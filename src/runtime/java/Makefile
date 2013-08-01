all: libjpgf.la Test.class

install:
	libtool --mode=install cp libjpgf.la /usr/lib/libjpgf.la

doc:
	javadoc org.grammaticalframework.pgf

Test.class: Test.java
	javac Test.java

org/grammaticalframework/pgf/PGF.class: org/grammaticalframework/pgf/PGF.java
	javac Test.java

org/grammaticalframework/pgf/Concr.class: org/grammaticalframework/pgf/Concr.java
	javac Test.java

libjpgf.la: jpgf.lo
	libtool --mode=link gcc -g -O -o libjpgf.la jpgf.lo -rpath /usr/lib -lpgf -lgu

jpgf.lo: jpgf.c org_grammaticalframework_pgf_PGF.h org_grammaticalframework_pgf_Concr.h
	libtool --mode=compile gcc -I /usr/lib/jvm/java-6-openjdk/include -std=c99 -c jpgf.c

org_grammaticalframework_pgf_PGF.h: org/grammaticalframework/pgf/PGF.class
	javah org.grammaticalframework.pgf.PGF

org_grammaticalframework_pgf_Concr.h: org/grammaticalframework/pgf/Concr.class
	javah org.grammaticalframework.pgf.Concr
