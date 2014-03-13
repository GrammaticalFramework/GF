concrete RGLBaseFre of RGLBase = 

-- modules in Grammar, excluding Structural, Verb, Sentence, Question
  TenseFre - [TTAnt],
  NounFre - [PPartNP],               -- to be generalized
  AdjectiveFre,
  NumeralFre,
  ConjunctionFre,
  AdverbFre,
  PhraseFre,
----  Sentence,
  QuestionFre - [QuestCl,QuestVP,QuestSlash,QuestIAdv,QuestIComp],
  RelativeFre - [RelCl,RelVP,RelSlash],
----  Idiom [NP, VP, Cl, Tense, ProgrVP, ExistNP, SelfAdvVP, SelfAdVVP, SelfNP], ---- why only these?

  SymbolFre [PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP] ;          ---- why only these?

----  Construction,
----  Extensions,
----  Documentation ;
