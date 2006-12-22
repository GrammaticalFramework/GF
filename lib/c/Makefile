CC = gcc
CFLAGS += -O2 -W -Wall

.PHONY: all clean

all: libgfcc.a

libgfcc.a: gfcc-tree.o gfcc-term.o 
	ar r $@ $^

gfcc-tree.o: gfcc-tree.c gfcc-tree.h
	$(CC) $(CFLAGS) -c -o $@ $<

gfcc-term.o: gfcc-term.c gfcc-term.h
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	-rm -f libgfcc.a
	-rm -f *.o
