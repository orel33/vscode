import sys

def fib(n):
    if n <= 1:
        return 1
    else:
        return fib(n - 1) + fib(n - 2)


n = 10
if len(sys.argv) == 2:
    n = int(sys.argv[1])
assert(n > 0)
sum = fib(n)
print(sum)
