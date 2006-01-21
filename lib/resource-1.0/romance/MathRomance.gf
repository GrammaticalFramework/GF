incomplete concrete MathRomance of Math = 
  CatRomance ** open Prelude, CommonRomance, ResRomance in {

lin
  SymbPN i = {s = i.s ; g = Masc} ;
  IntPN i  = {s = i.s ; g = Masc} ;

{-
  CNIntNP cn i = {
    s = \\c => (cn.s ! Sg ! DIndef ! Nom ++ i.s) ;
    a = agrP3 cn.g Sg
    } ;
  CNSymbNP det cn xs = let g = cn.g in {
    s = \\c => det.s ! g ++ cn.s ! det.n ! det.det ! caseNP c ++ xs.s ; 
    a = agrP3 g det.n
    } ;
-}

lincat 

  Symb, SymbList = SS ;

lin

  MkSymb s = s ;

  BaseSymb = infixSS "et" ; ----
  ConsSymb = infixSS "," ;

}
