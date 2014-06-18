--# -path=.:../chunk:../finnish/stemmed:../finnish:../api

concrete TranslateFin of Translate = 
  TenseX,
  CatFin,
  NounFin - [
    PPartNP
    ],
  AdjectiveFin,
  NumeralFin,
  SymbolFin [
    PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP
    ],
  ConjunctionFin,
  VerbFin -  [
    UseCopula,  
    PassV2  -- generalized in Extensions
    ],
  AdverbFin,
  PhraseFin,
  SentenceFin,
  QuestionFin,
  RelativeFin,
  IdiomFin,
  ConstructionFin,
  DocumentationFin,

  ChunkFin,
  ExtensionsFin [CompoundN,AdAdV,UttAdV,ApposNP,MkVPI, MkVPS, PredVPS, PassVPSlash, PassAgentVPSlash, CompoundAP,
                 DirectComplVS, DirectComplVQ, FocusObjS],

  DictionaryFin ** 

open MorphoFin, ResFin, ParadigmsFin, SyntaxFin, StemFin, (E = ExtraFin), (G = GrammarFin), Prelude in {

flags literal=Symb ; coding = utf8 ;

}

