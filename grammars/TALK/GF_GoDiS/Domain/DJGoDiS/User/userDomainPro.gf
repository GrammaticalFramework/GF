--# -path=.:../:../../:../Shared/:../../../Resource/Media/:../../../Resource/Media/English/:../../../Resource/Media/Swedish:../../../Resorce/Media/Swedish:../../../Resource/Numbers/:../../../Core:../../../Core/Shared/:../../../Core/User



concrete userDomainPro of userDomain = userCorePro, sharedDomainPro ** {

flags conversion=finite;


lin
	answerSongArtistPlay song artist = { s = ["answer ( item ("] ++ song.s ++ [" ) ) ,"] ++ 
						["answer ( group ("] ++ artist.s ++ [") )"]};
	answerSongArtistAdd song artist = { s = ["answer ( item ("] ++ song.s ++ [" ) ) ,"] ++ 
						["answer ( group ("] ++ artist.s ++ [") )"]};
}