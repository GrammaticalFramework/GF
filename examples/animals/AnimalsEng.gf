--# -path=.:present:prelude
--resource/english:resource/abstract:resource/../prelude

concrete AnimalsEng of Animals = QuestionsEng **
  open LangEng, ParadigmsEng, IrregEng in {

  lin
    Dog = regN "dog" ;
    Cat = regN "cat" ;
    Mouse = mk2N "mouse" "mice" ;
    Lion = regN "lion" ;
    Zebra = regN "zebra" ;
    Chase = dirV2 (regV "chase") ;
    Eat = dirV2 eat_V ;
    See = dirV2 see_V ;
}
