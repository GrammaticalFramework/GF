--# -path=.:present:prelude

concrete AnimalsFre of Animals = QuestionsFre **
  open LangFre, ParadigmsFre, IrregFre in {

  lin
    Dog   = regN "chien" ;
    Cat   = regN "chat" ;
    Mouse = regGenN "souris" feminine ;
    Lion  = mkN "lion" masculine ;
    Zebra = regGenN "zèbre" masculine ;
    Chase = dirV2 (regV "chasser") ;
    Eat   = dirV2 (regV "manger") ;
    See   = voir_V2 ;
}
