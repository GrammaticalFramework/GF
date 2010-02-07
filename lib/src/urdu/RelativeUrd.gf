concrete RelativeUrd of Relative = CatUrd ** open ResUrd in {

  flags optimize=all_subs ;

  lin

    RelCl cl = {
      s = \\t,p,o,agr => case <t,giveNumber agr> of {
	                    <VPImpPast,Sg> => "js" ++ cl.s ! t ! p ! o ; 
						<VPImpPast,Pl> => "jn" ++ cl.s ! t ! p ! o ;
						<_,_>          => "jw" ++ cl.s ! t ! p ! o 
			};
      c = Dir
      } ;

{-    RelVP rp vp = {
      s = \\t,p,o,ag => 
        let 
          agr = case rp.a of {
            RNoAg => ag ;
            RAg a => a
            } ;
		 cl = mkSClause (rp.s ! (giveNumber agr) ! Dir) agr vp;
		  
--          cl = case t of {
--                VPImpPast =>  mkSClause (rp.s ! (giveNumber agr) ! Obl) agr vp;
--				_         =>  mkSClause (rp.s ! (giveNumber agr) ! Dir) agr vp
--				};
        in
        cl.s ! t ! p ! ODir ;
      c = Dir
      } ;
--
---- Pied piping: "at which we are looking". Stranding and empty
---- relative are defined in $ExtraHin.gf$ ("that we are looking at", 
---- "we are looking at").
--
    RelSlash rp slash = {
      s = \\t,p,o,agr => rp.s ! (giveNumber agr) ! Dir ++ slash.c2.s ++  slash.s ! t ! p ! o  ;--case t of {
--	       VPImpPast => rp.s !  (giveNumber agr) Obl ++ slash.c2.s ++  slash.s ! t ! p ! o ;
--		   _         => rp.s !  (giveNumber agr) Dir ++ slash.c2.s ++  slash.s ! t ! p ! o 
--		   };
      c = Dir
      } ;
-}
    FunRP p np rp = {
      s = \\n,c => rp.s ! n ! c ++ np.s ! NPC c ++ p.s ! PP n (giveGender np.a)  ;
      a = RAg np.a
      } ;

    IdRP = {
      s = table {
        Sg => table {
		
    		Dir  => "jw" ; 
            Obl  => "js" ;
            Voc  => "js" 
			};
		Pl => table {
            Dir  => "jw" ;
		    Obl  => "jn" ;
		    Voc  => "jn"
			}
--        RPrep Neutr => "jn" ;
--        RPrep _     => "whom"
       }; 
      a = RNoAg
      } ;

}
