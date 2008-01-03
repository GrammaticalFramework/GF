--# -path=.:alltenses

resource Declensions = ResFin ** open MorphoFin,CatFin,Prelude in {

  flags optimize=all ;

  oper

  dLujuus : Str -> NForms = \lujuus -> 
    let
      lujuu = init lujuus ;
      lujuuksi = lujuu + "ksi" ;
      a = vowelHarmony (last lujuu) ;
    in nForms10
      lujuus (lujuu + "den") (lujuu + "tt" + a) 
      (lujuu + "ten" + a) (lujuu + "teen")
      (lujuuksi + "en") (lujuuksi + a) 
      (lujuuksi + "n" + a) (lujuuksi + "ss" + a) (lujuuksi + "in") ; 

  dNainen : Str -> NForms = \nainen ->
    let 
      a = vowelHarmony nainen ;
      nais = Predef.tk 3 nainen + "s"
    in nForms10
      nainen (nais + "en") (nais + "t" + a) (nais + "en" + a) (nais + "een")
      (nais + "ten") (nais + "i" + a) 
      (nais + "in" + a) (nais + "iss" + a) (nais + "iin") ; 

  dPuu : Str -> NForms = \puu ->
    let
      a = vowelHarmony puu ;
      pui = init puu + "i" ;
      u = last puu ;
    in nForms10
      puu (puu + "n") (puu + "t" + a) (puu + "n" + a)  (puu + "h" + u + "n")
      (pui + "den") (pui + "t" + a) 
      (pui + "n" + a) (pui + "ss" + a) (pui + "hin") ;

  dSuo : Str -> NForms = \suo ->
    let
      o = last suo ;
      a = vowelHarmony o ;
      soi = Predef.tk 2 suo + o + "i" ;
    in nForms10
      suo (suo + "n") (suo + "t" + a) (suo + "n" + a)  (suo + "h" + o + "n")
      (soi + "den") (soi + "t" + a) 
      (soi + "n" + a) (soi + "ss" + a) (soi + "hin") ;

  dKorkea : Str -> NForms = \korkea ->
    let
      a = last korkea ;
      korke = init korkea ;
    in nForms10
      korkea (korkea + "n") (korkea + a) 
      (korkea + "n" + a)  (korkea + a + "n")
      (korke + "iden") (korke + "it" + a) 
      (korke + "in" + a) (korke + "iss" + a) 
      (korke + "isiin") ; --- NSSK: korkeihin

  dKaunis : Str -> NForms = \kaunis ->
    let
      a = vowelHarmony kaunis ;
      kaunii = init kaunis + "i" ;
    in nForms10
      kaunis (kaunii + "n") (kaunis + "t" + a) 
      (kaunii + "n" + a)  (kaunii + "seen")
      (kaunii + "den") (kaunii + "t" + a) 
      (kaunii + "n" + a) (kaunii + "ss" + a) 
      (kaunii + "siin") ;

  dLiitin : (_,_ : Str) -> NForms = \liitin,liittimen ->
    let
      a = vowelHarmony liitin ;
      liittim = Predef.tk 2 liittimen ;
    in nForms10
      liitin (liittim + "en") (liitin + "t" + a) 
      (liittim + "en" + a)  (liittim + "een")
      (liittim + "ien") (liittim + "i" + a) 
      (liittim + "in" + a) (liittim + "iss" + a) 
      (liittim + "iin") ;

  dOnneton : Str -> NForms = \onneton ->
    let
      a = vowelHarmony onneton ;
      onnettom = Predef.tk 2 onneton + "t" + last (init onneton) + "m" ;
    in nForms10
      onneton (onnettom + a + "n") (onneton + "t" + a) 
      (onnettom + a + "n" + a)  (onnettom + a + a + "n")
      (onnettom + "ien") (onnettom + "i" + a) 
      (onnettom + "in" + a) (onnettom + "iss" + a) 
      (onnettom + "iin") ;


  dUkko : (_,_ : Str) -> NForms = \ukko,ukon ->
      let
        o   = last ukko ;
        a   = vowelHarmony o ;
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

  dSilakka : (_,_,_ : Str) -> NForms = \silakka,silakan,silakoita ->
    let
      a   = last silakka ;
      silakk = init silakka ;
      silaka = init silakan ;
      silak  = init silaka ;
      silakoiden = case <silakoita : Str> of {
        _ + "i" + ("a" | "ä") =>                    -- asemia
          <silakk + "ien", silakk, silak, silakk + "iin"> ;
        _ + o@("o" | "ö") + ("ja" | "jä") =>        -- pasuunoja
          <silakk + o + "jen",silakk + o, silak + o, silakk + o + "ihin"> ;
        _ + o@("o" | "ö") + ("ita" | "itä") =>      -- silakoita
          <silak + o + "iden",silakk + o, silak + o, silakk + o + "ihin"> ;
       _   => Predef.error silakoita                    
       } ;
      silakkoina = silakoiden.p2 + "in" + a ; 
      silakoissa = silakoiden.p3 + "iss" + a ;
    in nForms10
      silakka silakan (silakka + a) (silakka + "n" + a) (silakka + a + "n")
      silakoiden.p1 silakoita
      silakkoina silakoissa silakoiden.p4 ; 

   dArpi : (_,_ : Str) -> NForms = \arpi,arven ->
      let
        a = vowelHarmony arpi ;
        arp = init arpi ;
        arv = Predef.tk 2 arven ;
        ar  = init arp ;
        arpe = case last arp of {
         "s" => case last arv of {
            "d" | "l" | "n" | "r" =>   -- suden,sutta ; jälsi ; kansi ; hirsi
               <ar + "tt" + a, arpi + "en",arpi,ar + "t"> ;
            _ =>                                     -- kuusta,kuusien
               <arp + "t" + a,arp + "ien",arpi, arp>
            } ;
         "r" | "n" =>                                -- suurta,suurten
               <arp + "t" + a,arp + "ten",arpi, arp>; 
         "l" | "h" =>                           -- tuulta,tuulien
               <arp + "t" + a,arp + "ien",arpi, arp>; 
          _   =>                                -- arpea,arpien,arvissa
               <arp + "e" + a,arp + "ien",arv+"i",arp>   
          } ;                                   ---- pieni,pientä; uni,unta
        in nForms10
            arpi arven arpe.p1 (arpe.p4 + "en" + a) (arpe.p4 + "een")
            arpe.p2 (arpi + a)
            (arp + "in" + a) (arpe.p3 + "ss" + a) (arp + "iin") ; 

  dRae : (_,_ : Str) -> NForms = \rae,rakeen ->
      let
        a = vowelHarmony rae ;
        rakee  = init rakeen ;
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
          rae rakeen raetta.p1 (rakee + "n"+ a) raetta.p2
          (rakei + "den") (rakei + "t" + a)
          (rakei + "n" + a) (rakei + "ss" + a) (rakei + "siin") ; ---- sisariin

  dPaatti : (_,_ : Str) -> NForms = \paatti,paatin ->
        let
          a = vowelHarmony paatti ;
          paatte = init paatti + "e" ;
          paati = init paatin ;
          paate = init paati + "e" ;
        in nForms10
          paatti paatin (paatti + a) (paatti + "n" + a) (paatti + "in")
          (paatti + "en") (paatte + "j" + a) 
          (paatte + "in" + a) (paate + "iss" + a) (paatte + "ihin") ; 

  dPiennar : (_,_ : Str) -> NForms = \piennar,pientaren ->
    let 
      a = vowelHarmony piennar ;
      pientar = Predef.tk 2 pientaren ;
    in nForms10
      piennar pientaren (piennar +"t" + a) 
      (pientar + "en" + a) (pientar + "een")
      (piennar + "ten") (pientar + "i" + a) (pientar + "in" + a)
      (pientar + "iss" + a) (pientar + "iin") ;

  dUnix : (_ : Str) -> NForms = \unix ->
        let 
          a = vowelHarmony unix ;
          unixi = unix + "i" ; 
          unixe = unix + "e" ; 
        in nForms10
          unix (unixi + "n") (unixi + a) (unixi + "n" + a) (unixi + "in")
          (unixi + "en") (unixe + "j" + a) (unixe + "in" + a)
          (unixe + "iss" + a) (unixe + "ihin") ;

  dNukke : (_,_ : Str) -> NForms = \nukke,nuken ->
    let
      a = vowelHarmony nukke ;
      nukk = init nukke ;
      nuke = init nuken ;
    in
    nForms10
      nukke nuken (nukke + a) (nukk +"en" + a) (nukk + "een")
      (nukk + "ien") (nukk + "ej" + a) (nukk + "ein" + a)
      (nuke + "iss" + a) (nukk + "eihin") ;

  dJalas : Str -> NForms = \jalas -> 
    let
      a = vowelHarmony jalas ;
      jalaks = init jalas + "ks" ;
      jalaksi = jalaks + "i" ;
    in nForms10
      jalas (jalaks + "en") (jalas + "t" + a) 
      (jalaks + "en" + a) (jalaks + "een")
      (jalas + "ten") (jalaksi + a) 
      (jalaksi + "n" + a) (jalaksi + "ss" + a) (jalaksi + "in") ; 


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
