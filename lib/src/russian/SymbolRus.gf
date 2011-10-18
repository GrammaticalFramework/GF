--# -path=.:../abstract:../common

concrete SymbolRus of Symbol = CatRus ** open Prelude, ResRus in {

{- TODO! -}
-- lin
--   SymbPN i = {s = i.s ; g = Neut } ;

lincat 

  Symb, [Symb] = SS ;

lin
  MkSymb s = s ;

--  BaseSymb = infixSS "and" ;
  ConsSymb = infixSS "," ;

}
