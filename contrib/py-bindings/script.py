#!/usr/bin/env python
import gf
query = gf.read_pgf("Query.pgf")
lang = gf.read_language('QueryEng')
print 'start category:',query.startcat()
lexed = "is 2 prime"
print "Parsing '%s':" % lexed
for e in query.parse(lexed, lang):
    print '\t',e
