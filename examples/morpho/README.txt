AR 15/8/2008

Here are some examples of morphological lexica turned into top-level GF grammars.

Top level is useful because it supports analysis and synthesis by normal 
e.g. JavaScript tools.

The simplest example is in the following three files:

  Eng.gf       -- abstract syntax (English irregular verbs)
  EngDescr.gf  -- concrete syntax showing form descriptions
  EngReal.gf   -- concrete syntax showing real forms

Compile the result with 

  gfc --make -f js EngDescr.gf EngReal.gf

Then use Eng.js in place of GF/lib/javascript/grammar.js

Other examples:

  Fre*  -- French irregular verbs

NB: there are issues on character encoding of abstract verb names in Fre.

