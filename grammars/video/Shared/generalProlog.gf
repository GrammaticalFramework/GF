-- File name Shared/general.Prolog.gf

concrete generalProlog of general = open prologResource in {

flags lexer=codelit ; unlexer=codelit ; startcat=DMoveList ;



lin 
dmoves dm = {s = appHakeOne dm.s };
dmoves1 dm = {s = dm.s };
dmoves2 dm dms = {s = dm.s ++ "," ++ dms.s };

lin
answer p = {s = app "answer" p.s}; 
--request a = {s = app "request" a.s };

--- Answers
propans  a = {s = a.s} ;
negpropans a = {s = app "not" a.s} ;
shortans a = {s = a.s} ; 
negShortAns a = {s = a.s} ; 

negprop n p = {s = n.s ++ p.s} ;  

pattern
neg = [] ;

pattern
----Short answers
yes = "yes" ;
no = "no";
english = "english" ; ----???
swedish = "swedish" ; ----???

lin
indShortAns a = {s = a.s} ;
not n = {s = n.s} ;

--avsluta??
--börja om
top = { s = "top"} ;
}