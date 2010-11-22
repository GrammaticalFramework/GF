concrete TicketEng of Ticket = {

lincat
  Request, Station = Str ;
lin 
  Ticket X Y = 
    ((("I" ++ ("would like" | "want") ++ "to get" |
      ("may" | "can") ++ "I get" | 
      "can you give me" |
      []) ++ 
        "a ticket") | 
     []) ++ 
     "from" ++ X ++ "to" ++ Y ++ 
     ("please" | []) ;

  Hamburg = "Hamburg" ;
  Paris = "Paris" ;

}
