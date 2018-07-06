--# -path=.:../abstract:../common:../prelude

concrete SymbolEng of Symbol = CatEng ** open Prelude, ResEng in {

lin
  SymbPN i = {s = addGenitiveS i.s ; g = Neutr} ;
  IntPN i  = {s = addGenitiveS i.s ; g = Neutr} ;
  FloatPN i = {s = addGenitiveS i.s ; g = Neutr} ;
  NumPN i = {s = i.s ! False ; g = Neutr} ;
  CNIntNP cn i = {
    s = \\c => cn.s ! Sg ! Nom ++ (addGenitiveS i.s) ! npcase2case c ;
    a = agrgP3 Sg cn.g
    } ;
  CNSymbNP det cn xs = {
    s = \\c => det.s ++ cn.s ! det.n ! Nom ++ (addGenitiveS xs.s) ! npcase2case c ; 
    a = agrgP3 det.n cn.g
    } ;
  CNNumNP cn i = {
    s = \\c => cn.s ! Sg ! Nom ++ i.s ! False ! npcase2case c ;
    a = agrgP3 Sg cn.g
    } ;

  SymbS sy = sy ; 

  SymbNum sy = { s,sp = \\_ => addGenitiveS sy.s ; n = Pl ; hasCard = True } ;
  SymbOrd sy = { s    = \\c => sy.s ++ (regGenitiveS "th")!c} ;

lincat 

  Symb, [Symb] = SS ;

lin
  MkSymb s = s ;

  BaseSymb = infixSS "and" ;
  ConsSymb = infixSS frontComma ;

oper
    -- Note: this results in a space before 's, but there's
    -- not mauch we can do about that.
    addGenitiveS : Str -> Case => Str = \s -> 
      table { Gen => s ++ BIND ++ "'s"; _ => s } ;

}
