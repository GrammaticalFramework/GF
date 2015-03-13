--# -path=.:../abstract:../common:../prelude

concrete ConjunctionMon of Conjunction = CatMon ** open ResMon, Coordination, Prelude in {

 flags optimize=all_subs ;  coding=utf8 ;

lin
 ConjAdv, ConjAP, ConjIAdv = conjunctDistrSS ;
 ConjS conj s = conjunctDistrTable SType conj s ;
 ConjRS conj rs = conjunctDistrTable ComplType conj rs ** {
    existSubject = rs.existSubject
    } ;
	
 ConjNP conj ss = conjunctDistrTable RCase conj ss ** {
    n = ss.n ; 
    p = ss.p ; 
    isPron = False ;
	isDef = ss.isDef
    } ;
 ConjCN conj cn = conjunctDistrTable2 Number NCase conj cn ;
  
-- These fun's are generated from the list cat's.

 BaseS x y = twoTable SType x y ;
 ConsS x y = consrTable SType comma x y ;
 BaseAdv = twoSS ;
 ConsAdv = consrSS comma ;
 
 BaseNP x y = twoTable RCase x y ** {
    n = conjNumber x.n y.n ; 
    p = conjPerson x.p y.p ; 
    isPron = andB x.isPron y.isPron ;
	isDef = andB x.isDef y.isDef
    } ;
    
 ConsNP x y = consrTable RCase comma x y ** {
    n = conjNumber x.n y.n ; 
    p = conjPerson x.p y.p ; 
    isPron = andB x.isPron y.isPron ;
	isDef = andB x.isDef y.isDef
    } ;
 BaseAP = twoSS ;
 ConsAP = consrSS comma ;
 BaseRS x y = twoTable ComplType x y ** {
    existSubject = andB x.existSubject y.existSubject
    } ;
 ConsRS x y = consrTable ComplType comma x y ** {
    existSubject = y.existSubject 
	}; 
 BaseIAdv = twoSS ;
 ConsIAdv = consrSS comma ;
 BaseCN x y = twoTable2 Number NCase x y ;
 ConsCN x y = consrTable2 Number NCase comma x y ;
 
lincat
 [Adv],[AP],[IAdv] = {s1,s2 : Str} ;
 [S] = {s1,s2 : SType => Str} ;
 [RS] = {s1,s2 : ComplType => Str ; existSubject : Bool} ;
 [NP] = {s1,s2 : RCase => Str ; n : Number ; p : Person ; isPron : Bool ; isDef : Bool} ;
 [CN] = {s1,s2 : Number => NCase => Str} ;
 
}

