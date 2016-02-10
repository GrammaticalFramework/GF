# coding=utf-8

import xml.sax

class InkscapeSvgHandler(xml.sax.ContentHandler):
  def __init__(self):
	self.parents = []
	self.lemma = None
	self.pos   = None
	self.pos2  = None
	self.msd   = None
	self.forms = None

	self.ids = {}

	self.absf = open("DictSlvAbs.gf", "w")
	self.absf.write("abstract DictSlvAbs = Cat ** {\n");
	self.absf.write("fun\n");

	self.cncf = open("DictSlv.gf", "w")
	self.cncf.write("concrete DictSlv of DictSlvAbs = CatSlv ** open ParadigmsSlv, Prelude in {\n");
	self.cncf.write("lin\n");
	
  def close(self):
	  self.absf.write("}");
	  self.absf.close();

	  self.cncf.write("}");
	  self.cncf.close();
	  
  def gen_id(self, lemma, tag):
	  i = 1
	  while True:
		  ident = ""
		  quote = False
		  for c in lemma.lower():
			  if c < "a" or c > "z":
				  quote = True
			  if c == '\'':
				ident = ident + "\\\'"
			  else:
				ident = ident + c  
		  ident = ident + "_" + str(i) + "_" + tag
		  if quote:
			  ident = "'" + ident + "'"
		  if not self.ids.has_key(ident):
		      self.ids[ident] = ident
		      break
		  i = i + 1
	  return ident

  def startElement(self, name, attrs):
	if name == "LexicalEntry":
		self.forms = {}
		self.pos   = None
		self.pos2  = None
	elif name == "feat":
		if attrs["att"] == "zapis_oblike":
			if self.parents[-1] == "Lemma":
				self.lemma = attrs["val"]
			elif self.parents[-1] == "FormRepresentation":
				if self.forms.has_key(self.msd):
					l = self.forms[self.msd]
				else:
					l = []
					self.forms[self.msd] = l
				l.append(attrs["val"])
		elif attrs["att"] == "besedna_vrsta" and self.parents[-1] == "LexicalEntry":
			self.pos = attrs["val"]
		elif attrs["att"] == "vrsta" and self.parents[-1] == "LexicalEntry":
			self.pos2 = attrs["val"]
		elif attrs["att"] == "msd" and self.parents[-1] == "WordForm":
			self.msd = attrs["val"]
	self.parents.append(name)

  def endElement(self, name):
	self.parents.pop()
	if name == "LexicalEntry":
		if self.pos2 == "lastno_ime":
			ident = self.gen_id(self.lemma, "PN")
			s = " " + ident + " : PN ;\n"
			self.absf.write(s.encode("utf-8"))
			
			max_forms = 0
			for msd in self.forms.keys():
				max_forms = max(max_forms, len(self.forms[msd]))
			s = " " + ident + " = "
			for i in range(max_forms):
				if i > 0:
					s = s + "\n" + " " * (len(ident) + 2) + "| "
				s = s + "mkPN "
				if self.forms.has_key("Slmei"):
					gender = "masculine"
					tags = ["Slmei", "Slmer", "Slmed", "Slmetd", "Slmem", "Slmeo", "Slmdi", "Slmdr", "Slmdd", "Slmdt", "Slmdm", "Slmdo", "Slmmi", "Slmmr", "Slmmd", "Slmmt", "Slmmm", "Slmmo"]
					if self.forms.has_key("Slmetn"):
						tags[3] = "Slmetn"
				elif self.forms.has_key("Slzei"):
					gender = "feminine"
					tags = ["Slzei", "Slzer", "Slzed", "Slzet", "Slzem", "Slzeo", "Slzdi", "Slzdr", "Slzdd", "Slzdt", "Slzdm", "Slzdo", "Slzmi", "Slzmr", "Slzmd", "Slzmt", "Slzmm", "Slzmo"]
				else:
					gender = "neuter"
					tags = ["Slsei", "Slser", "Slsed", "Slset", "Slsem", "Slseo", "Slsdi", "Slsdr", "Slsdd", "Slsdt", "Slsdm", "Slsdo", "Slsmi", "Slsmr", "Slsmd", "Slsmt", "Slsmm", "Slsmo"]
				for msd in tags:
					if self.forms.has_key(msd):
						s = s + "\"" + self.forms[msd][min(i,len(self.forms[msd])-1)] + "\" "
					else:
						s = s + "nonExist" + " "
				s = s + gender + " "
			s = s + ";\n"
			self.cncf.write(s.encode("utf-8"))
		elif self.pos2 == u"občno_ime":
			ident = self.gen_id(self.lemma, "N")
			s = " " + ident + " : N ;\n"
			self.absf.write(s.encode("utf-8"))

			max_forms = 0
			for msd in self.forms.keys():
				max_forms = max(max_forms, len(self.forms[msd]))
			s = " " + ident + " = "
			for i in range(max_forms):
				if i > 0:
					s = s + "\n" + " " * (len(ident) + 2) + "| "
				s = s + "mkN "
				if self.forms.has_key("Somei"):
					gender = "masculine"
					tags = ["Somei", "Somer", "Somed", "Sometd", "Somem", "Someo", "Somdi", "Somdr", "Somdd", "Somdt", "Somdm", "Somdo", "Sommi", "Sommr", "Sommd", "Sommt", "Sommm", "Sommo"]
					if self.forms.has_key("Sometn"):
						tags[3] = "Sometn"
				elif self.forms.has_key("Sozei"):
					gender = "feminine"
					tags = ["Sozei", "Sozer", "Sozed", "Sozet", "Sozem", "Sozeo", "Sozdi", "Sozdr", "Sozdd", "Sozdt", "Sozdm", "Sozdo", "Sozmi", "Sozmr", "Sozmd", "Sozmt", "Sozmm", "Sozmo"]
				else:
					gender = "neuter"
					tags = ["Sosei", "Soser", "Sosed", "Soset", "Sosem", "Soseo", "Sosdi", "Sosdr", "Sosdd", "Sosdt", "Sosdm", "Sosdo", "Sosmi", "Sosmr", "Sosmd", "Sosmt", "Sosmm", "Sosmo"]
				for msd in tags:
					if self.forms.has_key(msd):
						s = s + "\"" + self.forms[msd][min(i,len(self.forms[msd])-1)] + "\" "
					else:
						s = s + "nonExist "
				s = s + gender + " "
			s = s + ";\n"
			self.cncf.write(s.encode("utf-8"))
		elif self.pos == "glagol" and self.pos2 == "glavni":
			ident = self.gen_id(self.lemma, "V")
			s = " " + ident + " : V ;\n"
			self.absf.write(s.encode("utf-8"))

			max_forms = 0
			for msd in self.forms.keys():
				max_forms = max(max_forms, len(self.forms[msd]))
			s = " " + ident + " = "
			for i in range(max_forms):
				if i > 0:
					s = s + "\n" + " " * (len(ident) + 2) + "| "
				s = s + "mkV "
				if self.forms.has_key("Ggvn"):
					tags = ["Ggvn", "Ggvm", "Ggvd-em", "Ggvd-dm", "Ggvd-mm", "Ggvd-ez", "Ggvd-dz", "Ggvd-mz", "Ggvd-es", "Ggvd-ds", "Ggvd-ms", "Ggvspe", "Ggvsde", "Ggvste", "Ggvspd", "Ggvsdd", "Ggvstd", "Ggvspm", "Ggvsdm", "Ggvstm", "Ggvvpd", "Ggvvpm", "Ggvvde", "Ggvvdd", "Ggvvdm"]
				elif self.forms.has_key("Ggnn"):
					tags = ["Ggnn", "Ggnm", "Ggnd-em", "Ggnd-dm", "Ggnd-mm", "Ggnd-ez", "Ggnd-dz", "Ggnd-mz", "Ggnd-es", "Ggnd-ds", "Ggnd-ms", "Ggnspe", "Ggnsde", "Ggnste", "Ggnspd", "Ggnsdd", "Ggnstd", "Ggnspm", "Ggnsdm", "Ggnstm", "Ggnvpd", "Ggnvpm", "Ggnvde", "Ggnvdd", "Ggnvdm"]
				else:
					tags = ["Ggdn", "Ggdm", "Ggdd-em", "Ggdd-dm", "Ggdd-mm", "Ggdd-ez", "Ggdd-dz", "Ggdd-mz", "Ggdd-es", "Ggdd-ds", "Ggdd-ms", "Ggdspe", "Ggdsde", "Ggdste", "Ggdspd", "Ggdsdd", "Ggdstd", "Ggdspm", "Ggdsdm", "Ggdstm", "Ggdvpd", "Ggdvpm", "Ggdvde", "Ggdvdd", "Ggdvdm"]
				for msd in tags:
					if self.forms.has_key(msd):
						s = s + "\"" + self.forms[msd][min(i,len(self.forms[msd])-1)] + "\" "
					else:
						s = s + "nonExist "
			s = s + ";\n"
			self.cncf.write(s.encode("utf-8"))
		elif self.pos == "pridevnik" and self.pos2 == u"splošni":
			ident = self.gen_id(self.lemma, "A")
			s = " " + ident + " : A ;\n"
			self.absf.write(s.encode("utf-8"))

			max_forms = 0
			for msd in self.forms.keys():
				max_forms = max(max_forms, len(self.forms[msd]))
			s = " " + ident + " = "
			for i in range(max_forms):
				if i > 0:
					s = s + "\n" + " " * (len(ident) + 2) + "| "
				s = s + "mkA "
				tags = ["Ppnmein", "Ppnmeid", "Ppnmer", "Ppnmed", "Ppnmet", "Ppnmetn", "Ppnmetd", "Ppnmem", "Ppnmeo", "Ppnmdi", "Ppnmdr", "Ppnmdd", "Ppnmdt", "Ppnmdm", "Ppnmdo", "Ppnmmi", "Ppnmmr", "Ppnmmd", "Ppnmmt", "Ppnmmm", "Ppnmmo", "Ppnzei", "Ppnzer", "Ppnzed", "Ppnzet", "Ppnzem", "Ppnzeo", "Ppnzdi", "Ppnzdr", "Ppnzdd", "Ppnzdt", "Ppnzdm", "Ppnzdo", "Ppnzmi", "Ppnzmr", "Ppnzmd", "Ppnzmt", "Ppnzmm", "Ppnzmo", "Ppnsei", "Ppnser", "Ppnsed", "Ppnset", "Ppnsem", "Ppnseo", "Ppnsdi", "Ppnsdr", "Ppnsdd", "Ppnsdt", "Ppnsdm", "Ppnsdo", "Ppnsmi", "Ppnsmr", "Ppnsmd", "Ppnsmt", "Ppnsmm", "Ppnsmo",
				        "Pppmeid",            "Pppmer", "Pppmed", "Pppmet",            "Pppmetd", "Pppmem", "Pppmeo", "Pppmdi", "Pppmdr", "Pppmdd", "Pppmdt", "Pppmdm", "Pppmdo", "Pppmmi", "Pppmmr", "Pppmmd", "Pppmmt", "Pppmmm", "Pppmmo", "Pppzei", "Pppzer", "Pppzed", "Pppzet", "Pppzem", "Pppzeo", "Pppzdi", "Pppzdr", "Pppzdd", "Pppzdt", "Pppzdm", "Pppzdo", "Pppzmi", "Pppzmr", "Pppzmd", "Pppzmt", "Pppzmm", "Pppzmo", "Pppsei", "Pppser", "Pppsed", "Pppset", "Pppsem", "Pppseo", "Pppsdi", "Pppsdr", "Pppsdd", "Pppsdt", "Pppsdm", "Pppsdo", "Pppsmi", "Pppsmr", "Pppsmd", "Pppsmt", "Pppsmm", "Pppsmo",
				        "Ppsmeid",            "Ppsmer", "Ppsmed", "Ppsmet",            "Ppsmetd", "Ppsmem", "Ppsmeo", "Ppsmdi", "Ppsmdr", "Ppsmdd", "Ppsmdt", "Ppsmdm", "Ppsmdo", "Ppsmmi", "Ppsmmr", "Ppsmmd", "Ppsmmt", "Ppsmmm", "Ppsmmo", "Ppszei", "Ppszer", "Ppszed", "Ppszet", "Ppszem", "Ppszeo", "Ppszdi", "Ppszdr", "Ppszdd", "Ppszdt", "Ppszdm", "Ppszdo", "Ppszmi", "Ppszmr", "Ppszmd", "Ppszmt", "Ppszmm", "Ppszmo", "Ppssei", "Ppsser", "Ppssed", "Ppsset", "Ppssem", "Ppsseo", "Ppssdi", "Ppssdr", "Ppssdd", "Ppssdt", "Ppssdm", "Ppssdo", "Ppssmi", "Ppssmr", "Ppssmd", "Ppssmt", "Ppssmm", "Ppssmo"]
				for msd in tags:
					if self.forms.has_key(msd):
						s = s + "\"" + self.forms[msd][min(i,len(self.forms[msd])-1)] + "\" "
					else:
						s = s + "nonExist "
			s = s + ";\n"
			self.cncf.write(s.encode("utf-8"))

parser = xml.sax.make_parser()
handler = InkscapeSvgHandler()
parser.setContentHandler(handler)
parser.parse(open("Sloleks_v1.2.xml","r"))
handler.close()

