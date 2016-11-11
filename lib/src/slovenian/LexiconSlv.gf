concrete LexiconSlv of Lexicon = CatSlv **
  open ParadigmsSlv, Prelude in {

flags
  optimize=values ;

lin
  airplane_N = mkN "letalo" "letala" "letalu" "letalo" "letalu" "letalom" "letali" "letal" "letaloma" "letali" "letalih" "letaloma" "letala" "letal" "letalom" "letala" "letalih" "letali" neuter ;
  apartment_N = mkN "stanovanje" "stanovanja" "stanovanju" "stanovanje" "stanovanju" "stanovanjem" "stanovanji" "stanovanj" "stanovanjema" "stanovanji" "stanovanjih" "stanovanjema" "stanovanja" "stanovanj" "stanovanjem" "stanovanja" "stanovanjih" "stanovanji" neuter ;
  apple_N = mkN "jabolko" "jabolka" "jabolku" "jabolko" "jabolku" "jabolkom" "jabolki" "jabolk" "jabolkoma" "jabolki" "jabolkih" "jabolkoma" "jabolka" "jabolk" "jabolkom" "jabolka" "jabolkih" "jabolki" neuter ;
  bank_N = mkN "banka" "banke" "banki" "banko" "banki" "banko" "banki" "bank" "bankama" "banki" "bankah" "bankama" "banke" "bank" "bankam" "banke" "bankah" "bankami" feminine ;
  beer_N = mkN "pivo" "piva" "pivu" "pivo" "pivu" "pivom" "pivi" "piv" "pivoma" "pivi" "pivih" "pivoma" "piva" "piv" "pivom" "piva" "pivih" "pivi" neuter ;
  big_A = mkA "velik" "večji" ;
  boat_N = mkN "čoln" "čolna" "čolnu" "čoln" "čolnu" "čolnom" "čolna" "čolnov" "čolnoma" "čolna" "čolnih" "čolnoma" "čolni" "čolnov" "čolnom" "čolne" "čolnih" "čolni" masculine ;
  buy_V2 = mkV2 (mkV "kupiti" "kupi") ;
  car_N = mkN "auto" masculine ;
  dog_N = mkN "pes" "psa" animate ;
  drink_V2 = mkV2 (mkV "piti" "pije" "pil") ;
  ear_N = mkN "uho" "ušesa" neuter ;
  flower_N = mkN "cvet" "cveta" "cvetovi" ;
  forest_N = mkN "gozd" "gozda" "gozdovi" ;
  girl_N = mkN "dekle" "dekleta" neuter ;
  green_A = mkA "zelen" "zelenejši" ;
  good_A = mkA "dober" "boljši" ;
  house_N = mkN "hiša" ;
  know_VS = mkVS (mkV "vedeti" "vedet" "vedel" "vedela" "vedeli" "vedela" "vedeli" "vedele" "vedelo" "vedeli" "vedela" "vem" "veš" "ve" "veva" "vesta" "vesta" "vemo" "veste" "vedo" "vediva" "vedimo" "vedi" "vedita" "vedite") ;
  love_V2 = mkV2 (mkV "ljubiti" "ljubi") ;
  man_N = mkN "fant" animate ;
  name_N = mkN "ime" "imena" neuter ;
  person_N = mkN "človek" "človeka" "človeku" "človeka" "človeku" "človekom" "človeka" "ljudi" "človekoma" "človeka" "ljudeh" "človekoma" "ljudje" "ljudi" "ljudem" "ljudi" "ljudeh" "ljudmi" animate ;
  red_A = mkA "rdeč" "rdeči" "rdečega" "rdečemu" "rdečega" "rdeč" "rdeči" "rdečem" "rdečim" "rdeča" "rdečih" "rdečima" "rdeča" "rdečih" "rdečima" "rdeči" "rdečih" "rdečim" "rdeče" "rdečih" "rdečimi" "rdeča" "rdeče" "rdeči" "rdečo" "rdeči" "rdečo" "rdeči" "rdečih" "rdečima" "rdeči" "rdečih" "rdečima" "rdeče" "rdečih" "rdečim" "rdeče" "rdečih" "rdečimi" "rdeče" "rdečega" "rdečemu" "rdeče" "rdečem" "rdečim" "rdeči" "rdečih" "rdečima" "rdeči" "rdečih" "rdečima" "rdeča" "rdečih" "rdečim" "rdeča" "rdečih" "rdečimi" nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist nonExist ;
  small_A = mkA "mali" "manjši" ;
  sleep_V = mkV "spati" "spi" "spal" ;
  sit_V = mkV "sedeti" "sedi" "sedel" ;
  tree_N = mkN "drevo" "drevesa" neuter ;
  walk_V = mkV "hoditi" "hodi" ;
  woman_N = mkN "ženska" ;
  write_V2 = mkV2 (mkV "pisati" "piše" "pisal");

} ;
