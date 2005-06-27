--# -path=.:../:../../:../Shared/:../../../Resource/Home/:../../../Core:../../../Core/Shared/:../../../Core/System



concrete sharedDomainPro of sharedDomain = sharedCorePro, DBPro ** {





lin
	-- ANSWERS

	answerLampOn lamp = {s = lamp.s};
	answerLampOff lamp = {s = lamp.s};
	answerLocation loc = {s = loc.s};
	
	questionWhichLamp lamp = {s = lamp.s};
	questionLocation loc = {s = loc.s};

	
-- LEXICON

pattern

	turnOn = "turnOn";
	turnOff = "turnOff";

	turnOnThis = "turnOn_closest";
	turnOffThis = "turnOff_closest";

	dimmerUp = "dimmer_up";
	dimmerDown = "dimmer_down";

	--askLamp = "lamps";
	--askLocation = "locations";

	askStatusLamp = "status";

}



