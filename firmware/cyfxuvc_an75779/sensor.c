/*
 ## Cypress FX3 Camera Kit source file (sensor.c)
 ## ===========================
 ##
 ##  Copyright Cypress Semiconductor Corporation, 2010-2012,
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

/* This file implements the I2C based driver for the MT9M114 image sensor used
   in the FX3 HD 720p camera kit.

   Please refer to the Aptina MT9M114 sensor datasheet for the details of the
   I2C commands used to configure the sensor.
 */

#include <cyu3system.h>
#include <cyu3os.h>
#include <cyu3dma.h>
#include <cyu3error.h>
#include <cyu3uart.h>
#include <cyu3i2c.h>
#include <cyu3types.h>
#include <cyu3gpio.h>
#include <cyu3utils.h>
#include "sensor.h"

static void Step1_Post_Reset (void);
static void Step2_PLL_Timing (void);
static void Step3_Recommended (void);
static void Step4_APGA (void);
static void Step5_AWB_CCM (void);
static void Step7_PIPE_Preference (void);
static void Step8_Features (void);

/* This function inserts a delay between successful I2C transfers to prevent
   false errors due to the slave being busy.
 */
static void
SensorI2CAccessDelay (
        CyU3PReturnStatus_t status)
{
    /* Add a 10us delay if the I2C operation that preceded this call was successful. */
    if (status == CY_U3P_SUCCESS)
        CyU3PBusyWait (10);
}

/* Write to an I2C slave with two bytes of data. */
CyU3PReturnStatus_t
SensorWrite2B (
        uint8_t slaveAddr,
        uint8_t highAddr,
        uint8_t lowAddr,
        uint8_t highData,
        uint8_t lowData)
{
    CyU3PReturnStatus_t apiRetStatus = CY_U3P_SUCCESS;
    CyU3PI2cPreamble_t  preamble;
    uint8_t buf[2];

    /* Validate the I2C slave address. */
    if ((slaveAddr != SENSOR_ADDR_WR) && (slaveAddr != I2C_MEMORY_ADDR_WR))
    {
        CyU3PDebugPrint (4, "I2C Slave address is not valid!\n");
        return 1;
    }

    /* Set the parameters for the I2C API access and then call the write API. */
    preamble.buffer[0] = slaveAddr;
    preamble.buffer[1] = highAddr;
    preamble.buffer[2] = lowAddr;
    preamble.length    = 3;             /*  Three byte preamble. */
    preamble.ctrlMask  = 0x0000;        /*  No additional start and stop bits. */

    buf[0] = highData;
    buf[1] = lowData;

    apiRetStatus = CyU3PI2cTransmitBytes (&preamble, buf, 2, 0);
    SensorI2CAccessDelay (apiRetStatus);

    return apiRetStatus;
}

CyU3PReturnStatus_t
SensorWrite (
        uint8_t slaveAddr,
        uint8_t highAddr,
        uint8_t lowAddr,
        uint8_t count,
        uint8_t *buf)
{
    CyU3PReturnStatus_t apiRetStatus = CY_U3P_SUCCESS;
    CyU3PI2cPreamble_t preamble;

    /* Validate the I2C slave address. */
    if ((slaveAddr != SENSOR_ADDR_WR) && (slaveAddr != I2C_MEMORY_ADDR_WR))
    {
        CyU3PDebugPrint (4, "I2C Slave address is not valid!\n");
        return 1;
    }

    if (count > 64)
    {
        CyU3PDebugPrint (4, "ERROR: SensorWrite count > 64\n");
        return 1;
    }

    /* Set up the I2C control parameters and invoke the write API. */
    preamble.buffer[0] = slaveAddr;
    preamble.buffer[1] = highAddr;
    preamble.buffer[2] = lowAddr;
    preamble.length    = 3;
    preamble.ctrlMask  = 0x0000;

    apiRetStatus = CyU3PI2cTransmitBytes (&preamble, buf, count, 0);
    SensorI2CAccessDelay (apiRetStatus);

    return apiRetStatus;
}

