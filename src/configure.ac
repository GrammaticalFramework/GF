dnl Run autoconf to generate configure from this file

AC_INIT([GF],[2.0],[dp03-7@mdstud.chalmers.se],[GF])

AC_PREREQ(2.53)

AC_REVISION($Revision: 1.1 $)

AC_CONFIG_FILES([config.mk])

AC_CANONICAL_SYSTEM


dnl ***********************************************
dnl GHC
dnl ***********************************************

AC_ARG_WITH(ghc,
  AC_HELP_STRING([--with-ghc=<ghc command>],
               [Use a different command instead of
                'ghc' for the Haskell compiler.]),
  [AC_CHECK_FILE("$withval",GHC="$withval",[AC_PATH_PROG(GHC,"$withval")])],
  [AC_PATH_PROG(GHC,ghc)])

GHCI=$(dirname $GHC)/ghci

AC_SUBST(GHC)
AC_SUBST(GHCI)

dnl ***********************************************
dnl Other programs
dnl ***********************************************

AC_PROG_INSTALL

dnl ***********************************************
dnl Output
dnl ***********************************************

AC_OUTPUT

