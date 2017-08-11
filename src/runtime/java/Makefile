C_SOURCES = jpgf.c jsg.c jni_utils.c
JAVA_SOURCES = $(wildcard org/grammaticalframework/pgf/*.java) \
               $(wildcard org/grammaticalframework/sg/*.java)

JNI_INCLUDES = $(if $(wildcard /usr/lib/jvm/default-java/include/.*), -I/usr/lib/jvm/default-java/include -I/usr/lib/jvm/default-java/include/linux, \
           $(if $(wildcard /System/Library/Frameworks/JavaVM.framework/Versions/A/Headers/.*), /System/Library/Frameworks/JavaVM.framework/Versions/A/Headers, \
           $(if $(wildcard /Library/Java/Home/include/.*), -I/Library/Java/Home/include/ -I/Library/Java/Home/include/darwin, \
           $(error No JNI headers found))))

INSTALL_PATH = /usr/local/lib
LIBTOOL = glibtool --tag=CC

LIBTOOL = $(if $(shell command -v glibtool 2>/dev/null), glibtool --tag=CC, libtool)

all: libjpgf.la jpgf.jar

libjpgf.la: $(patsubst %.c, %.lo, $(C_SOURCES))
	$(LIBTOOL) --mode=link gcc $(CFLAGS) -g -O -o libjpgf.la -shared $^ -rpath $(INSTALL_PATH) -lgu -lpgf -lsg

%.lo : %.c
	$(LIBTOOL) --mode=compile gcc $(CFLAGS) -g -O -c $(JNI_INCLUDES) -std=c99 -shared $< -o $@

jpgf.jar: $(patsubst %.java, %.class, $(JAVA_SOURCES))
	jar -cf $@ org/grammaticalframework/pgf/*.class org/grammaticalframework/sg/*.class

%.class : %.java
	javac $<

install: libjpgf.la jpgf.jar
	$(LIBTOOL) --mode=install install -s libjpgf.la $(INSTALL_PATH)
	install jpgf.jar $(INSTALL_PATH)


doc:
	javadoc org.grammaticalframework.pgf org.grammaticalframework.sg -d java-api

clean:
	rm -f *.lo
	rm -f *.la
	rm -f -r .libs
	rm -f *.jar
	rm -f org/grammaticalframework/*/*.class
