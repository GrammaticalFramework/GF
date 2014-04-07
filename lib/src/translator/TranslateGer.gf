--# -path=.:../chunk:alltenses

concrete TranslateGer of Translate = 
  TenseGer,
  NounGer - [PPartNP],
  AdjectiveGer,
  NumeralGer,
  SymbolGer [
    PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP
    ],
  ConjunctionGer,
  VerbGer -  [
    UseCopula,  
    SlashV2V, PassV2, ComplVV  -- generalized in Extensions
    ],
  AdverbGer,
  PhraseGer,
  SentenceGer,
  QuestionGer,
  RelativeGer,
  IdiomGer [
    NP, VP, Tense, Cl, ProgrVP, ExistNP, SelfAdvVP, SelfAdVVP, SelfNP, 
    neutr, sjalv
    ],
  ConstructionGer,
  DocumentationGer,

  ChunkGer,
  ExtensionsGer [CompoundCN,AdAdV,UttAdV,ApposNP,MkVPI, MkVPS, PredVPS, PassVPSlash, PassAgentVPSlash],

  DictionaryGer ** 
open MorphoGer, ResGer, ParadigmsGer, SyntaxGer, CommonScand, (E = ExtraGer), Prelude in {

flags
  literal=Symb ;

}
