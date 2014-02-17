resource HTML = open Prelude in {

  oper
    tag : Str -> Str = \t -> "<" + t + ">" ;
    endtag : Str -> Str = \t -> tag ("/" + t) ;
    intag : Str -> Str -> Str = \t,s -> tag t ++ s ++ endtag t ;
    intagAttr : Str -> Str -> Str -> Str = 
      \t,a,s -> ("<" + t) ++ (a + ">") ++ s ++ endtag t ;

-- common formatting

   document : Str -> Str = \s ->
     intag "html" (intag "head" ("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />") ++ intag "body" s) ;

   paragraph : Str -> Str = intag "p" ;
   heading1 : Str -> Str = intag "h1" ;
   heading2 : Str -> Str = intag "h2" ;
   heading3 : Str -> Str = intag "h3" ;
   heading4 : Str -> Str = intag "h4" ;

-- for building tables
   frameTable : Str -> Str = intagAttr "table" ("rules=all border=yes") ;
   tr : Str -> Str = intag "tr" ;  
   td : Str -> Str = intag "td" ;  
   th : Str -> Str = intag "th" ;  
}
