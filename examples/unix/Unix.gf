abstract Unix = {

  cat
    S ;
    Line ;
    Command ;
    File ;

  fun
    Pipe : Command -> S -> S ;
    Comm : Command -> S ;

    WhatTime   : Command ;
    WhatDate   : Command ;
    WhereNow   : Command ;
    Remove : File -> Command ;
    Copy   : File -> File -> Command ;
    Linecount : File -> Command ;
    Wordcount : File -> Command ;

    Name : String -> File ;
    It : File ;

}
