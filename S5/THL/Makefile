CC=gcc
CFLAGS=-std=c99 -pedantic

all:
	flex -o output.c calc.l
	$(CC) $(CFLAGS) -o output output.c
	./output

clean:
	rm -f output*
