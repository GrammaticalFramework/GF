--# -path=.:../chinese:../abstract

concrete TranslateChi of Translate = 
  TenseChi,
  NounChi - [PPartNP],
  AdjectiveChi,
  NumeralChi,
  SymbolChi [PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP],
  ConjunctionChi,
  VerbChi - [
    SlashV2V, PassV2, UseCopula, ComplVV,
    CompAP, AdvVP  -- Chi exceptions
    ],
  AdverbChi,
  PhraseChi,
  SentenceChi,
  QuestionChi - [
    QuestCl  -- Chi exception
    ],
  RelativeChi,
  IdiomChi [NP, VP, Tense, Cl, ProgrVP, ExistNP, SelfAdvVP, SelfAdVVP, SelfNP],
  ConstructionChi,
  ExtensionsChi,
  DictionaryChi
   ** 
open ResChi, ParadigmsChi, SyntaxChi, Prelude, (G = GrammarChi), (E = ExtraChi) in {

flags
  literal = Symb ;
  coding = utf8 ;


-- Chinese-specific overrides

lin
  CompAP = G.CompAP | E.CompBareAP ;                     -- he is good | he good

  AdvVP vp adv = E.TopicAdvVP vp adv | G.AdvVP vp adv ;  -- he *today* here sleeps | *today* he here sleeps

  QuestCl cl = G.QuestCl cl | E.QuestRepV cl ;           -- he comes 'ma' | he come not come

}
