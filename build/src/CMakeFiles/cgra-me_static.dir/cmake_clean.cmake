file(REMOVE_RECURSE
  "../lib/libcgra-me_static.a"
  "../lib/libcgra-me_static.pdb"
)

# Per-language clean rules from dependency scanning.
foreach(lang CXX)
  include(CMakeFiles/cgra-me_static.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
