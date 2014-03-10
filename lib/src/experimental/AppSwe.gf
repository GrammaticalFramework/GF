--# -path=.:../translator:../../../examples/phrasebook

concrete AppSwe of App =
    NDTransSwe
  , PhrasebookSwe - [open_A]
              ** {

flags
  literal = Symb ;

lin
  PhrasePhr p = {s = "+" ++ p.s} | p ;

}