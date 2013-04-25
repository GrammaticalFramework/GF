resource StressGre =  {

flags coding=utf8 ;

	

oper 

mkN : Str -> Str * Str = \s -> case s of {
	c + v@(#stressedVowel) + x@(? + ?) + "α" => <s,c + unstress v + x + "ών"> ;
	_ => <s,s>
} ;




stressedVowel : pattern Str = #("ά" | "ό" | "ί"| "έ" );

unstress : Str -> Str = \v -> case v of {
    "ά"	=> "α" ;
    "ό"	=> "ο" ;
    "ί"	=> "ι" ;
    "έ"	=> "ε" ;
    _ => v
} ;

stress : Str -> Str = \v -> case v of {
    "α"	=> "ά" ;
    "ο"	=> "ό" ;
    "ι"	=> "ί" ;
    "ε"	=> "έ" ;
    _ => v
} ;





}