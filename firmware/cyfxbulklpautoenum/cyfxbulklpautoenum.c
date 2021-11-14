/*
 ## Cypress USB 3.0 Platform source file (cyfxbulklpautoenum.c)
 ## ===========================
 ##
 ##  Copyright Cypress Semiconductor Corporation, 2010-2011,
 ##  All Rights Reserved
 ##  UNPUBLISHED, LICENSED SOFTWARE.
 ##
 ##  CONFIDENTIAL AND PROPRIETARY INFORMATION
 ##  WHICH IS THE PROPERTY OF CYPRESS.
 ##
 ##  Use of this file is governed
 ##  by the license agreement included in the file
 ##
 ##     <install>/license/license.txt
 ##
 ##  where <install> is the Cypress software
 ##  installation root directory path.
 ##
 ## ===========================
*/

/* This file illustrates the bulkloop application example using the DMA AUTO mode */

/*
   This example illustrates a loopback mechanism between two USB bulk endpoints. The example comprises of
   vendor class USB enumeration descriptors with 2 bulk endpoints. A bulk OUT endpoint acts as the producer
   of data from the host. A bulk IN endpint acts as the consumer of data to the host.

   The loopback is achieved with the help of a DMA AUTO channel. DMA AUTO channel is created between the
   producer USB bulk endpoint and the consumer USB bulk endpoint. Data is transferred from the host into
   the producer endpoint which is then directly transferred to the consumer endpoint by the DMA engine.
   CPU is not involved in the data transfer.

   The DMA buffer size is defined based on the USB speed. 64 for full speed, 512 for high speed and 1024
   for super speed. CY_FX_BULKLP_DMA_BUF_COUNT in the header file defines the number of DMA buffers.
 */

#include "cyu3system.h"
#include "cyu3os.h"
#include "cyu3dma.h"
#include "cyu3error.h"
#include "cyfxbulklpautoenum.h"
#include "cyu3usb.h"
#include "cyu3uart.h"

CyU3PThread     BulkLpAppThread;	/* Bulk loop application thread structure */
CyU3PDmaChannel glChHandleBulkLp;       /* DMA Channel handle */

uint8_t glEp0Buffer[32] __attribute__ ((aligned (32))); /* Buffer used for sending EP0 data.    */
uint8_t glUsbDeviceStat = 0;            /* USB device status. Bus powered.      */
uint8_t glUsbConfiguration = 0;         /* Active USB configuration.            */
uint8_t glUsbInterface = 0;             /* Active USB interface.                */
uint8_t *glSelBuffer = 0;               /* Buffer to hold SEL values.           */

CyBool_t glIsApplnActive = CyFalse;     /* Whether the loopback application is active or not. */
CyBool_t glResetDevice = CyFalse;       /* Request to reset the FX3 device. */

/* Application Error Handler */
void
CyFxAppErrorHandler (
        CyU3PReturnStatus_t apiRetStatus    /* API return status */
        )
{
    /* Application failed with the error code apiRetStatus */

    /* Add custom debug or recovery actions here */

    /* Loop Indefinitely */
    for (;;)
    {
        /* Thread sleep : 100 ms */
        CyU3PThreadSleep (100);
    }
}

/* This function initializes the debug module. The debug prints
 * are routed to the UART and can be seen using a UART console
 * running at 115200 baud rate. */
void
CyFxBulkLpApplnDebugInit (void)
{
    CyU3PUartConfig_t uartConfig;
    CyU3PReturnStatus_t apiRetStatus = CY_U3P_SUCCESS;

    /* Initialize the UART for printing debug messages */
    apiRetStatus = CyU3PUartInit();
    if (apiRetStatus != CY_U3P_SUCCESS)
    {
        /* Error handling */
        CyFxAppErrorHandler(apiRetStatus);
    }

    /* Set UART configuration */
    CyU3PMemSet ((uint8_t *)&uartConfig, 0, sizeof (uartConfig));
    uartConfig.baudRate = CY_U3P_UART_BAUDRATE_115200;
    uartConfig.stopBit = CY_U3P_UART_ONE_STOP_BIT;
    uartConfig.parity = CY_U3P_UART_NO_PARITY;
    uartConfig.txEnable = CyTrue;
    uartConfig.rxEnable = CyFalse;
    uartConfig.flowCtrl = CyFalse;
    uartConfig.isDma = CyTrue;

    apiRetStatus = CyU3PUartSetConfig (&uartConfig, NULL);
    if (apiRetStatus != CY_U3P_SUCCESS)
    {
        CyFxAppErrorHandler(apiRetStatus);
    }

    /* Set the UART transfer to a really large value. */
    apiRetStatus = CyU3PUartTxSetBlockXfer (0xFFFFFFFF);
    if (apiRetStatus != CY_U3P_SUCCESS)
    {
        CyFxAppErrorHandler(apiRetStatus);
    }

    /* Initialize the debug module. */
    apiRetStatus = CyU3PDebugInit (CY_U3P_LPP_SOCKET_UART_CONS, 8);
    if (apiRetStatus != CY_U3P_SUCCESS)
    {
        CyFxAppErrorHandler(apiRetStatus);
    }

    CyU3PDebugPreamble (CyFalse);

}

