--# -path=.:../:../../../Resource/Time:../Shared:../../../Core:../../../Core/Shared:

abstract sharedDomain = sharedCore, DB, Time, Weekday ** {

fun

-- ANSWERS

	--makeAddLocAnswer : Location -> Proposition addTask;
	--makeRemLocAnswer : Location -> Proposition removeTask;

	makeAddEventAnswer : Event -> Proposition addTask;
	makeRemEventAnswer : Event -> Proposition removeTask;
	makeCheckupAnswer : Event -> Proposition checkupTask;
	makeCheckTimeAnswer : Event -> Proposition checkTimeTask;
	makeAddInfoAnswer : Event -> Proposition addInfoTask;

	makeAddEventTimeAnswer : Time -> Proposition addTask;
	makeRemEventTimeAnswer : Time -> Proposition removeTask;
	makeCheckupTimeAnswer : Time -> Proposition checkupTask;
	makeCheckTimeTimeAnswer : Time -> Proposition checkTimeTask;
	makeAddInfoTimeAnswer : Time -> Proposition addInfoTask;

	makeAddEventDayAnswer : Weekday -> Proposition addTask;
	makeRemEventDayAnswer : Weekday -> Proposition removeTask;
	makeCheckupDayAnswer : Weekday -> Proposition checkupTask;
	makeCheckTimeDayAnswer : Weekday -> Proposition checkTimeTask;
	makeAddInfoDayAnswer : Weekday -> Proposition addInfoTask;

	makeCheckAnswer : Location -> Proposition checkupTask;
	makeAddInfoLocAnswer : Location -> Proposition addInfoTask;
	makeCheckTimeLocAnswer : Location -> Proposition checkTimeTask;



-- LEXICON

	addTask : Task;  
	removeTask : Task;
	changeTask : Task;
	addInfoTask : Task;
	checkupTask : Task; -- "har jag"
	checkTimeTask : Task;

	addEntry : Action addTask; -- "lägga till", "anteckna", "göra en anteckning", "boka", "boka in"
	removeEntry : Action removeTask; -- "ta bort", "radera", "ta bort en anteckning", "ta bort anteckningen"
	changeEntry : Action changeTask; -- "ändra anteckningen" - "request(change_info)"
	augmentEntry : Action addInfoTask; -- "lägga till mer information"  - "request(more_info)
	checkupEntry : Action checkTimeTask;

	checkup : Ask	checkupTask; -- "vad har jag"
	
}











