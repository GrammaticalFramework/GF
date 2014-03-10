--# -path=.:../translator:../../../examples/phrasebook

concrete AppEng of App =
    NDTransEng
  , PhrasebookEng
              ** {

flags
  literal = Symb ;

lin
  PhrasePhr p = {s = "+" ++ p.s} | p ;

}