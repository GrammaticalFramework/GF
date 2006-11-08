--# -path=.:../Common:prelude:resource-1.0/abstract:resource-1.0/common:resource-1.0/scandinavian:resource-1.0/swedish

concrete TramUserSwe of TramUser = GodisUserSwe, StopsSwe ** TramUserI
    with (Grammar=GrammarSwe), (GodisLang=GodisLangSwe), 
         (TramSystemI=TramSystemSwe), (TramLexicon=TramLexiconSwe);

-- concrete TramUserSwe of TramUser = GodisUserSwe, StopsSwe ** 
--     open Prelude, GrammarSwe, GodisLangSwe, TramLexiconSwe, TramSystemSwe, CommonScand in {

-- ------------------------------------------------------------------------
-- -- Predicates
 
-- lin

-- shortest_route 
--     = variants{ askQS shortest_route_Q;
-- 		ss (variants{["hitta"]; ["ge mig"]; ["fråga efter"]} ++ 
-- 			variants{["en rutt"]; ["kortaste vägen"]; ["en resväg"]})};

-- shortest_route__dept x 
--     = ss ( ["jag vill åka från"] ++ x.s!NPNom);

-- shortest_route__dest x 
--     = ss ( ["jag vill åka till"] ++ x.s!NPNom);

-- shortest_route__dept_dest x y 
--     = ss ( variants{["jag vill åka från"] ++ x.s!NPNom ++ "till" ++ y.s!NPNom ; 
-- 	["jag vill åka till"] ++ y.s!NPNom ++ "från" ++ x.s!NPNom} );

-- dest_stop x = ss( "till" ++ x.s!NPNom);	
-- dept_stop x = ss( "från" ++ x.s!NPNom);

-- dept_dest_stop x y = ss(variants{"till" ++ y.s!NPNom ++ "från" ++ x.s!NPNom; 
-- "från" ++ x.s!NPNom ++ "till" ++ y.s!NPNom} );

-- stop_dest_stop x y = ss(x.s!NPNom ++ "till" ++ y.s!NPNom);
-- stop_dept_stop x y = ss(x.s!NPNom ++ "från" ++ y.s!NPNom);

-- ----------------------------------------------------------------------
-- -- Short answers
-- lin
-- stop   x = ansNP x;


-- ----------------------------------------------------------------------
-- -- Actions

-- lin
-- top = reqVP top;

-- help = variants{ reqVP help;
-- 		 ss ["hur gör jag nu"] }; 



-- }

