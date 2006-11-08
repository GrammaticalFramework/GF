--# -path=.:prelude

abstract GodisUser = {

cat 

S;
Question;
Action;
Answer;
ShortAns;
Proposition;


fun

greet_S,
quit_S     : S;

no_S,
yes_S      : Answer;

request_S      : Action -> S;
answer_S       : Answer -> S;
ask_S          : Question -> S;

shortans_S,
not_shortans_S : ShortAns -> S; 
not_prop_S     : Proposition -> S;

request_request_S : Action -> Action -> S;

}
