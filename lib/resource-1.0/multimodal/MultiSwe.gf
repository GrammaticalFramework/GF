--# -path=.:alltenses:prelude

concrete MultiSwe of Multi =
  LangSwe - [
    NP, Adv, Det, Comp, VP, Cl, QCl, S, SC, QS, Imp, Utt,  -- Cat 
      QuantSg, QuantPl, Quant,
      ---- Slash, RC, AP, CN missing
    DetCN, UsePN, UsePron, PredetNP, PPartNP, AdvNP, -- Noun
      DetSg, DetPl, SgQuant, PlQuant, PossPron, DefArt, IndefArt, MassDet,
    PositAdvAdj, PrepNP, ComparAdvAdj, ComparAdvAdjS, AdAdv, SubjS, AdvSC, AdnCAdv,
    UseV, ComplV2, ComplV3, ComplVV, ComplVS, ComplVQ, ComplVA, ComplV2A,
      ReflV2, UseComp, PassV2, AdvVP, AdVVP, CompAP, CompNP, CompAdv,
    PredVP, PredSCVP, ImpVP, EmbedS, EmbedQS, EmbedVP, UseQCl, UseCl,
    QuestCl, QuestVP, QuestIAdv, QuestIComp, QuestSlash,
    PhrUtt, UttS, UttQS, UttImpSg, UttImpPl, UttNP, UttAdv, UttVP,
      UttIAdv, UttIP,
    ConjS, ConjNP, ConjAdv, DConjS, DConjNP, DConjAdv,
    everybody_NP, everything_NP, somebody_NP, something_NP, that_NP, these_NP,
      this_NP, those_NP, one_Quant, that_Quant, this_Quant,
      everywhere_Adv, here_Adv, here7to_Adv, here7from_Adv,
      somewhere_Adv, there_Adv, there7to_Adv, there7from_Adv,
      every_Det, few_Det, many_Det, much_Det, someSg_Det, somePl_Det,
    ImpersCl, GenericCl, ExistNP, ExistIP, ProgrVP, ImpPl1,
    already_Adv, far_Adv, now_Adv
    ]
  ** MultiI with
       (Lang = LangSwe) ;
