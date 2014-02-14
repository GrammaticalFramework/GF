abstract RGLBase = 

-- modules in Grammar, excluding Structural, Verb, Sentence, Question
----  Tense,
  Noun - [PPartNP],               -- to be generalized
  Adjective,
  Numeral,
  Conjunction,
  Adverb,
  Phrase,
----  Sentence,
  Question - [QuestCl,QuestVP,QuestSlash,QuestIAdv,QuestIComp],
  Relative - [RelCl,RelVP,RelSlash],
----  Idiom [NP, VP, Cl, Tense, ProgrVP, ExistNP, SelfAdvVP, SelfAdVVP, SelfNP], ---- why only these?

  Symbol [PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP] ;          ---- why only these?

----  Construction,
----  Extensions,
----  Documentation ;
