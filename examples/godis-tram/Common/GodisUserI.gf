--# -path=.:prelude:resource-1.0/abstract:resource-1.0/common

incomplete concrete GodisUserI of GodisUser = 
    open Prelude, GodisLang in {

lincat 

S = SS;

Question    = UserQuestion;
Action      = UserAction;
Answer      = UserAnswer;
ShortAns    = UserShortAns;
Proposition = UserProposition;

lin

greet_S = {s = "hei"} ;
quit_S  = userQuit;

no_S    = userNo;
yes_S   = userYes;

request_S  x = x;
answer_S   x = x;
ask_S      x = x;
shortans_S x = x;

not_prop_S     = not_user_prop;
not_shortans_S = not_user_short;

request_request_S = userCoordinate;

}
