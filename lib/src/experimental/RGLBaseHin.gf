concrete RGLBaseHin of RGLBase = 

-- modules in Grammar, excluding Structural, Verb, Sentence, Question
----  Tense,
  TenseX - [TTAnt,Adv,AdN,SC],
  NounHin - [PPartNP],               -- to be generalized
  AdjectiveHin,
  NumeralHin,
  ConjunctionHin,
  AdverbHin,
  PhraseHin,
----  Sentence,
  QuestionHin - [QuestCl,QuestVP,QuestSlash,QuestIAdv,QuestIComp],
  RelativeHin - [RelCl,RelVP,RelSlash],
----  Idiom [NP, VP, Cl, Tense, ProgrVP, ExistNP, SelfAdvVP, SelfAdVVP, SelfNP], ---- why only these?

  SymbolHin [PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP] ;          ---- why only these?

----  Construction,
----  Extensions,
----  Documentation ;
