--# -path=.:../chunk:alltenses

concrete TranslateTha of Translate = 
  TenseX,
  NounTha - [PPartNP],
  AdjectiveTha,
  NumeralTha,
  SymbolTha [
    PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP
    ],
  ConjunctionTha,

  VerbTha - [
    UseCopula,  -- just removed
    PassV2 -- generalized
    ],
  AdverbTha,
  PhraseTha,
  SentenceTha,
  QuestionTha,
  RelativeTha,
  IdiomTha,
--  ConstructionTha,
--  DocumentationTha,

  ChunkTha,
  ExtensionsTha [
    ListVPS,BaseVPS,ConsVPS,ConjVPS,ListVPI,BaseVPI,ConsVPI,ConjVPI,
    CompoundN,AdAdV,UttAdV,ApposNP,MkVPI, MkVPS, PredVPS, PassVPSlash, PassAgentVPSlash, CompoundAP
    , DirectComplVS, DirectComplVQ, FocusObjS
    , PastPartAP, PastPartAgentAP, PresPartAP, GerundNP, GerundAdv
    , WithoutVP, InOrderToVP, ByVP
    ],

  DictionaryTha ** 
 
  open ResTha, ParadigmsTha, SyntaxTha, Prelude, (G = GrammarTha) in {

flags
  literal = Symb ;
  coding = utf8 ;

{-
-- Thai-specific overrides

lin
  CompAP = E.CompBareAP | G.CompAP ;                      -- he good | he is good

  ExtAdvVP vp adv = G.ExtAdvVP vp adv ;
         ---- | E.TopicAdvVP vp adv  ;  -- he *today* here sleeps | *today* he here sleeps

  QuestCl cl = G.QuestCl cl | E.QuestRepV cl ;            -- he comes 'ma' | he come not come
-}

}

