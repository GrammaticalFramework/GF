--# -path=.:../romance:../abstract:../../prelude

concrete TestVerbesFre of TestVerbesAbs = 
  TestResourceFre, VerbesFre ** open TypesFre in {

  lin UseVN  ve = verbPres ve.s ve.aux ;
  lin UseVN2 ve = verbPres ve.s ve.aux ** {s2 = [] ; c = ve.c} ;

}
