concrete RelativePes of Relative = CatPes ** open ResPes in {

  flags optimize=all_subs ;
  coding = utf8;

  lin

    RelCl cl = {
      s = \\t,p,o,agr =>  "که" ++ cl.s ! t ! p ! o ; 
	};				    
-- RelVP and RelSlash slows the linking process a lot this is why it is commented for test purposes

    RelVP rp vp = {
      s = \\t,p,o,ag => 
        let 
          agr = case rp.a of {
            RNoAg => ag ;
            RAg a => a
            } ;
		 cl = mkSClause (rp.s) agr vp;
		  
--          cl = case t of {
--                VPImpPast =>  mkSClause (rp.s ! (giveNumber agr) ! Obl) agr vp;
--				_         =>  mkSClause (rp.s ! (giveNumber agr) ! Dir) agr vp
--				};
        in
        cl.s ! t ! p ! ODir ;
--      c = Dir
      } ;
      

---- Pied piping: "ت wهعه we رe لْْکنگ". Stranding and empty
---- relative are defined in $ExtraHin.gf$ ("تهت we رe لْْکنگ ت", 
---- "we رe لْْکنگ ت").
--
    RelSlash rp slash = {
      s = \\t,p,o,agr => rp.s ++ slash.c2.s ++  slash.s ! t ! p ! o  ;--case t of {
--	       VPImpPast => rp.s !  (giveNumber agr) Obl ++ slash.c2.s ++  slash.s ! t ! p ! o ;
--		   _         => rp.s !  (giveNumber agr) Dir ++ slash.c2.s ++  slash.s ! t ! p ! o 
--		   };
--      c = Dir
      } ;

    FunRP p np rp = {
      s = np.s ! NPC enClic ++ rp.s ++  p.s ++ getPron np.animacy (fromAgr np.a).n   ; -- need to make a special form of relative np by addY
      a = RAg np.a
      } ;

    IdRP = {
      s = "که" ;
      a = RNoAg
      } ;
 
}
