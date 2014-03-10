--# -path=.:../translator:../../../examples/phrasebook

concrete AppChi of App =
    NDTransChi
  , PhrasebookChi - [Ant,Pol,Tense,at_Prep]
              ** {

flags
  literal = Symb ;

lin
  PhrasePhr p = {s = "+" ++ p.s} | p ;

}