

--# -path=.:../abstract:../common:../../prelude

concrete AdverbAmh of Adverb = CatAmh ** open ResAmh, Prelude,ParamX in {
flags coding = utf8;
--
  lin
         PositAdvAdj a = {s = "በ" ++ a.s ! Masc! Sg! Indef! Nom ++"ሁኔታ"} ;  

	 PrepNP prep np = {s = preOrPost2 prep.isPre (prep.s)(np.s ! Nom)(prep.s2)}; 
      
	 AdAdv ada ad ={s = ada.s ++ ad.s  };
	  
	 ComparAdvAdj c a n = {s= "ከ" ++ n.s!Nom++c.s ++c.p ++ "በ" ++ a.s ! Masc! Sg! Indef! Nom ++"ሁኔታ"};

}
