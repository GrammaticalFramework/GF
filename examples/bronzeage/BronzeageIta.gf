--# -path=.:present

concrete BronzeageIta of Bronzeage = SwadeshIta ** BronzeageI with
  (Syntax = SyntaxIta) ** open ResIta in {
  flags language = en_US;
}

