--# -path=.:prelude

concrete UnixEng of Unix = CharEng ** open Prelude in {

  flags lexer=text ;

{-
  lincat
    Line ;
    [Command] {1} ;
    Command ;
    File ;
-}

  lin
    CommWords w = w ;

    Redirect = infixSS (optStr "and" ++ ["write the result to"]) ;
    Pipe = infixSS "then" ;
    Comm c = c ;

    WhatTime = ss ["what time is it"] ;
    WhatDate = ss ["what date is it"] ;
    WhereNow = ss ["where am I now"] ;
    Remove = prefixSS "remove" ;
    Copy x y = ss ("copy" ++ x.s ++ "to" ++ y.s) ;
    Linecount = prefixSS ["how many lines has"] ;
    Wordcount = prefixSS ["how many words has"] ;
    Grep x y = ss (["show the lines containing"] ++ x.s ++ "in" ++ y.s) ;
    Cat = prefixSS ["show the contents of"] ;

    It = ss "it" ;

    FileChars = prefixSS (optStr ["the file"]) ;
    WordChars = prefixSS (optStr ["the word"]) ;

    FileSuffix = prefixSS ["all files ending with"] ;
    FilePrefix = prefixSS ["all files beginning with"] ;

    BaseWord w = w ;
    ConsWord = infixSS "space" ;

}
