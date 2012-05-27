--# -path=.:../romance:../abstract:../common:prelude

concrete CatIta of Cat = CommonX - [SC,Temp,TTAnt,Tense,TPres,TPast,TFut,TCond,Pol] ** CatRomance with
  (ResRomance = ResIta) ;
