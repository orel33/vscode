add_library(mylib mylib.c)
install(TARGETS mylib ARCHIVE DESTINATION lib)
install(FILES mylib.h DESTINATION include)
