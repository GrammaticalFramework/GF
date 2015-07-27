concrete IdiomGer of Idiom = CatGer ** 
  open MorphoGer, ParadigmsGer, Prelude in {

  flags optimize=all_subs ;
    coding=utf8 ;

  lin
    ImpersCl vp = mkClause "es" (agrP3 Sg) vp ;
    GenericCl vp = mkClause "man" (agrP3 Sg) vp ;

    CleftNP np rs = mkClause "es" (agrP3 Sg) 
      (insertExtrapos (rs.s ! RGenNum (gennum (genderAgr np.a) (numberAgr np.a))) ----
        (insertObj (\\_ => np.s ! NPC rs.c) (predV MorphoGer.sein_V))) ;

    CleftAdv ad s = mkClause "es" (agrP3 Sg) 
      (insertExtrapos (conjThat ++ s.s ! Sub)
        (insertObj (\\_ => ad.s) (predV MorphoGer.sein_V))) ;


    ExistNP np = 
      mkClause "es" (agrP3 Sg) 
        (insertObj (\\_ => appPrep geben.c2 np.s) 
          (predV geben)) ;

    ExistIP ip = {
      s = \\m,t,a,p => 
            let 
              cls = 
                (mkClause "es" (agrP3 Sg)  (predV geben)).s ! m ! t ! a ! p ;
              who = ip.s ! Acc
            in table {
              QDir   => who ++ cls ! Inv ;
              QIndir => who ++ cls ! Sub
              }
      } ;

    ExistNPAdv np adv= 
      mkClause "es" (agrP3 Sg) 
        (insertAdv adv.s (insertObj (\\_ => appPrep geben.c2 np.s) 
          (predV geben))) ;

    ExistIPAdv ip adv = {
      s = \\m,t,a,p => 
            let 
              cls = 
                (mkClause "es" (agrP3 Sg)  (insertAdv adv.s (predV geben))).s ! m ! t ! a ! p ;
              who = ip.s ! Acc
            in table {
              QDir   => who ++ cls ! Inv ;
              QIndir => who ++ cls ! Sub
              }
      } ;

    ProgrVP = insertAdv "eben" ; ----

    ImpPl1 vp = {s = 
      (mkClause "wir" (Ag Fem Pl P1) vp).s ! 
                           MConjunct ! Pres ! Simul ! Pos ! Inv 
      } ;

    ImpP3 np vp = {
      s = (mkClause ((mkSubj np vp.subjc).p1) np.a vp).s ! 
                           MConjunct ! Pres ! Simul ! Pos ! Inv 
      } ;

  SelfAdvVP vp = insertAdv "selbst" vp ;
  SelfAdVVP vp = insertAdv "selbst" vp ;
  SelfNP np = np ** {
      s = \\c => np.s ! c ++ "selbst" ;
      isPron = False ;
      } ;

  oper
    geben = dirV2 (mk6V "geben" "gibt" "gib" "gab" "gäbe" "gegeben") ;
}

