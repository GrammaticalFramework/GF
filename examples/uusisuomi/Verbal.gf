--# -path=.:alltenses

resource Verbal = ResFin ** 
  open MorphoFin,Declensions,Conjugations,CatFin,Prelude in {

  flags optimize=noexpand ;

  oper

  mkV = overload {
    mkV : (huutaa : Str) -> V = mk1V ;
    mkV : (huutaa,huusi : Str) -> V = mk2V ;
  } ;

  showV : V -> Utt = \v -> ss (
   v.s ! Inf Inf1 ++
   v.s ! Presn  Sg P1 ++
   v.s ! Presn  Sg P3 ++
   v.s ! Presn  Pl P3 ++
   v.s ! Imper Pl ++
   v.s ! Pass True ++
   v.s ! Impf   Sg P1 ++
   v.s ! Impf   Sg P3 ++
   v.s ! Condit Sg P3 ++
   v.s ! PastPartAct (AN (NCase Sg Nom)) ++
   v.s ! PastPartPass (AN (NCase Sg Nom))
   ) ** {lock_Utt = <>} ;

  mk1V : Str -> V = \s -> vforms2V (vForms1 s) ;
  mk2V : (_,_ : Str) -> V = \s,t -> vforms2V (vForms2 s t) ;

  vForms1 : Str -> VForms = \ottaa ->
    let
      a = last ottaa ;
      otta = init ottaa ; 
      ott  = init otta ;
      ots  = init ott + "s" ;
      ota  = weakGrade otta ;
      otin = init (Declensions.strongGrade (init ott)) + "elin" ;
      ot   = init ota ;
    in
    case ottaa of {
      _ + ("e" | "i" | "o" | "u" | "y" | "ö") + ("a" | "ä") =>
        cHukkua ottaa (ota + "n") ;
      _ + ("l" | "n" | "r") + ("taa" | "tää") => 
        cOttaa ottaa (ota + "n") (ots + "in") (ots + "i") ;
      ("" | C_) + ("a" | "e" | "i" | "o" | "u") + C_ + _ + 
        ("a" | "e" | "i" | "o" | "u") + _ + "aa" => 
        cOttaa ottaa (ota + "n") (ot + "in") (ott + "i") ;
      ("" | C_) + ("a" | "e" | "i") + _ + "aa" => 
        cOttaa ottaa (ota + "n") (ot + "oin") (ott + "oi") ;
      _ + ("aa" | "ää") => 
        cOttaa ottaa (ota + "n") (ot + "in") (ott + "i") ;
      _ + ("ella" | "ellä") => 
        cKuunnella ottaa otin ;
      _ + ("osta" | "östä") => 
        cJuosta ottaa (init ott + "ksen") ;
      _ + ("st" | "nn" | "ll" | "rr") + ("a" | "ä") => 
        cJuosta ottaa (ott + "en") ;
      _ + ("ita" | "itä") => 
        cHarkita ottaa ;
      _ + ("eta" | "etä" | "ota" | "ata" | "uta" | "ytä" | "ätä" | "ötä") => 
        cPudota ottaa (Declensions.strongGrade ott + "si") ;
      _ + ("da" | "dä") => 
        cJuoda ottaa ;
      _ => Predef.error (["expected infinitive, found"] ++ ottaa) 
    } ;   

  vForms2 : (_,_ : Str) -> VForms = \huutaa,huusi ->
    let
      huuda = weakGrade (init huutaa) ;
      huusin = weakGrade huusi + "n" ;
      autoin = weakGrade (init huusi) + "in" ;
    in 
    case <huutaa,huusi> of {
      <_ + ("taa" | "tää"), _ + ("oi" | "öi")> =>
        cOttaa huutaa (huuda + "n") autoin huusi ;
      <_ + ("aa" | "ää"), _ + "i"> =>
        cOttaa huutaa (huuda + "n") huusin huusi ;
      <_ + ("eta" | "etä"), _ + "eni"> =>
        cValjeta huutaa huusi ;
      <_ + ("sta" | "stä"), _ + "si"> =>
        vForms1 huutaa ; -- pestä, halkaista
      <_ + ("ta" | "tä"), _ + "si"> =>
        cPudota huutaa huusi ;
      <_ + ("lla" | "llä"), _ + "li"> =>
        cKuunnella huutaa huusin ;
      _ => vForms1 huutaa
      } ;

}
