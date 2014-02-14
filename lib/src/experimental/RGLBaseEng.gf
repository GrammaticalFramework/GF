concrete RGLBaseEng of RGLBase = 

-- modules in Grammar, excluding Structural, Verb, Sentence, Question
----  Tense,
  NounEng - [PPartNP],               -- to be generalized
  AdjectiveEng,
  NumeralEng,
  ConjunctionEng,
  AdverbEng,
  PhraseEng,
----  Sentence,
  QuestionEng - [QuestCl,QuestVP,QuestSlash,QuestIAdv,QuestIComp],
  RelativeEng - [RelCl,RelVP,RelSlash],
----  Idiom [NP, VP, Cl, Tense, ProgrVP, ExistNP, SelfAdvVP, SelfAdVVP, SelfNP], ---- why only these?

  SymbolEng [PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP] ;          ---- why only these?

----  Construction,
----  Extensions,
----  Documentation ;
