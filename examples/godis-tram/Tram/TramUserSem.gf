--# -path=.:../Common:prelude

concrete TramUserSem of TramUser = GodisUserSem, StopsSem ** 
    open Prolog, TramSystemSem in {

lin

-------------------------------------------------------------
-- Predicates and questions

shortest_route = pm1 (ask shortest_route_Q);

shortest_route__dept x = pm2 (ask shortest_route_Q) (answer (dept_stop_P x));
shortest_route__dest x = pm2 (ask shortest_route_Q) (answer (dest_stop_P x));

shortest_route__dept_dest x y = pm3 (ask shortest_route_Q) (answer (dept_stop_P x)) (answer (dest_stop_P y));

dest_stop x = pm1 (answer (dest_stop_P x));
dept_stop x = pm1 (answer (dept_stop_P x));

dept_dest_stop x y = pm2 (answer (dept_stop_P x)) (answer (dest_stop_P y));


--------------------------------------------------
-- Short answers

stop   x = pm1 (shortAns (stop x));

stop_dest_stop x y = pm2 (shortAns(stop x)) (answer(dest_stop_P y));
stop_dept_stop x y = pm2 (shortAns(stop x)) (answer(dept_stop_P y));


------------------------------------------------------
-- Actions
top = pm1 (request top);
help = pm1 (request help);

}

