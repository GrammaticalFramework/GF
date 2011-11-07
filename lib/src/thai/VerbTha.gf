concrete VerbTha of Verb = CatTha ** open ResTha, StringsTha, Prelude in {

  flags optimize=all_subs ;

  lin
    UseV = predV ;

    SlashV2a v = predV v ** {c2 = v.c2} ;

    Slash2V3 v np = insertObj np (predV v) ** {c2 = v.c3} ;
    Slash3V3 v np = insertObj np (predV v) ** {c2 = v.c2} ;

    SlashV2A v ap = 
      insertObj (mkNP <thbind v.c2 ap.s : Str>) (predV v) ** {c2 = v.c2} ;

    SlashV2V v vp = ---- looks too simple compared with ComplVV
      insertObj (mkNP <thbind v.c2 (infVP vp) : Str>) (predV v) ** {c2 = v.c2} ;
    SlashV2S v s  = 
      insertObj (mkNP <thbind conjThat s.s : Str>) (predV v) ** {c2 = v.c2} ;
    SlashV2Q v q  = 
      insertObj (mkNP (q.s ! QDir)) (predV v) ** {c2 = v.c2} ;

    ComplVV vv vp = {
      s = \\p =>
        let 
          neg = polStr may_s p ;
          v = vp.s ! Pos
        in 
        case vv.typ of {
          VVPre => thbind vv.s neg v ; 
          VVMid => thbind neg vv.s v ; 
          VVPost => thbind v neg vv.s
          }
      } ;

    ComplVS v s  = insertObj (mkNP (thbind conjThat s.s)) (predV v) ;
    ComplVQ v q  = insertObj (mkNP (q.s ! QDir)) (predV v) ;


    ComplVA  v    ap = insertObj ap (predV v) ; 

    ComplSlash vp np = insertObj (mkNP (thbind vp.c2 np.s)) vp ;

    UseComp comp = comp ;

    SlashVV v vp = ---- too simple?
      insertObj (mkNP (infVP vp)) (predV (regV v.s)) ** {c2 = vp.c2} ;

    SlashV2VNP v np vp = 
      insertObj np
        (insertObj (mkNP (infVP vp)) (predV v)) ** {c2 = vp.c2} ;

    AdvVP vp adv = insertObj adv vp ;

    AdVVP adv vp = insertObj adv vp ; 
    
    ReflVP vp = insertObj (mkNP (thbind vp.c2 reflPron)) vp ;

    PassV2 v = {s = \\p => thbind thuuk_s ((predV v).s ! p)} ;

    CompAP ap = {s = \\p => thbind (polStr may_s p) ap.s} ;

    CompNP np = {s = table {
      Pos => thbind pen_s np.s ;
      Neg => thbind may_s chay_s np.s
      }
    } ;

    CompCN np = {s = table {
      Pos => thbind pen_s np.s ;
      Neg => thbind may_s chay_s np.s
      }
    } ;

    CompAdv a = {s = \\p => polStr may_s p ++ a.s} ; --- ??

}

