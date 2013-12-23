-- AdjectiveMlt.gf: adjectives
--
-- Maltese GF Resource Grammar
-- John J. Camilleri 2011 -- 2013
-- Licensed under LGPL

concrete AdjectiveMlt of Adjective = CatMlt ** open ResMlt, Prelude in {
  flags coding=utf8 ;

  lin

    -- A -> AP
    -- warm
    PositA  a = {
      s = \\gn => a.s ! (APosit gn) ;
      isPre = False
      } ;

    -- A -> NP -> AP
    -- warmer than I
    ComparA a np = {
      s = \\gn => case a.hasComp of {
        True => a.s ! ACompar ;
        _    => compMore ++ a.s ! (APosit gn)
        }
        ++ conjThan ++ np.s ! NPNom ;
      isPre = False
      } ;

    -- A -> AP
    -- warmer
    UseComparA a = {
      s = \\gn => case a.hasComp of {
        True => a.s ! ACompar ;
        _    => compMore ++ a.s ! (APosit gn)
        } ;
      isPre = False
      } ;

    -- Ord -> AP
    -- warmest
    --- Should be: L-IKTAR ĦOBŻA SĦUNA
    AdjOrd ord = {
      s = \\gn => ord.s ! NumNom ;
      isPre = True
      } ;

    -- CAdv -> AP -> NP -> AP
    -- as cool as John
    CAdvAP cadv ap np = {
      s = \\gn => cadv.s ++ ap.s ! gn ++ cadv.p ++ np.s ! NPNom ;
      isPre = False
      } ;

    -- A2 -> NP -> AP
    -- married to her
    ComplA2 a2 np = {
      s = \\gn => a2.s ! APosit gn ++ a2.c2.s ! Definite ++ np.s ! NPAcc ;
      isPre = False
      } ;

    -- A2 -> AP
    -- married to itself
    ReflA2 a2 = {
      s = \\gn => a2.s ! APosit gn ++ a2.c2.s ! Definite ++ prep_lil.enclitic ! (toAgr gn) ++ reflPron ! (toVAgr gn) ;
      isPre = False
      } ;

    -- AP -> SC -> AP
    -- good that she is here
    SentAP ap sc = {
      s = \\gn => ap.s ! gn ++ sc.s ;
      isPre = False
      } ;

    -- AdA -> AP -> AP
    -- very warm
    AdAP ada ap = {
      s = \\gn => ap.s ! gn ++ ada.s ;
      isPre = ap.isPre
      } ;

    -- A2 -> AP
    -- married
    UseA2 a2 = {
      s = \\gn => a2.s ! APosit gn ;
      isPre = True
      } ;

    -- AP -> Adv -> AP
    -- warm by nature
    AdvAP ap adv = {
      s = \\gn => ap.s ! gn ++ adv.s ;
      isPre = False
      } ;

  oper
    compMore : Str = "iktar" ;
    compLess : Str = "inqas" ;
    conjThan : Str = "minn" ;

}
