--# -path=alltenses

concrete GeometryEng of Geometry = LogicEng ** 
  open SyntaxEng, ParadigmsEng in {
lin
  Line = mkN "line" ;
  Point = mkN "point" ; 
  Circle = mkN "circle" ;
  Intersect = pred (mkV2 "intersect") ;
  Parallel = pred (mkA2 (mkA "parallel") (mkPrep "to")) ;
  Vertical = pred (mkA "vertical") ;
  Centre = app (mkN2 (mkN "centre") (mkPrep "of")) ;

  Horizontal = mkVP (mkA "horizontal") ;
  Diverge = mkVP (mkV "diverge") ;

  Contain = mkVPSlash (mkV2 "contain") ;
}
