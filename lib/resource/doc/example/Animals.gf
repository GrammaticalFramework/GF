abstract Animals = {
  cat 
    Phrase ; Animal ; Action ;
  fun
    Who    : Action -> Animal -> Phrase ;
    Whom   : Animal -> Action -> Phrase ;
    Answer : Animal -> Action -> Animal -> Phrase ;

    Dog, Cat, Mouse, Lion, Zebra : Animal ;
    Chase, Eat, Like : Action ;
}

