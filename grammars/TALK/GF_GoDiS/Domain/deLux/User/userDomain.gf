--# -path=.:../:../../:../Shared/:../../../Resource/Home/:../../../Core:../../../Core/Shared/:../../../Core/User

abstract userDomain = userCore, sharedDomain ** {


fun
	-- CompoundedAnswers

	answerLampLocTurnOn : Lamp -> Room -> AnswerList onTask;
	answerLampLocTurnOff : Lamp -> Room -> AnswerList offTask;


}