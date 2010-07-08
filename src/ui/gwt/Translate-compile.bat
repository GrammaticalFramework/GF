@echo off

set APPDIR=.
set GWT_DIR=c:\gwt-windows-1.5.2
set GWT_CLASSPATH="%GWT_DIR%\gwt-user.jar;%GWT_DIR%\gwt-dev-windows.jar"

set LIBS=%APPDIR%\lib\gwt-dnd-2.5.6.jar

java %GWT_JAVA_OPTS% -Xmx256M -cp "%APPDIR%\src;%APPDIR%\bin;%LIBS%;%GWT_CLASSPATH%" com.google.gwt.dev.GWTCompiler -out "%APPDIR%\www\translate" se.chalmers.cs.gf.gwt.TranslateApp
