--# -path=.:prelude

concrete LexiconTur of Lexicon = CatTur ** 
  open ResTur, ParadigmsTur, Prelude in {
  
lin
  airplane_N = regN "uçak" ;
  apartment_N = regN "apartman" ;
  art_N = regN "sanat" ;
  beer_N = regN "bira" ;
  boat_N = regN "gemi" ;
  book_N = regN "kitap" ;
  boot_N = regN "ayakkabı" ;
  boss_N = regN "şef" ;
  bread_N = regN "ekmek" ;
  come_V = regV "gelmek" ;
  day_N = regN "gün" ;
  father_N2 = regN "baba" ;
  go_V = regV "gitmek" ;
  house_N = regN "ev" ;
  mother_N2 = regN "anne" ;
  run_V = regV "koşmek" ;
  stop_V = regV "durmak" ;
} ;
