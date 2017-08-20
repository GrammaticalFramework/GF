incomplete concrete ExtendFunctor of Extend = open Grammar in {

lincat
  VPS = Grammar.VP ;
  [VPS] = Grammar.VP ;

  RNP = Grammar.NP ;
  RNPList = Grammar.ListNP ;

lin
  BaseVPS = variants {} ;
  ConsVPS = variants {} ;
  

lin
  GenNP = variants {} ;     -- NP -> Quant ; -- this man's
  GenIP = variants {} ;     -- IP -> IQuant ; -- whose
  GenRP = variants {} ;     -- Num -> CN -> RP ; -- whose car
  GenModNP = variants {} ;     -- Num -> NP -> CN -> NP ; -- this man's car(s)
  GenModIP = variants {} ;     -- Num -> IP -> CN -> IP ; -- whose car(s)
  CompBareCN = variants {} ;     -- CN -> Comp ; -- (est) professeur
  StrandQuestSlash = variants {} ;     -- IP -> ClSlash -> QCl ; -- whom does John live with
  StrandRelSlash = variants {} ;     -- RP -> ClSlash -> RCl ; -- that he lives in
  EmptyRelSlash = variants {} ;     -- ClSlash -> RCl ; -- he lives in
  MkVPS = variants {} ;     -- Temp -> Pol -> VP -> VPS ; -- to sleep / hasn't slept
  ConjVPS = variants {} ;     -- Conj -> [VPS] -> VPS ; -- has walked and won't sleep
  PredVPS = variants {} ;     -- NP -> VPS -> S ; -- she [has walked and won't sleep]
  ComplVPSVV = variants {} ;     -- VV -> VPS -> VP ; -- want to sleep and to walk
  PredVPSVV = variants {} ;     -- NP -> VV -> VPS -> VP ; -- she wants to sleep and to walk
  ProDrop = variants {} ;     -- Pron -> Pron ; -- unstressed subject pronoun becomes []: "(io) sono stanco"
  ICompAP = variants {} ;     -- AP -> IComp ; -- "how old"
  IAdvAdv = variants {} ;     -- Adv -> IAdv ; -- "how often"
  CompIQuant = variants {} ;     -- IQuant -> IComp ; -- which (is it) [agreement to NP]
  PrepCN = variants {} ;     -- Prep -> CN -> Adv ; -- by accident [Prep + CN without article]
  FocusObj = variants {} ;     -- NP -> SSlash -> Utt ; -- her I love
  FocusAdv = variants {} ;     -- Adv -> S -> Utt ; -- today I will sleep
  FocusAdV = variants {} ;     -- AdV -> S -> Utt ; -- never will I sleep
  FocusAP = variants {} ;     -- AP -> NP -> Utt ; -- green was the tree
  ParticipleAP = variants {} ;     -- VP -> AP ; -- (the man) looking at Mary
  EmbedPresPart = variants {} ;     -- VP -> SC ; -- looking at Mary (is fun)
  PassVPSlash = variants {} ;     -- VPSlash -> VP ; -- be forced to sleep
  PassAgentVPSlash = variants {} ;     -- VPSlash -> NP -> VP ; -- be begged by her to go
  PastPartAP = variants {} ;     -- VPSlash -> AP ; -- lost (opportunity) ; (opportunity) lost in space
  PastPartAgentAP = variants {} ;     -- VPSlash -> NP -> AP ; -- (opportunity) lost by the company
  NominalizeVPSlashNP = variants {} ;     -- VPSlash -> NP -> NP ;
  ExistsNP = variants {} ;     -- NP -> Cl ; -- there exists a number / there exist numbers
  PurposeVP = variants {} ;     -- VP -> Adv ; -- to become happy
  ComplBareVS = variants {} ;     -- VS -> S -> VP ; -- say she runs
  SlashBareV2S = variants {} ;     -- V2S -> S -> VPSlash ; -- answer (to him) it is good
  FrontExtPredVP = variants {} ;     -- NP -> VP -> Cl ; -- I am here, she said
  InvFrontExtPredVP = variants {} ;     -- NP -> VP -> Cl ; -- I am here, said she
  AdjAsCN = variants {} ;     -- AP -> CN ; -- a green one ; en grön (Swe)
  AdjAsNP = variants {} ;     -- AP -> NP ; -- green (is good)
  ReflRNP = variants {} ;     -- VPSlash -> RNP -> VP ; -- love my family and myself
  ReflPron = variants {} ;     -- RNP ; -- myself
  ReflPoss = variants {} ;     -- Num -> CN -> RNP ; -- my car(s)
  PredetRNP = variants {} ;     -- Predet -> RNP -> RNP ; -- all my brothers
  ConjRNP = variants {} ;     -- Conj -> RNPList -> RNP ; -- my family, John and myself
  Base_rr_RNP = variants {} ;     -- RNP -> RNP -> RNPList ; -- my family, myself
  Base_nr_RNP = variants {} ;     -- NP -> RNP -> RNPList ; -- John, myself
  Base_rn_RNP = variants {} ;     -- RNP -> NP -> RNPList ; -- myself, John
  Cons_rr_RNP = variants {} ;     -- RNP -> RNPList -> RNPList ; -- my family, myself, John
  Cons_nr_RNP = variants {} ;     -- NP -> RNPList -> RNPList ; -- John, my family, myself
  ComplVV = variants {} ;     -- VV -> Ant -> Pol -> VP -> VP ; -- want not to have slept
  SlashV2V = variants {} ;     -- V2V -> Ant -> Pol -> VPS -> VPSlash ; -- force (her) not to have slept
  CompoundN = variants {} ;     -- N -> N -> N ; -- control system / controls system / control-system
  CompoundAP = variants {} ;     -- N -> A -> AP ; -- language independent / language-independent
  GerundCN = variants {} ;     -- VP -> CN ; -- publishing of the document (can get a determiner)
  GerundNP = variants {} ;     -- VP -> NP ; -- publishing the document (by nature definite)
  GerundAdv = variants {} ;     -- VP -> Adv ; -- publishing the document (prepositionless adverb)
  WithoutVP = variants {} ;     -- VP -> Adv ; -- without publishing the document
  ByVP = variants {} ;     -- VP -> Adv ; -- by publishing the document
  InOrderToVP = variants {} ;     -- VP -> Adv ; -- (in order) to publish the document
  ApposNP = variants {} ;     -- NP -> NP -> NP ; -- Mr Macron, the president of France,
  AdAdV = variants {} ;     -- AdA -> AdV -> AdV ; -- almost always
  UttAdV = variants {} ;     -- AdV -> Utt ; -- always(!)
  PositAdVAdj = variants {} ;     -- A -> AdV ; -- (that she) positively (sleeps)
  CompS = variants {} ;     -- S -> Comp ; -- (the fact is) that she sleeps
  CompQS = variants {} ;     -- QS -> Comp ; -- (the question is) who sleeps
  CompVP = variants {} ;     -- Ant -> Pol -> VP -> Comp ; -- (she is) to go

}