--# -path=.:../romance:../abstract:../common:prelude

concrete CatSpa of Cat = CommonX - 
  [SC,Temp,TTAnt,Tense,TPres,TPast,TFut,TCond] ** CatRomance with
  (ResRomance = ResSpa) ;
