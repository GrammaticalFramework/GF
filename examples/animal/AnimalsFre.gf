--# -path=.:present:prelude

concrete AnimalsFre of Animals = QuestionsFre **
  open LangFre, ParadigmsFre, IrregFre in {

  lin
    Dog   = regN "chien" masculine ;
    Cat   = regN "chat" masculine ;
    Mouse = regN "souris" feminine ;
    Lion  = regN "lion" masculine ;
    Zebra = regN "zèbre" masculine ;
    Chase = dirV2 (regV "chasser") ;
    Eat   = dirV2 (regV "manger") ;
    See   = voir_V2 ;
}
