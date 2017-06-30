--# -path=.:../abstract:../common:../prelude

concrete SymbolFin of Symbol = CatFin ** open Prelude, NounFin, ResFin, MorphoFin, StemFin in {

lin
  SymbPN i = addStemEnding i.s ; 
  IntPN i = addStemEnding i.s ; 
  FloatPN i = addStemEnding i.s ;  
  NumPN i  = {s = \\c => i.s!Sg!Nom  ; h = Back} ; --- c

  CNIntNP cn i = {
    s = \\c => cn.s ! NCase Sg (npform2case Sg c) ++ i.s ;
    a = agrP3 Sg ;
    isPron = False ; isNeg = False
    } ;
  CNSymbNP det cn xs = let detcn = NounFin.DetCN det cn in {
    s = \\c => detcn.s ! c ++ xs.s ;
    a = detcn.a ;
    isPron = False ; isNeg = False
    } ;
  CNNumNP cn i = {
    s = \\c => cn.s ! NCase Sg (npform2case Sg c) ++ i.s ! Sg ! Nom ;
    a = agrP3 Sg ;
    isPron = False ; isNeg = False
    } ;

  SymbS sy = sy ;

  SymbNum n = {s = \\_,_ => n.s ; isNum = True ; n = Pl} ;
  SymbOrd n = {s = \\_ => glue n.s "."} ;

lincat 

  Symb, [Symb] = SS ;

lin

  MkSymb s = s ;

  BaseSymb = infixSS "ja" ;
  ConsSymb = infixSS "," ;

}

