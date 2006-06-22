-- Simple questions and answers, in present tense.

abstract Questions = {
  cat 
    Phrase ; Entity ; Action ;
  fun
    Who    : Action -> Entity -> Phrase ;           -- who chases X
    Whom   : Entity -> Action -> Phrase ;           -- whom does X chase
    Answer : Entity -> Action -> Entity -> Phrase ; -- X chases Y
}
