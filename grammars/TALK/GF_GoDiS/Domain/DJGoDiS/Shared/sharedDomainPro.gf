-- SWEDISH VERSION, UNCOMMENT AS NEEDED
-- --# -path=.:../:../../:../Shared/:../../../Resource/Media/:../../../Resource/Media/Swedish/:../../../Resource/Numbers/:../../../Core:../../../Core/Shared/
--concrete sharedDomainPro of sharedDomain = sharedCorePro, numbersEng, orderNumEng, swedishDBPro ** {


-- ENGLISH VERSION, UNCOMMENT AS NEEDED
--# -path=.:../:../../:../Shared/:../../../Resource/Media/:../../../Resource/Media/English/:../../../Resource/Numbers/:../../../Core:../../../Core/Shared/

concrete sharedDomainPro of sharedDomain = sharedCorePro, DBPro ** {

flags lexer=code ; unlexer=code ;
flags conversion=finite;

lin

-- ANSWERS

	answerSongPlay song = { s = "item" ++ "(" ++ song.s ++ ")"};	
	answerSongAdd song = { s = "item" ++ "(" ++ song.s ++ ")"};
	answerSongRemove song = { s = "item" ++ "(" ++ song.s ++ ")"};
	questionSong song = { s = "item" ++ "(" ++ song.s ++ ")"};
	

	answerArtistPlay artist = { s = "group" ++ "(" ++ artist.s ++ ")"};
	answerArtistAdd artist = { s = "groupToAdd" ++ "(" ++ artist.s ++ ")"};
	answerArtistRemove artist = { s = "group" ++ "(" ++ artist.s ++ ")"};
	questionArtist artist = {s = "group" ++ "(" ++ artist.s ++ ")"};


	answerStationPlay station = { s = "station" ++ "(" ++ station.s ++ ")"};
	answerStationAdd station = { s = "station" ++ "(" ++ station.s ++ ")"};
	answerStationRemove station = { s = "station" ++ "(" ++ station.s ++ ")"};


	answerNumberInListPlay numb = {s = "index" ++ "(" ++ "[" ++  numb.s  ++ "]" ++ ")"};
	answerNumberInListRemove numb = {s = "itemRem" ++ "(" ++ "[" ++  numb.s  ++ "]" ++ ")"};

	answerOrderInListPlay ordNum = {s = "index" ++ "(" ++ "[" ++ ordNum.s  ++ "]" ++ ")"};
	answerOrderInListRemove ordNum = {s = "itemRem" ++ "(" ++ "[" ++ ordNum.s  ++ "]" ++ ")"};



-- LEXICON
pattern

	play_spec = "start_specific";
	play_spec_alone = "start_specific";
	play = "start";
	stop = "stop";
	pause = "pause";
	resume = "resume";

	next = "next";
	previous = "previous";

	raise_volume	= "vol_up" ;
	lower_volume	= "vol_down" ;


	fastforward	= "fast_forward";
	rewind		= "rewind";


	shift = "set_balance";
	right = "1.0";
	left = "-1.0";
	center = "0.0";

	show_list = "show_list";

	add = "playlist_add";
	add_alone = "playlist_add";
	remove = "playlist_del";
	remove_alone = "playlist_del";

	remove_all = "playlist_clear";

	handle_list 	= "handle_playlist";
	handle_player 	= "handle_player";
	handle_stations = "handle_stations";
	
	askArtist = "songs_by_artist";
	askSong = "artists_song";

	askCurrent = "current_song";

}