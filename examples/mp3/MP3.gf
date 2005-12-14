abstract MP3 = {
  cat
    Move ;
    Song ;

  fun
    Play      : Song -> Move ;
    CanPlay   : Song -> Move ;
    WantPlay  : Song -> Move ;
    WhichPlay : Move ;

    ThisSong : Song ;
    This   : Song ;

    Yesterday : Song ;

----    MkSong : String -> Song ;

}
