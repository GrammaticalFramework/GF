--# -path=.:../abstract:../common

concrete SymbolRus of Symbol = CatRus ** open Prelude, ResRus in {

{- TODO! -}
lin
  SymbPN i = {s = table  {_ => i.s} ; g = Neut; anim = Inanimate } ;
  IntPN i = {s = table  {_ => i.s} ; g = Neut; anim = Inanimate } ;
  FloatPN i = {s = table  {_ => i.s} ; g = Neut; anim = Inanimate } ;
  NumPN n = {s = table  {_ => n.s ! Neut ! Inanimate ! Nom} ; g = Neut; anim = Inanimate } ;

  CNIntNP cn i = {s = \\cas => cn.s ! NF Sg (extCase cas) nom ++ i.s;
		  n = Sg ; p = P3 ;
		  g = PGen cn.g ; anim = cn.anim ; pron = False } ;
  CNNumNP cn n = {s = \\cas => cn.s ! NF Sg (extCase cas) nom
		    ++ n.s ! cn.g ! cn. anim ! (extCase cas) ;
		  n = Sg ; p = P3 ;
		  g = PGen cn.g ; anim = cn.anim ; pron = False } ;

  CNSymbNP d cn ss = {s = \\cas => cn.s ! NF Sg (extCase cas) nom;
			n = Sg ; p = P3 ;
			g = PGen cn.g ; anim = cn.anim ; pron = False } ;

  SymbS sy = sy ; 

  SymbNum sy = { s = \\_,_,_=>sy.s; n=Pl ; size = plg };

  SymbOrd sy = { s = \\af => sy.s } ;

lincat 

  Symb, [Symb] = SS ;

lin
  MkSymb s = s ;

  BaseSymb = infixSS "и" ;
  ConsSymb = infixSS "," ;


}
