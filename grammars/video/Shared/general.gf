abstract general = {

cat
Action ; 
DMove ; 
DMoves ; 
DMoveList ; 

Ind ; 
Prop ; 

fun
--- DMove
dmoves : DMoves -> DMoveList ; 
dmoves1 : DMove -> DMoves ; 
dmoves2 : DMove -> DMoves -> DMove ;

-- File name User/general.Abs.gf

cat
Answer ;
ShortAns ;
NegShortAns ;
NegProp ;
Neg ;

fun
answer : Answer -> DMove ;
--request :  Action -> DMove ;

--- Answers
propans : Prop -> Answer ; 
negpropans : NegProp -> Answer ; 
shortans : ShortAns -> Answer ; 
negShortAns : NegShortAns -> Answer ; 

negprop : Neg -> Prop -> NegProp ;
neg : Neg ;

--Short answers
swedish : ShortAns ; 
english : ShortAns ; 
yes : ShortAns ; 
no : NegShortAns ;
indShortAns : Ind -> ShortAns ; 
not : ShortAns -> NegShortAns ;

--avsluta??
--börja om
top : Action ;
}
