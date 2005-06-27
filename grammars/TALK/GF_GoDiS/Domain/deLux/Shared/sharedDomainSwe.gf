--# -path=.:../:../../:../Shared/:../../../Resource/Home/:../../../Core:../../../Core/Shared/:../../../Core/System



concrete sharedDomainSwe of sharedDomain = sharedCoreSwe, DBSwe ** {





lin
	-- ANSWERS

	answerLampOn lamp = {s = lamp.s};
	answerLampOff lamp = {s = lamp.s};
	answerLocation loc = {s = loc.s};
	
	questionWhichLamp lamp = {s = lamp.s};
	questionLocation loc = {s = loc.s};

	
-- LEXICON

pattern

	turnOn = "tända";
	turnOff = "släcka";

	turnOnThis = "tända";
	turnOffThis = "släcka";

	dimmerUp = ["dimma upp"];
	dimmerDown = ["dimma ner"];

	--askLamp = ["har jag en"];
	--askLocation = ["finns det ett"];

	askStatusLamp = ["vilka lampor är tända"];

}








