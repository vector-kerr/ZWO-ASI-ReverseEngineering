# ZWO-ASI-ReverseEngineering

This repository contains efforts to reverse-engineer the protocol of the ZWO ASI120MM-S camera.

## List of files

filename                                   | description
-------------------------------------------|--------------------------------------------------------------------------------------------------------------
README.md                                  | Description of the library
MD5SUM                                     | contains MD5 checksums of the original library and include files (v0.0.918).
ASICamera2.h.orig                          | The original header file
libASICamera2.a.orig                       | The original static library
libASICamera2.so.0.0.0918.orig             | The original dynamic library
ISSUES.txt                                 | A text file describing several issues with the current include file and library
ASICamera2.h                               | A hand-edited version of the library include file to fix some problems (see ISSUES.txt).
patch-library.py                           | A script to make patched versions of the library where all references to "libusb" are replaced by "libUSB".
libASICamera2.a                            | The patched static library; uses "libUSB_<xxx>" rather than "libusb_<xxx>" calls.
libASICamera2.so.0.0.0918                  | The patched dynamic library; uses "libUSB_<xxx>" rather than "libusb_<xxx>" calls.
asi-test.cc                                | A test program that controls the camera and captures a bunch of images.
libUSB.c                                   | A set of functions that mimic libusb behavior, printing invocations and results along the way.
Makefile                                   | Makefile for asi-test, using the libUSB.c functions.

## External info

A partial datasheet for the MT9M034 sensor can be found by googling, e.g. here: http://ghgtechn.com/admin/upload/634912822373126250MT9M034_DS_B.pdf

Note that this datasheet is marked "Aptina Confidential and Proprietary". Furthermore, the datasheet sadly doesn't include the register file description.

Some more info is available here:

https://github.com/Aptina/BeagleBoard-xM/tree/master/MT9M034

This has a V4L2 driver for the MT9M034 sensor that is partially done, it seems. At the very least we see some names for the register file in the code there.

## Register file

This taken from the BeagleBoard-xM driver.

#define MT9M034_CHIP_ID_REG                 0x3000
#define MT9M034_CHIP_ID                     0x2400
#define MT9M034_RESET_REG                   0x301A
#define MT9M034_SEQ_CTRL_PORT               0x3088
#define MT9M034_SEQ_DATA_PORT               0x3086
#define MT9M034_ANALOG_REG                  0x3ED6
#define MT9M034_TEST_RAW_MODE               0x307A
#define MT9M034_DARK_CTRL                   0x3044
#define MT9M034_DATA_PEDESTAL               0x301E
#define MT9M034_COLUMN_CORRECTION           0x30D4
#define MT9M034_VT_SYS_CLK_DIV              0x302A
#define MT9M034_VT_PIX_CLK_DIV              0x302C
#define MT9M034_PRE_PLL_CLK_DIV             0x302E
#define MT9M034_PLL_MULTIPLIER              0x3030
#define MT9M034_DIGITAL_TEST                0x30B0
#define MT9M034_Y_ADDR_START                0x3002
#define MT9M034_X_ADDR_START                0x3004
#define MT9M034_Y_ADDR_END                  0x3006
#define MT9M034_X_ADDR_END                  0x3008
#define MT9M034_FRAME_LENGTH_LINES          0x300A
#define MT9M034_LINE_LENGTH_PCK             0x300C
#define MT9M034_COARSE_INT_TIME             0x3012
#define MT9M034_FINE_INT_TIME               0x3014
#define MT9M034_COARSE_INT_TIME_CB          0x3016
#define MT9M034_FINE_INT_TIME_CB            0x3018
#define MT9M034_X_ODD_INC                   0x30A2
#define MT9M034_Y_ODD_INC                   0x30A6
#define MT9M034_READ_MODE                   0x3040
#define MT9M034_TEST_PATTERN                0x3070
#define MT9M034_LLP_RECOMMENDED               1650
#define MT9M034_DIGITAL_BINNING             0x3032
#define MT9M034_HOR_AND_VER_BIN             0x0022
#define MT9M034_HOR_BIN                     0x0011
#define MT9M034_DISABLE_BINNING             0x0000
#define MT9M034_AE_CTRL_REG                 0x3100
#define MT9M034_GREEN1_GAIN                 0x3056
#define MT9M034_BLUE_GAIN                   0x3058
#define MT9M034_RED_GAIN                    0x305A
#define MT9M034_GREEN2_GAIN                 0x305C
#define MT9M034_GLOBAL_GAIN                 0x305E
#define MT9M034_GREEN1_GAIN_CB              0x30BC
#define MT9M034_BLUE_GAIN_CB                0x30BE
#define MT9M034_RED_GAIN_CB                 0x30C0
#define MT9M034_GREEN2_GAIN_CB              0x30C2
#define MT9M034_GLOBAL_GAIN_CB              0x30C4
#define MT9M034_RESET_REGISTER              0x301A
#define MT9M034_RESET                       0x00D9
#define MT9M034_STREAM_OFF                  0x00D8
#define MT9M034_STREAM_ON                   0x00DC
#define MT9M034_ERS_PROG_START_ADDR         0x309E
#define MT9M034_MODE_CTRL                   0x3082
#define MT9M034_DAC_LD_14_15                0x3EDA
#define MT9M034_DAC_LD_18_19                0x3EDE
#define MT9M034_DAC_LD_12_13                0x3ED8
#define MT9M034_DAC_LD_22_23                0x3EE2
#define MT9M034_DAC_LD_20_21                0x3EE0
#define MT9M034_DAC_LD_16_17                0x3EDC
#define MT9M034_DARK_CONTROL                0x3044
#define MT9M034_DAC_LD_26_27                0x3EE6
#define MT9M034_DAC_LD_24_25                0x3EE4
#define MT9M034_DAC_LD_10_11                0x3ED6
#define MT9M034_ADC_BITS_6_7                0x30E4
#define MT9M034_ADC_BITS_4_5                0x30E2
#define MT9M034_ADC_BITS_2_3                0x30E0
#define MT9M034_ADC_CONFIG1                 0x30E6
#define MT9M034_ADC_CONFIG2                 0x30E8
#define MT9M034_DIGITAL_CTRL                0x30BA
#define MT9M034_COARSE_INTEGRATION_TIME     0x3012
#define MT9M034_HDR_COMP                    0x31D0
#define MT9M034_AE_DCG_EXPOSURE_HIGH_REG    0x3112
#define MT9M034_AE_DCG_EXPOSURE_LOW_REG     0x3114
#define MT9M034_AE_DCG_GAIN_FACTOR_REG      0x3116
#define MT9M034_AE_DCG_GAIN_FACTOR_INV_REG  0x3118
#define MT9M034_AE_LUMA_TARGET_REG          0x3102
#define MT9M034_AE_HIST_TARGET_REG          0x3104
#define MT9M034_AE_ALPHA_V1_REG             0x3126
#define MT9M034_AE_MAX_EXPOSURE_REG         0x311C
#define MT9M034_AE_MIN_EXPOSURE_REG         0x311E
#define MT9M034_EMBEDDED_DATA_CTRL          0x3064



