--# -path=.:../:../../:../Shared/:../../../Resource/Home/:../../../Core:../../../Core/Shared/:../../../Core/User

concrete userDomainEng of userDomain = userCoreEng, sharedDomainEng ** { 

lin

	-- CompoundedAnswers
	-- CompoundedAnswers
	answerLampLocTurnOn lamp loc = {s = lamp.s ++ "in" ++ loc.s};
		
	answerLampLocTurnOff lamp loc = {s = lamp.s ++ "in" ++ loc.s};
}