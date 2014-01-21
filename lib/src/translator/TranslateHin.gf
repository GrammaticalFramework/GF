--# -path=.:../abstract:../hindi:../hindustani
concrete TranslateHin of Translate = 
  TenseX - [AdN,Adv,SC,PPos,PNeg],
--  TextX - [AdN,Adv,SC],
  CatHin,
  NounHin - [PPartNP],
  AdjectiveHin,
  NumeralHin,
  ConjunctionHin,
  VerbHin - [SlashV2V, PassV2, UseCopula, ComplVV, VPSlashPrep],
  AdverbHin,
  PhraseHin,
  SentenceHin,
  RelativeHin,
  QuestionHin,
  IdiomHin [NP, VP, Tense, Cl, ProgrVP, ExistNP],

  SymbolHin [PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP, addGenitiveS],

  ExtensionsHin,
  DictionaryHin ** 
open MorphoHin, ResHin, ParadigmsHin, Prelude in {

flags
  literal=Symb ;
  coding=utf8 ;

}
