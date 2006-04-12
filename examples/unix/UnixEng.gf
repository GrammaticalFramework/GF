--# -path=.:prelude

concrete UnixEng of Unix = open Prelude in {

  flags unlexer=textlit ; lexer=textlit ;

{-
  lincat
    Line ;
    [Command] {1} ;
    Command ;
    File ;
-}

  lin
    Pipe = infixSS "then" ;
    Comm c = c ;

    WhatTime = ss ["what time is it"] ;
    WhatDate = ss ["what date is it"] ;
    WhereNow = ss ["where am I now"] ;
    Remove = prefixSS "remove" ;
    Copy x y = ss ("copy" ++ x.s ++ "to" ++ y.s) ;
    Linecount = prefixSS ["how many lines has"] ;
    Wordcount = prefixSS ["how many words has"] ;

    Name x = x ;
    It = ss "it" ;

}
