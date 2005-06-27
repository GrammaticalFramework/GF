--# -path=.:../:../../:../Shared/:../../../Resource/Home/:../../../Core:../../../Core/Shared/:../../../Core/System

abstract systemDomain = sharedDomain, systemCore ** {


fun

-- PROPOSITIONS. 
-- 


	lampProp : Lamp -> Proposition onTask;
	locProp : Room -> Proposition onTask;

	whatToTurnOffProp : Lamp -> Proposition offTask;
	whatToTurnOnProp : Lamp -> Proposition onTask;

-- Asks
	whatLampQuestion : SingleAsk;   -- "what song do you mean?"
	whatLocQuestion : SingleAsk;	-- "what artist do you mean?"

-- Confirms

	turnedOnLamp : Confirm;
	turnedOffLamp : Confirm;

}







