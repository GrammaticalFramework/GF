-- (c) 2009 Ramona Enache and Aarne Ranta under LGPL

concrete WordsIta of Words = SentencesIta ** open
  SyntaxIta,
  DiffPhrasebookIta,
  BeschIta,
  (E = ExtraIta),
  ParadigmsIta in {

lin

Wine = mkCN (mkN "vino") ;
    Beer = mkCN (mkN "birra") ;
    Water = mkCN (mkN "acqua") ;
    Coffee = mkCN (mkN "caffè") ;
--   Tea = mkCN (mkN "té") ; ----

Cheese = mkCN (mkN "formaggio") ;
Fish = mkCN (mkN "pesce") ;
Pizza = mkCN (mkN "pizza") ;

Fresh = mkAP (mkA "fresco") ;
Warm = mkAPA "caldo" ;
Italian = mkAPA "italiano" ;
Expensive = mkAPA "caro" ;
Delicious = mkAPA "delizioso" ;
Boring = mkAPA "noioso" ;

    Restaurant = mkCN (mkN "ristorante") ;
    Bar = mkCN (mkN "bar") ;
    Toilet = mkCN (mkN "bagno") ;

    Euro = mkCN (mkN "euro" "euro" masculine) ;
    Dollar = mkCN (mkN "dollar") ;
    Lei = mkCN (mkN "lei") ; ---- ?

    AWant p obj = mkCl p want_V2 obj ;
    ALike p item = mkCl item (mkV2 (mkV (piacere_64 "piacere")) dative) p ;
    AHave p kind = mkCl p have_V2 (mkNP kind) ;
    ASpeak p lang = mkCl p  (mkV2 (mkV "parlare")) lang ;
    ALove p q = mkCl p (mkV2 (mkV "amare")) q ;

    English = mkNP (mkPN "inglese") ;
    Finnish = mkNP (mkPN "finlandese") ;
    French = mkNP (mkPN "francese") ; 
    Romanian = mkNP (mkPN "rumeno") ;
    Swedish = mkNP (mkPN "svedese") ;

    AHungry p = mkCl p (E.ComplCN have_V2 (mkCN (mkN "fame" feminine))) ;
    AThirsty p = mkCl p (E.ComplCN have_V2 (mkCN (mkN "sete" feminine))) ;
    ATired p = mkCl p (mkA "stanco") ;
    AScared p = mkCl p (E.ComplCN have_V2 (mkCN (mkN "paura" feminine))) ;
    AUnderstand p = mkCl p (mkV "capire") ;

oper
mkAPA : (_ : Str) -> AP = \x -> mkAP (mkA x) ;

}
