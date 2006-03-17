incomplete concrete SymbolScand of Symbol = 
  CatScand ** open Prelude, ResScand, CommonScand in {

lin
  SymbPN i = {s = \\c => i.s ; g = Neutr} ; --- c
  IntPN i  = {s = \\c => i.s ; g = Neutr} ; --- c
  FloatPN i  = {s = \\c => i.s ; g = Neutr} ; --- c
  CNIntNP cn i = {
    s = \\c => (cn.s ! Sg ! DIndef ! Nom ++ i.s) ;
    a = agrP3 cn.g Sg
    } ;
  CNSymbNP det cn xs = let g = cn.g in {
    s = \\c => det.s ! cn.isMod ! g ++ cn.s ! det.n ! det.det ! caseNP c ++ xs.s ; 
    a = agrP3 g det.n
    } ;

  SymbS sy = {s = \\_ => sy.s} ;

lincat 

  Symb, [Symb] = SS ;

lin

  MkSymb s = s ;

  BaseSymb = infixSS conjAnd ;
  ConsSymb = infixSS "," ;

}
