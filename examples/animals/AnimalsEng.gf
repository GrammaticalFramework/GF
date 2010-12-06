--# -path=.:present

concrete AnimalsEng of Animals = QuestionsEng **
  open SyntaxEng, ParadigmsEng, IrregEng in {

  lin
    Dog = mkN "dog" ;
    Cat = mkN "cat" ;
    Mouse = mkN "mouse" "mice" ;
    Lion = mkN "lion" ;
    Zebra = mkN "zebra" ;
    Chase = mkV2 "chase" ;
    Eat = mkV2 eat_V ;
    See = mkV2 see_V ;
}
