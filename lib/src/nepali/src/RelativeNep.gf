concrete RelativeNep of Relative = CatNep ** open ResNep in {

  flags optimize=all_subs ;
  coding = utf8;

  lin

    RelCl cl = {
      s = \\t,p,o,agr => "jsx:tikI" ++ cl.s ! t ! p ! o ;
      c = Nom
      } ;

-- RelVP and RelSlash slows the linking process a lot this is why it is commented for test purposes

    RelVP rp vp = {
      s = \\t,p,o,ag => 
        let 
          agr = case rp.a of {
            RNoAg => ag ;
            RAg a => a
            } ;
		 cl = mkSClause (rp.s ! Nom) agr vp;
		  
--          cl = case t of {
--                VPImpPast =>  mkSClause (rp.s ! (giveNumber agr) ! Obl) agr vp;
--				_         =>  mkSClause (rp.s ! (giveNumber agr) ! Dir) agr vp
--				};

        in
        cl.s ! t ! p ! ODir ;
        c = Nom
        } ;
      

---- Pied piping: 'at which we are looking'. Stranding and empty
---- relative are defined in $ExtraHin.gf$ ("that we are looking at", 
---- "we are looking at").
--
    RelSlash rp slash = {
      s = \\t,p,o,agr => rp.s ! Nom ++ slash.c2.s ++  slash.s ! t ! p ! o  ;--case t of {
--	       VPImpPast => rp.s !  (giveNumber agr) Obl ++ slash.c2.s ++  slash.s ! t ! p ! o ;
--		   _         => rp.s !  (giveNumber agr) Dir ++ slash.c2.s ++  slash.s ! t ! p ! o 
--		   };
      c = Nom
      } ;

    
    -- CHEK NEPALI RULES FOR RELSTIVE (PG 32)
    FunRP p np rp = {
      s = \\c => rp.s ! c ++ np.s ! NPC Nom ++ p.s  ;
      a = RAg np.a
      } ;

    IdRP = {
      s = table {
		    ResNep.Nom  => "jo" ;
		    ResNep.Ins  => "jsx:le" ;
		    _           => "jo"
			} ;
      a = RNoAg
      } ;

}
