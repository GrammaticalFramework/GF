concrete Sierpinski of Graftal = {
lincat N = {a : Str; b : Str} ;
lincat S = {s : Str} ;

lin z = {a = A; b = B} ;
lin s x = {a = x.b ++ R ++ x.a ++ R ++ x.b; b =x.a ++ L ++ x.b ++ L ++ x.a} ;
lin c x = {s = "newpath 300 550 moveto" ++ x.a ++ "stroke showpage"} ;

oper A : Str = "0 2 rlineto" ;
oper B : Str = "0 2 rlineto" ;
oper L : Str = "+60 rotate" ;
oper R : Str = "-60 rotate" ;

}