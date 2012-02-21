concrete RelativeSnd of Relative = CatSnd ** open ResSnd in {

  flags optimize=all_subs ;
  coding = utf8;

  lin

    RelCl cl = {
      s = \\t,p,o,agr => case <t,giveNumber agr,giveGender agr> of {
	                    <VPImpPast,Sg,_> => "jh'nk'y" ++ cl.s ! t ! p ! o ; 
			    <VPImpPast,Pl,_> => "jh'njW" ++ cl.s ! t ! p ! o ;
			    <_,Sg,Masc>          => "jyh'RW" ++ cl.s ! t ! p ! o ;
			    <_,Sg,Fem>          => "jyh'Ra" ++ cl.s ! t ! p ! o ;
			    <_,Pl,Masc>          => "jyh'Ra" ++ cl.s ! t ! p ! o ;
			    <_,Pl,Fem>          => "jyh'RyWn" ++ cl.s ! t ! p ! o 
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
      

---- Pied piping: "at which we are looking". Stranding and empty
---- relative are defined in $ExtraHin.gf$ ("that we are looking at", 
---- "we are looking at").
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
		
    	    ResSnd.Dir  => "jh'Ra" ; 
            ResSnd.Obl  => "jnh'n" ;
            ResSnd.Voc  => "jh'Ry" ;
	    ResSnd.Abl => "jh'Ry"
	    };
	  Fem => table {
		
    	    ResSnd.Dir  => "jh'Ry" ; 
            ResSnd.Obl  => "jnh'n" ;
            ResSnd.Voc  => "jh'Ry" ;
	    ResSnd.Abl => "jh'Ry"
	    }
	    };
	Pl => table {
	    Masc => table {
                    ResSnd.Dir  => "jh'Ry" ;
		    ResSnd.Obl  => "jh'Ry" ;
		    ResSnd.Voc  => "jh'Ry" ;
		    ResSnd.Abl => "jh'Ry"
			};
	    Fem => table {
                    ResSnd.Dir  => "jh'Ry" ;
		    ResSnd.Obl  => "jh'Ry" ;
		    ResSnd.Voc  => "jh'Ry" ;
		    ResSnd.Abl => "jh'Ry"
			}
	  }
       }; 
      a = RNoAg
      } ;

}
