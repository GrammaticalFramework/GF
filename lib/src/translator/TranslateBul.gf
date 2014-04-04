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
    SlashV2V, PassV2, ComplVV  -- generalized in Extensions
    ],
  AdverbBul,
  PhraseBul,
  SentenceBul,
  QuestionBul,
  RelativeBul,
  IdiomBul [
    NP, VP, Tense, Cl, ProgrVP, ExistNP, SelfAdvVP, SelfAdVVP, SelfNP, 
    neutr, sjalv
    ],
--  ConstructionBul,
  DocumentationBul,

  ChunkBul,
  ExtensionsBul [CompoundCN,AdAdV,UttAdV,ApposNP,MkVPI, MkVPS, PredVPS, that_RP, who_RP],

  DictionaryBul ** 
open MorphoBul, ResBul, ParadigmsBul, SyntaxBul, CommonScand, (E = ExtraBul), Prelude in {

flags
  literal=Symb ;

}

