concrete VerbDut of Verb = CatDut ** open Prelude, ResDut in {

  flags optimize=all_subs ;

  lin
    UseV = predV ;

    ComplVV v vp = 
      let
        vpv = predVGen v.isAux vp.negPos (v2v v) ;
        vpi = infVP v.isAux vp ;
      in
      vpv ** {n2 = vpi.obj ; inf = <vpi.inf, True> ; ext = vpi.ext} ; ---- Why replace and not use insertInfVP? TODO find out

    ComplVS v s = 
      insertExtrapos (conjThat ++ s.s ! Sub) (predV v) ;
    ComplVQ v q = 
      insertExtrapos (q.s ! QIndir) (predV v) ;
    ComplVA v ap = 
      insertObj (\\agr => ap.s ! agr ! APred) (predVGen False BetweenObjs v) ;

    SlashV2a v = predV (v2v v) ** {c2 = v.c2} ; 
      
    Slash2V3 v np =
      insertObj (\\_ => appPrep v.c2.p1 np) (predVv v) ** {c2 = v.c3} ;
    Slash3V3 v np =
      insertObj (\\_ => appPrep v.c3.p1 np) (predVv v) ** {c2 = v.c2} ;
    SlashV2S v s = 
      insertExtrapos (conjThat ++ s.s ! Sub) (predVv v) ** {c2 = v.c2} ;
    SlashV2Q v q = 
      insertExtrapos (q.s ! QIndir) (predVv v) ** {c2 = v.c2} ;
    SlashV2V v vp =
      insertInfVP v.isAux vp (predVGen v.isAux vp.negPos v) ** {c2 = v.c2} ;
    SlashV2A v ap = 
      insertObj (\\agr => ap.s ! agr ! APred) 
                (predVGen False BetweenObjs (v2v v)) ** {c2 = v.c2} ;

    ComplSlash vp np =
      let hasInf = vp.inf.p2 ;
          hasPrep = vp.c2.p2 ;
          obj : Str = appPrep vp.c2.p1 np ;

          -- If the verb has a preposition, insert the new object as an Adv.
          insertArg = case hasPrep of {
	              True => insertAdv obj ;
                      False => insertObjNP np.isPron vp.negPos (\\_ => obj) } ;

	  -- If there is an infinitive, put old object before the infinitive
          -- and choose its agreement based on the new object.
	  -- Otherwise, keep the old VP.
	  newVP : VP = case hasInf of {
                         True  => let emptyObjVP : VP = vp ** {n0, n2 = \\_ => [] } ;
                                      infCompl = vp.n0 ! np.a ++ vp.n2 ! np.a ;
                                   in insertInf infCompl emptyObjVP ;
                         _     => vp } ;

       in insertArg newVP ;

    SlashVV v vp =
      insertInfVP v.isAux vp (predVGen v.isAux vp.negPos v) ** {c2 = vp.c2} ;

    SlashV2VNP v np vp =
      insertInfVP v.isAux vp (
        insertObj (\\_ => appPrep v.c2.p1 np)
                  (predVGen v.isAux vp.negPos v))
      ** {c2 = v.c2} ;

    UseComp comp = insertObj comp.s (compV zijn_V) ;

    UseCopula = predV zijn_V; 

    CompCN cn = {s = \\a => case a.n of {
                                 Sg => "een" ++ cn.s ! Strong ! NF Sg Nom ;
                                 Pl => cn.s ! Strong ! NF Pl Nom }} ;
    CompAP ap = {s = \\agr => ap.s ! agr ! APred} ; -- agr needed for reflexives: "married to my/your/...self"
    CompNP np = {s = \\_ => np.s ! NPNom} ;
    CompAdv a = {s = \\_ => a.s} ;

    AdvVP vp adv = insertAdv adv.s vp ;
    ExtAdvVP vp adv = insertAdv (embedInCommas adv.s) vp ;

    AdVVP adv vp = insertAdV adv.s vp ;

    ReflVP vp = insertObj (\\a => appPrep vp.c2.p1 
                                          (npLite (\\_ => reflPron ! a))
                          ) vp ;

    PassV2 v = insertInf (v.s ! VPerf APred) (predV worden_V) ;

    VPSlashPrep vp prep = vp ** {c2 = <prep,True>} ;


---- workaround for a subtyping bug
  oper
    v2v : VVerb -> VVerb = \v -> 
      {s = v.s ; aux = v.aux ; prefix = v.prefix ; particle = v.particle ; vtype = v.vtype} ;
    predVv : VVerb -> ResDut.VP = \v -> predV (v2v v) ;
}
