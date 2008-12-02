--# -path=.:present:prelude

concrete BronzeageSpa of Bronzeage = SwadeshSpa **  BronzeageI with
  (Syntax = SyntaxSpa) ** open ResSpa in {
  flags language = es_ES;
}

