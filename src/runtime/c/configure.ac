AC_INIT(Portable Grammar Format library, 0.1.pre, 
		 https://code.google.com/p/grammatical-framework/, 
		 libpgf)
AC_PREREQ(2.58)

AC_CONFIG_SRCDIR([gu/mem.c])
AC_CONFIG_AUX_DIR([scripts])
AC_CONFIG_MACRO_DIR([m4])

AM_INIT_AUTOMAKE([1.7.9])
m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])

PKG_PROG_PKG_CONFIG

AC_CONFIG_HEADERS([config.h])

AM_MAINTAINER_MODE([enable])
AC_CHECK_LIB(m,nan)
AC_PROG_MAKE_SET
AC_PROG_INSTALL
AC_PROG_LIBTOOL
AC_PROG_CC
AC_PROG_CC_C99
AM_PROG_CC_C_O

[if [ "x$GCC" = "xyes" ]; then
  CFLAGS="$CFLAGS\
 -Wall\
 -Wextra\
 -Wno-missing-field-initializers\
 -Wno-unused-parameter"
fi]


AC_C_ALIGNOF
AC_C_FAM_IN_MEM
AC_C_STATEMENT_EXPRESSIONS
AC_C_ASCII

dnl Doxygen support
DX_PS_FEATURE(OFF)	
DX_PDF_FEATURE(OFF)	
AC_DEFUN([DX_FEATURE_dev],   OFF)
DX_ARG_ABLE(dev, [include internal development documentation],
            [],
            [],
	    [],
	    [DX_ENV_APPEND(DEVDOC, YES)]
	    [DX_ENV_APPEND(INPUT, $srcdir)],
	    [DX_ENV_APPEND(DEVDOC, NO)
	     DX_ENV_APPEND(INPUT, 
	     [\$(guinclude_HEADERS) \$(pgfinclude_HEADERS)])])
DX_INIT_DOXYGEN(libpgf)


AC_CONFIG_FILES([Makefile
	         libgu.pc
		 libpgf.pc
		 libteyjus.pc
		 ])

AC_OUTPUT
