concrete ExtraUrd of ExtraUrdAbs = CatUrd ** 
  open ResUrd, Coordination, Prelude, MorphoUrd, ParadigmsUrd in {

  lin
    GenNP np = {s = \\_,_,_ => np.s ! NPC Obl ++ "ka" ; a = np.a} ;

    each_Det = mkDet  "hr kwy" "hr kwy" "hr kwy" "hr kwy" Sg ;
    have_V = mkV "rakh-na";

-- for VP conjunction
} 
