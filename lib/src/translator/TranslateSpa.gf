--# -path=.:../chunk:alltenses

concrete TranslateSpa of Translate = 
  TenseSpa,
  NounSpa - [PPartNP],
  AdjectiveSpa,
  NumeralSpa,
  SymbolSpa [
    PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP
    ],
  ConjunctionSpa,
  VerbSpa -  [
    UseCopula,  
    SlashV2V, PassV2, ComplVV  -- generalized in Extensions
    ],
  AdverbSpa,
  PhraseSpa,
  SentenceSpa,
  QuestionSpa,
  RelativeSpa,
  IdiomSpa [
    NP, VP, Tense, Cl, ProgrVP, ExistNP, SelfAdvVP, SelfAdVVP, SelfNP, 
    neutr, sjalv
    ],
--  ConstructionSpa,
  DocumentationSpa,

  ChunkSpa,
  ExtensionsSpa [CompoundCN,AdAdV,UttAdV,ApposNP,MkVPI, MkVPS, PredVPS, PassVPSlash, PassAgentVPSlash],

  DictionarySpa ** 
open MorphoSpa, ResSpa, ParadigmsSpa, SyntaxSpa, CommonScand, (E = ExtraSpa), Prelude in {

flags
  literal=Symb ;

}

