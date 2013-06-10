-- SymbolMlt.gf
--
-- Maltese GF Resource Grammar
-- John J. Camilleri 2011 -- 2013
-- Licensed under LGPL

--# -path=.:../abstract:../common

concrete SymbolMlt of Symbol = CatMlt ** open Prelude, ResMlt in {

  oper
    symAgr : Agr = { n = Sg ; p = P3 ; g = Masc } ;

  lin

    -- SymbPN -> PN
    -- x
    SymbPN i = {s = i.s ; a = symAgr} ;

    -- Int -> PN
    -- 27
    IntPN i  = {s = i.s ; a = symAgr} ;

    -- Float -> PN
    -- 3.14159
    FloatPN i = {s = i.s ; a = symAgr} ;

    -- Card -> PN ;
    NumPN i = {s = i.s ! NumNom ; a = symAgr} ;

    -- CN -> Int -> NP
    -- level 53 (covered by CNNumNP)
    CNIntNP cn i = {
      s = \\c => cn.s ! num2nounnum Sg ++ i.s;
      a = agrP3 Sg cn.g ;
      isPron = False ;
      isDefn = False ;
      } ;

    -- Det -> CN -> [Symb] -> NP
    -- (the) (2) numbers x and y
    CNSymbNP det cn xs = {
      s = \\c => det.s ! cn.g ++ cn.s ! (numform2nounnum det.n) ++ xs.s ;
      a = agrP3 (numform2num det.n) cn.g ;
      isPron = False ;
      isDefn = False ;
      } ;

    -- CN -> Card -> NP
    -- level five ; level 5
    CNNumNP cn i = {
      s = \\c => cn.s ! num2nounnum Sg ++ i.s ! NumNom ;
      a = agrP3 Sg cn.g ;
      isPron = False ;
      isDefn = False ;
      } ;

    -- Symb -> S
    -- A
    SymbS sy = sy ;

    -- Symb -> Card
    -- n
    SymbNum sy = {
      s = \\_ => sy.s ;
      n = NumX Pl ;
      } ;

    -- Symb -> Ord
    -- n'th
    SymbOrd sy = {
      s = \\c => sy.s ;
      } ;

  lincat
    Symb, [Symb] = SS ;

  lin
    -- String -> Symb
    MkSymb s = s ;

    BaseSymb = infixSS "u" ;
    ConsSymb = infixSS "," ;

}
