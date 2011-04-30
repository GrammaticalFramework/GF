concrete RelativePnb of Relative = CatPnb ** open ResPnb in {

  flags optimize=all_subs ;
  coding = utf8;

  lin

    RelCl cl = {
      s = \\t,p,o,agr => case <t,giveNumber agr,giveGender agr> of {
	                    <VPImpPast,Sg,_> => "جنے" ++ cl.s ! t ! p ! o ; 
			    <VPImpPast,Pl,_> => "جناں" ++ cl.s ! t ! p ! o ;
			    <_,Sg,Masc>          => "جعڑا" ++ cl.s ! t ! p ! o ;
			    <_,Sg,Fem>          => "جعڑی" ++ cl.s ! t ! p ! o ;
			    <_,Pl,Masc>          => "جعڑے" ++ cl.s ! t ! p ! o ;
			    <_,Pl,Fem>          => "جعڑیاں" ++ cl.s ! t ! p ! o 
			};
      c = Dir
      } ;
-- RelVP and RelSlash slows the linking process a lot this is why it is commented for test purposes

    RelVP rp vp = {
      s = \\t,p,o,ag => 
        let 
          agr = case rp.a of {
            RNoAg => ag ;
            RAg a => a
            } ;
		 cl = mkSClause (rp.s ! (giveNumber agr) ! (giveGender agr) ! Dir) agr vp;
		  
--          cl = case t of {
--                VPImpPast =>  mkSClause (rp.s ! (giveNumber agr) ! Obl) agr vp;
--				_         =>  mkSClause (rp.s ! (giveNumber agr) ! Dir) agr vp
--				};
        in
        cl.s ! t ! p ! ODir ;
      c = Dir
      } ;
      

---- Pied piping: "ات وہiچہ وع ارع لooكiنگ". Stranding and empty
---- relative are defined in $ExtraHin.gf$ ("تہات وع ارع لooكiنگ ات", 
---- "وع ارع لooكiنگ ات").
--
    RelSlash rp slash = {
      s = \\t,p,o,agr => rp.s ! (giveNumber agr) ! (giveGender agr) ! Obl ++ slash.c2.s ++  slash.s ! t ! p ! o  ;--case t of {
--	       VPImpPast => rp.s !  (giveNumber agr) Obl ++ slash.c2.s ++  slash.s ! t ! p ! o ;
--		   _         => rp.s !  (giveNumber agr) Dir ++ slash.c2.s ++  slash.s ! t ! p ! o 
--		   };
      c = Dir
      } ;

    FunRP p np rp = {
      s = \\n,g,c => rp.s ! n ! g ! c ++ np.s ! NPC c ++ p.s  ;
      a = RAg np.a
      } ;

    IdRP = {
      s = table {
        Sg => table {
	  Masc => table {
		
    	    ResPnb.Dir  => "جیڑا" ; 
            ResPnb.Obl  => "جن" ;
            ResPnb.Voc  => "جیڑے" ;
	    ResPnb.Abl => "جیڑے"
	    };
	  Fem => table {
		
    	    ResPnb.Dir  => "جیڑی" ; 
            ResPnb.Obl  => "جن" ;
            ResPnb.Voc  => "جیڑی" ;
	    ResPnb.Abl => "جیڑی"
	    }
	    };
	Pl => table {
	    Masc => table {
                    ResPnb.Dir  => "جیڑے" ;
		    ResPnb.Obl  => "جیڑے" ;
		    ResPnb.Voc  => "جیڑے" ;
		    ResPnb.Abl => "جیڑے"
			};
	    Fem => table {
                    ResPnb.Dir  => "جیڑی" ;
		    ResPnb.Obl  => "جیڑی" ;
		    ResPnb.Voc  => "جیڑی" ;
		    ResPnb.Abl => "جیڑی"
			}
	  }
       }; 
      a = RNoAg
      } ;

}
