--# -path=.:alltenses

resource Conjugations = ResFin ** open MorphoFin,Declensions,CatFin,Prelude in {

  flags optimize=all ;

  oper

  cHukkua : (_,_ : Str) -> VForms = \hukkua,hukun -> 
    let
      a     = last hukkua ;
      hukku = init hukkua ;
      huku  = init hukun ;
      u     = last huku ;
      i = case u of {
        "e" | "i" => [] ;
        _ => u
        } ;
      y = uyHarmony a ;
      hukkui = init hukku + i + "i" ; 
      hukui  = init huku + i + "i" ; 
    in vForms12
      hukkua
      hukun
      (hukku + u)
      (hukku + "v" + a + "t")
      (hukku + "k" + a + a)
      (huku + "t" + a + a + "n")
      (hukui + "n")
      hukkui
      (hukkui + "si")
      (hukku + "n" + y + "t")
      (huku + "tt" + y)
      (hukku + "nee") ;

  cOttaa : (_,_,_,_ : Str) -> VForms = \ottaa,otan,otin,otti -> 
    let
      a    = last ottaa ;
      aa   = a + a ;
      u    = uyHarmony a ;
      ota  = init otan ;
      otta = init ottaa ;
      ote  = init ota + "e" ;
    in vForms12
      ottaa
      otan
      ottaa
      (otta + "v" + a + "t") 
      (otta + "k" + aa) 
      (ote  + "t" + aa + "n")
      otin
      otti
      (otta + "isi")
      (otta + "n" + u + "t")
      (ote + "tt" + u)
      (otta + "nee") ;

  cJuosta : (_,_ : Str) -> VForms = \juosta,juoksen -> 
    let
      a      = last juosta ;
      juos   = Predef.tk 2 juosta ;
      juoss  = juos + last juos ;
      juokse = init juoksen ;
      juoks  = init juokse ;
      u      = uyHarmony a ;
      juoksi = juoks + "i" ;
    in vForms12
      juosta
      (juoksen)
      (juokse + "e")
      (juokse + "v" + a + "t")
      (juos + "k" + a + a)
      (juosta + a + "n")
      (juoks + "in")
      (juoks + "i")
      (juoks + "isi")
      (juoss + u + "t")
      (juos + "t" + u)
      (juoss + "ee") ;

  cJuoda : (_ : Str) -> VForms = \juoda -> 
    let
      a      = last juoda ;
      juo    = Predef.tk 2 juoda ;
      joi    = case last juo of {
        "i" => juo ;                     -- naida
        o   => Predef.tk 2 juo + o + "i"
        } ;
      u      = uyHarmony a ;
    in vForms12
      juoda
      (juo + "n")
      (juo)
      (juo + "v" + a + "t")
      (juo + "k" + a + a)
      (juoda + a + "n")
      (joi + "n")
      (joi)
      (joi + "si")
      (juo + "n" + u + "t")
      (juo + "t" + u)
      (juo + "nee") ;

  cPudota : (_,_ : Str) -> VForms = \pudota,putosi -> 
    let
      a      = last pudota ;
      pudot  = init pudota ;
      pudo   = init pudot ;
      ai = case last pudo of {
        "a" | "ä" => <[], "i"> ;
        _         => <a, a + "i">
        } ;
      puto   = Predef.tk 2 putosi ;
      u      = uyHarmony a ;
    in vForms12
      pudota
      (puto  + a + "n")
      (puto  + ai.p1 + a)
      (puto  + a + "v" + a + "t")
      (pudot + "k" + a + a)
      (pudot + a + a + "n")
      (puto  + "sin")
      (puto  + "si")
      (puto  + ai.p2 + "si")
      (pudo  + "nn" + u + "t")
      (pudot + "t" + u)
      (pudo  + "nnee") ;

  cHarkita : (_ : Str) -> VForms = \harkita -> 
    let
      a      = last harkita ;
      harkit = init harkita ;
      harki  = init harkit ;
      u      = uyHarmony a ;
    in vForms12
      harkita
      (harkit + "sen")
      (harkit + "se")
      (harkit + "sev" + a + "t")
      (harkit + "k" + a + a)
      (harkit + a + a + "n")
      (harkit + "sin")
      (harkit + "si")
      (harkit + "sisi")
      (harki  + "nn" + u + "t")
      (harkit + "t" + u)
      (harki  + "nnee") ;

  cValjeta : (_,_ : Str) -> VForms = \valjeta,valkeni -> 
    let
      a      = last valjeta ;
      valjet = init valjeta ;
      valken = init valkeni ;
      valje  = init valjet ;
      u      = uyHarmony a ;
    in vForms12
      valjeta
      (valken + "en")
      (valken + "ee")
      (valken + "ev" + a + "t")
      (valjet + "k" + a + a)
      (valjet + a + a + "n")
      (valken + "in")
      (valken + "i")
      (valken + "isi")
      (valje  + "nn" + u + "t")
      (valjet + "t" + u)
      (valje  + "nnee") ;

  cKuunnella : (_,_ : Str) -> VForms = \kuunnella,kuuntelin -> 
    let
      a       = last kuunnella ;
      kuunnel = Predef.tk 2 kuunnella ;
      kuuntel = Predef.tk 2 kuuntelin ;
      u       = uyHarmony a ;
    in vForms12
      kuunnella
      (kuuntel + "en")
      (kuuntel + "ee")
      (kuuntel + "ev" + a + "t")
      (kuunnel + "k" + a + a)
      (kuunnella + a + "n")
      (kuuntel + "in")
      (kuuntel + "i")
      (kuuntel + "isi")
      (kuunnel + "l" + u + "t")
      (kuunnel + "t" + u)
      (kuunnel + "lee") ;

-- auxiliaries

    uyHarmony : Str -> Str = \a -> case a of {
      "a" => "u" ;
      _ => "y"
      } ;

    VForms : Type = Predef.Ints 11 => Str ;

    vForms12 : (x1,_,_,_,_,_,_,_,_,_,_,x12 : Str) -> VForms = 
      \olla,olen,on,ovat,olkaa,ollaan,olin,oli,olisi,ollut,oltu,lienee ->
      table {
        0 => olla ;
        1 => olen ;
        2 => on ;
        3 => ovat ;
        4 => olkaa ;
        5 => ollaan ;
        6 => olin ;
        7 => oli ;
        8 => olisi ;
        9 => ollut ;
       10 => oltu ;
       11 => lienee
      } ;

    vforms2V : VForms -> V = \vh -> 
    let
      tulla = vh ! 0 ; 
      tulen = vh ! 1 ; 
      tulee = vh ! 2 ; 
      tulevat = vh ! 3 ;
      tulkaa = vh ! 4 ; 
      tullaan = vh ! 5 ; 
      tulin = vh ! 6 ; 
      tuli = vh ! 7 ;
      tulisi = vh ! 8 ;
      tullut = vh ! 9 ;
      tultu = vh ! 10 ;
      tullun = vh ! 11 ;
      tule_ = init tulen ;
      tuli_ = init tulin ;
      a = last tulkaa ;
      tulko = Predef.tk 2 tulkaa + (ifTok Str a "a" "o" "ö") ;
      tulkoo = tulko + last tulko ;
      tullee = Predef.tk 2 tullut + "ee" ;
      tulleen = (nForms2N (dRae tullut (tullee + "n"))).s ;
      tullu : Str = weakGrade tultu ;
      tullun  = (nForms2N (dUkko tultu (tullu + "n"))).s ; 
      tulema = Predef.tk 3 tulevat + "m" + a ;
      vat = "v" + a + "t"
    in
    {s = table {
      Inf Inf1 => tulla ;
      Presn Sg P1 => tule_ + "n" ;
      Presn Sg P2 => tule_ + "t" ;
      Presn Sg P3 => tulee ;
      Presn Pl P1 => tule_ + "mme" ;
      Presn Pl P2 => tule_ + "tte" ;
      Presn Pl P3 => tulevat ;
      Impf Sg P1  => tuli_ + "n" ;   --# notpresent
      Impf Sg P2  => tuli_ + "t" ;  --# notpresent
      Impf Sg P3  => tuli ;  --# notpresent
      Impf Pl P1  => tuli_ + "mme" ;  --# notpresent
      Impf Pl P2  => tuli_ + "tte" ;  --# notpresent
      Impf Pl P3  => tuli + vat ;  --# notpresent
      Condit Sg P1 => tulisi + "n" ;  --# notpresent
      Condit Sg P2 => tulisi + "t" ;  --# notpresent
      Condit Sg P3 => tulisi ;  --# notpresent
      Condit Pl P1 => tulisi + "mme" ;  --# notpresent
      Condit Pl P2 => tulisi + "tte" ;  --# notpresent
      Condit Pl P3 => tulisi + vat ;  --# notpresent
      Imper Sg   => tule_ ;
      Imper Pl   => tulkaa ;
      ImperP3 Sg => tulkoo + "n" ;
      ImperP3 Pl => tulkoo + "t" ;
      ImperP1Pl  => tulkaa + "mme" ;
      ImpNegPl   => tulko ;
      Pass True  => tullaan ;
      Pass False => Predef.tk 2 tullaan ;
      PastPartAct (AN n)  => tulleen ! n ;
      PastPartAct AAdv    => tullee + "sti" ;
      PastPartPass (AN n) => tullun ! n ;
      PastPartPass AAdv   => tullu + "sti" ;
      Inf Inf3Iness => tulema + "ss" + a ;
      Inf Inf3Elat  => tulema + "st" + a ;
      Inf Inf3Illat => tulema +  a   + "n" ;
      Inf Inf3Adess => tulema + "ll" + a ;
      Inf Inf3Abess => tulema + "tt" + a 
      } ;
    sc = NPCase Nom ;
    lock_V = <>
    } ;
}

