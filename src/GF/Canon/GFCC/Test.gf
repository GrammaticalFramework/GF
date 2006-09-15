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

lincat NP = {s : Case => Str ; a : {n : Number ; p : Person}} ;
lincat N  = Noun ; 
lincat VP = Verb ; 

oper Noun = {s : {n : Number ; c : Case} => Str} ;
oper Verb = {s : {n : Number ; p : Person} => Str} ;

lin Pred np vp = {s = np.s ! Nom ++ vp.s ! np.a} ;
lin Pred2 np vp ob = {s = np.s ! Nom ++ vp.s ! np.a ++ ob.s ! Part} ;
lin Det  no = {s = \\c => no.s ! {n = Sg ; c = c} ; a = {n = Sg ; p = P3}} ;
lin Dets no = {s = \\c => no.s ! {n = Pl ; c = c} ; a = {n = Pl ; p = P3}} ;

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
    {n = Sg ; c = Nom} => raha ;
    {n = Sg ; c = Part} => raha + "a" ;
    {n = Pl ; c = Nom} => raha + "t" ;
    {n = Pl ; c = Part} => Predef.tk 1 raha + "oja"
    } 
  } ;

oper mkV : Str -> Verb = \puhu -> {
  s = table {
    {n = Sg ; p = P1} => puhu + "n" ;
    {n = Sg ; p = P2} => puhu + "t" ;
    {n = Sg ; p = P3} => puhu + Predef.dp 1 puhu ;
    {n = Pl ; p = P1} => puhu + "mme" ;
    {n = Pl ; p = P2} => puhu + "tte" ;
    {n = Pl ; p = P3} => puhu + "vat"
    } 
  } ;

