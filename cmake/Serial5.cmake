function(visit target)
    message("======> Serial5 visiting ${target}")
    target_include_directories(${target} PRIVATE ${FIRMWARE_DIR}/user/libraries)
endfunction()
