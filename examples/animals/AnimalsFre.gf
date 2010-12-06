--# -path=.:present

concrete AnimalsFre of Animals = QuestionsFre **
  open SyntaxFre, ParadigmsFre, IrregFre in {

  lin
    Dog   = mkN "chien" ;
    Cat   = mkN "chat" ;
    Mouse = mkN "souris" feminine ;
    Lion  = mkN "lion" masculine ;
    Zebra = mkN "zèbre" masculine ;
    Chase = mkV2 (mkV "chasser") ;
    Eat   = mkV2 (mkV "manger") ;
    See   = voir_V2 ;
}
