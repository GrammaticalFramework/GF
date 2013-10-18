concrete AdjectiveEst of Adjective = CatEst ** open ResEst, Prelude in {

  -- gfc size from 2864336 to 6786 - i.e. factor 422
  flags optimize=all_subs ; coding=utf8;

  lin

    PositA  a = {
      s = \\_,nf => a.s ! Posit ! AN nf ;
      infl = a.infl
      } ;
    ComparA a np = {
      s = \\isMod,af => case isMod of {
        True => np.s ! NPCase Elat ++ a.s ! Compar ! AN af ;        -- minust suurem
        _    => a.s ! Compar ! AN af ++ "kui" ++ np.s ! NPCase Nom  -- suurem kui mina
        } ;
      infl = Regular ; --a.infl
      } ;
      
    CAdvAP ad ap np = {
      s = \\m,af => ad.s ++ ap.s ! m ! af ++ ad.p ++ np.s ! NPCase Nom ;
      infl = ap.infl 
      } ;
    UseComparA a = {
      s = \\_,nf => a.s ! Compar ! AN nf ;
      infl = Regular ; --a.infl
      } ;

-- $SuperlA$ belongs to determiner syntax in $Noun$.
    AdjOrd ord = {
      s = \\_ => ord.s ;
      infl = Regular
      } ;


    ComplA2 adj np = {
      s = \\isMod,af => 
          preOrPost isMod (appCompl True Pos adj.c2 np) (adj.s ! Posit ! AN af) ;
      infl = adj.infl
      } ;

    ReflA2 adj = {
      s = \\isMod,af => 
          preOrPost isMod 
            (appCompl True Pos adj.c2 (reflPron (agrP3 Sg))) (adj.s ! Posit ! AN af) ;
      infl = adj.infl
      } ;

    SentAP ap sc = {
      s = \\b,a => ap.s ! b ! a ++ sc.s ;
      infl = ap.infl
      } ;

    AdAP ada ap = {
      s = \\b,af => ada.s ++ ap.s ! b ! af ;
      infl = ap.infl
      } ;

    UseA2 a = {
      s = \\_,nf => a.s ! Posit ! AN nf ;
      infl = a.infl
      } ;

}
