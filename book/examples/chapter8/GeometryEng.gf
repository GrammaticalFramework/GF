--# -path=.:present

concrete GeometryEng of Geometry = LogicEng ** 
  open SyntaxEng, ParadigmsEng in {
lin
  Line = mkCN (mkN "line") ;
  Point = mkCN (mkN "point") ; 
  Circle = mkCN (mkN "circle") ;
  Intersect = pred (mkV2 "intersect") ;
  Parallel = pred (mkA2 (mkA "parallel") (mkPrep "to")) ;
  Vertical = pred (mkA "vertical") ;
  Centre = app (mkN2 (mkN "centre") (mkPrep "of")) ;
}
