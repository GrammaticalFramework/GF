concrete SymbolFin of Symbol = CatFin ** open Prelude, ResFin in {

lin
  SymbPN i = {s = \\c => i.s} ; --- c
  IntPN i  = {s = \\c => i.s} ; --- c
{-
  CNIntNP cn i = {
    s = \\c => (cn.s ! Sg ! DIndef ! Nom ++ i.s) ;
    a = agrP3 cn.g Sg
    } ;
  CNSymbNP det cn xs = let g = cn.g in {
    s = \\c => det.s ! cn.isMod ! g ++ cn.s ! det.n ! det.det ! caseNP c ++ xs.s ; 
    a = agrP3 g det.n
    } ;
-}
lincat 

  Symb, SymbList = SS ;

lin

  MkSymb s = s ;

  BaseSymb = infixSS "ja" ;
  ConsSymb = infixSS "," ;

}

