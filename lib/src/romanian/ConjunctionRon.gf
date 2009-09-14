concrete ConjunctionRon of Conjunction = 
  CatRon ** open ResRon, Coordination, Prelude in {

  flags optimize=all_subs ;

  lin
   
    ConjS conj ss = conjunctDistrTable Mood conj ss ;

    ConjAdv conj ss = conjunctDistrSS conj ss ;

    ConjNP conj ss = heavyNP (conjunctDistrTable NCase conj ss ** {
      a = {g = ss.a.g ; n = conjNumber conj.n ss.a.n ; p = ss.a.p} ;
      hasClit = ss.hasClit;
      ss = "" ---- fix this !!!! 
      }) ;


    ConjAP conj ss = conjunctDistrTable AForm conj ss ** {
      isPre = ss.isPre
      } ;
  
  ConjRS conj ss = conjunctDistrTable2 Mood Agr conj ss ** {
      c = ss.c
      } ;


-- These fun's are generated from the list cat's.

    BaseS = twoTable Mood ;
    ConsS = consrTable Mood comma ;
    BaseAdv = twoSS ;
    ConsAdv = consrSS comma ;
  BaseNP x y = {
      s1 = \\c => (x.s ! c).comp ; 
      s2 = \\c => (y.s ! c).comp ;  
      a = conjAgr x.a y.a;
      hasClit = andB x.hasClit y.hasClit
      } ;  
 ConsNP x xs = {
      s1 = \\c => (x.s ! c).comp ++ comma ++ xs.s1 ! c ; ----e (conjunctCase c) ; 
      s2 = \\c => xs.s2 ! c ; ----e (conjunctCase c) ; 
      a = conjAgr x.a xs.a ;
      hasClit = andB xs.hasClit x.hasClit
      } ;

    BaseAP x y = twoTable AForm x y ** {isPre = andB x.isPre y.isPre} ;
    ConsAP xs x = consrTable AForm comma xs x ** {isPre = andB xs.isPre x.isPre} ;
    BaseRS x y = twoTable2 Mood Agr x y ** {c = y.c} ;
   ConsRS xs x = consrTable2 Mood Agr comma xs x ** {c = xs.c} ;

  lincat
     [S] = {s1,s2 : Mood => Str} ;
    [Adv] = {s1,s2 : Str} ;
    [NP] = {s1,s2 : NCase => Str ; a : Agr; hasClit : Bool} ;
    [AP] = {s1,s2 : AForm  => Str ; isPre : Bool} ;
    [RS] = {s1,s2 : Mood => Agr => Str ; c : NCase} ;
 
};
