--# -path=.:prelude

concrete LexiconTur of Lexicon = CatTur ** 
  open ResTur, ParadigmsTur, Prelude in {
  
lin
  come_V = regV "gelmek" ;
  go_V = regV "gitmek" ;
  run_V = regV "koşmek" ;
  stop_V = regV "durmak" ;
} ;
