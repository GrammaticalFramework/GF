
LDADD = libgu.la

lib_LTLIBRARIES = libgu.la libpgf.la libteyjus.la

pkgconfigdir = $(libdir)/pkgconfig
pkgconfig_DATA = libgu.pc libpgf.pc libteyjus.pc

configincludedir = $(libdir)/libgu/include

guincludedir=$(includedir)/gu
guinclude_HEADERS = \
	gu/assert.h \
	gu/bits.h \
	gu/choice.h \
	gu/defs.h \
	gu/enum.h \
	gu/exn.h \
	gu/file.h \
	gu/fun.h \
	gu/hash.h \
	gu/in.h \
	gu/map.h \
	gu/mem.h \
	gu/out.h \
	gu/prime.h \
	gu/seq.h \
	gu/str.h \
	gu/string.h \
	gu/sysdeps.h \
	gu/type.h \
	gu/ucs.h \
	gu/utf8.h \
	gu/variant.h

pgfincludedir=$(includedir)/pgf
pgfinclude_HEADERS = \
	pgf/expr.h \
	pgf/reader.h \
	pgf/linearizer.h \
	pgf/parser.h \
	pgf/lexer.h \
	pgf/literals.h \
	pgf/graphviz.h \
	pgf/pgf.h

libgu_la_SOURCES = \
	gu/assert.c \
	gu/bits.c \
	gu/choice.c \
	gu/defs.c \
	gu/seq.c \
	gu/enum.c \
	gu/exn.c \
	gu/file.c \
	gu/fun.c \
	gu/hash.c \
	gu/in.c \
	gu/map.c \
	gu/mem.c \
	gu/out.c \
	gu/prime.c \
	gu/str.c \
	gu/string.c \
	gu/type.c \
	gu/utf8.c \
	gu/ucs.c \
	gu/variant.c

libteyjus_la_SOURCES = \
	teyjus/simulator/abstmachine.c \
	teyjus/simulator/dataformats.c \
	teyjus/simulator/hnorm.c \
	teyjus/simulator/hnormlocal.c \
	teyjus/simulator/hopu.c \
	teyjus/simulator/io-datastructures.c \
	teyjus/simulator/mcstring.c \
	teyjus/simulator/printterm.c \
	teyjus/simulator/simdispatch.c \
	teyjus/simulator/siminit.c \
	teyjus/simulator/siminstr.c \
	teyjus/simulator/siminstrlocal.c \
	teyjus/simulator/simulator.c \
	teyjus/simulator/trail.c \
	teyjus/simulator/types.c

libpgf_la_SOURCES = \
	pgf/data.c \
	pgf/data.h \
	pgf/edsl.h \
	pgf/expr.c \
	pgf/expr.h \
	pgf/parser.c \
	pgf/parser.h \
	pgf/jit.c \
	pgf/parseval.c \
	pgf/lexer.c \
	pgf/lexer.h \
	pgf/literals.c \
	pgf/literals.h \
	pgf/reader.h \
	pgf/reader.c \
	pgf/linearizer.c \
	pgf/reasoner.c \
	pgf/printer.c \
	pgf/graphviz.c \
	pgf/pgf.c \
	pgf/pgf.h

bin_PROGRAMS = \
	utils/pgf-print \
	utils/pgf-translate \
	utils/pgf-parse 

utils_pgf_print_SOURCES = utils/pgf-print.c
utils_pgf_print_LDADD = libpgf.la libgu.la 

utils_pgf_translate_SOURCES = utils/pgf-translate.c
utils_pgf_translate_LDADD = libpgf.la libgu.la

utils_pgf_parse_SOURCES = utils/pgf-parse.c
utils_pgf_parse_LDADD = libpgf.la libgu.la

AUTOMAKE_OPTIONS = foreign subdir-objects dist-bzip2
ACLOCAL_AMFLAGS = -I m4
include doxygen.am

EXTRA_DIST = \
	Doxyfile \
	DoxygenLayout.xml \
	libgu.pc.in \
	libteyjus.pc.in \
	libpgf.pc.in
