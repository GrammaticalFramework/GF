concrete TestCnc of Test = {

lincat E,P = {s:Str} ;

lin Exist f = {s = "exists" ++ f.$0 ++ "such that" ++ f.s};
lin Even x  = {s = x.s ++ "is even"};
}