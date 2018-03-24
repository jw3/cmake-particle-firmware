#
# copyright 2018 https://github.com/jw3
#

function(add_particle_app name)
    include(arm)

    set(OUTPUT_PREFIX ${CMAKE_BINARY_DIR}/${name})
    set(APP_DIR ${CMAKE_SOURCE_DIR}/${name})
    file(RELATIVE_PATH TARGET_DIR ${FIRMWARE_DIR}/main ${CMAKE_BINARY_DIR}/${name})

    add_custom_target(${name} ALL
                      DEPENDS ${OUTPUT_PREFIX}/${name}.bin)

    file(GLOB CPP_SOURCE ${APP_DIR}/*.cpp)

    set(REMOTE ${name}_remote)
    add_library(${REMOTE} STATIC ${CPP_SOURCE})
    target_compile_definitions(${REMOTE} PRIVATE ${ARM_DEFS})
    add_dependencies(${name} ${REMOTE})

    foreach (dep IN LISTS ARGN)
        set(APPLIBS ${APPLIBS} ${${dep}})
        target_include_directories(${REMOTE} PRIVATE ${${dep}})
        target_link_libraries(${REMOTE} PRIVATE $<TARGET_OBJECTS:${dep}>)
    endforeach ()

    set(MAKE_ARGS
        PLATFORM=${PLATFORM}
        TARGET_DIR=${TARGET_DIR}
        GCC_ARM_PATH=${GCC_ARM_PATH}
        APPDIR=${APP_DIR}
        USER_REMOTE=${OUTPUT_PREFIX}/CMakeFiles/${REMOTE}.dir)

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
