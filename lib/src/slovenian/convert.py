# coding=utf-8

import xml.sax
import subprocess
import pgf
import sys
import os

class SloleksHandler(xml.sax.ContentHandler):
  def __init__(self):
	self.parents = []
	self.key   = None
	self.lemma = None
	self.pos   = None
	self.pos2  = None
	self.msd   = None
	self.forms = None
	self.sloleks = {}

  def startElement(self, name, attrs):
	if name == "LexicalEntry":
		self.forms = {}
		self.pos   = None
		self.pos2  = None
	elif name == "feat":
		if attrs["att"] == u"ključ" and self.parents[-1] == "LexicalEntry":
			self.key = attrs["val"].encode("utf-8")
		elif attrs["att"] == "zapis_oblike":
			if self.parents[-1] == "Lemma":
				self.lemma = attrs["val"].encode("utf-8")
			elif self.parents[-1] == "FormRepresentation":
				if self.forms.has_key(self.msd):
					l = self.forms[self.msd]
				else:
					l = []
					self.forms[self.msd] = l
				l.append(attrs["val"].encode("utf-8"))
		elif attrs["att"] == "besedna_vrsta" and self.parents[-1] == "LexicalEntry":
			self.pos = attrs["val"]
		elif attrs["att"] == "vrsta" and self.parents[-1] == "LexicalEntry":
			self.pos2 = attrs["val"]
		elif attrs["att"] == "msd" and self.parents[-1] == "WordForm":
			self.msd = attrs["val"].encode("utf-8")
	self.parents.append(name)

  def endElement(self, name):
	self.parents.pop()
	if name == "LexicalEntry":
		self.sloleks[self.key] = (self.pos,self.pos2,self.lemma,self.forms,0)

sys.stdout.write("Reading Sloleks_v1.2.xml ...")
sys.stdout.flush()
parser = xml.sax.make_parser()
handler = SloleksHandler()
parser.setContentHandler(handler)
parser.parse(open("Sloleks_v1.2.xml","r")) # open("sample.xml","r"))
sloleks = handler.sloleks
sys.stdout.write("\n")

def pos2cat(pos,pos2):
	if pos2 == "lastno_ime":
		return "PN"
	elif pos2 == u"občno_ime":
		return "N"
	elif pos == "glagol" and pos2 == "glavni":
		return "V"
	elif pos == "pridevnik" and pos2 == u"splošni":
		return "A"
	else:
		return None

def quote(id):
	quote = False
	ident = ""
	for c in id:
		if not ((c >= "a" and c <= "z") or (c >= "A" and c <= "Z") or c == "_"):
			quote = True
		if c == '\'':
			ident = ident + "\\\'"
		else:
			ident = ident + c  
	if quote:
		ident = "'" + ident + "'"
	return ident

