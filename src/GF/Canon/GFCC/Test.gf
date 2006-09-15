-- to test GFCC compilation

cat S ; NP ; N ; VP ;

fun Pred : NP -> VP -> S ;
fun Pred2 : NP -> VP -> NP -> S ;
fun Det, Dets : N -> NP ;

fun Mina, Te : NP ;
fun Raha, Paska, Pallo : N ;
fun Puhua, Munia, Sanoa : VP ;


param Person = P1 | P2 | P3 ;
param Number = Sg | Pl ;
param Case = Nom | Part ;

param NForm = NF Number Case ;
param VForm = VF Number Person ;

--lincat NP = {s : Case => Str ; n : Number ; p : Person} ;
lincat NP = {s : Case => Str ; a : {n : Number ; p : Person}} ;
lincat N  = Noun ; 
lincat VP = Verb ; 

oper Noun = {s : NForm => Str} ;
oper Verb = {s : VForm => Str} ;

--lin Pred np vp = {s = np.s ! Nom ++ vp.s ! VF np.n np.p} ;
lin Pred np vp = {s = np.s ! Nom ++ vp.s ! VF np.a.n np.a.p} ;
lin Pred2 np vp ob = {s = np.s ! Nom ++ vp.s ! VF np.a.n np.a.p ++ ob.s ! Part} ;
--lin Det  no = {s = \\c => no.s ! NF Sg c ; n = Sg ; p = P3} ;
--lin Dets no = {s = \\c => no.s ! NF Pl c ; n = Pl ; p = P3} ;
lin Det  no = {s = \\c => no.s ! NF Sg c ; a = {n = Sg ; p = P3}} ;
lin Dets no = {s = \\c => no.s ! NF Pl c ; a = {n = Pl ; p = P3}} ;

--lin Mina = {s = table Case ["minä" ; "minua"] ; n = Sg ; p = P1} ;
--lin Te = {s = table Case ["te" ; "teitä"] ; n = Pl ; p = P2} ;
lin Mina = {s = table Case ["minä" ; "minua"] ; a = {n = Sg ; p = P1}} ;
lin Te = {s = table Case ["te" ; "teitä"] ; a = {n = Pl ; p = P2}} ;

lin Raha = mkN "raha" ;
lin Paska = mkN "paska" ;
lin Pallo = mkN "pallo" ;
lin Puhua = mkV "puhu" ;
lin Munia = mkV "muni" ;
lin Sanoa = mkV "sano" ;

oper mkN : Str -> Noun = \raha -> {
  s = table {
    NF Sg Nom  => raha ;
    NF Sg Part => raha + "a" ;
    NF Pl Nom  => raha + "t" ;
    NF Pl Part => Predef.tk 1 raha + "oja"
    } 
  } ;

oper mkV : Str -> Verb = \puhu -> {
  s = table {
    VF Sg P1 => puhu + "n" ;
    VF Sg P2 => puhu + "t" ;
    VF Sg P3 => puhu + Predef.dp 1 puhu ;
    VF Pl P1 => puhu + "mme" ;
    VF Pl P2 => puhu + "tte" ;
    VF Pl P3 => puhu + "vat"
    } 
  } ;

