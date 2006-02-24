--# -path=.:compiled:prelude:resource-1.0/swadesh

concrete BronzeageEng of Bronzeage = CatEng, SwadeshEng ** BronzeageI with
  (Lang = LangEng),
  (Swadesh = SwadeshEng) ;

