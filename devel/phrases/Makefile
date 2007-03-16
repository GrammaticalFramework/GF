GF_GRAMMAR_ABS = Travel
GF_GRAMMAR_ENG = $(GF_GRAMMAR_ABS)Eng
GF_GRAMMAR_THA = $(GF_GRAMMAR_ABS)Tha
GF_GRAMMAR_THP = $(GF_GRAMMAR_ABS)ThaiP
GF_GRAMMAR_CNC = $(GF_GRAMMAR_ABS)ThaiP $(GF_GRAMMAR_ABS)Tha $(GF_GRAMMAR_ABS)Eng
GF_GRAMMAR_CNC_FILES = $(addsuffix .gf, $(GF_GRAMMAR_CNC))
GF_GRAMMAR_FILES = $(addsuffix .gf, $(GF_GRAMMAR_ABS)) $(GF_GRAMMAR_CNC_FILES)
GEN_FILES = $(addsuffix .grxml,        $(GF_GRAMMAR_ENG)) \
            $(addsuffix .gram,         $(GF_GRAMMAR_ENG)) \
            $(addsuffix .jsgf,         $(GF_GRAMMAR_ENG)) \
            $(addsuffix .jsgf,         $(GF_GRAMMAR_THA)) \
            $(addsuffix .jsgf,         $(GF_GRAMMAR_THP)) \
            $(addsuffix .vxml,         $(GF_GRAMMAR_ENG)) \
            $(addsuffix .vxml-generic, $(GF_GRAMMAR_ENG)) \
            $(addsuffix .vxml-grxml,   $(GF_GRAMMAR_ENG)) \
            $(addsuffix .vxml-gram,    $(GF_GRAMMAR_ENG)) \
            $(addsuffix .vxml-jsgf,    $(GF_GRAMMAR_ENG)) \
            $(addsuffix .js,           $(GF_GRAMMAR_ABS))
SRG_FORMAT = gram

.PHONY: all clean

all: $(GEN_FILES)



%.grxml: %.gf
	echo "pg -printer=srgs_xml_sisr_old | wf $@" | gf -s -nocpu -batch $^
	tidy -q -xml -i -wrap 200 -m $@
# Work around tidy bug
	perl -i -pe 's/ lang=/ xml:lang=/' $@

%.gram: %.gf
	echo "pg -printer=srgs_abnf_sisr_old | wf $@" | gf -s -nocpu -batch $^

%.jsgf: %.gf
	echo "pg -printer=jsgf_sisr_old | wf $@" | gf -s -nocpu -batch $^

%.vxml: %.vxml-$(SRG_FORMAT)
	cp $^ $@

%.vxml-generic: %.gf
	echo 'pg -printer=vxml | wf $@' | gf -s -nocpu -batch $^
	tidy -q -xml -i -wrap 200 -m $@ 
# Work around tidy bug
	perl -i -pe 's/ lang=/ xml:lang=/' $@
# Work around Opera bug
	perl -i -pe "s/ src=\"#/ src=\"$*.vxml#/" $@

%.vxml-grxml: %.vxml-generic
	cp $^ $@

%.vxml-gram: %.vxml-generic
	cp $^ $@
	perl -i -pe 's/\.grxml/\.gram/' $@

%.vxml-jsgf: %.vxml-generic
	cp $^ $@
	perl -i -pe 's/\.grxml/\.jsgf/' $@
# Work around Opera for Zaurus bug 
	perl -i -pe 's/ src="(.*\.jsgf)#(\w+)"/ src="$$1" root="$$2"/' $@

$(GF_GRAMMAR_ABS).js: $(GF_GRAMMAR_FILES)
	echo "pm -printer=js | wf $@" | gf -s -nocpu -batch $(GF_GRAMMAR_CNC_FILES)

gflib.js: $(GF_LIB_PATH)/javascript/gflib.js
	cat $^ > $@

clean:
	-rm -f $(GEN_FILES)
	-rm -f *.gfc
