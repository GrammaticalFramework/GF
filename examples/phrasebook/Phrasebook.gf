abstract Phrasebook = 
  Greetings,
  Food
  ** {

flags startcat = Phrase ;

cat 
  Phrase ;
  Politeness ; Gender ; -- abstract parameters
fun
  PNumeral  : Numeral -> Phrase ;
  PSentence : Sentence -> Phrase ;

  PGreeting : Greeting -> Phrase ;
----  PGreeting : Politeness -> Gender -> Gender -> Greeting -> Phrase ;
              -- politeness level, speaker, hearer

  Polite, Familiar : Politeness ;
  Male, Female : Gender ;

}
