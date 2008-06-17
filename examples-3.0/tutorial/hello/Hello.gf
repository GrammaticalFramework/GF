abstract Hello = {

  cat Greeting ; Recipient ;

  flags startcat = Greeting ;

  fun 
    Hello : Recipient -> Greeting ;
    World, Mum, Friends : Recipient ;
}