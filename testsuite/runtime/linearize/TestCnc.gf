concrete TestCnc of Test = {

param Number = Pl | Sg;
lincat E = {s:Str; n : Number} ;
lindef E = \s -> {s=s; n=Sg} ;

lincat S = {s:Str} ;

lin Exist f = {s = "exists" ++ f.$0 ++ "such that" ++ f.s};
lin Even x  = {s = x.s ++ case x.n of {Sg => "is"; Pl => "are"} ++ "even"};

lin a = {s = pre {"a"; "aa" / strs {"a"}}; n = Pl} ;
lin f  a = {s = a.s};
lin fa a = {s = a.s ++ "a"};
lin fb a = {s = a.s ++ "b"};

lin IsString  x = {s = x.s ++ "is string"} ;
lin IsInteger x = {s = x.s ++ "is integer"} ;
lin IsFloat   x = {s = x.s ++ "is float"} ;

}