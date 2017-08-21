--# -path=.:../chunk:alltenses

concrete TranslateUrd of Translate = 
  TenseX - [AdN,Adv,SC],
  CatUrd,
  NounUrd - [PPartNP],
  AdjectiveUrd,
  NumeralUrd,
  SymbolUrd [
    PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP
    ],
  ConjunctionUrd,
  VerbUrd -  [
    UseCopula,  
    PassV2  -- generalized in Extensions
    ],
  AdverbUrd,
  PhraseUrd,
  SentenceUrd,
  QuestionUrd,
  RelativeUrd,
  IdiomUrd,
  ConstructionUrd,
  DocumentationUrd,

  ChunkUrd,
  ExtensionsUrd [    ListVPS,BaseVPS,ConsVPS,ConjVPS,ListVPI,BaseVPI,ConsVPI,ConjVPI,
CompoundN,AdAdV,UttAdV,ApposNP,MkVPI, MkVPS, PredVPS, PassVPSlash, PassAgentVPSlash],

  DictionaryUrd ** 
open MorphoUrd, ResUrd, ParadigmsUrd, SyntaxUrd, CommonScand, (E = ExtraUrd), Prelude in {

flags
  literal=Symb ;

}
