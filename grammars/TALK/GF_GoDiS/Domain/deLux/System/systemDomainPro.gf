--# -path=.:../:../../:../Shared/:../../../Resource/Home/:../../../Core:../../../Core/Shared/:../../../Core/System

concrete systemDomainPro of systemDomain = sharedDomainPro, systemCorePro  ** {

lin

-- PROPOSITIONS

	lampProp lamp = { s = lamp.s };
	locProp loc =  { s = loc.s };

	whatToTurnOffProp lamp = { s = lamp.s };
	whatToTurnOnProp lamp = { s = lamp.s };

pattern

-- Asks

	whatLampQuestion = ["X^lamp(X)"];
	whatLocQuestion = ["X^loc(X)"];

-- Confirms

	turnedOnLamp = ["turnOn"];
	turnedOffLamp = ["turnOff"];


}