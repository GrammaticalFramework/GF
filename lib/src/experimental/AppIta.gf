--# -path=.:../translator:../../../examples/phrasebook

concrete AppIta of App =
    SmallPredIta
  , ExtensionsIta [CN,NP,AdA,AdV,CompoundCN,AdAdV,UttAdV,ApposNP]
  , DocumentationIta
  , DictionaryIta
  , PhrasebookIta - [open_A]

              ** {

flags
  literal = Symb ;

lin
  PhrasePhr p = {s = "+" ++ p.s} | p ;

}