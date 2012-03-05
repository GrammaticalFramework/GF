--# -path=.:../abstract:../common

concrete SymbolPes of Symbol = CatPes ** open Prelude, ResPes in {

  flags coding = utf8;

 lin
-- SymbPN i = {s = \\_ => i.s ; g = Masc} ;
  SymbPN i = {s = i.s ; animacy = Inanimate} ; -- "از" is removed for Phrasebook
  IntPN i  = {s = i.s ++ "از" ; animacy = Inanimate} ;
  FloatPN i = {s = i.s ++ "از" ; animacy = Inanimate} ;
  NumPN i = {s = i.s ; animacy = Inanimate} ;
  CNIntNP cn i = {
    s = \\ez => cn.s ! aEzafa ! Sg  ++ i.s ;
    a = agrPesP3 Sg ;
    animacy = cn.animacy
    } ;
  CNSymbNP det cn xs = {
    s = \\ez => det.s ++ cn.s ! aEzafa ! det.n   ++  xs.s ; 
    a = agrPesP3 det.n ;
    animacy = cn.animacy
    } ;
  CNNumNP cn i = {
    s = \\ez => cn.s ! aEzafa ! Sg   ++ i.s ;
    a = agrPesP3 Sg ;
    animacy = cn.animacy
    } ;

  SymbS sy = sy ; 
  SymbNum sy = { s = sy.s ; n = Pl } ;
  SymbOrd sy = { s = sy.s ++ "wN" ; n = Pl} ;

lincat 

  Symb, [Symb] = SS ;

lin
  MkSymb s = s ;

  BaseSymb = infixSS "تE" ;
  ConsSymb = infixSS "" ;

--oper
    -- Note: this results in a space before 's, but there's
    -- not mauch we can do about that.
--    addGenitiveS : Str ;
--    addGenitiveS s =
--     s ++ "از" ;


}
