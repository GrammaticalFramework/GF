--# -path=alltenses

concrete TestHeb of Test = GrammarHeb ** open ResHeb in  {

flags
  coding=utf8 ;

lin
  man_N = mkN "Ays" "AnsyM" Masc;
  woman_N = mkN "Aysh" "nsyM" Fem ;
  house_N = mkN  "byt" "btyM" Masc; 
  leg_N = mkN "rgl" "rglyyM" "rglyyM" Fem; 
  store_N = mkN "Hnwt" "Hnwywt" Fem;
  chair_N = mkN "kSA" "kSAwt" Masc;  
  eyes_N = mkN "OyN" "OynyyM" "OynyyM" Fem; 
  spoon_N = mkN "kP" Fem; 
  big_A = regA "gdwl";
  small_A = regA "qTN";
  green_A = regA "yrwq";
  delicious_A = regA2 "nhdr"; 
  italian_A = regA2 "AyTlqy";
  write_V = mkVPaal "ktb" ; 
  finish_V = mkVPaal "gmr" ; 
  walk_V = mkVPaal "ZOd" ; 
  arrive_V = mkVHifhil2 "ngO" ;
  express_V = mkVHifhil2 "nbO" ;
  love_V2 = dirV2 (mkVPaal "Ahb") ;
  please_V2 = dirV2 (mkVPaal "Spq") ;
}
