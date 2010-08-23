--# -path=.:alltenses

concrete DemoSwe of Demo = LangSwe - [
          PredetNP, PPartNP, AdvNP, RelNP, DetNP, DetQuantOrd,
            NumDigits, AdNum, OrdDigits, OrdNumeral, OrdSuperl, MassNP,
            ComplN2, ComplN3, UseN2, Use2N3, Use3N3, AdjCN, RelCN,
          AdvCN, SentCN, ApposCN,
          PassV2, CompAdv, 
            -- CompNP,
            SlashV2V, SlashV2VNP, ---
          ComparA, ComplA2, ReflA2, UseA2, UseComparA, CAdvAP, AdjOrd, SentAP, AdAP,
          PredSCVP, AdvSlash, SlashPrep, SlashVS, 
            EmbedS, EmbedQS, EmbedVP, UseSlash, AdvS, RelS, 
          CompIP,
          PConjConj, VocNP, UttVP,
          FunRP,
          nothing_NP, nobody_NP, please_Voc, otherwise_PConj, therefore_PConj, but_PConj,
            language_title_Utt, whatPl_IP, whoPl_IP, if_then_Conj, either7or_DConj,
            both7and_DConj, much_Det, that_Subj, no_Quant,
          ImpersCl, GenericCl, CleftNP, CleftAdv, ProgrVP, ImpPl1, ImpP3,
            -- ExistNP, ---
          ConsNP, ConsAdv, ConsS, ConsRS, ConsAP
  ] ** 
  open LangSwe in {

  lin 
    AdjN ap n = AdjCN ap (UseN n) ;
    AdAdj ad a = AdAP ad (PositA a) ;

}
