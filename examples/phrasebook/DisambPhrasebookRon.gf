--# -path=.:present

concrete DisambPhrasebookRon of Phrasebook = PhrasebookRon - 
   [PSentence, PQuestion, ObjIndef
   ] 
  ** open SyntaxRon, Prelude in {
lin
    PSentence s = mkText s ;  -- punctuation not optional
    PQuestion s = mkText s ;
    ObjIndef k = mkNP someSg_Det k ;
}
