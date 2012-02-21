concrete IdiomSnd of Idiom = CatSnd ** open Prelude,Predef, ResSnd in {

  flags optimize=all_subs ;
  flags coding = utf8;

  lin
    ImpersCl vp = mkSClause " " (agrP3 Masc Sg) vp ;
    GenericCl vp = mkSClause "ڪو۶ی" (agrP3 Masc Sg) vp ;

    CleftNP np rs = 
	 let cl = mkSClause (np.s ! NPC rs.c) (np.a) (predAux auxBe);
	  in 
	   {s = \\t,p,o =>  cl.s ! t ! p ! o ++ rs.s ! np.a };
	  
    CleftAdv ad ss = { s = \\t,b,o => ad.s ! Masc ++ ss.s};
        
    ExistNP np = 
      mkSClause "ھتی" (agrP3 (fromAgr np.a).g (fromAgr np.a).n) 
        (insertObj (\\_ => np.s ! NPC Dir) (predAux auxBe)) ;

    ExistIP ip = 
     let cl = mkSClause ("ھتی" ++ ip.s ! Dir) (agrP3 ip.g ip.n) (predAux auxBe); 
	   in {
       s = \\t,p,qf => case qf of { 
	      QDir =>   cl.s ! t ! p ! ODir;
          QIndir => cl.s ! t! p ! ODir
		  }
		};

    ProgrVP vp =  (predProg vp) ;


    ImpPl1 vp = {s = "اچ" ++ (vp.s ! VPReq).inf} ;
--	ImpP3 np vp = {s = np.s!NPC Dir ++ "کی" ++ (vp.s ! VPImp ).inf ++ "ڏی"}; here VPImp form is not correct e.g jan ko sw do, rather jan ko swnE do, and swnE is stored in vp.VPInf.fin
  ImpP3 np vp = {s = np.s!NPC Dir ++ "کی" ++ (vp.s ! VPInf ).fin ++ "ڏیو"};



}

