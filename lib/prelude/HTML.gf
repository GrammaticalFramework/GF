resource HTML = open Prelude in {
  oper
    tag : Str -> Str = \t -> "<" + t + ">" ;
    endtag : Str -> Str = \t -> tag ("/" + t) ;
    intag : Str -> Str -> Str = \t,s -> tag t ++ s ++ endtag t ;
    intagAttr : Str -> Str -> Str -> Str = 
      \t,a,s -> ("<" + t) ++ (a + ">") ++ s ++ endtag t ;
}
