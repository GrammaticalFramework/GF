lib_LTLIBRARIES = libgu.la libpgf.la libsg.la

pkgconfigdir = $(libdir)/pkgconfig
pkgconfig_DATA = libgu.pc libpgf.pc libsg.pc

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
	gu/string.h \
	gu/sysdeps.h \
	gu/ucs.h \
	gu/utf8.h \
	gu/variant.h

pgfincludedir=$(includedir)/pgf
pgfinclude_HEADERS = \
	pgf/expr.h \
	pgf/linearizer.h \
	pgf/literals.h \
	pgf/graphviz.h \
	pgf/pgf.h \
	pgf/data.h

sgincludedir=$(includedir)/sg
sginclude_HEADERS = \
	sg/sg.h

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
	gu/string.c \
	gu/utf8.c \
	gu/ucs.c \
	gu/variant.c
libgu_la_LDFLAGS = -no-undefined

libpgf_la_SOURCES = \
	pgf/data.c \
	pgf/data.h \
	pgf/expr.c \
	pgf/expr.h \
	pgf/parser.c \
	pgf/lookup.c \
	pgf/jit.c \
	pgf/parseval.c \
	pgf/literals.c \
	pgf/literals.h \
	pgf/reader.h \
	pgf/reader.c \
	pgf/linearizer.c \
	pgf/typechecker.c \
	pgf/reasoner.c \
	pgf/evaluator.c \
	pgf/hopu.c \
	pgf/printer.c \
	pgf/graphviz.c \
	pgf/aligner.c \
	pgf/pgf.c \
	pgf/pgf.h \
libpgf_la_LDFLAGS = "-no-undefined"
libpgf_la_LIBADD = libgu.la

libsg_la_SOURCES = \
	sg/sqlite3Btree.c \
	sg/sg.c
libsg_la_LIBADD = libgu.la libpgf.la

bin_PROGRAMS =

AUTOMAKE_OPTIONS = foreign subdir-objects dist-bzip2
ACLOCAL_AMFLAGS = -I m4

EXTRA_DIST = \
	libgu.pc.in \
	libpgf.pc.in \
	libsg.pc.in
