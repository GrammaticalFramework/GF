-- SWEDISH VERSION, UNCOMMENT WHEN NEEDED
----# -path=.:../:../../:../Shared/:../../../Resource/Media/:../../../Resource/Media/Swedish/:../../../Resource/Numbers/:../../../Core:../../../Core/Shared/:../../../Core/User


-- ENGLISH VERSION, UNCOMMENT WHEN NEEDED
--# -path=.:../:../../:../Shared/:../../../Resource/Media/:../../../Resource/Media/English/:../../../Resorce/Media/Swedish:../../../Resource/Numbers/:../../../Core:../../../Core/Shared/:../../../Core/User


abstract userDomain = userCore, sharedDomain ** {


fun
	-- CompoundedAnswers

	answerSongArtistPlay : Song -> Artist -> AnswerList playTask;
	answerSongArtistAdd : Song -> Artist -> AnswerList addTask;


}