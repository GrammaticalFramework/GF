--# -path=.:alltenses

concrete DemoEng of Demo = 
  NounEng - [AdvCN,PredetNP,PPartNP,RelNP,RelCN,SentCN,ApposCN,MassNP,DetNP], 
--  VerbEng, 
  ClauseEng, --
  AdjectiveEng - [SentAP],
  AdverbEng,
  NumeralEng,
----  SentenceEng,
  QuestionEng - [QuestVP,QuestSlash],
----  RelativeEng,
----  ConjunctionEng,
----  PhraseEng,
----  TextX,
----  IdiomEng,
  StructuralEng,
  LexiconEng
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
