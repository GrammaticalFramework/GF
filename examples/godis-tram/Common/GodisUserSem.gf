--# -path=.:prelude

concrete GodisUserSem of GodisUser = 
    open Prolog, GodisSystemSem in {

lincat 

S,
Question,
Answer,
ShortAns,
Action,
Proposition    = PStr;

lin

greet_S = pList1 (pp0 "greet");
quit_S  = pList1 (pp0 "quit");

no_S    = pm1 (answer (pp0 "no"));
yes_S   = pm1 (answer (pp0 "yes"));

answer_S   = pBrackets;
ask_S      = pBrackets;
request_S  = pBrackets;
shortans_S = pBrackets;

not_prop_S = \x -> pBrackets (pp1 "not" x);
not_shortans_S = \x -> pBrackets (pp1 "not" x);

request_request_S = pList2;

}
