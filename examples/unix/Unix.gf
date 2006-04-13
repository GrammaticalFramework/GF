abstract Unix = Char ** {

  cat
    S ;           -- whole command line
    Command ;     -- one command
    File ;        -- file name
    Word ;        -- string e.g. in grep
    [Word] {1} ;  -- 

  fun

-- Catch-all: command dictated letter by letter.

    CommWords : [Word] -> Command ;

-- General command-line structure.

    Redirect : S -> File -> S ;     -- cs >f
    Pipe     : S -> Command -> S ;  -- cs | c
    Comm     : Command -> S ;       -- c

--- This would be cool, but is it supported by speech recognition?
---    CommOpt  : (c : Command) -> [Option c] -> S ;       -- c -o -k

    WhatTime   : Command ;
    WhatDate   : Command ;
    WhereNow   : Command ;
    Remove     : File -> Command ;
    Copy       : File -> File -> Command ;
    Linecount  : File -> Command ;
    Wordcount  : File -> Command ;
    Grep       : Word -> File -> Command ;
    Cat        : File -> Command ;

    It : File ;                  -- no file name - contents received from pipe

    FileChars : [Chr] -> File ;
    WordChars : [Chr] -> Word ;

    FileSuffix : Word -> File ;  -- *suff
    FilePrefix : Word -> File ;  -- pref*

}
