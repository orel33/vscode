enable_testing()

add_executable(test-mylib-foo test-mylib-foo.c)
target_link_libraries(test-mylib-foo mylib)

add_executable(test-mylib-bar test-mylib-bar.c)
target_link_libraries(test-mylib-bar mylib)

add_test(test1 test-mylib-foo)
set_tests_properties(test1 PROPERTIES PASS_REGULAR_EXPRESSION "foo")
add_test(test2 test-mylib-bar)
set_tests_properties(test2 PROPERTIES PASS_REGULAR_EXPRESSION "bar")

add_custom_target(check COMMAND ${CMAKE_CTEST_COMMAND})

