--# -path=.:../abstract:../common

concrete SymbolChi of Symbol = CatChi ** open Prelude, ResChi in {

  flags coding = utf8;

 lin
  SymbPN i = i ;
  IntPN i  = i ;
  FloatPN i = i ;
  NumPN i = i ;
  CNIntNP cn i = {
    s = cn.s ++ i.s ;
    c = cn.c
    } ;
  CNSymbNP det cn xs = ss (det.s ++ cn.s ++ xs.s) ; ----  
  CNNumNP cn i = {
    s = cn.s ++ i.s ;
    c = cn.c
    } ;

  SymbS sy = sy ; 
  SymbNum sy = sy ;
  SymbOrd sy = sy ;

lincat 

  Symb, [Symb] = SS ;

lin
  MkSymb s = s ;

  BaseSymb = infixSS "" ;
  ConsSymb = infixSS "" ;

}
