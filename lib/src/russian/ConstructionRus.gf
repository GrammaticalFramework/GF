concrete ConstructionRus of Construction = CatRus **
  open SyntaxRus, ParadigmsRus, ResRus in {

lin
  hungry_VP = mkVP (mkA "голодный") ;
  thirsty_VP = mkVP want_VV (mkVP (regV imperfective firstE "пь" "ю" "пил" "пей" "пить")) ;
  tired_VP = mkVP (mkA "уставший" Rel) ;
  scared_VP = mkVP (mkV imperfective "боюсь" "боишься" "боится" "боимся" "бойтесь" "боятся" "боялся" "бойся" "бояться") ;
  ill_VP = mkVP (mkA "больной") ;
  ready_VP = mkVP (mkA "готовый") ;

}
