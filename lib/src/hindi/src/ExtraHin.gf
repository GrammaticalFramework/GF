concrete ExtraHin of ExtraHinAbs = CatHin ** 
  open ResHin, Coordination, Prelude, MorphoHin, ParadigmsHin,CommonHindustani in {

flags coding = utf8 ;

  lin
 
 GenNP np = {s = \\n,g,c => 
     case <n,g,c> of {
     <Sg,Masc,Obl> => np.s ! NPC Obl ++ "ke:" ;
     <Sg,Masc,_> => np.s ! NPC Obl ++ "ka:" ;
     <Pl,Masc,_> => np.s ! NPC Obl ++ "ke:" ;
     <_,Fem,_> => np.s ! NPC Obl ++ "ki:"
     };
     
   a = np.a} ;

--    each_Det = mkDet  "hr kwy" "hr kwy" "hr kwy" "hr kwy" Sg ;
    have_V = mkV "ra:k'na:";
    IAdvAdv adv = {s = "kitni:" ++ adv.s ! Masc} ;
    ICompAP ap = {s = "kitne:" ++ ap.s ! Sg ! Masc ! Dir ! Posit} ;
    cost_V = mkV "qi:mat" ;
    
    -- added for causitives
    make_CV = mkVerb "nothing"   ** {c2 = "" };
-- for VP conjunction
} 
