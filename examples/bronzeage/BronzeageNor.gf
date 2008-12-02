--# -path=.:present:prelude

concrete BronzeageNor of Bronzeage = SwadeshNor **  BronzeageI with
  (Syntax = SyntaxNor) ** open ResNor in {
  flags language = nb_NO;
}
