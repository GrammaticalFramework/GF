concrete ExtraSnd of ExtraSndAbs = CatSnd ** 
  open ResSnd, Coordination, Prelude, MorphoSnd, ParadigmsSnd in {

  flags coding = utf8;

  lin
    GenNP np = {s = \\_,_,_ => np.s ! NPC Obl ++ "ka" ; a = np.a} ;

    each_Det = mkDet  "hr kwy" "hr kwy" "hr kwy" "hr kwy" Sg ;
    have_V = mkV "rakh'na";
    IAdvAdv adv = {s = "ktny" ++ adv.s!Masc} ;
    ICompAP ap = {s = "ktnE" ++ ap.s ! Sg ! Masc ! Dir} ;
    cost_V = mkV "qymt" ;
    
    -- added for causitives
    make_CV = mkVerb "nothing"   ** {c2 = "" };

-- for VP conjunction
} 
