
GFDIR=../../../../../

LIBGFCC_INCLUDES = $(GFDIR)/lib/c
LIBGFCC_LIBDIR = $(GFDIR)/lib/c

GFCC2C = $(GFDIR)/bin/gfcc2c

TEST_PROG = bronzeage-test

GRAMMAR_DIR = $(GFDIR)/examples/bronzeage

GRAMMAR_MODULES = Bronzeage BronzeageEng BronzeageSwe

GRAMMAR_H_FILES = $(addsuffix .h, $(GRAMMAR_MODULES))
GRAMMAR_C_FILES = $(addsuffix .c, $(GRAMMAR_MODULES))
GRAMMAR_O_FILES = $(addsuffix .o, $(GRAMMAR_MODULES))

CFLAGS += -O2
CPPFLAGS += -I$(LIBGFCC_INCLUDES)

.PHONY: clean

all: bronzeage.gfcc $(TEST_PROG)

$(TEST_PROG): $(GRAMMAR_O_FILES) $(TEST_PROG).o $(LIBGFCC_LIBDIR)/libgfcc.a	

$(TEST_PROG).o: $(GRAMMAR_H_FILES) $(GRAMMAR_O_FILES) $(TEST_PROG).c

$(GRAMMAR_H_FILES) $(GRAMMAR_C_FILES): $(GFCC2C) bronzeage.gfcc
	$(GFCC2C) bronzeage.gfcc

bronzeage.gfcc:
	echo "i -optimize=all $(GRAMMAR_DIR)/BronzeageEng.gf" > mkBronzeage.gfs
	echo "i -optimize=all $(GRAMMAR_DIR)/BronzeageSwe.gf" >> mkBronzeage.gfs
	echo "s" >> mkBronzeage.gfs
	echo "pm -printer=gfcc | wf bronzeage.gfcc" >> mkBronzeage.gfs
	cat mkBronzeage.gfs | gf
	rm -f mkBronzeage.gfs

clean:
	-rm -f $(TEST_PROG) *.o


distclean: clean
	-rm -f $(GRAMMAR_H_FILES) $(GRAMMAR_C_FILES)
	-rm -f bronzeage.gfcc
