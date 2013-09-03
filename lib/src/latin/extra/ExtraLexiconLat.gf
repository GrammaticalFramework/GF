concrete ExtraLexiconLat of ExtraLexicon = CatLat ** open
  ParadigmsLat, 
  IrregLat,
  ResLat,
  Structural,
  Prelude in { 
flags 
  optimize=values ;
  coding = utf8;
lincat
  Numeral = { s : Str } ;
lin
-- Navigatio sancti Brendani abbatis
  abbot_N = mkN "abbas" "abbatis" Masc ;
  Brendan_PN = mkPN ( mkN "Brendanus" ) ;
  bring_V = IrregLat.bring_V ;
  but_Conj = sd2 [] "autem" ** { n = Sg } ;
  Christus_PN = mkPN ( mkN "Christus" ) ;
  confessor_N = mkN "confessor" "confessoris" Masc ;
  day_N = mkN "dies" "diei" ( Masc | Fem ) ;
  eight_Num = ss "octo" ;
  holy_A = mkA "sanctus" ;
  life_N = mkN "vita" ;
  saint_N = mkN "sanctus" ;
  see_V = mkV "videre" "video" "visi" "visum" ;
  texture_N = mkN "textus" "textus" Masc ;
  through_Prep = mkPrep "per" Acc ; 
  thus_Adv = ss "sic" ;
  voyage_N = mkN "navigatio" "navigationis" Fem ;
  yet_Adv = ss ( "iam" | "jam" ) ;
-- In L. Catilinam oratio I
  speech_N =
}