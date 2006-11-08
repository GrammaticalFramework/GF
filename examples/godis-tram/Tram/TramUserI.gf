--# -path=.:../Common:prelude:resource-1.0/abstract:resource-1.0/common

incomplete concrete TramUserI of TramUser = GodisUserI ** 
    open Prelude, Grammar, GodisLang, TramSystemI, TramLexicon in {

----------------------------------------------------------------------
-- Predicates and questions

lin

shortest_route 
    = variants{ askQS shortest_route_Q;
		reqVP (ComplV2 (variants{find_V2;findout_V2}) 
			   (variants {indef_N_sg (variants{way_N;route_N});
				      (the_A_super_N_sg short_A (variants{way_N;route_N}))})) };

shortest_route__dept x 
    = reqVP (ComplV2 go_from_V2 x);

shortest_route__dest x 
    = reqVP (ComplV2 go_to_V2 x);

shortest_route__dept_dest x y 
    = variants{ reqVP (AdvVP (ComplV2 go_from_V2 x) (Prep_NP to_Prep y));
		reqVP (AdvVP (ComplV2 go_to_V2 y) (Prep_NP from_Prep y)) };


dest_stop x = UttAdv (Prep_NP to_Prep x);
dept_stop x = UttAdv (Prep_NP from_Prep x);

dept_dest_stop x y
    = variants{ UttAdv (Prep_NP to_Prep (NP_Prep_NP from_Prep x y));
		UttAdv (Prep_NP from_Prep (NP_Prep_NP to_Prep x y)) };


----------------------------------------------------------------------
-- short answers
lin

stop x = ansNP x;

stop_dest_stop x y = ansNP (NP_Prep_NP to_Prep x y);
stop_dept_stop x y = ansNP (NP_Prep_NP from_Prep x y);



----------------------------------------------------------------------
-- Actions
lin

top = reqVP top;

help = reqVP help; 

}