/* This function starts the bulk loop application. This is called
 * when a SET_CONF event is received from the USB host. The endpoints
 * are configured and the DMA pipe is setup in this function. */
void
CyFxBulkLpApplnStart (
        void)
{
    uint16_t size = 0;
    CyU3PEpConfig_t epCfg;
    CyU3PDmaChannelConfig_t dmaCfg;
    CyU3PReturnStatus_t apiRetStatus = CY_U3P_SUCCESS;
    CyU3PUSBSpeed_t usbSpeed = CyU3PUsbGetSpeed();

    /* First identify the usb speed. Once that is identified,
     * create a DMA channel and start the transfer on this. */

    /* Based on the Bus Speed configure the endpoint packet size */
    switch (usbSpeed)
    {
        case CY_U3P_FULL_SPEED:
            size = 64;
            break;

        case CY_U3P_HIGH_SPEED:
            size = 512;
            break;

        case  CY_U3P_SUPER_SPEED:
            size = 1024;
            break;

        default:
            CyU3PDebugPrint (4, "Error! Invalid USB speed.\n");
            CyFxAppErrorHandler (CY_U3P_ERROR_FAILURE);
            break;
    }

    CyU3PMemSet ((uint8_t *)&epCfg, 0, sizeof (epCfg));
    epCfg.enable = CyTrue;
    epCfg.epType = CY_U3P_USB_EP_BULK;
    epCfg.burstLen = 1;
    epCfg.streams = 0;
    epCfg.pcktSize = size;

    /* Producer endpoint configuration */
    apiRetStatus = CyU3PSetEpConfig(CY_FX_EP_PRODUCER, &epCfg);
    if (apiRetStatus != CY_U3P_SUCCESS)
    {
        CyU3PDebugPrint (4, "CyU3PSetEpConfig failed, Error code = %d\n", apiRetStatus);
        CyFxAppErrorHandler (apiRetStatus);
    }

    /* Consumer endpoint configuration */
    apiRetStatus = CyU3PSetEpConfig(CY_FX_EP_CONSUMER, &epCfg);
    if (apiRetStatus != CY_U3P_SUCCESS)
    {
        CyU3PDebugPrint (4, "CyU3PSetEpConfig failed, Error code = %d\n", apiRetStatus);
        CyFxAppErrorHandler (apiRetStatus);
    }

    /* Create a DMA Auto Channel between two sockets of the U port.
     * DMA size is set based on the USB speed. */
    dmaCfg.size = size;
    dmaCfg.count = CY_FX_BULKLP_DMA_BUF_COUNT;
    dmaCfg.prodSckId = CY_FX_EP_PRODUCER_SOCKET;
    dmaCfg.consSckId = CY_FX_EP_CONSUMER_SOCKET;
    dmaCfg.dmaMode = CY_U3P_DMA_MODE_BYTE;
    dmaCfg.notification = 0;
    dmaCfg.cb = NULL;
    dmaCfg.prodHeader = 0;
    dmaCfg.prodFooter = 0;
    dmaCfg.consHeader = 0;
    dmaCfg.prodAvailCount = 0;

    apiRetStatus = CyU3PDmaChannelCreate (&glChHandleBulkLp,
            CY_U3P_DMA_TYPE_AUTO, &dmaCfg);
    if (apiRetStatus != CY_U3P_SUCCESS)
    {
        CyU3PDebugPrint (4, "CyU3PDmaChannelCreate failed, Error code = %d\n", apiRetStatus);
        CyFxAppErrorHandler(apiRetStatus);
    }

    /* Flush the Endpoint memory */
    CyU3PUsbFlushEp(CY_FX_EP_PRODUCER);
    CyU3PUsbFlushEp(CY_FX_EP_CONSUMER);

    /* Set DMA Channel transfer size */
    apiRetStatus = CyU3PDmaChannelSetXfer (&glChHandleBulkLp, CY_FX_BULKLP_DMA_TX_SIZE);
    if (apiRetStatus != CY_U3P_SUCCESS)
    {
        CyU3PDebugPrint (4, "CyU3PDmaChannelSetXfer Failed, Error code = %d\n", apiRetStatus);
        CyFxAppErrorHandler(apiRetStatus);
    }

    /* Update the status flag. */
    glIsApplnActive = CyTrue;

    /* Drop current U1/U2 enable state values. */
    glUsbDeviceStat = 0;
}

