concrete VerbIna of Verb = CatIna ** open ResIna, Prelude in {

  flags optimize=all_subs ;

  lin
    UseV = predV ;
    ComplV2 v np = insertObj v.p2 v.c2 np (predV v) ;

    ComplV3 v np np2 = insertObj v.p3 v.c3 np2 
                      (insertObj v.p2 v.c2 np 
		      (predV v)) ;

    ComplVV v vp = insertInvarObj (infVP vp) (predV v) ;
    
    ComplVS v s  = insertInvarObj ("que" ++ s.s) (predV v) ;
    ComplVQ v q  = insertInvarObj (q.s ! ODir) (predV v) ;


    ComplVA  v    ap = insertInvarObj (ap.s ! Sp3) (predV v) ; 
    -- !!! Agr should agree with the subject; however this is a quite useless sentence:
    -- You are greater than yourself... etc.
    
    ComplV2A v np ap = insertInvarObj (casePrep v.p3 v.c3 ++ (ap.s ! Sp3))
                      (insertObj v.p2 v.c2 np
                      (predV v)) ;

    -- This is not described by the interlingua grammar.
    -- eg. "peint en rouge"

    UseComp comp = insertInvarObj (comp.s ! Sp3) (predV esserV) ;
    -- !!! as above

    AdvVP vp adv = insertInvarObj (adv.s) vp ;

    AdVVP adv vp = insertInvarObj adv.s vp ; 
    -- ??? The grammar is quite unclear about where the adverbs should go.
    

    ReflV2 v = insertReflObj v.p2 v.c2 {isPronoun = True; s = \\agr,c => reflPron!agr} (predV v) ;

    PassV2 v = insertInvarObj (v.s ! VPPart) (predV esserV);

    UseVS, UseVQ = \vv -> {s = vv.s ; p2 = []; c2 = Acc; isRefl = vv.isRefl};

    CompAP ap = ap ;
    CompNP np = {s = \\_ => np.s ! Acc} ;
    CompAdv a = {s = \\_ => a.s} ;

}
