--# -path=.:present

concrete BronzeageEng of Bronzeage = SwadeshEng ** BronzeageI with
  (Syntax = SyntaxEng) ** open ResEng in {
  flags language = en_US;
}

