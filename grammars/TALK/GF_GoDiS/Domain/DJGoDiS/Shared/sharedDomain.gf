-- SWEDISH version, uncomment as needed.
-- --# -path=.:../:../../:../Shared/:../../../Resource/Media/:../../../Resource/Media/Swedish/:../../../Resource/Numbers/:../../../Core:../../../Core/Shared/
-- abstract sharedDomain = sharedCore, numbers, orderNum, swedishDB ** {


-- ENGLISH version, uncomment as needed.
--# -path=.:../:../../:../Shared/:../../../Resource/Media/:../../../Resource/Media/English/:../../../Resource/Numbers/:../../../Core:../../../Core/Shared/

abstract sharedDomain = sharedCore, DB ** {

fun

-- ANSWERS

	-- Request Answers

	answerSongPlay 		: Song 		-> Proposition playTask;
	answerSongAdd		: Song 		-> Proposition addTask;
	answerSongRemove 	: Song 		-> Proposition removeTask;

	answerArtistPlay 	: Artist 	-> Proposition playTask;
	answerArtistAdd 	: Artist 	-> Proposition addTask;
	answerArtistRemove 	: Artist 	-> Proposition removeTask;

	answerStationPlay 	: Station 	-> Proposition playTask;
	answerStationAdd 	: Station 	-> Proposition addTask;
	answerStationRemove 	: Station 	-> Proposition removeTask;

	answerNumberInListPlay 	: Number 	-> Proposition playTask;
	answerNumberInListRemove: Number 	-> Proposition removeTask;

	answerOrderInListPlay 	: OrderNumber 	-> Proposition playTask;
	answerOrderInListRemove	: OrderNumber 	-> Proposition removeTask;




	-- Ask Answers
	questionSong		: Song		-> Proposition songQuestion;
	questionArtist		: Artist 	-> Proposition artistQuestion;

-- LEXICON

	playTask	 	: Task;
	addTask			: Task;
	removeTask		: Task;
	speakerTask 		: Task;

	artistQuestion		: Task;
	songQuestion		: Task;


	play_spec		: Action 		playTask;

	play_spec_alone		: SingleAction;
	play			: SingleAction;
	stop 			: SingleAction;
	pause 			: SingleAction;
	resume 			: SingleAction;

	next 		: OrderNumber;
	previous 	: OrderNumber;

	raise_volume	: SingleAction;
	lower_volume	: SingleAction;

	fastforward	: SingleAction;
	rewind		: SingleAction;

	shift 		: Action 		speakerTask;
	right 		: Proposition 		speakerTask;
	left 		: Proposition 		speakerTask;
	center 		: Proposition 		speakerTask;

	show_list 	: SingleAction;

	add 		: Action 		addTask;
	add_alone	: SingleAction;
	remove 		: Action 		removeTask;
	remove_alone	: SingleAction;

	remove_all	: SingleAction;
	

	handle_list	: SingleAction;
	handle_player	: SingleAction;
	handle_stations	: SingleAction;

	askArtist	: Ask			artistQuestion;
	askSong		: Ask			songQuestion;

	askCurrent	: SingleAsk;

}