/* This function stops the bulk loop application. This shall be called whenever
 * a RESET or DISCONNECT event is received from the USB host. The endpoints are
 * disabled and the DMA pipe is destroyed by this function. */
void
CyFxBulkLpApplnStop (
        void)
{
    CyU3PEpConfig_t epCfg;
    CyU3PReturnStatus_t apiRetStatus = CY_U3P_SUCCESS;

    /* Update the flag. */
    glIsApplnActive = CyFalse;

    /* Flush the endpoint memory */
    CyU3PUsbFlushEp(CY_FX_EP_PRODUCER);
    CyU3PUsbFlushEp(CY_FX_EP_CONSUMER);

    /* Destroy the channel */
    CyU3PDmaChannelDestroy (&glChHandleBulkLp);

    /* Disable endpoints. */
    CyU3PMemSet ((uint8_t *)&epCfg, 0, sizeof (epCfg));
    epCfg.enable = CyFalse;

    /* Producer endpoint configuration. */
    apiRetStatus = CyU3PSetEpConfig(CY_FX_EP_PRODUCER, &epCfg);
    if (apiRetStatus != CY_U3P_SUCCESS)
    {
        CyU3PDebugPrint (4, "CyU3PSetEpConfig failed, Error code = %d\n", apiRetStatus);
        CyFxAppErrorHandler (apiRetStatus);
    }

    /* Consumer endpoint configuration. */
    apiRetStatus = CyU3PSetEpConfig(CY_FX_EP_CONSUMER, &epCfg);
    if (apiRetStatus != CY_U3P_SUCCESS)
    {
        CyU3PDebugPrint (4, "CyU3PSetEpConfig failed, Error code = %d\n", apiRetStatus);
        CyFxAppErrorHandler (apiRetStatus);
    }
}

