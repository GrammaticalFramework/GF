incomplete concrete RelativeRomance of Relative = 
  CatRomance ** open Prelude, CommonRomance, ResRomance in {

  flags optimize=all_subs ;

  lin

    RelCl cl = {
      s = \\t,a,p,m,ag => pronSuch ! ag ++ conjThat ++ cl.s ! t ! a ! p ! m
      } ;

    RelVP rp vp = {
      s = \\t,ant,b,m,ag => 
        let 
          agr = case rp.a of {
            RNoAg => ag ;
            RAg a => a ** {p = P3}
            } ;
          cl = mkClause (rp.s ! False ! ag ! Nom) agr vp
        in
        cl.s ! t ! ant ! b ! m
      } ;
{-
    RelSlash rp slash = {
      s = \\t,a,p,ag => 
          rp.s ! ag.gn ! RNom ++ slash.s ! t ! a ! p ! Sub ++ slash.c2
      } ;
-}

    FunRP p np rp = {
      s = \\_,a,c => np.s ! Ton Nom ++ p.s ++ rp.s ! True ! a ! p.c ;
      a = RAg np.a
      } ;
    IdRP = {
      s = relPron ; 
      a = RNoAg
      } ;

--    RCl  = {s : Tense => Anteriority => Polarity => Mood => Agr => Str} ;
--    RP   = {s : AAgr  => RelForm => Str ; a : RAgr} ;

}
