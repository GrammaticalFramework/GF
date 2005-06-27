--# -path=.:../:../../:../../../Resource/Time:../../../Resource/Media/:../Shared:../../../Core:../../../Core/Shared:../../../Core/User

concrete userDomainSwe of userDomain = userCoreSwe, sharedDomainSwe ** { 

lin

	-- CompoundedAnswers
	answerEventLocAdd event loc = {s = event.s ++ loc.s };
		
	answerEventLocRem event loc = {s = event.s ++ loc.s };

	answerEventLocTimeDay event loc time day = {s = variants {
							(event.s ++ loc.s ++ time.s ++ "på" ++ day.s);
							(event.s ++ loc.s ++ "på" ++ day.s ++ time.s);
						}
					};

--							(event.s ++ "på" ++ day.s ++ time.s);
--							(loc.s ++ time.s ++ "på" ++ day.s);

							  

		
}