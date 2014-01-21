--# -path=alltenses:../bulgarian:../abstract
concrete TranslateBul of Translate = 
  TenseX - [IAdv, CAdv],
  CatBul,
  NounBul - [PPartNP],
  AdjectiveBul,
  NumeralBul,
  SymbolBul [PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP],
  ConjunctionBul,
  VerbBul - [SlashV2V, PassV2, UseCopula, ComplVV],
  AdverbBul,
  PhraseBul,
  SentenceBul,
  QuestionBul,
  RelativeBul,
  IdiomBul [NP, VP, Tense, Cl, ProgrVP, ExistNP],
  ExtensionsBul,
  DictionaryBul ** 
open ResBul, Prelude in {

flags
  literal=Symb ;
  coding = utf8 ;

}
