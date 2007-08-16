concrete HelloEng of Hello = {

  lincat Greeting, Recipient = {s : Str} ;

  lin 
    Hello rec = {s = "hello" ++ rec.s} ;
    World = {s = "world"} ;
    Mum = {s = "mum"} ;
    Friends = {s = "friends"} ;
}