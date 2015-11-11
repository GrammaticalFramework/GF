--# -path=.:../chunk:../estonian

concrete TranslateEst of Translate = 
  TenseX,
  CatEst,
  NounEst - [
    PPartNP
    ],
  AdjectiveEst,
  NumeralEst,
  SymbolEst [
    PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP
    ],
  ConjunctionEst,
  VerbEst -  [
    UseCopula,  -- not used  
--    CompAP,  -- variant Nom/Part, in Finnish
    PassV2  -- generalized in Extensions
    ],
  AdverbEst,
  PhraseEst,
  SentenceEst,
  QuestionEst,
  RelativeEst,
  IdiomEst,
  ConstructionEst,
  DocumentationEst,

  ChunkEst,
  ExtensionsEst [
    ListVPS,BaseVPS,ConsVPS,ConjVPS,ListVPI,BaseVPI,ConsVPI,ConjVPI,
      CompoundN,AdAdV,UttAdV,ApposNP,MkVPI, MkVPS, PredVPS, PassVPSlash, PassAgentVPSlash, CompoundAP,
      DirectComplVS, DirectComplVQ, FocusObjS
    , PastPartAP, PastPartAgentAP, PresPartAP, GerundNP, GerundAdv
    , WithoutVP, InOrderToVP, ByVP
  ],

  DictionaryEst ** 

open MorphoEst, ResEst, ParadigmsEst, SyntaxEst, (E = ExtraEst), (G = GrammarEst), Prelude in {

flags literal=Symb ; coding = utf8 ;

{-
--- in Estonian, too?

lin
  CompAP ap = G.CompAP ap 
    | 
   {s = \\agr => 
          let
            n = complNumAgr agr ;
            c = Part ;
          in ap.s ! False ! (NCase n c)
      } ;
-}
}

