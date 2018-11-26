CC=gcc
CFLAGS=-std=c99 -O3 -Wall -I/usr/include/SDL2
LDFLAGS=-rdynamic -lm -lSDL2 -lSDL2_ttf -lSDL2_image

ALL: mandel

mandel: mandel.o

clean:
	rm -f *~ *.o mandel