CyU3PReturnStatus_t
SensorRead2B (
        uint8_t slaveAddr,
        uint8_t highAddr,
        uint8_t lowAddr,
        uint8_t *buf)
{
    CyU3PReturnStatus_t apiRetStatus = CY_U3P_SUCCESS;
    CyU3PI2cPreamble_t preamble;

    if ((slaveAddr != SENSOR_ADDR_RD) && (slaveAddr != I2C_MEMORY_ADDR_RD))
    {
        CyU3PDebugPrint (4, "I2C Slave address is not valid!\n");
        return 1;
    }

    preamble.buffer[0] = slaveAddr & I2C_SLAVEADDR_MASK;        /*  Mask out the transfer type bit. */
    preamble.buffer[1] = highAddr;
    preamble.buffer[2] = lowAddr;
    preamble.buffer[3] = slaveAddr;
    preamble.length    = 4;
    preamble.ctrlMask  = 0x0004;                                /*  Send start bit after third byte of preamble. */

    apiRetStatus = CyU3PI2cReceiveBytes (&preamble, buf, 2, 0);
    SensorI2CAccessDelay (apiRetStatus);

    return apiRetStatus;
}

CyU3PReturnStatus_t
SensorRead (
        uint8_t slaveAddr,
        uint8_t highAddr,
        uint8_t lowAddr,
        uint8_t count,
        uint8_t *buf)
{
    CyU3PReturnStatus_t apiRetStatus = CY_U3P_SUCCESS;
    CyU3PI2cPreamble_t preamble;

    /* Validate the parameters. */
    if ((slaveAddr != SENSOR_ADDR_RD) && (slaveAddr != I2C_MEMORY_ADDR_RD))
    {
        CyU3PDebugPrint (4, "I2C Slave address is not valid!\n");
        return 1;
    }
    if ( count > 64 )
    {
        CyU3PDebugPrint (4, "ERROR: SensorWrite count > 64\n");
        return 1;
    }

    preamble.buffer[0] = slaveAddr & I2C_SLAVEADDR_MASK;        /*  Mask out the transfer type bit. */
    preamble.buffer[1] = highAddr;
    preamble.buffer[2] = lowAddr;
    preamble.buffer[3] = slaveAddr;
    preamble.length    = 4;
    preamble.ctrlMask  = 0x0004;                                /*  Send start bit after third byte of preamble. */

    apiRetStatus = CyU3PI2cReceiveBytes (&preamble, buf, count, 0);
    SensorI2CAccessDelay (apiRetStatus);

    return apiRetStatus;
}

/*
 * Reset the MT9M114 sensor using GPIO.
 */
void
SensorReset (
        void)
{
    CyU3PReturnStatus_t apiRetStatus;

    /* Drive the GPIO low to reset the sensor. */
    apiRetStatus = CyU3PGpioSetValue (SENSOR_RESET_GPIO, CyFalse);
    if (apiRetStatus != CY_U3P_SUCCESS)
    {
        CyU3PDebugPrint (4, "GPIO Set Value Error, Error Code = %d\n", apiRetStatus);
        return;
    }

    /* Wait for some time to allow proper reset. */
    CyU3PThreadSleep (10);

    /* Drive the GPIO high to bring the sensor out of reset. */
    apiRetStatus = CyU3PGpioSetValue (SENSOR_RESET_GPIO, CyTrue);
    if (apiRetStatus != CY_U3P_SUCCESS)
    {
        CyU3PDebugPrint (4, "GPIO Set Value Error, Error Code = %d\n", apiRetStatus);
        return;
    }

    /* Delay the allow the sensor to power up. */
    CyU3PThreadSleep (10);
    return;
}

/*
 * As UVC driver only support YUY2 uncompressed video, select YUY2 video format on the sensor.
 */
static void
SensorSelectYUY2Format (
        void)
{
    uint8_t buf[2];

    SensorRead2B (SENSOR_ADDR_RD, 0xC8, 0x6C, buf);
    buf[1] |= (1 << 1);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x6C, buf[0], buf[1]);
}

