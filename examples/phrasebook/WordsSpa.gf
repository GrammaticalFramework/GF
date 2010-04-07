-- (c) 2009 Aarne Ranta and Olga Caprotti under LGPL

concrete WordsSpa of Words = SentencesSpa ** open
  SyntaxSpa,
  BeschSpa,
  (E = ExtraSpa),
  (L = LexiconSpa),
  (P = ParadigmsSpa), 
  ParadigmsSpa in {

  lin
 
-- kinds
 
    Apple = mkCN L.apple_N ;
    Beer = mkCN L.beer_N ;
    Bread = mkCN L.bread_N ;
--     Cheese = mkCN (mkN "formaggio") ;
--     Coffee = mkCN (mkN "caffè") ;
    Fish = mkCN L.fish_N ;
    Milk = mkCN L.milk_N ;
--     Pizza = mkCN (mkN "pizza") ;
    Salt = mkCN L.salt_N ;
--     Tea = mkCN (mkN "tè") ;
    Water = mkCN L.water_N ;
    Wine = mkCN L.wine_N ;
-- 
-- -- properties
-- 
    Bad = L.bad_A ;
--     Boring = mkA "noioso" ;
    Cold = L.cold_A ;
--     Delicious = mkA "delizioso" ;
--     Expensive = mkA "caro" ;
--     Fresh = mkA "fresco" ;
    Good = L.good_A ;
    Warm = L.warm_A ;
-- 
-- -- places
-- 
--     Airport = mkPlace (mkN "aeroporto") dative ;
--     Bar = mkPlace (mkN "bar") P.in_Prep ;
--     Church = mkPlace (mkN "chiesa") P.in_Prep ;
--     Hospital = mkPlace (mkN "ospedale") P.in_Prep ;
--     Museum = mkPlace (mkN "museo") P.in_Prep ;
--     Restaurant = mkPlace (mkN "ristorante") P.in_Prep ;
--     Station = mkPlace (mkN "stazione" feminine) dative ;
--     Toilet = mkPlace (mkN "bagno") P.in_Prep ;
-- 
-- -- currencies
-- 
--     DanishCrown = mkCN (mkA "danese") (mkN "corona") ;
--     Dollar = mkCN (mkN "dollar") ;
--     Euro = mkCN (mkN "euro" "euro" masculine) ;
--     Lei = mkCN (mkN "lei") ; ---- ?
-- 
-- -- nationalities
-- 
--     Belgian = mkA "belgo" ;
--     Belgium = mkNP (mkPN "Belgio") ;
--     English = mkNat "inglese" "Inghilterra" ;
--     Finnish = mkNat "finlandese" "Finlandia" ;
--     Flemish = mkNP (mkPN "fiammingo") ;
--     French = mkNat "francese" "Francia" ; 
--     Italian = mkNat "italiano" "Italia" ;
--     Romanian = mkNat "rumeno" "Romania" ;
--     Swedish = mkNat "svedese" "Svezia" ;
-- 
-- -- actions
-- 
--     AHasName p name = mkCl p.name (mkV2 (reflV (mkV "chiamare"))) name ;
--     AHungry p = mkCl p.name (E.ComplCN have_V2 (mkCN (mkN "fame" feminine))) ;
--     AIll p = mkCl p.name (mkA "malato") ;
--     AKnow p = mkCl p.name (mkV (sapere_78 "sapere")) ;
--     ALike p item = mkCl item (mkV2 (mkV (piacere_64 "piacere")) dative) p.name ;
--     ALive p co = 
--       mkCl p.name (mkVP (mkVP (mkV "abitare")) (SyntaxSpa.mkAdv P.in_Prep co)) ;
--     ALove p q = mkCl p.name (mkV2 (mkV "amare")) q.name ;
--     AScared p = mkCl p.name (E.ComplCN have_V2 (mkCN (mkN "paura" feminine))) ;
--     ASpeak p lang = mkCl p.name  (mkV2 (mkV "parlare")) lang ;
--     AThirsty p = mkCl p.name (E.ComplCN have_V2 (mkCN (mkN "sete" feminine))) ;
--     ATired p = mkCl p.name (mkA "stanco") ;
--     AUnderstand p = mkCl p.name (mkV "capire") ;
--     AWant p obj = mkCl p.name (mkV2 (mkV (volere_96 "volere"))) obj ;
    AWantGo p place = mkCl p.name want_VV (mkVP (mkVP L.go_V) place.to) ;
-- 
-- 
-- -- miscellaneous
-- 
--     QWhatName p = mkQS (mkQCl how_IAdv (mkCl p.name (reflV (mkV "chiamare")))) ;
-- 
--     PropOpen p = mkCl p.name open_A ;
--     PropClosed p = mkCl p.name closed_A ;
--     PropOpenDate p d = mkCl p.name (mkVP (mkVP open_A) d) ; 
--     PropClosedDate p d = mkCl p.name (mkVP (mkVP closed_A) d) ; 
--     PropOpenDay p d = mkCl p.name (mkVP (mkVP open_A) d.habitual) ; 
--     PropClosedDay p d = mkCl p.name (mkVP (mkVP closed_A) d.habitual) ; 
-- 
--     HowMuchCost item = mkQS (mkQCl how8much_IAdv (mkCl item (mkV "costare"))) ; 
--     ItCost item price = mkCl item (mkV2 (mkV "costare")) price ;
-- 
-- -- week days
-- 
--     Monday = mkDay "lunedì" ;
--     Tuesday = mkDay "martedì" ;
--     Wednesday = mkDay "mercoledì" ;
--     Thursday = mkDay "giovedì" ;
--     Friday = mkDay "venerdì" ;
--     Saturday = mkDay "sabato" ;
--     Sunday = mkDay "domenica" ;
-- 
-- -- auxiliaries
-- 
--   oper
--     mkNat : Str -> Str -> {lang : NP ; prop : A ; country : NP} = \nat,co -> 
--       {lang = mkNP (mkPN nat) ; prop = mkA nat ; country = mkNP (mkPN co)} ;
-- 
--     mkDay : Str -> {name : NP ; point : Adv ; habitual : Adv} = \d ->
--       let day = mkNP (mkPN d) in
--       {name = day ; 
--        point, -- = ParadigmsSpa.mkAdv d ; 
--        habitual = ParadigmsSpa.mkAdv ("il" ++ d) ; ---- ?
--       } ;
-- 
--     mkPlace : N -> Prep -> {name : CN ; at : Prep ; to : Prep} = \p,i -> {
--       name = mkCN p ;
--       at = i ;
--       to = dative
--       } ;
-- 
--     open_A = mkA "aperto" ;
--     closed_A = mkA "chiuso" ;
-- 
-- 
-- }
}
