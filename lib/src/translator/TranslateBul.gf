--# -path=.:../chunk:alltenses

concrete TranslateBul of Translate = 
  TenseX - [IAdv, CAdv],
  CatBul,
  NounBul - [PPartNP],
  AdjectiveBul,
  NumeralBul,
  SymbolBul [
    PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP
    ],
  ConjunctionBul,
  VerbBul -  [
    UseCopula,  
    PassV2  -- generalized in Extensions
    ],
  AdverbBul,
  PhraseBul,
  SentenceBul,
  QuestionBul,
  RelativeBul,
  IdiomBul,
  ConstructionBul,
  DocumentationBul,

  ChunkBul,
  ExtensionsBul [
    ListVPS,BaseVPS,ConsVPS,ConjVPS,ListVPI,BaseVPI,ConsVPI,ConjVPI,
    CompoundN,AdAdV,UttAdV,ApposNP,MkVPI, MkVPS, PredVPS, PassVPSlash, PassAgentVPSlash, CompoundAP,
    DirectComplVS, DirectComplVQ, FocusObjS,
    PastPartAP, PastPartAgentAP, PresPartAP, GerundNP, GerundAdv,
    WithoutVP, InOrderToVP, ByVP
    ],

  DictionaryBul ** 
open MorphoBul, ResBul, ParadigmsBul, SyntaxBul, CommonScand, (E = ExtraBul), Prelude in {

flags
  literal=Symb ;

}

