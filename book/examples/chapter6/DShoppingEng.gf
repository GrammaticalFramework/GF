--# -path=.:present

concrete DShoppingEng of DShopping = open SyntaxEng, ParadigmsEng in {

  lincat
    Comment = Cl ; 
    Item = NP ;
    Kind = CN ;
    Quality = AP ;
  lin
    Pred _ item quality = mkCl item quality ;
    This _ kind = mkNP this_QuantSg kind ;
    That _ kind = mkNP that_QuantSg kind ;
    Mod _ quality kind = mkCN quality kind ;
    Very _ quality = mkAP very_AdA quality ;

    Shirt = mkCN (mkN "shirt") ;
    Jacket = mkCN (mkN "jacket") ;
    Wine = mkCN (mkN "wine") ;
    Cheese = mkCN (mkN "cheese") ;
    Fish = mkCN (mkN "fish" "fish") ;
    Fresh = mkAP (mkA "fresh") ;
    Warm = mkAP (mkA "warm") ;
    Italian _ = mkAP (mkA "Italian") ;
    Expensive _ = mkAP (mkA "expensive") ;
    Elegant _ = mkAP (mkA "elegant") ;
    Delicious = mkAP (mkA "delicious") ;
    Boring = mkAP (mkA "boring") ;
    Comfortable = mkAP (mkA "comfortable") ;

    DFood, DCloth = {s = []} ;

}
