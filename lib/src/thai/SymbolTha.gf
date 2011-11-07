--# -path=.:../abstract:../common

concrete SymbolTha of Symbol = CatTha ** open Prelude, ResTha in {

  flags coding = utf8;

 lin
  SymbPN i = i ;
  IntPN i  = i ;
  FloatPN i = i ;
  NumPN i = i ;
  CNIntNP cn i = {
    s = thbind cn.s ++ i.s ;
    c = cn.c
    } ;
  CNSymbNP det cn xs = ss (thbind det.s1 cn.s xs.s) ; ----  
  CNNumNP cn i = {
    s = thbind cn.s ++ i.s ;
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
