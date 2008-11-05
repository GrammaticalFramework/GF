--# -path=.:present

concrete BronzeageFin of Bronzeage = SwadeshFin **  BronzeageI with
  (Syntax = SyntaxFin) ** open ResFin in {
  flags language = fi_FI;
}


