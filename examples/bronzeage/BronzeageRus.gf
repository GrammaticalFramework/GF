--# -path=.:minimal:present

concrete BronzeageRus of Bronzeage = SwadeshRus ** BronzeageI with
  (Syntax = SyntaxRus) ** open ResRus in {
  flags language = ru_RU;
}