/* MT9M114 sensor initialization sequence.
   Adapted from MT9M114-REV2.ini file provided by Aptina.

   Step1_Post_Reset       : Post-Reset Settings
   Step2_PLL_Timing       : PLL and Timing settings
   Step3_Recommended      : Patch, Errata and Sensor optimization Setting
   Step4_APGA             : APGA
   Step5_AWB_CCM          : AWB & CCM
   Step7_PIPE_Preference  : Color Pipe preference settings
   Step8_Features         : Ports, special features etc.
   Select Video Resolution
   SensorChangeConfig     : Update sensor configuration.
*/
void
SensorInit (
        void)
{
    if (SensorI2cBusTest () != CY_U3P_SUCCESS)        /* Verify that the sensor is connected. */
    {
        CyU3PDebugPrint (4, "Error: Reading Sensor ID failed!\r\n");
        return;
    }

    Step1_Post_Reset ();        /* Post-Reset Settings */
    Step2_PLL_Timing ();        /* PLL and Timing */
    Step3_Recommended ();       /* Patch, Errata and Sensor optimization Setting */
    Step4_APGA ();              /* APGA */
    Step5_AWB_CCM ();           /* AWB & CCM */
    Step7_PIPE_Preference ();   /* Color Pipe preference settings, if any */
    Step8_Features ();          /* Ports, special features, etc. */

    /* Update sensor configuration based on desired video stream parameters. Using 720p 30fps as default setting.*/
    SensorScaling_HD720p_30fps ();

    SensorSelectYUY2Format ();
    SensorChangeConfig ();
}

/*
 * Verify that the sensor can be accessed over the I2C bus from FX3.
 */
uint8_t
SensorI2cBusTest (
        void)
{
    /* The sensor ID register can be read here to verify sensor connectivity. */
    uint8_t buf[2];

    /* Reading sensor ID */
    if (SensorRead2B (SENSOR_ADDR_RD, 0x00, 0x00, buf) == CY_U3P_SUCCESS)
    {
        if ((buf[0] == 0x24) && (buf[1] == 0x81))
        {
            return CY_U3P_SUCCESS;
        }
    }
    return 1;
}

/* Post sensor reset settings. */
static void
Step1_Post_Reset (
        void)
{
    uint8_t buf[2];

    /* Poll the command register for ready status. */
    while (1)
    {
        if (SensorRead2B (SENSOR_ADDR_RD, 0x00, 0x80, buf) != CY_U3P_SUCCESS)
            CyU3PDebugPrint (4, "Error: Command register read failed\r\n");
        else
            if (!(buf[1] & 0x02))
                break;
    }

    /* Errata item 2 */
    SensorRead2B (SENSOR_ADDR_RD, 0x30, 0x1A, buf);
    buf[0] |= (1 << 2);
    SensorWrite2B (SENSOR_ADDR_WR, 0x30, 0x1A, buf[0], buf[1]);
}

/* Update sensor PLL and timing settings.
   The procedure is adapted from Aptina's sensor initialization scripts. Please
   refer to the MT9M114 sensor datasheet for details.
 */
static void
Step2_PLL_Timing (
        void)
{
    /* Default PLL_settings */
    SensorWrite2B (SENSOR_ADDR_WR, 0x09, 0x8E, 0, 0);   /* set XDMA to logical addressing */
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x7E, 0, 1);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x80, 0x02, 0x25);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x82, 0x07, 0);

    /* Timing settings */
    SensorWrite2B (SENSOR_ADDR_WR, 0x09, 0x8E, 0, 0);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x00, 0x00, 0x7C);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x02, 0x00, 0x04);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x04, 0x03, 0x53);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x06, 0x05, 0x0B);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x08, 0x02, 0x34);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x0A, 0x93, 0x40);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x0C, 0x00, 0x01);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x0E, 0x00, 0xDB);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x10, 0x05, 0xAD);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x12, 0x02, 0xFE);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x14, 0x06, 0x50);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x16, 0x00, 0x60);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x18, 0x02, 0xD3);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x34, 0x00, 0x00);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x54, 0x00, 0x00);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x56, 0x00, 0x00);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x58, 0x05, 0x00);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x5A, 0x02, 0xD0);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x5C, 0x00, 0x03);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x68, 0x05, 0x00);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x6A, 0x02, 0xD0);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x8C, 0x1E, 0x00);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x8E, 0x0F, 0x00);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x14, 0x00, 0x00);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x16, 0x00, 0x00);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x18, 0x04, 0xFF);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x1A, 0x02, 0xCF);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x1C, 0x00, 0x00);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x1E, 0x00, 0x00);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x20, 0x00, 0xFF);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x22, 0x00, 0x8F);
    SensorWrite2B (SENSOR_ADDR_WR, 0xE8, 0x01, 0x00, 0x00);
}

/* Patch, errata and optimization settings from Aptina.
   The procedure is adapted from Aptina's sensor initialization scripts. Please
   refer to the MT9M114 sensor datasheet for details.
 */