/* Handle the CLEAR_FEATURE request. */
CyBool_t
CyFxUsbHandleClearFeature (
        uint8_t bTarget,
        uint16_t wValue,
        uint16_t wIndex)
{
    CyU3PUSBSpeed_t usbSpeed = CyU3PUsbGetSpeed();
    CyBool_t isHandled = CyFalse;

    if (bTarget == CY_U3P_USB_TARGET_DEVICE)
    {
        switch (wValue & 0xFF)
        {
            case CY_U3P_USB2_FS_REMOTE_WAKE:
                glUsbDeviceStat &= 0xFD;
                /* Fall-through here. */
            case CY_U3P_USB2_FS_TEST_MODE:
                if (usbSpeed != CY_U3P_SUPER_SPEED)
                {
                    isHandled = CyTrue;
                }
                break;

            case CY_U3P_USB3_FS_U1_ENABLE:
                if ((usbSpeed == CY_U3P_SUPER_SPEED) && (glIsApplnActive))
                {
                    glUsbDeviceStat &= 0xFB;
                    isHandled = CyTrue;
                }
                break;

            case CY_U3P_USB3_FS_U2_ENABLE:
                if ((usbSpeed == CY_U3P_SUPER_SPEED) && (glIsApplnActive))
                {
                    glUsbDeviceStat &= 0xF7;
                    isHandled = CyTrue;
                }
                break;

            default:
                isHandled = CyFalse;
                break;
        }
    }
    else if (bTarget == CY_U3P_USB_TARGET_INTF)
    {
        /* Need to handle CLEAR_FEATURE(FUNCTION_SUSPEND) requests. We allow this request to pass
           if the USB device is in configured state and fail it otherwise.  */
        if ((glIsApplnActive) && (wValue == 0))
            CyU3PUsbAckSetup ();
        else
            CyU3PUsbStall (0, CyTrue, CyFalse);

        isHandled = CyTrue;
    }
    else if ((bTarget == CY_U3P_USB_TARGET_ENDPT) && (wValue == CY_U3P_USBX_FS_EP_HALT))
    {
        /* If the application is active make sure that all sockets and
         * DMA buffers are flushed and cleaned. If more than one enpoint
         * is linked to the same DMA channel, then reset all the affected
         * endpoint pipes. */
        if (glIsApplnActive)
        {
            CyU3PDmaChannelReset (&glChHandleBulkLp);
            CyU3PUsbFlushEp(CY_FX_EP_PRODUCER);
            CyU3PUsbFlushEp(CY_FX_EP_CONSUMER);
            CyU3PUsbResetEp (CY_FX_EP_PRODUCER);
            CyU3PUsbResetEp (CY_FX_EP_CONSUMER);
            CyU3PDmaChannelSetXfer (&glChHandleBulkLp, CY_FX_BULKLP_DMA_TX_SIZE);
        }
 
        /* Clear stall on the endpoint. */
        CyU3PUsbStall (wIndex, CyFalse, CyTrue);
        CyU3PUsbAckSetup ();
        isHandled = CyTrue;
    }
    else
    {
        isHandled = CyFalse;
    }

    return isHandled;
}
/* Handle the SET_FEATURE request. */
CyBool_t
CyFxUsbHandleSetFeature (
        uint8_t bTarget,
        uint16_t wValue,
        uint16_t wIndex)
{
    CyU3PUSBSpeed_t usbSpeed = CyU3PUsbGetSpeed();
    CyBool_t isHandled = CyFalse;

    if (bTarget == CY_U3P_USB_TARGET_DEVICE)
    {
        switch (wValue & 0xFF)
        {
            case CY_U3P_USB2_FS_REMOTE_WAKE:
                glUsbDeviceStat |= 0x02;
                /* Fall-through here. */
            case CY_U3P_USB2_FS_TEST_MODE:
                if (usbSpeed != CY_U3P_SUPER_SPEED)
                {
                    isHandled = CyTrue;
                }
                break;

            case CY_U3P_USB3_FS_U1_ENABLE:
                if ((usbSpeed == CY_U3P_SUPER_SPEED) && (glIsApplnActive))
                {
                    glUsbDeviceStat |= 0x04;
                    isHandled = CyTrue;
                }
                break;

            case CY_U3P_USB3_FS_U2_ENABLE:
                if ((usbSpeed == CY_U3P_SUPER_SPEED) && (glIsApplnActive))
                {
                    glUsbDeviceStat |= 0x08;
                    isHandled = CyTrue;
                }
                break;

            default:
                isHandled = CyFalse;
                break;
        }
    }
    else if (bTarget == CY_U3P_USB_TARGET_INTF)
    {
        /* Need to handle SET_FEATURE(FUNCTION_SUSPEND) requests. We allow this request to pass
           if the USB device is in configured state and fail it otherwise.  */
        if ((glIsApplnActive) && (wValue == 0))
            CyU3PUsbAckSetup ();
        else
            CyU3PUsbStall (0, CyTrue, CyFalse);

        isHandled = CyTrue;
    }
    else if ((bTarget == CY_U3P_USB_TARGET_ENDPT) && (wValue == CY_U3P_USBX_FS_EP_HALT))
    {
        /* Stall the endpoint */
        CyU3PUsbStall (wIndex, CyTrue, CyFalse);
        CyU3PUsbAckSetup ();
        isHandled = CyTrue;
    }
    else
    {
        isHandled = CyFalse;
    }

    return isHandled;
}

