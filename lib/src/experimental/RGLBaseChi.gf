concrete RGLBaseChi of RGLBase = 

-- modules in Grammar, excluding Structural, Verb, Sentence, Question
----  Tense,
  NounChi - [PPartNP],               -- to be generalized
  AdjectiveChi,
  NumeralChi,
  ConjunctionChi,
  AdverbChi,
  PhraseChi,
----  Sentence,
  QuestionChi - [QuestCl,QuestVP,QuestSlash,QuestIAdv,QuestIComp],
  RelativeChi - [RelCl,RelVP,RelSlash],
----  Idiom [NP, VP, Cl, Tense, ProgrVP, ExistNP, SelfAdvVP, SelfAdVVP, SelfNP], ---- why only these?

  SymbolChi [PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP] ;          ---- why only these?

----  Construction,
----  Extensions,
----  Documentation ;
