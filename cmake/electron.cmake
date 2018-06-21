message("\n=============================== Configuring firmware for the -=-= ${PLATFORM} =-=- ===============================\n")

set(CMAKE_CXX_COMPILER "${GCC_ARM_PATH}/arm-none-eabi-g++")

set(PLATFORM_CXX_FLAGS
    -std=gnu++11
    -g3
    -gdwarf-2
    -Os
    -mcpu=cortex-m3
    -mthumb
    -fdata-sections
    -Wall
    -Wno-switch
    -Wno-error=deprecated-declarations
    -fmessage-length=0
    -fno-strict-aliasing
    -fno-builtin-malloc
    -fno-builtin-free
    -fno-builtin-realloc
    -fno-exceptions
    -fno-rtti
    -fcheck-new)

string(REPLACE ";" " " PLATFORM_CXX_FLAGS "${PLATFORM_CXX_FLAGS}")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${PLATFORM_CXX_FLAGS}")

set(PLATFORM_CXX_DEFS
    STM32_DEVICE
    STM32F2XX
    PLATFORM_THREADING=1
    PLATFORM_ID=10
    PLATFORM_NAME=electron
    USBD_VID_SPARK=0x2B04
    USBD_PID_DFU=0xD00A
    USBD_PID_CDC=0xC00A
    SPARK_PLATFORM
    INCLUDE_PLATFORM=1
    PRODUCT_ID=10
    PRODUCT_FIRMWARE_VERSION=65535
    USE_STDPERIPH_DRIVER
    DFU_BUILD_ENABLE
    SYSTEM_VERSION_STRING=0.6.4
    RELEASE_BUILD
    SPARK=1
    PARTICLE=1
    START_DFU_FLASHER_SERIAL_SPEED=14400
    START_YMODEM_FLASHER_SERIAL_SPEED=28800
    SPARK_PLATFORM_NET=UBLOXSARA
    LOG_INCLUDE_SOURCE_INFO=1
    PARTICLE_USER_MODULE
    USE_THREADING=0
    USE_SPI=SPI
    USE_CS=A2
    USE_SPI=SPI
    USE_CS=A2
    USE_THREADING=0
    USER_FIRMWARE_IMAGE_SIZE=0x20000
    USER_FIRMWARE_IMAGE_LOCATION=0x8080000
    MODULAR_FIRMWARE=1
    MODULE_VERSION=4
    MODULE_FUNCTION=5
    MODULE_INDEX=1
    MODULE_DEPENDENCY=4,2,110
    _WINSOCK_H
    _GNU_SOURCE
    LOG_MODULE_CATEGORY="app")

set(PLATFORM_CXX_INCLUDES
    ${FIRMWARE_DIR}/user/inc
    ${FIRMWARE_DIR}/user/libraries
    ${FIRMWARE_DIR}/wiring/inc
    ${FIRMWARE_DIR}/system/inc
    ${FIRMWARE_DIR}/services/inc
    ${FIRMWARE_DIR}/communication/src
    ${FIRMWARE_DIR}/hal/inc
    ${FIRMWARE_DIR}/hal/shared
    ${FIRMWARE_DIR}/hal/src/electron/rtos/FreeRTOSv8.2.2/FreeRTOS/Source/include
    ${FIRMWARE_DIR}/hal/src/electron/rtos/FreeRTOSv8.2.2/FreeRTOS/Source/portable/GCC/ARM_CM3
    ${FIRMWARE_DIR}/hal/src/electron
    ${FIRMWARE_DIR}/hal/src/stm32f2xx
    ${FIRMWARE_DIR}/hal/src/stm32
    ${FIRMWARE_DIR}/platform/shared/inc
    ${FIRMWARE_DIR}/platform/MCU/STM32F2xx/STM32_USB_Host_Driver/inc
    ${FIRMWARE_DIR}/platform/MCU/STM32F2xx/STM32_StdPeriph_Driver/inc
    ${FIRMWARE_DIR}/platform/MCU/STM32F2xx/STM32_USB_OTG_Driver/inc
    ${FIRMWARE_DIR}/platform/MCU/STM32F2xx/STM32_USB_Device_Driver/inc
    ${FIRMWARE_DIR}/platform/MCU/STM32F2xx/SPARK_Firmware_Driver/inc
    ${FIRMWARE_DIR}/platform/MCU/shared/STM32/inc
    ${FIRMWARE_DIR}/platform/MCU/STM32F2xx/CMSIS/Include
    ${FIRMWARE_DIR}/platform/MCU/STM32F2xx/CMSIS/Device/ST/Include
    ${FIRMWARE_DIR}/dynalib/inc)
