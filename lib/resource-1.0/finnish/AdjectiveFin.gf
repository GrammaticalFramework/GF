concrete AdjectiveFin of Adjective = CatFin ** open ResFin, Prelude in {

  flags optimize=all_subs ; -- gfc size from 2864336 to 6786

  lin

    PositA  a = {
      s = \\_ => a.s ! Posit
      } ;
    ComparA a np = {
      s = \\isMod,af => case isMod of {
        True => np.s ! NPCase Part ++ a.s ! Compar ! af ;        -- minua isompi
        _    => a.s ! Compar ! af ++ "kuin" ++ np.s ! NPCase Nom -- isompi kuin minä
        } 
      } ;

-- $SuperlA$ belongs to determiner syntax in $Noun$.

    ComplA2 adj np = {
      s = \\isMod,af => 
          preOrPost isMod (appCompl True Pos adj.c2 np) (adj.s ! Posit ! af)
      } ;
{-
    ReflA2 a = {
      s = \\ag => a.s ! AAdj Posit ++ a.c2 ++ reflPron ! ag ; 
      isPre = False
      } ;

    SentAP ap sc = {
      s = \\a => ap.s ! a ++ sc.s ; 
      isPre = False
      } ;
-}
    AdAP ada ap = {
      s = \\b,af => ada.s ++ ap.s ! b ! af
      } ;

    UseA2 a = a ;

}
