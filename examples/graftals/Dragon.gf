concrete Dragon of Graftal = {
lincat N = {x : Str; y : Str} ;
lincat S = {s : Str} ;

lin z = {x = ""; y = ""} ;
lin s x = {x = x.x ++ R ++ x.y ++ F ++ R; y = L ++ F ++ x.x ++ L ++ x.y} ;
lin c x = {s = "newpath 300 550 moveto" ++ F ++ x.x ++ "stroke showpage"} ;

oper F : Str = "0 5 rlineto" ;
oper L : Str = "+90 rotate" ;
oper R : Str = "-90 rotate" ;

}