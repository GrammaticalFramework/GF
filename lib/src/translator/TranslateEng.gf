--# -path=.:../abstract:../english

concrete TranslateEng of Translate = 
  TenseX - [Pol, PNeg, PPos],
  CatEng,
  NounEng - [PPartNP],
  AdjectiveEng,
  NumeralEng,
  SymbolEng [
    PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP,
    addGenitiveS
    ],
  ConjunctionEng,
  VerbEng - [SlashV2V, PassV2, UseCopula, ComplVV],
  AdverbEng,
  PhraseEng,
  SentenceEng - [UseCl], -- replaced by UseCl | ContractedUseCl
  QuestionEng,
  RelativeEng,
  IdiomEng [NP, VP, Tense, Cl, ProgrVP, ExistNP, SelfAdvVP, SelfAdVVP, SelfNP],
  ConstructionEng,
  DocumentationEng,

  ExtensionsEng,
  DictionaryEng ** 
open MorphoEng, ResEng, ParadigmsEng, (S = SentenceEng), (E = ExtraEng), Prelude in {

flags
  literal=Symb ;

-- exceptional linearizations
lin
  UseCl t p cl = S.UseCl t p cl | E.ContractedUseCl t p cl ;

  PPos = {s = [] ; p = CPos} ;
  PNeg = {s = [] ; p = CNeg True} | {s = [] ; p = CNeg False} ;


}
