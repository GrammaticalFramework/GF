--# -path=.:alltenses

concrete DemoEng of Demo = 
  NounEng - [AdvCN,PredetNP,PPartNP,RelNP,RelCN,SentCN,
             ApposCN,MassNP,DetNP,ComplN3,Use2N3,Use3N3,AdvNP], 
--  VerbEng, 
  ClauseEng, --
  AdjectiveEng - [SentAP,ComplA2,UseA2,DemoA2],
  AdverbEng,
  NumeralEng,
----  SentenceEng,
  QuestionEng - [QuestVP,QuestSlash],
----  RelativeEng,
----  ConjunctionEng,
----  PhraseEng,
----  TextX,
----  IdiomEng,
  StructuralEng - [everybody_NP,everything_NP,something_NP],
  LexiconEng
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;
  lin foo = "bar" ;
} ;
