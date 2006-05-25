--# -path=.:../scandinavian:../common:../abstract:../../prelude

-- http://users.cybercity.dk/~nmb3879/danishgram3.html

concrete IrregDan of IrregDanAbs = CatDan ** open Prelude, ParadigmsDan in {

  flags optimize=values ;

  lin

  bære_V = irregV "bære" "bar" "båret" ;--
  bede_V = mkV "bede" "beder" "bedes" "bad" "bedt" "bed" ;--
  bide_V = irregV "bite" "bed" "bitt" ;--
  blive_V = irregV "blive" "blev" "blevet" ;
  brænde_V = irregV "brænde" "brant" "brænt" ;--
  bringe_V = irregV "bringe" "bragte" "bragt" ;--
  burde_V = irregV "burde" "burde" "burdet" ;--
  dø_V = irregV "dø" "døde" "død" ;
--  dra_V = mkV "dra" "drar" "dras" "drog" (variants {"dradd" ;-- "dratt"}) "dra" ;--
  drikke_V = irregV "drikke" "drak" "drukket" ;
--  drive_V = irregV "drive" (variants {"drev" ;-- "dreiv"}) "drevet" ;--
--  eie_V = irregV "eie" (variants {"eide" ;-- "åtte"}) (variants {"eid" ;-- "ått"}) ;--
  falle_V = irregV "falle" "falt" "falt" ;--
  få_V = irregV "få" "fik" "fået" ;
  finde_V = irregV "finde" "fand" "fundet" ;--
  flyde_V = irregV "flyde" "flød" "flytt" ;--
  flyve_V = irregV "flyve" "fløg" "flydd" ;--
  foretrekke_V = irregV "foretrekke" "foretrakk" "foretrukket" ;--
  forlade_V = irregV "forlade" "forlod" "forladet" ;
  forstå_V = irregV "forstå" "forstod" "forstått" ;--
  fortælle_V = irregV "fortælle" "fortalte" "fortalt" ;--
  fryse_V = irregV "fryse" "frøs" "frosset" ;--
  gå_V = irregV "gå" "gik" "gået" ;
  give_V = irregV "give" "gav" "givet" ;
--  gjelde_V = irregV "gjelde" (variants {"gjaldt" ;-- "galdt"}) "gjeldt" ;--
  gnide_V = irregV "gnide" "gned" "gnidd" ;--
  gøre_V = irregV "gøre" "gjorde" "gjort" ;
  have_V =  mkV "have" "har" "havde" "haft" nonExist "hav" ;
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
  vide_V = irregV "vide" "vidste" "vidst" ;

}

-- readFile "vrbs.tmp" >>= mapM_ (putStrLn . (\ (a:_:b:c:_) -> "  " ++ a ++ "_V = irregV \"" ++ a ++ "\" \"" ++ b ++ "\" \"" ++ c ++ "\" ;") . words) . lines