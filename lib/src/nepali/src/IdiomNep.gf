concrete IdiomNep of Idiom = CatNep ** open Prelude,Predef, ResNep in {

  flags optimize=all_subs ;
  flags coding = utf8;

  lin
    ImpersCl vp = mkSClause " " (agrP3 Masc Sg) vp ;
    
    GenericCl vp = mkSClause "kohI" (agrP3 Masc Sg) vp ;

    CleftNP np rs = 
	 let cl =  mkSClause (np.s ! NPC rs.c) (np.a) (predAux np.t);
        
	   in 
	   {s = \\t,p,o =>  cl.s ! t ! p ! o ++ rs.s ! np.a };
	  
    CleftAdv ad ss = { s = \\t,b,o => ad.s  ++ ss.s};
        
    ExistNP np =         
      mkSClause "tx:yhaV" (agrP3 (fromAgr np.a).g (fromAgr np.a).n) -- त्यहाँ
        (insertObj (\\_ => np.s ! NPC Nom) (predAux np.t)) ;

    ExistIP ip = 
       --let cl = mkSClause ("junx:" ++ ip.s ! Nom) (agrP3 Masc ip.n) (predAux auxBe) ; -- जुन्
       let cl = mkSClause ("tx:yhaV" ++ ip.s ! Nom) (agrP3 Masc ip.n) (predAux NonLiving) ; --  त्यहाँ
	   in {
       s = \\t,p,qf => case qf of { 
	      QDir   => cl.s ! t ! p ! ODir;
          QIndir => cl.s ! t ! p ! ODir
		  }
		};


    ProgrVP vp =  (predProg vp) ;

    ImpPl1 vp = {s =  vp.obj.s ++ (vp.s ! ResNep.Imp).inf ++ vp.comp ! (agrP1 Masc Pl)} ;
	
    --ImpP3 np vp = {s = np.s ! NPC Nom ++ "lai:" ++ (vp.s ! PVForm ).inf ++ "def"} ;
    ImpP3 np vp = {s = np.s ! NPC Acc ++ (vp.s ! PVForm ).inf ++ "def"} ;
}
