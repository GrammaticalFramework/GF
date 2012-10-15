concrete TextChi of Text = CommonX - [Temp,Tense,Adv] ** open ResChi in {

-- No punctuation - but make sure to leave spaces between sentences!

  lin
    TEmpty = {s = []} ;
    TFullStop x xs = {s = x.s ++ fullstop_s ++ xs.s} ;
    TQuestMark x xs = {s = x.s ++ questmark_s ++ xs.s} ;
    TExclMark x xs = {s = x.s ++ exclmark_s ++ xs.s} ;

}
