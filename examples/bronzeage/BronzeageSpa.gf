--# -path=.:resource-1.0/present:prelude:compiled

concrete BronzeageSpa of Bronzeage = CatSpa, SwadeshSpa **  BronzeageI with
  (Lang = LangSpa),
  (Swadesh = SwadeshSpa) ;

