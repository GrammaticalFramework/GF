-- SWEDISH VERSION, UNCOMMENT AS NEEDED
--# -path=.:../:../DBase/Swedish:../DBase:../Shared:../System:../Numbers
concrete sharedDomainPro of sharedDomain = sharedCorePro, numbersEng, orderNumEng, swedishDBPro ** {

-- ENGLISH VERSION, UNCOMMENT AS NEEDED
-- --# -path=.:../:../DBase/English:../DBase:../Shared:../System:../Numbers


-- concrete sharedDomainPro of sharedDomain = sharedCorePro, numbersEng, orderNumEng, englishDBPro ** {

flags lexer=code ; unlexer=code ;

lin

-- ANSWERS

	answerSongPlay song = { s = "item" ++ "(" ++ song.s ++ ")"};	
	answerSongAdd song = { s = "item" ++ "(" ++ song.s ++ ")"};
	answerSongRemove song = { s = "item" ++ "(" ++ song.s ++ ")"};
	questionSong song = { s = "item" ++ "(" ++ song.s ++ ")"};
	

	answerArtistPlay artist = { s = "group" ++ "(" ++ artist.s ++ ")"};
	answerArtistAdd artist = { s = "group" ++ "(" ++ artist.s ++ ")"};
	answerArtistRemove artist = { s = "group" ++ "(" ++ artist.s ++ ")"};
	questionArtist artist = {s = "group" ++ "(" ++ artist.s ++ ")"};


	answerStationPlay station = { s = "station" ++ "(" ++ station.s ++ ")"};
	answerStationAdd station = { s = "station" ++ "(" ++ station.s ++ ")"};
	answerStationRemove station = { s = "station" ++ "(" ++ station.s ++ ")"};


	answerNumberInListPlay numb = {s = "index" ++ "(" ++ "[" ++  numb.s  ++ "]" ++ ")"};
	answerNumberInListRemove numb = {s = "index" ++ "(" ++ "[" ++  numb.s  ++ "]" ++ ")"};

	answerOrderInListPlay ordNum = {s = "index" ++ "(" ++ "[" ++ ordNum.s  ++ "]" ++ ")"};
	answerOrderInListRemove ordNum = {s = "index" ++ "(" ++ "[" ++ ordNum.s  ++ "]" ++ ")"};



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

	shift = "set_balance";
	right = "1.0";
	left = "-1.0";
	center = "0.0";

	show_list = "show_list";

	add = "playlist_add";
	remove = "playlist_del";

	handle_list 	= "handle_playlist";
	handle_player 	= "handle_player";
	handle_stations = "handle_stations";
	
	askArtist = "songs_by_artist";
	askSong = "artists_song";

	askCurrent = "current_song";

}