concrete QuestionPes of Question = CatPes ** open ResPes, Prelude in {
  flags optimize=all_subs ;
    coding = utf8;

  lin

    QuestCl cl = {
      s = \\t,p,qf => case qf of { 
	              QDir => cl.s ! t ! p ! OQuest;
                      QIndir =>  cl.s ! t! p ! ODir
					  }
				};	  

    QuestVP qp vp = 
       let cl = mkSClause ("") (AgPes qp.n PPers3) vp;
--           qp1 = qp.s;
--           qp2 = qp.s ! Obl ++ "nE"
          in { s = \\t,p,o =>  qp.s ++ cl.s ! t ! p ! ODir } ;
--					 _         => qp1 ++ cl.s ! t ! p ! ODir
--					 }
					 
    QuestSlash ip slash = {
      s = \\t,p,o =>  slash.c2.s ++ ip.s ++ slash.c2.ra ++ slash.s ! t ! p ! ODir; -- order of whome and john needs to be changed
            
        };

    QuestIAdv iadv cl = { 
             s = \\t,p,_ => iadv.s ++ cl.s ! t ! p ! ODir;
                      	};

    QuestIComp icomp np = 
     let cl = mkSClause (np.s ! NPC bEzafa ++ icomp.s) np.a (predAux auxBe); 
	   in {
       s = \\t,p,qf => case qf of { 
	      QDir =>   cl.s ! t ! p ! ODir;
          QIndir => cl.s ! t! p ! ODir
		  }
		};

    PrepIP p ip = {s = p.s ++ ip.s } ;

    AdvIP ip adv = {
      s =  ip.s ++ adv.s  ;
      n = ip.n;
      } ;
 
    IdetCN idet cn = {
      s = case idet.isNum of {False => idet.s ++ cn.s ! bEzafa ! idet.n ; True => idet.s ++ cn.s ! bEzafa ! Sg} ; 
	  n = idet.n;
      } ;

    IdetIP idet = idet ;

    IdetQuant iqant num = {
      s = iqant.s  ++ num.s ; 
      n = num.n ;
      isNum = True
      } ;

    CompIAdv a = a ;
    CompIP p = ss p.s ;
    AdvIAdv i a = {s =  a.s ++ i.s } ;
  

}
