--# -path=.:../newresource/abstract:../newresource/french:../newresource/romance:../prelude
--- path names: resource in release, newresource in cvs

concrete RestaurantFre of Restaurant = 
  DatabaseFre ** open Prelude, ResourceFre, ParadigmsFre in {

lin 
  Restaurant = UseN (nReg "restaurant" masculine) ;
  Bar = UseN (nReg "bar" masculine) ;
  French = AdjP1 (adj1Anglais "français" postpos) ;
  Italian = AdjP1 (adj1Italien "italien" postpos) ;
  Indian = AdjP1 (adj1Italien "indien" postpos) ;
  Japanese = AdjP1 (adj1Anglais "japonais" postpos) ;

  address = funDe (nReg "adresse" feminine) ;
  phone   = funCNCase (AdvCN (UseN (nReg "numéro" masculine)) 
              (PrepNP PossessPrep (MassNP (UseN (nReg "téléphone" masculine))))) genitive ;
  priceLevel = funCNCase (AdvCN (UseN (nEau "niveau" masculine)) 
              (PrepNP PossessPrep (MassNP (UseN (nCas "prix" masculine))))) genitive ;

  Cheap = aReg "cher" postpos ; ---- 
  Expensive = aReg ["pas cher"] postpos ; ----

  WhoRecommend rest = 
    ss2 ["qui a recommandé"] rest.s ** {lock_Phr = <>} ;
  WhoHellRecommend rest = 
    ss2 ["qui enfer a recommandé"] rest.s ** {lock_Phr = <>} ;

  LucasCarton = mkPN ["Lucas Carton"] masculine ;
  LaCoupole  = mkPN ["La Coupole"] feminine ;
  BurgerKing =mkPN ["Burger King"] masculine ;

}
