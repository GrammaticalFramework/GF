--# -path=.:prelude:present

concrete BaseEng of Base = open Syntax, (G = Grammar), Symbolic, LexBase in {

flags lexer=literals ; unlexer=text ;

lincat
  Question = Phr ;
  Answer = Phr ;
  S  = Cl ;
  NP = NP ;
  PN = NP ;
  CN = CN ;
  AP = AP ;
  A2 = A2 ;
  Conj = Conj ;
  ListPN = ListNP ;
lin 
  PredAP  = mkCl ;

  ComplA2 = mkAP ;

  ModCN   = mkCN ;

---  ConjS  = mkS ;
  ConjAP = mkAP ;
  ConjNP = mkNP ;

  UsePN p = p ;
  Every = mkNP every_Det ;
  Some  = mkNP someSg_Det ;
---  None  = mkNP noSg_Det ; ---

  And = and_Conj ;
  Or  = or_Conj ;

  UseInt = symb ;

  Number = mkCN number_N ;

  Even   = mkAP even_A ;
  Odd    = mkAP odd_A ;
  Prime  = mkAP prime_A ;
  Equal  = mkA2 equal_A2 ;
  Greater = mkA2 greater_A2 ;
  Smaller = mkA2 smaller_A2 ;
  Divisible = mkA2 divisible_A2 ;
 
  Sum pns = mkNP defSgDet (mkCN sum_N2 (mkNP and_Conj pns)) ;
---  Product = prefixSS ["the product of"] ;
---  GCD     = prefixSS ["the greatest common divisor of"] ;

---  WhatIs = prefixSS ["what is"] ;
---  WhichAre cn ap = ss ("which" ++ cn.s ++ "is" ++ ap.s) ; ---- are
  QuestS s = mkPhr (mkQCl s) ;

  Yes = yes_Phr ;
  No = no_Phr ;

  Value np = mkPhr (mkUtt np) ;
  Many list = list ;

  BasePN = G.BaseNP ;
  ConsPN = G.ConsNP ;
  
}
