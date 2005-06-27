--# -path=.:../:../../:../Shared/:../../../Resource/Home/:../../../Core:../../../Core/Shared/:../../../Core/System


concrete sharedDomainEng of sharedDomain = sharedCoreEng, DBEng ** 
		open SpecResEng in {





lin
	-- ANSWERS

	answerLampOn lamp = {s = lamp.s};
	answerLampOff lamp = {s = lamp.s};
	answerLocation loc = {s = loc.s};
	
	questionWhichLamp lamp = {s = lamp.s};
	questionLocation loc = {s = loc.s};

-- LEXICON

pattern
	
	turnOn = ["turn on"];
	turnOff = ["turn off"];

	turnOnThis = ["turn on"];
	turnOffThis = ["turn off"];

	dimmerUp = ["dim up"];
	dimmerDown = ["dim down"];

	--askLamp = ["do i have a"];
	--askLocation = ["is there a"];

	askStatusLamp = ["what lights are on"];
}








