--# -path=.:../romance:../abstract:../common:../prelude

-- machine-generated GF file from Andersson & Söderberg's MSc work

concrete IrregPor of IrregPorAbs = CatPor **
  open (C=CommonRomance), ParadigmsPor, BeschPor in {

flags optimize=values ;
    coding=utf8 ;

  lin estar_V = mkV (estar_10 "estar") ;
  lin fazer_V = mkV (fazer_31 "fazer") ;

}
