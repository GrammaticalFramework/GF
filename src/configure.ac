dnl Run autoconf to generate configure from this file

AC_INIT([GF],[2.1],[aarne@cs.chalmers.se],[GF])

AC_PREREQ(2.53)

AC_REVISION($Revision: 1.10 $)

AC_CONFIG_FILES([config.mk jgf])

AC_CANONICAL_HOST


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
dnl javac
dnl ***********************************************

AC_ARG_WITH(javac,
  AC_HELP_STRING([--with-javac=<javac command>],
               [Use a different command instead of
                'javac' for the Java compiler.]),
  [AC_CHECK_FILE("$withval",JAVAC="$withval",[AC_PATH_PROG(JAVAC,"$withval")])],
  [AC_PATH_PROG(JAVAC,javac)])

AC_SUBST(JAVAC)

dnl ***********************************************
dnl jar
dnl ***********************************************

AC_ARG_WITH(jar,
  AC_HELP_STRING([--with-jar=<jar command>],
               [Use a different command instead of
                'jar' for the Java archive tool.]),
  [AC_CHECK_FILE("$withval",JAR="$withval",[AC_PATH_PROG(JAR,"$withval")])],
  [AC_PATH_PROG(JAR,jar)])

AC_SUBST(JAR)

dnl ***********************************************
dnl java
dnl ***********************************************

AC_ARG_WITH(java,
  AC_HELP_STRING([--with-java=<java command>],
               [Use a different command instead of
                'java' for the Java Virtual Machine.]),
  [AC_CHECK_FILE("$withval",JAVA="$withval",[AC_PATH_PROG(JAVA,"$withval")])],
  [AC_PATH_PROG(JAVA,java)])

AC_SUBST(JAVA)

dnl ***********************************************
dnl Other programs
dnl ***********************************************

AC_PROG_INSTALL

dnl ***********************************************
dnl Program flags
dnl ***********************************************

AC_SUBST(CPPFLAGS)
AC_SUBST(LDFLAGS)

dnl ***********************************************
dnl Output
dnl ***********************************************

AC_OUTPUT

