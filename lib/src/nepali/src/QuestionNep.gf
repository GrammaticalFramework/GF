concrete QuestionNep of Question = CatNep ** open ResNep, Prelude in {
  
  flags optimize=all_subs ;
  coding = utf8;

  lin

    QuestCl cl = {
      s = \\t,p,qf => 
         case qf of { 
	        QDir   => cl.s ! t ! p ! OQuest;
            QIndir => "yedi" ++ cl.s ! t ! p ! ODir
			}
		 } ;	  

    QuestVP qp vp = 
       let cl  = mkSClause ("") (Ag Masc qp.n Pers3_M) vp; -- Pers3_M
           qp1 = qp.s ! Nom;
           qp2 = qp.s ! Ins
           in { s = \\t,p,o => 
              case t of {
-- 	           VPSmplPast => qp2 ++ cl.s ! t ! p ! ODir ;
	           _          => qp1 ++ cl.s ! t ! p ! ODir
               }
			} ; 


    QuestSlash ip slash = 
      let ip1 = ip.s ! Nom;
          ip2 = ip.s ! Ins
          in {
          s = \\t,p,o => case t of { 
--            VPSmplPast => ip2 ++ slash.s ! t ! p ! ODir ;
              _          => ip2 ++ slash.s ! t ! p ! ODir
            }
        };

    QuestIAdv iadv cl = { 
        s = \\t,p,_ => iadv.s ++ cl.s ! t ! p ! ODir;
        } ;

    QuestIComp icomp np = 
     let cl =  mkSClause (np.s ! NPC Nom ++ icomp.s) np.a (predAux NonLiving) ;--(predAux np.t); to test mkQCl-IAdv-NP-QCl                     
	   in {                                                                    -- eg उनी कहाँ छिन् - (छिन् - NonLiving case) 
       s = \\t,p,qf => case qf of { 
	      QDir   => cl.s ! t ! p ! ODir;
          QIndir => cl.s ! t ! p ! ODir
		  }
		};

    PrepIP p ip = {s = ip.s ! ResNep.Nom ++ p.s } ; -- case need to be confirmed

    AdvIP ip adv = {
      s = \\c => adv.s  ++ ip.s ! c ;
      n = ip.n;
      g = ip.g;
      } ;
 
    IdetCN idet cn = {
      s = \\c => idet.s ! Masc++ cn.s ! idet.n ! c ; 
	  n = idet.n;
      } ;

    IdetIP idet = {
      s = \\_ => idet.s ! Masc ; 
      n = idet.n;
      } ;

    IdetQuant iqant num = {
      s =\\_ => iqant.s ! num.n ++ num.s ;
      n = num.n ;
      } ;

    CompIAdv a = a ;
    CompIP p = ss (p.s ! Nom) ;
    AdvIAdv i a = {s = i.s ++ a.s} ;
    AdvQVP vp iadv = insertObj (\\_ => iadv.s) vp ;
    AddAdvQVP qvp iadv = insertObj (\\_ => iadv.s) qvp ;
    ComplSlashIP vpslash ip = insertObj (\\_ => ip.s ! Nom) vpslash ;
    
   --QuestQVP      : IP -> QVP -> QCl ;       -- who buys what where
   QuestQVP ip qvp = 
     let cl  = mkSClause ("") (Ag Masc ip.n Pers3_M) qvp ; -- Pers3_M
         qp1 = ip.s ! Nom ;
         qp2 = ip.s ! Ins
         in { s = \\t,p,o => 
            case t of {
-- 	        VPSmplPast => qp2 ++ cl.s ! t ! p ! ODir ;
	        _          => qp1 ++ cl.s ! t ! p ! ODir
            }
		} ; 
   
   lincat QVP = CatNep.VP ;
   
}
