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
      ukon = uko + "n" ;
      renka = Declensions.strongGrade (init ukko) ;
      rake = Declensions.strongGrade ukko ;
    in
    case ukko of {
      _ + "nen" => dNainen ukko ;
      _ + ("aa" | "ee" | "ii" | "oo" | "uu" | "yy" |"ää"|"öö") => dPuu ukko ;
      _ + ("ai" | "ei" | "oi" | "ui" | "yi" | "äi" | "öi") => dPuu ukko ;
      _ + ("ie" | "uo" | "yö") => dSuo ukko ;
      _ + ("ea" | "eä") => dKorkea ukko ;
      _ + "is" => dKaunis ukko ;
      _ + ("i" | "u") + "n" => dLiitin ukko (renka + "men") ;
      _ + ("ton" | "tön") => dOnneton ukko ;
      _ + "e" => dRae ukko (rake + "en") ;
      _ + ("ut" | "yt") => dRae ukko (ukk + "en") ;
      _ + ("as" | "äs") => dRae ukko (renka + last renka + "n") ;
      _ + ("uus" | "yys") => dLujuus ukko ;
      _ + "s" => dJalas ukko ; 
      _ + ("a" | "e" | "i") + C_ + _ + "aja" =>  -- opettaja correct autom. 
          dSilakka ukko (ukko + "n") (ukk + "ia") ;
      _ + ("a" | "e" | "i" | "o" | "u") + C_ + _ + "ija" =>  
          dSilakka ukko (ukko + "n") (ukk + "oita") ;
      _ + ("e" | "i" | "y" | "ä" | "ö") + C_ + _ + "ijä" =>  
          dSilakka ukko (ukko + "n") (ukk + "öitä") ;
      _ + "i" +o@("o"|"ö") => dSilakka ukko (ukko+"n") (ukko+"it"+getHarmony o);
      _ + "i" + "a" => dSilakka ukko (ukko + "n") (ukk + "oita") ;
      _ + "i" + "ä" => dSilakka ukko (ukko + "n") (ukk + "öitä") ;
      _ + ("a" | "o" | "u" | "y" | "ä" | "ö") => dUkko ukko ukon ;
      _ + "i" => dPaatti ukko ukon ;
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
              "ie" | "uo" | "yö" | "ea" | "eä" | 
              "ia" | "iä" | "io" | "iö" | "ja" | "jä"), _ + "n"> => 
           nForms1 ukko ; --- to protect
        <_ + ("a" | "o" | "u" | "y" | "ä" | "ö"), _ + "n"> => 
          dUkko ukko ukon ;  -- auto,auton
        <arp + "i", arv + "en"> => dArpi ukko ukon ;
---        <arp + "i", _ + "i" + ("a" | "ä")> =>         -- for b-w compat.
---          dArpi ukko (init (weakGrade ukko) + "en") ;
        <terv + "e", terv + "een"> => 
          dRae ukko ukon ;
        <taiv + ("as" | "äs"), taiv + ("aan" | "ään")> => 
          dRae ukko ukon ;
        <nukk + "e", nuk + "en"> => dNukke ukko ukon ;
        <_ + ("us" | "ys"), _ + "den"> => dLujuus ukko ;
        <_, _ + ":n"> => dSDP ukko ;
        <_, _ + "n"> => nForms1 ukko ;
        _ => 
          Predef.error (["second argument should end in n, not"] ++ ukon)
       } ;

    nForms3 : (_,_,_ : Str) -> NForms = \ukko,ukon,ukkoja -> 
      let
        ukot = nForms2 ukko ukon ; 
      in
      case <ukko,ukon,ukkoja> of {
        <_ + "ea", _ + "ean", _ + "oita"> => 
          dSilakka ukko ukon ukkoja ;  -- idea, but not korkea
        <_ + ("aa" | "ee" | "ii" | "oo" | "uu" | "yy" | "ää" | "öö" | 
              "ie" | "uo" | "yö" | "ea" | "eä" | 
              "ia" | "iä" | "io" | "iö"), _ + "n"> => 
          nForms1 ukko ; --- to protect --- how to get "dioja"?
        <_ + ("a" | "ä" | "o" | "ö"), _ + "n", _ + ("a" | "ä")> => 
          dSilakka ukko ukon ukkoja ;
        <_ + "i", _ + "n", _ + ("eita" | "eitä")> => 
          dTohtori ukko ;
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
