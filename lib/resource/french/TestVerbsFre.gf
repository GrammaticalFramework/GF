--# -path=.:../romance:../oldabstract:../abstract:../../prelude

concrete TestVerbsFre of TestVerbsFreAbs = 
  TestResourceFre, VerbsFre ** open TypesFre in {

  lin UseVN  ve = verbPres ve.s ve.aux ;
  lin UseVN2 ve = verbPres ve.s ve.aux ** {s2 = [] ; c = ve.c} ;

}
