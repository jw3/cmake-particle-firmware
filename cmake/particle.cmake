#
# copyright 2018 https://github.com/jw3
#

function(add_particle_app name)
    set(OUTPUT_PREFIX ${CMAKE_BINARY_DIR}/${name})
    set(APP_DIR ${CMAKE_SOURCE_DIR}/${name})
    file(RELATIVE_PATH TARGET_DIR ${FIRMWARE_DIR}/main ${CMAKE_BINARY_DIR}/${name})

    add_custom_target(${name} ALL
                      DEPENDS ${OUTPUT_PREFIX}/${name}.bin)

    foreach (dep IN LISTS ARGN)
        set(APPLIBS ${APPLIBS} ${${dep}})
        add_dependencies(${name} ${dep})
    endforeach ()

    set(MAKE_ARGS
        PLATFORM=${PLATFORM}
        TARGET_DIR=${TARGET_DIR}
        GCC_ARM_PATH=${GCC_ARM_PATH}
        APPDIR=${APP_DIR})

    if (APPLIBS)
        set(MAKE_ARGS ${MAKE_ARGS} APPLIBSV1=${APPLIBS})
    endif ()

    file(GLOB SOURCE_FILES ${APP_DIR}/*.cpp)

    add_custom_command(OUTPUT ${OUTPUT_PREFIX}/${name}.bin
                       COMMAND make
                       ARGS ${MAKE_ARGS}
                       DEPENDS ${SOURCE_FILES}
                       WORKING_DIRECTORY ${FIRMWARE_DIR}
                       COMMENT "Compile app [${name}] for the ${PLATFORM} platform.")

    configure_file(${CMAKE_SOURCE_DIR}/common/flash.mk.in ${CMAKE_BINARY_DIR}/${name}/flash.mk)

endfunction(add_particle_app)

function(add_particle_remote_app name)
    include(${PLATFORM})
    set(OUTPUT_PREFIX ${CMAKE_BINARY_DIR}/${name})

    set(APP_DIR ${CMAKE_SOURCE_DIR}/${name})
    file(RELATIVE_PATH TARGET_DIR ${FIRMWARE_DIR}/main ${CMAKE_BINARY_DIR}/${name})

    add_custom_target(${name} ALL
                      DEPENDS ${OUTPUT_PREFIX}/${name}.bin)

    file(GLOB SOURCE_FILES ${APP_DIR}/*.cpp)

    set(REMOTE_TARGET ${name}_remote)
    set(USER_REMOTE ${CMAKE_CURRENT_BINARY_DIR}/CMakeFiles/${REMOTE_TARGET}.dir/${name})
    add_library(${REMOTE_TARGET} STATIC ${SOURCE_FILES})
    target_compile_options(${REMOTE_TARGET} PRIVATE "$<$<CONFIG:ALL>:${PLATFORM_CXX_FLAGS}>")
    target_include_directories(${REMOTE_TARGET} PRIVATE ${APP_DIR} ${PLATFORM_CXX_INCLUDES})
    target_compile_definitions(${REMOTE_TARGET} PRIVATE ${PLATFORM_CXX_DEFS})
    add_dependencies(${name} ${REMOTE_TARGET})

    message(STATUS "Configuring [${name}] remote at ${USER_REMOTE}")

    foreach (dep IN LISTS ARGN)
        message(STATUS "${name} include ${dep} at ${${dep}}")
        target_include_directories(${REMOTE_TARGET} PRIVATE ${${dep}})
        target_link_libraries(${REMOTE_TARGET} PRIVATE $<TARGET_OBJECTS:${dep}>)
        add_dependencies(${REMOTE_TARGET} ${dep})
        add_custom_command(TARGET ${name}
                           POST_BUILD
                           COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_OBJECTS:${dep}> ${CMAKE_BINARY_DIR}
                           COMMENT "Copy ${dep} object file $<TARGET_OBJECTS:${dep}> to ${CMAKE_BINARY_DIR} to be included in Remote User Module.")
    endforeach ()


    set(MAKE_ARGS
        PLATFORM=${PLATFORM}
        TARGET_DIR=${TARGET_DIR}
        GCC_ARM_PATH=${GCC_ARM_PATH}
        TARGET_DIR=${OUTPUT_PREFIX}
        TARGET_FILE=${name}
        USER_BUILD_DIR=${name}
        USER_REMOTE=${USER_REMOTE})

    add_custom_command(OUTPUT ${OUTPUT_PREFIX}/${name}.bin
                       COMMAND make
                       ARGS ${MAKE_ARGS}
                       DEPENDS ${SOURCE_FILES}
                       WORKING_DIRECTORY ${FIRMWARE_DIR}
                       COMMENT "Compile [${name}] as a Remote User Module for the ${PLATFORM} platform.")

    add_custom_command(TARGET ${name}
                       POST_BUILD
                       COMMAND cp ${USER_REMOTE}/*.o ${CMAKE_BINARY_DIR}
                       COMMENT "copying ${name} objs to root binary dir")

    configure_file(${CMAKE_SOURCE_DIR}/common/flash.mk.in ${CMAKE_BINARY_DIR}/${name}/flash.mk)

endfunction(add_particle_remote_app)
