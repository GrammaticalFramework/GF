abstract Translate = ParseEngAbs, Phrasebook ** {

flags startcat = Phrase ;

fun
  PPhr : Phr -> Phrase ;
  NP_Person : NP -> Person ;
  NP_Object : NP -> Object ;
  NP_Item   : NP -> Item ;
  NP_Place  : NP -> Place ;

}