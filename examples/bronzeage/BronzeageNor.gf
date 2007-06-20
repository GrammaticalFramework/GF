--# -path=.:present:prelude

concrete BronzeageNor of Bronzeage = CatNor, SwadeshNor **  BronzeageI with
  (Lang = LangNor) ** {
  flags language = nb_NO;
}
