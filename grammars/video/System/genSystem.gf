-- general.Abs.gf

abstract genSystem = general ** {


cat
Empty ; -- whatever this is good for?
Question ;
YNQuestion ;
WHQuestion ;
AltQuestion ;
PropQ ;


fun
greet : DMove ;  -- "Welcome"
quit : DMove ;  -- "Goodbye"

ask : Question -> DMove ;

--- Language
change_language : Action ;
language_alt : Question ;

--- Actions
actionQ : WHQuestion ;

--- Questions 
whQuestion : WHQuestion  -> Question ; 
altQuestion : YNQuestion -> YNQuestion -> AltQuestion ;

--- Issue
issue : Question -> PropQ ; 

--- Lists
nil : Empty ;
}
