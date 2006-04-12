--# -path=.:prelude

concrete UnixUni of Unix = open Prelude in {

  flags unlexer=codelit ; lexer=codelit ;

{-
  lincat
    Line ;
    [Command] {1} ;
    Command ;
    File ;
-}

  lin
    Pipe = infixSS "|" ;
    Comm c = c ;

    WhatTime = ss ["date +%D"] ;
    WhatDate = ss ["date +%T"] ;
    WhereNow = ss ["pwd"] ;
    Remove = prefixSS "rm" ;
    Copy x y = ss ("cp" ++ x.s ++ y.s) ;
    Linecount = prefixSS ["wc -l"] ;
    Wordcount = prefixSS ["wc -w"] ;

    Name x = x ;
    It = ss [] ;

}
