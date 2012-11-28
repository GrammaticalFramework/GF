concrete IdiomUrd of Idiom = CatUrd ** open Prelude,Predef, ResUrd,ParamX,CommonHindustani in {

  flags optimize=all_subs ;
  flags coding = utf8;

  lin
    ImpersCl vp = mkSClause " " (agrP3 Masc Sg) vp ;
    GenericCl vp = mkSClause "kwy" (agrP3 Masc Sg) vp ;

    CleftNP np rs = 
	 let cl = mkSClause (np.s ! NPC rs.c) (np.a) (predAux auxBe);
	  in 
	   {s = \\t,p,o =>  cl.s ! t ! p ! o ++ rs.s ! np.a };
	  
    CleftAdv ad ss = { s = \\t,b,o => ad.s ! Masc ++ ss.s};
        
    ExistNP np = 
      mkSClause "" (agrP3 (fromAgr np.a).g (fromAgr np.a).n) --removed wahaN
        (insertObj (\\_ => np.s ! NPC Dir) (predAux auxBe)) ;

    ExistIP ip = 
     let cl = mkSClause ("whaN" ++ ip.s ! Dir) (agrP3 ip.g ip.n) (predAux auxBe); 
	   in {
       s = \\t,p,qf => case qf of { 
	      QDir =>   cl.s ! t ! p ! ODir;
          QIndir => cl.s ! t! p ! ODir
		  }
		};

--    ProgrVP vp = insertObj (\\a => vp.obj.s ++ vp.ad ++ vp.comp ! a ++ (vp.s ! VPStem).inf ++ raha (fromAgr a).g (fromAgr a).n ) (predAux auxBe) ;
    ProgrVP vp =  (predProg vp) ;

--    ImpPl1 vp = {s = "Aw" ++ infVP True vp (agrP1 Masc Pl)} ; -- inf form is not used e.g Aw swna instead Aw swyyN (Imp.fin)
   ImpPl1 vp = {s = "Aw" ++ (vp.s ! VPImp).fin} ;
--	ImpP3 np vp = {s = np.s!NPC Dir ++ "kw" ++ (vp.s ! VPImp ).inf ++ "dw"}; here VPImp form is not correct e.g jan ko sw do, rather jan ko swnE do, and swnE is stored in vp.VPInf.fin
  ImpP3 np vp = {s = np.s!NPC Dir ++ "kw" ++ (vp.s ! VPInf ).fin ++ "dw"};


}

