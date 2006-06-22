--# -path=.:../romance:../common:../abstract:../common:prelude

concrete CatFre of Cat = CommonX - [Tense,TPres,TPast,TFut,TCond] ** CatRomance with
  (ResRomance = ResFre) ;
