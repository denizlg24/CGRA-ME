include(ProcessorCount)
ProcessorCount(CORE_NUMBER)
if(NOT CORE_NUMBER EQUAL 0)
    SET(SCIP_MAKE_FLAG -j${CORE_NUMBER})
endif()

set(SCIP_LIB_DIR ${CMAKE_CURRENT_SOURCE_DIR}/lib)

# SCIP's own build system always generates .so, even on macOS
add_custom_target(scipoptsuite
    COMMAND make scipoptlib SHARED=true ZLIB=false GMP=false READLINE=false ${SCIP_MAKE_FLAG}
    COMMAND ${CMAKE_COMMAND} -E create_symlink
        ${SCIP_LIB_DIR}/libscipopt.so
        ${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/libscipopt.so
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
)

# On macOS, fix the SCIP library's install name so binaries can find it via rpath
if(APPLE)
    add_custom_command(TARGET scipoptsuite POST_BUILD
        COMMAND ${CMAKE_COMMAND}
            -DSCIP_LIB_DIR=${SCIP_LIB_DIR}
            -P ${CMAKE_CURRENT_SOURCE_DIR}/fix_scip_rpath.cmake
        COMMENT "Fixing SCIP library install names for macOS"
    )
endif()

add_library(scip INTERFACE)

target_link_libraries(
    scip
    INTERFACE ${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/libscipopt.so
)
