CC=gcc
CFLAGS=-std=c99 -O3 -Wall `pkg-config --cflags sdl2 sdl2_image sdl2_ttf`
LDFLAGS=-rdynamic -lm `pkg-config --libs sdl2 sdl2_image sdl2_ttf`

ALL: mandel

mandel: mandel.o

clean:
	rm -f *~ *.o mandel
