--# -path=.:../romance:../common:../abstract:../common:prelude

concrete CatFre of Cat = CommonX ** CatRomance with
  (ResRomance = ResFre) ;
