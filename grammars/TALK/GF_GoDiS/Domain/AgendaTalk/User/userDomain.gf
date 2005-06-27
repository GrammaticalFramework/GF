--# -path=.:../:../../../Resource/Time:../../../Resource/Media:../Shared:../../../Core:../../../Core/Shared:../../../Core/User

abstract userDomain = userCore, sharedDomain ** {


fun
	-- CompoundedAnswers

	answerEventLocAdd : Event -> Location -> AnswerList addTask;
	answerEventLocRem : Event -> Location -> AnswerList removeTask;

	answerEventLocTimeDay : Event -> Location -> Time -> Weekday -> AnswerList removeTask;
}