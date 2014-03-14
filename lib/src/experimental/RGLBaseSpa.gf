concrete RGLBaseSpa of RGLBase = 

-- modules in Grammar, excluding Structural, Verb, Sentence, Question
  TenseSpa - [TTAnt],
  NounSpa - [PPartNP],               -- to be generalized
  AdjectiveSpa,
  NumeralSpa,
  ConjunctionSpa,
  AdverbSpa,
  PhraseSpa,
----  Sentence,
  QuestionSpa - [QuestCl,QuestVP,QuestSlash,QuestIAdv,QuestIComp],
  RelativeSpa - [RelCl,RelVP,RelSlash],
----  Idiom [NP, VP, Cl, Tense, ProgrVP, ExistNP, SelfAdvVP, SelfAdVVP, SelfNP], ---- why only these?

  SymbolSpa [PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP] ;          ---- why only these?

----  Construction,
----  Extensions,
----  Documentation ;
