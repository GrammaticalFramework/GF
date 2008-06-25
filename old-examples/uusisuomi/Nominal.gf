--# -path=.:alltenses

resource Nominal = ResFin ** open MorphoFin,Declensions,CatFin,Prelude in {

  flags optimize=noexpand ;

  oper

  mkN : overload {
    mkN : (talo : Str) -> N ;
    mkN : (talo,talon : Str) -> N ;
    mkN : (talo,talon,taloja : Str) -> N ;
    mkN : (talo,talon,taloja,taloa : Str) -> N ;
    mkN : (sora : Str) -> (tie : N) -> N ;
    mkN : (oma : N) -> (tunto : N) -> N ;
  } ;

  mkA : overload {
    mkA : Str -> A ;
    mkA : N -> A ;
    mkA : (hyva,parempi,paras : N) -> (hyvin,paremmin,parhaiten : Str) -> A ;
  } ;

  showN : N -> Utt = \talo -> 
    let t = talo.s in ss (
      t ! NCase Sg Nom ++
      t ! NCase Sg Gen ++
      t ! NCase Sg Part ++
      t ! NCase Sg Ess ++
      t ! NCase Sg Illat ++
      t ! NCase Pl Gen ++
      t ! NCase Pl Part ++
      t ! NCase Pl Ess ++
      t ! NCase Pl Iness ++
      t ! NCase Pl Illat
      ) ** {lock_Utt = <>} ;

  mkN = overload {
    mkN : (talo : Str) -> N = mk1N ;
    --  \s -> nForms2N (nForms1 s) ;
    mkN : (talo,talon : Str) -> N = mk2N ;
    --  \s,t -> nForms2N (nForms2 s t) ;
    mkN : (talo,talon,taloja : Str) -> N = mk3N ;
    --  \s,t,u -> nForms2N (nForms3 s t u) ;
    mkN : (talo,talon,taloja,taloa : Str) -> N = mk4N ;
    --  \s,t,u,v -> nForms2N (nForms4 s t u v) ;
    mkN : 
      (talo,talon,taloa,talona,taloon,talojen,taloja,taloina,taloissa,taloihin
        : Str) -> N = mk10N ;
    mkN : (sora : Str) -> (tie : N) -> N = mkStrN ;
    mkN : (oma,tunto : N) -> N = mkNN ;
  } ;

  mk1A : Str -> A = \jalo -> aForms2A (nforms2aforms (nForms1 jalo)) ;
  mkNA : N -> A = \suuri -> aForms2A (nforms2aforms (n2nforms suuri)) ;

  mk1N : (talo : Str) -> N = \s -> nForms2N (nForms1 s) ;
  mk2N : (talo,talon : Str) -> N = \s,t -> nForms2N (nForms2 s t) ;
  mk3N : (talo,talon,taloja : Str) -> N = \s,t,u -> nForms2N (nForms3 s t u) ;
  mk4N : (talo,talon,taloa,taloja : Str) -> N = \s,t,u,v -> 
      nForms2N (nForms4 s t u v) ;
  mk10N : 
      (talo,talon,taloa,talona,taloon,talojen,taloja,taloina,taloissa,taloihin
        : Str) -> N = \a,b,c,d,e,f,g,h,i,j -> 
        nForms2N (nForms10 a b c d e f g h i j) ;

  mkStrN : Str -> N -> N = \sora,tie -> {
    s = \\c => sora + tie.s ! c ; lock_N = <>
    } ;
  mkNN : N -> N -> N = \oma,tunto -> {
    s = \\c => oma.s ! c + tunto.s ! c ; lock_N = <>
    } ; ---- TODO: oma in possessive suffix forms

  nForms1 : Str -> NForms = \ukko ->
    let
      ukk = init ukko ;
      uko = weakGrade ukko ;
      ukon = uko + "n" ;
      o = case last ukko of {"ä" => "ö" ; "a" => "o"} ; -- only used then 
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
      _ + ("uus" | "yys" | "eus" | "eys") => dLujuus ukko ;
      _ + "s" => dJalas ukko ; 

{- heuristics for 3-syllable nouns ending a/ä
      _ + ("a" | "e" | "i" | "o" | "u" | "y" | "ä" | "ö") + C_ + 
          _ + "i" + C_ + a@("a" | "ä") =>  
          dSilakka ukko (ukko + "n") (ukk + o + "it" + a) ;
      _ + ("a" | "e" | "i" | "o" | "u" | "y" | "ä" | "ö") + C_ + _ + 
          ("a" | "e" | "o" | "u" | "y" | "ä" | "ö") + 
          ("l" | "r" | "n") + a@("a" | "ä") =>  
          dSilakka ukko (ukko + "n") (ukk + o + "it" + a) ;
      _ + ("a" | "e" | "i" | "o" | "u" | "y" | "ä" | "ö") + C_ + _ + 
          ("a" | "e" | "i" | "o" | "u" | "y" | "ä" | "ö") + 
          ("n" | "k" | "s") + "k" + a@("a" | "ä") =>  
          dSilakka ukko (uko + "n") (init uko + o + "it" + a) ;
      _ + ("a" | "e" | "i" | "o" | "u" | "y" | "ä" | "ö") + C_ + _ + 
          ("a" | "e" | "i" | "o" | "u" | "y" | "ä" | "ö") + 
          ("n" | "t" | "s") + "t" + a@("a" | "ä") =>  
          dSilakka ukko (uko + "n") (ukk + o + "j" + a) ;
      _ + ("a" | "e" | "i" | "o" | "u") + C_ + _ + 
          ("a" | "e" | "o" | "u") + C_ + "a" =>  
          dSilakka ukko (ukko + "n") (ukk + "ia") ;
-}
      _ + "i" +o@("o"|"ö") => dSilakka ukko (ukko+"n") (ukko+"it"+getHarmony o);
      _ + "i" + "a" => dSilakka ukko (ukko + "n") (ukk + "oita") ;
      _ + "i" + "ä" => dSilakka ukko (ukko + "n") (ukk + "öitä") ;
      _ + ("a" | "o" | "u" | "y" | "ä" | "ö") => dUkko ukko ukon ;
      _ + "i" => dPaatti ukko ukon ;
      _ + ("ar" | "är") => dPiennar ukko (renka + "ren") ;
      _ + "e" + ("l" | "n") => dPiennar ukko (ukko + "en") ;
      _ => dUnix ukko
    } ;   


    nForms2 : (_,_ : Str) -> NForms = \ukko,ukkoja -> 
      let
        ukot = nForms1 ukko ; 
        ukon = weakGrade ukko + "n" ;
      in
      case <ukko,ukkoja> of {
        <_ + "ea", _ + "oita"> => 
          dSilakka ukko ukon ukkoja ;  -- idea, but not korkea
        <_ + ("aa" | "ee" | "ii" | "oo" | "uu" | "yy" | "ää" | "öö" | 
              "ie" | "uo" | "yö" | "ea" | "eä" | 
              "ia" | "iä" | "io" | "iö"), _ + ("a" | "ä")> => 
          nForms1 ukko ; --- to protect --- how to get "dioja"?
        <_ + ("a" | "ä" | "o" | "ö"), _ + ("a" | "ä")> => 
          dSilakka ukko ukon ukkoja ;
        <arp + "i", _ + "i" + ("a" | "ä")> =>
          dArpi ukko (init (weakGrade ukko) + "en") ;
        <_ + "i", _ + ("eita" | "eitä")> => 
          dTohtori ukko ;
        <_ + "e", nuk + ("eja" | "ejä")> => 
          dNukke ukko ukon ;
        <_, _ + ":" + _ + ("a" | "ä")> => dSDP ukko ;
        <_ + ("l" | "n" | "r" | "s"), _ + ("eja" | "ejä")> => dUnix ukko ;
        <_, _ + ("a" | "ä")> => ukot ;
        _ => 
          Predef.error 
           (["last argument should end in a/ä, not"] ++ ukkoja)
      } ;

    nForms3 : (_,_,_ : Str) -> NForms = \ukko,ukon,ukkoja -> 
      let
        ukk = init ukko ;
        ukot = nForms2 ukko ukkoja ;
      in
      case <ukko,ukon> of {
        <_ + ("aa" | "ee" | "ii" | "oo" | "uu" | "yy" | "ää" | "öö" | 
              "ie" | "uo" | "yö" | "ea" | "eä" | 
              "ia" | "iä" | "io" | "iö" | "ja" | "jä"), _ + "n"> => 
           ukot ; --- to protect
        <_ + ("a" | "o" | "u" | "y" | "ä" | "ö"), _ + "n", _ + ("a" | "ä")> => 
          dSilakka ukko ukon ukkoja ;  -- auto,auton
        <_ + "mpi", _ + ("emman" | "emmän")> => dSuurempi ukko ;
        <_ + "in", _ + ("imman" | "immän")> => dSuurin ukko ;
        <terv + "e", terv + "een"> => 
          dRae ukko ukon ;
        <taiv + ("as" | "äs"), taiv + ("aan" | "ään")> => 
          dRae ukko ukon ;
        <nukk + "e", nuk + "een"> => dRae ukko ukon ;
        <arp + "i", arv + "en"> => dArpi ukko ukon ;
        <_ + ("us" | "ys"), _ + "den"> => dLujuus ukko ;
        <_, _ + ":n"> => dSDP ukko ;
        <_, _ + "n"> => ukot ;
        _ => 
          Predef.error (["second argument should end in n, not"] ++ ukon)
       } ;



    nForms4 : (_,_,_,_ : Str) -> NForms = \ukko,ukon,ukkoja,ukkoa -> 
      let
        ukot = nForms3 ukko ukon ukkoja ;
      in
      case <ukko,ukon,ukkoja,ukkoa> of {
        <_,_ + "n", _ + ("a" | "ä"), _ + ("a" | "ä")> => 
          table {
            2 => ukkoa ;
            n => ukot ! n
          } ;
        _ => 
          Predef.error 
            (["last arguments should end in n, a/ä, and a/ä, not"] ++ 
            ukon ++ ukkoja ++ ukkoa)
      } ;

}
