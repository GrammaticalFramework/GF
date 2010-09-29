@echo off

set APPDIR=.
set GWT_DIR=C:\Program Files\eclipse\plugins\com.google.gwt.eclipse.sdkbundle.2.0.4_2.0.4.v201006301254\gwt-2.0.4
set GWT_CLASSPATH=%GWT_DIR%\gwt-user.jar;%GWT_DIR%\gwt-dev.jar

java %GWT_JAVA_OPTS% -Xmx256M -cp "%APPDIR%\src;%GWT_CLASSPATH%" com.google.gwt.dev.Compiler -war "%APPDIR%\www\editor" org.grammaticalframework.ui.gwt.EditorApp -style PRETTY
