abstract Translate = ParseEngAbs, Phrasebook ** {

flags 
  startcat = Phrase ;
  heuristic_search_factor=0.60;
  meta_prob=1.0e-5;
  meta_token_prob=1.1965149246222233e-9;

fun
  PPhr : Phr -> Phrase ;
  NP_Person : NP -> Person ;
  NP_Object : NP -> Object ;
  NP_Item   : NP -> Item ;
  NP_Place  : NP -> Place ;

}