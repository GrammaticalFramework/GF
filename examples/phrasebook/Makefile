compile = runghc Compile 

all: demo missing

thaidroid: #thaiscript
	cp -p Phrasebook.pgf FullPhrasebook.pgf
	$(compile) -opt Eng Swe Tha PhrasebookThaP DisambPhrasebookEng
	$(compile) -link Eng Fin Swe Tha PhrasebookThaP DisambPhrasebookEng
	mv Phrasebook.pgf Thaidroid.pgf
	mv FullPhrasebook.pgf Phrasebook.pgf

thaiscript:
	runghc ../../lib/src/thai/ThaiScript.hs

demo: compdemo fin linkdemo

compdemo:
#	$(compile) Bul Dan Dut Nor Pol Spa
#	$(compile) -opt Cat Eng Fre Ger Rus Swe Tha Urd DisambPhrasebookEng
	$(compile) -opt Bul Cat Dan Dut Eng Fre Ger Ita Nor Pol Ron Rus Spa Swe Tha Urd DisambPhrasebookEng

linkdemo:
#	$(compile) -link Eng Bul Cat Dan Dut Fin Fre Ger Ita Nor Pol Rus Spa Swe Tha Urd DisambPhrasebookEng 
	$(compile) -link Eng Bul Cat Dan Dut Fin Fre Ger Ita Nor Pol Ron Rus Spa Swe Tha Urd DisambPhrasebookEng 

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

upload:: Phrasebook.pgf
	rsync -a Phrasebook.pgf www.grammaticalframework.org:/usr/local/www/GF-demos/www/grammars
