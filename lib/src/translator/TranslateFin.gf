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
    UseCopula,  -- not used  
    CompAP,  -- variant Nom/Part
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
  ExtensionsFin [
    ListVPS,BaseVPS,ConsVPS,ConjVPS,ListVPI,BaseVPI,ConsVPI,ConjVPI,
      CompoundN,AdAdV,UttAdV,ApposNP,MkVPI, MkVPS, PredVPS, PassVPSlash, PassAgentVPSlash, CompoundAP,
      DirectComplVS, DirectComplVQ, FocusObjS
    , PastPartAP, PastPartAgentAP, PresPartAP, GerundNP, GerundAdv
    , WithoutVP, InOrderToVP, ByVP
  ],

  DictionaryFin ** 

open MorphoFin, ResFin, ParadigmsFin, SyntaxFin, StemFin, (E = ExtraFin), (G = GrammarFin), Prelude in {

flags literal=Symb ; coding = utf8 ;


lin
  CompAP ap = G.CompAP ap 
    | 
   {s = \\agr => 
          let
            n = complNumAgr agr ;
            c = Part ;
          in ap.s ! False ! (NCase n c)
      } ;
}

