--# -path=.:present

concrete ClothesEng of Clothes = CommentsEng ** 
    open SyntaxEng, ParadigmsEng in {
  lin
    Shirt = mkCN (mkN "shirt") ;
    Jacket = mkCN (mkN "jacket") ;
    Comfortable = mkAP (mkA "comfortable") ;
    Elegant = mkAP (mkA "elegant") ;
}
