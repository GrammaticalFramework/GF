--# -path=.:../:../DBase/English:../DBase:../Numbers:../Shared

concrete userDomainEng of userDomain = userCoreEng, sharedDomainEng ** { 

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