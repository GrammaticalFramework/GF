--# -path=.:../romance:../abstract:../common:prelude

concrete CatSpa of Cat = CommonX ** CatRomance with
  (ResRomance = ResSpa) ;
