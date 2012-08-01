all: instrformats/gen pervasives/gen
	(cd instrformats; ./gen)
	(cd pervasives; ./gen)

instrformats/gen: instrformats/y.tab.o instrformats/lex.yy.o \
                  instrformats/instrgen-c.o instrformats/instrgen-haskell.o \
                  util/util.o
	gcc -o instrformats/gen $^ -lm 

pervasives/gen: pervasives/y.tab.o pervasives/lex.yy.o \
                pervasives/ccode.o pervasives/ocamlcode.o \
                pervasives/pervgen-c.o pervasives/pervgen-ocaml.o \
                pervasives/types.o pervasives/op.o \
                util/util.o
	gcc -o pervasives/gen $^

.o : .c
	gcc -c -o $@ $^

instrformats/y.tab.c instrformats/y.tab.h : instrformats/instrformats.y
	yacc -o instrformats/y.tab.c --defines=instrformats/y.tab.h instrformats/instrformats.y 

instrformats/lex.yy.c : instrformats/instrformats.l instrformats/y.tab.h
	flex -o instrformats/lex.yy.c instrformats/instrformats.l

pervasives/y.tab.c pervasives/y.tab.h : pervasives/pervasives.y
	yacc -o pervasives/y.tab.c --defines=pervasives/y.tab.h pervasives/pervasives.y 

pervasives/lex.yy.c : pervasives/pervasives.l pervasives/y.tab.h
	flex -o pervasives/lex.yy.c pervasives/pervasives.l
