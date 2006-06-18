--# -path=.:../romance:../abstract:../common:prelude

concrete CatSpa of Cat = CommonX - [Tense,TPres,TPast,TFut,TCond] ** CatRomance with
  (ResRomance = ResSpa) ;
