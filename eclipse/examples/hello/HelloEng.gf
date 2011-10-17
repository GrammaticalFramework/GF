concrete HelloEng of HelloAbs = ResEng ** { 
 
	lincat
		Greeting, Farewell = {s : Str} ;
		Recipient = {s : Gender => Str} ;

	lin
 		Hello recip = {s = "hello" ++ recip.s ! Masc} ;
		Goodbye recip = {s = "goodbye" ++ recip.s ! Fem} ;
		
		World = {s = \\_ => "world"} ;
		Parent = { s = table {
			Masc => "dad" ; Fem => "mum"
		} } ;
		Friends = superate "friends" ;

	oper
		superate : Str -> Recipient = \s ->
			lin Recipient { s = \\_ => "super" ++ s } ;
 
} 
