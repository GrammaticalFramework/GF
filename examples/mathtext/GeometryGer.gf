--# -path=alltenses

concrete GeometryGer of Geometry = LogicGer ** 
  open SyntaxGer, ParadigmsGer, IrregGer in {
lin
  Line = mkN "Gerade" ;
  Point = mkN "Punkt" ; 
  Circle = mkN "Kreis" ;
  Intersect = pred (mkV2 (mkV "schneiden")) ;
  Parallel = pred (mkA2 (mkA "parallel") (mkPrep "zu" dative)) ;
  Vertical = pred (mkA "vertikal") ;
  Centre = app (mkN2 (mkN "Mittelpunkt") (mkPrep [] genitive)) ;

  Horizontal = mkVP (mkA "horizontal") ;
  Diverge = mkVP (mkV "divergieren") ;

  Contain = mkVPSlash (mkV2 (fixprefixV "ent" halten_V)) ;

}
