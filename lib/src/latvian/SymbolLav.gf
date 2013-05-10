--# -path=.:../abstract:../common:../prelude

concrete SymbolLav of Symbol = CatLav ** open
  Prelude,
  ResLav
  in {

flags
  coding = utf8 ;

lin

  SymbPN i = {s = \\_ => i.s ; gend = Masc ; num = Sg} ;
  IntPN i  = {s = \\_ => i.s ; gend = Masc ; num = Pl} ;
  FloatPN i = {s = \\_ => i.s ; gend = Masc ; num = Pl} ;
  NumPN i = {s = \\_ => i.s ! Masc ! Nom ; gend = Masc ; num = Pl} ;

  CNIntNP cn i = {
    s = \\_ => cn.s ! Indef ! Sg ! Nom ++ i.s ;
    agr = AgrP3 Sg cn.gend ;
    pol = Pos
  } ;

  CNSymbNP det cn xs = {
    s = \\_ => det.s ! cn.gend ! Nom ++ cn.s ! det.defin ! det.num ! Nom ++ xs.s ;
    agr = AgrP3 det.num cn.gend ;
    pol = Pos
  } ;

  CNNumNP cn i = {
    s = \\_ => cn.s ! Indef ! Sg ! Nom ++ i.s ! Masc ! Nom ;
    agr = AgrP3 Sg cn.gend ;
    pol = Pos
  } ;

  SymbS sy = sy ;

  SymbNum sy = { s = \\_,_ => sy.s ; num = Pl } ;
  SymbOrd sy = { s = \\_,_ => sy.s ++ "."} ;

lincat

  Symb, [Symb] = SS ;

lin

  MkSymb s = s ;

  BaseSymb = infixSS "un" ;
  ConsSymb = infixSS "," ;

}
