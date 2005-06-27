--# -path=.:../:../../:../Shared/:../../../Resource/Media/:../../../Resource/Media/Swedish/:../../../Resource/Numbers/:../../../Core:../../../Core/Shared/

concrete sharedDomainSwe of sharedDomain = sharedCoreSwe, DBSwe ** open SpecResSwe in{


flags conversion=finite;


lin
	-- ANSWERS
	answerSongPlay song = {s = variants { 
					(                      song.s );
					( (itemForm ! Song) ++ song.s )
				}
		  };
	answerSongAdd song = {s = variants { 
					(                      song.s );
					( (itemForm ! Song) ++ song.s )
				}
		  };
	answerSongRemove song = {s = variants { 
					(                      song.s );
					( (itemForm ! Song) ++ song.s )
				}
		  };
	questionSong song = {s = variants { 
					(                      song.s );
					( (itemForm ! Song) ++ song.s )
				}
		  };



	answerArtistPlay artist = {s = variants {
				     (                        artist.s );
				     ( (itemForm ! Artist) ++ artist.s )
				    }
		      };
	answerArtistAdd artist = {s = variants {
				     (                        artist.s );
				     ( (itemForm ! Artist) ++ artist.s )
				    }
		      };
	answerArtistRemove artist = {s = variants {
				     (                        artist.s );
				     ( (itemForm ! Artist) ++ artist.s )
				    }
		      };
	questionArtist artist = { s = variants {
				     (                        artist.s );
				     ( (itemForm ! Artist) ++ artist.s )
				    }
		      };



	answerStationPlay station = {s = variants {
					(			station.s);
					( "stationen" ++ station.s)
						}
		      };
	answerStationAdd station = {s = variants {
					(			station.s);
					( "stationen" ++ station.s)
						}
		      };
	answerStationRemove station = {s = variants {
					(			station.s);
					( "stationen" ++ station.s)
						}
		      };


	
	-- LIST RELATED ANSWERS

	-- nummer fem
	-- fem
	answerNumberInListPlay numb = {s = variants {
					( (listForm ! Numeric) ++ numb.s ); 
					(                         numb.s )
				     }
			};

	answerNumberInListRemove numb = {s = variants {
					( (listForm ! Numeric) ++ numb.s ); 
					(                         numb.s )
				     }
			};


	-- den femte låten
	-- den femte
	answerOrderInListPlay ordNum = 
		{s = variants {
				("den" ++ ordNum.s ++ (itemForm ! Post));
				("den" ++ ordNum.s)
			      }
		};
	answerOrderInListRemove ordNum = 
		{s = variants {
				("den" ++ ordNum.s ++ (itemForm ! Post));
				("den" ++ ordNum.s)
			      }
		};


-- LEXICON

pattern
	
	play_spec = (variants {["spela"] ; ["starta"] ; ["höra"] ; ["lyssna på"]});
	play_spec_alone = variants {["spela"] ; ["spela den här"] ; ["spela den"] ; ["spela en speciell"] ; ["spela en speciell låt"]};
	play = (variants {["spela från början"] ; ["spela"] ; ["starta"]});
	stop = (variants {["stoppa"] ; ["avbryta"]});
	pause = (variants {["pausa"] });
	resume = (variants {["återuppta spelningen"] ; ["starta igen"]});

	next = "nästa";
	previous = "föregående";

	raise_volume	= "höja" ++ variants { ("volymen") ; ("ljudet")};
	lower_volume	= "sänka" ++ variants { ("volymen") ; ("ljudet")}; 

	
	fastforward	= ["spola framåt"];
	rewind		= ["spola bakåt"];


	shift = variants{ ["ändra balansen"] ; "skifta"};
	right = variants{"" ; "till"} ++ "höger";
	left = variants{"" ; "till"} ++ "vänster";
	center = variants{"" ; "till"} ++ "mitten";

	show_list = ["visa listan"];

	add = ["lägga till"];
	add_alone = variants {["lägga till"]; ["lägg till den här"] ; ["lägg till den"]};
	remove = ["ta bort"];
	remove_alone = variants { ["ta bort"] ; ["ta bort den"] ; ["ta bort den här"] };

	remove_all = variants {["rensa listan"] ; ["ta bort allt"]};

	handle_list 		= ["ändra i spellistan"];
	handle_player 		= ["prata med spelaren"];
	handle_stations 	= ["välja en radiostation"];



	-- FLYTTAT TILL userSpecificSwe.gf och systemSpecificSwe.gf pga 
	-- olika linearisering for system och användare.

	--askArtist = variants { "låtar" ; 
	--	variants { variants {"vad" ; ["vilka låtar"]} ++ ["har jag"] ; 
	--		["har jag någonting"]} ++ variants {"med" ; "av"}};


	--askSong = variants { "artister" ; (["vem har"] ++ variants {"skrivit"; "gjort"})};

	--askCurrent = ["vad heter"] ++ variants {["den här"] ; ["låten som spelas nu"]};

}