static void
Step3_Recommended (
        void)
{
    uint8_t buf[2];

    /* Sensor optimization. */
    SensorWrite2B (SENSOR_ADDR_WR, 0x31, 0x6A, 0x82, 0x70);
    SensorWrite2B (SENSOR_ADDR_WR, 0x31, 0x6C, 0x82, 0x70);
    SensorWrite2B (SENSOR_ADDR_WR, 0x3E, 0xD0, 0x23, 0x05);
    SensorWrite2B (SENSOR_ADDR_WR, 0x3E, 0xD2, 0x77, 0xCF);
    SensorWrite2B (SENSOR_ADDR_WR, 0x31, 0x6E, 0x82, 0x02);
    SensorWrite2B (SENSOR_ADDR_WR, 0x31, 0x80, 0x87, 0xFF);
    SensorWrite2B (SENSOR_ADDR_WR, 0x30, 0xD4, 0x60, 0x80);
    SensorWrite2B (SENSOR_ADDR_WR, 0xA8, 0x02, 0x00, 0x08);

    /* Errata item 1: REG = 0x3E14, 0xFF39. */
    SensorWrite2B (SENSOR_ADDR_WR, 0x3E, 0x14, 0xFF, 0x39);

    /* Errata item 2: BITFIELD = 0x301A, 0x0400, 0x1 */
    SensorRead2B (SENSOR_ADDR_RD, 0x30, 0x1A, buf);
    buf[0] |= (1 << 2);
    SensorWrite2B (SENSOR_ADDR_WR, 0x30, 0x1A, buf[0], buf[1]);
}

/*
   The procedure is adapted from Aptina's sensor initialization scripts. Please
   refer to the MT9M114 sensor datasheet for details.
 */
static void
Step4_APGA (
        void)
{
    /* LOAD_PROM = 0xA8, PGA, FACTORY, ELSELOAD = PROM_PROMPT */
    SensorWrite2B (SENSOR_ADDR_WR, 0x09, 0x8E, 0x00, 0x00); /* set XDMA to logical addressing */
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x5E, 0x00, 0x03); /* enable PGA and APGA */
}

/*
   The procedure is adapted from Aptina's sensor initialization scripts. Please
   refer to the MT9M114 sensor datasheet for details.
 */
static void
Step5_AWB_CCM (
        void)
{
    /* CCM */
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x92, 0x02, 0x6C);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x94, 0xFF, 0x1A);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x96, 0xFF, 0xB3);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x98, 0xFF, 0x80);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x9A, 0x01, 0x66);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x9C, 0x00, 0x03);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x9E, 0xFF, 0x9A);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0xA0, 0xFE, 0xB4);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0xA2, 0x02, 0x4D);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0xA4, 0x01, 0xBF);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0xA6, 0xFF, 0x01);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0xA8, 0xFF, 0xF3);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0xAA, 0xFF, 0x75);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0xAC, 0x01, 0x98);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0xAE, 0xFF, 0xFD);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0xB0, 0xFF, 0x9A);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0xB2, 0xFE, 0xE7);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0xB4, 0x02, 0xA8);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0xB6, 0x01, 0xD9);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0xB8, 0xFF, 0x26);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0xBA, 0xFF, 0xF3);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0xBC, 0xFF, 0xB3);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0xBE, 0x01, 0x32);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0xC0, 0xFF, 0xE8);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0xC2, 0xFF, 0xDA);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0xC4, 0xFE, 0xCD);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0xC6, 0x02, 0xC2);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0xC8, 0x00, 0x75);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0xCA, 0x01, 0x1C);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0xCC, 0x00, 0x9A);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0xCE, 0x01, 0x05);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0xD0, 0x00, 0xA4);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0xD2, 0x00, 0xAC);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0xD4, 0x0A, 0x8C);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0xD6, 0x0F, 0x0A);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0xD8, 0x19, 0x64);
    /* Load factory RG and BG gains, if any */

    /* AWB */
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x14, 0x00, 0x00);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x16, 0x00, 0x00);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x18, 0x04, 0xFF);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x1A, 0x02, 0xCF);

    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x04, 0x00, 0x33); /*  CAM_AWB_AWB_XSHIFT_PRE_ADJ */
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x06, 0x00, 0x40); /*  CAM_AWB_AWB_YSHIFT_PRE_AD */

    /* VAR8 = 18, 0xF2, 0x3 */
    /* VAR8 = 18, 0xF3, 0x2 */
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0xF2, 0x03, 0x02);

    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x06, 0x00, 0x3C);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0xF4, 0x00, 0x00);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0xF6, 0x00, 0x00);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0xF8, 0x00, 0x00);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0xFA, 0xE7, 0x24);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0xFC, 0x15, 0x83);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0xFE, 0x20, 0x45);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x00, 0x05, 0xDC);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x02, 0x00, 0x7C);

    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x0C, 0x80, 0x80);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x0E, 0x80, 0x88);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x10, 0x80, 0x80);
}

