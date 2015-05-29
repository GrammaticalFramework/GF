--# -path=.:../chunk:alltenses

concrete TranslateCat of Translate = 
  TenseCat,
  NounCat - [
    PPartNP
    ],
  AdjectiveCat,
  NumeralCat,
  SymbolCat [
    PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP
    ],
  ConjunctionCat,
  VerbCat -  [
    UseCopula,  
    PassV2  -- generalized in Extensions
    ],
  AdverbCat,
  PhraseCat,
  SentenceCat,
  QuestionCat,
  RelativeCat,
  IdiomCat,
  ConstructionCat,
  DocumentationCat,

  ChunkCat,
  ExtensionsCat [    ListVPS,BaseVPS,ConsVPS,ConjVPS,ListVPI,BaseVPI,ConsVPI,ConjVPI,
CompoundN,AdAdV,UttAdV,ApposNP,MkVPI, MkVPS, PredVPS, PassVPSlash, PassAgentVPSlash, CompoundAP],

  DictionaryCat ** 
open MorphoCat, ResCat, ParadigmsCat, SyntaxCat, (E = ExtraCat), (G = GrammarCat), Prelude in {

flags
  literal=Symb ;

}

