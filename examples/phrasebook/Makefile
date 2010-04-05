all: pgf missing

pgf:
	gf -make PhrasebookEng.gf PhrasebookFin.gf PhrasebookFre.gf PhrasebookIta.gf PhrasebookRon.gf PhrasebookSwe.gf DisambPhrasebookEng.gf DisambPhrasebookRon.gf

koe:
	gf -make PhrasebookEng.gf PhrasebookFre.gf DisambPhrasebookEng.gf

missing:
	echo "pg -missing | wf -file=missing.txt" | gf Phrasebook.pgf 

doc:
	txt2tags -thtml phrasebook.txt
