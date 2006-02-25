--# -path=.:present:prelude

concrete BronzeageEng of Bronzeage = CatEng, SwadeshEng ** BronzeageI with
  (Lang = LangEng),
  (Swadesh = SwadeshEng) ;

