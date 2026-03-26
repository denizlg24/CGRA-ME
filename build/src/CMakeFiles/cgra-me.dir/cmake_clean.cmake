file(REMOVE_RECURSE
  "../lib/libcgra-me.dylib"
  "../lib/libcgra-me.pdb"
)

# Per-language clean rules from dependency scanning.
foreach(lang CXX)
  include(CMakeFiles/cgra-me.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
