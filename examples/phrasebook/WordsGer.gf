-- (c) 2009 Aarne Ranta under LGPL

concrete WordsGer of Words = SentencesGer ** 
    open SyntaxGer, ParadigmsGer, IrregGer, (L = LexiconGer), Prelude in {

   lin

-- kinds of food
 
    Apple = mkCN L.apple_N ;
    Beer = mkCN L.beer_N ;
    Bread = mkCN L.bread_N ;
--     Cheese = mkCN (mkN "ost") ;
--     Coffee = mkCN (mkN "kaffe" neutrum) ;
    Fish = mkCN L.fish_N ;
    Milk = mkCN L.milk_N ;
--     Pizza = mkCN (mkN "pizza") ;
    Salt = mkCN L.salt_N ;
--     Tea = mkCN (mkN "te" neutrum) ;
    Water = mkCN L.water_N ;
    Wine = mkCN L.wine_N ;

-- properties

    Bad = L.bad_A ;
--     Boring = mkA "tråkig" ;
    Cold = L.cold_A ;
--     Delicious = mkA "läcker" ;
--     Expensive = mkA "dyr" ;
--     Fresh = mkA "färsk" ;
    Good = L.good_A ;
    Warm = L.warm_A ;
-- 
-- -- places
-- 
--     Airport = mkPlace (mkN "flygplats" "flygplatser") "på" ;
--     Bar = mkPlace (mkN "bar" "barer") "i" ;
--     Church = mkPlace (mkN "kyrka") "i" ;
--     Hospital = mkPlace (mkN "sjukhus" "sjukhus") "på" ;
--     Museum = mkPlace (mkN "museum" "museet" "museer" "museerna") "på" ;
--     Restaurant = mkPlace (mkN "restaurang" "restauranger") "på" ;
--     Station = mkPlace (mkN "station" "stationer") "på" ;
--     Toilet = mkPlace (mkN "toalett" "toaletter") "på" ;
-- 
-- -- currencies
-- 
--     DanishCrown = mkCN (mkA "dansk") (mkN "krona") ;
--     Dollar = mkCN (mkN "dollar" "dollar") ;
--     Euro = mkCN (mkN "euro" "euro") ;
--     Lei = mkCN (mkN "lei" "lei") ;
--     SwedishCrown = mkCN (mkA "svensk") (mkN "krona") ;
-- 
-- -- nationalities
-- 
--     Belgian = mkA "belgisk" ;
--     Belgium = mkNP (mkPN "Belgien") ;
--     English = mkNat "engelsk" "England" ;
--     Finnish = mkNat "finsk" "Finland" ;
--     Flemish = mkNP (mkPN "flamländska") ;
--     French = mkNat "fransk" "Frankrike" ; 
--     Italian = mkNat "italiensk" "Italien" ;
--     Romanian = mkNat "rumänsk" "Rumänien" ;
--     Swedish = mkNat "svensk" "Sverige" ;
-- 
-- -- actions
-- 
--     AHasName p name = mkCl (nameOf p) name ;
--     AHungry p = mkCl p.name (mkA "hungrig") ;
--     AIll p = mkCl p.name (mkA "sjuk") ;
--     AKnow p = mkCl p.name (mkV "veta" "vet" "vet" "visste" "vetat" "visst") ; 
--     ALike p item = mkCl p.name (mkV2 (mkV "tycker") (mkPrep "om")) item ;
--     ALive p co = mkCl p.name (mkVP (mkVP (mkV "bo")) (SyntaxGer.mkAdv in_Prep co)) ;
--     ALove p q = mkCl p.name (mkV2 (mkV "älska")) q.name ;
--     AScared p = mkCl p.name (mkA "rädd") ;
--     ASpeak p lang = mkCl p.name  (mkV2 (mkV "tala")) lang ;
--     AThirsty p = mkCl p.name (mkA "törstig") ;
--     ATired p = mkCl p.name (mkA "trött") ;
--     AUnderstand p = mkCl p.name (mkV "förstå" "förstod" "förstått") ;
    AWant p obj = mkCl p.name want_VV (mkVP have_V2 obj) ;
    AWantGo p place = mkCl p.name want_VV (mkVP (mkVP L.go_V) place.to) ;
-- 
-- -- miscellaneous
-- 
--     QWhatName p = mkQS (mkQCl whatSg_IP (mkVP (nameOf p))) ;
-- 
--     PropOpen p = mkCl p.name open_A ;
--     PropClosed p = mkCl p.name closed_A ;
--     PropOpenDate p d = mkCl p.name (mkVP (mkVP open_A) d) ; 
--     PropClosedDate p d = mkCl p.name (mkVP (mkVP closed_A) d) ; 
--     PropOpenDay p d = mkCl p.name (mkVP (mkVP open_A) d.habitual) ; 
--     PropClosedDay p d = mkCl p.name (mkVP (mkVP closed_A) d.habitual) ; 
-- 
--     HowMuchCost item = mkQS (mkQCl how8much_IAdv (mkCl item (mkV "kosta"))) ; 
--     ItCost item price = mkCl item (mkV2 (mkV "kosta")) price ;
-- 
-- -- week days
-- 
--     Monday = mkDay "måndag" ;
--     Tuesday = mkDay "tisdag" ;
--     Wednesday = mkDay "onsdag" ;
--     Thursday = mkDay "torsdag" ;
--     Friday = mkDay "fredag" ;
--     Saturday = mkDay "lördag" ;
--     Sunday = mkDay "söndag" ;
-- 
--   oper
--     mkNat : Str -> Str -> {lang : NP ; prop : A ; country : NP} = \nat,co -> 
--       {lang = mkNP (mkPN (nat + "a")) ; 
--        prop = mkA nat ; country = mkNP (mkPN co)} ;
-- 
--     mkDay : Str -> {name : NP ; point : Adv ; habitual : Adv} = \d ->
--       let day = mkNP (mkPN d) in
--       {name = day ; 
--        point = SyntaxGer.mkAdv on_Prep day ; 
--        habitual = SyntaxGer.mkAdv on_Prep (mkNP a_Quant plNum (mkCN (mkN d)))
--       } ;
-- 
--     mkPlace : N -> Str -> {name : CN ; at : Prep ; to : Prep} = \p,i -> {
--       name = mkCN p ;
--       at = mkPrep i ;
--       to = to_Prep
--       } ;
-- 
--     open_A = mkA "öppen" "öppet" ;
--     closed_A = mkA "stängd" "stängt" ;
-- 
--     nameOf : {name : NP ; isPron : Bool ; poss : Det} -> NP = \p -> 
--       case p.isPron of {
--         True => mkNP p.poss (mkN "namn" "namn") ;
--         _    => mkNP (mkNP the_Det (mkN "namn" "namn")) 
--                        (SyntaxGer.mkAdv possess_Prep p.name)
--         } ;
-- }
}
