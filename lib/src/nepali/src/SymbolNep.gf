--# -path=.:../abstract:../common

concrete SymbolNep of Symbol = CatNep ** open Prelude, ResNep in {

  flags coding = utf8;

 lin
  SymbPN i = {s = addGenitiveS i.s ; g = Masc ; t = NonLiving ; h = Pers3_L } ;
  
  IntPN i  = {s = addGenitiveS i.s ; g = Masc ; t = NonLiving ; h = Pers3_L } ;
  
  FloatPN i = {s = addGenitiveS i.s ; g = Masc ; t = NonLiving ; h = Pers3_L } ;
  
  NumPN i = {s = \\_ =>i.s ; g = Masc ; t = NonLiving ; h = Pers3_L } ;
  
  CNIntNP cn i = {
    s = \\c => cn.s ! Sg ! Nom ++ i.s ;
    a = agrP3 cn.g Sg ;
    t = NonLiving
    } ;
  
  CNSymbNP det cn xs = {
    s = \\c => det.s!Sg!Masc ++ cn.s ! det.n ! Nom ++  xs.s ; 
    a = agrP3 cn.g det.n ;
    t = NonLiving
    } ;
  
  CNNumNP cn i = {
    s = \\c => cn.s ! Sg ! Nom ++ i.s ;
    a = agrP3 cn.g Sg ;
    t = NonLiving
    } ;

  SymbS sy = sy ; 
  SymbNum sy = { s = sy.s ; n = Pl } ;
  SymbOrd sy = { s = sy.s ++ "wV" ; n = Pl} ;

lincat 

  Symb, [Symb] = SS ;

lin
  MkSymb s = s ;

  BaseSymb = infixSS "r" ;
  ConsSymb = infixSS "," ;

oper
    -- Note: this results in a space before 's, but there's
    -- not mauch we can do about that.
    addGenitiveS : Str -> Case => Str = \s -> 
      table {_ => Prelude.glue s "da" } ;
      
}