/*
   The procedure is adapted from Aptina's sensor initialization scripts. Please
   refer to the MT9M114 sensor datasheet for details.
 */
static void
Step7_PIPE_Preference (
        void)
{
    uint8_t buf[2];

    /* Color pipeline */
    /* VAR = 18, 0x126, 0x126, 0x0020 */
    /* VAR= 18, 0x128, 0x128, 0x009A */
    /* VAR= 18, 0x146, 0x146, 0x0070 */
    /* VAR= 18, 0x148, 0x148, 0x00F3 */
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x26, 0x00, 0x20);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x28, 0x00, 0x9A);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x46, 0x00, 0x70);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x48, 0x00, 0xF3);

    /* VAR= 18, 0x152, 0x152, 0x0020 */
    /* VAR= 18, 0x154, 0x154, 0x009A */
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x52, 0x00, 0x20);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x54, 0x00, 0x9A);

    /* VAR8 = 18, 0x12A, 0x12A, 0x80 */
    /* VAR8 = 18, 0x12B, 0x12B, 0x4B */
    /* VAR8 = 18, 0x12C, 0x12C, 0x00 */
    /* VAR8 = 18, 0x12D, 0x12D, 0xFF */
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x2A, 0x80, 0x4B);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x2C, 0x00, 0xFF);

    /* VAR8 = 18, 0x12E, 0x12E, 0x3C */
    /* VAR8 = 18, 0x12F, 0x12F, 0x02 */
    /* VAR8 = 18, 0x130, 0x130, 0x06 */
    /* VAR8 = 18, 0x131, 0x131, 0x64 */
    /* VAR8 = 18, 0x132, 0x132, 0x01 */
    /* VAR8 = 18, 0x133, 0x133, 0x0C */
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x2E, 0x3C, 0x02);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x30, 0x06, 0x64);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x32, 0x01, 0x0C);

    /* VAR8 = 18, 0x134, 0x134, 0x3C */
    /* VAR8 = 18, 0x135, 0x135, 0x3C */
    /* VAR8 = 18, 0x136, 0x136, 0x3C */
    /* VAR8 = 18, 0x137, 0x137, 0x19 */
    /* VAR8 = 18, 0x138, 0x138, 0x64 */
    /* VAR8 = 18, 0x139, 0x139, 0x64 */
    /* VAR8 = 18, 0x13A, 0x13A, 0x64 */
    /* VAR8 = 18, 0x13B, 0x13B, 0x32 */
    SensorWrite2B (SENSOR_ADDR_WR, 0xc9, 0x34, 0x3C, 0x3C);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x36, 0x3C, 0x19);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x38, 0x64, 0x64);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x3A, 0x64, 0x32);

    /* VAR= 18, 0x13C, 0x13C, 0x0010 */
    /* VAR= 18, 0x13E, 0x13E, 0x0070 */
    /* VAR= 18, 0x140, 0x140, 0x00DC */
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x3C, 0x00, 0x10);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x3E, 0x00, 0x70);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x40, 0x00, 0xDC);

    /* VAR8 = 18, 0x142, 0x142, 0x38 */
    /* VAR8 = 18, 0x143, 0x143, 0x30 */
    /* VAR8 = 18, 0x144, 0x144, 0x50 */
    /* VAR8 = 18, 0x145, 0x145, 0x19 */
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x42, 0x38, 0x30);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x44, 0x50, 0x19);


    /* VAR= 18, 0x14A, 0x14A, 0x0230 */
    /* VAR= 18, 0x14C, 0x14C, 0x0010 */
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x4A, 0x02, 0x30);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x4C, 0x00, 0x10);

    /* VAR= 18, 0x14E, 0x14E, 0x01CD */
    /* VAR8 = 18, 0x150, 0x150, 0x05 */
    /* VAR8 = 18, 0x151, 0x151, 0x40 */
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x4E, 0x01, 0xCD);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x50, 0x05, 0x40);

    /* REG= 0xC87B, 0x1B   : CAM_AET_TARGET_AVERAGE_LUMA_DARK */
    /* REG= 0xC878, 0x0E   : CAM_AET_AEMODE */
    /* REG= 0xC890, 0x0080 : CAM_AET_TARGET_GAIN */
    /* REG= 0xC886, 0x0100 : CAM_AET_AE_MAX_VIRT_AGAIN */
    /* REG= 0xC87C, 0x005A : CAM_AET_BLACK_CLIPPING_TARGET */
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x7B, 0x00, 0x1B);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x78, 0x00, 0x0E);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x90, 0x00, 0x80);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x86, 0x01, 0x00);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x7C, 0x00, 0x5A);

    /* VAR8 = 13, 0x2A, 0x2A, 0x05 */
    /* VAR8 = 10, 0xA, 0xA, 0x20 */
    buf[0] = 0x05;
    SensorWrite (SENSOR_ADDR_WR, 0xB4, 0x2A, 1, buf);

    buf[0] = 0x05;
    SensorWrite (SENSOR_ADDR_WR, 0xA8, 0x0A, 1, buf);
}

