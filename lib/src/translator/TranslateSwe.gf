--# -path=.:../swedish/:../scandinavian:../abstract
concrete TranslateSwe of Translate = 
  TenseSwe,
  NounSwe - [PPartNP],
  AdjectiveSwe,
  NumeralSwe,
  SymbolSwe [
    PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP
    ],
  ConjunctionSwe,
  VerbSwe - [SlashV2V, PassV2, UseCopula, ComplVV],
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

  ExtensionsSwe,
  DictionarySwe ** 
open MorphoSwe, ResSwe, ParadigmsSwe, SyntaxSwe, CommonScand, (E = ExtraSwe), Prelude in {

flags
  literal=Symb ;

}
