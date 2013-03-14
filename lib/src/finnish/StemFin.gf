-- stem-based morphology, with just the minimum number of concatenative stems

resource StemFin = open MorphoFin, Prelude in {

flags coding = utf8 ;

oper
  SNoun : Type = {s : Predef.Ints 9 => Str ; h : Harmony} ;
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

    snoun2noun : SNoun -> Noun = \sn -> 
      let
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
      NCase Sg Gen    => uko + "n" ;
      NCase Sg Part   => ukkoa ;
      NCase Sg Transl => uko + "ksi" ;
      NCase Sg Ess    => ukkona ;
      NCase Sg Iness  => uko + ("ss" + a) ;
      NCase Sg Elat   => uko + ("st" + a) ;
      NCase Sg Illat  => ukkoo + "n" ;
      NCase Sg Adess  => uko + ("ll" + a) ;
      NCase Sg Ablat  => uko + ("lt" + a) ;
      NCase Sg Allat  => uko + "lle" ;
      NCase Sg Abess  => uko + ("tt" + a) ;

      NCase Pl Nom    => uko + "t" ;
      NCase Pl Gen    => ukkoje + "n" ;
      NCase Pl Part   => ukkoja ;
      NCase Pl Transl => ukoi + "ksi" ;
      NCase Pl Ess    => ukkoi + ("n" + a) ;
      NCase Pl Iness  => ukoi + ("ss" + a) ;
      NCase Pl Elat   => ukoi + ("st" + a) ;
      NCase Pl Illat  => ukkoihi + "n" ;
      NCase Pl Adess  => ukoi + ("ll" + a) ;
      NCase Pl Ablat  => ukoi + ("lt" + a) ;
      NCase Pl Allat  => ukoi + "lle" ;
      NCase Pl Abess  => ukoi + ("tt" + a) ;

      NComit    => ukkoi + "ne" ;
      NInstruct => ukoi + "n" ;

      NPossNom _     => ukko ;
      NPossGen Sg    => ukko ;
      NPossGen Pl    => ukkoje ;
      NPossTransl Sg => uko + "kse" ;
      NPossTransl Pl => ukoi + "kse" ;
      NPossIllat Sg  => ukkoo ;
      NPossIllat Pl  => ukkoihi
      } ;
    h = sn.h ;
    lock_N = <>
    } ;


    aHarmony : Str -> Harmony = \a -> case a of 
       {"a" => Back ; _   => Front} ;

    harmonyA : Harmony -> Str = \h -> case h of 
       {Back => "a" ; Front => "ä"} ;

}