def mkLin(pos,pos2,lemma,forms,version):
	if pos2 == "lastno_ime":
		if forms.has_key("Slmei") and forms.has_key("Slmetn"):
			tags   = [["Slmei"]
			         ,["Slmei", "Slmer"]
			         ,["Slmei"]
			         ,["Slmei", "Slmer", "Slmed", "Slmetn", "Slmem", "Slmeo"]
			         ]
			gender = "masculine"
			forms.pop("Slmetd",None)
		elif forms.has_key("Slmei") and forms.has_key("Slmetd"):
			tags   = [["Slmei"]
			         ,["Slmei", "Slmer"]
			         ,["Slmei"]
			         ,["Slmei", "Slmer", "Slmed", "Slmetd", "Slmem", "Slmeo"]
			         ]
			gender = "animate"
		elif forms.has_key("Slzei"):
			tags   = [["Slzei"]
			         ,["Slzei", "Slzer"]
			         ,["Slzei"]
			         ,["Slzei", "Slzer", "Slzed", "Slzet", "Slzem", "Slzeo"]
			         ]
			gender = "feminine"
		elif forms.has_key("Slsei"):
			tags   = [["Slsei"]
			         ,["Slsei", "Slser"]
			         ,["Slsei"]
			         ,["Slsei", "Slser", "Slsed", "Slset", "Slsem", "Slseo"]
			         ]
			gender = "neuter"
		else:
			return None
			#tags   = [["Lemma"]]
			#forms["Lemma"] = [lemma]
			#gender = None
		if version == 0 or version == 1:
			s = "mkPN (mkN"
		else:
			s = "mkPN"
		for msd in tags[version]:
			if forms.has_key(msd):
				s = s + " \"" + forms[msd][0] + "\""
			else:
				s = s + " nonExist"
		if gender != None:
			s = s+" "+gender
		if version == 0 or version == 1:
			s = s+")"
		else:
			s = s+" singular"
		return s
	elif pos2 == u"občno_ime":
		if forms.has_key("Somei") and forms.has_key("Sometn"):
			tags = [["Somei"]
			       ,["Somei", "Somer"]
			       ,["Somei", "Somer", "Sommi"]
			       ,["Somei", "Somer", "Somed", "Sometn", "Somem", "Someo", "Somdi", "Somdr", "Somdd", "Somdt", "Somdm", "Somdo", "Sommi", "Sommr", "Sommd", "Sommt", "Sommm", "Sommo"]
			       ]
			if version != 2:
				gender = "masculine"
			else:
				gender = None
			forms.pop("Sometd",None)
		elif forms.has_key("Somei") and forms.has_key("Sometd"):
			tags = [["Somei"]
			       ,["Somei", "Somer"]
			       ,["Somei", "Somer", "Somed", "Sometd", "Somem", "Someo", "Somdi", "Somdr", "Somdd", "Somdt", "Somdm", "Somdo", "Sommi", "Sommr", "Sommd", "Sommt", "Sommm", "Sommo"]
			       ]
			gender = "animate"
		elif forms.has_key("Sozei"):
			tags = [["Sozei"]
			       ,["Sozei", "Sozer"]
			       ,["Sozei"]
			       ,["Sozei", "Sozer", "Sozdr"]
			       ,["Sozei", "Sozer", "Sozed", "Sozet", "Sozem", "Sozeo", "Sozdi", "Sozdr", "Sozdd", "Sozdt", "Sozdm", "Sozdo", "Sozmi", "Sozmr", "Sozmd", "Sozmt", "Sozmm", "Sozmo"]
			       ]
			gender = "feminine"
		elif forms.has_key("Sosei"):
			tags = [["Sosei"]
			       ,["Sosei", "Soser"]
			       ,["Sosei", "Soser", "Sosdr"]
			       ,["Sosei", "Soser", "Sosed", "Soset", "Sosem", "Soseo", "Sosdi", "Sosdr", "Sosdd", "Sosdt", "Sosdm", "Sosdo", "Sosmi", "Sosmr", "Sosmd", "Sosmt", "Sosmm", "Sosmo"]
			       ]
			gender = "neuter"
		else:
			return None
			#tags = [["Lemma"]]
			#forms["Lemma"] = [lemma]
			#gender = None
		if gender == "feminine" and version == 2:
			s = "iFem"
			gender = None
		elif gender == "feminine" and version == 3:
			s = "irregFem"
			gender = None
		elif gender == "neuter" and version == 2:
			s = "irregNeut"
			gender = None
		else:
			s = "mkN"
		for msd in tags[version]:
			if forms.has_key(msd):
				s = s + " \"" + forms[msd][0] + "\""
			else:
				s = s + " nonExist"
		if gender != None:
			s = s + " " + gender
		return s
	elif pos == "glagol" and pos2 == "glavni":
		if forms.has_key("Ggvn"):
			tags = [["Ggvn", "Ggvste"]
			       ,["Ggvn", "Ggvste", "Ggvd-em"]
			       ,["Ggvn", "Ggvste", "Ggvd-em", "Ggvvde"]
			       ,["Ggvn", "Ggvste", "Ggvd-em", "Ggvd-ez", "Ggvvde"]
			       ,["Ggvn", "Ggvm", "Ggvd-em", "Ggvd-dm", "Ggvd-mm", "Ggvd-ez", "Ggvd-dz", "Ggvd-mz", "Ggvd-es", "Ggvd-ds", "Ggvd-ms", "Ggvspe", "Ggvsde", "Ggvste", "Ggvspd", "Ggvsdd", "Ggvstd", "Ggvspm", "Ggvsdm", "Ggvstm", "Ggvvpd", "Ggvvpm", "Ggvvde", "Ggvvdd", "Ggvvdm"]
			       ]
		elif forms.has_key("Ggnn"):
			tags = [["Ggnn", "Ggnste"]
			       ,["Ggnn", "Ggnste", "Ggnd-em"]
			       ,["Ggnn", "Ggnste", "Ggnd-em", "Ggnvde"]
			       ,["Ggnn", "Ggnste", "Ggnd-em", "Ggnd-ez", "Ggnvde"]
			       ,["Ggnn", "Ggnm", "Ggnd-em", "Ggnd-dm", "Ggnd-mm", "Ggnd-ez", "Ggnd-dz", "Ggnd-mz", "Ggnd-es", "Ggnd-ds", "Ggnd-ms", "Ggnspe", "Ggnsde", "Ggnste", "Ggnspd", "Ggnsdd", "Ggnstd", "Ggnspm", "Ggnsdm", "Ggnstm", "Ggnvpd", "Ggnvpm", "Ggnvde", "Ggnvdd", "Ggnvdm"]
			       ]
		else:
			tags = [["Ggdn", "Ggdste"]
			       ,["Ggdn", "Ggdste", "Ggdd-em"]
			       ,["Ggdn", "Ggdste", "Ggdd-em", "Ggdvde"]
			       ,["Ggdn", "Ggdste", "Ggdd-em", "Ggdd-ez", "Ggdvde"]
			       ,["Ggdn", "Ggdm", "Ggdd-em", "Ggdd-dm", "Ggdd-mm", "Ggdd-ez", "Ggdd-dz", "Ggdd-mz", "Ggdd-es", "Ggdd-ds", "Ggdd-ms", "Ggdspe", "Ggdsde", "Ggdste", "Ggdspd", "Ggdsdd", "Ggdstd", "Ggdspm", "Ggdsdm", "Ggdstm", "Ggdvpd", "Ggdvpm", "Ggdvde", "Ggdvdd", "Ggdvdm"]
			       ]
		s = "mkV"
		for msd in tags[version]:
			if forms.has_key(msd):
				s = s+" \"" + forms[msd][0] + "\""
			else:
				s = s+" nonExist"
		return s
	elif pos == "pridevnik" and pos2 == u"splošni":
		if not forms.has_key("Ppnmein"):
			forms["Ppnmein"] = [lemma]

		tags = [["Ppnmein"]
			   ,["Ppnmein","Pppmeid"]
			   ,["Ppnmein","Ppnzei","Ppnsei"]
			   ,["Ppnmein","Ppnzei","Ppnsei","Pppmeid","Pppzei","Pppsei"]
			   ,["Ppnmein", "Ppnmeid", "Ppnmer", "Ppnmed", "Ppnmet", "Ppnmetn", "Ppnmetd", "Ppnmem", "Ppnmeo", "Ppnmdi", "Ppnmdr", "Ppnmdd", "Ppnmdt", "Ppnmdm", "Ppnmdo", "Ppnmmi", "Ppnmmr", "Ppnmmd", "Ppnmmt", "Ppnmmm", "Ppnmmo", "Ppnzei", "Ppnzer", "Ppnzed", "Ppnzet", "Ppnzem", "Ppnzeo", "Ppnzdi", "Ppnzdr", "Ppnzdd", "Ppnzdt", "Ppnzdm", "Ppnzdo", "Ppnzmi", "Ppnzmr", "Ppnzmd", "Ppnzmt", "Ppnzmm", "Ppnzmo", "Ppnsei", "Ppnser", "Ppnsed", "Ppnset", "Ppnsem", "Ppnseo", "Ppnsdi", "Ppnsdr", "Ppnsdd", "Ppnsdt", "Ppnsdm", "Ppnsdo", "Ppnsmi", "Ppnsmr", "Ppnsmd", "Ppnsmt", "Ppnsmm", "Ppnsmo"]
			   ,["Ppnmein", "Ppnmeid", "Ppnmer", "Ppnmed", "Ppnmet", "Ppnmetn", "Ppnmetd", "Ppnmem", "Ppnmeo", "Ppnmdi", "Ppnmdr", "Ppnmdd", "Ppnmdt", "Ppnmdm", "Ppnmdo", "Ppnmmi", "Ppnmmr", "Ppnmmd", "Ppnmmt", "Ppnmmm", "Ppnmmo", "Ppnzei", "Ppnzer", "Ppnzed", "Ppnzet", "Ppnzem", "Ppnzeo", "Ppnzdi", "Ppnzdr", "Ppnzdd", "Ppnzdt", "Ppnzdm", "Ppnzdo", "Ppnzmi", "Ppnzmr", "Ppnzmd", "Ppnzmt", "Ppnzmm", "Ppnzmo", "Ppnsei", "Ppnser", "Ppnsed", "Ppnset", "Ppnsem", "Ppnseo", "Ppnsdi", "Ppnsdr", "Ppnsdd", "Ppnsdt", "Ppnsdm", "Ppnsdo", "Ppnsmi", "Ppnsmr", "Ppnsmd", "Ppnsmt", "Ppnsmm", "Ppnsmo",
				 "Pppmeid",            "Pppmer", "Pppmed", "Pppmet",            "Pppmetd", "Pppmem", "Pppmeo", "Pppmdi", "Pppmdr", "Pppmdd", "Pppmdt", "Pppmdm", "Pppmdo", "Pppmmi", "Pppmmr", "Pppmmd", "Pppmmt", "Pppmmm", "Pppmmo", "Pppzei", "Pppzer", "Pppzed", "Pppzet", "Pppzem", "Pppzeo", "Pppzdi", "Pppzdr", "Pppzdd", "Pppzdt", "Pppzdm", "Pppzdo", "Pppzmi", "Pppzmr", "Pppzmd", "Pppzmt", "Pppzmm", "Pppzmo", "Pppsei", "Pppser", "Pppsed", "Pppset", "Pppsem", "Pppseo", "Pppsdi", "Pppsdr", "Pppsdd", "Pppsdt", "Pppsdm", "Pppsdo", "Pppsmi", "Pppsmr", "Pppsmd", "Pppsmt", "Pppsmm", "Pppsmo",
				 "Ppsmeid",            "Ppsmer", "Ppsmed", "Ppsmet",            "Ppsmetd", "Ppsmem", "Ppsmeo", "Ppsmdi", "Ppsmdr", "Ppsmdd", "Ppsmdt", "Ppsmdm", "Ppsmdo", "Ppsmmi", "Ppsmmr", "Ppsmmd", "Ppsmmt", "Ppsmmm", "Ppsmmo", "Ppszei", "Ppszer", "Ppszed", "Ppszet", "Ppszem", "Ppszeo", "Ppszdi", "Ppszdr", "Ppszdd", "Ppszdt", "Ppszdm", "Ppszdo", "Ppszmi", "Ppszmr", "Ppszmd", "Ppszmt", "Ppszmm", "Ppszmo", "Ppssei", "Ppsser", "Ppssed", "Ppsset", "Ppssem", "Ppsseo", "Ppssdi", "Ppssdr", "Ppssdd", "Ppssdt", "Ppssdm", "Ppssdo", "Ppssmi", "Ppssmr", "Ppssmd", "Ppssmt", "Ppssmm", "Ppssmo"]
			   ]

		s = "mkA"
		for msd in tags[version]:
			if forms.has_key(msd):
				s = s + " \"" + forms[msd][0] + "\""
			else:
				s = s + " nonExist"
		return s
	else:
		return None


