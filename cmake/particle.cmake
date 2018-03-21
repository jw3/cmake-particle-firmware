function(add_particle_app name)
    file(RELATIVE_PATH TARGET_DIR ${FIRMWARE_DIR}/main ${CMAKE_CURRENT_BINARY_DIR}/${name})

    set(APP_DIR ${CMAKE_CURRENT_SOURCE_DIR}/${name})
    file(GLOB SOURCE_FILES ${APP_DIR}/*.cpp)

    set(MAKE_ARGS
        PLATFORM=${PLATFORM}
        TARGET_DIR=${TARGET_DIR}
        GCC_ARM_PATH=${GCC_ARM_PATH}
        APPDIR=${APP_DIR})

    set(OUTPUT_PREFIX ${CMAKE_BINARY_DIR}/${name})

    add_custom_target(${name} ALL
                      DEPENDS ${OUTPUT_PREFIX}/${name}.bin)

    add_custom_command(OUTPUT ${OUTPUT_PREFIX}/${name}.bin
                       COMMAND make
                       ARGS ${MAKE_ARGS}
                       DEPENDS ${SOURCE_FILES}
                       WORKING_DIRECTORY ${FIRMWARE_DIR}
                       COMMENT "Compile app [${name}] for the ${PLATFORM} platform.")

    configure_file(${CMAKE_SOURCE_DIR}/common/flash.mk.in ${CMAKE_BINARY_DIR}/${name}/flash.mk)

endfunction(add_particle_app)
