--# -path=.:../translator:../../../examples/phrasebook

concrete AppEng of App =
    SmallPredEng
  , ExtensionsEng [CN,NP,AdA,AdV,CompoundCN,AdAdV,UttAdV,ApposNP]
  , DocumentationEng - [Pol,Tense]
  , DictionaryEng - [Pol,Tense]

  , PhrasebookEng

              ** {

flags
  literal = Symb ;

lin
  PhrasePhr p = {s = "+" ++ p.s} | p ;

}