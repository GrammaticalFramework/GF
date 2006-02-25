--# -path=.:resource-1.0/present:prelude:compiled

concrete BronzeageEng of Bronzeage = CatEng, SwadeshEng ** BronzeageI with
  (Lang = LangEng),
  (Swadesh = SwadeshEng) ;

