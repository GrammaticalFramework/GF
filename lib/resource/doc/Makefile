all: gfdoc htmls gifs

htmls:
	htmls gf-resource.html

gfdoc:
	gfdoc ../abstract/Categories.gf ; mv ../abstract/Categories.html .
	gfdoc ../abstract/Rules.gf ; mv ../abstract/Rules.html .
	gfdoc ../abstract/Verbphrase.gf ; mv ../abstract/Verbphrase.html .
	gfdoc ../abstract/Clause.gf ; mv ../abstract/Clause.html .
	gfdoc ../abstract/Structural.gf ; mv ../abstract/Structural.html .
	gfdoc ../abstract/Basic.gf ; mv ../abstract/Basic.html .
	gfdoc ../abstract/Time.gf ; mv ../abstract/Time.html .
	gfdoc ../abstract/Lang.gf ; mv ../abstract/Lang.html .
	gfdoc ../swedish/ParadigmsSwe.gf ; mv ../swedish/ParadigmsSwe.html .
	gfdoc ../swedish/VerbsSwe.gf ; mv ../swedish/VerbsSwe.html .
	gfdoc ../swedish/BasicSwe.gf ; mv ../swedish/BasicSwe.html .
	gfdoc ../english/ParadigmsEng.gf ; mv ../english/ParadigmsEng.html .
	gfdoc ../english/VerbsEng.gf ; mv ../english/VerbsEng.html .
	gfdoc ../english/BasicEng.gf ; mv ../english/BasicEng.html .
	gfdoc ../french/ParadigmsFre.gf ; mv ../french/ParadigmsFre.html .
	gfdoc ../french/VerbsFre.gf ; mv ../french/VerbsFre.html .
	gfdoc ../french/BasicFre.gf ; mv ../french/BasicFre.html .

gifs: api lang scand low

api:
#	echo "pm -printer=graph | wf Resource.dot" | gf ../abstract/Resource.gf
	dot -Tgif ResourceVP.dot>Resource.gif

lang:
	echo "pm -printer=graph | wf Lang.dot" | gf ../abstract/Lang.gf
	dot -Tgif Lang.dot>Lang.gif

low:
	echo "pm -printer=graph | wf Low.dot" | gf ../english/RulesEng.gf
	dot -Tgif Low.dot >Low.gif

scand:
	echo "pm -printer=graph | wf Scand.dot" | gf ../swedish/RulesSwe.gf
	dot -Tgif Scand.dot >Scand.gif
