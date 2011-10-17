-- Functor
-- (a module that opens one or more interfaces)
incomplete concrete FoodsI of Foods = open Syntax, LexFoods in {
lincat
  Phrase = Cl ; 
  Item = NP ;
  Kind = CN ;
  Quality = AP ;
lin
  Is item quality = mkCl item quality ;
  This kind = mkNP this_Det kind ;
  That kind = mkNP that_Det kind ;
  These kind = mkNP these_Det kind ;
  Those kind = mkNP those_Det kind ;
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
