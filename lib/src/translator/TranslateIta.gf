--# -path=.:../chunk:alltenses

concrete TranslateIta of Translate = 
  TenseIta,
  NounIta - [PPartNP],
  AdjectiveIta,
  NumeralIta,
  SymbolIta [
    PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP
    ],
  ConjunctionIta,
  VerbIta -  [
    UseCopula,  
    PassV2  -- generalized in Extensions
    ],
  AdverbIta,
  PhraseIta,
  SentenceIta,
  QuestionIta,
  RelativeIta,
  IdiomIta,
--  ConstructionIta,
  DocumentationIta,

  ChunkIta,
  ExtensionsIta [CompoundCN,AdAdV,UttAdV,ApposNP,MkVPI, MkVPS, PredVPS, PassVPSlash, PassAgentVPSlash, CompoundAP],

  DictionaryIta ** 
open MorphoIta, ResIta, ParadigmsIta, SyntaxIta, CommonScand, (E = ExtraIta), Prelude in {

flags
  literal=Symb ;

}

