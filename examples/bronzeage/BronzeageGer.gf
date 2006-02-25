--# -path=.:resource-1.0/present:prelude:compiled

concrete BronzeageGer of Bronzeage = CatGer, SwadeshGer **  BronzeageI with
  (Lang = LangGer),
  (Swadesh = SwadeshGer) ;

