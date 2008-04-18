--1 Text: Texts

-- Texts are built from an empty text by adding $Phr$ases,
-- using as constructors the punctuation marks ".", "?", and "!".
-- Any punctuation mark can be attached to any kind of phrase.

abstract Text = Common ** {

  fun
    TEmpty     : Text ;                 --
    TFullStop  : Phr -> Text -> Text ;  -- John walks. ...
    TQuestMark : Phr -> Text -> Text ;  -- Are you OK? ...
    TExclMark  : Phr -> Text -> Text ;  -- John walks! ...

}
