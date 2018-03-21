function(add_particle_app name)
    file(RELATIVE_PATH TARGET_DIR ${FIRMWARE_DIR}/main ${CMAKE_CURRENT_BINARY_DIR}/${name})

    set(MAKE_ARGS
        PLATFORM=${PLATFORM}
        TARGET_DIR=${TARGET_DIR}
        GCC_ARM_PATH=${GCC_ARM_PATH}
        APPDIR=${CMAKE_CURRENT_SOURCE_DIR}/${name})

    add_custom_target(${name} ALL
                      COMMAND make ${MAKE_ARGS}
                      WORKING_DIRECTORY ${FIRMWARE_DIR})

    configure_file(${CMAKE_SOURCE_DIR}/common/flash.mk.in ${CMAKE_BINARY_DIR}/${name}/flash.mk)

endfunction(add_particle_app)
