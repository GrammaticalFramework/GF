concrete HelloIta of Hello = {

  lincat Greeting, Recipient = {s : Str} ;

  lin 
    Hello rec = {s = "ciao" ++ rec.s} ;
    World = {s = "mondo"} ;
    Mum = {s = "mamma"} ;
    Friends = {s = "amici"} ;
}