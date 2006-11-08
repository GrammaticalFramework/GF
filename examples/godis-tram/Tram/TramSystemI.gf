--# -path=.:../Common:prelude:resource-1.0/abstract:resource-1.0/common

incomplete concrete TramSystemI of TramSystem = 
    GodisSystemI ** open Grammar, GodisLang, TramLexicon in {

lincat
Route = NP;
Leg = NP; 
[Leg] = [NP];


lin

-----------------------------------------------------------------------------
-- Route 

lineLeg line from to = AdvNP (AdvNP line (PrepNP from_Prep from)) (PrepNP to_Prep to);

oneLeg  leg  = leg;
mkRoute legs = ConjNP and_then_Conj legs;
BaseLeg = BaseNP;
ConsLeg = ConsNP;

-------------------------------------------------------------------------------
-- Predicates and Questions 

shortest_route_Q     = isDoing ** what_is_NP (the_A_super_N_sg short_A route_N);
shortest_route_P   x = isDoing ** GenericCl (ComplV2 take_V2 x);

dest_stop_Q          = isDoing ** which_N_do_you_want_to_V2 stop_N go_to_V2;
dest_stop_P        x = isDoing ** you_want_to_VP (ComplV2 go_to_V2 x);

dept_stop_Q          = isDoing ** which_N_do_you_want_to_V2 stop_N go_from_V2;
dept_stop_P        x = isDoing ** you_want_to_VP (ComplV2 go_from_V2 x);


---------------------------------------------------------------------------
-- Short Answers

stop x = x;

-----------------------------------------------------------------------
-- Actions

top              = isDoing ** UseV restart_V;

help             = isDoing ** UseV help_V;

}
