resource ResProlog = {
oper
--with single quotes
--app2 : Str -> Str -> Str -> Str = \pred -> \argH -> \argM -> pred ++ "(" ++ "'" ++ argH ++ ":" ++ argM ++ "'" ++ ")" ;
--without single quotes
--app2 : Str -> Str -> Str -> Str = \pred -> \argH -> \argM -> pred ++ "(" ++ argH ++ ":" ++ argM ++ ")" ;

app3 : Str -> Str -> Str = \argH -> \argM -> argH ++ ":" ++ argM ;

oper
app : Str -> Str -> Str = 
		\pred -> \arg -> 
		pred ++ "(" ++ arg ++ ")" ;

appHakeOne : Str -> Str = 
		\arg -> 
		"["++ arg ++ "]" ;

appCurlyOne : Str -> Str = 
		\arg -> 
		"{"++ arg ++"}" ;

}

