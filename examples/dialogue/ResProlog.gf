resource ResProlog = open Prelude in {

  oper
    bracket : Str -> Str = \s -> "[" ++ s ++ "]" ;

    app1 : Str -> Str -> Str = \f,x -> f ++ paren x ;

    apps : Str -> SS -> SS = \f,x -> ss (app1 f x.s) ;

    request : Str -> Str = app1 "request" ;
    answer  : Str -> Str = app1 "answer" ;

    req_ans : Str -> Str -> Str -> Str = \f,t,k ->
      bracket (request f ++ "," ++ answer (app1 t k)) ;

}

-- [request(add_event), answer(event_to_store(meeting))]
