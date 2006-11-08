--# -path=.:../Common:prelude

abstract TramSystem = GodisSystem, Stops, Lines ** {

cat
Route; -- route descripiption.
Leg; 
[Leg]{2}; -- route segments on a line
-- the following are derived from declaring [Leg]{2}:
-- BaseLeg : Leg -> Leg -> [Leg];
-- ConsLeg : Leg -> [Leg] -> [Leg];


fun

-----------------------------------------------------------------
-- Functions for creating routes

lineLeg : Line -> Stop -> Stop -> Leg;

oneLeg  : Leg -> Route;
mkRoute : [Leg] -> Route;

-------------------------------------------------------------------
-- Predicates
-- Questions and Propositions as they are intended to be used 
-- by either System or User

-- U: what is the shortest route?
shortest_route_Q : Question;

-- S: Take Tram Z from X to Y. Take...
shortest_route_P : Route -> Proposition;

-- S: Where do you want to go to?
dest_stop_Q : Question;

-- U: I want to go to Stop
dest_stop_P : Stop -> Proposition;

-- S: Where do you want to go from?
dept_stop_Q : Question;

-- U: I want to go from Stop
dept_stop_P : Stop -> Proposition;


-----------------------------------------------------------------
-- Short answers

-- U: "klippan" 
stop : Stop -> ShortAns;


------------------------------------------------------------------
-- Actions
 
-- S: GoTGoDiS is a tram information system
help: Action;

-- S: restarting
top: Action;

}
