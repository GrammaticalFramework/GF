--# -path=.:../romance:../abstract:../common:prelude

concrete CatCat of Cat = 
  CommonX - [SC,Temp,TTAnt,Tense,TPres,TPast,TFut,TCond,Pol] ** 
  CatRomance with -- JS restore TPast for notpresent
  (ResRomance = ResCat) ;