/* Send the requested USB descriptor to the host. */
CyU3PReturnStatus_t
CyFxUsbSendDescriptor (uint16_t wValue, uint16_t wIndex, uint16_t wLength)
{
    uint16_t length = 0, index = 0;
    uint8_t *buffer = NULL;
    CyU3PReturnStatus_t status = CY_U3P_SUCCESS;
    CyU3PUSBSpeed_t usbSpeed = CyU3PUsbGetSpeed ();

    /* The descriptor type is in the MS byte and the index is in
     * the LS byte. The index is useful only for string descriptor. */
    switch (wValue >> 8)
    {
        case CY_U3P_USB_DEVICE_DESCR:
            if (usbSpeed == CY_U3P_SUPER_SPEED)
            {
                buffer = (uint8_t *)CyFxUSB30DeviceDscr;
            }
            else
            {
                buffer = (uint8_t *)CyFxUSB20DeviceDscr;
            }
            length = buffer[0];
            break;

        case CY_U3P_BOS_DESCR:
            buffer = (uint8_t *)CyFxUSBBOSDscr;
            length = (buffer[2] | ((uint16_t)buffer[3] << 8));
            break;

        case CY_U3P_USB_DEVQUAL_DESCR:
            buffer = (uint8_t *)CyFxUSBDeviceQualDscr;
            length = buffer[0];
            break;

        case CY_U3P_USB_CONFIG_DESCR:
            if (usbSpeed == CY_U3P_SUPER_SPEED)
            {
                buffer = (uint8_t *)CyFxUSBSSConfigDscr;
            }
            else if (usbSpeed == CY_U3P_HIGH_SPEED)
            {
                buffer = (uint8_t *)CyFxUSBHSConfigDscr;
            }
            else /* CY_U3P_FULL_SPEED */
            {
                buffer = (uint8_t *)CyFxUSBFSConfigDscr;
            }
            buffer[1] = CY_U3P_USB_CONFIG_DESCR;                /* Mark as configuration descriptor. */
            length    = (buffer[2] | ((uint16_t)buffer[3] << 8));
            break;

        case CY_U3P_USB_OTHERSPEED_DESCR:
            if (usbSpeed == CY_U3P_HIGH_SPEED)
            {
                buffer = (uint8_t *)CyFxUSBFSConfigDscr;
            }
            else if (usbSpeed == CY_U3P_FULL_SPEED)
            {
                buffer = (uint8_t *)CyFxUSBHSConfigDscr;
            }
            else
            {
                /* Do nothing. buffer = NULL. */
            }

            if (buffer != NULL)
            {
                buffer[1] = CY_U3P_USB_OTHERSPEED_DESCR;        /* Mark as other speed configuration descriptor. */
                length    = (buffer[2] | ((uint16_t)buffer[3] << 8));
            }
            break;

        case CY_U3P_USB_STRING_DESCR:
            index = wValue & 0xFF;
            switch (index)
            {
                case 0:
                    buffer = (uint8_t *)CyFxUSBStringLangIDDscr;
                    break;

                case 1:
                    buffer = (uint8_t *)CyFxUSBManufactureDscr;
                    break;

                case 2:
                    buffer = (uint8_t *)CyFxUSBProductDscr;
                    break;

                default:
                    /* Do nothing. buffer = NULL. */
                    break;
            }
            length = buffer[0];
            break;

        default:
            /* Do nothing. buffer = NULL. */
            break;
    }

    if (buffer != NULL)
    {
        /* Send only the minimum of actual descriptor length
         * and the requested length. */
        length = (wLength < length) ? wLength : length;
        status = CyU3PUsbSendEP0Data (length, buffer);
    }
    else
    {
        status = CY_U3P_ERROR_FAILURE;
    }

    return status;
}

