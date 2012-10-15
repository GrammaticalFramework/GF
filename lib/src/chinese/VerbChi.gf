concrete VerbChi of Verb = CatChi ** open ResChi, Prelude in {

  flags optimize=all_subs ;

  lin
    UseV = predV ;

    SlashV2a v = predV v ** {c2 = v.c2} ;

    Slash2V3 v np = insertObj np (predV v) ** {c2 = v.c3} ; ---- to check arg order
    Slash3V3 v np = insertObj np (predV v) ** {c2 = v.c2} ;

    SlashV2A v ap = insertObj ap (predV v) ** {c2 = v.c2} ; 

    SlashV2V v vp = insertObj (mkNP (infVP vp)) (predV v) ** {c2 = v.c2} ;
    SlashV2S v s  = insertObj s (predV v) ** {c2 = v.c2} ; 
    SlashV2Q v q  = insertObj q (predV v) ** {c2 = v.c2} ; 

    ComplVV v vp = {
      verb = v ;
      compl = vp.verb.s ++ vp.compl ;
      prePart = vp.prePart
      } ;

    ComplVS v s  = insertObj s  (predV v) ; 
    ComplVQ v q  = insertObj q  (predV v) ; 
    ComplVA v ap = insertObj ap (predV v) ; 

    ComplSlash vp np = insertObj (mkNP (appPrep vp.c2 np.s)) vp ;

    UseComp comp = comp ;

    SlashVV v vp = ---- too simple?
      insertObj (mkNP (infVP vp)) (predV v) ** {c2 = vp.c2} ;

    SlashV2VNP v np vp = 
      insertObj np
        (insertObj (mkNP (infVP vp)) (predV v)) ** {c2 = vp.c2} ;

    AdvVP vp adv = case adv.advType of {
      ATManner => insertObj (ss (deVAdv_s ++ adv.s)) vp ;                -- he sleeps well
      _ => insertAdv (ss (zai_V.s ++ adv.s)) vp     -- he sleeps in the house / today
      } ;

    AdVVP adv vp = insertAdv adv vp ; 
    
    ReflVP vp = insertObj (mkNP reflPron) vp ;

    PassV2 v = insertObj (mkNP passive_s) (predV v) ; ----

    CompAP ap = insertObj (mkNP (ap.s ++ possessive_s)) (predV copula) ; ---- hen / bu

    CompNP np = insertObj np (predV copula) ; ----

    CompCN cn = insertObj cn (predV copula) ; ----

    CompAdv adv = insertObj adv (predV zai_V) ;

}

