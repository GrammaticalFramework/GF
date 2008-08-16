incomplete concrete BronzeageI of Bronzeage = open Lang in {

  flags 
    optimize = all_subs ; --optimize = share_subs ;
    unlexer = text ; lexer = text ;

  lincat
    Sent = {s : SForm => Str} ; MassCN = CN ;

  lin
    PhrPos sent = {s = sent.s ! SPos ++ "."} ;
    PhrNeg sent = {s = sent.s ! SNeg ++ "."} ;
    PhrQuest sent = {s = sent.s ! SQuest ++ "?"} ;
    PhrImp imp = {s = (PhrUtt NoPConj (UttImpSg PPos imp) NoVoc).s ++ "!"} ;
    PhrImpNeg imp = {s = (PhrUtt NoPConj (UttImpSg PNeg imp) NoVoc).s ++ "!"} ;
    
    SentV  v np = mkSent np (UseV v) ;

    SentV2 v x y = mkSent x (ComplSlash (SlashV2a v) y) ;
    SentV2Mass v x y = mkSent x (ComplSlash (SlashV2a v) (massNP y)) ;
    SentV3 v x y z = mkSent x (ComplSlash (Slash2V3 v y) z) ;
    SentA  a x = mkSent x (UseComp (CompAP (PositA a))) ;
    SentNP a x = mkSent x (UseComp (CompNP a)) ;

    SentAdvV  v np adv = mkSent np (AdvVP (UseV v) adv) ;
    SentAdvV2 v x y adv = mkSent x (AdvVP (ComplSlash (SlashV2a v) y) adv) ;

    ImpV v = ImpVP (UseV v) ;
    ImpV2 v x = ImpVP (ComplSlash (SlashV2a v) x)  ;

    UsePron p = Lang.UsePron p ;
    DetCN d n = Lang.DetCN d n ;
    NumCN k cn = Lang.DetCN (DetArtCard (IndefArt) k) cn ;

    UseN n = Lang.UseN n ;
    ModCN a cn = AdjCN (PositA a) cn ;

    UseMassN mn = Lang.UseN mn ;
    ModMass a cn = AdjCN (PositA a) cn ;

  param
    SForm = SPos | SNeg | SQuest ;

  oper
    mkSent : NP -> VP -> Sent ;
    mkSent np vp = 
      let cl = PredVP np vp
      in {
        s = table {
          SPos   => Predef.toStr S  (UseCl Lang.TPres ASimul PPos cl) ;
          SNeg   => Predef.toStr S  (UseCl Lang.TPres ASimul PNeg cl) ;
          SQuest => Predef.toStr QS (UseQCl Lang.TPres ASimul PPos (QuestCl cl))
          } ;
        lock_Sent = <>
      } ;

    massNP : CN -> NP = MassNP ;

}
