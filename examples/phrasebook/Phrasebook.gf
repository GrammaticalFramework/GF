abstract Phrasebook = 
  Greetings,
  Words
  ** {

flags startcat = Phrase ;

cat 
  Politeness ; Gender ; -- abstract parameters
fun

-- here rather than Sentences, because not functorial
  PSentence : Sentence -> Phrase ;
  PQuestion : Question -> Phrase ;
  PGreeting : Greeting -> Phrase ;
----  PGreeting : Politeness -> Gender -> Gender -> Greeting -> Phrase ;
              -- politeness level, speaker, hearer

  Polite, Familiar : Politeness ;
  Male, Female : Gender ;

}
