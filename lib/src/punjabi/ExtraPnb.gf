concrete ExtraPnb of ExtraPnbAbs = CatPnb ** 
  open ResPnb, Coordination, Prelude, MorphoPnb, ParadigmsPnb in {

  flags coding = utf8;

  lin
    GenNP np = {s = \\_,_,_ => np.s ! NPC Obl ++ "كا" ; a = np.a} ;

    each_Det = mkDet  "ہر كوی" "ہر كوی" "ہر كوی" "ہر كوی" Sg ;
    have_V = mkV "راكھنا";
    IAdvAdv adv = {s = "كتنی" ++ adv.s!Masc} ;
    ICompAP ap = {s = "كتنے" ++ ap.s ! Sg ! Masc ! Dir} ;
    cost_V = mkV "قیمت" ;
    
    -- added for causitives
    make_CV = mkVerb "نoتہiنگ"   ** {c2 = "" };

-- for VP conjunction
} 
