--# -path=.:present:prelude

incomplete concrete MultiI of Multi = 
  Lang - [
    NP, Adv, VP, Cl, QCl, S, SC, QS, Imp, Utt,  -- Cat
    DetCN, UsePN, UsePron, PredetNP, PPartNP, AdvNP, -- Noun
    PositAdvAdj, PrepNP, ComparAdvAdj, ComparAdvAdjS, AdAdv, SubjS, AdvSC, AdnCAdv,
    ComplV2, ComplV3, ComplVV,
    PredVP,
    UseCl,
    PhrUtt, UttS, UttQS, UttImpSg, UttImpPl, UttNP, UttAdv, UttVP
    ] 
  ** open (Lang = Lang) in {

  flags optimize = all_subs ;

  lincat 
    NP  = Lang.NP  ** {point : Str} ;
    Adv = Lang.Adv ** {point : Str} ;
    Det = Lang.Det ** {point : Str} ;
    Comp= Lang.Comp** {point : Str} ;
    VP  = Lang.VP  ** {point : Str} ;
    Cl  = Lang.Cl  ** {point : Str} ;
    QCl = Lang.QCl ** {point : Str} ;
    S   = Lang.S   ** {point : Str} ;
    SC  = Lang.SC  ** {point : Str} ;
    QS  = Lang.QS  ** {point : Str} ;
    Imp = Lang.Imp ** {point : Str} ;
    Utt = Lang.Utt ** {point : Str} ;
    Quant = Lang.Quant ** {point : Str} ;
    QuantSg = Lang.QuantSg ** {point : Str} ;
    QuantPl = Lang.QuantPl ** {point : Str} ;

    Point  = {point : Str} ;
    Speech = {s : Str} ;

  lin
    DetCN det cn = Lang.DetCN det cn ** {point = det.point} ;
    UsePN pn = Lang.UsePN pn ** noPoint ;
    UsePron pn = Lang.UsePron pn ** noPoint ;
    PredetNP p np = Lang.PredetNP p np ** {point = np.point} ;
    PPartNP np v = Lang.PPartNP np v ** {point = np.point} ;
    AdvNP np adv = Lang.AdvNP np adv ** {point = np.point ++ adv.point} ;
    DetSg qu o = Lang.DetSg qu o ** {point = qu.point} ;
    DetPl qu n o = Lang.DetPl qu n o ** {point = qu.point} ;
    SgQuant qu = Lang.SgQuant qu ** {point = qu.point} ;
    PlQuant qu = Lang.PlQuant qu ** {point = qu.point} ;
    PossPron p = Lang.PossPron p ** noPoint ;
    DefArt = Lang.DefArt ** noPoint ;
    IndefArt = Lang.IndefArt ** noPoint ;
    MassDet = Lang.MassDet ** noPoint ;

    PositAdvAdj a = Lang.PositAdvAdj a ** noPoint ;
    PrepNP p np = Lang.PrepNP p np ** {point = np.point} ;
    ComparAdvAdj ca a np = Lang.ComparAdvAdj ca a np ** {point = np.point} ;
    ComparAdvAdjS ca a s = Lang.ComparAdvAdjS ca a s ** {point = s.point} ;
    AdAdv ad a = Lang.AdAdv ad a ** {point = a.point} ;
    SubjS su s = Lang.SubjS su s ** {point = s.point} ;
    AdvSC sc = Lang.AdvSC sc ** {point = sc.point} ;

    UseV v = Lang.UseV v ** noPoint ;
    ComplV2 v np = Lang.ComplV2 v np ** {point = np.point} ;
    ComplV3 v np p = Lang.ComplV3 v np p ** {point = np.point ++ p.point} ;
    ComplVV v vp = Lang.ComplVV v vp ** {point = vp.point} ;
    ComplVS v s  = Lang.ComplVS v s ** {point = s.point} ;
    ComplVQ v s  = Lang.ComplVQ v s ** {point = s.point} ;
    ComplVA v ap = Lang.ComplVA v ap ** noPoint ; ----
    ComplV2A v np ap  = Lang.ComplV2A v np ap ** {point = np.point} ; ---- ap
    ReflV2 v = Lang.ReflV2 v ** noPoint ;
    UseComp c  = Lang.UseComp c ** {point = c.point} ;
    PassV2 v = Lang.PassV2 v ** noPoint ;
    AdvVP vp ad = Lang.AdvVP vp ad ** {point = vp.point ++ ad.point} ;
    AdVVP ad vp = Lang.AdVVP ad vp ** {point = vp.point} ;
    CompAP v = Lang.CompAP v ** noPoint ;
    CompNP c  = Lang.CompNP c ** {point = c.point} ;
    CompAdv c  = Lang.CompAdv c ** {point = c.point} ;

    PredVP np vp = Lang.PredVP np vp ** {point = np.point ++ vp.point} ;
    PredSCVP sc vp = Lang.PredSCVP sc vp ** {point = sc.point ++ vp.point} ;
    ImpVP vp = Lang.ImpVP vp ** {point = vp.point} ;
    EmbedS s = Lang.EmbedS s ** {point = s.point} ;
    EmbedQS s = Lang.EmbedQS s ** {point = s.point} ;
    EmbedVP s = Lang.EmbedVP s ** {point = s.point} ;
    UseCl t a p cl = Lang.UseCl t a p cl ** {point = cl.point} ;
    UseQCl t a p cl = Lang.UseQCl t a p cl ** {point = cl.point} ;

    QuestCl cl = Lang.QuestCl cl ** {point = cl.point} ;
    QuestVP ip cl = Lang.QuestVP ip cl ** {point = cl.point} ;
    QuestIAdv ip cl = Lang.QuestIAdv ip cl ** {point = cl.point} ;
    QuestIComp ip cl = Lang.QuestIComp ip cl ** {point = cl.point} ;
    QuestSlash ip cl = Lang.QuestSlash ip cl ** noPoint ;

    UttS s = Lang.UttS s **  {point = s.point} ;
    UttQS s = Lang.UttQS s **  {point = s.point} ;
    UttImpSg p s = Lang.UttImpSg p s **  {point = s.point} ;
    UttImpPl p s = Lang.UttImpPl p s **  {point = s.point} ;
    UttNP s = Lang.UttNP s **  {point = s.point} ;
    UttAdv s = Lang.UttAdv s **  {point = s.point} ;
    UttVP s = Lang.UttVP s **  {point = s.point} ;
    UttIP s = Lang.UttIP s ** noPoint ;
    UttIAdv s = Lang.UttIAdv s ** noPoint ;

    ---- to be completed with point
    ConjS c xs = Lang.ConjS c xs ** noPoint ;
    ConjNP c xs = Lang.ConjNP c xs ** noPoint ;
    ConjAdv c xs = Lang.ConjAdv c xs ** noPoint ;
    DConjS c xs = Lang.DConjS c xs ** noPoint ;
    DConjNP c xs = Lang.DConjNP c xs ** noPoint ;
    DConjAdv c xs = Lang.DConjAdv c xs ** noPoint ;

  ImpersCl vp = Lang.ImpersCl vp ** {point = vp.point} ;
  GenericCl vp = Lang.GenericCl vp ** {point = vp.point} ;
  ExistNP np = Lang.ExistNP np ** {point = np.point} ;
  ExistIP ip = Lang.ExistIP ip ** noPoint ;
  ProgrVP vp = Lang.ProgrVP vp ** {point = vp.point} ;
  ImpPl1 vp = Lang.ImpPl1 vp ** {point = vp.point} ;

  everybody_NP = Lang.everybody_NP ** noPoint ;
  everything_NP = Lang.everything_NP ** noPoint ;
  somebody_NP = Lang.somebody_NP ** noPoint ;
  something_NP = Lang.something_NP ** noPoint ;
  that_NP = Lang.that_NP ** noPoint ;
  these_NP = Lang.these_NP ** noPoint ;
  this_NP = Lang.this_NP ** noPoint ;
  those_NP = Lang.those_NP ** noPoint ;
  one_Quant = Lang.one_Quant ** noPoint ;
  that_Quant = Lang.that_Quant ** noPoint ;
  this_Quant = Lang.this_Quant ** noPoint ;
    
  everywhere_Adv  = Lang.everywhere_Adv  ** noPoint ;
  here_Adv  = Lang.here_Adv  ** noPoint ;
  here7to_Adv  = Lang.here7to_Adv  ** noPoint ;
  here7from_Adv  = Lang.here7from_Adv  ** noPoint ;
  somewhere_Adv  = Lang.somewhere_Adv  ** noPoint ;
  there_Adv  = Lang.there_Adv  ** noPoint ;
  there7to_Adv  = Lang.there7to_Adv  ** noPoint ;
  there7from_Adv  = Lang.there7from_Adv  ** noPoint ;
  every_Det  = Lang.every_Det  ** noPoint ;
  few_Det  = Lang.few_Det  ** noPoint ;
  many_Det  = Lang.many_Det  ** noPoint ;
  much_Det  = Lang.much_Det  ** noPoint ;
  someSg_Det  = Lang.someSg_Det  ** noPoint ;
  somePl_Det  = Lang.somePl_Det  ** noPoint ;

  already_Adv  = Lang.already_Adv  ** noPoint ;
  far_Adv  = Lang.far_Adv  ** noPoint ;
  now_Adv  = Lang.now_Adv  ** noPoint ;


--2 New constructs
    
--3 interface to top level

    PhrUtt pc utt voc = {
      s = Predef.toStr Phr (Lang.PhrUtt pc utt voc) ++ ";" ++ utt.point
      } ;

    SpeechUtt pc utt voc = {
      s = Predef.toStr Phr (Lang.PhrUtt pc utt voc)
      } ;

--3 Demonstratives

    this8point_NP p = Lang.this_NP ** p ;
    that8point_NP p = Lang.that_NP ** p ;
    these8point_NP p = Lang.these_NP ** p ;
    those8point_NP p = Lang.those_NP ** p ;
    here8point_Adv p = Lang.here_Adv ** p ;
    here7to8point_Adv p = Lang.here7to_Adv ** p ;
    here7from8point_Adv p = Lang.here7from_Adv ** p ;
    this8point_Quant p = Lang.this_Quant ** p ;
    that8point_Quant p = Lang.that_Quant ** p ;


    MkPoint s = {point = s.s} ;

  oper
    noPoint = {point = []} ;

}
