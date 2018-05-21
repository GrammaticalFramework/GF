concrete VerbChi of Verb = CatChi ** open ResChi, Prelude in {

  flags optimize=all_subs ;

  lin
    UseV v = predV v [] ;

    SlashV2a v = predV v v.part ** {c2 = v.c2 ; isPre = v.hasPrep} ;

    Slash2V3 v np = insertAdv (mkNP (ba_s ++      np.s)) (predV v v.part) ** {c2 = v.c3 ; isPre = v.hasPrep} ;  -- slot for third argument 
    Slash3V3 v np = insertObj (mkNP (appPrep v.c3 np.s)) (predV v v.part) ** {c2 = v.c2 ; isPre = True} ;   -- slot for ba object

    SlashV2A v ap = insertObj ap (predV v v.part) ** {c2 = v.c2 ; isPre = v.hasPrep} ; 

    SlashV2V v vp = insertObj (mkNP (infVP vp))   (predV v v.part) ** {c2 = v.c2 ; isPre = v.hasPrep} ;
    SlashV2S v s  = insertObj (ss (say_s ++ s.s)) (predV v v.part) ** {c2 = v.c2 ; isPre = v.hasPrep} ; 
    SlashV2Q v q  = insertObj (ss (say_s ++ q.s ! False)) (predV v v.part) ** {c2 = v.c2 ; isPre = v.hasPrep} ; 

    ComplVV v vp = {
      verb = v ;
      compl = vp.prePart ++ vp.verb.s ++ vp.compl ;
      prePart, topic = [] ;
      isAdj = False ;
      } ;

    ComplVS v s  = insertObj s  (predV v []) ; 
    ComplVQ v q  = insertObj (ss (q.s ! False)) (predV v []) ; 
    ComplVA v ap = insertObj ap (predV v []) ; 

    ComplSlash vp np = case vp.isPre of {
---      True  => insertAdv (mkNP (ba_s ++       np.s)) vp ; --- ba or vp.c2 ?
      True  => insertPP  (mkNP (appPrep vp.c2 np.s)) vp ; --- ba or vp.c2 ?
      False => insertObj (mkNP (appPrep vp.c2 np.s)) vp
      } ;

    UseComp comp = comp ;
    UseCopula = predV copula [] ;

    SlashVV v vp = ---- too simple?
      insertObj (mkNP (infVP vp)) (predV v []) ** {c2 = vp.c2 ; isPre = vp.isPre} ;

    SlashV2VNP v np vp = 
      insertObj np
        (insertObj (mkNP (infVP vp)) (predV v v.part)) ** {c2 = vp.c2 ; isPre = vp.isPre} ;

    AdvVP vp adv = case adv.advType of {
      ATManner => insertObj (ss (deVAdv_s ++ adv.s)) vp ;           -- he sleeps *well*
      ATPlace True => insertAdvPost adv vp ;                        -- he today *in the house* sleeps
      ATPlace False => insertAdvPost (ss (zai_V.s ++ adv.s)) vp ;   -- he today *here* sleeps
      ATTime | ATPoss => insertTopic adv vp                                  -- *today* he here sleeps
      } ;
    ExtAdvVP vp adv = case adv.advType of {  ---- ExtAdvVP also ?
      ATManner => insertObj (ss (deVAdv_s ++ adv.s)) vp ;           -- he sleeps *well*
      ATPlace True => insertAdvPost adv vp ;                        -- he today *in the house* sleeps
      ATPlace False => insertAdvPost (ss (zai_V.s ++ adv.s)) vp ;   -- he today *here* sleeps
      ATTime | ATPoss => insertTopic adv vp                                  -- *today* he here sleeps
      } ;

    AdVVP adv vp = insertAdv adv vp ; 
    
    ReflVP vp = insertObj (mkNP reflPron) vp ;

    PassV2 v = insertAdv (mkNP passive_s) (predV v v.part) ; ----

    CompAP ap = insertObj (mkNP (ap.s ++ de_s)) (predV copula []) ** {isAdj = True} ;

{-
    CompAP ap = case ap.hasAdA of {
      True  => insertObj (mkNP ap.s) (predV nocopula []) ; 
      False => insertObj (mkNP (ap.s ++ de_s)) (predV copula [])
      } ; 
-}

    CompNP np = insertObj np (predV copula []) ; ----

    CompCN cn = insertObj cn (predV copula []) ; ----

    CompAdv adv = case adv.advType of {
      ATPlace True => insertObj adv (predV noVerb []) ;
      _ => insertObj adv (predV zai_V []) ---- for all others ??
      } ;

    VPSlashPrep vp prep = vp ** {c2 = prep ; isPre = True} ;

    AdvVPSlash vp adv = case adv.advType of {
      ATManner     => insertObj (ss (deVAdv_s ++ adv.s)) vp ;                -- he sleeps well
      ATPlace True => insertAdv adv vp ;            -- he sleeps on the table
      _ => insertAdv (ss (zai_V.s ++ adv.s)) vp     -- he sleeps in the house / today
      } ** {c2 = vp.c2 ; isPre = vp.isPre} ;

    AdVVPSlash adv vp = insertAdv adv vp  ** {c2 = vp.c2 ; isPre = vp.isPre} ;


}

