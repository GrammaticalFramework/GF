--# -path=.:present:prelude

concrete AnimalsSwe of Animals = QuestionsSwe **
  open LangSwe, ParadigmsSwe, IrregSwe in {

  lin
    Dog = regN "hund" utrum ;
    Cat = mk2N "katt" "katter" ;
    Mouse = mkN "mus" "musen" "möss" "mössen" ;
    Lion = mk2N "lejon" "lejon" ;
    Zebra = regN "zebra" utrum ;
    Chase = dirV2 (regV "jaga") ;
    Eat = dirV2 äta_V ;
    See = dirV2 se_V ;
}
