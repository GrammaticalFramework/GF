concrete VerbBul of Verb = CatBul ** open Prelude, ResBul, ParadigmsBul in {

  flags optimize=all_subs ;

  lin
    UseV = predV ;

    SlashV2a v = predV v ** {c2 = v.c2} ;

    Slash2V3 v np = 
      insertObj (\\_ => v.c2.s ++ np.s ! RObj v.c2.c) (predV v) ** {c2 = v.c3} ;

    Slash3V3 v np = 
      insertObj (\\_ => v.c3.s ++ np.s ! RObj v.c3.c) (predV v) ** {c2 = v.c2} ;

    ComplVV vv vp = {
      s   = \\t,a,p,agr,q,asp => 
        let 
          vv_verb = (predV vv).s ! t ! a ! p ! agr ! q ! asp ;
          vp_verb = vp.s ! Pres ! Simul ! Pos ! agr ! False ! Perf ;
        in vv_verb ++ vp.ad ! False ++ "да" ++ vp_verb ;
      imp = vp.imp ;
      ad = \\_ => [] ;
      s2 = vp.s2 ;
      subjRole = vp.subjRole
      } ;

    ComplVS v s  = insertObj (\\_ => "," ++ "че" ++ s.s) (predV v) ;
    ComplVQ v q  = insertObj (\\_ => q.s ! QIndir) (predV v) ;

    ComplVA v ap = 
      insertObj (\\agr => ap.s ! aform agr.gn Indef (RObj Acc)) (predV v) ;


    SlashV2A v ap = 
      insertObj (\\a => ap.s ! aform a.gn Indef (RObj Acc)) 
        (predV v) ** {c2 = v.c2} ;  ---- FIXME: agreement with obj.a 

    -- test: I saw a boy to whom she said that they are here
    SlashV2S v s  = insertObj (\\_ => "," ++ "че" ++ s.s) (predV v) ** {c2 = v.c2} ;

    -- test: I saw a boy whom she asked who is here
    SlashV2Q v q  = insertObj (\\_ => q.s ! QIndir) (predV v) ** {c2 = v.c2} ;

    -- test: I saw a boy whom she begged to walk 
    SlashV2V vv vp =
      insertObj (\\agr => vp.ad ! False ++ "да" ++ vp.s ! Pres ! Simul ! Pos ! agr ! False ! Perf)
                (predV vv)
         ** {c2 = vv.c2} ;

    -- test: I saw a car whom she wanted to buy
    SlashVV vv slash = {
      s   = \\t,a,p,agr,q,asp => 
        let 
          vv_verb = (predV vv).s ! t ! a ! p ! agr ! q ! asp ;
          slash_verb = slash.s ! Pres ! Simul ! Pos ! agr ! False ! Perf ;
        in vv_verb ++ slash.ad ! False ++ "да" ++ slash_verb ;
      imp = slash.imp ;
      ad = \\_ => [] ;
      s2 = slash.s2 ;
      subjRole = slash.subjRole
      } ** {c2 = slash.c2} ;

    -- test: I saw a car whom she begged me to buy
    SlashV2VNP vv np slash = {
      s   = \\t,a,p,agr,q,asp => 
        let 
          vv_verb = (predV vv).s ! t ! a ! p ! agr ! q ! asp ;
          slash_verb = slash.s ! Pres ! Simul ! Pos ! np.a ! False ! Perf ;
        in vv_verb ++ vv.c2.s ++ np.s ! RObj vv.c2.c ++ slash.ad ! False ++ "да" ++ slash_verb ;
      imp = slash.imp ;
      ad = \\_ => [] ;
      s2 = slash.s2 ;
      subjRole = slash.subjRole
      } ** {c2 = slash.c2} ;

    ComplSlash slash np = {
      s   = slash.s ;
      imp = slash.imp ;
      ad  = slash.ad ;
      s2 = \\_ => slash.c2.s ++ np.s ! RObj slash.c2.c ++ slash.s2 ! np.a ;
      subjRole = slash.subjRole
      } ;

    UseComp comp = insertObj comp.s (predV verbBe) ;

    AdvVP vp adv = insertObj (\\_ => adv.s) vp ;

    AdVVP adv vp = {
      s   = \\t,a,p,agr,q,asp => vp.s ! t ! a ! p ! agr ! False ! asp ;
      imp = vp.imp ;
      ad  = \\q => vp.ad ! q ++ adv.s ++ case q of {True => "ли"; False => []} ;
      s2 = vp.s2 ;
      subjRole = vp.subjRole
      } ;

----    ReflV2 v = predV (reflV (v ** {lock_V=<>}) v.c2.c) ;

----  FIXME: AR cannot do this
----  ReflVP : VPSlash -> VP

    PassV2 v = insertObj (\\a => v.s ! Perf ! VPassive (aform a.gn Indef (RObj Acc))) (predV verbBe) ;

----    UseVS, UseVQ = \vv -> {s = vv.s; c2 = noPrep; vtype = vv.vtype} ; -- no "to"

    CompAP ap = {s = \\agr => ap.s ! aform agr.gn Indef (RObj Acc)} ;
    CompNP np = {s = \\_ => np.s ! RObj Acc} ;
    CompAdv a = {s = \\_ => a.s} ;
}
