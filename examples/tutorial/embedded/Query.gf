abstract Query = {

  flags startcat=Question ;

  cat 
    Answer ; Question ; Object ;

  fun 
    Even   : Object -> Question ;
    Odd    : Object -> Question ;
    Prime  : Object -> Question ;
    Number : Int -> Object ;

    Yes : Answer ;
    No  : Answer ;
}

