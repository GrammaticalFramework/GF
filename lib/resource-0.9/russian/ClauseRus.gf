--# -path=.:../abstract:../../prelude

concrete ClauseRus of Clause = CategoriesRus **
  ClauseI with (Rules=RulesRus), (Verbphrase=VerbphraseRus) ;
