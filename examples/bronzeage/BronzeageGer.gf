--# -path=.:present

concrete BronzeageGer of Bronzeage = SwadeshGer **  BronzeageI with
  (Syntax = SyntaxGer) ** open ResGer in {
  flags language = de_DE;
}


