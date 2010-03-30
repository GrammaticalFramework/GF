abstract Phrasebook = 
  Greetings,
  Words
  ** {

flags startcat = Phrase ;

fun

-- here rather than Sentences, because not functorial
  PGreeting : Politeness -> Greeting -> Phrase ;
----  PGreeting : Politeness -> Gender -> Gender -> Greeting -> Phrase ;
              -- politeness level, speaker, hearer

}
