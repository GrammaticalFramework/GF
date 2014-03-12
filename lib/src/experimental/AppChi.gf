--# -path=.:../translator:../../../examples/phrasebook

concrete AppChi of App =
    SmallPredChi
  , ExtensionsChi [CN,NP,AdA,AdV,CompoundCN,AdAdV,UttAdV,ApposNP]
  , DocumentationChi - [Pol,Tense,Ant]
  , DictionaryChi - [Pol,Tense,Ant]
  , PhrasebookChi - [Ant,Pol,Tense,at_Prep]

              ** {

flags
  literal = Symb ;

lin
  PhrasePhr p = {s = "+" ++ p.s} | p ;

}


