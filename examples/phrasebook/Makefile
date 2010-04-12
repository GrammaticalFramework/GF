compile = runghc Compile 

all: fin demo missing

demo: compdemo linkdemo

compdemo:
	$(compile) Eng Fre Ger Ita Ron Swe DisambPhrasebookEng

linkdemo:
	$(compile) -link Eng Fin Fre Ger Ita Ron Swe DisambPhrasebookEng 

#separate, because slow...
fin:
	$(compile) Fin

pgfs:
	$(compile) Bul Cat Dan Dut Eng Fin Fre Ger Ita Nor Pol Ron Rus Spa Swe

koe:
	$(compile) Eng Fre DisambPhrasebookEng

missing:
	echo "pg -missing | wf -file=missing.txt" | gf Phrasebook.pgf 

doc:
	cat Sentences.gf Words.gf >Ontology.gf
	gfdoc Ontology.gf
	rm -f Ontology.gf
	cat SentencesI.gf WordsEng.gf >Implementation.gf
	gfdoc Implementation.gf
	txt2tags -thtml phrasebook.txt
	rm -f Ontology.gf Implementation.gf