## Methodology of reverse-engineering the library

The proprietary ASICamera2 library uses libusb 1.0 (the modern version of the user-space USB library) to
communicate with devices.

To understand the way in which the library uses libusb, we generated a patched version of the ASICamera2 library
where all references to "libusb" are replaced by "libUSB".

Next, we implement a "libUSB.c" that re-implements 15 of the "libusb" functions, but renames them with the prefix "libUSB".
These 15 functions print their arguments, call the actual libusb functions, and then print the return value of the libusb functions.

This effectively means that all usage of libusb by the ASICamera2 is now logged.

## What we learned so far

The "ASICamera2" API currently consists of 21 function calls.
We describe them below and discuss below what they do in terms of USB bus activity.

All functions use the 'default' context of libusb, meaning that they pass a NULL pointer as the 'context' argument
wherever it is needed.

##### int ASIGetNumOfConnectedCameras()

The ASIGetNumOfConnectedCameras() call is intended to be the first function called in a program that
uses the ASICamera2 library.


It starts by executing a libusb_init() call. Next it executes libusb_get_device_list() to obtain a list of
all USB devices available in the system.

Next, it traverses the list of all devices. For each device, three libusb functions are called:

- libusb_get_device_descriptor()
- libusb_get_device_address()
- libusb_get_bus_number()

This allows the ASICamera2 library to find all ZWO ASI devices, and build an internal data structure to describe
where they are.

Finally, the device list is freed by executing libusb_free_device_list(), and libusb_exit() is called to detach from
libusb.

Note that this is the only function in the API that does not return an ASI_ERROR_CODE. Instead, it returns the
number of ASI camera devices found.

##### ASI_ERROR_CODE ASIGetCameraProperty(ASI_CAMERA_INFO *pASICameraInfo, int iCameraIndex)

This function fills a user-supplied ASI_CAMERA_INFO structure with information about an ASI camera device.

This function only works if ASIGetNumOfConnectedCameras() was executed beforehand. If it is called before, an
ASI_ERROR_INVALID_ID is returned, presumably because the internal list of devices maintained by ASICamera2
contains zero devices.

