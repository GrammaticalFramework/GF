concrete ExtraSnd of ExtraSndAbs = CatSnd ** 
  open ResSnd, Coordination, Prelude, MorphoSnd, ParadigmsSnd in {

  flags coding = utf8;

  lin
    GenNP np = {s = \\_,_,_ => np.s ! NPC Obl ++ "ڪا" ; a = np.a} ;

    each_Det = mkDet  "hر ڪwی" "hر ڪwی" "hر ڪwی" "hر ڪwی" Sg ;
    have_V = mkV "راڪھنا";
    IAdvAdv adv = {s = "ڪتنی" ++ adv.s!Masc} ;
    ICompAP ap = {s = "ڪتنE" ++ ap.s ! Sg ! Masc ! Dir} ;
    cost_V = mkV "قیمت" ;
    
    -- added for causitives
    make_CV = mkVerb "نoتhiنگ"   ** {c2 = "" };

-- for VP conjunction
} 
