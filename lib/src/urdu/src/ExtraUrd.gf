concrete ExtraUrd of ExtraUrdAbs = CatUrd ** 
  open ResUrd, Coordination, Prelude, MorphoUrd, ParadigmsUrd,CommonHindustani in {

flags coding = utf8 ;

  lin
 --   GenNP np = {s = \\_,_,_ => np.s ! NPC Obl ++ "ka" ; a = np.a} ;
  GenNP np = {s = \\n,g,c => 
     case <n,g,c> of {
     <Sg,Masc,Obl> => np.s ! NPC Obl ++ "kE" ;
     <Sg,Masc,_> => np.s ! NPC Obl ++ "ka" ;
     <Pl,Masc,_> => np.s ! NPC Obl ++ "kE" ;
     <_,Fem,_> => np.s ! NPC Obl ++ "ky"
     };
     
   a = np.a} ;

    each_Det = mkDet  "hr kwy" "hr kwy" "hr kwy" "hr kwy" Sg ;
    have_V = mkV "rakh-na";
    IAdvAdv adv = {s = "ktny" ++ adv.s ! Masc} ;
    ICompAP ap = {s = "ktnE" ++ ap.s ! Sg ! Masc ! Dir ! Posit} ;
    cost_V = mkV "qymt" ;
    
    -- added for causitives
    make_CV = mkVerb "nothing"   ** {c2 = "" };

-- for VP conjunction
} 
