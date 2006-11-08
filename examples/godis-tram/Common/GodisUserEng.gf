--# -path=.:prelude:resource-1.0/abstract:resource-1.0/common:resource-1.0/english

concrete GodisUserEng of GodisUser = 
    GodisUserI with (GodisLang = GodisLangEng);


--     open Prelude, GodisLangEng in {

-- lincat 

-- S = SS;

-- Question = UserQuestion;
-- Action   = UserAction;
-- Answer   = UserAnswer;
-- ShortAns = UserShortAns;


-- lin

-- greet_S = ss ["hello"];
-- quit_S  = variants{ ss ["goodbye"]; ss ["quit"] };

-- no_S = ss ["no"];
-- yes_S = ss ["yes"];

-- request_S  x = x;
-- answer_S   x = x;
-- ask_S      x = x;
-- shortans_S x = x;

-- }
