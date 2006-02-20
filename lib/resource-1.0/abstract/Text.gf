--1 Texts

abstract Text = Cat ** {

  fun
    TEmpty : Text ;
    TFullStop : Phr -> Text -> Text ;
    TQuestMark : Phr -> Text -> Text ;
    TExclMark : Phr -> Text -> Text ;

}
