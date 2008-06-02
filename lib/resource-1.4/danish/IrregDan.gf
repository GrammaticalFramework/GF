--# -path=.:../scandinavian:../common:../abstract:../../prelude

-- http://users.cybercity.dk/~nmb3879/danishgram3.html

concrete IrregDan of IrregDanAbs = CatDan ** open Prelude, ParadigmsDan in {

  flags optimize=values ;

  lin

  bære_V = irregV "bære" "bar" "båret" ;
  bede_V = mkV "bede" "beder" "bedes" "bad" "bedt" "bed" ;
  bide_V = irregV "bite" "bed" "bidt" ;
  binde_V = irregV "binde" "bandt" "bundet" ;
  blive_V = irregV "blive" "blev" "blevet" ;
  brænde_V = irregV "brænde" "brandt" "brændt" ;--
  bringe_V = irregV "bringe" "bragte" "bragt" ;
  burde_V = irregV "burde" "burde" "burdet" ;--
  dø_V = irregV "dø" "døde" "død" ;
  drage_V = irregV "drage" "drog" "draget" ;
  drikke_V = irregV "drikke" "drak" "drukket" ;
  drive_V = irregV "drive" "drev" "drevet" ;
  falde_V = irregV "falde" "faldt" "faldet" ;----er
  få_V = irregV "få" "fik" "fået" ;
  finde_V = irregV "finde" "fandt" "fundet" ;
  flyde_V = irregV "flyde" "flød" "flydt" ;
  flyve_V = irregV "flyve" "fløj" "fløjet" ;
  forlade_V = irregV "forlade" "forlod" "forladet" ;
  forstå_V = irregV "forstå" "forstod" "forstået" ;
  fryse_V = irregV "fryse" "frøs" "frosset" ;
  gå_V = irregV "gå" "gik" "gået" ;----er
  give_V = irregV "give" "gav" "givet" ;
  gnide_V = irregV "gnide" "gned" "gnidd" ;--
  gøre_V = irregV "gøre" "gjorde" "gjort" ;
  have_V =  mkV "have" "har" "havde" "haft" "havd" "hav" ;
  hente_V = irregV "hente" "hentet" "hendt" ;--
--  hete_V = irregV "hete" (variants {"het" ;-- "hette"}) "hett" ;--
--  hjelpe_V = irregV "hjelpe" "hjalp" "hjulpet" ;--
  holde_V = irregV "holde" "holdt" "holdt" ;--
  komme_V = irregV "komme" "kom" "kommet" ;
  kunne_V = irregV "kunne" "kunne" "kunnet" ;
  lade_V = irregV "lade" "lod" "ladet" ;
  lægge_V = irregV "lægge" "lagde" "lagt" ;
  le_V = irregV "le" "lo" "leet" ;
  ligge_V = irregV "ligge" "lå" "ligget" ;
  løbe_V = irregV "løbe" "løb" "løbet" ;
  måtte_V = irregV "måtte" "måtte" "måttet" ;
  renne_V = irregV "renne" "rant" "rent" ;--
  sælge_V = irregV "sælge" "solgte" "solgt" ;
  sætte_V = irregV "sætte" "satte" "sat" ;
  se_V = irregV "se" "så" "set" ;
  sidde_V = irregV "sidde" "sad" "siddet" ;
  sige_V = irregV "sige" "sagde" "sagt" ;
  skære_V = irregV "skære" "skar" "skåret" ;--
  skrive_V = irregV "skrive" "skrev" "skrevet" ;
  skulle_V = irregV "skulle" "skulle" "skullet" ;
  slå_V = irregV "slå" "slog" "slått" ;--
  sove_V = irregV "sove" "sov" "sovet" ;
  spørge_V = irregV "spørge" "spurgte" "spurgt" ;
  springe_V = irregV "springe" "sprang" "sprunget" ;--
  stå_V = irregV "stå" "stod" "stået" ;
  stikke_V = irregV "stikke" "stakk" "stukket" ;--
  synge_V = irregV "synge" "sang" "sunget" ;--
  tage_V = irregV "tage" "tog" "taget" ;
--  treffe_V = irregV "treffe" "traff" "truffet" ;--
--  trives_V = irregV "trives" "trivdes" (variants {"trives" ;-- "trivs"}) ;--
  tælle_V = irregV "tælle" "talte" "talt" ;
  vide_V = irregV "vide" "vidste" "vidst" ;

}

-- readFile "vrbs.tmp" >>= mapM_ (putStrLn . (\ (a:_:b:c:_) -> "  " ++ a ++ "_V = irregV \"" ++ a ++ "\" \"" ++ b ++ "\" \"" ++ c ++ "\" ;") . words) . lines
