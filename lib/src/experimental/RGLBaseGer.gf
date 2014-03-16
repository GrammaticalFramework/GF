concrete RGLBaseGer of RGLBase = 

-- modules in Grammar, excluding Structural, Verb, Sentence, Question
  TenseGer - [TTAnt],
  NounGer - [PPartNP],               -- to be generalized
  AdjectiveGer,
  NumeralGer,
  ConjunctionGer,
  AdverbGer,
  PhraseGer,
----  Sentence,
  QuestionGer - [QuestCl,QuestVP,QuestSlash,QuestIAdv,QuestIComp],
  RelativeGer - [RelCl,RelVP,RelSlash],
----  Idiom [NP, VP, Cl, Tense, ProgrVP, ExistNP, SelfAdvVP, SelfAdVVP, SelfNP], ---- why only these?

  SymbolGer [PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP] ;          ---- why only these?

----  Construction,
----  Extensions,
----  Documentation ;
