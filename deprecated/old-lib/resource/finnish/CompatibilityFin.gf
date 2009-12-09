--# -path=.:../abstract:../common

concrete CompatibilityFin of Compatibility = CatFin ** open Prelude, ResFin in {

-- from Noun 19/4/2008

lin
    NumInt n = {s = \\_,_ => n.s ; isNum = True ; n = Pl} ;
    OrdInt n = {s = \\_,_ => n.s ++ "."} ;

}
