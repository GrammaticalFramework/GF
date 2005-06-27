
--# -path=.:../:../../:../Shared/:../../../Resource/Media/:../../../Resource/Media/Swedish/:../../../Resource/Media/English:../../../Resource/Numbers/:../../../Core:../../../Core/Shared/:../../../Core/User

concrete userDomainEng of userDomain = userCoreEng, sharedDomainEng ** { 

flags conversion=finite;


lin

	-- CompoundedAnswers
	answerSongArtistPlay song artist = {s = variants {(song.s ++ "with" ++ artist.s)
					; (artist.s ++ "with" ++ song.s)} };
		
	answerSongArtistAdd song artist = {s = variants {(song.s ++ "with" ++ artist.s)
					; (artist.s ++ "with" ++ song.s)} };
		

pattern
	askArtist = variants { ["what do i have"] ; ["what songs do i have"] ; ["do i have anything"]}
					++ variants {"with" ; "by"};


	askSong = ["who"] ++ variants {"made"; "wrote"};

	askCurrent = ["what"] ++ variants {["song is this"] ; ["is this called"]};


}