abstract ExtraChiAbs = Cat, 

  Extra [NP, Quant, VPSlash, VP, Tense, Aspect, GenNP, PassVPSlash,
            Temp, Pol, Conj, VPS, ListVPS, S, Num, CN, RP, MkVPS, BaseVPS, ConsVPS, ConjVPS, PredVPS, GenRP,
            VPI, VPIForm, VPIInf, VPIPresPart, ListVPI, VV, MkVPI, BaseVPI, ConsVPI, ConjVPI, ComplVPIVV,
            ClSlash, RCl, EmptyRelSlash]

   ** {
  cat
    Aspect ;

  fun
    PredBareAP : NP -> AP -> Cl ;  -- adjectival predication without copula

    QuestRepV : Cl -> QCl ;        -- V neg V question

    TopicAdvCl : Adv -> Cl -> Cl ; -- topicalized adverb
  } ;