This function does not cause any traffic on the USB bus. This suggests that all information is contained
as a lookup table in the library.

The ASI_CAMERA_INFO contains the all-important 'CameraID' field. This is an integer value that is used to
identify the camera in all API calls below.

##### ASI_ERROR_CODE ASIOpenCamera(int iCameraID)

Almost all functions in the API require that the camera be opened using this call.

Note that on my machine, this call fails with error ASI_ERROR_CAMERA_REMOVED if the camera is connected in
an actual USB3 port.

This function causes a flurry of libusb activity.

- libusb_init()
- libusb_open_device_with_vid_pid(vendor_id = 963, product_id = 4621)
- libusb_set_configuration(configuration = 1)
- libusb_claim_interface(interface_number = 0)
- libusb_control_transfer calls (129x !!!)

The 129 control calls are where much of the action is happening
This will be rather hard to reverse engineer.

##### ASI_ERROR_CODE ASICloseCamera(int iCameraID)

This function closes the camera device that was previously opened by ASIOpenCamera().

It causes two calls to libusb_close(); one with the USB device handle, and another one with NULL.
The latter invocation may be a bug.

##### ASI_ERROR_CODE ASIIsUSB3Host(int iCameraID, ASI_BOOL *bSet);

This function returns whether the camera is a USB3 host.
The camera device must be opened for this to work.

With my ASI120/MM-S, this function returns 0 if it is plugged in an USB2 port.
As indicated above, my camera doesn't currently work on an USB3 port under Linux.

This function causes no USB activity.

##### ASI_ERROR_CODE ASIGetNumOfControls(int iCameraID, int * piNumberOfControls)

This function queries the number of controls.
A "control" is a camera parameter that can be set.
The camera device must be opened for this to work.

This function causes no USB activity.

##### ASI_ERROR_CODE ASIGetControlCaps(int iCameraID, int iControlIndex, ASI_CONTROL_CAPS * pControlCaps)

This function gives information about a specific control.
A "control" is a camera parameter that can be set.
The camera device must be opened for this to work.

The ControlID and ControlType fields in ASI_CONTROL_CAPS appear to be identical.

However, the "AutoExpMaxBrightness", with ControlID 12, control gives ControlType 11 (ASI_AutoExpMaxExp),
which should probably be 12 (ASI_AutoExpMaxBrightness).

This function causes no USB activity.

##### ASI_ERROR_CODE ASIGetControlValue(int iCameraID, int iControlID, long *plValue, ASI_BOOL *pbAuto)

Get the current value of a certain control.

Note that only a query of the ASI_TEMPERATURE control causes bus activity
An ASI_TEMPERATURE request looks like this:

libusb_control_transfer(dev, bmRequestType = 192, bRequest = 0xa7, wValue = 0x30b2, wIndex = 0, data = ..., wLength = 2, timeout = 500)

All other values are (apparently) cached.

##### ASI_ERROR_CODE ASISetControlValue(int iCameraID, int iControlID, long lValue, ASI_BOOL bAuto)

Setting values will not fail on an open camera. No range checking is performed.

control                      | number of libusb_control_transfer() calls
-----------------------------|------------------------------------------
ASI_GAIN                     | 2
ASI_EXPOSURE                 | 1
ASI_GAMMA                    | 0 (local)
ASI_WB_R                     | 0 (local)
ASI_WB_B                     | 0 (local)
ASI_BRIGHTNESS               | 1
ASI_BANDWIDTHOVERLOAD        | 2
ASI_OVERCLOCK                | 7
ASI_TEMPERATURE              | 0 (local)
ASI_FLIP                     | 0 (local)
ASI_AutoExpMaxGain           | 0 (local)
ASI_AutoExpMaxExp            | 0 (local)
ASI_AutoExpMaxBrightness     | 0 (local)

##### ASI_ERROR_CODE ASISetROIFormat(int iCameraID, int   iWidth, int   iHeight,  int   iBin, ASI_IMG_TYPE   Img_type)

