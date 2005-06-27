--# -path=.:../:../../:../Shared/:../../../Resource/Media/:../../../Resource/Media/Swedish/:../../../Resorce/Media/English:../../../Resource/Numbers/:../../../Core:../../../Core/Shared/:../../../Core/System

abstract systemDomain = sharedDomain, systemCore ** {


fun

-- PROPOSITIONS. 

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

	actionProp : (t: Task) -> Action (t) -> Proposition;



-- Asks
	whatSongQuestion : SingleAsk;   -- "what song do you mean?"
	whatArtistQuestion : SingleAsk;	-- "what artist do you mean?"
	whatIndexQuestion : SingleAsk; -- "what index do you mean?"
	whatToRemoveQuestion : SingleAsk;
	whatStationQuestion : SingleAsk; -- "what station do you want?"
	whatAlbumQuestion : SingleAsk; -- "what album do you mean?"
	whatToPlayQuestion : SingleAsk; -- "which song in the playlist do you want to lay?"
	whatToRemove : SingleAsk; -- "What number do you want to remove?"


-- Confirms

	addedToPlaylist : Confirm;    -- "The playlist is increased"
	removedFromPLaylist : Confirm; -- "The playlist is reduced"
	clearedPlaylist : Confirm;  -- "The playlist is cleared"
	turnedUpVolume : Confirm;  -- "Turning up the volume"
	loweredVolume : Confirm;  -- "Lowering the volume"
	startingThePlayer : Confirm; -- "Starting the music"
	stoppingThePlayer : Confirm; -- "Stopping the music"
	pausingThePlayer : Confirm; -- "Pausing the music"
	resumingThePlayer : Confirm; -- "Resuming the music"
	shuffleTheList : Confirm; -- "The list has been shuffled"
	ffing : Confirm;
	rewinding : Confirm;
	handlingstations : Confirm;
	handlingplayer : Confirm;
	handlingplaylist : Confirm;
	showedList : Confirm;

}







