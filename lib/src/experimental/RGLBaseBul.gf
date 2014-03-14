concrete RGLBaseBul of RGLBase = 

-- modules in Grammar, excluding Structural, Verb, Sentence, Question
  TenseX - [CAdv,IAdv,TTAnt],
  NounBul - [PPartNP],               -- to be generalized
  AdjectiveBul,
  NumeralBul,
  ConjunctionBul,
  AdverbBul,
  PhraseBul,
----  Sentence,
  QuestionBul - [QuestCl,QuestVP,QuestSlash,QuestIAdv,QuestIComp],
  RelativeBul - [RelCl,RelVP,RelSlash],
----  Idiom [NP, VP, Cl, Tense, ProgrVP, ExistNP, SelfAdvVP, SelfAdVVP, SelfNP], ---- why only these?

  SymbolBul [PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP] ;          ---- why only these?

----  Construction,
----  Extensions,
----  Documentation ;
