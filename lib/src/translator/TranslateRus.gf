--# -path=.:../chunk:alltenses

concrete TranslateRus of Translate = 
  TenseX - [IAdv, CAdv],
  CatRus,
  NounRus - [PPartNP],
  AdjectiveRus,
  NumeralRus,
  SymbolRus [
    PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP
    ],
  ConjunctionRus,
  VerbRus -  [
    UseCopula,  
    PassV2  -- generalized in Extensions
    ],
  AdverbRus,
  PhraseRus,
  SentenceRus,
  QuestionRus,
  RelativeRus,
  IdiomRus,
  ConstructionRus,
  DocumentationRus,

  ChunkRus,
  ExtensionsRus [
    ListVPS,BaseVPS,ConsVPS,ConjVPS,ListVPI,BaseVPI,ConsVPI,ConjVPI,
    CompoundN,AdAdV,UttAdV,ApposNP,MkVPI, MkVPS, PredVPS, PassVPSlash, PassAgentVPSlash, CompoundAP,
    DirectComplVS, DirectComplVQ, FocusObjS,
    PastPartAP, PastPartAgentAP, PresPartAP, GerundNP, GerundAdv,
    WithoutVP, InOrderToVP, ByVP
    ],

  DictionaryRus ** 
{

flags
  literal=Symb ;

}

