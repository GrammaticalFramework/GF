concrete RGLBaseFin of RGLBase = 

-- modules in Grammar, excluding Structural, Verb, Sentence, Question
----  Tense,
  NounFin - [PPartNP],               -- to be generalized
  AdjectiveFin,
  NumeralFin,
  ConjunctionFin,
  AdverbFin,
  PhraseFin,
----  Sentence,
----  Question,
  RelativeFin - [RelCl,RelVP,RelSlash],
----  Idiom [NP, VP, Cl, Tense, ProgrVP, ExistNP, SelfAdvVP, SelfAdVVP, SelfNP], ---- why only these?

  SymbolFin [PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP] ;          ---- why only these?

----  Construction,
----  Extensions,
----  Documentation ;
