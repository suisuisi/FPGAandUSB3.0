
                        CYPRESS SEMICONDUCTOR CORPORATION
                                    FX3 SDK

SYNCHRONOUS SLAVE FIFO PROTOCOL EXAMPLE
---------------------------------------

  This example illustrates the configuration and usage of the GPIF II
  interface on the FX3 device to implement the synchronous slave FIFO
  protocol.

  A master device that implements the Cypress defined Sync Slave FIFO
  protocol is required to perform data transfers with this application.

  This application example does the following:

  1. Configures the GPIF II interface to implement the Sync Slave FIFO
     protocol.

  2. Enumerates as a vendor specific USB device with two bulk endpoints
     (1-OUT and 1-IN).

  3. Create MANUAL DMA channels to enable the following data paths:
     a. All data received from the USB host through the 1-OUT endpoint is
        forwarded to the master device on the slave port through socket 3.
     b. All data received from the master device on the slave port through
        socket 0 is forwarded to the USB host through the 1-IN endpoint.

  4. When any data packet is received through one of the ingress sockets,
     the application is notified and forwards the data to the recipient
     through a DMA callback function.

  Known limitation:
  In synchronous burst access operation, the minimum transfer size to 
  perform data read/write accesses from/to the FX3 device should be three words.
  In 16-bit mode this is six bytes and 32-bit mode this is twelve bytes.
  To transfer data less than this, single cycle access operation needs to 
  be used.

  Files:

    * cyfx_gcc_startup.S   : Start-up code for the ARM-9 core on the FX3
      device.  This assembly source file follows the syntax for the GNU
      assembler.

    * cyfxslfifosync.h     : C header file that defines constants used by
      this example implementation.  Can be modified to select USB connection
      speed, endpoint numbers and properties etc.

    * cyfxslfifousbdscr.c  : C source file that contains USB descriptors
      used by this example. VID and PID is defined in this file.

    * cyfxgpif_syncsf.h    : C header file that contains the data required
      to configure the GPIF interface to implement the Sync. Slave FIFO
      protocol.

    * cyfxtx.c             : C source file that provides ThreadX RTOS wrapper
      functions and other utilites required by the FX3 firmware library.

    * cyfxslfifosync.c     : Main C source file that implements this example.

    * makefile             : GNU make compliant build script for compiling
      this example.

[]

