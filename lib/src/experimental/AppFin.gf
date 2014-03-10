--# -path=.:../finnish/stemmed:../finnish:../api:../translator:../../../examples/phrasebook:alltenses

concrete AppFin of App =
    NDTransFin
  , PhrasebookFin
              ** {

flags
  literal = Symb ;

lin
  PhrasePhr p = {s = "+" ++ p.s} | p ;

}