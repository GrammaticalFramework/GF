concrete VerbTha of Verb = CatTha ** open ResTha, StringsTha, Prelude in {

  flags optimize=all_subs ;

  lin
    UseV = predV ;

    SlashV2a v = predV v ** {c2 = v.c2} ;

    Slash2V3 v np = insertObject <thbind v.c2 np.s : Str> (predV v) ** {c2 = v.c3} ;
    Slash3V3 v np = insertExtra  <thbind v.c3 np.s : Str> (predV v) ** {c2 = v.c2} ;

    SlashV2A v ap = 
      insertExtra <thbind pen_s v.c3 ap.s : Str> (predV v) ** {c2 = v.c2} ; --- pen?

    SlashV2V v vp = ---- looks too simple compared with ComplVV
      insertExtra <thbind <v.c3 : Str> <infVP vp : Str> : Str> (predV v) ** {c2 = v.c2} ;
    SlashV2S v s  = 
      insertExtra <thbind conjThat s.s : Str> (predV v) ** {c2 = v.c2} ;
    SlashV2Q v q  = 
      insertExtra (q.s ! QIndir) (predV v) ** {c2 = v.c2} ;

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
          } ;
       e = []
      } ;

    ComplVS v s  = insertObj (mkNP (thbind conjThat s.s)) (predV v) ;
    ComplVQ v q  = insertObj (mkNP (q.s ! QIndir)) (predV v) ;


    ComplVA  v    ap = insertObj ap (predV v) ; 

    ComplSlash vp np = insertObj (mkNP (thbind vp.c2 np.s)) vp ;

    UseComp comp = comp ** {e = []} ;

    SlashVV v vp = ---- too simple?
      insertObj (mkNP (infVP vp)) (predV (regV v.s)) ** {c2 = vp.c2} ;

    SlashV2VNP v np vp = 
      insertObj np
        (insertObj (mkNP (infVP vp)) (predV v)) ** {c2 = vp.c2} ;

    AdvVP vp adv = insertObj adv vp ;

    AdVVP adv vp = insertObj adv vp ; 
    
    ReflVP vp = insertObj (mkNP (thbind vp.c2 reflPron)) vp ;

    PassV2 v = {s = \\p => thbind (polStr may_s p) thuuk_s ; e = thbind v.s1 v.s2} ; -- to put agent before verb; --- the place of neg?

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

    CompAdv a = {s = \\p => thbind (polStr may_s p) yuu_s a.s} ; --- works for place adverbs

}

