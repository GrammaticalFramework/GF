concrete ExtraHin of ExtraHinAbs = CatHin ** 
  open ResHin, Coordination, Prelude, MorphoHin, ParadigmsHin,CommonHindustani in {

flags coding = utf8 ;

  lin
 
 GenNP np = {s = \\n,g,c => 
     case <n,g,c> of {
     <Sg,Masc,Obl> => np.s ! NPC Obl ++ "के" ;
     <Sg,Masc,_> => np.s ! NPC Obl ++ "का" ;
     <Pl,Masc,_> => np.s ! NPC Obl ++ "के" ;
     <_,Fem,_> => np.s ! NPC Obl ++ "की"
     };
     
   a = np.a} ;

--    each_Det = mkDet  "हर कwय" "हर कwय" "हर कwय" "हर कwय" Sg ;
    have_V = mkV "राखना";
    IAdvAdv adv = {s = "कितनी" ++ adv.s ! Masc} ;
    ICompAP ap = {s = "कितने" ++ ap.s ! Sg ! Masc ! Dir ! Posit} ;
    cost_V = mkV "क़ीमत" ;
    
    -- added for causitives
    make_CV = mkVerb "नoतहिनग"   ** {c2 = "" };
-- for VP conjunction
} 
