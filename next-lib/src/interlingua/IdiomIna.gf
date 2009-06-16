concrete IdiomIna of Idiom = CatIna ** open Prelude, ResIna in {

  flags optimize=all_subs ;

  lin
    ImpersCl vp = mkClause "il"  Sp3 vp ;
    GenericCl vp = mkClause "on" Sp3 vp ;

    CleftNP np rs = mkClause "lo" Sp3
      (insertObj [] Acc (mkInvarNP (rs.s ! Sp3))
         (insertObj []  Acc np 
	    (predV_ esserV)));
	 -- ??? number/case agreement

    CleftAdv ad s = mkClause "lo" Sp3
      (insertObj [] Acc (mkInvarNP ("que" ++ s.s))
        (insertObj [] Acc (mkInvarNP (ad.s)) (predV_ esserV))) ;


    ExistNP np = 
      mkClause "il" Sp3 ((insertObj "" Acc np) (predV_ haberV)) ;
    -- Il ha colonias que non pote reclamar mesmo un tal origine. (sample text 3)

    ExistIP ip = mkQuestion {s=ip.s ! Acc} (mkClause "il" Sp3 (predV_ haberV)) ;
    -- Never seen the above, but we can deduce it exists, since it's
    -- merely an interrogative form of ExistNP.

    ProgrVP vp = vp; -- progressive tense is the same as present in Interlingua. 
    -- (parag. 80+ of Grammatica de Interlingua)

    ImpPl1 vp = {s = "que" ++ (mkClause "nos" {n = Pl ; p = P1} vp).s ! variants {True;False} ! Pres ! Simul ! Pos ! ODir};

}

