--# -path=.:../foods:present:prelude

incomplete concrete FoodsI of Foods = open Syntax, LexFoods in {
  lincat
    Phrase = Utt ; 
    Item = NP ;
    Kind = CN ;
    Quality = AP ;
  lin
    Is item quality = mkUtt (mkCl item quality) ;
    This kind = mkNP (mkDet this_Quant) kind ;
    That kind = mkNP (mkDet that_Quant) kind ;
    These kind = mkNP (mkDet (mkQuantPl this_Quant)) kind ;
    Those kind = mkNP (mkDet (mkQuantPl that_Quant)) kind ;
    QKind quality kind = mkCN quality kind ;
    Very quality = mkAP very_AdA quality ;

    Wine = mkCN wine_N ;
    Pizza = mkCN pizza_N ;
    Cheese = mkCN cheese_N ;
    Fish = mkCN fish_N ;
    Fresh = mkAP fresh_A ;
    Warm = mkAP warm_A ;
    Italian = mkAP italian_A ;
    Expensive = mkAP expensive_A ;
    Delicious = mkAP delicious_A ;
    Boring = mkAP boring_A ;
}
