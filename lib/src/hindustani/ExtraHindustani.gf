--concrete ExtraUrd of ExtraUrdAbs = CatUrd ** 
--  open ResUrd, Coordination, Prelude, MorphoUrd, ParadigmsUrd in {
incomplete concrete ExtraHindustani of ExtraHindustaniAbs = CatHindustani ** 
   open CommonHindustani,Coordination,ResHindustani, ParamX in {
  lin
--    GenNP np = {s = \\_,_,_ => np.s ! NPC Obl ++ "ka" ; a = np.a} ;
   GenNP np = {s = \\n,g,c => 
     case <n,g,c> of {
     <_,Masc,_> => np.s ! NPC Obl ++ "ka" ;
     <_,Fem,_> => np.s ! NPC Obl ++ "ky"
     };
     
   a = np.a} ;
   
   EmptyRelSlash slash = {
      s = \\t,p,o,_ => slash.s ! t ! p ! o  ++ slash.c2.s ;
      c = Obl
      } ;


    each_Det = mkDet  "hr kwy" "hr kwy" "hr kwy" "hr kwy" Sg ;
    have_V = mkV "rakh'na";
    IAdvAdv adv = {s = "ktny" ++ adv.s} ;
    ICompAP ap = {s = "ktnE" ++ ap.s ! Sg ! Masc ! Dir ! Posit} ;
    cost_V = mkV "qymt" ;
    
    -- added for causitives
    make_CV = mkVerb "nothing"   ** {c2 = "" };


   PassVPSlash vps = vsp ;
 {-   let 
      be = predAux auxBe ;
      ppt = vps.ptp
    in {
    s = be.s ;
    prp = be.prp ;
    ptp = be.ptp ;
    inf = be.inf ;
    ad = vps.ad ;
    s2 = \\a => ppt ++ vps.s2 ! a ---- order
    } ;
    -}
-- for VP conjunction
} 
