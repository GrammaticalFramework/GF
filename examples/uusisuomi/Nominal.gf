--# -path=.:alltenses

resource Nominal = ResFin ** open MorphoFin,Declensions,CatFin,Prelude in {

  flags optimize=noexpand ;

  oper

--  mkN = overload {
    mk1N : (talo : Str) -> N = \s -> nForms2N (nForms1 s) ;
    mk2N : (talo,talon : Str) -> N = \s,t -> nForms2N (nForms2 s t) ;
    mk3N : (talo,talon,taloja : Str) -> N = \s,t,u -> nForms2N (nForms3 s t u) ;
    mk4N : (talo,talon,taloa,taloja : Str) -> N = \s,t,u,v -> 
      nForms2N (nForms4 s t u v) ;
--  } ;

  nForms1 : Str -> NForms = \ukko ->
    let
      ukk = init ukko ;
      uko = weakGrade ukko ;
      renka = Declensions.strongGrade (init ukko) ;
      rake = Declensions.strongGrade ukko ;
    in
    case ukko of {
      _ + ("us" | "ys") => dLujuus ukko ;
      _ + "nen" => dNainen ukko ;
      _ + ("aa" | "ee" | "ii" | "oo" | "uu" | "yy" |"ää"|"öö") => dPuu ukko ;
      _ + ("ai" | "ei" | "oi" | "ui" | "yi" | "äi" | "öi") => dPuu ukko ;
      _ + ("ie" | "uo" | "yö") => dSuo ukko ;
      _ + ("ea" | "eä") => dKorkea ukko ;
      _ + "is" => dKaunis ukko ;
      _ + ("i" | "u") + "n" => dLiitin ukko (renka + "men") ;
      _ + ("ton" | "tön") => dOnneton ukko ;
      _ + ("ut" | "yt") => dRae ukko (ukk + "en") ;
      _ + ("as" | "äs") => dRae ukko (renka + last renka + "n") ;
      _ + "e" => dRae ukko (rake + "en") ;
      _ + ("a" | "o" | "u" | "y" | "ä" | "ö") => dUkko ukko (uko + "n") ;
      _ + "i" => dPaatti ukko (uko + "n") ;
      _ + ("ar" | "är") => dPiennar ukko (renka + "ren") ;
      _ + "e" + ("l" | "n") => dPiennar ukko (ukko + "en") ;
      _ => dUnix ukko
    } ;   

    nForms2 : (_,_ : Str) -> NForms = \ukko,ukon -> 
      let
        ukk = init ukko ;
      in
      case <ukko,ukon> of {
        <_ + ("aa" | "ee" | "ii" | "oo" | "uu" | "yy" | "ää" | "öö" | 
              "ie" | "uo" | "yö" | "ea" | "eä"), _ + "n"> => 
           nForms1 ukko ; --- to protect
        <_ + ("a" | "o" | "u" | "y" | "ä" | "ö"), _ + "n"> => 
          dUkko ukko ukon ;  -- auto,auton
        <arp + "i", arv + "en"> => dArpi ukko ukon ;
        <arp + "i", _ + "i" + ("a" | "ä")> =>         -- for b-w compat.
          dArpi ukko (init (weakGrade ukko) + "en") ;
        <terv + "e", terv + "een"> => 
          dRae ukko (terv + "een") ;
        <nukk + "e", nuk + "en"> => dNukke ukko ukon ;
        <_ + "s", _ + "ksen"> => dJalas ukko ; 
        <_, _ + "n"> => nForms1 ukko ;
        _ => 
          Predef.error (["second argument should end in n, not"] ++ ukon)
       } ;

    nForms3 : (_,_,_ : Str) -> NForms = \ukko,ukon,ukkoja -> 
      let
        ukot = nForms2 ukko ukon ; 
      in
      case <ukko,ukon,ukkoja> of {

        <_ + ("aa" | "ee" | "ii" | "oo" | "uu" | "yy" | "ää" | "öö" | 
              "ie" | "uo" | "yö" | "ea" | "eä"), _ + "n", _> => 
          nForms1 ukko ; --- to protect
        <_ + "a" | "ä", _ + "n", _ + ("a" | "ä")> => 
          dSilakka ukko ukon ukkoja ;
        <_, _ + "n", _ + ("a" | "ä")> => ukot ;
        _ => 
          Predef.error 
           (["last arguments should end in n and a/ä, not"] ++ ukon ++ ukkoja)
      } ;

    nForms4 : (_,_,_,_ : Str) -> NForms = \ukko,ukon,ukkoa,ukkoja -> 
      let
        ukot = nForms3 ukko ukon ukkoja ;
      in
      case <ukko,ukon,ukkoa,ukkoja> of {
        <_,_ + "n", _ + ("a" | "ä"), _ + ("a" | "ä")> => 
          table {
            2 => ukkoa ;
            n => ukot ! n
          } ;
        _ => 
          Predef.error 
            (["last arguments should end in n, a/ä, and a/ä, not"] ++ 
            ukon ++ ukkoa ++ ukkoja)
      } ;

}
