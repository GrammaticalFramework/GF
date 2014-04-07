--# -path=.:../chunk:alltenses

concrete TranslateHin of Translate = 
  TenseX - [AdN,Adv,SC],
  CatHin,
  NounHin - [PPartNP],
  AdjectiveHin,
  NumeralHin,
  SymbolHin [
    PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP
    ],
  ConjunctionHin,
  VerbHin -  [
    UseCopula,  
    SlashV2V, PassV2, ComplVV  -- generalized in Extensions
    ],
  AdverbHin,
  PhraseHin,
  SentenceHin,
  QuestionHin,
  RelativeHin,
  IdiomHin [
    NP, VP, Tense, Cl, ProgrVP, ExistNP, SelfAdvVP, SelfAdVVP, SelfNP, 
    neutr, sjalv
    ],
--  ConstructionHin,
  DocumentationHin,

  ChunkHin,
  ExtensionsHin [CompoundCN,AdAdV,UttAdV,ApposNP,MkVPI, MkVPS, PredVPS, PassVPSlash, PassAgentVPSlash],

  DictionaryHin ** 
open MorphoHin, ResHin, ParadigmsHin, SyntaxHin, CommonScand, (E = ExtraHin), Prelude in {

flags
  literal=Symb ;

}
