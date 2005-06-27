--# -path=.:../:../../:../Shared/:../../../Resource/Home/:../../../Core:../../../Core/Shared/:../../../Core/System

concrete systemDomainSwe of systemDomain = sharedDomainSwe, systemCoreSwe ** {

lin

-- PROPOSITIONS

	lampProp lamp = { s = lamp.s };
	locProp loc =  { s = loc.s };

	whatToTurnOffProp lamp = { s = lamp.s };
	whatToTurnOnProp lamp = { s = lamp.s };

pattern

-- Asks

	whatLampQuestion = ["vilken lampa menar du"];
	whatLocQuestion = ["vilket rum menar du"];

-- Confirms

	turnedOnLamp = ["lampan är tänd"];
	turnedOffLamp = ["lampan är släckt"];
}


