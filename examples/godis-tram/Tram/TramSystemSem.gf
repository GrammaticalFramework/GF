--# -path=.:../Common:prelude

concrete TramSystemSem of TramSystem = GodisSystemSem, StopsSem, LinesSem ** open Prolog in {

lincat
Route,
Leg,
[Leg] = PStr;

lin

-----------------------------------------------------------
-- Route

lineLeg line s1 s2 = pp3 "leg" line s1 s2;

oneLeg  leg  = pList1 leg;
mkRoute legs = pBrackets legs;
BaseLeg leg leg' = pSeq leg leg';
ConsLeg leg legs = pSeq leg legs;

-----------------------------------------------------------
-- Predicates and questions

shortest_route_Q = pWhQ "shortest_path";
shortest_route_P route = pp1 "shortest_path" route;

dest_stop_Q = pWhQ "dest_stop";
dest_stop_P = pp1 "dest_stop";

dept_stop_Q = pWhQ "dept_stop";
dept_stop_P = pp1 "dept_stop";

------------------------------------------------------------
-- Short answers

stop = pp1 "stop"; 

-------------------------------------------------------------
-- Actions

top              = pp0 "top";
help             = pp0 "help";

}
