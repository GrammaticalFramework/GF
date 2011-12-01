compile = runghc Compile 

all: fin demo missing

demo: compdemo linkdemo

compdemo:
	$(compile) Bul Dan Dut Nor Pol Ron Spa
	$(compile) -opt Cat Eng Fre Ger Rus Swe Tha Urd DisambPhrasebookEng
#	$(compile) -opt Bul Cat Dan Dut Eng Fre Ger Ita Nor Pol Ron Rus Spa Swe Tha Urd DisambPhrasebookEng

linkdemo:
	$(compile) -link Eng Bul Cat Dan Dut Fin Fre Ger Ita Nor Pol Rus Spa Swe Tha Urd DisambPhrasebookEng 
#	$(compile) -link Eng Bul Cat Dan Dut Fin Fre Ger Ita Nor Pol Ron Rus Spa Swe Tha Urd DisambPhrasebookEng 

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
