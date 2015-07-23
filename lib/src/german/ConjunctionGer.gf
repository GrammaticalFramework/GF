concrete ConjunctionGer of Conjunction = 
  CatGer ** open ResGer, Coordination, Prelude in {

  flags optimize=all_subs ;

  lin

    ConjS conj ss = conjunctDistrTable Order conj ss ;

    ConjAdv conj ss = conjunctDistrSS conj ss ;

    ConjNP conj ss = heavyNP (conjunctDistrTable PCase conj ss ** {
      a = Ag Fem (conjNumber conj.n (numberAgr ss.a)) (personAgr ss.a) ;
      }) ;

    ConjAP conj ss = conjunctDistrTable AForm conj ss ** {
      isPre = ss.isPre ; c = ss.c ; ext = ss.ext} ;

    ConjRS conj ss = conjunctDistrTable RelGenNum conj ss ** {
      c = ss.c
      } ;


-- These fun's are generated from the list cat's.

    BaseS x y = { -- twoTable Order ;
      s1 = x.s ;
      s2 = table {Inv => y.s ! Main ; o => y.s ! o}
      } ;
    ConsS x xs = { -- consrTable Order comma ;
      s1 = \\o => x.s ! Inv ++ comma ++ xs.s1 ! case o of {Inv => Main ; _ => o} ;
      s2 = xs.s2
      } ;

    BaseAdv = twoSS ;
    ConsAdv = consrSS comma ;
    BaseNP x y = {
		s1 = \\c => x.s ! c ++ bigNP x ;
		s2 = \\c => y.s ! c ++ bigNP y ;
		a = conjAgr x.a y.a } ;
    ConsNP xs x = {
		s1 = \\c => xs.s ! c ++ bigNP xs ++ comma ++ x.s1 ! c ;
		s2 = x.s2 ;
		a = conjAgr xs.a x.a } ;
    BaseAP x y = {
		s1 = bigAP x ;
		s2 = bigAP y ;
		isPre = andB x.isPre y.isPre ;
		c = <[],[]> ;
	  	ext = []} ;
   ConsAP xs x = {
		s1 = \\a => (bigAP xs) ! a ++ comma ++ x.s1 ! a ;
		s2 = x.s2 ;
		isPre = andB x.isPre xs.isPre ;
		c = <[],[]> ;
	  	ext = []} ;
    BaseRS x y = twoTable RelGenNum x y ** {c = y.c} ;
    ConsRS xs x = consrTable RelGenNum comma xs x ** {c = xs.c} ;

  lincat
    [S] = {s1,s2 : Order => Str} ;
    [Adv] = {s1,s2 : Str} ;
    [NP] = {s1,s2 : PCase => Str ; a : Agr} ;
    [AP] = {s1,s2 : AForm => Str ; isPre : Bool; c : Str * Str ; ext : Str} ;
    [RS] = {s1,s2 : RelGenNum => Str ; c : Case} ;

  oper
    bigAP : AP -> AForm => Str = \ap ->
		\\a => ap.c.p1 ++ ap.s ! a ++ ap.c.p2 ++ ap.ext;
}
