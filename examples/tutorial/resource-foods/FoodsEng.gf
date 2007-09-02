--# -path=.:../foods:present:prelude

concrete FoodsEng of Foods = open SyntaxEng,ParadigmsEng in {
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
    Wine = mkCN (mkN "wine") ;
    Pizza = mkCN (mkN "pizza") ;
    Cheese = mkCN (mkN "cheese") ;
    Fish = mkCN (mkN "fish" "fish") ;
    Very quality = mkAP very_AdA quality ;
    Fresh = mkAP (mkA "fresh") ;
    Warm = mkAP (mkA "warm") ;
    Italian = mkAP (mkA "Italian") ;
    Expensive = mkAP (mkA "expensive") ;
    Delicious = mkAP (mkA "delicious") ;
    Boring = mkAP (mkA "boring") ;
}
