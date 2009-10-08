interface ParamSammie = open Syntax in {

oper 
  song_N, track_N, album_N, record_N, cd_N, 
    playlist_N, artist_N, number_N, rock_N : N ;
  new_A : A ;

  add_V3, remove_V3, show_V3 : V3 ;
  tell_V2Q, show_V2Q : V2Q ;
  create_V2, play_V2, return_V2, goto_V2, 
    record_V2, make_V2 : V2 ;
  stop_V : V ;

  back_Adv : Adv ;

  what_IAdv : IAdv ;

  previous_A, next_A : A ;
  please_PConj : PConj ;

  mainmenu_NP : NP ;

  goback_VP : VP ;
  shutup_VP : VP ;
  pause_VP  : VP ;
  resume_VP : VP ;

  whatever_Utt : Utt ;

  typeWithGenre : CN -> CN -> CN ;

  name : Str -> PN ;

  WhatName : NP -> QCl ;

  past : Tense * Ant ;

  imperative : VP -> Utt ;

  previous, next : CN -> NP ;

  what_say : Utt ;
  all_art : Quant ;

  this : CN -> NP ;

}
