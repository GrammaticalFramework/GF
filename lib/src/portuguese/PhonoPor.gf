resource PhonoPor = open Prelude in {

  oper
    arts : pattern Str = #("o" | "os" | "a" | "as") ;

    elisDe : Str ;
    elisDe = pre {
      #arts => "d" ++ BIND ;
      _ => "de"
      } ;

} ;