/* Callback to handle the USB setup requests. */
CyBool_t
CyFxBulkLpApplnUSBSetupCB (
        uint32_t setupdat0, /* SETUP Data 0 */
        uint32_t setupdat1  /* SETUP Data 1 */
    )
{
    CyBool_t isHandled = CyTrue;
    CyU3PReturnStatus_t status = CY_U3P_SUCCESS;

    uint8_t  bRequest, bReqType;
    uint8_t  bType, bTarget;
    uint16_t wValue, wIndex, wLength;

    /* Decode the fields from the setup request. */
    bReqType = (setupdat0 & CY_U3P_USB_REQUEST_TYPE_MASK);
    bType    = (bReqType & CY_U3P_USB_TYPE_MASK);
    bTarget  = (bReqType & CY_U3P_USB_TARGET_MASK);
    bRequest = ((setupdat0 & CY_U3P_USB_REQUEST_MASK) >> CY_U3P_USB_REQUEST_POS);
    wValue   = ((setupdat0 & CY_U3P_USB_VALUE_MASK)   >> CY_U3P_USB_VALUE_POS);
    wIndex   = ((setupdat1 & CY_U3P_USB_INDEX_MASK)   >> CY_U3P_USB_INDEX_POS);
    wLength  = ((setupdat1 & CY_U3P_USB_LENGTH_MASK)  >> CY_U3P_USB_LENGTH_POS);

    /* The only supported vendor command is to reset the FX3 device. */
    if (bType == CY_U3P_USB_VENDOR_RQT)
    {
        if ((bRequest == 0xE0) && (wLength == 0))
        {
            glResetDevice = CyTrue;
            CyU3PUsbAckSetup ();
            return CyTrue;
        }

        return CyFalse;
    }

    /* Identify and handle setup request. */
    switch (bRequest)
    {
        /* This is a get status request. The response depends on the target.
         * If this is for the device, then we need to return the status
         * of the device. If this is for the endpoint, then return the stall
         * status of the endpoint. */
        case CY_U3P_USB_SC_GET_STATUS:
            CyU3PMemSet (glEp0Buffer, 0, sizeof(glEp0Buffer));
            if (bTarget == CY_U3P_USB_TARGET_DEVICE)
            {
                glEp0Buffer[0] = glUsbDeviceStat;
                status = CyU3PUsbSendEP0Data (wLength, glEp0Buffer);
            }
            else if (bTarget == CY_U3P_USB_TARGET_INTF)
            {
                /* Just send zeros. */
                status = CyU3PUsbSendEP0Data (wLength, glEp0Buffer);
            }
            else if (bTarget == CY_U3P_USB_TARGET_ENDPT)
            {
                CyBool_t isStall;
                status = CyU3PUsbGetEpCfg (wIndex, NULL, &isStall);
                if (status == CY_U3P_SUCCESS)
                {
                    glEp0Buffer[0] = isStall;
                    status = CyU3PUsbSendEP0Data (wLength, glEp0Buffer);
                }
            }
            else
            {
                isHandled = CyFalse;
            }
            break;

        /* This feature behaves differently depending upon the target.
         * If the target is device then, this request is for remote-wakeup,
         * test mode, U1_ENABLE and U2_ENABLE. If this is for the endpoint
         * then this is for clearing the endpoint stall. */
        case CY_U3P_USB_SC_CLEAR_FEATURE:
            isHandled = CyFxUsbHandleClearFeature (bTarget, wValue, wIndex);
            break;

        /* This feature behaves differently depending upon the target.
         * If the target is device then, this request is for remote-wakeup,
         * test mode, U1_ENABLE and U2_ENABLE. If this is for the endpoint
         * then this is for clearing the endpoint stall. */
        case CY_U3P_USB_SC_SET_FEATURE:
            isHandled = CyFxUsbHandleSetFeature (bTarget, wValue, wIndex);
            break;

        /* Return the requested descriptor. */
        case CY_U3P_USB_SC_GET_DESCRIPTOR:
            status = CyFxUsbSendDescriptor (wValue, wIndex, wLength);
            break;

        case CY_U3P_USB_SC_SET_DESCRIPTOR:
            /* ACK the request and do nothing. */
            break;

        /* Return the current selected configuration. */
        case CY_U3P_USB_SC_GET_CONFIGURATION:
            glEp0Buffer[0] = glUsbConfiguration;
            status = CyU3PUsbSendEP0Data (wLength, glEp0Buffer);
            break;

        /* Store the value for future use and start the application. */
        case CY_U3P_USB_SC_SET_CONFIGURATION:
            if (wValue == 1)
            {
                /* If the application is already active, then disable
                 * it before re-enabling it. */
                glUsbConfiguration = wValue;
                if (glIsApplnActive)
                {
                    CyFxBulkLpApplnStop ();
                }
                /* Start the loop back function. */
                CyFxBulkLpApplnStart ();
            }
            else
            {
            	if (wValue == 0)
            	{
                    /* Stop the loop back function. */
                    glUsbConfiguration = wValue;
                    if (glIsApplnActive)
                    {
                        CyFxBulkLpApplnStop ();
                    }
            	}
            	else
            	{
            		/* Invalid configuration value. Fail the request. */
            		CyU3PUsbStall (0, CyTrue, CyFalse);
            	}
            }
            break;

        /* Return the current selected interface. */
        case CY_U3P_USB_SC_GET_INTERFACE:
            glEp0Buffer[0] = glUsbInterface;
            status = CyU3PUsbSendEP0Data (wLength, glEp0Buffer);
            break;

        /* Store the selected interface value. */
        case CY_U3P_USB_SC_SET_INTERFACE:
            glUsbInterface = wValue;
            break;

        case CY_U3P_USB_SC_SET_SEL:
            {
                if ((CyU3PUsbGetSpeed () == CY_U3P_SUPER_SPEED) && (wValue == 0) && (wIndex == 0) && (wLength == 6))
                {
                    status = CyU3PUsbGetEP0Data (32, glSelBuffer, 0);
                }
                else
                {
                    isHandled = CyFalse;
                }
            }
            break;

        case CY_U3P_USB_SC_SET_ISOC_DELAY:
            {
                if ((CyU3PUsbGetSpeed () != CY_U3P_SUPER_SPEED) || (wIndex != 0) || (wLength != 0))
                    isHandled = CyFalse;
            }
            break;
        
        default:
            isHandled = CyFalse;
            break;
    }

    /* If there has been an error, stall EP0 to fail the transaction. */
    if ((isHandled != CyTrue) || (status != CY_U3P_SUCCESS))
    {
        /* This is an unhandled setup command. Stall the EP. */
        CyU3PUsbStall (0, CyTrue, CyFalse);
    }
    else
    {
        CyU3PUsbAckSetup ();
    }

    return CyTrue;
}

