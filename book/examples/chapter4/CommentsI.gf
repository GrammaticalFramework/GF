incomplete concrete CommentsI of Comments = open Syntax in {
  lincat
    Comment = Cl ; 
    Item = NP ;
    Kind = CN ;
    Quality = AP ;
  lin
    Pred item quality = mkCl item quality ;
    This kind = mkNP this_QuantSg kind ;
    That kind = mkNP that_QuantSg kind ;
    These kind = mkNP these_QuantPl kind ;
    Those kind = mkNP those_QuantPl kind ;
    Mod quality kind = mkCN quality kind ;
    Very quality = mkAP very_AdA quality ;
}
