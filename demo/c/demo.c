#include "demo.h"
#include <stdio.h>

void foo(int x)
{
    printf("foo: %d\n", x);
}

int bar(char *s)
{
    printf("bar: %s\n", s);
    return 0;
}