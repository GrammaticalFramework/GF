--# -path=alltenses

concrete GeometryFre of Geometry = LogicFre ** 
  open SyntaxFre, ParadigmsFre, IrregFre in {
lin
  Line = mkN "ligne" ;
  Point = mkN "point" ; 
  Circle = mkN "cercle" masculine ;
  Intersect = pred (mkV2 "couper") ;
  Parallel = pred (mkA2 (mkA "parallèle") dative) ;
  Vertical = pred (mkA "vertical") ;
  Centre = app (mkN2 (mkN "centre" masculine) genitive) ;

  Horizontal = mkVP (mkA "horizontel") ;
  Diverge = mkVP (mkV "diverger") ;

  Contain = mkVPSlash contenir_V2 ;
}
