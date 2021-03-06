if(NOT CMAKE_Fortran_COMPILER)
  message(FATAL_ERROR "Must have invoked Fortran before including compilers.cmake")
endif()

if(CMAKE_Fortran_COMPILER_ID STREQUAL Intel)
  set(CMAKE_Fortran_FLAGS $<IF:WIN32,"/stand:f18 /traceback /warn /heap-arrays ","-stand f18 -traceback -warn -heap-arrays ">)

  if(CMAKE_BUILD_TYPE STREQUAL Debug)
    string(APPEND CMAKE_Fortran_FLAGS $<IF:WIN32,"/debug /check:all ","-debug extended -check all ">)
  endif()
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL GNU)
  if(CMAKE_Fortran_COMPILER_VERSION VERSION_GREATER_EQUAL 8)
    set(CMAKE_Fortran_FLAGS "-std=f2018 ")
  endif()
  string(APPEND CMAKE_Fortran_FLAGS "-march=native -Wall -Wextra -fimplicit-none ")

  if(CMAKE_BUILD_TYPE STREQUAL Debug)
    string(APPEND CMAKE_Fortran_FLAGS "-Werror=array-bounds -fcheck=all ")
  endif()
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL PGI)
  set(CMAKE_Fortran_FLAGS "-C -Mdclchk ")
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL NAG)
  # https://www.nag.co.uk/nagware/np/r70_doc/manual/compiler_2_4.html#OPTIONS
  set(CMAKE_Fortran_FLAGS "-f2018 -C -colour -gline -nan -info -u ")
endif()

include(CheckCSourceCompiles)
include(CheckCSourceRuns)
include(CheckFortranSourceCompiles)

include(${CMAKE_CURRENT_LIST_DIR}/f08block.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/f08contig.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/f18errorstop.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/f18random.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/f18assumed_rank.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/f08kind.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/f18prop.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/f08command.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/f03ieee.cmake)
