
# Copyright (C) 2011, Peter Ljunglof. All rights reserved.

# This file is part of the FraCaS Treebank.
# 
# The FraCaS Treebank is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# The FraCaS Treebank is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with the FraCaS Treebank.  If not, see <http://www.gnu.org/licenses/>.

"""
Usage: python build_fracasbank.py (xml/pl) FraCaSBankI.gf FraCaSBank{Lang}.gf ...

This script compiles the FraCaS treebank into XML or Prolog format.
The result is printed to standard output.
"""

import re


def read_treebank(treefile):
    """Reads trees from the FraCaS treebank.
    Returns a dict mapping sentence IDs to the trees.
    """
    treebank = {}
    with open(treefile) as F:
        for line in F:
            match = re.match(r"^lin +(\w+) *= *(.+?) *; *$", line)
            if match:
                sid, tree = match.group(1, 2)
                if re.match(r"^\w+$", tree):
                    pass
                elif re.match(r"^ *variants *\{ *\} *$", tree):
                    tree = None
                else:
                    tree = GFTree.parse(tree)
                treebank[sid] = {'tree': tree}
    return treebank


def linearize_language(treebank, langfile, lang):
    """Calls GF to linearize the trees in the treebank in the given language.
    Adds the results to the treebank.
    """
    from subprocess import Popen, PIPE
    gf = Popen(["gf", "--quiet", "--run", langfile], stdin=PIPE, stdout=PIPE)
    gfinput = ""
    for sid in sorted(treebank):
        gfinput += 'ps "@ %s"\nl %s\n' % (sid, sid)
    output, _error = gf.communicate(gfinput)

    for result in output.split("@"):
        try:
            sid, lin = result.split(None, 1)
        except ValueError:
            continue
        treebank[sid][lang] = lin.strip()


def print_treebank(treebank, outformat):
    """Print the treebank on the standard output.
    The outformat can be 'xml' (XML) or 'pl' (Prolog).
    """
    pro = outformat.lower() == "pl"
    xml = outformat.lower() == "xml"
    assert pro or xml, "Unknown output format: '%s'" % outformat

    if xml:
        print "<?xml version='1.0' encoding='UTF-8' ?>"
        print "<treebank>"
    if pro:
        print ":- discontiguous tree/2, sent/3."
        print "%% tree(?SentenceID, ?Tree)"
        print "%% sent(?SentenceID, ?Language, ?Sentence)"

    for sid, item in sorted(treebank.items()):
        if xml: print "<phrase id='%s'>" % sid
        if isinstance(item['tree'], basestring):
            if xml: print "<tree ref='%s'/>" % item['tree']
            if pro: print "tree(%s, %s)." % (plquote(sid), plquote(item['tree']))
        elif isinstance(item['tree'], GFTree):
            if xml: print "<tree>%s</tree>" % item['tree'].xmlstr()
            if pro: print "tree(%s, %s)." % (plquote(sid), item['tree'].prologstr())
        for lang, sent in sorted(item.items()):
            if lang != 'tree':
                if xml: print "<sent lang='%s'>%s</sent>" % (lang, sent)
                if pro: print "sent(%s, %s, %s)." % (plquote(sid), plquote(lang.lower()), plquote(sent))
        if xml: print "</phrase>"
        if pro: print

    if xml: print "</treebank>"


def plquote(atom):
    """Surround a Prolog atom with '...' if necessary."""
    if re.match(r"^(\d+|[a-z][a-zA-Z0-9_]*)$", atom):
        return atom
    else:
        return "'" + atom.replace("\\", "\\\\").replace("'", "\\'") + "'"


class GFTree(object):
    def __init__(self, node, children=[]):
        self.node = node
        self.children = list(children)

    @classmethod
    def parse(cls, descr):
        tokens = descr.replace("(", " ( ").replace(")", " ) ").split()
        if tokens[0] == "(" and tokens[-1] == ")":
            tokens = tokens[1:-1]
        result = [[]]
        for token in tokens:
            if token == "(":
                result.append([])
            elif token == ")":
                tree = result.pop()
                result[-1].append(GFTree(tree[0], tree[1:]))
            elif not result[-1]:
                result[-1].append(token)
            else:
                result[-1].append(GFTree(token))
        assert len(result) == 1
        tree = result[0]
        return GFTree(tree[0], tree[1:])

    def __str__(self):
        return "(" + " ".join(map(str, [self.node] + self.children)) + ")"

    def __repr__(self):
        return (type(self).__name__ + "(" +
                ", ".join(map(repr, [self.node] + self.children)) + ")")

    def xmlstr(self):
        return ("<t><n>" + self.node + "</n><cs>" +
                "".join(child.xmlstr() for child in self.children) +
                "</cs></t>")

    def prologstr(self):
        return ("t(" + plquote(self.node) + ", [" +
                ", ".join(child.prologstr() for child in self.children) +
                "])")


if __name__ == '__main__':
    import sys, os.path
    if len(sys.argv) < 3:
        exit(__doc__)
    outformat, treefile = sys.argv[1:3]
    languages = sys.argv[3:]
    basename = os.path.commonprefix(sys.argv[2:])
    treebank = read_treebank(treefile)
    for langfile in languages:
        lang = langfile[len(basename):]
        if lang.endswith(".gf"): lang = lang[:-3]
        linearize_language(treebank, langfile, lang)
    print_treebank(treebank, outformat)
    
