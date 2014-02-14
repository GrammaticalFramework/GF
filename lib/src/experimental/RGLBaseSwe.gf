concrete RGLBaseSwe of RGLBase = 

-- modules in Grammar, excluding Structural, Verb, Sentence, Question
----  Tense,
  NounSwe - [PPartNP],               -- to be generalized
  AdjectiveSwe,
  NumeralSwe,
  ConjunctionSwe,
  AdverbSwe,
  PhraseSwe,
----  Sentence,
  QuestionSwe - [QuestCl,QuestVP,QuestSlash,QuestIAdv,QuestIComp],
  RelativeSwe - [RelCl,RelVP,RelSlash],
----  Idiom [NP, VP, Cl, Tense, ProgrVP, ExistNP, SelfAdvVP, SelfAdVVP, SelfNP], ---- why only these?

  SymbolSwe [PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP] ;          ---- why only these?

----  Construction,
----  Extensions,
----  Documentation ;
