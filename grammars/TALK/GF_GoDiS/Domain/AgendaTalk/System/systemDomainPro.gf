-- SWEDISH VERSION, UNCOMMENT AS NEEDED
--# -path=.:../:../DBase/Swedish:../DBase:../Shared:../System:../Numbers

-- ENGLISH VERSION, UNCOMMENT AS NEEDED
-- --# -path=.:../:../DBase/English:../DBase:../Shared:../System:../Numbers


concrete systemDomainPro of systemDomain = sharedDomainPro, systemCorePro  ** {


lin
-- PROPOSITIONS

	-- Ok hur ska jag göra med propositions tro? Och vad menar David med song_to_add(Song). 
	-- Hur blir de till? Skulle man kunna göra som nedan?

	songProp song = { s = "song" ++ "(" ++ song.s ++ ")" };
	itemProp song =  { s = "item" ++ "(" ++ song.s ++ ")" };
	currentSongProp song = { s = "current_song" ++ "(" ++ song.s ++ ")" };

	whatToPlayPropNum number = { s = "what_to_play" ++ "(" ++ number.s ++ ")" };
	whatToPlayPropOrd order = { s = "what_to_play" ++ "(" ++ order.s ++ ")" };

	itemRemPropNum number = { s = "itemRem" ++ "(" ++ number.s ++ ")" };
	itemRemPropOrd order = { s = "itemRem" ++ "(" ++ order.s ++ ")" };
	
	groupToAddProp artist = { s = "groupToAdd" ++ "(" ++ artist.s ++ ")" };
	artistProp artist = { s = "artist" ++ "(" ++ artist.s ++ ")"};
	groupProp artist = { s = "group" ++ "(" ++ artist.s ++ ")" };
	songArtistProp artist = { s = "song_artist" ++ "(" ++ artist.s ++ ")" };
	
	albumProp album = { s = "album" ++ "(" ++ album.s ++ ")" };

	artistsSongProp artist = { s = "artist_song" ++ "(" ++ artist.s ++ ")" };
	artistsAlbumProp artist = { s = "artists_album" ++ "(" ++ artist.s ++ ")" };

	albumArtistProp album = { s = "albums_by_artist" ++ "(" ++ album.s ++ ")" };

	songsArtistProp song = { s = "songs_by_artist" ++ "(" ++ song.s ++ ")" };

	stationProp station = { s = "station" ++ "(" ++ station.s ++ ")" };

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

}