/* This is the callback function to handle the USB events. */
void
CyFxBulkLpApplnUSBEventCB (
    CyU3PUsbEventType_t evtype, /* Event type */
    uint16_t            evdata  /* Event data */
    )
{
    switch (evtype)
    {
        case CY_U3P_USB_EVENT_RESET:
        case CY_U3P_USB_EVENT_DISCONNECT:
            /* Stop the loop back function. */
            CyFxBulkLpApplnStop ();
            /* Drop current U1/U2 enable state values. */
            glUsbDeviceStat = 0;
            break;

        default:
            break;
    }
}

/* Callback function to handle LPM requests from the USB 3.0 host. This function is invoked by the API
   whenever a state change from U0 -> U1 or U0 -> U2 happens. If we return CyTrue from this function, the
   FX3 device is retained in the low power state. If we return CyFalse, the FX3 device immediately tries
   to trigger an exit back to U0.

   This application does not have any state in which we should not allow U1/U2 transitions; and therefore
   the function always return CyTrue.
 */
CyBool_t
CyFxBulkLpApplnLPMRqtCB (
        CyU3PUsbLinkPowerMode link_mode)
{
    return CyTrue;
}

/* This function initializes the USB Module, sets the enumeration descriptors.
 * This function does not start the bulk streaming and this is done only when
 * SET_CONF event is received. */
void
CyFxBulkLpApplnInit (void)
{
    CyU3PReturnStatus_t apiRetStatus = CY_U3P_SUCCESS;

    /* Start the USB functionality. */
    apiRetStatus = CyU3PUsbStart();
    if (apiRetStatus != CY_U3P_SUCCESS)
    {
        CyU3PDebugPrint (4, "CyU3PUsbStart failed to Start, Error code = %d\n", apiRetStatus);
        CyFxAppErrorHandler(apiRetStatus);
    }

    /* Allocate a buffer to hold the SEL (System Exit Latency) values set by the host. */
    glSelBuffer = (uint8_t *)CyU3PDmaBufferAlloc (32);
    CyU3PMemSet (glSelBuffer, 0, 32);

    /* In this example the application handles all the setup packets.
     * But even in normal mode of enumeration, it is possible to register
     * DMA descriptors with the library and not handle inside the setup
     * callback. */
    CyU3PUsbRegisterSetupCallback(CyFxBulkLpApplnUSBSetupCB, CyFalse);

    /* Setup the callback to handle the USB events. */
    CyU3PUsbRegisterEventCallback(CyFxBulkLpApplnUSBEventCB);

    /* Register a callback to handle LPM requests from the USB 3.0 host. */
    CyU3PUsbRegisterLPMRequestCallback(CyFxBulkLpApplnLPMRqtCB);

    /* Connect the USB Pins with super speed operation enabled. */
    apiRetStatus = CyU3PConnectState(CyTrue, CyTrue);
    if (apiRetStatus != CY_U3P_SUCCESS)
    {
        CyU3PDebugPrint (4, "USB Connect failed, Error code = %d\n", apiRetStatus);
        CyFxAppErrorHandler(apiRetStatus);
    }
}

