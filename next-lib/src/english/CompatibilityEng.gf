--# -path=.:../abstract:../common

concrete CompatibilityEng of Compatibility = CatEng ** open Prelude, ResEng in {

-- from Noun 19/4/2008

lin
    NumInt n = {s = n.s ; n = Pl ; hasCard = True} ; 
    OrdInt n = {s = n.s ++ "th"} ;

}
