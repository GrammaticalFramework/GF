concrete SymbolGre of Symbol = 
  CatGre ** open Prelude, CommonGre, ResGre in {

flags coding= utf8 ;


lin
  SymbPN i = {s = \\_,_ => i.s ; g = Masc };
  IntPN i  = {s = \\_,_ => i.s ; g = Masc } ;
  FloatPN i = {s = \\_,_ => i.s ; g = Masc } ;
  NumPN i  =  {s = \\_,_ => i.s ! Masc ! Nom ; g = Masc } ;


  CNIntNP cn i = heavyNP {
    s = \\c => prepCase c ++ cn.s ! Sg!c ++ i.s ;
    a = agrP3 cn.g Sg ;
    hasClit = False
    } ;
  CNSymbNP det cn xs = let g = cn.g in heavyNP {
    s = \\c => det.s ! g ! c ++ cn.s ! det.n ! c++ xs.s ; 
    a = agrP3 g det.n ;
    hasClit = False
    } ;
  CNNumNP cn i = heavyNP {
    s = \\c => artDef cn.g Sg c ++ cn.s ! Sg!c ++ i.s ! Masc!c ;
    a = agrP3 cn.g Sg ;
    hasClit = False
    } ;

  SymbS sy = {s = \\_ => sy.s} ;

  SymbNum n = {s = \\_,_ => n.s ; isNum = True ; n = Pl} ;
  SymbOrd n = {s = \\_,_,_,_ => n.s ++ "." ; adv=   table { Posit => " "  ; Compar =>  " " ; Superl =>  " "}} ; 

lincat 

  Symb, [Symb] = SS ;

lin

  MkSymb s = s ;

  BaseSymb = infixSS "και" ; 
  ConsSymb = infixSS "," ;

}