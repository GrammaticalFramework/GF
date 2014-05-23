--# -path=.:../chunk:alltenses:../german

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
    PassV2
    ],
  AdverbGer,
  PhraseGer,
  SentenceGer,
  QuestionGer,
  RelativeGer,
  IdiomGer,
  ConstructionGer,
  DocumentationGer,

  ChunkGer,
  ExtensionsGer [CompoundCN,AdAdV,UttAdV,ApposNP,MkVPI, MkVPS, PredVPS, PassVPSlash, PassAgentVPSlash, CompoundAP,
                 DirectComplVS, DirectComplVQ, FocusObjS],

  DictionaryGer ** 
open MorphoGer, ResGer, ParadigmsGer, SyntaxGer, CommonScand, (E = ExtraGer), Prelude in {

flags
  literal=Symb ;

}
