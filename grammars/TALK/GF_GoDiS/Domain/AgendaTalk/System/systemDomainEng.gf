--# -path=.:../:../DBase/English:../DBase:../Shared:../System:../Numbers


concrete systemDomainEng of systemDomain = sharedDomainEng, systemCoreEng ** {


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

	askArtist = "songs" ; 
		

	askSong = "artist" ; 
	askCurrent = ["the current song"];


}


