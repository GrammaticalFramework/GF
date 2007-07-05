--# -path=present:prelude

concrete FoodFre of Food = open SyntaxFre,ParadigmsFre in {

  lincat
    S = Utt ; 
    Item = NP ;
    Kind = CN ;
    Quality = AP ;

  lin
    Is item quality = mkUtt (mkCl item quality) ;
    This kind = SyntaxFre.mkNP (mkDet this_Quant) kind ;
    That kind = SyntaxFre.mkNP (mkDet that_Quant) kind ;
    All kind = SyntaxFre.mkNP all_Predet (SyntaxFre.mkNP defPlDet kind) ;
    QKind quality kind = mkCN quality kind ;
    Wine = mkCN (mkN "vin") ;
    Beer = mkCN (mkN "bière") ;
    Pizza = mkCN (mkN "pizza" feminine) ;
    Cheese = mkCN (mkN "fromage" masculine) ;
    Fish = mkCN (mkN "poisson") ;
    Very quality = mkAP very_AdA quality ;
    Fresh = mkAP (mkA "frais" "fraîche") ;
    Warm = mkAP (mkA "chaud") ;
    Italian = mkAP (mkA "italien") ;
    Expensive = mkAP (mkA "cher") ;
    Delicious = mkAP (mkA "délicieux") ;
    Boring = mkAP (mkA "ennuyeux") ;

}
