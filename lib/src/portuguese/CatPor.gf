--# -path=.:../romance:../abstract:../common:prelude

concrete CatPor of Cat = CommonX - 
  [SC,Temp,TTAnt,Tense,TPres,TPast,TFut,TCond,Pol] ** CatRomance with
  (ResRomance = ResPor) ;
