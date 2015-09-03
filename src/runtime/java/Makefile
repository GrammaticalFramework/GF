C_SOURCES = jpgf.c jsg.c jni_utils.c
JAVA_SOURCES = $(wildcard org/grammaticalframework/pgf/*.java) \
               $(wildcard org/grammaticalframework/sg/*.java)

JNI_PATH = /usr/lib/jvm/default-java/include
INSTALL_PATH = /usr/local/lib

all: libjpgf.la jpgf.jar

libjpgf.la: $(patsubst %.c, %.lo, $(C_SOURCES))
	libtool --mode=link gcc -g -O -o libjpgf.la -shared $^ -rpath $(INSTALL_PATH) -lgu -lpgf -lsg

%.lo : %.c
	libtool --mode=compile gcc -g -O -c -I$(JNI_PATH) -std=c99 -shared $< -o $@

jpgf.jar: $(patsubst %.java, %.class, $(JAVA_SOURCES))
	jar -cf $@ $^

%.class : %.java
	javac $<

install: libjpgf.la jpgf.jar
	libtool --mode=install install -s libjpgf.la $(INSTALL_PATH)

clean:
	rm -f *.lo
	rm -f *.la
	rm -f -r .libs
	rm -f *.jar
	rm -f org/grammaticalframework/*/*.class
