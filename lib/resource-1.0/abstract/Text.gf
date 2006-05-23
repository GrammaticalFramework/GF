--1 Texts

abstract Text = Common ** {

  fun
    TEmpty : Text ;
    TFullStop : Phr -> Text -> Text ;
    TQuestMark : Phr -> Text -> Text ;
    TExclMark : Phr -> Text -> Text ;

}
