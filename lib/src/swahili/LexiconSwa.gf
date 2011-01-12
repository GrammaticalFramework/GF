--# -path=.:../abstract:../../prelude:../common
concrete LexiconSwa of Lexicon = CatSwa ** 
  open ParadigmsSwa, Prelude in {

flags 
  optimize=values ;

lin

  bird_N = regN "ndege" e_e animate;
  country_N = regN "nchi" e_e inanimate ;
  cousin_N = regN "binamu" e_ma animate;
  cow_N = regN "ngombe" e_e animate;
  doctor_N = regN "daktari" e_ma animate ;
  dog_N = regN "mbwa" e_e animate ;
  door_N = regN "mlango" m_mi inanimate;
  enemy_N = regN "adui" e_ma animate;
  father_N = regN "baba" e_e animate;
  fish_N = regN "samaki" e_e animate;
  friend_N = regN "rafiki" e_ma animate;
  garden_N = regN "shamba" e_ma inanimate;
  girl_N = regN "msichana" m_wa animate ;
  lamp_N = regN "taa" e_e inanimate ;
  man_N = regN "mwanaume" m_wa animate ;
  tree_N = regN "mti" m_mi inanimate ; 
  water_N = regN "maji" ma_ma inanimate ;
  woman_N = regN "mwanamke" m_wa animate ;
  ear_N = regN "sikio" e_ma inanimate ;
  eye_N = mkN "jicho" "macho" ji_ma inanimate ;
  fingernail_N = regN "ukucha" u_e inanimate ;  
  nose_N = regN "pua" e_ma inanimate;
  person_N = regN "mtu" m_wa animate ;
  road_N = regN "barabara" e_e inanimate;
  tooth_N = regN "jino" ji_ma inanimate ;
  wife_N = regN "bibi" e_ma animate ;
  river_N = regN "mto" m_mi inanimate ;
  
  come_V = regV "kuja";
  walk_V = regV "tembea";
  sleep_V = regV "lala";
  smell_V = regV "nuka";
  stand_V = regV "simama";
  stop_V = regV "simama";
  swell_V = regV "fura";
  swim_V = regV "ogelea";
  think_V = regV "waza";
  travel_V = regV "safiri";

  big_A = regA "kubwa";
  
  beautiful_A = regA "rembo" ;
  black_A = regA "eusi";
  blue_A = regA "buluu" ;
  broad_A = regA "pana" ; 
  brown_A = regA "hudhurungi" ;
  clean_A = regA "safi" ;
  clever_A = regA "hodari" ;
  cold_A = regA "baridi";
  correct_A = regA "sahihi" ;
  dirty_A = regA "chafu" ;
  dry_A = regA "kavu" ;
  dull_A = regA "liofifia" ;
  full_A = regA "tele" ;
  good_A = regA "zuri" ;
  green_A = regA "kijani";
  heavy_A = regA "zito" ;
  hot_A = regA "moto" ;
  important_A = regA "muhimu" ;
  long_A = regA "refu" ;
  narrow_A = regA "embamba" ;
  near_A = regA "karibu" ;
  new_A = regA "pya" ;
  old_A = regA "zee" ;
  ready_A = regA "tayari" ;
  red_A = regA "ekundu" ;
  rotten_A = regA "oza" ;
  round_A = regA "viringo" ;
  sharp_A = regA "kali" ;
  short_A = regA "fupi" ;
  small_A = regA "dogo" ;
  smooth_A = regA "laini" ;
  straight_A = regA "nyofu" ;
  stupid_A = regA "jinga" ;
  thick_A = regA "nene" ;
  thin_A = regA "embamba" ;
  ugly_A = regA "baya";
  certain_A = regA "hakika" ;
  warm_A = regA "fufutende" ;
  wet_A = regA "nyevu" ;
  white_A = regA "eupe" ;
  wide_A = regA "pana" ;
  yellow_A = regA "njano" ;
  young_A = regA "bichi" ;

  father_N2 = mkN2 (regN "baba" e_e animate) (mkPrep "ya") ;
  mother_N2 = mkN2 (regN "mama" e_e animate) (mkPrep "ya");
  brother_N2 = mkN2 (regN  "ndugu" e_e animate) (mkPrep "ya") ;

} ;
