incomplete concrete FoodI of Food = open Syntax, LexFood in {

  lincat
    S = Utt ; 
    Item = NP ;
    Kind = CN ;
    Quality = AP ;

  lin
    Is item quality = mkUtt (mkCl item quality) ;
    This kind = mkNP (mkDet this_Quant) kind ;
    That kind = mkNP (mkDet that_Quant) kind ;
    All kind = mkNP all_Predet (mkNP defPlDet kind) ;
    QKind quality kind = mkCN quality kind ;
    Wine = mkCN wine_N ;
    Beer = mkCN beer_N ;
    Pizza = mkCN pizza_N ;
    Cheese = mkCN cheese_N ;
    Fish = mkCN fish_N ;
    Very quality = mkAP very_AdA quality ;
    Fresh = mkAP fresh_A ;
    Warm = mkAP warm_A ;
    Italian = mkAP italian_A ;
    Expensive = mkAP expensive_A ;
    Delicious = mkAP delicious_A ;
    Boring = mkAP boring_A ;

}
