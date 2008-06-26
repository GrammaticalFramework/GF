concrete VerbTha of Verb = CatTha ** open ResTha, StringsTha, Prelude in {

  flags optimize=all_subs ;

  lin
    UseV = mkVP ;
--    ComplV2 v np = insertObject (v.c2 ++ np.s) (mkVP v)  ;
--    ComplV3 v np np2 = insertObject (v.c2 ++ np.s ++ v.c3 ++ np2.s) (mkVP v)  ;

    ComplVV vv vp = {
      s = \\p =>
        let 
          neg = polStr may_s p ;
          v = vp.s ! Pos
        in 
        case vv.typ of {
          VVPre => vv.s ++ neg ++ v ; 
          VVMid => neg ++ vv.s ++ v ; 
          VVPost => v ++ neg ++ vv.s
          }
      } ;

--
--    ComplVS v s  = insertObj (\\_ => conjThat ++ s.s) (predV v) ;
--    ComplVQ v q  = insertObj (\\_ => q.s ! QIndir) (predV v) ;
--
--    ComplVA  v    ap = insertObj (ap.s) (predV v) ;
--    ComplV2A v np ap = 
--      insertObj (\\_ => v.c2 ++ np.s ! Acc ++ ap.s ! np.a) (predV v) ;
--
    UseComp comp = comp ;
--
--    AdvVP vp adv = insertObj (\\_ => adv.s) vp ;
--
--    AdVVP adv vp = insertAdV adv.s vp ;
--
--    ReflV2 v = insertObj (\\a => v.c2 ++ reflPron ! a) (predV v) ;
--
--    PassV2 v = insertObj (\\_ => v.s ! VPPart) (predAux auxBe) ;
--
--    UseVS, UseVQ = \vv -> {s = vv.s ; c2 = [] ; isRefl = vv.isRefl} ; 

    CompAP ap = {s = \\p => polStr may_s p ++ ap.s} ;
    CompNP np = {s = table {
      Pos => pen_s ++ np.s ;
      Neg => may_s ++ chay_s ++ np.s
      }
    } ;
    CompAdv a = {s = \\p => polStr may_s p ++ a.s} ; --- ??

}
