--# -path=.:../translator:../../../examples/phrasebook

concrete AppFre of App =
    SmallPredFre
  , ExtensionsFre [CN,NP,AdA,AdV,CompoundCN,AdAdV,UttAdV,ApposNP]
  , DocumentationFre
  , DictionaryFre
  , PhrasebookFre - [open_A]

              ** {

flags
  literal = Symb ;

lin
  PhrasePhr p = {s = "+" ++ p.s} | p ;

}