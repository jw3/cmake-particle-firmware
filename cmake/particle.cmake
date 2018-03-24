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
    include(arm)

    set(APP_DIR ${CMAKE_SOURCE_DIR}/${name})
    file(RELATIVE_PATH TARGET_DIR ${FIRMWARE_DIR}/main ${CMAKE_BINARY_DIR}/${name})

    add_custom_target(${name} ALL
                      DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/${name}.bin)

    file(GLOB SOURCE_FILES ${APP_DIR}/*.cpp)

    set(REMOTE_TARGET ${name}_remote)
    set(USER_REMOTE ${CMAKE_CURRENT_BINARY_DIR}/CMakeFiles/${REMOTE_TARGET}.dir/${name})
    add_library(${REMOTE_TARGET} STATIC ${SOURCE_FILES})
    target_compile_definitions(${REMOTE_TARGET} PRIVATE ${ARM_DEFS})
    add_dependencies(${name} ${REMOTE_TARGET})

    message(STATUS "Configuring [${name}] remote at ${USER_REMOTE}")

    foreach (dep IN LISTS ARGN)
        set(APPLIBS ${APPLIBS} ${${dep}})
        target_include_directories(${REMOTE_TARGET} PRIVATE ${${dep}})
        target_link_libraries(${REMOTE_TARGET} PRIVATE $<TARGET_OBJECTS:${dep}>)
        add_dependencies(${REMOTE_TARGET} ${dep})
        add_custom_command(TARGET ${name}
                           POST_BUILD
                           COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_OBJECTS:${dep}> ${CMAKE_BINARY_DIR})
    endforeach ()


    set(MAKE_ARGS
        PLATFORM=${PLATFORM}
        TARGET_DIR=${TARGET_DIR}
        GCC_ARM_PATH=${GCC_ARM_PATH}
        APPDIR=${APP_DIR}
        USER_REMOTE=${CMAKE_BINARY_DIR})

    if (APPLIBS)
        set(MAKE_ARGS ${MAKE_ARGS} APPLIBSV1=${APPLIBS})
    endif ()

    add_custom_command(OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${name}.bin
                       COMMAND make
                       ARGS ${MAKE_ARGS}
                       DEPENDS ${SOURCE_FILES}
                       WORKING_DIRECTORY ${FIRMWARE_DIR}
                       COMMENT "Compile app [${name}] for the ${PLATFORM} platform.")

    add_custom_command(TARGET ${name}
                       POST_BUILD
                       COMMAND cp ${USER_REMOTE}/*.o ${CMAKE_BINARY_DIR}
                       COMMENT "copying ${name} objs to root binary dir")

    configure_file(${CMAKE_SOURCE_DIR}/common/flash.mk.in ${CMAKE_BINARY_DIR}/${name}/flash.mk)

endfunction(add_particle_remote_app)
