CC=gcc
CFLAGS=-std=c99 -O3 -Wall `pkg-config --cflags sdl2`
LDFLAGS=-rdynamic -lm `pkg-config --libs sdl2`

ALL: mandel

mandel: mandel.o

clean:
	rm -f *~ *.o mandel
