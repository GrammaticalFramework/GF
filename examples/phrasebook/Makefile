all: demo missing

demo:
	gf -make PhrasebookEng.gf PhrasebookFin.gf PhrasebookFre.gf PhrasebookGer.gf PhrasebookIta.gf PhrasebookRon.gf PhrasebookSwe.gf DisambPhrasebookEng.gf 
#DisambPhrasebookRon.gf

pgf:
	gf -make Phrasebook???.gf DisambPhrasebookEng.gf

koe:
	gf -make PhrasebookEng.gf PhrasebookFre.gf DisambPhrasebookEng.gf

missing:
	echo "pg -missing | wf -file=missing.txt" | gf Phrasebook.pgf 
#PhrasebookBul.gf PhrasebookCat.gf PhrasebookDan.gf PhrasebookDut.gf PhrasebookNor.gf PhrasebookPol.gf PhrasebookRus.gf PhrasebookSpa.gf


doc:
	cat Sentences.gf Words.gf >Ontology.gf
	gfdoc Ontology.gf
	rm -f Ontology.gf
	cat SentencesI.gf WordsEng.gf >Implementation.gf
	gfdoc Implementation.gf
	txt2tags -thtml phrasebook.txt
	rm -f Ontology.gf Implementation.gf

