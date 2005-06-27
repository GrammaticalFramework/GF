--# -path=.:../:../../:../Shared/:../../../Resource/Home/:../../../Core:../../../Core/Shared/:../../../Core/User

concrete userDomainPro of userDomain = userCorePro, sharedDomainPro ** {

lin

	-- CompoundedAnswers
	answerLampLocTurnOn lamp loc = {s = "answer(lamp(" ++ lamp.s ++ ")," ++ 
					"answer(loc(" ++ loc.s ++ ")"};
		
	answerLampLocTurnOff lamp loc = {s = "answer(lamp(" ++ lamp.s ++ ")," ++ 
					"answer(loc(" ++ loc.s ++ ")"};

}