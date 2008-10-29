GFCFLAGS = +RTS -K100M -RTS --cpu

.PHONY: pgf.fcgi run gwt gf-gwt.jar

pgf.fcgi: 
	cabal install
	cp dist/build/pgf.fcgi/pgf.fcgi .

gwt:
	chmod a+x gwt/Translate-compile
	gwt/Translate-compile

gf-gwt.jar:
	mkdir -p gwt/bin/se/chalmers/cs/gf/gwt/client
	javac -classpath $(GWT_CLASSPATH) -sourcepath gwt/src -d gwt/bin gwt/src/se/chalmers/cs/gf/gwt/client/*.java
	jar -cf $@ -C gwt/src se
	jar -uf $@ -C gwt/bin se
	cp $@ ../../lib/java

food.pgf:
	gfc --make --name=food ../../examples/tutorial/food/Food{Eng,Ita}.gf

Demo%-parse.pgf: ../../lib/resource/demo/Demo%.gf
	gfc $(GFCFLAGS) --make --erasing=on --name=Demo$*-parse $^

Demo%-noparse.pgf: ../../lib/resource/demo/Demo%.gf
	gfc $(GFCFLAGS) --make --parser=off --name=Demo$*-noparse $^

Lang%-parse.pgf: ../../lib/alltenses/Lang%.gfo
	gfc $(GFCFLAGS) --make --erasing=on --name=Lang$*-parse $^

Lang%-noparse.pgf: ../../lib/alltenses/Lang%.gfo
	gfc $(GFCFLAGS) --make --parser=off --name=Lang$*-noparse $^

demo.pgf: DemoBul-noparse.pgf DemoCat-noparse.pgf DemoDan-noparse.pgf DemoEng-parse.pgf DemoFin-noparse.pgf DemoFre-noparse.pgf DemoGer-noparse.pgf DemoIta-noparse.pgf DemoNor-noparse.pgf DemoRus-noparse.pgf DemoSpa-noparse.pgf DemoSwe-parse.pgf
	gfc $(GFCFLAGS) --name=demo $^

lang.pgf: LangBul-noparse.pgf LangCat-noparse.pgf LangDan-parse.pgf LangEng-parse.pgf LangFin-noparse.pgf LangFre-noparse.pgf LangGer-noparse.pgf LangIta-noparse.pgf LangNor-parse.pgf LangRus-noparse.pgf LangSpa-noparse.pgf LangSwe-parse.pgf
	gfc $(GFCFLAGS) --name=lang $^

test.pgf: LangEng-parse.pgf LangGer-parse.pgf
	gfc $(GFCFLAGS) --name=test $^

run: pgf.fcgi
	@echo '*********************************************'
	@echo 'See http://localhost:41296/gwt/www/se.chalmers.cs.gf.gwt.TranslateApp/Translate.html'
	@echo '*********************************************'
	lighttpd -f lighttpd.conf -D

clean:
	cabal clean
	-rm -f pgf.fcgi