--# -path=.:alltenses

resource Declensions = ResFin ** open MorphoFin,CatFin,Prelude in {

  flags optimize=all ;

  oper

  dLujuus : Str -> NForms = \lujuus -> 
    let
      lujuu = init lujuus ;
      lujuuksi = lujuu + "ksi" ;
      a = vowHarmony (last lujuu) ;
    in nForms10
      lujuus (lujuu + "den") (lujuu + "tt" + a) 
      (lujuu + "ten" + a) (lujuu + "teen")
      (lujuuksi + "en") (lujuuksi + a) 
      (lujuuksi + "n" + a) (lujuuksi + "ss" + a) (lujuuksi + "in") ; 

  dNainen : Str -> NForms = \nainen ->
    let 
      a = vowHarmony nainen ;
      nais = Predef.tk 3 nainen + "s"
    in nForms10
      nainen (nais + "en") (nais + "t" + a) (nais + "en" + a) (nais + "een")
      (nais + "ten") (nais + "i" + a) 
      (nais + "in" + a) (nais + "iss" + a) (nais + "iin") ; 

  dPuu : Str -> NForms = \puu ->
    let
      a = vowHarmony puu ;
      pui = init puu + "i" ;
      u = last puu ;
    in nForms10
      puu (puu + "n") (puu + "t" + a) (puu + "n" + a)  (puu + "h" + u + "n")
      (pui + "den") (pui + "t" + a) 
      (pui + "n" + a) (pui + "ss" + a) (pui + "hin") ;

  dSuo : Str -> NForms = \suo ->
    let
      o = last suo ;
      a = vowHarmony o ;
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
      a = vowHarmony kaunis ;
      kaunii = init kaunis + "i" ;
    in nForms10
      kaunis (kaunii + "n") (kaunis + "t" + a) 
      (kaunii + "n" + a)  (kaunii + "seen")
      (kaunii + "den") (kaunii + "t" + a) 
      (kaunii + "n" + a) (kaunii + "ss" + a) 
      (kaunii + "siin") ;

  dLiitin : (_,_ : Str) -> NForms = \liitin,liittimen ->
    let
      a = vowHarmony liitin ;
      liittim = Predef.tk 2 liittimen ;
    in nForms10
      liitin (liittim + "en") (liitin + "t" + a) 
      (liittim + "en" + a)  (liittim + "een")
      (liittim + "ien") (liittim + "i" + a) 
      (liittim + "in" + a) (liittim + "iss" + a) 
      (liittim + "iin") ;

  dOnneton : Str -> NForms = \onneton ->
    let
      a = vowHarmony onneton ;
      onnettom = Predef.tk 2 onneton + "t" + last (init onneton) + "m" ;
    in nForms10
      onneton (onnettom + a + "n") (onneton + "t" + a) 
      (onnettom + a + "n" + a)  (onnettom + a + a + "n")
      (onnettom + "ien") (onnettom + "i" + a) 
      (onnettom + "in" + a) (onnettom + "iss" + a) 
      (onnettom + "iin") ;

  -- 2-syllable a/ä, o/ö, u/y
  dUkko : (_,_ : Str) -> NForms = \ukko,ukon ->
      let
        o   = last ukko ;
        a   = vowHarmony o ;
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

  -- 3-syllable a/ä/o/ö
  dSilakka : (_,_,_ : Str) -> NForms = \silakka,silakan,silakoita ->
    let
      o = last silakka ;
      a = getHarmony o ;
      silakk = init silakka ;
      silaka = init silakan ;
      silak  = init silaka ;
      silakkaa = silakka + case o of {
        "o" | "ö" => "t" + a ;  -- radiota
        _ => a                  -- sammakkoa
        } ;
      silakoiden = case <silakoita : Str> of {
        _ + "i" + ("a" | "ä") =>                    -- asemia
          <silakka+a, silakk + "ien", silakk, silak, silakk + "iin"> ;
        _ + O@("o" | "ö") + ("ja" | "jä") =>        -- pasuunoja
          <silakka+a,silakk+O+"jen",silakk+O, silak+O, silakk +O+ "ihin"> ;
        _ + O@("o" | "ö") + ("ita" | "itä") =>      -- silakoita
          <silakkaa, silak+O+"iden",silakk+O, silak+O, silakk +O+ "ihin"> ;
        _   => Predef.error silakoita                    
        } ;
      silakkoina = silakoiden.p3 + "in" + a ; 
      silakoissa = silakoiden.p4 + "iss" + a ;
    in nForms10
      silakka silakan silakoiden.p1 (silakka + "n" + a) (silakka + o + "n")
      silakoiden.p2 silakoita
      silakkoina silakoissa silakoiden.p5 ; 

   dArpi : (_,_ : Str) -> NForms = \arpi,arven ->
      let
        a = vowHarmony arpi ;
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
        a = vowHarmony rae ;
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
      a = vowHarmony paatti ;
      paatte = init paatti + "e" ;
      paati = init paatin ;
      paate = init paati + "e" ;
    in nForms10
      paatti paatin (paatti + a) (paatti + "n" + a) (paatti + "in")
      (paatti + "en") (paatte + "j" + a) 
      (paatte + "in" + a) (paate + "iss" + a) (paatte + "ihin") ; 

  dTohtori : (_ : Str) -> NForms = \tohtori ->
    let
      a = vowHarmony tohtori ;
      tohtor = init tohtori ;
    in nForms10
      tohtori (tohtori+"n") (tohtori + a) (tohtori + "n" + a) (tohtori + "in")
      (tohtor + "eiden") (tohtor + "eit" + a) 
      (tohtor + "ein" + a) (tohtor + "eiss" + a) (tohtor + "eihin") ; 

  dPiennar : (_,_ : Str) -> NForms = \piennar,pientaren ->
    let 
      a = vowHarmony piennar ;
      pientar = Predef.tk 2 pientaren ;
    in nForms10
      piennar pientaren (piennar +"t" + a) 
      (pientar + "en" + a) (pientar + "een")
      (piennar + "ten") (pientar + "i" + a) (pientar + "in" + a)
      (pientar + "iss" + a) (pientar + "iin") ;

  dUnix : (_ : Str) -> NForms = \unix ->
    let 
      a = vowHarmony unix ;
      unixi = unix + "i" ; 
      unixe = unix + "e" ; 
    in nForms10
      unix (unixi + "n") (unixi + a) (unixi + "n" + a) (unixi + "in")
      (unixi + "en") (unixe + "j" + a) (unixe + "in" + a)
      (unixe + "iss" + a) (unixe + "ihin") ;

  dNukke : (_,_ : Str) -> NForms = \nukke,nuken ->
    let
      a = vowHarmony nukke ;
      nukk = init nukke ;
      nuke = init nuken ;
    in
    nForms10
      nukke nuken (nukke + a) (nukk +"en" + a) (nukk + "een")
      (nukk + "ien") (nukk + "ej" + a) (nukk + "ein" + a)
      (nuke + "iss" + a) (nukk + "eihin") ;

  dJalas : Str -> NForms = \jalas -> 
    let
      a = vowHarmony jalas ;
      jalaks = init jalas + "ks" ;
      jalaksi = jalaks + "i" ;
    in nForms10
      jalas (jalaks + "en") (jalas + "t" + a) 
      (jalaks + "en" + a) (jalaks + "een")
      (jalas + "ten") (jalaksi + a) 
      (jalaksi + "n" + a) (jalaksi + "ss" + a) (jalaksi + "in") ; 

  dSDP : Str -> NForms = \SDP ->
    let 
      c = case last SDP of {
        "A" => 
           <"n","ta","na","han","iden","ita","ina","issa","ihin"> ;
        "B" | "C" | "D" | "E" | "G" | "P" | "T" | "V" | "W" => 
           <"n","tä","nä","hen","iden","itä","inä","issä","ihin"> ;
        "F" | "L" | "M" | "N" | "R" | "S" | "X" => 
           <"n","ää","nä","ään","ien","iä","inä","issä","iin"> ;
        "H" | "K" | "O" | "Å" => 
           <"n","ta","na","hon","iden","ita","ina","issa","ihin"> ;
        "I" | "J" => 
           <"n","tä","nä","hin","iden","itä","inä","issä","ihin"> ;
        "Q" | "U" => 
           <"n","ta","na","hun","iden","ita","ina","issa","ihin"> ;
        "Z" => 
           <"n","aa","na","aan","ojen","oja","oina","oissa","oihin"> ;
        "Ä" => 
           <"n","tä","nä","hän","iden","itä","inä","issä","ihin"> ;
        "Ö" => 
           <"n","tä","nä","hön","iden","itä","inä","issä","ihin"> ;
        _ => Predef.error (["illegal abbreviation"] ++ SDP)
        } ;
    in nForms10
      SDP (SDP + ":" + c.p1) (SDP + ":" + c.p2) (SDP + ":" + c.p3) 
      (SDP + ":" + c.p4) (SDP + ":" + c.p5) (SDP + ":" + c.p6) 
      (SDP + ":" + c.p7) (SDP + ":" + c.p8) (SDP + ":" + c.p9) ;

-- for adjective comparison

  dSuurempi : Str -> NForms = \suurempi ->
    let
      a = vowHarmony suurempi ;
      suuremp = init suurempi ;
      suuremm = Predef.tk 2 suurempi + "m" ;
    in nForms10
      suurempi (suuremm + a + "n") (suuremp + a + a) 
      (suuremp + a + "n" + a) (suuremp + a + a + "n")
      (suuremp + "ien") (suurempi + a) 
      (suurempi + "n" + a) (suuremm + "iss" + a) (suurempi + "in") ; 

  dSuurin : Str -> NForms = \suurin ->
    let
      a = vowHarmony suurin ;
      suurimm = init suurin + "mm" ;
      suurimp = init suurimm + "p" ;
    in nForms10
      suurin (suurimm + a + "n") (suurin + "t" + a) 
      (suurimp + a + "n" + a) (suurimp + a + a + "n")
      (suurimp + "ien") (suurimp + "i" + a) 
      (suurimp + "in" + a) (suurimm + "iss" + a) (suurimp + "iin") ; 


-------------------
-- auxiliaries ----
-------------------

-- the maximal set of technical stems

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

  n2nforms : N -> NForms = \ukko -> table {
    0 => ukko.s ! NCase Sg Nom ;
    1 => ukko.s ! NCase Sg Gen ;
    2 => ukko.s ! NCase Sg Part ;
    3 => ukko.s ! NCase Sg Ess ;
    4 => ukko.s ! NCase Sg Illat ;
    5 => ukko.s ! NCase Pl Gen ;
    6 => ukko.s ! NCase Pl Part ;
    7 => ukko.s ! NCase Pl Ess ;
    8 => ukko.s ! NCase Pl Iness ;
    9 => ukko.s ! NCase Pl Illat
  } ;

-- Adjective forms

    AForms : Type = {
      posit  : NForms ;
      compar : NForms ;
      superl : NForms ;
      adv_posit, adv_compar, adv_superl : Str ;
      } ;

    aForms2A : AForms -> A = \afs -> {
      s = table {
        Posit => table {
          AN n => (nForms2N afs.posit).s ! n ; 
          AAdv => afs.adv_posit
          } ;
        Compar => table {
          AN n => (nForms2N afs.compar).s ! n ; 
          AAdv => afs.adv_compar
          } ;
        Superl => table {
          AN n => (nForms2N afs.superl).s ! n ; 
          AAdv => afs.adv_superl
          }
        } ;
      lock_A = <>
      } ;

    nforms2aforms : NForms -> AForms = \nforms -> 
      let
        suure = init (nforms ! 1) ;
        suur = Predef.tk 4 (nforms ! 8) ;
      in {
        posit = nforms ;
        compar = dSuurempi (suure ++ "mpi") ;
        superl = dSuurin   (suur ++ "in") ;
        adv_posit = suure + "sti" ;
        adv_compar = suure + "mmin" ;
        adv_superl = suur + "immin" ;
      } ;

-- This is used to analyse nouns "rae", "hake", "rengas", "laidun", etc.

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

  vowHarmony : Str -> Str = \s -> case s of {
    _ + ("a" | "o" | "u") + _ => "a" ;
    _ => "ä"
    } ;

}
