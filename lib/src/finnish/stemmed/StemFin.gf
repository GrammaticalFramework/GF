-- stem-based morphology, with just the minimum number of concatenative stems

resource StemFin = open MorphoFin, Prelude in {

flags coding = utf8 ;

oper
  SNForm : Type = Predef.Ints 9 ;
  SNoun : Type = {s : SNForm => Str ; h : Harmony} ;
--  SVerb : Type ;

  nforms2snoun : NForms -> SNoun = \nf -> {
    s = table {
      0 => nf ! 0 ;                -- ukko
      1 => Predef.tk 1 (nf ! 1) ;  -- uko(n)
      2 => nf ! 2 ;                -- ukkoa
      3 => nf ! 3 ;                -- ukkona
      4 => Predef.tk 1 (nf ! 4) ;  -- ukkoo(n)
      5 => Predef.tk 1 (nf ! 5) ;  -- ukkoje(n)
      6 => nf ! 6 ;                -- ukkoja
      7 => Predef.tk 2 (nf ! 7) ;  -- ukkoi(na)
      8 => Predef.tk 3 (nf ! 8) ;  -- ukoi(ssa)
      9 => Predef.tk 1 (nf ! 9)    -- ukkoihi(n)
      } ;
    h = aHarmony (last (nf ! 2)) ;
    } ;

    snoun2nounBind : SNoun -> Noun = snoun2noun True ;
    snoun2nounSep  : SNoun -> Noun = snoun2noun False ;

    snoun2noun : Bool -> SNoun -> Noun = \b,sn -> 
      let
        plus : Str -> Str -> Str = \x,y -> case b of {
          True  => x + y ;
          False => glue x y 
          } ;

        f = sn.s ;

        ukko    = f ! 0 ;
        uko     = f ! 1 ;
        ukkoa   = f ! 2 ;
        ukkona  = f ! 3 ;
        ukkoo   = f ! 4 ;
        ukkoje  = f ! 5 ;
        ukkoja  = f ! 6 ;
        ukkoi   = f ! 7 ;
        ukoi    = f ! 8 ;
        ukkoihi = f ! 9 ;

        a       = harmonyA sn.h ;
      in 

    {s = table {
      NCase Sg Nom    => ukko ;
      NCase Sg Gen    => plus uko "n" ;
      NCase Sg Part   => ukkoa ;
      NCase Sg Transl => plus uko "ksi" ;
      NCase Sg Ess    => ukkona ;
      NCase Sg Iness  => plus uko ("ss" + a) ;
      NCase Sg Elat   => plus uko ("st" + a) ;
      NCase Sg Illat  => plus ukkoo "n" ;
      NCase Sg Adess  => plus uko ("ll" + a) ;
      NCase Sg Ablat  => plus uko ("lt" + a) ;
      NCase Sg Allat  => plus uko "lle" ;
      NCase Sg Abess  => plus uko ("tt" + a) ;

      NCase Pl Nom    => plus uko "t" ;
      NCase Pl Gen    => plus ukkoje "n" ;
      NCase Pl Part   => ukkoja ;
      NCase Pl Transl => plus ukoi "ksi" ;
      NCase Pl Ess    => plus ukkoi ("n" + a) ;
      NCase Pl Iness  => plus ukoi ("ss" + a) ;
      NCase Pl Elat   => plus ukoi ("st" + a) ;
      NCase Pl Illat  => plus ukkoihi "n" ;
      NCase Pl Adess  => plus ukoi ("ll" + a) ;
      NCase Pl Ablat  => plus ukoi ("lt" + a) ;
      NCase Pl Allat  => plus ukoi "lle" ;
      NCase Pl Abess  => plus ukoi ("tt" + a) ;

      NComit    => plus ukkoi "ne" ;
      NInstruct => plus ukoi "n" ;

      NPossNom _     => ukko ;
      NPossGen Sg    => ukko ;
      NPossGen Pl    => ukkoje ;
      NPossTransl Sg => plus uko "kse" ;
      NPossTransl Pl => plus ukoi "kse" ;
      NPossIllat Sg  => ukkoo ;
      NPossIllat Pl  => ukkoihi
      } ;
    h = sn.h ;
    lock_N = <>
    } ;


    snoun2np : Number -> SNoun -> NPForm => Str = \n,sn ->
      \\c => (snoun2nounSep sn).s ! NCase n (npform2case n c) ; 

    noun2snoun : Noun -> SNoun = \n -> nforms2snoun (n2nforms n) ;

    aHarmony : Str -> Harmony = \a -> case a of 
       {"a" => Back ; _   => Front} ;

    harmonyA : Harmony -> Str = \h -> case h of 
       {Back => "a" ; Front => "ä"} ;


-- Adjectives

param 
  SAForm = SAN SNForm | SAAdv ;

oper
  SAdj = {s : SAForm => Str ; h : Harmony} ;

  snoun2sadj : SNoun -> SAdj = snoun2sadjComp True ;

  snoun2sadjComp : Bool -> SNoun -> SAdj = \isPos,tuore ->
    let 
      tuoree = tuore.s ! 1 ;
      tuoreesti  = tuoree + "sti" ; 
      tuoreemmin =  init tuoree ;
    in {s = table {
         SAN f => tuore.s ! f ;
         SAAdv => if_then_Str isPos tuoreesti tuoreemmin
         } ;
        h = tuore.h
       } ;


}