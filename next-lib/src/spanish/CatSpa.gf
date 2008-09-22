--# -path=.:../romance:../abstract:../common:prelude

concrete CatSpa of Cat = CommonX - 
  [Temp,TTAnt,Tense,TPres,TPast,TFut,TCond] ** CatRomance with
  (ResRomance = ResSpa) ;
