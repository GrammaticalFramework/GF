-- RelativeMlt.gf: relational clauses and pronouns
--
-- Maltese GF Resource Grammar
-- John J. Camilleri 2011 -- 2013
-- Licensed under LGPL

concrete RelativeMlt of Relative = CatMlt ** open ResMlt in {

  flags optimize=all_subs ;

  lin
    -- Cl -> RCl
    RelCl cl = {
      s = \\t,a,p,_ => "li" ++ cl.s ! t ! a ! p ! ODir ;
      } ;

    -- RP -> VP -> RCl
    RelVP rp vp = {
      s = \\t,ant,p,agr =>
        let
          cl = mkClause rp.s agr vp
        in
        cl.s ! t ! ant ! p ! ODir ;
      } ;

    -- RP -> ClSlash -> RCl
    RelSlash rp slash = {
      s = \\t,a,p,agr =>
        rp.s ++ slash.s ! t ! a ! p ! ODir ;
      } ;

    -- Prep -> NP -> RP -> RP
    FunRP prep np rp = {
      s = np.s ! NPAcc ++ (prep.s ! bool2definiteness np.isDefn) ++ rp.s ;
      } ;

    -- RP
    IdRP = { s = "li" } ;

}
