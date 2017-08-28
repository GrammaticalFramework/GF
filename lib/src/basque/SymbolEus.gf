--# -path=.:../abstract:../common:../prelude

concrete SymbolEus of Symbol = CatEus ** open Prelude, ParadigmsEus, ResEus, (NE=NounEus) in {

lin

  --  : Symb -> PN ;                -- x
  SymbPN i = symbPN i.s ; 

  ---- : Int -> PN ;                 -- 27
  IntPN i  = symbPN i.s ;

  ---- : Float -> PN ;               -- 3.14159
  FloatPN i = symbPN i.s ;

  ---- : Card -> PN ;                -- twelve [as proper name]
  NumPN i = symbPN i.s ;

oper
  symbPN : Str -> PN = \symb -> lin PN 
    { s = symb ;
      ph = FinalCons ;
      anim = Inan ;
      nbr = Pl } ;

lin
--  CNIntNP cn i = {} ;

  -- : Det -> CN -> [Symb] -> NP ; -- (the) (2) numbers x and y
  CNSymbNP det cn xs = 
    let cnSymb = cn ** { comp = cn.comp ++ xs.s } 
     in NE.DetCN det cnSymb ;

  -- : CN -> Card -> NP ;          -- level five ; level 5
  CNNumNP cn i = NE.MassNP (cn ** { comp = cn.comp ++ i.s }) ;

  -- : Symb -> S ;  
  SymbS sy = {s = { beforeAux = sy.s ; 
                    aux = {indep = "da" ; stem = "de" } ;
                    afterAux = [] } } ;
  -- : Symb -> Card ;  
  SymbNum sy = { s = sy.s ; n = Pl } ;

  -- : Symb -> Ord ;  
  SymbOrd sy = { s = sy.s ++ BIND ++ "garren" ; n = Pl } ;

lincat 

  Symb, [Symb] = SS ;

lin
  MkSymb s = s ;

  BaseSymb = infixSS "eta" ;
  ConsSymb = infixSS "," ;



}
