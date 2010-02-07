concrete IdiomUrd of Idiom = CatUrd ** open Prelude,Predef, ResUrd in {

  flags optimize=all_subs ;

  lin
    ImpersCl vp = mkSClause " " (agrP3 Masc Sg) vp ;
    GenericCl vp = mkSClause "kwy" (agrP3 Masc Sg) vp ;

    CleftNP np rs = 
	 let cl = mkSClause (np.s ! NPC rs.c) (np.a) (predAux auxBe);
	  in 
	   {s = \\t,p,o =>  cl.s ! t ! p ! o ++ rs.s ! np.a };
	  
--      (insertObj (\\_ => rs.s ! np.a ++ ",") (predAux auxBe));
--        (insertObj (\\_ => np.s ! NPC rs.c) (predAux auxBe))) ;

    CleftAdv ad ss = { s = \\t,b,o => ad.s ++ ss.s};
        
--    CleftAdv ad s = mkClause ad.s (agrP3 Masc Sg) 
--      (insertObj (\\_ => optStr conjThat ++ s.s)
--        (insertObj (\\_ => ad.s) (predAux auxBe))) ;
--
    ExistNP np = 
      mkSClause "whaN" (agrP3 (fromAgr np.a).g (fromAgr np.a).n) 
        (insertObj (\\_ => np.s ! NPC Obl) (predAux auxBe)) ;
--
    ExistIP ip = 
     let cl = mkSClause ("whaN" ++ ip.s ! Dir) (agrP3 ip.g ip.n) (predAux auxBe); 
	   in {
       s = \\t,p,qf => case qf of { 
	      QDir =>   cl.s ! t ! p ! ODir;
          QIndir => cl.s ! t! p ! ODir
		  }
		};
--      mkQuestion (ss (ip.s ! Nom)) 
--        (mkClause "there" (agrP3 ip.n) (predAux auxBe)) ;
--
--    ProgrVP vp = insertObj (\\a => vp.ad ++ vp.prp ++ vp.s2 ! a) (predAux auxBe) ;
--
--    ImpPl1 vp = {s = "Aw" ++ infVP True vp (agrP1 Masc Pl)} ;
--    ImpPl1 vp = {s = "Aw" ++ (vp.s ! VPTense VPFutr (Ag Masc Pl Pers3_Near)).inf2} ;
--	ImpP3 np vp = {s = np.s!NPC Dir ++ "kw" ++ (vp.s ! VPImp ).inf2 ++ "dw"};
--

}

