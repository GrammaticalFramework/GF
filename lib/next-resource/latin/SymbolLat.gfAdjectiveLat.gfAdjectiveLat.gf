concrete SymbolLat of Symbol = CatLat ** open Prelude, ResLat in {

lin
  SymbPN i = {s = \\c => i.s ; g = Neutr} ; --- c
  IntPN i  = {s = \\c => i.s ; g = Neutr} ; --- c
  FloatPN i = {s = \\c => i.s ; g = Neutr} ; --- c
  NumPN i = {s = \\c => i.s ; g = Neutr} ; --- c
  CNIntNP cn i = {
    s = \\c => (cn.s ! Sg ! Nom ++ i.s) ;
    a = agrgP3 Sg cn.g
    } ;
  CNSymbNP det cn xs = {
    s = \\c => det.s ++ cn.s ! det.n ! c ++ xs.s ; 
    a = agrgP3 det.n cn.g
    } ;
  CNNumNP cn i = {
    s = \\c => (cn.s ! Sg ! Nom ++ i.s) ;
    a = agrgP3 Sg cn.g
    } ;

  SymbS sy = sy ; 

  SymbNum sy = {s = sy.s ; n = Pl ; hasCard = True} ;
  SymbOrd sy = {s = sy.s ++ "th"} ;

lincat 

  Symb, [Symb] = SS ;

lin

  MkSymb s = s ;

  BaseSymb = infixSS "and" ;
  ConsSymb = infixSS "," ;

}
