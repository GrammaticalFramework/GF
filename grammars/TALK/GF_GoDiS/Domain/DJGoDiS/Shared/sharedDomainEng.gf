--# -path=.:../:../../:../Shared/:../../../Resource/Media/:../../../Resource/Media/English/:../../../Resource/Numbers/:../../../Core:../../../Core/Shared/

concrete sharedDomainEng of sharedDomain = sharedCoreEng, DBEng ** 
		open SpecResEng in {

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
					( ["the station"] ++ station.s)
						}
		      };
	answerStationAdd station = {s = variants {
					(			station.s);
					( ["the station"] ++ station.s)
						}
		      };
	answerStationRemove station = {s = variants {
					(			station.s);
					( ["the station"] ++ station.s)
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
				("the" ++ ordNum.s ++ (itemForm ! Post));
				("the" ++ ordNum.s)
			      }
		};
	answerOrderInListRemove ordNum = 
		{s = variants {
				("the" ++ ordNum.s ++ (itemForm ! Post));
				("the" ++ ordNum.s)
			      }
		};


-- LEXICON

pattern
	
	play_spec = (variants {["play"] ; ["listen to"] ; "hear"});
	play_spec_alone = variants {["play a specific song"] ; ["play a specific"] ; ["listen to a specific song"] ; ["hear a specific song"]};
	play = (variants {["start from the beginning"] ; ["play"] ; ["start"]});
	stop = (variants {["stop"]});
	pause = ["pause"];
	resume = (variants {["resume"] ; ["resume playing"]});

	next = "next";
	previous = "previous";

	raise_volume	= ["raise the volume"] ;
	lower_volume	= ["lower the volume"]; 

	fastforward	= ["fast forward"];
	rewind		= "rewind";

	shift = "shift" ++ variants{ ["the balance"] ; ""};
	right = variants{"" ; ["to the"]} ++ "right";
	left = variants{"" ; ["to the"]} ++ "left";
	center = variants{"" ; ["to the"]} ++ "middle";

	show_list = ["show the list"];

	add = ["add"];
	add_alone = variants {["add a specific song"] ; ["add this"] ; ["add this one"]};
	remove = ["remove"];
	remove_alone = variants {["remove"] ; ["renmove this"] ; ["remove this one"]};

	remove_all = ["clear the playlist"];

	handle_list 		= ["manage the playlist"];
	handle_player 		= ["talk to the player"];
	handle_stations 	= ["choose a station"];
}








