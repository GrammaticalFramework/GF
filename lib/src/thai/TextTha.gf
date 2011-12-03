concrete TextTha of Text = CommonX ** open ResTha in {

-- No punctuation - but make sure to leave spaces between sentences!

  lin
    TEmpty = {s = []} ;
    TFullStop x xs = {s = x.s ++ "" ++ xs.s} ;
    TQuestMark x xs = {s = x.s ++ "" ++ xs.s} ;
    TExclMark x xs = {s = x.s ++ "" ++ xs.s} ;

}
