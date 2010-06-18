#!/usr/bin/env python
# GF Python bindings
# Jordi Saludes 2010
#
 

import gf
import unittest


samples = [
	("Odd (Number 89)",
	 {'eng': "is 89 odd",
	  'spa': "89 es impar"}),
	("Prime (Number 21)",
	 {'eng': "is 21 prime",
	  'spa': "21 es primo"})]

def lang2iso(l):
	s = rmprefix(l)
	assert(s[:5],"Query")
	return s[5:].lower()

import re
hexre = re.compile('0x[0-9a-f]+:[ ]*')
def rmprefix(obj):
	return `obj`
#	s = `obj`
#	m = hexre.match(s)
#	return m and s[m.end(0):]

class TestPgfInfo(unittest.TestCase):
	def pgf(self):
		return gf.read_pgf(self.path)
	def setUp(self):
		self.path = 'Query.pgf'
	def test_readPgf(self):
		pgf = self.pgf()
		self.assertNotEqual(pgf,None)
	def test_startcat(self):
		pgf = self.pgf()
		cat = pgf.startcat()
		self.assertEqual(rmprefix(cat),'Question')
	def test_categories(self):
		pgf = self.pgf()
		cats = [`c` for c in pgf.categories()]
		self.failUnless('Float' in cats)
		self.failUnless('Int' in cats)
		self.failUnless('String' in cats)
	def test_createLanguage(self):
		pgf = self.pgf()
		for lang in 'QueryEng QuerySpa'.split():
			l = gf.read_language(lang) 
			self.assertEqual(rmprefix(l),lang)
	
class TestParsing(unittest.TestCase):
	def setUp(self):
		self.lexed = samples
		self.lang = 'QueryEng'
		self.pgf = "Query.pgf"

	def test_parse(self):
		s = self.lexed[0]
		pgf = gf.read_pgf(self.pgf)
		l = gf.read_language(self.lang)
		for abs,cnc in self.lexed:
			ps = pgf.parse(cnc['eng'], l)
			self.failUnless(ps)
			pt = rmprefix(ps[0])
			self.assertEqual(pt,abs)


class TestLinearize(unittest.TestCase):
	def setUp(self):
		self.samples = samples
		self.pgf = gf.read_pgf('Query.pgf') 
		self.lang = gf.read_language('QueryEng')

	def test_Linearize(self):
		l = self.lang
		for abs,cnc in self.samples:
			ts = self.pgf.parse(cnc['eng'], l)
			self.assertEqual(cnc['eng'],self.pgf.lin(l,ts[0]))

class TestTranslate(unittest.TestCase):
	def setUp(self):
		self.samples = samples
		self.pgf = gf.read_pgf('Query.pgf')
		self.langs = [(lang2iso(l),l) for l in self.pgf.languages()]

	def test_translate(self):
		for abs,cnc in self.samples:
			for i,l in self.langs:
				for j,m in self.langs:
					if i==j: continue
					parsed = self.pgf.parse(cnc[i],l)
					assert len(parsed) == 1
					lin = self.pgf.lin(m,parsed[0])
					self.assertEqual(lin,cnc[j])
			
if __name__ == '__main__':
	unittest.main()
