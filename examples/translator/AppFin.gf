--# -path=.:../finnish/stemmed:../finnish:../api:../translator:../../../examples/phrasebook:alltenses

concrete AppFin of App =
    SmallPredFin
  , ExtensionsFin [CN,NP,AdA,AdV,CompoundCN,AdAdV,UttAdV,ApposNP]
  , DocumentationFin - [Pol,Tense]
  , DictionaryFin - [Pol,Tense]
  , PhrasebookFin - [open_A]

              ** {

flags
  literal = Symb ;

lin
  PhrasePhr p = {s = "+" ++ p.s} | p ;

}