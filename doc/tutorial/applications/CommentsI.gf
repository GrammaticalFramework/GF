--# -path=.:prelude

incomplete concrete CommentsI of Comments = open Syntax in {

  lincat
    S = Syntax.S ;
    Quality = AP ; 
    Kind = CN ;
    Item = NP ;

  lin
    Is item quality = PosVP item (PredAP quality) ;
    This  = DetCN this_Det ;
    That  = DetCN that_Det ;
    These = DetCN these_Det ;
    Those = DetCN those_Det ;
    QKind = ModCN ;
    Very  = AdAP very_AdA ;

}
    