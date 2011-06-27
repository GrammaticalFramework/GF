concrete RelativeNep of Relative = CatNep ** open ResNep in {

  flags optimize=all_subs ;
  coding = utf8;

  lin

    RelCl cl = {
      s = \\t,p,o,agr => "जस्तोकी" ++ cl.s ! t ! p ! o ;
      c = Nom
      } ;

    RelVP rp vp = {
      s = \\t,p,o,ag => 
        let 
        agr = case rp.a of {
              RNoAg => ag ;
              RAg a => a
              } ;
        cl = mkSClause (rp.s ! Nom) agr vp;
        in
        cl.s ! t ! p ! ODir ;
        c = Nom
        } ;
      

    RelSlash rp slash = {
      s = \\t,p,o,agr => rp.s ! Nom ++ slash.c2.s ++  slash.s ! t ! p ! o  ;
      c = Nom
      } ;

    
    -- CHEK NEPALI RULES FOR RELSTIVE (PG 32)
    FunRP p np rp = {
      s = \\c => rp.s ! c ++ np.s ! NPC Nom ++ p.s  ;
      a = RAg np.a
      } ;

    IdRP = {
      s = table {
		    ResNep.Nom  => "जो" ;
		    ResNep.Ins  => "जस्ले" ;
		    _           => "जो"
			} ;
      a = RNoAg
      } ;

}
