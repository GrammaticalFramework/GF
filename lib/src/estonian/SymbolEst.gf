--# -path=.:../abstract:../common:../prelude

concrete SymbolEst of Symbol = CatEst ** open Prelude, NounEst, ResEst in {

lin
  SymbPN i = {s = \\c => i.s} ; --- c
  IntPN i  = {s = \\c => i.s} ; --- c
  FloatPN i  = {s = \\c => i.s} ; --- c
  NumPN i  = {s = \\c => i.s!Sg!Nom } ; --- c

  CNIntNP cn i = {
    s = \\c => cn.s ! NCase Sg (npform2case Sg c) ++ i.s ;
    a = agrP3 Sg ;
    isPron = False
    } ;
  CNSymbNP det cn xs = let detcn = NounEst.DetCN det cn in {
    s = \\c => detcn.s ! c ++ xs.s ;
    a = detcn.a ;
    isPron = False
    } ;
  CNNumNP cn i = {
    s = \\c => cn.s ! NCase Sg (npform2case Sg c) ++ i.s ! Sg ! Nom ;
    a = agrP3 Sg ;
    isPron = False
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

