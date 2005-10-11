--# -path=.:../abstract:../../prelude

concrete MinimalEng of Minimal = CategoriesEng ** open ParadigmsEng in {

flags 
  optimize=all ;

lin
  man_N = mk2N "man" "men" ;
  wine_N = regN "wine" ;
  mother_N2 = regN2 "mother" ;
  distance_N3 = mkN3 (regN "distance") "from" "to" ;
  john_PN = regPN "John" masculine ;
  blue_ADeg = regADeg "blue" ;
  american_A = regA "american" ;
  married_A2 = mkA2 (regA "married") "to" ;
  probable_AS = mkAS (regA "probable") ;
  important_A2S = mkA2S (regA "important") "to" ;
  easy_A2V = mkA2V (regA "easy") "for" ;
  now_Adv = mkAdv "now" ;
  walk_V = (regV "walk") ;
  love_V2 = dirV2 (regV "love") ;
  give_V3 = dirV3 (irregV "give" "gave" "given") "to" ;
  believe_VS = mkVS (regV "believe") ;
  try_VV = mkVV (regV "try") ;
  wonder_VQ = mkVQ (regV "wonder") ;
  become_VA = mkVA (irregV "become" "became" "become") ;
  paint_V2A = mkV2A (regV "paint") [] ;
  promise_V2V = mkV2V (regV "promise") [] "to" ;
  ask_V2Q = mkV2Q (regV "ask") [] ;
  tell_V2S = mkV2S (irregV "tell" "told" "told") [] ;
  rain_V0 = mkV0 (regV "rain") ;

} ;
