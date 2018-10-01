#include <stdio.h>
#include <assert.h>
#include <stdlib.h>

/**
 * @brief compute Fibonacci sequence
 *
 * @param n sequence length
 * @details https://en.wikipedia.org/wiki/Fibonacci_number
 * @return the n'th term of Fibonacci sequence
 */
int fib(int n)
{
    if (n <= 1)
        return 1;
    else
        return fib(n - 1) + fib(n - 2);
}

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
