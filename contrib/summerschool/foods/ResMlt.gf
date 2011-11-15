-- (c) 2011 John Camilleri under LGPL

resource ResMlt = open Prelude in {
	flags coding=utf8 ;

	param
		Number = Sg | Pl ;
		Gender = Masc | Fem ;

	oper
		--Create an adjective (full function)
		--Params: Sing Masc, Sing Fem, Plural
		adjective : (_,_,_ : Str) -> {s : Gender => Number => Str} = \iswed,sewda,suwed -> {
			s = table {
				Masc => table {
					Sg => iswed ;
					Pl => suwed
				} ; 
				Fem => table {
					Sg => sewda ;
					Pl => suwed
				}
			}
		} ;

		--Create a regular adjective
		--Param: Sing Masc
		regAdj : Str -> {s : Gender => Number => Str} = \frisk ->
			adjective frisk (frisk + "a") (frisk + "i") ;

		--Create a "uni-adjective" eg tal-buzz
		--Param: Sing Masc
		uniAdj : Str -> {s : Gender => Number => Str} = \uni ->
			adjective uni uni uni ;
			
		--Create a noun
		--Params: Singular, Plural, Gender (inherent)
		noun : Str -> Str -> Gender -> {s : Number => Str ; g : Gender} = \ktieb,kotba,g -> {
			s = table {
				Sg => ktieb ;
				Pl => kotba
			} ;
			g = g
		} ;

		--Copula is a linking verb
		--Params: Number, Gender
		copula : Number -> Gender -> Str = \n,g -> case n of {
			Sg => case g of { Masc => "huwa" ; Fem => "hija" } ;
			Pl => "huma"
		} ;

		--Create an article, taking into account first letter of next word
		article = pre {
			"a"|"e"|"i"|"o"|"u" => "l-" ;
			--cons@("ċ"|"d"|"n"|"r"|"s"|"t"|"x"|"ż") => "i" + cons + "-" ;
			_ => "il-"
		} ;
		
		--Create a determinant
		--Params: Sg/Pl, Masc, Fem
		det : Number -> Str -> Str -> {s : Number => Str ; g : Gender} -> {s : Str ; g : Gender ; n : Number} = \n,m,f,cn -> {
			s = case n of {
				Sg => case cn.g of {Masc => m ; Fem => f}; --string
				Pl => m --default to masc
			} ++ article ++ cn.s ! n ;
			g = cn.g ; --gender
			n = n --number
		} ;

}