/* Entry function for the BulkLpAppThread. */
void
BulkLpAppThread_Entry (
        uint32_t input)
{
    /* Initialize the debug module */
    CyFxBulkLpApplnDebugInit();

    /* Initialize the bulk loop application */
    CyFxBulkLpApplnInit();

    for (;;)
    {
        CyU3PThreadSleep (1000);

        if (glResetDevice)
        {
            /* Disconnect from the USB host and reset the device. */
            glResetDevice = CyFalse;
            CyU3PThreadSleep (1000);
            CyU3PConnectState (CyFalse, CyTrue);
            CyU3PThreadSleep (1000);
            CyU3PDeviceReset (CyFalse);
            for (;;);
        }
    }
}

/* Application define function which creates the threads. */
void
CyFxApplicationDefine (
        void)
{
    void *ptr = NULL;
    uint32_t retThrdCreate = CY_U3P_SUCCESS;

    /* Allocate the memory for the threads */
    ptr = CyU3PMemAlloc (CY_FX_BULKLP_THREAD_STACK);

    /* Create the thread for the application */
    retThrdCreate = CyU3PThreadCreate (&BulkLpAppThread,           /* Bulk loop App Thread structure */
                          "21:Bulk_loop_AUTO",                     /* Thread ID and Thread name */
                          BulkLpAppThread_Entry,                   /* Bulk loop App Thread Entry function */
                          0,                                       /* No input parameter to thread */
                          ptr,                                     /* Pointer to the allocated thread stack */
                          CY_FX_BULKLP_THREAD_STACK,               /* Bulk loop App Thread stack size */
                          CY_FX_BULKLP_THREAD_PRIORITY,            /* Bulk loop App Thread priority */
                          CY_FX_BULKLP_THREAD_PRIORITY,            /* Bulk loop App Thread priority */
                          CYU3P_NO_TIME_SLICE,                     /* No time slice for the application thread */
                          CYU3P_AUTO_START                         /* Start the Thread immediately */
                          );

    /* Check the return code */
    if (retThrdCreate != 0)
    {
        /* Thread Creation failed with the error code retThrdCreate */

        /* Add custom recovery or debug actions here */

        /* Application cannot continue */
        /* Loop indefinitely */
        while(1);
    }
}

/*
 * Main function
 */
int
main (void)
{
    CyU3PIoMatrixConfig_t io_cfg;
    CyU3PReturnStatus_t status = CY_U3P_SUCCESS;

    /* Initialize the device */
    status = CyU3PDeviceInit (NULL);
    if (status != CY_U3P_SUCCESS)
    {
        goto handle_fatal_error;
    }

    /* Initialize the caches. Enable both Instruction and Data caches. */
    status = CyU3PDeviceCacheControl (CyTrue, CyTrue, CyTrue);
    if (status != CY_U3P_SUCCESS)
    {
        goto handle_fatal_error;
    }

    /* Configure the IO matrix for the device. On the FX3 DVK board, the COM port 
     * is connected to the IO(53:56). This means that either DQ32 mode should be
     * selected or lppMode should be set to UART_ONLY. Here we are choosing
     * UART_ONLY configuration. */
    io_cfg.isDQ32Bit = CyFalse;
    io_cfg.s0Mode = CY_U3P_SPORT_INACTIVE;
    io_cfg.s1Mode = CY_U3P_SPORT_INACTIVE;
    io_cfg.useUart   = CyTrue;
    io_cfg.useI2C    = CyFalse;
    io_cfg.useI2S    = CyFalse;
    io_cfg.useSpi    = CyFalse;
    io_cfg.lppMode   = CY_U3P_IO_MATRIX_LPP_UART_ONLY;
    /* No GPIOs are enabled. */
    io_cfg.gpioSimpleEn[0]  = 0;
    io_cfg.gpioSimpleEn[1]  = 0;
    io_cfg.gpioComplexEn[0] = 0;
    io_cfg.gpioComplexEn[1] = 0;
    status = CyU3PDeviceConfigureIOMatrix (&io_cfg);
    if (status != CY_U3P_SUCCESS)
    {
        goto handle_fatal_error;
    }

    /* This is a non returnable call for initializing the RTOS kernel */
    CyU3PKernelEntry ();

    /* Dummy return to make the compiler happy */
    return 0;

handle_fatal_error:

    /* Cannot recover from this error. */
    while (1);
}

/* [ ] */

