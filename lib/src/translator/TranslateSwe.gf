--# -path=.:../chunk:alltenses

concrete TranslateSwe of Translate = 
  TenseSwe,
  NounSwe - [PPartNP],
  AdjectiveSwe,
  NumeralSwe,
  SymbolSwe [
    PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP
    ],
  ConjunctionSwe,
  VerbSwe -  [
    UseCopula,  
    SlashV2V, PassV2, ComplVV  -- generalized in Extensions
    ],
  AdverbSwe,
  PhraseSwe,
  SentenceSwe,
  QuestionSwe,
  RelativeSwe,
  IdiomSwe [
    NP, VP, Tense, Cl, ProgrVP, ExistNP, SelfAdvVP, SelfAdVVP, SelfNP, 
    neutr, sjalv
    ],
  ConstructionSwe,
  DocumentationSwe,

  ChunkSwe,
  ExtensionsSwe [CompoundCN,AdAdV,UttAdV,ApposNP,MkVPI, MkVPS, PredVPS, that_RP, who_RP],

  DictionarySwe ** 
open MorphoSwe, ResSwe, ParadigmsSwe, SyntaxSwe, CommonScand, (E = ExtraSwe), Prelude in {

flags
  literal=Symb ;

}
