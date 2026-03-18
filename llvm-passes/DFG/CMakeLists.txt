SET( CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} -fno-rtti" )

add_library(DFG MODULE DFGGeneration.cpp)

target_link_libraries(
  DFG
  PRIVATE cgra-me
  )

if(APPLE)
  # On macOS, LLVM pass plugins are loaded by opt which provides the symbols.
  # Allow undefined symbols at link time (matching Linux's default behavior).
  target_link_options(DFG PRIVATE -undefined dynamic_lookup)
endif()

configure_file(LoopParser.py ${CMAKE_BINARY_DIR}/script/LoopParser.py COPYONLY)

