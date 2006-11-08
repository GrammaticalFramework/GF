--# -path=.:../Common:prelude

abstract TramUser = GodisUser, Stops ** {

fun

------------------------------------------------------------------------
-- Predicates
-- Questions used by the User

-- "find a route"
shortest_route : Question;

-- "I want to go from chalmers"
shortest_route__dept : Stop -> Question;

-- "I want to go to chalmers"
shortest_route__dest : Stop -> Question;

-- "I want to go from chalmers to valand"
shortest_route__dept_dest : Stop -> Stop -> Question;


------------------------------------------------------------------------
-- Answers

-- "from chalmers"
dept_stop : Stop -> Answer;

-- "to chalmers"
dest_stop : Stop -> Answer;

-- "from valand to chalmers"
dept_dest_stop : Stop -> Stop -> Answer;

-----------------------------------------------------------------------
-- Short answers

-- "chalmers"
stop : Stop -> ShortAns;

-- "valand to chalmers"
stop_dest_stop: Stop -> Stop -> ShortAns;

-- "valand from chalmers"
stop_dept_stop: Stop -> Stop -> ShortAns;

-------------------------------------------------------------------------
-- Actions

-- U: restart
top : Action;

-- U: help
help : Action;

-- print_info,
-- download_info,
-- read_info : Action;


}
