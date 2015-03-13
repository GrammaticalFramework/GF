--# -path=.:../abstract:../common:../prelude

concrete AdjectiveMon of Adjective = CatMon ** open ResMon, Prelude in {

 flags  coding=utf8 ;

lin

 PositA  a = a ;
	
-- Comparative forms are used with an object of comparison, as adjectival phrases.
   
 ComparA a np = {
    s = np.s ! Abl ++ a.s 
	} ;
	   
 UseComparA a = a ;
  
-- $SuperlA$ belongs to determiner syntax in $Noun$.

 ComplA2 a2 np = {
    s = np.s ! a2.c2.rc ++ a2.c2.s ++ a2.s
	} ;
    
 ReflA2 a = {
    s = reflPron ! Sg ! a.c2.rc ++ a.c2.s ++ a.s
    } ;    
   
 AdAP ada ap = {
    s = ada.s ++ ap.s
    } ;
    
 UseA2 a = a ;
   
 CAdvAP cadv ap np = {
    s = np.s ! cadv.c2.rc ++ cadv.c2.s ++ cadv.s ++ ap.s
    } ;
    
 AdvAP ap adv = {
    s = adv.s ++ ap.s
    } ;
   
 AdjOrd  ord = {
    s = ord.s
    } ;
    
 SentAP ap sc = {
    s = sc.s ++ "нь" ++ ap.s
    } ;

} 
