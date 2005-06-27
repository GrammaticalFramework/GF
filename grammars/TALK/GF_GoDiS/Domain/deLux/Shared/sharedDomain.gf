--# -path=.:../:../../:../Shared/:../../../Resource/Home/:../../../Core:../../../Core/Shared/:../../../Core/System

abstract sharedDomain = sharedCore, DB ** {

fun

-- ANSWERS

	answerLampOn 		: Lamp 		-> Proposition onTask;
	answerLampOff		: Lamp 		-> Proposition offTask;

	answerLocation		: Room 		-> Proposition locateTask;

	-- Ask Answers
	questionWhichLamp	: Lamp		-> Proposition lampQuestion;
	questionLocation	: Room 		-> Proposition locQuestion;

-- LEXICON

	onTask	 		: Task;
	offTask			: Task;
	locateTask		: Task;
	lampQuestion 		: Task;
	locQuestion 		: Task;

	turnOn			: Action	onTask;
	turnOff			: Action 	offTask;

	turnOnThis		: SingleAction;
	turnOffThis		: SingleAction;

	dimmerUp		: SingleAction;
	dimmerDown		: SingleAction;

	--askLamp		: Ask			lampQuestion;
	--askLocation	: Ask			locQuestion;

	askStatusLamp	: SingleAsk;
}