/*
   The procedure is adapted from Aptina's sensor initialization scripts. Please
   refer to the MT9M114 sensor datasheet for details.
 */
static void
Step8_Features (
        void)
{
    /* REG = 0x098E, 0x0000 : Set XDMA to logical addressing */
    /* REG = 0xC984, 0x8040 : cam_port_output_control = 32832 */
    /* REG = 0x001E, 0x0777 : PAD SLEW CONTROL */
    /* IF_SERIAL=0xCA, 0x08, 0xFF, 8:16, ==0x10, LOAD=MIPI settings */
    SensorWrite2B (SENSOR_ADDR_WR, 0x09, 0x8E, 0x00, 0x00);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x84, 0x80, 0x40);
    SensorWrite2B (SENSOR_ADDR_WR, 0x00, 0x1E, 0x07, 0x77);
}

/*
   The procedure is adapted from Aptina's sensor initialization scripts. Please
   refer to the MT9M114 sensor datasheet for details.
 */
void
SensorScaling_VGA (
        void)
{
    uint8_t buf[2];

    /* PLL */
    SensorWrite2B (SENSOR_ADDR_WR, 0x09, 0x8E, 0x10, 0x00);
    buf[0] = 0x01;
    SensorWrite (SENSOR_ADDR_WR, 0xC9, 0x7E, 1, buf);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x80, 0x03, 0x3B);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x82, 0x0D, 0x00);

    /* 720P */
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x84, 0x80, 0x40);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x00, 0x00, 0x04);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x02, 0x00, 0x04);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x04, 0x03, 0xCB);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x06, 0x05, 0x0B);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x08, 0x01, 0x81); /* pixclk config */
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x0A, 0xD4, 0x52); /* pixclk config */
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x0C, 0x00, 0x01);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x0E, 0x00, 0xDB);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x10, 0x05, 0xB2);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x12, 0x03, 0xEF);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x14, 0x06, 0x35);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x16, 0x00, 0x60);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x18, 0x03, 0xC3);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x26, 0x00, 0x20);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x34, 0x00, 0x00);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x54, 0x00, 0x00);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x56, 0x00, 0x00);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x58, 0x05, 0x00);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x5A, 0x03, 0xC0);
    buf[0] = 0x03;
    SensorWrite (SENSOR_ADDR_WR, 0xC8, 0x5C, 1, buf);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x68, 0x02, 0x80);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x6A, 0x01, 0xE0);
    buf[0] = 0x00;
    SensorWrite (SENSOR_ADDR_WR, 0xC8, 0x78, 1, buf);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x8C, 0x0F, 0xCD);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x8E, 0x0F, 0xCD);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x14, 0x00, 0x00);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x16, 0x00, 0x00);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x18, 0x02, 0x7F);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x1A, 0x01, 0xDF);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x1C, 0x00, 0x00);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x1E, 0x00, 0x00);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x20, 0x00, 0x7F);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x22, 0x00, 0x5F);

    SensorChangeConfig();
}

/*
   The procedure is adapted from Aptina's sensor initialization scripts. Please
   refer to the MT9M114 sensor datasheet for details.
 */
