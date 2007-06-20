--# -path=.:present:prelude

concrete BronzeageRus of Bronzeage = CatRus, SwadeshRus ** BronzeageI with
  (Lang = LangRus) ** {
  flags language = ru_RU;
}

