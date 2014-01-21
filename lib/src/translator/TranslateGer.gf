--# -path=alltenses:.:../german:../abstract
concrete TranslateGer of Translate = 
  TenseGer,
  NounGer - [PPartNP],
  AdjectiveGer,
  NumeralGer,
  SymbolGer [PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP],
  ConjunctionGer,
  VerbGer - [SlashV2V, PassV2, UseCopula, ComplVV],
  AdverbGer,
  PhraseGer,
  SentenceGer,
  QuestionGer,
  RelativeGer,
  IdiomGer [NP, VP, Tense, Cl, ProgrVP, ExistNP, SelfAdvVP, SelfAdVVP, SelfNP, geben],
  ConstructionGer,
  DocumentationGer,
  ExtensionsGer,
  DictionaryGer ** 
open MorphoGer, ResGer, ParadigmsGer, SyntaxGer, Prelude in {

flags 
  literal=Symb ; 
  coding = utf8 ;

}
