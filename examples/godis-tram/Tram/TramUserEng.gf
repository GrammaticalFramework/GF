--# -path=.:../Common:prelude:resource-1.0/abstract:resource-1.0/common:resource-1.0/english

concrete TramUserEng of TramUser = GodisUserEng, StopsEng ** TramUserI
    with (Grammar=GrammarEng), (GodisLang=GodisLangEng), 
         (TramSystemI=TramSystemEng), (TramLexicon=TramLexiconEng);

-- concrete TramUserEng of TramUser = GodisUserEng, StopsEng ** 
--     open Prelude, GodisLangEng, TramSystemEng, ResEng, TramLexiconEng in {

-- ----------------------------------------------------------------------
-- -- Predicates and questions

-- lin

-- shortest_route 
--     = variants{ askQS shortest_route_Q;
-- 		ss (variants{["find"]; ["find out"]; ["get"]; ["ask for"]} ++ 
-- 			variants{["a route"]; ["shortest route"];["a way"];["a itinerary"]})};

-- shortest_route__dept x 
--     = ss ( ["i want to go from"] ++ x.s!Nom); 
 

-- shortest_route__dest x 
--     = ss ( ["i want to go to"] ++ x.s!Nom);


-- shortest_route__dept_dest x y 
--     = ss ( variants{["i want to go from"] ++ x.s!Nom ++ "to" ++ y.s!Nom;
-- 	["i want to go to"] ++ y.s!Nom ++ "from" ++ x.s!Nom} );


-- dest_stop x = ss( "to" ++ x.s!Nom);	
-- dept_stop x = ss( "from" ++ x.s!Nom);

-- dept_dest_stop x y = ss(variants{"to" ++ y.s!Nom ++ "from" ++ x.s!Nom; 
-- "from" ++ x.s!Nom ++ "to" ++ y.s!Nom} );

-- stop_dest_stop x y = ss(x.s!Nom ++ "to" ++ y.s!Nom);
-- stop_dept_stop x y = ss(x.s!Nom ++ "from" ++ y.s!Nom);


-- ----------------------------------------------------------------------
-- -- short answers
-- lin

-- stop   x = ansNP x;


-- ----------------------------------------------------------------------
-- -- Actions
-- lin

-- top = reqVP top;

-- help = reqVP help; 

-- }

