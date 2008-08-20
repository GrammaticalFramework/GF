incomplete concrete PeaceSyntaxI of PeaceSyntax = 
  PeaceCatI ** open Lang,Constructors,PeaceRes in {

  flags 
    unlexer = text ; lexer = text ;

  lin
    PhrPos sent = stop (sent.s!SPos) ;
    PhrNeg sent = stop (sent.s!SNeg) ;
    PhrQuest q = quest q.s ;
    PhrImp imp = excl (mkPhr (mkUtt imp)).s;
    PhrImpNeg imp = excl (mkPhr (mkUtt negativePol imp)).s;
    
    PhrYes = stop yes_Utt.s ;
    PhrNo = stop no_Utt.s ;


    QuestSent sent = { s = sent.s!SQuest } ; 
    QuestIP_V v ip = mkQuest (QuestVP ip (UseV v)) ;
    QuestIP_V2 v2 ip x = mkQuest (QuestVP ip (mkVP v2 x)) ;
    QuestIP_V2Mass v2 ip x = mkQuest (QuestVP ip (mkVP v2 (MassNP x))) ;
    QuestIP_V3 v3 ip x y = mkQuest (QuestVP ip (mkVP v3 x y)) ;
    QuestIP_V3Mass v3 ip x y = mkQuest (QuestVP ip (mkVP v3 (MassNP x) y)) ;
    QuestIP_A a ip = mkQuest (QuestVP ip (UseComp (CompAP (PositA a))));
    QuestIAdv_NP x ia = mkQuest (QuestIComp (CompIAdv ia) x);

    QuestIAdv_V v x ia = mkQuest (QuestIAdv ia (PredVP x (UseV v)));
    QuestIAdv_V2 v x y ia = mkQuest (QuestIAdv ia (PredVP x (ComplV2 v y)));


    SentV  v np = mkSent (mkCl np v) ;

    SentV2 v2 x y = mkSent (mkCl x v2 y) ;
    SentV2Mass v2 x y = mkSent (mkCl x v2 (MassNP y)) ;
    SentV3 v3 x y z = mkSent (mkCl x v3 y z) ;
    SentV3Mass v3 x y z = mkSent (mkCl x v3 (MassNP y) z) ;
    SentA  a x = mkSent (mkCl x a) ;
    SentNP np x = mkSent (mkCl x np) ;

    SentAdvV  v x adv = mkSent (mkCl x (mkVP (mkVP v) adv)) ;
    SentAdvV2 v2 x y adv = mkSent (mkCl x (mkVP (mkVP v2 y) adv)) ;

    ImpV v = mkImp v ;
    ImpV2 v2 x = mkImp v2 x ;
    ImpV2Mass v2 x = mkImp v2 (MassNP x) ;
    ImpV3 v3 x y = mkImp (mkVP v3 x y) ;
    ImpV3Mass v3 x y = mkImp (mkVP v3 (MassNP x) y) ;

    UsePron p = mkNP p ;
    PossPronCNSg p n = mkNP (mkDet p) n ;
    PossPronCNPl p n = mkNP (mkDet p plNum) n ;
    DetCN d n = mkNP d n ;
    NumCN k cn = mkNP a_Art k cn ;
    ArtCNSg = DetArtSg ;
    ArtCNPl = DetArtPl ;

    UseN n = mkCN n ;
    ModCN a cn = mkCN a cn ;

    UseMassN mn = mkCN mn ;
    ModMass a cn = mkCN a cn ;

  oper
    mkSent : Lang.Cl -> Sent ;
    mkSent cl = 
      {
        s = table {
          SPos   => Predef.toStr Lang.S  (mkS cl) ;
          SNeg   => Predef.toStr Lang.S  (mkS negativePol cl) ;
          SQuest => Predef.toStr Lang.QS (mkQS cl)
          } ;
        lock_Sent = <>
      } ;

    mkQuest : Lang.QCl -> Quest ;
    mkQuest q = { s = Predef.toStr Lang.QS (mkQS q);
		  lock_Quest = <> } ;

}
