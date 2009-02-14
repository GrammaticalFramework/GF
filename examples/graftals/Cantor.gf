concrete Cantor of Graftal = {
lincat N = {f : Str; g : Str} ;
lincat S = {s : Str} ;

lin z = {f = F; g = G} ;
lin s x = {f = x.f ++ x.g ++ x.f; g = x.g ++ x.g ++ x.g} ;
lin c x = {s = "newpath 10 550 moveto" ++ x.f ++ "stroke showpage"} ;

oper F : Str = "1 0 rlineto" ;
oper G : Str = "1 0 rmoveto" ;
}