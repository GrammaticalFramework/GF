concrete QuestionUrd of Question = CatUrd ** open ResUrd, Prelude in {
--
  flags optimize=all_subs ;

  lin

    QuestCl cl = {
      s = \\t,p,qf => case qf of { 
	                  QDir => cl.s ! t ! p ! OQuest;
                      QIndir => "agr" ++ cl.s ! t! p ! ODir
					  }
				};	  

    QuestVP qp vp = 

       let cl = mkSClause (qp.s ! Dir) (Ag qp.g qp.n Pers3_Near) vp;
	       cl2 = mkSClause (qp.s ! Obl ++ "nE" ) (Ag qp.g Sg Pers3_Near) vp
--        in {s = \\t,p,o => cl.s ! t ! p ! ODir} ;
          in { s = \\t,p,o => case t of {
		             VPImpPast => cl2.s ! t ! p ! ODir;
					 _         => cl.s ! t ! p ! ODir
					 }
					}; 
--    QuestSlash ip slash = 
--      mkQuestion (ss (slash.c2 ++ ip.s ! Acc)) slash ;
--      --- stranding in ExratHin 

    QuestIAdv iadv cl = { 
             s = \\t,p,_ => iadv.s ++ cl.s ! t ! p ! ODir;
                      	};

    QuestIComp icomp np = 
	let cl = mkSClause (np.s ! NPC Dir ++ icomp.s) np.a (predAux auxBe); 
	   in {
       s = \\t,p,qf => case qf of { 
	      QDir =>   cl.s ! t ! p ! ODir;
          QIndir => cl.s ! t! p ! ODir
		  }
		};

    PrepIP p ip = {s = ip.s ! Voc ++ p.s ! PP ip.n ip.g } ;

    AdvIP ip adv = {
      s = \\c => adv.s ++ ip.s ! c ;
      n = ip.n;
	  g = ip.g;
      } ;
 
    IdetCN idet cn = {
      s = \\c => idet.s ! cn.g ++ cn.s ! idet.n ! c ; 
      g = cn.g;
	  n = idet.n;
      } ;

    IdetIP idet = {
     s = \\_ => idet.s ! Masc ; 
      n = idet.n;
	  g = Masc;
      } ;

    IdetQuant iqant num = {
      s = \\g => iqant.s ! num.n ++ num.s ; 
      n = num.n
      } ;

    CompIAdv a = a ;
    CompIP p = ss (p.s ! Dir) ;

}
