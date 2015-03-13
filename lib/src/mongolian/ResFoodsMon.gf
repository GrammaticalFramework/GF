resource ResFoodsMon {
param
  Number = Sg | Pl ;
oper
  Noun : Type = {s : Number => Str} ;
  NounPhrase : Type = {s : Str ; n : Number} ;
  Adjective : Type = {s : Str} ;
  
  det : Number -> Str -> Noun -> NounPhrase = \n,d,cn -> {
        s = d ++ cn.s ! n ;
        n = n
        } ;
  regNoun : Str -> Noun = \x -> { 
   s = table { Sg => x ; 
               Pl => case x of {
			         _ + "c" => x + "нууд" ;
					 _       => x + "ууд"
			   }
             } 
  } ;
  mkAdj : Str -> Adjective = \adj -> {s = adj} ;
} ;
     
    
