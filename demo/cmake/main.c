#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include "fib.h"

int main(int argc, char const *argv[])
{
    int n = 10;
    if (argc == 2)
        n = atoi(argv[1]);
    assert(n > 0);
    int sum = fib(n);
    printf("%d\n", sum);
    return 0;
}
