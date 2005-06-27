-- SWEDISH VERSION, UNCOMMENT AS NEEDED
--# -path=.:../:../DBase/Swedish:../DBase:../Shared:../System:../Numbers

-- ENGLISH VERSION, UNCOMMENT AS NEEDED
-- --# -path=.:../:../DBase/English:../DBase:../Shared:../System:../Numbers

abstract systemDomain = sharedDomain, systemCore ** {


cat

	Proposition;


fun

-- PROPOSITIONS. 
-- 

	songProp : Song -> Proposition;
	itemProp : Song -> Proposition;
	currentSongProp : Song -> Proposition;

	whatToPlayPropNum : Number -> Proposition;
	whatToPlayPropOrd : Number -> Proposition;

	itemRemPropNum : Number -> Proposition;
	itemRemPropOrd : Number -> Proposition;
	
	groupToAddProp : Artist -> Proposition;
	artistProp : Artist -> Proposition;
	groupProp : Artist -> Proposition;
	songArtistProp : Artist -> Proposition;
	
	albumProp : Album -> Proposition;

	artistsSongProp : Artist -> Proposition;
	artistsAlbumProp : Artist -> Proposition;

	albumArtistProp : Album -> Proposition;

	songsArtistProp : Song -> Proposition;

	stationProp : Station -> Proposition;

}







