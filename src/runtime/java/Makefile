all:
	libtool --mode=compile gcc -I /usr/lib/jvm/java-6-openjdk/include -std=c99 -c jpgf.c
	libtool --mode=link gcc -g -O -o libjpgf.la jpgf.lo -rpath /usr/lib -lpgf -lgu 
	libtool --mode=install cp libjpgf.la /usr/lib/libjpgf.la

headers:
	javah org.grammaticalframework.PGF
