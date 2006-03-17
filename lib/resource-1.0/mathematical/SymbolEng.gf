concrete SymbolEng of Symbol = CatEng ** open Prelude, ResEng in {

lin
  SymbPN i = {s = \\c => i.s ; a = agrP3 Sg} ; --- c
  IntPN i  = {s = \\c => i.s ; a = agrP3 Sg} ; --- c
  FloatPN i = {s = \\c => i.s ; a = agrP3 Sg} ; --- c
  CNIntNP cn i = {
    s = \\c => (cn.s ! Sg ! Nom ++ i.s) ;
    a = agrP3 Sg
    } ;
  CNSymbNP det cn xs = {
    s = \\c => det.s ++ cn.s ! det.n ! c ++ xs.s ; 
    a = agrP3 det.n
    } ;

  SymbS sy = sy ; 

lincat 

  Symb, [Symb] = SS ;

lin

  MkSymb s = s ;

  BaseSymb = infixSS "and" ;
  ConsSymb = infixSS "," ;

}
