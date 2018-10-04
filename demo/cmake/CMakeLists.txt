cmake_minimum_required(VERSION 2.6)
project(Fibonacci C)

### build ###

set(CMAKE_C_FLAGS "-std=c99 -Wall")
add_library(fib fib.c fib.h)
add_executable(main  main.c)
target_link_libraries(main fib)

### tests ###

include(CTest)
enable_testing()

set(args "1" "5" "10" "20")
set(sols "1" "8" "89" "10946")
set(args_sols args sols)
set(len 3)

foreach(i RANGE ${len})
  list(GET args ${i} arg)
  list(GET sols ${i} sol)
  add_test(fib-${arg} ./main ${arg})
  set_tests_properties(fib-${arg} PROPERTIES PASS_REGULAR_EXPRESSION "${sol}" TIMEOUT 3)
endforeach()
