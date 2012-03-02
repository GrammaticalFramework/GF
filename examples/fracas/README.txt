======================
The FraCaS GF Treebank
======================

:Authors: Peter Ljunglöf, Magdalena Siverbo
:Version: 0.2
:Date: 2012-01-27
:Organization: Centre for Language Technology, University of Gothenburg
:Copyright: Distributed under GNU GPL v3, see COPYING.txt for details

1. Introduction
===============

This is the FraCaS Treebank, developed and maintained by 
the Centre for Language Technolgy at University of Gothenburg:

    http://www.clt.gu.se/

The treebank is part of the CLT Toolkit, a set of state-of-the-art
open source Language Technology tools and accompanying linguistic
resources.  The different parts of the toolkit, including the 
FraCaS Treebank, can be downloaded from:

    http://www.clt.gu.se/clt-toolkit

The treebank is built upon the FraCaS textual inference problem set, 
which was built in the mid 1990’s by the FraCaS project, a large
collaboration aimed at developing resources and theories for
computational semantics.  This test set was later modified and
converted to XML by Bill MacCartney:

    http://www-nlp.stanford.edu/~wcmac/downloads/fracas.xml

It is this modified version that has been used in this treebank. 
The corpus consists of 346 problems each containing one or more
statements and one yes/no-question (except for four problems, where
there is no question).  The total number of sentences in the corpus is
1220, but since some of them are repeated in several problems, there
are in total 874 unique sentences. 

2. Description
==============

The treebank is created in Grammatical Framework (GF), using its
multilingual Resource Grammar as backend grammar.  Currently the
treebank is bilingual, with an English and a Swedish lexicon. 

More information about GF, including installation instructions, 
can be found at: 

    http://www.grammaticalframework.org/

The treebank is also distributed in XML and Prolog formats, 
for people that have no interest in learning GF.  Note however 
that the syntactical constructions come from the GF resource grammar. 

3. Download and installation
============================

The full distribution can be downloaded from
`<dist/FraCaSBank-0.2.zip>`_.

The Prolog and XML treebanks are already generated, so to use these
you don't need anything else. But if you want to work with the GF
source files, you need a GF installation including the Resource Grammar. 

4. Contents
===========

a) Documentation
----------------

The documentation is located in the `doc directory <doc>`_:

``FraCaSBank-report.{pdf,lyx,bib}``:
  A technical report describing the treebank, together with
  the `LyX <http://www.lyx.org>`_ and 
  `BibTeX <http://www.bibtex.org>`_ source files.
  The PDF version can be `read here <doc/FraCaSBank-report.pdf>`_.

b) GF source files
------------------

The grammar sources are located in the `src directory <src>`_:

``Additions*.gf``
  Generic additions to the GF Resource Grammar.

``FraCaS*.gf``
  Grammatical constructions specific to the FraCaS domain.

``FraCaSLex*.gf``
  The lexical items in the FraCaS treebank.

``FraCaSBank*.gf``
  The actual treebank. 
  The file ``FraCaSBankOriginal.gf`` contains the original treebank sentences.
  The file ``FraCaSBankI.gf`` contains the language-independent abstract syntax trees.

c) Other files
--------------

``Makefile, build_fracasbank.py``
  Files for automatically generating the XML and Prolog treebank.

``build/FraCaSBank.{xml,pl}``
  The automatically generated 
  `XML treebank <build/FraCaSBank.xml>`_ and 
  `Prolog treebank <build/FraCaSBank.pl>`_.

``dist/FraCaSBank*.zip``
  All files collected in a zip file.

``README.txt, COPYING.txt``:
  The `source <README.txt>`_ of this README file, and `GNU GPL 3 <COPYING.txt>`_ licensing information.
