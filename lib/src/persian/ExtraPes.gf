concrete ExtraPes of ExtraPesAbs = CatPes ** 
  open ResPes, Coordination, Prelude, MorphoPes, ParadigmsPes in {

  flags coding = utf8;

  lin
    GenNP np = {s = \\_ => np.s ! NPC aEzafa ; a = np.a ; fromPron = True} ; -- changed  from fromPron=False for Phrasebook

--    each_Det = mkDet  "هر کwی" "هر کwی" "هر کwی" "هر کwی" Sg ;
--    have_V = mkV "رکh-ن";
    IAdvAdv adv = {s = "تا چه" ++ adv.s} ;
--    ICompAP ap = {s = "کتنE" ++ ap.s ! Sg ! Masc ! Dir ! Posit} ;
--    cost_V = mkV "قیمت" ;
    
    -- added for causitives
--    make_CV = mkVerb "نْتهنگ"   ** {c2 = "" };

-- for VP conjunction
} 