libusb_control_transfer(dev = 0x8b37f0, bmRequestType =  64, bRequest = 0xa6, wValue = 0x3002, wIndex =   450, data =          (nil), wLength =    0, timeout = 500)
libusb_control_transfer(dev = 0x8b37f0, bmRequestType =  64, bRequest = 0xa6, wValue = 0x3004, wIndex =   576, data =          (nil), wLength =    0, timeout = 500)
libusb_control_transfer(dev = 0x8b37f0, bmRequestType =  64, bRequest = 0xa6, wValue = 0x3006, wIndex =   513, data =          (nil), wLength =    0, timeout = 500)
libusb_control_transfer(dev = 0x8b37f0, bmRequestType =  64, bRequest = 0xa6, wValue = 0x3008, wIndex =   703, data =          (nil), wLength =    0, timeout = 500)
libusb_control_transfer(dev = 0x8b37f0, bmRequestType =  64, bRequest = 0xac, wValue = 0x0000, wIndex =     0, data =          (nil), wLength =    0, timeout = 200)
libusb_clear_halt()
libusb_control_transfer(dev = 0x8b37f0, bmRequestType =  64, bRequest = 0xb5, wValue = 0x0000, wIndex =     1, data =          (nil), wLength =    0, timeout = 500)
libusb_control_transfer(dev = 0x8b37f0, bmRequestType =  64, bRequest = 0xa6, wValue = 0x300c, wIndex =  1390, data =          (nil), wLength =    0, timeout = 500)
libusb_control_transfer(dev = 0x8b37f0, bmRequestType =  64, bRequest = 0xa6, wValue = 0x3012, wIndex =   835, data =          (nil), wLength =    0, timeout = 500)
libusb_control_transfer(dev = 0x8b37f0, bmRequestType =  64, bRequest = 0xa6, wValue = 0x300a, wIndex =    90, data =          (nil), wLength =    0, timeout = 500)

##### ASI_ERROR_CODE ASIGetROIFormat(int iCameraID, int *piWidth, int *piHeight,  int *piBin, ASI_IMG_TYPE *pImg_type)

No traffic.

##### ASI_ERROR_CODE ASISetStartPos(int iCameraID, int iStartX, int iStartY)

libusb_control_transfer(dev = 0xc9a7f0, bmRequestType =  64, bRequest = 0xa6, wValue = 0x3002, wIndex = y0 + 2                    , data = (nil), wLength = 0, timeout = 500)
libusb_control_transfer(dev = 0xc9a7f0, bmRequestType =  64, bRequest = 0xa6, wValue = 0x3004, wIndex = x0                        , data = (nil), wLength = 0, timeout = 500)
libusb_control_transfer(dev = 0xc9a7f0, bmRequestType =  64, bRequest = 0xa6, wValue = 0x3006, wIndex = y0 + BinSize * yHeight + 1, data = (nil), wLength = 0, timeout = 500)
libusb_control_transfer(dev = 0xc9a7f0, bmRequestType =  64, bRequest = 0xa6, wValue = 0x3008, wIndex = x0 + BinSize * xWidth  - 1, data = (nil), wLength = 0, timeout = 500)

##### ASI_ERROR_CODE ASIGetStartPos(int iCameraID, int *piStartX, int *piStartY)

No traffic.

##### ASI_ERROR_CODE ASIEnableDarkSubtract(int iCameraID, char *pcBMPPath, bool *bIsSubDarkWorking)
##### ASI_ERROR_CODE ASIDisableDarkSubtract(int iCameraID)

##### ASI_ERROR_CODE ASIStartVideoCapture(int iCameraID)
##### ASI_ERROR_CODE ASIStopVideoCapture(int iCameraID)

##### ASI_ERROR_CODE ASIGetDroppedFrames(int iCameraID,int *piDropFrames)

##### ASI_ERROR_CODE ASIGetVideoData(int iCameraID, unsigned char* pBuffer, long lBuffSize, int iWaitms)

##### ASI_ERROR_CODE ASIPulseGuideOn(int iCameraID, ASI_GUIDE_DIRECTION direction)

Enable the pulse guide for a given direction.

libusb_control_transfer(dev, bmRequestType = 64, bRequest = 0xb0, wValue = direction, wIndex = 0, data = NULL, wLength = 0, timeout = 500)

- bRequest = 0xb0

- ASI_GUIDE_NORTH = 0
- ASI_GUIDE_SOUTH = 1
- ASI_GUIDE_EAST  = 2
- ASI_GUIDE_WEST  = 3

This function is completely understood.

##### ASI_ERROR_CODE ASIPulseGuideOff(int iCameraID, ASI_GUIDE_DIRECTION direction)

Disable the pulse guide for a given direction.

libusb_control_transfer(dev, bmRequestType = 64, bRequest = 0xb1, wValue = direction, wIndex = 0, data = NULL, wLength = 0, timeout = 500)

- bRequest = 0xb1

- ASI_GUIDE_NORTH = 0
- ASI_GUIDE_SOUTH = 1
- ASI_GUIDE_EAST  = 2
- ASI_GUIDE_WEST  = 3

This function is completely understood.
