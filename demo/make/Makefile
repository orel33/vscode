CC= gcc
CFLAGS= -std=c99 -Wall -I include

ALL: fib

fib: fib.o main.o
main.o: main.c include/fib.h
fib.o: fib.c include/fib.h

clean:
	rm -f *.o fib
