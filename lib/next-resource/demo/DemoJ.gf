--# -path=.:alltenses

incomplete concrete DemoJ of Demo = 
  Noun - [AdvCN,PredetNP,PPartNP,RelNP,RelCN,SentCN,
             ApposCN,MassNP,DetNP,ComplN3,Use2N3,Use3N3,AdvNP], 
--  Verb, 
  Clause, --
  Adjective - [SentAP,ComplA2,UseA2,DemoA2],
  Adverb,
  Numeral,
----  Sentence,
  Question - [QuestVP,QuestSlash],
----  Relative,
----  Conjunction,
----  Phrase,
----  TextX,
----  Idiom,
  Structural - [everybody_NP,everything_NP,something_NP],
  Lexicon
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
