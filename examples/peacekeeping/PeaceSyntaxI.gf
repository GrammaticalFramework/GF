incomplete concrete PeaceSyntaxI of PeaceSyntax = PeaceCatI ** open Lang in {

  flags 
--    optimize = all_subs ;
    optimize = share ;
    unlexer = text ; lexer = text ;

  lincat
    Sent = {s : SForm => Str} ; 
    Quest = { s : Str } ;
    MassCN = CN ;

  lin
    PhrPos sent = {s = sent.s ! SPos ++ "."} ;
    PhrNeg sent = {s = sent.s ! SNeg ++ "."} ;
    PhrQuest q = {s = q.s ++ "?" } ;
    PhrImp imp = {s = (PhrUtt NoPConj (UttImpSg PPos imp) NoVoc).s ++ "!"} ;
    PhrImpNeg imp = {s = (PhrUtt NoPConj (UttImpSg PNeg imp) NoVoc).s ++ "!"} ;
    
    PhrYes = { s = yes_Phr.s ++ "." } ;
    PhrNo = { s = no_Phr.s ++ "." } ;

    QuestSent sent = {s = sent.s ! SQuest } ; 
    QuestIP_V v ip = mkQuest (QuestVP ip (UseV v)) ;
    QuestIP_V2 v ip x = mkQuest (QuestVP ip (ComplV2 v x)) ;
    QuestIP_V2Mass v ip x = mkQuest (QuestVP ip (ComplV2 v (massNP x))) ;
    QuestIP_V3 v ip x y = mkQuest (QuestVP ip (ComplV3 v x y)) ;
    QuestIP_V3Mass v ip x y = mkQuest (QuestVP ip (ComplV3 v (massNP x) y)) ;
    QuestIP_A : A -> IP -> Phr ;
    QuestIP_A a ip = mkQuest (QuestVP ip (UseComp (CompAP (PositA a))));
    QuestIAdv_NP x ia = mkQuest (QuestIComp (CompIAdv ia) x);

    QuestIAdv_V v x ia = mkQuest (QuestIAdv ia (PredVP x (UseV v)));
    QuestIAdv_V2 v x y ia = mkQuest (QuestIAdv ia (PredVP x (ComplV2 v y)));

    SentV  v np = mkSent np (UseV v) ;

    SentV2 v x y = mkSent x (ComplV2 v y) ;
    SentV2Mass v x y = mkSent x (ComplV2 v (massNP y)) ;
    SentV3 v x y z = mkSent x (ComplV3 v y z) ;
    SentV3Mass v x y z = mkSent x (ComplV3 v (massNP y) z) ;
    SentA  a x = mkSent x (UseComp (CompAP (PositA a))) ;
    SentNP a x = mkSent x (UseComp (CompNP a)) ;

    SentAdvV  v np adv = mkSent np (AdvVP (UseV v) adv) ;
    SentAdvV2 v x y adv = mkSent x (AdvVP (ComplV2 v y) adv) ;

    ImpV v = ImpVP (UseV v) ;
    ImpV2 v x = ImpVP (ComplV2 v x) ;
    ImpV2Mass v x = ImpVP (ComplV2 v (massNP x)) ;
    ImpV3 v x y = ImpVP (ComplV3 v x y) ;
    ImpV3Mass v x y = ImpVP (ComplV3 v (massNP x) y) ;

    UsePron p = UsePron p ;
    PossPronCNSg p n = DetCN (DetSg (SgQuant (PossPron p)) NoOrd) n;
    PossPronCNPl p n = DetCN (DetPl (PlQuant (PossPron p)) NoNum NoOrd) n;
    DetCN d n = DetCN d n ;
    NumCN k cn = DetCN (DetPl (PlQuant IndefArt) k NoOrd) cn ;

    UseN n = UseN n ;
    ModCN a cn = AdjCN (PositA a) cn ;

    UseMassN mn = UseN mn ;
    ModMass a cn = AdjCN (PositA a) cn ;

  param
    SForm = SPos | SNeg | SQuest ;

  oper
    mkSent : NP -> VP -> Sent ;
    mkSent np vp = 
      let cl = PredVP np vp
      in {
        s = table {
          SPos   => Predef.toStr S  (UseCl TPres ASimul PPos cl) ;
          SNeg   => Predef.toStr S  (UseCl TPres ASimul PNeg cl) ;
          SQuest => Predef.toStr QS (UseQCl TPres ASimul PPos (QuestCl cl))
          } ;
        lock_Sent = <>
      } ;

    massNP : CN -> NP = \mcn -> DetCN (DetSg MassDet NoOrd) mcn ;

    mkQuest : QCl -> Quest ;
    mkQuest q = { s = Predef.toStr QS (UseQCl TPres ASimul PPos q);
		  lock_Quest = <> } ;

}
