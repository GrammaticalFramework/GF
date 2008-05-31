--# -path=.:../romance:../abstract:../common:prelude

concrete CatCat of Cat = CommonX - [Tense,TPres,TPast,TFut,TCond] ** CatRomance with -- JS restore TPast for notpresent
  (ResRomance = ResCat) ;