sys.stdout.write("Writing   DictSlvAbs.gf ...")
sys.stdout.flush()
f = open("DictSlvAbs.gf","w")
f.write("--# -coding=utf-8\n")
f.write("abstract DictSlvAbs = Cat ** {\n");
f.write("fun\n");
for key in sloleks:
	(pos,pos2,lemma,forms,version) = sloleks[key]
	cat = pos2cat(pos,pos2)
	if cat != None:
		f.write("  "+quote(key)+" : "+cat+" ;\n")
f.write("}");
f.close()
sys.stdout.write("\n")

mapping = {
	"Slmei":  "s Nom",
	"Slmer":  "s Gen",
	"Slmed":  "s Dat",
	"Slmetn": "s Acc",
	"Slmetd": "s Acc",
	"Slmem":  "s Loc",
	"Slmeo":  "s Instr",
	"Slzei":  "s Nom",
	"Slzer":  "s Gen",
	"Slzed":  "s Dat",
	"Slzet":  "s Acc", 
	"Slzem":  "s Loc",
	"Slzeo":  "s Instr",
	"Slsei":  "s Nom",
	"Slser":  "s Gen",
	"Slsed":  "s Dat",
	"Slset":  "s Acc",
	"Slsem":  "s Loc",
	"Slseo":  "s Instr",
	"Somei":  "s Nom Sg",
	"Somer":  "s Gen Sg",
	"Somed":  "s Dat Sg",
	"Sometd": "s Acc Sg",
	"Sometn": "s Acc Sg",
	"Somem":  "s Loc Sg",
	"Someo":  "s Instr Sg",
	"Somdi":  "s Nom Dl",
	"Somdr":  "s Gen Dl",
	"Somdd":  "s Dat Dl",
	"Somdt":  "s Acc Dl",
	"Somdm":  "s Loc Dl",
	"Somdo":  "s Instr Dl",
	"Sommi":  "s Nom Pl",
	"Sommr":  "s Gen Pl",
	"Sommd":  "s Dat Pl",
	"Sommt":  "s Acc Pl",
	"Sommm":  "s Loc Pl",
	"Sommo":  "s Instr Pl",
	"Sozei":  "s Nom Sg",
	"Sozer":  "s Gen Sg",
	"Sozed":  "s Dat Sg",
	"Sozet":  "s Acc Sg",
	"Sozem":  "s Loc Sg",
	"Sozeo":  "s Instr Sg",
	"Sozdi":  "s Nom Dl",
	"Sozdr":  "s Gen Dl",
	"Sozdd":  "s Dat Dl",
	"Sozdt":  "s Acc Dl",
	"Sozdm":  "s Loc Dl",
	"Sozdo":  "s Instr Dl",
	"Sozmi":  "s Nom Pl",
	"Sozmr":  "s Gen Pl",
	"Sozmd":  "s Dat Pl",
	"Sozmt":  "s Acc Pl",
	"Sozmm":  "s Loc Pl",
	"Sozmo":  "s Instr Pl",
	"Sosei":  "s Nom Sg",
	"Soser":  "s Gen Sg",
	"Sosed":  "s Dat Sg",
	"Soset":  "s Acc Sg",
	"Sosem":  "s Loc Sg",
	"Soseo":  "s Instr Sg",
	"Sosdi":  "s Nom Dl",
	"Sosdr":  "s Gen Dl",
	"Sosdd":  "s Dat Dl",
	"Sosdt":  "s Acc Dl",
	"Sosdm":  "s Loc Dl",
	"Sosdo":  "s Instr Dl",
	"Sosmi":  "s Nom Pl",
	"Sosmr":  "s Gen Pl",
	"Sosmd":  "s Dat Pl",
	"Sosmt":  "s Acc Pl",
	"Sosmm":  "s Loc Pl",
	"Sosmo":  "s Instr Pl",
	"Ggvn":   "s VInf",
	"Ggvm":   "s VSup",
	"Ggvd-em":"s (VPastPart Masc Sg)",
	"Ggvd-dm":"s (VPastPart Masc Dl)",
	"Ggvd-mm":"s (VPastPart Masc Pl)",
	"Ggvd-ez":"s (VPastPart Fem Sg)",
	"Ggvd-dz":"s (VPastPart Fem Dl)",
	"Ggvd-mz":"s (VPastPart Fem Pl)",
	"Ggvd-es":"s (VPastPart Neut Sg)",
	"Ggvd-ds":"s (VPastPart Neut Dl)",
	"Ggvd-ms":"s (VPastPart Neut Pl)",
	"Ggvspe": "s (VPres Sg P1)",
	"Ggvsde": "s (VPres Sg P2)",
	"Ggvste": "s (VPres Sg P3)",
	"Ggvspd": "s (VPres Dl P1)",
	"Ggvsdd": "s (VPres Dl P2)",
	"Ggvstd": "s (VPres Dl P3)",
	"Ggvspm": "s (VPres Pl P1)",
	"Ggvsdm": "s (VPres Pl P2)",
	"Ggvstm": "s (VPres Pl P3)",
	"Ggvvpd": "s VImper1Dl",
	"Ggvvpm": "s VImper1Sg",
	"Ggvvde": "s (VImper2 Sg)",
	"Ggvvdd": "s (VImper2 Dl)",
	"Ggvvdm": "s (VImper2 Pl)",
	"Ggnn":   "s VInf",
	"Ggnm":   "s VSup",
	"Ggnd-em":"s (VPastPart Masc Sg)",
	"Ggnd-dm":"s (VPastPart Masc Dl)",
	"Ggnd-mm":"s (VPastPart Masc Pl)",
	"Ggnd-ez":"s (VPastPart Fem Sg)",
	"Ggnd-dz":"s (VPastPart Fem Dl)",
	"Ggnd-mz":"s (VPastPart Fem Pl)",
	"Ggnd-es":"s (VPastPart Neut Sg)",
	"Ggnd-ds":"s (VPastPart Neut Dl)",
	"Ggnd-ms":"s (VPastPart Neut Pl)",
	"Ggnspe": "s (VPres Sg P1)",
	"Ggnsde": "s (VPres Sg P2)",
	"Ggnste": "s (VPres Sg P3)",
	"Ggnspd": "s (VPres Dl P1)",
	"Ggnsdd": "s (VPres Dl P2)",
	"Ggnstd": "s (VPres Dl P3)",
	"Ggnspm": "s (VPres Pl P1)",
	"Ggnsdm": "s (VPres Pl P2)",
	"Ggnstm": "s (VPres Pl P3)",
	"Ggnvpd": "s VImper1Dl",
	"Ggnvpm": "s VImper1Sg",
	"Ggnvde": "s (VImper2 Sg)",
	"Ggnvdd": "s (VImper2 Dl)",
	"Ggnvdm": "s (VImper2 Pl)",
	"Ggdn":   "s VInf",
	"Ggdm":   "s VSup",
	"Ggdd-em":"s (VPastPart Masc Sg)",
	"Ggdd-dm":"s (VPastPart Masc Dl)",
	"Ggdd-mm":"s (VPastPart Masc Pl)",
	"Ggdd-ez":"s (VPastPart Fem Sg)",
	"Ggdd-dz":"s (VPastPart Fem Dl)",
	"Ggdd-mz":"s (VPastPart Fem Pl)",
	"Ggdd-es":"s (VPastPart Neut Sg)",
	"Ggdd-ds":"s (VPastPart Neut Dl)",
	"Ggdd-ms":"s (VPastPart Neut Pl)",
	"Ggdspe": "s (VPres Sg P1)",
	"Ggdsde": "s (VPres Sg P2)",
	"Ggdste": "s (VPres Sg P3)",
	"Ggdspd": "s (VPres Dl P1)",
	"Ggdsdd": "s (VPres Dl P2)",
	"Ggdstd": "s (VPres Dl P3)",
	"Ggdspm": "s (VPres Pl P1)",
	"Ggdsdm": "s (VPres Pl P2)",
	"Ggdstm": "s (VPres Pl P3)",
	"Ggdvpd": "s VImper1Dl",
	"Ggdvpm": "s VImper1Sg",
	"Ggdvde": "s (VImper2 Sg)",
	"Ggdvdd": "s (VImper2 Dl)",
	"Ggdvdm": "s (VImper2 Pl)",
	"Ppnmein":"s (APosit Masc Sg Nom)",
	"Ppnmeid":"s APositDefNom",
	"Ppnmer": "s (APosit Masc Sg Gen)",
	"Ppnmed": "s (APosit Masc Sg Dat)",
	"Ppnmet": "s (APosit Masc Sg Acc)",
	"Ppnmetn":"s APositIndefAcc",
	"Ppnmetd":"s APositDefAcc",
	"Ppnmem": "s (APosit Masc Sg Loc)",
	"Ppnmeo": "s (APosit Masc Sg Instr)",
	"Ppnmdi": "s (APosit Masc Dl Nom)",
	"Ppnmdr": "s (APosit Masc Dl Gen)",
	"Ppnmdd": "s (APosit Masc Dl Dat)",
	"Ppnmdt": "s (APosit Masc Dl Acc)",
	"Ppnmdm": "s (APosit Masc Dl Loc)",
	"Ppnmdo": "s (APosit Masc Dl Instr)",
	"Ppnmmi": "s (APosit Masc Pl Nom)",
	"Ppnmmr": "s (APosit Masc Pl Gen)",
	"Ppnmmd": "s (APosit Masc Pl Dat)",
	"Ppnmmt": "s (APosit Masc Pl Acc)",
	"Ppnmmm": "s (APosit Masc Pl Loc)",
	"Ppnmmo": "s (APosit Masc Pl Instr)",
	"Ppnzei": "s (APosit Fem Sg Nom)",
	"Ppnzer": "s (APosit Fem Sg Gen)",
	"Ppnzed": "s (APosit Fem Sg Dat)",
	"Ppnzet": "s (APosit Fem Sg Acc)",
	"Ppnzem": "s (APosit Fem Sg Loc)",
	"Ppnzeo": "s (APosit Fem Sg Instr)",
	"Ppnzdi": "s (APosit Fem Dl Nom)",
	"Ppnzdr": "s (APosit Fem Dl Gen)",
	"Ppnzdd": "s (APosit Fem Dl Dat)",
	"Ppnzdt": "s (APosit Fem Dl Acc)",
	"Ppnzdm": "s (APosit Fem Dl Loc)",
	"Ppnzdo": "s (APosit Fem Dl Instr)",
	"Ppnzmi": "s (APosit Fem Pl Nom)",
	"Ppnzmr": "s (APosit Fem Pl Gen)",
	"Ppnzmd": "s (APosit Fem Pl Dat)",
	"Ppnzmt": "s (APosit Fem Pl Acc)",
	"Ppnzmm": "s (APosit Fem Pl Loc)",
	"Ppnzmo": "s (APosit Fem Pl Instr)",
	"Ppnsei": "s (APosit Neut Sg Nom)",
	"Ppnser": "s (APosit Neut Sg Gen)",
	"Ppnsed": "s (APosit Neut Sg Dat)",
	"Ppnset": "s (APosit Neut Sg Acc)",
	"Ppnsem": "s (APosit Neut Sg Loc)",
	"Ppnseo": "s (APosit Neut Sg Instr)",
	"Ppnsdi": "s (APosit Neut Dl Nom)",
	"Ppnsdr": "s (APosit Neut Dl Gen)",
	"Ppnsdd": "s (APosit Neut Dl Dat)",
	"Ppnsdt": "s (APosit Neut Dl Acc)",
	"Ppnsdm": "s (APosit Neut Dl Loc)",
	"Ppnsdo": "s (APosit Neut Dl Instr)",
	"Ppnsmi": "s (APosit Neut Pl Nom)",
	"Ppnsmr": "s (APosit Neut Pl Gen)",
	"Ppnsmd": "s (APosit Neut Pl Dat)",
	"Ppnsmt": "s (APosit Neut Pl Acc)",
	"Ppnsmm": "s (APosit Neut Pl Loc)",
	"Ppnsmo": "s (APosit Neut Pl Instr)",
	"Pppmeid":"s (ACompar Masc Sg Nom)",
	"Pppmer": "s (ACompar Masc Sg Gen)",
	"Pppmed": "s (ACompar Masc Sg Dat)",
	"Pppmet": "s (ACompar Masc Sg Acc)",
	"Pppmetd":"s AComparDefAcc",
	"Pppmem": "s (ACompar Masc Sg Loc)",
	"Pppmeo": "s (ACompar Masc Sg Instr)",
	"Pppmdi": "s (ACompar Masc Dl Nom)",
	"Pppmdr": "s (ACompar Masc Dl Gen)",
	"Pppmdd": "s (ACompar Masc Dl Dat)",
	"Pppmdt": "s (ACompar Masc Dl Acc)",
	"Pppmdm": "s (ACompar Masc Dl Loc)",
	"Pppmdo": "s (ACompar Masc Dl Instr)",
	"Pppmmi": "s (ACompar Masc Pl Nom)",
	"Pppmmr": "s (ACompar Masc Pl Gen)",
	"Pppmmd": "s (ACompar Masc Pl Dat)",
	"Pppmmt": "s (ACompar Masc Pl Acc)",
	"Pppmmm": "s (ACompar Masc Pl Loc)",
	"Pppmmo": "s (ACompar Masc Pl Instr)",
	"Pppzei": "s (ACompar Fem Sg Nom)",
	"Pppzer": "s (ACompar Fem Sg Gen)",
	"Pppzed": "s (ACompar Fem Sg Dat)",
	"Pppzet": "s (ACompar Fem Sg Acc)",
	"Pppzem": "s (ACompar Fem Sg Loc)",
	"Pppzeo": "s (ACompar Fem Sg Instr)",
	"Pppzdi": "s (ACompar Fem Dl Nom)",
	"Pppzdr": "s (ACompar Fem Dl Gen)",
	"Pppzdd": "s (ACompar Fem Dl Dat)",
	"Pppzdt": "s (ACompar Fem Dl Acc)",
	"Pppzdm": "s (ACompar Fem Dl Loc)",
	"Pppzdo": "s (ACompar Fem Dl Instr)",
	"Pppzmi": "s (ACompar Fem Pl Nom)",
	"Pppzmr": "s (ACompar Fem Pl Gen)",
	"Pppzmd": "s (ACompar Fem Pl Dat)",
	"Pppzmt": "s (ACompar Fem Pl Acc)",
	"Pppzmm": "s (ACompar Fem Pl Loc)",
	"Pppzmo": "s (ACompar Fem Pl Instr)",
	"Pppsei": "s (ACompar Neut Sg Nom)",
	"Pppser": "s (ACompar Neut Sg Gen)",
	"Pppsed": "s (ACompar Neut Sg Dat)",
	"Pppset": "s (ACompar Neut Sg Acc)",
	"Pppsem": "s (ACompar Neut Sg Loc)",
	"Pppseo": "s (ACompar Neut Sg Instr)",
	"Pppsdi": "s (ACompar Neut Dl Nom)",
	"Pppsdr": "s (ACompar Neut Dl Gen)",
	"Pppsdd": "s (ACompar Neut Dl Dat)",
	"Pppsdt": "s (ACompar Neut Dl Acc)",
	"Pppsdm": "s (ACompar Neut Dl Loc)",
	"Pppsdo": "s (ACompar Neut Dl Instr)",
	"Pppsmi": "s (ACompar Neut Pl Nom)",
	"Pppsmr": "s (ACompar Neut Pl Gen)",
	"Pppsmd": "s (ACompar Neut Pl Dat)",
	"Pppsmt": "s (ACompar Neut Pl Acc)",
	"Pppsmm": "s (ACompar Neut Pl Loc)",
	"Pppsmo": "s (ACompar Neut Pl Instr)",
	"Ppsmeid":"s (ASuperl Masc Sg Nom)",
	"Ppsmer": "s (ASuperl Masc Sg Gen)",
	"Ppsmed": "s (ASuperl Masc Sg Dat)",
	"Ppsmet": "s (ASuperl Masc Sg Acc)",
	"Ppsmetd":"s ASuperlDefAcc",
	"Ppsmem": "s (ASuperl Masc Sg Loc)",
	"Ppsmeo": "s (ASuperl Masc Sg Instr)",
	"Ppsmdi": "s (ASuperl Masc Dl Nom)",
	"Ppsmdr": "s (ASuperl Masc Dl Gen)",
	"Ppsmdd": "s (ASuperl Masc Dl Dat)",
	"Ppsmdt": "s (ASuperl Masc Dl Acc)",
	"Ppsmdm": "s (ASuperl Masc Dl Loc)",
	"Ppsmdo": "s (ASuperl Masc Dl Instr)",
	"Ppsmmi": "s (ASuperl Masc Pl Nom)",
	"Ppsmmr": "s (ASuperl Masc Pl Gen)",
	"Ppsmmd": "s (ASuperl Masc Pl Dat)",
	"Ppsmmt": "s (ASuperl Masc Pl Acc)",
	"Ppsmmm": "s (ASuperl Masc Pl Loc)",
	"Ppsmmo": "s (ASuperl Masc Pl Instr)",
	"Ppszei": "s (ASuperl Fem Sg Nom)",
	"Ppszer": "s (ASuperl Fem Sg Gen)",
	"Ppszed": "s (ASuperl Fem Sg Dat)",
	"Ppszet": "s (ASuperl Fem Sg Acc)",
	"Ppszem": "s (ASuperl Fem Sg Loc)",
	"Ppszeo": "s (ASuperl Fem Sg Instr)",
	"Ppszdi": "s (ASuperl Fem Dl Nom)",
	"Ppszdr": "s (ASuperl Fem Dl Gen)",
	"Ppszdd": "s (ASuperl Fem Dl Dat)",
	"Ppszdt": "s (ASuperl Fem Dl Acc)",
	"Ppszdm": "s (ASuperl Fem Dl Loc)",
	"Ppszdo": "s (ASuperl Fem Dl Instr)",
	"Ppszmi": "s (ASuperl Fem Pl Nom)",
	"Ppszmr": "s (ASuperl Fem Pl Gen)",
	"Ppszmd": "s (ASuperl Fem Pl Dat)",
	"Ppszmt": "s (ASuperl Fem Pl Acc)",
	"Ppszmm": "s (ASuperl Fem Pl Loc)",
	"Ppszmo": "s (ASuperl Fem Pl Instr)",
	"Ppssei": "s (ASuperl Neut Sg Nom)",
	"Ppsser": "s (ASuperl Neut Sg Gen)",
	"Ppssed": "s (ASuperl Neut Sg Dat)",
	"Ppsset": "s (ASuperl Neut Sg Acc)",
	"Ppssem": "s (ASuperl Neut Sg Loc)",
	"Ppsseo": "s (ASuperl Neut Sg Instr)",
	"Ppssdi": "s (ASuperl Neut Dl Nom)",
	"Ppssdr": "s (ASuperl Neut Dl Gen)",
	"Ppssdd": "s (ASuperl Neut Dl Dat)",
	"Ppssdt": "s (ASuperl Neut Dl Acc)",
	"Ppssdm": "s (ASuperl Neut Dl Loc)",
	"Ppssdo": "s (ASuperl Neut Dl Instr)",
	"Ppssmi": "s (ASuperl Neut Pl Nom)",
	"Ppssmr": "s (ASuperl Neut Pl Gen)",
	"Ppssmd": "s (ASuperl Neut Pl Dat)",
	"Ppssmt": "s (ASuperl Neut Pl Acc)",
	"Ppssmm": "s (ASuperl Neut Pl Loc)",
	"Ppssmo": "s (ASuperl Neut Pl Instr)"
}             

