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
    PassV2  -- generalized in Extensions
    ],
  AdverbHin,
  PhraseHin,
  SentenceHin,
  QuestionHin,
  RelativeHin,
  IdiomHin,
  ConstructionHin,
  DocumentationHin,

  ChunkHin,
  ExtensionsHin [    ListVPS,BaseVPS,ConsVPS,ConjVPS,ListVPI,BaseVPI,ConsVPI,ConjVPI,
CompoundN,AdAdV,UttAdV,ApposNP,MkVPI, MkVPS, PredVPS, PassVPSlash, PassAgentVPSlash],

  DictionaryHin ** 
open MorphoHin, ResHin, ParadigmsHin, SyntaxHin, CommonScand, (E = ExtraHin), Prelude in {

flags
  literal=Symb ;

}
