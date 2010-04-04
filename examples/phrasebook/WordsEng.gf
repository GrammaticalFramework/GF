-- (c) 2009 Aarne Ranta under LGPL

concrete WordsEng of Words = SentencesEng ** 
    open SyntaxEng, ParadigmsEng, IrregEng in {
  lin
    Wine = mkCN (mkN "wine") ;
    Beer = mkCN (mkN "beer") ;
    Water = mkCN (mkN "water") ;
    Coffee = mkCN (mkN "coffee") ;
    Tea = mkCN (mkN "tea") ;

    Pizza = mkCN (mkN "pizza") ;
    Cheese = mkCN (mkN "cheese") ;
    Fish = mkCN (mkN "fish" "fish") ;
    Fresh = mkA "fresh" ;
    Warm = mkA "warm" ;
    Italian = mkA "Italian" ;
    Expensive = mkA "expensive" ;
    Delicious = mkA "delicious" ;
    Boring = mkA "boring" ;
    Good = mkA "good" "better" "best" "well" ;

    Restaurant = mkCN (mkN "restaurant") ;
    Bar = mkCN (mkN "bar") ;
    Toilet = mkCN (mkN "toilet") ;

    Euro = mkCN (mkN "euro" "euros") ; -- to prevent euroes
    Dollar = mkCN (mkN "dollar") ;
    Lei = mkCN (mkN "leu" "lei") ;

    English = mkNP (mkPN "English") ;
    Finnish = mkNP (mkPN "Finnish") ;
    French = mkNP (mkPN "French") ; 
    Romanian = mkNP (mkPN "Romanian") ;
    Swedish = mkNP (mkPN "Swedish") ;

    AWant p obj = mkCl p (mkV2 (mkV "want")) obj ;
    ALike p item = mkCl p (mkV2 (mkV "like")) item ;
    AHave p kind = mkCl p have_V2 (mkNP kind) ;
    ASpeak p lang = mkCl p  (mkV2 IrregEng.speak_V) lang ;
    ALove p q = mkCl p (mkV2 (mkV "love")) q ;

    AHungry p = mkCl p (mkA "hungry") ;
    AThirsty p = mkCl p (mkA "thirsty") ;
    ATired p = mkCl p (mkA "tired") ;
    AScared p = mkCl p (mkA "scared") ;
    AUnderstand p = mkCl p IrregEng.understand_V ;

}
