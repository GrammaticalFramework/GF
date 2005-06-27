-- SWEDISH VERSION, UNCOMMENT AS NEEDED
--# -path=.:../:../DBase/Swedish:../DBase:../Numbers:../Shared

-- ENGLISH VERSION, UNCOMMENT AS NEEDED
-- --# -path=.:../:../DBase/English/:../DBase/:../Numbers:../Shared


concrete userDomainPro of userDomain = userCorePro, sharedDomainPro ** {

lin
	answerSongArtistPlay song artist = { s = "answer(item(" ++ song.s ++ ")," ++ 
						"answer(group(" ++ artist.s ++ ")"};
	answerSongArtistAdd song artist = { s = "answer(item(" ++ song.s ++ ")," ++ 
						"answer(group(" ++ artist.s ++ ")"};



}