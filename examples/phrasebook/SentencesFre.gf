concrete SentencesFre of Sentences = NumeralFre ** SentencesI - [WhetherIs] 
  with 
    (DiffPhrasebook = DiffPhrasebookFre), 
    (Syntax = SyntaxFre) ** open SyntaxFre, ExtraFre in {

    lin WhetherIs item quality = 
      lin QS {s = \\_ => (EstcequeS (mkS (mkCl item quality))).s} ;

}
