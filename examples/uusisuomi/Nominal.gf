--# -path=.:alltenses

resource Nominal = ResFin ** open MorphoFin,CatFin,Prelude in {

  flags optimize=all ;

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
      a = vowelHarmony ukko ;
      ukk = init ukko ;
      uko = weakGrade ukko ;
      rake = Nominal.strongGrade ukko ;
      renka = Nominal.strongGrade (init ukko) ;
      o   = last ukko ;
    in
    case ukko of {
      _ + ("us" | "ys") => 
        let 
          lujuus = ukko ;
          lujuu = ukk ;
          lujuuksi = ukk + "ksi" 
        in nForms10
          lujuus (lujuu + "den") (lujuu + "tt" + a) 
          (lujuu + "ten" + a) (lujuu + "teen")
          (lujuuksi + "en") (lujuuksi + a) 
          (lujuuksi + "n" + a) (lujuuksi + "ss" + a) (lujuuksi + "in") ; 
      _ + "nen" => 
        let 
          nainen = ukko ;
          nais = Predef.tk 3 ukko + "s"
        in nForms10
          nainen (nais + "en") (nais + "t" + a) (nais + "en" + a) (nais + "een")
          (nais + "ten") (nais + "i" + a) 
          (nais + "in" + a) (nais + "iss" + a) (nais + "iin") ; 
      _ + ("aa" | "ee" | "ii" | "oo" | "uu" | "yy" | "ää" | "öö") => 
        let
          puu = ukko ;
          pui = ukk + "i" ;
          u = o ;
        in nForms10
          puu (puu + "n") (puu + "t" + a) (puu + "n" + a)  (puu + "h" + u + "n")
          (pui + "den") (pui + "t" + a) 
          (pui + "n" + a) (pui + "ss" + a) (pui + "hin") ;
      _ + ("ie" | "uo" | "yö") =>
        let
          suo = ukko ;
          soi = init ukk + o + "i" ;
        in nForms10
          suo (suo + "n") (suo + "t" + a) (suo + "n" + a)  (suo + "h" + o + "n")
          (soi + "den") (soi + "t" + a) 
          (soi + "n" + a) (soi + "ss" + a) (soi + "hin") ;
      _ + ("ea" | "eä") => 
        let
          korkea = ukko ;
          korke = init ukko ;
        in nForms10
          korkea (korkea + "n") (korkea + a) 
          (korkea + "n" + a)  (korkea + a + "n")
          (korke + "iden") (korke + "it" + a) 
          (korke + "in" + a) (korke + "iss" + a) 
          (korke + "isiin") ; --- NSSK: korkeihin
      _ + "is" => 
        let
          kaunis = ukko ;
          kaunii = init kaunis + "i" ;
        in nForms10
          kaunis (kaunii + "n") (kaunis + "t" + a) 
          (kaunii + "n" + a)  (kaunii + "seen")
          (kaunii + "den") (kaunii + "t" + a) 
          (kaunii + "n" + a) (kaunii + "ss" + a) 
          (kaunii + "siin") ;

      _ + ("i" | "u") + "n" =>  -- liitin,laidun
        let
          liitin  = ukko ;
          liittim = renka + "m" ;
        in nForms10
          liitin (liittim + "en") (liitin + "t" + a) 
          (liittim + "en" + a)  (liittim + "een")
          (liittim + "ien") (liittim + "i" + a) 
          (liittim + "in" + a) (liittim + "iss" + a) 
          (liittim + "iin") ;

      onne + "t" + on@("on" | "ön") => 
        let
          onneton  = ukko ;
          onnettom = onne + "tt" + init on + "m" ;
        in nForms10
          onneton (onnettom + a + "n") (onneton + "t" + a) 
          (onnettom + a + "n" + a)  (onnettom + a + a + "n")
          (onnettom + "ien") (onnettom + "i" + a) 
          (onnettom + "in" + a) (onnettom + "iss" + a) 
          (onnettom + "iin") ;

      _ + ("ut" | "yt") =>   -- olut,kätkyt
        nForms_rae ukko (ukk + "en" + a) ;
      _ + ("as" | "äs") =>   -- rengas,rypäs
        nForms_rae ukko (renka + a + "n" + a) ;
      _ + ("ar" | "är") =>   -- piennar,tytär
        nForms_rae ukko (renka + "ren" + a) ;
      _ + "e" => 
        nForms_rae ukko (rake + "en" + a) ;

      _ + ("a" | "o" | "u" | "y" | "ä" | "ö") => 
        nForms_ukko ukko (uko + "n") ;

      _ + "i" =>
        let
          paatte = ukk + "e" ;
          paate = init uko + "e" ;
        in nForms10
          ukko (uko + "n") (ukko + a) (ukko + "n" + a) (ukko + "in")
          (ukko + "en") (paatte + "j" + a) 
          (paatte + "in" + a) (paate + "iss" + a) (paatte + "ihin") ; 
      _ + "e" + ("l" | "n") =>
        let 
          ahven = ukko ; 
        in nForms10
          ahven (ahven + "en") (ahven +"t" + a) 
          (ahven + "en" + a) (ahven + "een")
          (ahven + "ten") (ahven + "i" + a) (ahven + "in" + a)
          (ahven + "iss" + a) (ahven + "iin") ;
      _ =>
        let 
          unixi = ukko + "i" ; 
          unixe = ukko + "e" ; 
        in nForms10
          ukko (unixi + "n") (unixi + a) (unixi + "n" + a) (unixi + "in")
          (unixi + "en") (unixe + "j" + a) (unixe + "in" + a)
          (unixe + "iss" + a) (unixe + "ihin")
    } ;   


    nForms2 : (_,_ : Str) -> NForms = \ukko,ukon -> 
      let
        a = vowelHarmony ukko ;
        ukk = init ukko ;
        ukot = nForms1 ukko ;
      in
      case <ukko,ukon> of {
        <_ + ("aa" | "ee" | "ii" | "oo" | "uu" | "yy" | "ää" | "öö" | 
              "ie" | "uo" | "yö"), _ + "n"> => ukot ; --- to protect these
        <_ + ("a" | "o" | "u" | "y" | "ä" | "ö"), _ + "n"> => 
          nForms_ukko ukko ukon ;  -- auto,auton
        <arp + "i", arv + "en"> => 
          nForms_arpi ukko ukon (arp + "i" + a) ;
        <arp + "i", _ + "i" + ("a" | "ä")> =>         -- for b-w compat.
          nForms_arpi ukko (init (weakGrade ukko) + "en") ukon ;
        <terv + "e", terv + "een"> => 
          nForms_rae ukko (terv + "een" + a) ;
        <nukk + "e", nuk + "en"> => 
          nForms10
            ukko ukon (ukko + a) (nukk +"en" + a) (nukk + "een")
            (nukk + "ien") (nukk + "ej" + a) (nukk + "ein" + a)
            (nuk + "eiss" + a) (nukk + "eihin") ;
        <_ + "s", _ + "ksen"> => table {
          1 => ukon ;
          2 => ukko + "t" + a ;
          3 => ukk + "ksen" + a ; 
          4 => ukk + "kseen" ;
          n => ukot ! n
          } ;
        <_,_ + "n"> => table {
          1 => ukon ;
          n => ukot ! n
          } ;
        <_,_ + ("a" | "ä")> => table {  -- for b-w compat.
          5 => (part2casePl ukon).p1 ;
          6 => ukon ;
          n => ukot ! n
          } ;
        _ => 
          Predef.error (["second argument should end in n, not"] ++ ukon)
       } ;

    nForms3 : (_,_,_ : Str) -> NForms = \ukko,ukon,ukkoja -> 
      let
        ukot = nForms2 ukko ukon ;
      in
      case <ukko,ukon,ukkoja> of {
        <_ + "a" | "ä", _ + "n", _ + ("a" | "ä")> => 
          let ukkojen = part2casePl ukkoja in
          table {
            5 => ukkojen.p1 ;
            6 => ukkoja ;
            7 => ukkojen.p2 ;
            8 => ukkojen.p3 ;
            9 => ukkojen.p4 ;
            n => ukot ! n
          } ;
        <_,_ + "n", _ + ("a" | "ä")> => 
          let ukkojen = part2casePl ukkoja in
          table {
            5 => ukkojen.p1 ;
            6 => ukkoja ;
            n => ukot ! n
          } ;
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


-- auxiliary "declensions"

    nForms_ukko : (_,_ : Str) -> NForms = \ukko,ukon ->
      let
        o   = last ukko ;
        a   = getHarmony o ;
        ukk = init ukko ;
        uko = init ukon ;
        uk  = init uko ;
        ukkoja = case <ukko : Str> of {
          _ + "ä" =>                        -- kylä,kyliä,kylien,kylissä,kyliin 
             <ukk + "iä", ukk + "ien", ukk, uk, ukk + "iin"> ;
          _ + ("au" | "eu") + _ + "a" =>    -- kauhojen,seurojen
             <ukk + "oja",ukk + "ojen",ukk + "o", uk + "o", ukk + "oihin"> ;
          _ + ("o" | "u") + _ + "a" =>      -- pula,pulia,pulien,pulissa,puliin
             <ukk + "ia", ukk + "ien", ukk, uk, ukk + "iin"> ;
          _ + "a" =>                        -- kala,kaloja,kalojen,-oissa,-oihin
             <ukk + "oja",ukk + "ojen",ukk + "o", uk + "o", ukk + "oihin"> ;
          _   =>                            -- suku,sukuja,sukujen,-uissa,-uihin
             <ukko + "j" + a,ukko + "jen",ukko, uko, ukko + "ihin">
        } ;
        ukkoina = ukkoja.p3 + "in" + a ; 
        ukoissa = ukkoja.p4 + "iss" + a ;
      in nForms10
        ukko ukon (ukko + a) (ukko + "n" + a) (ukko + o + "n")
        ukkoja.p2 ukkoja.p1
        ukkoina ukoissa ukkoja.p5 ; 


    nForms_arpi : (_,_,_ : Str) -> NForms = \arpi,arven,arpia ->
      let
        a = last arpia ;
        arp = init arpi ;
        arv = Predef.tk 2 arven ;
        ar  = init arp ;
        arpe = case last arp of {
         "s" => case last arv of {
            "d" | "l" | "n" | "r" =>   -- suden,sutta ; jälsi ; kansi ; hirsi
               <ar + "tt" + a, arpi + "en",arpi,ar + "t"> ;
            _ =>                                -- kuusen,kuusta
               <arp + "t" + a,arp + "ten",arpi, arp> ---- suksi,suksen
            } ;
         "r"  =>                                -- suurta,suurten
               <arp + "t" + a,arp + "ten",arpi, arp>; 
         "l" | "h" =>                           -- tuulta,tuulien
               <arp + "t" + a,arp + "ien",arpi, arp>; 
          _   =>                                -- arpea,arpien,arvissa
               <arp + "e" + a,arp + "ien",arv+"i",arp>   
          } ;                                   ---- pieni,pientä; uni,unta
        in nForms10
            arpi arven arpe.p1 (arpe.p4 + "en" + a) (arpe.p4 + "een")
            arpe.p2 arpia
            (arp + "in" + a) (arpe.p3 + "ss" + a) (arp + "iin") ; 

    nForms_rae : (_,_ : Str) -> NForms = \rae,rakeena ->
      let
        a = last rakeena ;
        rakee  = Predef.tk 2 rakeena ;
        rakei  = init rakee + "i" ;
        raetta = case <rae : Str> of {
          _ + "e" => 
            <rae + "tt" + a, rakee + "seen"> ;  -- raetta,rakeeseen
          _ + "s" => 
            <rae + "t" + a,  rakee + "seen"> ;  -- rengasta,renkaaseen
          _ + "t" => 
            <rae + "t" + a,  rakee + "en"> ;    -- olutta,olueen
          _ + "r" => 
            <rae + "t" + a,  rakee + "en"> ;    -- sisarta,sisareen
          _ => Predef.error (["expected ending e/t/s/r, found"] ++ rae)
          } ;
        in nForms10
          rae (rakee + "n") raetta.p1 (rakee + "n"+ a) raetta.p2
          (rakei + "den") (rakei + "t" + a)
          (rakei + "n" + a) (rakei + "ss" + a) (rakei + "siin") ; ---- sisariin

    NForms : Type = Predef.Ints 9 => Str ;

    nForms10 : (x1,_,_,_,_,_,_,_,_,x10 : Str) -> NForms = 
      \Ukko,ukon,ukkoa,ukkona,ukkoon,
       ukkojen,ukkoja,ukkoina,ukoissa,ukkoihin -> table {
      0 => Ukko ;
      1 => ukon ;
      2 => ukkoa ;
      3 => ukkona ;
      4 => ukkoon ;
      5 => ukkojen ;
      6 => ukkoja ;
      7 => ukkoina ;
      8 => ukoissa ;
      9 => ukkoihin
      } ;

    nForms2N : NForms -> N = \f -> 
      let
        Ukko = f ! 0 ;
        ukon = f ! 1 ;
        ukkoa = f ! 2 ;
        ukkona = f ! 3 ;
        ukkoon = f ! 4 ;
        ukkojen = f ! 5 ;
        ukkoja = f ! 6 ;
        ukkoina = f ! 7 ;
        ukoissa = f ! 8 ;
        ukkoihin = f ! 9 ;
        a     = last ukkoja ;
        uko   = init ukon ;
        ukko  = Predef.tk 2 ukkona ;
        ukkoi = Predef.tk 2 ukkoina ;
        ukoi  = Predef.tk 3 ukoissa ;
      in 
    {s = table {
      NCase Sg Nom    => Ukko ;
      NCase Sg Gen    => uko + "n" ;
      NCase Sg Part   => ukkoa ;
      NCase Sg Transl => uko + "ksi" ;
      NCase Sg Ess    => ukkona ;
      NCase Sg Iness  => uko + ("ss" + a) ;
      NCase Sg Elat   => uko + ("st" + a) ;
      NCase Sg Illat  => ukkoon ;
      NCase Sg Adess  => uko + ("ll" + a) ;
      NCase Sg Ablat  => uko + ("lt" + a) ;
      NCase Sg Allat  => uko + "lle" ;
      NCase Sg Abess  => uko + ("tt" + a) ;

      NCase Pl Nom    => uko + "t" ;
      NCase Pl Gen    => ukkojen ;
      NCase Pl Part   => ukkoja ;
      NCase Pl Transl => ukoi + "ksi" ;
      NCase Pl Ess    => ukkoina ;
      NCase Pl Iness  => ukoissa ;
      NCase Pl Elat   => ukoi + ("st" + a) ;
      NCase Pl Illat  => ukkoihin ;
      NCase Pl Adess  => ukoi + ("ll" + a) ;
      NCase Pl Ablat  => ukoi + ("lt" + a) ;
      NCase Pl Allat  => ukoi + "lle" ;
      NCase Pl Abess  => ukoi + ("tt" + a) ;

      NComit    => ukkoi + "ne" ;
      NInstruct => ukoi + "n" ;

      NPossNom _     => ukko ;
      NPossGen Sg    => ukko ;
      NPossGen Pl    => init ukkojen ;
      NPossTransl Sg => uko + "kse" ;
      NPossTransl Pl => ukoi + "kse" ;
      NPossIllat Sg  => init ukkoon ;
      NPossIllat Pl  => init ukkoihin
      } ;
    lock_N = <>
    } ;


--- This is used to analyse nouns "rae", "hake", "rengas", "laidun", etc.

  strongGrade : Str -> Str = \hanke ->
    let
      ha = Predef.tk 3 hanke ;
      nke = Predef.dp 3 hanke ; 
    in 
    ha + case nke of {
      "ng" + a => "nk" + a ;
      "nn" + e => "nt" + e ;
      "mm" + e => "mp" + e ;
      "rr" + e => "rt" + e ;
      "ll" + a => "lt" + a ;
      h@("h" | "l") + "j" + e => h + "k" + e ; -- pohje/lahje impossible
      ("hk" | "sk" | "sp" | "st") + _ => nke ;       -- viuhke,kuiske 
      a + k@("k" | "p" | "t") + e@("e"|"a"|"ä"|"u"|"i")  => a + k + k + e ;
      a + "d" + e@("e"|"a"|"ä"|"u"|"i")  => a + "t" + e ; 
      s + a@("a" | "ä") + "e" => s + a + "ke" ;       -- säe, tae
      a + "v" + e@("e"|"a"|"ä"|"u"|"i") => a + "p" + e ;  -- taive/toive imposs
      ase => ase
      } ;

  part2casePl : Str -> Str * Str * Str * Str = \savia -> case savia of {
    sav  + "i"  + a@("a" | "ä") => 
      <sav + "ien", sav + "in" + a, sav + "iss" + a, sav + "iin"> ;
    elio + "it" + a@("a" | "ä") => 
      <elio + "iden", elio + "in" + a, elio + "iss" + a, elio + "ihin"> ;
    maal + "ej" + a@("a" | "ä") => 
      <maal + "ien", maal + "ein" + a, maal + "eiss" + a, maal + "eihin"> ;
    talo + "j"  + a@("a" | "ä") => 
      <talo + "jen", talo + "in" + a, talo + "iss" + a, talo + "ihin">  ;
    _ => Predef.error (["impossible plural partitive"] ++ savia)
    } ;

}
