concrete generalSwe of general = {

flags lexer=codelit ; unlexer=codelit ; startcat=DMoveList ;


lincat DMove = {s : Str} ;

lin 
dmoves dm = {s = dm.s };
dmoves1 dm = {s = dm.s };
dmoves2 dm dms = {s = dm.s ++ "," ++ dms.s };
lin

answer a = {s = a.s } ;


--- Answers
propans  a = {s = a.s} ;
negpropans a = {s = a.s} ;
shortans a = {s = a.s} ; 
negShortAns a = {s = a.s} ; 

negprop n p = {s= n.s ++ p.s} ;  

pattern
neg = "inte" ;

pattern
--Short answers
swedish = "svenska" ;
english = "engelska" ; 
yes = (variants {"ja" ; "jajamensan" ; "japp"}) ;
no = "nej";

lin
indShortAns a = {s = a.s} ;
not n = {s = n.s} ;

--avsluta??
--börja om 
-- variants?  från början etc?
top = { s = ["börja om"]} ; 
}
