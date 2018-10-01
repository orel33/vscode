cmake_minimum_required (VERSION 2.6)

set (SRC fib.c)
set (EXE main)

project (Fibo)
add_compile_options(-g -O0 --coverage)
add_executable(${EXE} ${EXE}.c ${SRC})
target_link_libraries(${EXE} --coverage)
enable_testing()
add_test(${EXE} ${EXE})