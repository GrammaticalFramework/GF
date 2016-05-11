--# -path=.:../abstract

concrete ExtensionsRus of Extensions = 
  CatRus ** open ResRus, (E = ExtraRus), Prelude, SyntaxRus in {

flags 
  coding = utf8 ;

lincat
  VPI = {s:Str} ;

}
