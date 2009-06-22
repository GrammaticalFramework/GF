--# -path=.:../romance:../abstract:../common:prelude

concrete CatIta of Cat = CommonX - [Temp,TTAnt,Tense,TPres,TPast,TFut,TCond] ** CatRomance with
  (ResRomance = ResIta) ;