void
SensorScaling_HD720p_30fps (
        void)
{
    uint8_t buf[2];

    SensorWrite2B (SENSOR_ADDR_WR, 0x09, 0x8E, 0x10, 0x00);

    buf[0] = 0x01;
    SensorWrite (SENSOR_ADDR_WR, 0xC9, 0x7E, 1, buf);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x80, 0x01, 0x20);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x82, 0x07, 0x00);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x84, 0x80, 0x40);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x00, 0x00, 0x04);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x02, 0x00, 0x04);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x04, 0x03, 0xCB);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x06, 0x05, 0x0B);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x08, 0x02, 0xDC);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x0A, 0x6C, 0x00);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x0C, 0x00, 0x01);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x0E, 0x00, 0xDB);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x10, 0x05, 0xB3);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x12, 0x03, 0xEE);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x14, 0x06, 0x36);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x16, 0x00, 0x60);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x18, 0x03, 0xC3);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x26, 0x00, 0x20);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x34, 0x00, 0x00);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x54, 0x00, 0x00);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x56, 0x00, 0x00);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x58, 0x05, 0x00);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x5A, 0x03, 0xC0);

    buf[0] = 0x03;
    SensorWrite (SENSOR_ADDR_WR, 0xC8, 0x5C, 1, buf);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x68, 0x05, 0x00);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x6A, 0x02, 0xD0);

    buf[0] = 0x00;
    SensorWrite (SENSOR_ADDR_WR, 0xC8, 0x78, 1, buf);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x8C, 0x1E, 0x02);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC8, 0x8E, 0x1E, 0x02);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x14, 0x00, 0x00);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x16, 0x00, 0x00);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x18, 0x04, 0xFF);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x1A, 0x02, 0xCF);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x1C, 0x00, 0x00);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x1E, 0x00, 0x00);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x20, 0x00, 0xFF);
    SensorWrite2B (SENSOR_ADDR_WR, 0xC9, 0x22, 0x00, 0x8F);

    SensorChangeConfig();
}

/*
   The procedure is adapted from Aptina's sensor initialization scripts. Please
   refer to the MT9M114 sensor datasheet for details.
 */
void
SensorChangeConfig (
        void)
{
    uint8_t buf[2];

    /* 1. set next state is change_config */
    buf[0] = 0x28;  /* sys_state_enter_config_change */
    SensorWrite (SENSOR_ADDR_WR, 0xDC, 0x00, 1, buf);

    /* 2. poll command register */
    while (SensorRead2B(SENSOR_ADDR_RD, 0x00, 0x80, buf))
    {
        if (!(buf[1]& 0x02))
            break;
    }

    /* 3. issue command */
    SensorWrite2B (SENSOR_ADDR_WR, 0x00, 0x80, 0x80, 0x02);

    /* 4. waiting for firmware updating new configuration */
    while (SensorRead2B(SENSOR_ADDR_RD, 0x00, 0x80, buf))
    {
        if (!(buf[1]& 0x02))
            break;
    }

    /* 5. error handling */
    SensorRead2B (SENSOR_ADDR_RD, 0x00, 0x80, buf);

    /* 6. refresh command */
    SensorWrite2B (SENSOR_ADDR_WR, 0x00, 0x80, 0x80, 0x04);
    while (SensorRead2B(SENSOR_ADDR_RD, 0x00, 0x80, buf))
    {
        if (!(buf[1]& 0x04))
            break;
    }

    SensorRead2B (SENSOR_ADDR_RD, 0xDC, 0x01, buf);
}

/*
   Get the current brightness setting from the MT9M114 sensor.
 */
uint8_t
SensorGetBrightness (
        void)
{
    uint8_t buf[2];

    SensorRead2B (SENSOR_ADDR_RD, 0xCC, 0x0A, buf);
    return (uint8_t)buf[1];
}

/* TODO #2-2 sensor function to read gain register */
/* Copy the SensorGetBrightness function (right aobve this comment),
 * paste it below this comment and rename it to SensorGetGain.
 * Change the register address accessed to 0xCC12.
 */

/*
   Update the brightness setting for the MT9M114 sensor.
 */
void
SensorSetBrightness (
        uint8_t input)
{
    SensorWrite2B (SENSOR_ADDR_WR, 0xCC, 0x0A, 0x00, input);
}

/* TODO #2-3 sensor function to write gain register */
/* Copy the SensorSetBrightness function (right above),
 * paste it below this comment and rename it to SensorSetGain.
 * Change the register address accessed to 0xCC12.
 */


