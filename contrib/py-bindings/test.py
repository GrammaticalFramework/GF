#!/usr/bin/env python
import gf
import unittest


samples = [
	('is 89 odd',"Odd (Number 89)"),
	('is 21 prime',"Prime (Number 21)")]

import re
hexre = re.compile('0x[0-9a-f]+:[ ]*')
def rmprefix(obj):
	return `obj`
#	s = `obj`
#	m = hexre.match(s)
#	return m and s[m.end(0):]
	
class TestParsing(unittest.TestCase):
	def setUp(self):
		self.lexed = samples
		self.lang = 'QueryEng'
		self.pgf = "Query.pgf"
	def test_createPgf(self):
		q = gf.read_pgf(self.pgf)
		self.assertNotEqual(q,None)
	def test_startcat(self):
		pgf = gf.read_pgf(self.pgf)
		cat = pgf.startcat()
		self.assertEqual(rmprefix(cat),'Question')
	def test_createLanguage(self):
		l = gf.read_language(self.lang) 
		self.assertEqual(rmprefix(l),self.lang)
	def test_parse(self):
		s = self.lexed[0]
		pgf = gf.read_pgf(self.pgf)
		l = gf.read_language(self.lang)
		for s,t in self.lexed:
			ps = pgf.parse(s, l)
			self.failUnless(ps)
			pt = rmprefix(ps[0])
			self.assertEqual(pt,t)


class TestLinearize(unittest.TestCase):
	def setUp(self):
		self.samples = samples
		self.pgf = gf.read_pgf('Query.pgf') 
		self.lang = gf.read_language('QueryEng')

	def test_Linearize(self):
		l = self.lang
		for s,t in self.samples:
			t = self.pgf.parse(s, l)[0]
			self.assertEqual(s,self.pgf.lin(l,t))

if __name__ == '__main__':
	unittest.main()
	if 0:
		q = gf.read_pgf('Query.pgf')
		l = gf.read_language('QueryEng')
		ts = q.parse('is 10 prime', l)
		print ts[0]
		print q.lin(l,ts[0])
