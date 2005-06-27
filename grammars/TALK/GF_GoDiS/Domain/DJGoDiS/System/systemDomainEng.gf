--# -path=.:../:../../:../Shared/:../../../Resource/Media/:../../../Resource/Media/English/:../../../Resorce/Media/Swedish:../../../Resource/Numbers/:../../../Core:../../../Core/Shared/:../../../Core/System

concrete systemDomainEng of systemDomain = sharedDomainEng, systemCoreEng ** {


flags conversion=finite;


lin

-- PROPOSITIONS

	songProp song = { s = song.s };
	itemProp song =  { s = song.s };
	currentSongProp song = { s = song.s };

	whatToPlayPropNum number = { s = number.s };
	whatToPlayPropOrd order = { s = order.s };

	itemRemPropNum number = { s = number.s };
	itemRemPropOrd order = { s =  order.s };
	
	groupToAddProp artist = { s = artist.s };
	artistProp artist = { s = artist.s};
	groupProp artist = { s = artist.s };
	songArtistProp artist = { s = artist.s };
	
	albumProp album = { s = album.s };

	artistsSongProp artist = { s = artist.s };
	artistsAlbumProp artist = { s = artist.s };

	albumArtistProp album = { s = album.s };

	songsArtistProp song = { s = song.s };

	stationProp station = { s = station.s };

	actionProp _ action = {s = action.s };

-- sort_restr( song(X) ):-          sem_sort(X,item).
-- sort_restr( item(X) ):-          sem_sort(X,item).
-- sort_restr( current_song(X) ):-  sem_sort(X,song).
-- sort_restr( what_to_play(X) ):-  sem_sort(X,index).
-- sort_restr( itemRem(X) ):-       sem_sort(X,index).
-- sort_restr( itemRem(X) ):-       sem_sort(X,index).
-- sort_restr( groupToAdd(X) ):-    group( X ).
-- sort_restr( artist(X) ):-        group( X ).
-- sort_restr( group(X) ):-         group( X ).
-- sort_restr( song_artist(X) ):-   group( X ).
-- sort_restr( album(X) ):-         album( X ).
-- sort_restr( artists_song(X) ):-  group_atom( X ).
-- sort_restr( artists_album(X) ):- group_atom( X ).
-- sort_restr( albums_by_artist(X) ):- album_atom( X ).
-- sort_restr( songs_by_artist(X) ):-  song_atom( X ).
-- sort_restr( station(X) ):-	 radio_station( X ).
-- sort_restr( year(X) ):-          sem_sort( X, year ).
-- sort_restr( path(X) ):-          atomic( X ).%,format("hallå: ~w\n",[X]).
-- %sort_restr( X^path(X) ):-          atomic( X ),format("hallå: ~w\n",[X]).
-- sort_restr( not path(X) ):-     format("hallå: ~w\n",[X]), atomic( X ).
-- sort_restr( fail(Path^path(Path),no_matches) ).


pattern


-- Because of differing linearisations in User and System usage these functions are not linearized in Shared. 

	askArtist = "song" ; 
	askSong = "artist" ; 
	askCurrent = ["the current song"];


-- Asks
	whatSongQuestion = ["what song do you mean"];
	whatArtistQuestion = ["what artist do you mean"];
	whatIndexQuestion = ["what index number do you want to play"];
	whatToRemoveQuestion = ["what song do you want to remove from the playlist"];
	whatStationQuestion = ["what radio station do you want to listen to"];
	whatAlbumQuestion = ["what album do you mean"];
	whatToPlayQuestion = ["what song in the playlist do you want to play"];
	whatToRemove = ["what song in the playlist do you want to remove"];


-- Confirms

	addedToPlaylist = ["the playlist is increased"];
	removedFromPLaylist = ["the playlist is reduced"];
	clearedPlaylist = ["the playlist is cleared"];
	turnedUpVolume = ["turning up the volume"];
	loweredVolume = ["lowering the volume"];
	startingThePlayer = ["starting the music"]; 
	stoppingThePlayer = ["the player is stopped"];
	pausingThePlayer = ["pausing the player"];
	resumingThePlayer = ["resuming the music"];
	shuffleTheList = ["the playlist has been shuffled"];
	ffing = ["performing fast forward"];
	rewinding = ["rewinding"];
	handlingstations = ["done with choosing a station"];
	handlingplayer = ["your wish is my command"];
	handlingplaylist = ["done fiddling with the playlist"];
	showedList = ["finished showing the list"];

}


