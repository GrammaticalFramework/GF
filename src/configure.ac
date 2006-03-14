dnl Run autoconf to generate configure from this file

AC_INIT([GF],[2.4],[aarne@cs.chalmers.se],[GF])

AC_PREREQ(2.53)

AC_REVISION($Revision: 1.26 $)

AC_CONFIG_FILES([config.mk jgf gfeditor])

AC_CANONICAL_HOST

dnl ***********************************************
dnl Executable suffix
dnl ***********************************************


AC_MSG_CHECKING([executable suffix])
case $host_os in
      cygwin)
          EXEEXT='.exe';;
      *)  
	  EXEEXT='';;
esac
AC_MSG_RESULT(['$EXEEXT'])
AC_SUBST(EXEEXT)

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

GHC_VERSION=`$GHC --version | sed -e 's/.*version //'`
AC_MSG_CHECKING([GHC version])
AC_MSG_RESULT($GHC_VERSION)


AC_SUBST(GHC)
AC_SUBST(GHCI)

dnl ***********************************************
dnl readline
dnl ***********************************************

AC_ARG_WITH(readline,
  AC_HELP_STRING([--with-readline=<readline alternative>],
               [Select which readline implementation to use. 
	        Available alternatives are: 'readline' (GNU readline),
                'no' (don't use readline)
                (default = readline)]),
  [if test "$withval" = "yes"; then
     READLINE="readline"
   else
     READLINE="$withval"
   fi],
  [if test "$GHC_VERSION" = "6.4" && test "$host_os" = "cygwin"; then
     AC_MSG_WARN([There are problems with readline on 6.4 for Windows, 
                    disabling readline support. 
                    Use --with-readline to override.])
     READLINE="no"
   else
     READLINE="readline"
   fi])

case $READLINE in
    readline)
        ;;
    no)
        ;;
    *)
        AC_MSG_ERROR([Bad value for --with-readline: $READLINE])
        ;;
esac

AC_SUBST(READLINE)

dnl ***********************************************
dnl command interruption
dnl ***********************************************

AC_ARG_WITH(interrupt,
  AC_HELP_STRING([--with-interrupt=<allow command interruption>],
               [Choose whether to enable interruption of commands
	        with SIGINT (Ctrl-C)
	        Available alternatives are: 'yes', 'no'
		(default = yes)]),
  [INTERRUPT="$withval"],
  [if test "$host_os" = "cygwin"; then
     AC_MSG_WARN([Command interruption does not work under
                  Cygwin, because of missing signal handler support.
                  Disabling command interruption support. 
                  Use --with-interrupt to override.])
     INTERRUPT="no"
   else
     INTERRUPT="yes"
   fi])

case $INTERRUPT in
    yes)
        ;;
    no)
        ;;
    *)
        AC_MSG_ERROR([Bad value for --with-interrupt: $INTERRUPT])
        ;;
esac

AC_SUBST(INTERRUPT)

dnl ***********************************************
dnl ATK speech recognition
dnl ***********************************************

AC_ARG_WITH(atk,
  AC_HELP_STRING([--with-atk=<use ATK speech recognition>],
               [Choose whether to compile in support for speech
	        recognition using ATK. Requires ATK and libatkrec.
	        Available alternatives are: 'yes', 'no'
		(default = no)]),
  [ATK="$withval"],
  [ATK="no"])

case $ATK in
    yes)
        AC_MSG_CHECKING([for atkrec package])
	ATKREC_VERSION=`ghc-pkg field atkrec version`
	if test "$ATKREC_VERSION" = ""; then
	    AC_MSG_RESULT(['not found'])
            AC_MSG_WARN([Disabling ATK support.])
	    ATK="no"
        else
	    AC_MSG_RESULT([$ATKREC_VERSION])
        fi
        ;;
    no)
        ;;
    *)
        AC_MSG_ERROR([Bad value for --with-atk: $ATK])

        ;;
esac

AC_SUBST(ATK)

dnl ***********************************************
dnl java stuff
dnl ***********************************************

AC_ARG_ENABLE(java,
AC_HELP_STRING([--enable-java],
	       [Build Java components. (default = yes)]),
[ENABLE_JAVA="$enableval"],
[ENABLE_JAVA=yes]
)

if test "$ENABLE_JAVA" = "yes"; then

  AC_ARG_WITH(javac,
    AC_HELP_STRING([--with-javac=<javac command>],
                   [Use a different command instead of
                    'javac' for the Java compiler.]),
    [AC_CHECK_FILE("$withval",JAVAC="$withval",[AC_PATH_PROG(JAVAC,"$withval")])],
    [AC_PATH_PROG(JAVAC,javac)])
  AC_SUBST(JAVAC)

  AC_ARG_WITH(java,
    AC_HELP_STRING([--with-java=<java command>],
                   [Use a different command instead of
                    'java' for the Java Virtual Machine.]),
    [AC_CHECK_FILE("$withval",JAVA="$withval",[AC_PATH_PROG(JAVA,"$withval")])],
    [AC_PATH_PROG(JAVA,java)])
  AC_SUBST(JAVA)

  AC_ARG_WITH(jar,
    AC_HELP_STRING([--with-jar=<jar command>],
                   [Use a different command instead of
                    'jar' for the Java archive tool.]),
    [AC_CHECK_FILE("$withval",JAR="$withval",[AC_PATH_PROG(JAR,"$withval")])],
    [AC_PATH_PROG(JAR,jar)])
  AC_SUBST(JAR)

  if test "$JAVAC" = "" || test ! -x "$JAVAC" \
     || test "$JAVA" = ""  || test ! -x "$JAVA" \
     || test "$JAR" = ""   || test ! -x "$JAR"; then

    AC_MSG_WARN([Not building Java components.])
    ENABLE_JAVA=no
  fi

fi

AC_SUBST(ENABLE_JAVA)


dnl ***********************************************
dnl TAR
dnl ***********************************************

AC_CHECK_PROGS(TAR, gtar tar)

dnl ***********************************************
dnl Other programs
dnl ***********************************************

AC_PROG_INSTALL

dnl ***********************************************
dnl Program flags
dnl ***********************************************

AC_SUBST(GHCFLAGS)
AC_SUBST(CPPFLAGS)
AC_SUBST(LDFLAGS)

dnl ***********************************************
dnl Output
dnl ***********************************************

AC_OUTPUT

