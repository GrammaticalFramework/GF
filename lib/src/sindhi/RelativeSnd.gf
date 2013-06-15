concrete RelativeSnd of Relative = CatSnd ** open ResSnd in {

  flags optimize=all_subs ;
  coding = utf8;

  lin

    RelCl cl = {
      s = \\t,p,o,agr => case <t,giveNumber agr,giveGender agr> of {
	                    <VPImpPast,Sg,_> => "جھنکي" ++ cl.s ! t ! p ! o ; 
			    <VPImpPast,Pl,_> => "جھنجو" ++ cl.s ! t ! p ! o ;
			    <_,Sg,Masc>          => "جيھڙو" ++ cl.s ! t ! p ! o ;
			    <_,Sg,Fem>          => "جيھڙا" ++ cl.s ! t ! p ! o ;
			    <_,Pl,Masc>          => "جيھڙا" ++ cl.s ! t ! p ! o ;
			    <_,Pl,Fem>          => "جيھڙيون" ++ cl.s ! t ! p ! o 
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
      

---- Pied piping: "ات whiچh wع ارع looڪiنگ". Stranding and empty
---- relative are defined in $ExtraHin.gf$ ("تhات wع ارع looڪiنگ ات", 
---- "wع ارع looڪiنگ ات").
--
    RelSlash rp slash = {
      s = \\t,p,o,agr => rp.s ! (giveNumber agr) ! (giveGender agr) ! Obl ++ slash.c2.s ++  slash.s ! t ! p ! o  ;
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
		
    	    ResSnd.Dir  => "جھڙا" ; 
            ResSnd.Obl  => "جنھن" ;
            ResSnd.Voc  => "جھڙي" ;
	    ResSnd.Abl => "جھڙي"
	    };
	  Fem => table {
		
    	    ResSnd.Dir  => "جھڙي" ; 
            ResSnd.Obl  => "جنھن" ;
            ResSnd.Voc  => "جھڙي" ;
	    ResSnd.Abl => "جھڙي"
	    }
	    };
	Pl => table {
	    Masc => table {
                    ResSnd.Dir  => "جھڙي" ;
		    ResSnd.Obl  => "جھڙي" ;
		    ResSnd.Voc  => "جھڙي" ;
		    ResSnd.Abl => "جھڙي"
			};
	    Fem => table {
                    ResSnd.Dir  => "جھڙي" ;
		    ResSnd.Obl  => "جھڙي" ;
		    ResSnd.Voc  => "جھڙي" ;
		    ResSnd.Abl => "جھڙي"
			}
	  }
       }; 
      a = RNoAg
      } ;

}
