-- (c) 2009 Ramona Enache and Aarne Ranta under LGPL

concrete WordsFre of Words = SentencesFre ** open
  SyntaxFre,
  DiffPhrasebookFre,
  IrregFre,
  (E = ExtraFre),
  ParadigmsFre in
{
flags coding=utf8 ;

lin

Wine = mkCN (mkN "vin") ;
    Beer = mkCN (mkN "bière") ;
    Water = mkCN (mkN "eau" feminine) ;
    Coffee = mkCN (mkN "café") ;
    Tea = mkCN (mkN "thé") ;

Cheese = mkCN (mkN "fromage" masculine) ;
Fish = mkCN (mkN "poisson" masculine) ;
Pizza = mkCN (mkN "pizza" feminine) ;

Fresh = mkA "frais" "fraîche" "frais" "fraîchement" ;
Warm = mkA "chaud" ;
Italian = mkA "italien" ;
Expensive = mkA "cher" ;
Delicious = mkA "délicieux" ;
Boring = mkA "ennuyeux" ;
Good = prefixA (mkA "bon" "bonne" "bons" "bien") ;

    Restaurant = mkCN (mkN "restaurant") ;
    Bar = mkCN (mkN "bar") ;
    Toilet = mkCN (mkN "toilette") ;

    Euro = mkCN (mkN "euro") ;
    Dollar = mkCN (mkN "dollar") ;
    Lei = mkCN (mkN "lei") ; ---- ?

    AWant p obj = mkCl p want_V2 obj ;
    ALike p item = mkCl item plaire_V2 p ;
    AHave p kind = mkCl p have_V2 (mkNP kind) ;
    ASpeak p lang = mkCl p  (mkV2 (mkV "parler")) lang ;
    ALove p q = mkCl p (mkV2 (mkV "aimer")) q ;

    English = mkNP (mkPN "anglais") ;
    Finnish = mkNP (mkPN "finnois") ;
    French = mkNP (mkPN "français") ; 
    Romanian = mkNP (mkPN "roumain") ;
    Swedish = mkNP (mkPN "suédois") ;

    AHungry p = mkCl p (E.ComplCN have_V2 (mkCN (mkN "faim" feminine))) ;
    AThirsty p = mkCl p (E.ComplCN have_V2 (mkCN (mkN "soif" feminine))) ;
    ATired p = mkCl p (mkA "fatigué") ;
    AScared p = mkCl p (E.ComplCN have_V2 (mkCN (mkN "peur" feminine))) ;
    AUnderstand p = mkCl p (mkV IrregFre.comprendre_V2) ;

}
