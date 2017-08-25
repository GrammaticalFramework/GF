--# -path=.:../chunk:alltenses:../basque

concrete TranslateEus of Translate = 
  TenseX,
  CatEus,
  NounEus - [PPartNP],
  AdjectiveEus,
  NumeralEus,
  VerbEus - [PassV2,UseCopula],
  SentenceEus,
  ConjunctionEus,
  AdverbEus,
  PhraseEus,
  QuestionEus,
  RelativeEus,
  IdiomEus,
  SymbolEus [PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP],          ---- why only these?
  ConstructionEus,

  ChunkEus,
  ExtensionsEus [
 --   ListVPS,BaseVPS,ConsVPS,ConjVPS,ListVPI,BaseVPI,ConsVPI,ConjVPI,
 --   CompoundN,AdAdV,UttAdV,ApposNP,MkVPI, MkVPS, PredVPS, PassVPSlash, PassAgentVPSlash, CompoundAP,
 --   DirectComplVS, DirectComplVQ, FocusObjS
 --   , PastPartAP, PastPartAgentAP, PresPartAP, GerundNP, GerundAdv ---- not yet available for all languages
     WithoutVP, InOrderToVP -- , ByVP
    ],
  DictionaryEus **
  
open ResEus, Prelude in {

flags
  literal=Symb ;

}
