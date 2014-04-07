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
    SlashV2V, PassV2, ComplVV  -- generalized in Extensions
    ],
  AdverbIta,
  PhraseIta,
  SentenceIta,
  QuestionIta,
  RelativeIta,
  IdiomIta [
    NP, VP, Tense, Cl, ProgrVP, ExistNP, SelfAdvVP, SelfAdVVP, SelfNP, 
    neutr, sjalv
    ],
--  ConstructionIta,
  DocumentationIta,

  ChunkIta,
  ExtensionsIta [CompoundCN,AdAdV,UttAdV,ApposNP,MkVPI, MkVPS, PredVPS, PassVPSlash, PassAgentVPSlash],

  DictionaryIta ** 
open MorphoIta, ResIta, ParadigmsIta, SyntaxIta, CommonScand, (E = ExtraIta), Prelude in {

flags
  literal=Symb ;

}

