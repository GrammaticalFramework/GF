--# -path=.:../abstract:../common:../prelude

concrete SymbolDut of Symbol = CatDut ** open Prelude, ResDut in 
{


lin
  SymbPN i = {s = \\c => i.s ; g = Neutr} ; --- c
  IntPN i  = {s = \\c => i.s ; g = Neutr} ; --- c
  FloatPN i  = {s = \\c => i.s ; g = Neutr} ; --- c
  NumPN i  = {s = \\_ => i.s ! Neutr ! Nom ; g = Neutr} ; --- c

  CNIntNP cn i = noMerge ** {
    s = \\c => cn.s ! Weak ! NF Sg Nom ++ i.s ;
    a = agrP3 Sg ;
    isPron = False
    } ;
  CNSymbNP det cn xs = let g = cn.g in noMerge ** {
    s = \\c => det.s ! g ++ cn.s ! det.a ! NF det.n Nom ++ xs.s ; 
    a = agrP3 det.n ;
    isPron = False
    } ;
  CNNumNP cn i = noMerge ** {
    s = \\c => artDef Sg cn.g ++ cn.s ! Weak ! NF Sg Nom ++ i.s ! Neutr ! Nom ;
    a = agrP3 Sg ;
    isPron = False
    } ;

  SymbS sy = {s = \\_ => sy.s} ;

  SymbNum n = {s = \\_,_ => n.s ; n = Pl ; isNum = True} ;
  SymbOrd n = {s = \\_ => glue n.s "."} ;


lincat 

  Symb, [Symb] = SS ;

lin

  MkSymb s = s ;

  BaseSymb = infixSS "en" ;
  ConsSymb = infixSS bindComma ;

oper
  artDef : Number -> Gender -> Str = \n,g -> case <n,g> of {<Sg,Neutr> => "het" ; _ => "de"} ;

}
