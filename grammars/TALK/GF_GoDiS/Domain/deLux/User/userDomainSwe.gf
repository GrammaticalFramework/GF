--# -path=.:../:../../:../Shared/:../../../Resource/Home/:../../../Core:../../../Core/Shared/:../../../Core/User

concrete userDomainSwe of userDomain = userCoreSwe, sharedDomainSwe ** { 

lin

	-- CompoundedAnswers
	answerLampLocTurnOn lamp loc = {s = lamp.s ++ "i" ++ loc.s};
		
	answerLampLocTurnOff lamp loc = {s = lamp.s ++ "i" ++ loc.s};
}