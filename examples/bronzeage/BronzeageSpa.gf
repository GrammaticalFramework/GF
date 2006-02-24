--# -path=.:compiled:prelude:resource-1.0/swadesh

concrete BronzeageSpa of Bronzeage = CatSpa, SwadeshSpa **  BronzeageI with
  (Lang = LangSpa),
  (Swadesh = SwadeshSpa) ;

