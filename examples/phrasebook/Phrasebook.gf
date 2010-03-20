abstract Phrasebook = 
  Greetings,
  Food
  ** {

flags startcat = Phrase ;

cat 
  Phrase ;
fun
  PNumeral  : Numeral -> Phrase ;
  PGreeting : Greeting -> Phrase ;
  PSentence : Sentence -> Phrase ;


}
