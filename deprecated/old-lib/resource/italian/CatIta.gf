--# -path=.:../romance:../abstract:../common:prelude

concrete CatIta of Cat = CommonX - [Tense,TPres,TPast,TFut,TCond] ** CatRomance with
  (ResRomance = ResIta) ;
