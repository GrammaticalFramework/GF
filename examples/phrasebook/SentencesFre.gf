concrete SentencesFre of Sentences = NumeralFre ** SentencesI - [WhetherIs, QAction] 
  with 
    (DiffPhrasebook = DiffPhrasebookFre), 
    (Syntax = SyntaxFre) ** open SyntaxFre, ExtraFre in {

    lin 
      WhetherIs item quality = 
        {s = \\_ => lin QS {s = \\_ => (EstcequeS (mkS (mkCl item quality))).s}} ;
      QAction a = 
        {s = \\r => lin QS {s = \\_ => (EstcequeS (mkS (a.s ! r))).s}} ;

}
