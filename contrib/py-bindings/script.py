#!/usr/bin/env python
from gf import *
query = read_pgf("Query.pgf")
lang = read_language('QueryEng')
cat = startcat(query)
lexed = "is 2 prime"
print "Parsing '%s':" % lexed
for e in parse(query, lang, cat, lexed):
    print '\t',e
