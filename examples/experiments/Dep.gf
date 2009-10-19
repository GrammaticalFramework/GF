abstract Dep = {

cat 
  S ; NP ; VP ; V2 ; CN ; AP ; Adv ; AdA ; Prep ;
fun
  Pred  : NP -> VP -> S ;
  Extr  : NP -> VP -> S ;
  Compl : NP -> V2 -> VP ;
  Mods  : AP -> CN -> NP ;
  MMods : AdA -> AP -> CN -> NP ;
  Prepm : Adv -> NP -> NP ;
  Prepp : NP -> Prep -> Adv ; 
   
  Economic, Financial, Little : AP ;
  News, Effect, Markets : CN ;
  Had : V2 ;
  On : Prep ;
  Very : AdA ;
}
