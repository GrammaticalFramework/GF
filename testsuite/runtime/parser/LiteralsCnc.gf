concrete LiteralsCnc of Literals = {

lincat S = Str ;

lin IsString  x = x.s ++ "is string" ;
lin IsInteger x = x.s ++ "is integer" ;
lin IsFloat   x = x.s ++ "is float" ;
lin IsEq      x = x.s ++ "=" ++ x.s ;

}