incomplete concrete BaseI of Base = 
  open Syntax, (G = Grammar), Symbolic, LexBase in {

flags lexer=literals ; unlexer=text ;

lincat
  Question = G.Phr ;
  Answer = G.Phr ;
  S  = G.Cl ;
  NP = G.NP ;
  PN = G.NP ;
  CN = G.CN ;
  AP = G.AP ;
  A2 = G.A2 ;
  Conj = G.Conj ;
  ListPN = G.ListNP ;

lin 
  PredAP  = mkCl ;

  ComplA2 = mkAP ;

  ModCN   = mkCN ;

  ConjAP = mkAP ;
  ConjNP = mkNP ;

  UsePN p = p ;
  Every = mkNP every_Det ;
  Some  = mkNP someSg_Det ;

  And = and_Conj ;
  Or  = or_Conj ;

  UseInt i = symb (i ** {lock_Int = <>}) ; ---- terrible to need this

  Number = mkCN number_N ;

  Even = mkAP even_A ;
  Odd  = mkAP odd_A ;
  Prime = mkAP prime_A ;
  Equal = equal_A2 ;
  Greater = greater_A2 ;
  Smaller = smaller_A2 ;
  Divisible = divisible_A2 ;
 
  Sum     = prefix sum_N2 ;
  Product = prefix product_N2 ;
  GCD nps = mkNP (mkDet DefArt (mkOrd great_A)) 
              (mkCN common_A (mkCN divisor_N2 (mkNP and_Conj nps))) ;

  WhatIs np = mkPhr (mkQS (mkQCl whatSg_IP (mkVP np))) ;
  WhichAre cn ap = mkPhr (mkQS (mkQCl (mkIP which_IQuant cn) (mkVP ap))) ;
  QuestS s = mkPhr (mkQS (mkQCl s)) ;

  Yes = mkPhr yes_Utt ;
  No = mkPhr no_Utt ;

  Value np = mkPhr (mkUtt np) ;
  Many list = mkNP and_Conj list ;
  None  = none_NP ;

  BasePN = G.BaseNP ;
  ConsPN = G.ConsNP ;

oper
  prefix : G.N2 -> G.ListNP -> G.NP = \n2,nps -> 
    mkNP DefArt (mkCN n2 (mkNP and_Conj nps)) ;
  
}
