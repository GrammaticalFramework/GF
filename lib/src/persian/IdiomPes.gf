concrete IdiomPes of Idiom = CatPes ** open Prelude,Predef, ResPes in {

  flags optimize=all_subs ;
  flags coding = utf8;

  lin
 
    ImpersCl vp = mkSClause " " (agrPesP3 Sg) vp ;
    GenericCl vp = mkSClause "آدم" (agrPesP3 Sg) vp ;

    CleftNP np rs = 
	 let cl = mkSClause (np.s ! NPC bEzafa) (np.a) (predAux auxBe);
	  in 
	   {s = \\t,p,o =>  cl.s ! t ! p ! o ++ rs.s ! np.a };
	  
    CleftAdv ad ss = { s = \\t,b,o => ad.s ++ ss.s};
        
    ExistNP np = 
      mkSClause " " (agrPesP3 (fromAgr np.a).n) 
        (insertObj (\\_ => np.s ! NPC bEzafa) (predAux auxBe)) ;

    ExistIP ip = 
     let cl = mkSClause ( ip.s ) (agrPesP3 ip.n) (predAux auxBe); 
	   in {
       s = \\t,p,qf => case qf of { 
	      QDir =>   cl.s ! t ! p ! ODir;
          QIndir => cl.s ! t! p ! ODir
		  }
		};

--    ProgrVP vp = insertObj (\\a => vp.obj.s ++ vp.ad ++ vp.comp ! a ++ (vp.s ! VPStem).inf ++ raha (fromAgr a).g (fromAgr a).n ) (predAux auxBe) ;
    ProgrVP vp =  (predProg vp) ;


    ImpPl1 vp = {s = "بیایید" ++ (vp.s ! VVForm (agrPesP1 Pl)).inf} ;
	ImpP3 np vp = {s = "بگذارید" ++ np.s!NPC bEzafa ++ (vp.s ! VVForm (AgPes (fromAgr np.a).n (fromAgr np.a).p)).inf};


}

