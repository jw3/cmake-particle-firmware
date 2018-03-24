set(CMAKE_CXX_COMPILER "${GCC_ARM_PATH}/arm-none-eabi-g++")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g3 -gdwarf-2 -Os -mcpu=cortex-m3 -mthumb")

set(ARM_DEFS ARDUINO=10800 RELEASE_BUILD)
include_directories(/usr/local/src/particle/firmware/hal/inc
                    /usr/local/src/particle/firmware/user/inc
                    /usr/local/src/particle/firmware/system/inc
                    /usr/local/src/particle/firmware/wiring/inc
                    /usr/local/src/particle/firmware/hal/shared
                    /usr/local/src/particle/firmware/services/inc
                    /usr/local/src/particle/firmware/hal/src/stm32
                    /usr/local/src/particle/firmware/communication/src)
