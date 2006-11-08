--# -path=.:prelude:resource-1.0/abstract:resource-1.0/common:resource-1.0/english

instance GodisLangEng of GodisLang = 
    open Prelude, PredefCnc, GrammarEng, ParadigmsEng, (ResEng=ResEng), ParamX, ConstructX, 
         (Lex=LangEng), (Irreg=IrregEng) in {

oper

----------------------------------------------------------------------
-- focus

embed_NP a b x = {s = \\c => a ++ (x.s ! c) ++ b; a = x.a; lock_NP = <>};


----------------------------------------------------------------------
-- user utterances

userGreet = ss ["hello"];
userQuit  = ss (variants{ ["goodbye"]; ["quit"] });
userNo    = ss ["no"];
userYes   = ss ["yes"];
userOkay  = variants { ss ["okay"]; ss ["ok"] };

userCoordinate x y = ss (x.s ++ "and" ++ optStr "then" ++ y.s);

thank_you_Str = variants {["thank you"]; "great"; ["thanks"]};
i_want_to_Str = variants{"i" ++ variants{"want"; ["would like"]} ++ "to";
                         ["can you"]};
please_Str    = "please";
this_that_Str = variants{"this"; "that"};

not_user_prop  p = ss ( not_Predet.s ++ p.s );
not_user_short a = ss ( not_Predet.s ++ a.s );

----------------------------------------------------------------------
-- system utterances

hello           = mkUtt ["The mp3 player is ready to use"];
goodbye         = mkUtt ["Goodbye"];
yes             = mkUtt ["Yes"];
no              = mkUtt ["No"];

is_that_correct_Post   = mkUtt [", is that correct"];
returning_to_Pre       = mkUtt ["Returning to"];
returning_to_act_Pre   = mkUtt ["Returning to"];
returning_to_issue_Pre = mkUtt ["Returning to the issue of"];
what_did_you_say       = mkUtt ["What did you say"];
what_do_you_mean       = mkUtt ["What do you mean"];
i_dont_understand      = mkUtt ["Sorry, I don't quite understand"];
cant_answer_que_Pre    = mkUtt ["Sorry, I can't answer questions about"];
not_valid_Post         = mkUtt ["is not a valid option"];

icm_acc_pos     = variants { mkUtt ["Okay"]; mkUtt thank_you_Str }; 
icm_con_neg     = mkUtt ["Hello?"];
icm_reraise     = mkUtt ["So, "];
icm_loadplan    = mkUtt ["Let's see"];
icm_accommodate = mkUtt ["Alright "];

icm_per_pos   x = mkUtt (["I thought you said"] ++ x.s);


----------------------------------------------------------------------
-- noun phrases

sing_NP    s = ResEng.regNP s Sg ** {lock_NP = <>};
plur_NP    s = ResEng.regNP s Pl ** {lock_NP = <>};

NPgen_NP = NP_of_NP;

NP_Cl np = {s = \\t,a,b,o => np.s ! ResEng.Nom; lock_Cl = <>};

prefix_N n = compoundN (UttNP (DetCN (DetSg MassDet NoOrd) (UseN n))).s;

----------------------------------------------------------------------
-- verb phrases, actions

VPing  vp = case vp.clform of {HasDone => vp; IsDoing => ProgrVP vp};
vp2Utt vp = mkUtt (ResEng.infVP True vp (ResEng.agrP3 Sg));
-- vp2Utt vp   = mkUtt (vp.s2 ! (ResEng.agrP3 Sg));i_want_to_Str ++


----------------------------------------------------------------------
-- general syntactical operations

disjunct_QCl q q' = 
    {s = \\t,a,p,x => q.s!t!a!p!x ++ "or" ++ q'.s!t!a!p!x;
     lock_QCl = <>};

negate_Cl c = 
    {s = \\t,a,p,o => c.s!t!a!(case p of {ResEng.CNeg _ => ResEng.CPos; ResEng.CPos => ResEng.CNeg Prelude.True})!o;
     lock_Cl = <>};

----------------------------------------------------------------------
-- verbs

see_V           = Irreg.see_V;

do_V2           = Lex.do_V2;
have_V2         = Lex.have_V2;
understand_V2   = Lex.understand_V2;

know_VQ         = mkVQ Irreg.know_V;
wonder_VQ       = Lex.wonder_VQ;

say_VS          = Lex.say_VS;

fail_VV         = mkVV (regV "fail");
like_VV         = mkVV (regV "like");

----------------------------------------------------------------------
-- nouns, proper nouns, common nouns and noun phrases

information_N   = regN "information";

you_NP          = UsePron Lex.youSg_Pron;

----------------------------------------------------------------------
-- closed word categories

of_på_Prep      = mkPrep "of";
for_Prep        = mkPrep "for";

not_Predet      = ss "not" ** {lock_Predet = <>};

no_Quant        = {s = \\_ => "no"; lock_Quant = <>};
all_Quant       = {s = "all"; lock_QuantPl = <>};


------------------------------------------------------------------

i_dont_want_to = variants { ["i do not want to"];
                            ["i don't want to"] };

}
