concrete Koch of Graftal = {
lincat N = {f : Str} ;
lincat S = {s : Str} ;

lin z = {f = F} ;
lin s x = {f = x.f ++ L ++ x.f ++ R ++ x.f ++ R ++ x.f ++ L ++ x.f} ;
lin c x = {s = "newpath 10 550 moveto" ++ x.f ++ "stroke showpage"} ;

oper F : Str = "2 0 rlineto" ;
oper L : Str = "+90 rotate" ;
oper R : Str = "-90 rotate" ;
}