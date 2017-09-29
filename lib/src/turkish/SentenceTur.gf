concrete SentenceTur of Sentence = CatTur ** open Prelude, ResTur in {

  lin

    PredVP np vp = mkClause (np.s ! Nom) np.a vp ;

    -- TODO: Check how correct this is.
    EmbedVP vp = {s = (vp.s ! Gerund Sg Acc)} ;

}
