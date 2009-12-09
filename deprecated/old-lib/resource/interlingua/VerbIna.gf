concrete VerbIna of Verb = CatIna ** open ResIna, Prelude in {

  flags optimize=all_subs ;

  lin
    UseV = predV ;

    SlashV2a v = predV v ** {p2 = v.p2 ; c2 = v.c2} ;

    Slash2V3 v np = insertObj v.p2 v.c2 np (predV v) ** {p2 = v.p3 ; c2 = v.c3} ;
    Slash3V3 v np = insertObj v.p3 v.c3 np (predV v) ** {p2 = v.p2 ; c2 = v.c2} ;

    SlashV2A v ap = 
      insertInvarObj (casePrep v.p3 v.c3 ++ (ap.s ! Sp3))
                      (predV v) ** {p2 = v.p2 ; c2 = v.c2} ;

    -- This is not described by the interlingua grammar.
    -- eg. "peint en rouge"

-- the 1.4 additions made by AR 16/6/2008
    SlashV2V v vp = 
      insertInvarObj (infVP vp) (predV v) ** {p2 = v.p2 ; c2 = v.c2} ;
    SlashV2S v s  = 
      insertInvarObj ("que" ++ s.s) (predV v) ** {p2 = v.p2 ; c2 = v.c2} ;
    SlashV2Q v q  = 
      insertInvarObj (q.s ! ODir) (predV v) ** {p2 = v.p2 ; c2 = v.c2} ;


    ComplVV v vp = insertInvarObj (infVP vp) (predV v) ;
    
    ComplVS v s  = insertInvarObj ("que" ++ s.s) (predV v) ;
    ComplVQ v q  = insertInvarObj (q.s ! ODir) (predV v) ;


    ComplVA  v    ap = insertInvarObj (ap.s ! Sp3) (predV v) ; 
    -- !!! Agr should agree with the subject; however this is a quite useless sentence:
    -- You are greater than yourself... etc.
    

    ComplSlash vp np = insertObj vp.p2 vp.c2 np vp ;

    UseComp comp = insertInvarObj (comp.s ! Sp3) (predV esserV) ;
    -- !!! as above

    SlashVV v vp = 
      insertInvarObj (infVP vp) (predV v) ** {p2 = vp.p2 ; c2 = vp.c2} ;

    SlashV2VNP v np vp = 
      insertObj v.p2 v.c2 np
        (insertInvarObj (infVP vp) (predV v)) ** {p2 = vp.p2 ; c2 = vp.c2} ;

    AdvVP vp adv = insertInvarObj (adv.s) vp ;

    AdVVP adv vp = insertInvarObj adv.s vp ; 
    -- ??? The grammar is quite unclear about where the adverbs should go.
    
    ReflVP vp = insertReflObj vp.p2 vp.c2 
      {isPronoun = True; s = \\agr,c => reflPron!agr} vp ;

    PassV2 v = insertInvarObj (v.s ! VPPart) (predV esserV);

    CompAP ap = ap ;
    CompNP np = {s = \\_ => np.s ! Acc} ;
    CompAdv a = {s = \\_ => a.s} ;

}
