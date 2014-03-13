concrete RGLBaseIta of RGLBase = 

-- modules in Grammar, excluding Structural, Verb, Sentence, Question
  TenseIta - [TTAnt],
  NounIta - [PPartNP],               -- to be generalized
  AdjectiveIta,
  NumeralIta,
  ConjunctionIta,
  AdverbIta,
  PhraseIta,
----  Sentence,
  QuestionIta - [QuestCl,QuestVP,QuestSlash,QuestIAdv,QuestIComp],
  RelativeIta - [RelCl,RelVP,RelSlash],
----  Idiom [NP, VP, Cl, Tense, ProgrVP, ExistNP, SelfAdvVP, SelfAdVVP, SelfNP], ---- why only these?

  SymbolIta [PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP] ;          ---- why only these?

----  Construction,
----  Extensions,
----  Documentation ;
