incomplete concrete SymbolRomance of Symbol = 
  CatRomance ** open Prelude, CommonRomance, ResRomance in {

lin
  SymbPN i = {s = i.s ; g = Masc} ;
  IntPN i  = {s = i.s ; g = Masc} ;
  FloatPN i  = {s = i.s ; g = Masc} ;

  CNIntNP cn i = {
    s = \\c => cn.s ! Sg ++ i.s ;
    a = agrP3 cn.g Sg ;
    hasClit = False
    } ;
  CNSymbNP det cn xs = let g = cn.g in {
    s = \\c => det.s ! g ! npform2case c ++ cn.s ! det.n ++ xs.s ; 
    a = agrP3 g det.n ;
    hasClit = False
    } ;
  CNNumNP cn i = {
    s = \\c => cn.s ! Sg ++ i.s ! Masc ;
    a = agrP3 cn.g Sg ;
    hasClit = False
    } ;
  SymbS sy = {s = \\_ => sy.s} ;

  SymbNum n = {s = \\_ => n.s ; isNum = True} ;
  SymbOrd n = {s = \\_ => n.s ++ "."} ; ---

lincat 

  Symb, [Symb] = SS ;

lin

  MkSymb s = s ;

  BaseSymb = infixSS "et" ; ----
  ConsSymb = infixSS "," ;

}
