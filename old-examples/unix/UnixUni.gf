--# -path=.:prelude

concrete UnixUni of Unix = CharUni ** open Prelude in {

  flags unlexer=bind ;

{-
  lincat
    Line ;
    [Command] {1} ;
    Command ;
    File ;
-}

  lin
    CommWords w = w ;

    Redirect = infixSS ">" ;
    Pipe = infixSS "|" ;
    Comm c = c ;

    WhatTime = ss ["date +%D"] ;
    WhatDate = ss ["date +%T"] ;
    WhereNow = ss ["pwd"] ;
    Remove = prefixSS "rm" ;
    Copy x y = ss ("cp" ++ x.s ++ y.s) ;
    Linecount = prefixSS ["wc -l"] ;
    Wordcount = prefixSS ["wc -w"] ;
    Grep x y = ss ("grep" ++ x.s ++ y.s) ;
    Cat = prefixSS "cat" ;

    It = ss [] ;

    FileChars c = c ;
    WordChars c = c ;

    FileSuffix = prefixSS ["* &+"] ;
    FilePrefix = postfixSS ["&+ *"] ;

    BaseWord w = w ;
    ConsWord = cc2 ;

}
