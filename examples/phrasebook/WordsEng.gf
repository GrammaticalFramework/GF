-- (c) 2009 Aarne Ranta under LGPL

concrete WordsEng of Words = SentencesEng ** 
    open SyntaxEng, ParadigmsEng, IrregEng, (R = Roles) in {
  lin
    Wine = mkCN (mkN "wine") ;
    Beer = mkCN (mkN "beer") ;
    Water = mkCN (mkN "water") ;
    Coffee = mkCN (mkN "coffee") ;
    Tea = mkCN (mkN "tea") ;

    Pizza = mkCN (mkN "pizza") ;
    Cheese = mkCN (mkN "cheese") ;
    Fish = mkCN (mkN "fish" "fish") ;
    Fresh = mkAP (mkA "fresh") ;
    Warm = mkAP (mkA "warm") ;
    Italian = mkAP (mkA "Italian") ;
    Expensive = mkAP (mkA "expensive") ;
    Delicious = mkAP (mkA "delicious") ;
    Boring = mkAP (mkA "boring") ;

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

    AWant p obj = neutralA (mkCl (np p) (mkV2 (mkV "want")) obj) ;
    ALike p item = neutralA (mkCl (np p) (mkV2 (mkV "like")) item) ;
    AHave p kind = neutralA (mkCl (np p) have_V2 (mkNP kind)) ;
    ASpeak p lang = neutralA (mkCl (np p)  (mkV2 IrregEng.speak_V) lang) ;
    ALove p q = neutralA (mkCl (np p) (mkV2 (mkV "love")) (np q)) ;

  oper
    neutralA : Cl -> {s : R.Politeness => Cl}  = \pol -> {s = \\_ => pol} ;
    np : {s : R.Politeness => NP} -> NP = \p -> p.s ! R.PPolite ;
}
