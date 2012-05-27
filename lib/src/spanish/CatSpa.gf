--# -path=.:../romance:../abstract:../common:prelude

concrete CatSpa of Cat = CommonX - 
  [SC,Temp,TTAnt,Tense,TPres,TPast,TFut,TCond,Pol] ** CatRomance with
  (ResRomance = ResSpa) ;
