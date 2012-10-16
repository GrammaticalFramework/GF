concrete VerbCmn of Verb = CatCmn ** open ResCmn, Prelude in {

  flags optimize=all_subs ;

  lin
    UseV = predV ;

    SlashV2a v = predV v ** {c2 = v.c2 ; isPre = False} ;

    Slash2V3 v np = insertAdv (mkNP (ba_s ++      np.s)) (predV v) ** {c2 = v.c3 ; isPre = False} ;  -- slot for third argument 
    Slash3V3 v np = insertObj (mkNP (appPrep v.c3 np.s)) (predV v) ** {c2 = v.c2 ; isPre = True} ;   -- slot for ba object

    SlashV2A v ap = insertObj ap (predV v) ** {c2 = v.c2 ; isPre = True} ; 

    SlashV2V v vp = insertObj (mkNP (infVP vp))   (predV v) ** {c2 = v.c2 ; isPre = True} ;
    SlashV2S v s  = insertObj (ss (say_s ++ s.s)) (predV v) ** {c2 = v.c2 ; isPre = True} ; 
    SlashV2Q v q  = insertObj (ss (say_s ++ q.s)) (predV v) ** {c2 = v.c2 ; isPre = True} ; 

    ComplVV v vp = {
      verb = v ;
      compl = vp.verb.s ++ vp.compl ;
      prePart = vp.prePart
      } ;

    ComplVS v s  = insertObj s  (predV v) ; 
    ComplVQ v q  = insertObj q  (predV v) ; 
    ComplVA v ap = insertObj ap (predV v) ; 

    ComplSlash vp np = case vp.isPre of {
      True  => insertAdv (mkNP (ba_s ++       np.s)) vp ; --- ba or vp.c2 ?
      False => insertObj (mkNP (appPrep vp.c2 np.s)) vp
      } ;

    UseComp comp = comp ;

    SlashVV v vp = ---- too simple?
      insertObj (mkNP (infVP vp)) (predV v) ** {c2 = vp.c2 ; isPre = vp.isPre} ;

    SlashV2VNP v np vp = 
      insertObj np
        (insertObj (mkNP (infVP vp)) (predV v)) ** {c2 = vp.c2 ; isPre = vp.isPre} ;

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

