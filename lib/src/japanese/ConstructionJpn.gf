concrete ConstructionJpn of Construction = CatJpn **
  open SyntaxJpn, ParadigmsJpn, ResJpn, (L = LexiconJpn) in {

lin
  hungry_VP = mkVP (mkV "お腹が空いている" Gr1) ;
  thirsty_VP = mkVP (mkA "喉が乾いている" "渇した") ;
  tired_VP = mkVP (mkA "疲れている" "疲れた") ;
  scared_VP = mkVP (mkA "怖い") ;
  ill_VP = mkVP (mkA "病気の") ;
  ready_VP = mkVP L.ready_A ;

}
