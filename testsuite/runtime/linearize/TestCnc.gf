concrete TestCnc of Test = {

param Number = Pl | Sg;
lincat E = {s:Str; n : Number} ;
lindef E = \s -> {s=s; n=Sg} ;

lincat P = {s:Str} ;

lin Exist f = {s = "exists" ++ f.$0 ++ "such that" ++ f.s};
lin Even x  = {s = x.s ++ case x.n of {Sg => "is"; Pl => "are"} ++ "even"};

}