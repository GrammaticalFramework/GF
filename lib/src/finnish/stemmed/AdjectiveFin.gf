concrete AdjectiveFin of Adjective = CatFin ** open ResFin, StemFin, Prelude in {

  flags optimize=all_subs ; -- gfc size from 2864336 to 6786 - i.e. factor 422

  lin

    PositA  a = {
      s = \\_ => (snoun2nounSep {s = \\f => a.s ! Posit ! SAN f ; h = a.h}).s
      } ;
    ComparA a np = 
      let acomp = (snoun2nounSep {s = \\f => a.s ! Posit ! SAN f ; h = a.h}).s in {
      s = \\isMod,af => case isMod of {
        True => np.s ! NPCase Part ++ acomp ! af ;        -- minua isompi
        _    => acomp ! af ++ "kuin" ++ np.s ! NPCase Nom -- isompi kuin minä
        } 
      } ;
    CAdvAP ad ap np = {
      s = \\m,af => ad.s ++ ap.s ! m ! af ++ ad.p ++ np.s ! NPCase Nom 
      } ;
    UseComparA a = {
      s = \\_ => (snoun2nounSep {s = \\f => a.s ! Compar ! SAN f ; h = a.h}).s
      } ;

-- $SuperlA$ belongs to determiner syntax in $Noun$.
    AdjOrd ord = {
      s = \\_ => ord.s
      } ;


    ComplA2 a np = {
      s = \\isMod,af => 
          preOrPost isMod (appCompl True Pos a.c2 np)  ((snoun2nounSep {s = \\f => a.s ! Posit ! SAN f ; h = a.h}).s ! af)
      } ;

    ReflA2 a = {
      s = \\isMod,af => 
          preOrPost isMod 
            (appCompl True Pos a.c2 (reflPron (agrP3 Sg))) ((snoun2nounSep {s = \\f => a.s ! Posit ! SAN f ; h = a.h}).s ! af)
      } ;

    SentAP ap sc = {
      s = \\b,a => ap.s ! b ! a ++ sc.s
      } ;

    AdAP ada ap = {
      s = \\b,af => ada.s ++ ap.s ! b ! af
      } ;

    AdvAP ap adv = {
      s = \\b,af => adv.s ++ ap.s ! b ! af -- luonnostaan vaalea
      } ;

    UseA2 a = {
      s = \\_ => (snoun2nounSep {s = \\f => a.s ! Posit ! SAN f ; h = a.h}).s
      } ;

}
