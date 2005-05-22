--# -path=.:resource/french:resource/romance:resource/abstract:resource/../prelude

concrete AnimalsFre of Animals = QuestionsFre **
  open ResourceFre, ParadigmsFre, VerbsFre in {

  lin
    Dog   = regN "chien" masculine ;
    Cat   = regN "chat" masculine ;
    Mouse = regN "souris" feminine ;
    Lion  = regN "lion" masculine ;
    Zebra = regN "zèbre" masculine ;
    Chase = dirV2 (regV "chasser") ;
    Eat   = dirV2 (regV "manger") ;
    Like  = dirV2 (regV "aimer") ;
}
