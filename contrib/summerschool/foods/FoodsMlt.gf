-- (c) 2011 John Camilleri under LGPL

concrete FoodsMlt of Foods = open Prelude, ResMlt in {
	flags coding=utf8 ;

	lincat
		Comment = SS ; 
		Quality = {s : Gender => Number => Str} ; 
		Kind = {s : Number => Str ; g : Gender} ; 
		Item = {s : Str ; g : Gender ; n : Number} ; 

	lin
		Pred item quality = ss (item.s ++ copula item.n item.g ++ quality.s ! item.g ! item.n) ;
		
		This kind = det Sg "dan" "din" kind ;
		That kind = det Sg "dak" "dik" kind ;
		These kind = det Pl "dawn" "" kind ;
		Those kind = det Pl "dawk" "" kind ;
		
		Mod quality kind = {
			s = \\n => kind.s ! n ++ quality.s ! kind.g ! n ;
			g = kind.g
		} ;
		
		Wine = noun "inbid" "inbejjed" Masc ;
		Cheese = noun "ġobon" "ġobniet" Masc ;
		Fish = noun "ħuta" "ħut" Fem ;
		Pizza = noun "pizza" "pizzez" Fem ;
		
		Very qual = {s = \\g,n => qual.s ! g ! n ++ "ħafna"} ;
		
		Warm = adjective "sħun" "sħuna" "sħan" ;
		Expensive = adjective "għali" "għalja" "għaljin" ;
		Delicious = adjective "tajjeb" "tajba" "tajbin" ;
		Boring = uniAdj "tad-dwejjaq" ;
		Fresh = regAdj "frisk" ;
		Italian = regAdj "Taljan" ;
}
