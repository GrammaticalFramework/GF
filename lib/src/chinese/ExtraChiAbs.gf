abstract ExtraChiAbs = Cat, 

  Extra [NP, Quant, VPSlash, VP, Tense, Aspect, GenNP, PassVPSlash, PassAgentVPSlash,
            Temp, Pol, Conj, VPS, ListVPS, S, Num, CN, RP, MkVPS, BaseVPS, ConsVPS, ConjVPS, PredVPS, GenRP,
            VPI, VPIForm, VPIInf, VPIPresPart, ListVPI, VV, MkVPI, BaseVPI, ConsVPI, ConjVPI, ComplVPIVV,
            ClSlash, RCl, EmptyRelSlash]

   ** {
  cat
    Aspect ;

  fun
    CompBareAP : AP -> Comp ;      -- adjectival predication without copula

    QuestRepV : Cl -> QCl ;        -- V neg V question

    TopicAdvVP : VP -> Adv -> VP ; -- topicalized adverb
  } ;
