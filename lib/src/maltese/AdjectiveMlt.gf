-- AdjectiveMlt.gf: adjectives
--
-- Maltese GF Resource Grammar
-- John J. Camilleri 2011 -- 2013
-- Licensed under LGPL

concrete AdjectiveMlt of Adjective = CatMlt ** open ResMlt, Prelude in {
  flags coding=utf8 ;

  lin

    -- A -> AP
    PositA  a = {
      s = \\gn => a.s ! (APosit gn) ;
      isPre = True -- TO CHECK
      } ;

    -- A -> NP -> AP
    ComparA a np = {
      s = \\gn => case a.hasComp of {
        True => a.s ! ACompar ;
        _    => compMore ++ a.s ! (APosit gn)
        }
        ++ conjThan ++ np.s ! Nom ; 
      isPre = False -- TO CHECK
      } ;

    -- A -> AP
    UseComparA a = {
      s = \\gn => case a.hasComp of {
        True => a.s ! ACompar ;
        _    => compMore ++ a.s ! (APosit gn)
        } ;
      isPre = False -- TO CHECK
      } ;
 
    -- Ord -> AP
    -- AdjOrd ord = {
    --   s = \\_ => ord.s ! Nom ;
    --   isPre = True
    --   } ;

  oper
    -- TODO: Don't know where these should go
    compMore : Str = "iktar" | "iżjed" ;
    compLess : Str = "inqas" ;
    conjThan : Str = "minn" ;


}
