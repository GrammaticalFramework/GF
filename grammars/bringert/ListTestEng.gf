concrete ListTestEng of ListTest = {

lin BaseA = { s = "" } ;
lin ConsA a as = { s = a.s ++ "" ++ as.s } ;

lin BaseB b = { s = b.s } ;
lin ConsB b bs = { s = b.s ++ "," ++ bs.s } ;

lin apa = { s = "apa" } ;
lin bepa = { s = "bepa" } ;

}