def updateVersions(sloleks,slv):
	count = 0
	for key in sloleks:
		(pos,pos2,lemma,forms,version) = sloleks[key]
		if not slv.hasLinearization(key):
			continue

		lins = slv.tabularLinearize(pgf.Expr(key,[]))
		for msd in forms:
			if not mapping.has_key(msd):
				continue

			if not lins[mapping[msd]] in forms[msd]:
				sloleks[key] = (pos,pos2,lemma,forms,version+1)
				count = count + 1
				break
	return count

stage = 1
while True:    
	sys.stdout.write("Writing   DictSlv.gf ("+str(stage)+") ...")
	sys.stdout.flush()
	f = open("DictSlv.gf","w")
	f.write("--# -coding=utf-8\n")
	f.write("concrete DictSlv of DictSlvAbs = CatSlv ** open ParadigmsSlv, Prelude in {\n");
	f.write("lin\n");
	for key in sloleks:
		(pos,pos2,lemma,forms,version) = sloleks[key]
		lin = mkLin(pos,pos2,lemma,forms,version)
		if lin != None:
			f.write("  "+quote(key)+" = "+lin+" ;\n")
	f.write("}");
	f.close()
	sys.stdout.write("\n")

	sys.stdout.write("Compiling DictSlv.gf ("+str(stage)+") ...")
	sys.stdout.flush()
	try:
		os.remove("DictSlvAbs.pgf")
	except OSError:
		pass
	subprocess.call(["gf","--make","-s","DictSlv.gf","+RTS","-K128M"])
	sys.stdout.write("\n")

	sys.stdout.write("Checking  DictSlv.gf ("+str(stage)+") ...")
	sys.stdout.flush()
	slv = pgf.readPGF("DictSlvAbs.pgf").languages["DictSlv"]
	count = updateVersions(sloleks,slv)
	sys.stdout.write(" "+str(count)+"\n")

	if count == 0:
		break

	stage = stage + 1
