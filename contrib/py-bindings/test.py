#!/usr/bin/env python
# GF Python bindings
# Jordi Saludes 2010
#
 

import gf
import unittest


samples = [
	(['Odd', ['Number', 89]],
	 {'eng': "is 89 odd",
	  'spa': "89 es impar"}),
	(['Prime', ['Number', 21]],
	 {'eng': "is 21 prime",
	  'spa': "21 es primo"})]

def lang2iso(l):
	s = rmprefix(l)
	assert(s[:5],"Query")
	return s[5:].lower()

def exp2str(e):
	def e2s(e,n):
		if type(e) == type([2]):
			f = e[0]
			sr = ' '.join([e2s(arg,n+1) for arg in e[1:]])
			ret =f + ' ' + sr
			return n and '('+ret+')' or ret
		elif type(e) == type('2'):
			return e
		elif type(e) == type(2):
			return `e`
		else:
			raise ValueError, "Do not know how to render " + `e`
	return e2s(e,0)
		

import re
hexre = re.compile('0x[0-9a-f]+:[ ]*')
def rmprefix(obj):
	return `obj`
#	s = `obj`
#	m = hexre.match(s)
#	return m and s[m.end(0):]

class TestPgfInfo(unittest.TestCase):
	def pgf(self, path=None):
		path = path or self.path
		return gf.read_pgf(path)
	def setUp(self):
		self.path = 'Query.pgf'
	def test_readPgf(self):
		pgf = self.pgf()
		self.assertNotEqual(pgf,None)
	def test_readNonExistent(self):
		nopath = 'x' + self.path
		self.assertRaises(IOError, self.pgf, nopath)
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
	def test_functions(self):
		pgf = self.pgf()
		self.assertTrue('Even' in [`f` for f in pgf.functions()])
	def test_function_types(self):
		pgf = self.pgf()
		gftypes = dict((`f`,`pgf.fun_type(f)`) for f in pgf.functions())
		for p in "Prime : Object -> Question; Yes : Answer".split(';'):
			lhs,rhs = [s.strip() for s in p.split(':')]
			self.assertEqual(gftypes[lhs],rhs)

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
			rabs = exp2str(abs)
			ps = pgf.parse(cnc['eng'], l)
			self.failUnless(ps)
			pt = rmprefix(ps[0])
			self.assertEqual(pt,rabs)


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

class TestUnapplyExpr(unittest.TestCase):
	def setUp(self):
		self.samples = samples
		self.pgf = gf.read_pgf('Query.pgf')
		self.langs = dict([(lang2iso(l),l) for l in self.pgf.languages()])

	def deep_unapp(self,exp):
		exp = exp.unapply()
		if type(exp) == type([2]):
			f = exp[0]
			return [`f`] + map(self.deep_unapp,exp[1:])
		else:
			return exp
		

	def test_unapply(self):
		lg = 'eng'
		lang = self.langs[lg]
		for abs,cnc in self.samples:
			parsed = self.pgf.parse(cnc[lg],lang)
			uparsed = self.deep_unapp(parsed[0])
			self.assertEqual(abs,uparsed)

	def test_infer(self):
		lg = 'eng'
		lang = self.langs[lg]
		cnc = self.samples[0][1]
		parsed = self.pgf.parse(cnc[lg],lang)
		exp = parsed[0]
		for t in 'Question Object Int'.split():
			self.assertEqual(`exp.infer(self.pgf)`, t)
			uexp = exp.unapply()
			if type(uexp) != type(2) and type(uexp) != type('2'):
				exp = uexp[1]


if __name__ == '__main__':
	unittest.main()
