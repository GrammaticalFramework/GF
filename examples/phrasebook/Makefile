compile = runghc Compile 

forApp: 
	$(compile) -opt Bul Cat Chi Dut Eng Est Fin Fre Ger Hin Ita Jpn Rus Spa Swe Tha Urd
	make gfos

.PHONY: gfos

Chi:
	$(compile) Chi

all: demo missing gfos

gfos:
	mkdir -p gfos && cp -p *.gfo gfos

thaidroid: #thaiscript
	cp -p Phrasebook.pgf FullPhrasebook.pgf
	$(compile) -opt Eng Swe Tha Thb DisambPhrasebookEng
	$(compile) -link Eng Fin Swe Tha Thb DisambPhrasebookEng
	mv Phrasebook.pgf Thaidroid.pgf
	mv FullPhrasebook.pgf Phrasebook.pgf

thaiscript:
	runghc ../../lib/src/thai/ThaiScript.hs

demo: compdemo fin linkdemo

compdemo:
	$(compile) -opt Bul Cat Chi Dan Dut Eng Fre Ger Hin Ita Jpn Lav Nor Pes Pol Ron Rus Spa Swe Tha Urd DisambPhrasebookEng

linkdemo:
	$(compile) -link Eng Bul Cat Chi Dan Dut Fin Fre Ger Hin Ita Jpn Lav Nor Pes Pol Ron Rus Spa Swe Tha Urd DisambPhrasebookEng

linkdemothb:
	$(compile) -link Eng Bul Cat Chi Dan Dut Fin Fre Ger Ita Jpn Nor Pol Ron Rus Spa Swe Tha Thb Urd DisambPhrasebookEng 

#separate, because slow...
fin:
	$(compile) -opt Fin

missing:
	echo "pg -missing | wf -file=missing.txt" | gf -run Phrasebook.pgf 

doc:
	cat Sentences.gf Words.gf >Ontology.gf
	gfdoc Ontology.gf
	rm -f Ontology.gf
	cat SentencesI.gf WordsEng.gf >Implementation.gf
	gfdoc Implementation.gf
	txt2tags -thtml --toc doc-phrasebook.txt
	txt2tags -thtml help-phrasebook.txt
	rm -f Ontology.gf Implementation.gf

clean:
	rm *.gfo *.pgf

upload:: Phrasebook.pgf
	rsync -avb Phrasebook.pgf www.grammaticalframework.org:/usr/local/www/GF-demos/www/grammars
