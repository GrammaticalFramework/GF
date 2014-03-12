--# -path=.:../translator:../../../examples/phrasebook

concrete AppSwe of App =
    SmallPredSwe
  , ExtensionsSwe [CN,NP,AdA,AdV,CompoundCN,AdAdV,UttAdV,ApposNP]
  , DocumentationSwe - [Pol,Tense]
  , DictionarySwe - [Pol,Tense]
  , PhrasebookSwe - [open_A]

              ** {

flags
  literal = Symb ;

lin
  PhrasePhr p = {s = "+" ++ p.s} | p ;

}