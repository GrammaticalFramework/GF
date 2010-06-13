#!/usr/bin/env python
import gf
import unittest

import re
hexre = re.compile('0x[0-9a-f]+:[ ]*')
def rmprefix(obj):
	s = `obj`
	m = hexre.match(s)
	return m and s[m.end(0):]
	
class TestParsing(unittest.TestCase):
	def setUp(self):
		self.lexed = [
			('is 89 odd',"Odd (Number 89)"),
			('is 21 prime',"Prime (Number 21)")]
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

if __name__ == '__main__':
	unittest.main()
