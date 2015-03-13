--# -path=.:../abstract:../common:../prelude

concrete RelativeMon of Relative = CatMon ** open ResMon, MorphoMon, Prelude in {

 flags optimize=all_subs ; coding=utf8 ;

lin

 RelCl cl = {
    s = \\t,ant,pol,_ => cl.s ! t ! ant ! pol ! Part Rel ;
	existSubject = True
    } ;

 RelVP rp vp = {
    s = \\t,ant,pol,_ => 
    let 
     cl = (mkClause (\\_ => []) Sg vp.vt Acc vp)
    in 
    cl.s ! t ! ant ! pol ! Part Object ;
	existSubject = False
    } ;
    
 RelSlash rp slash = {
    s = \\t,ant,pol,_ => slash.s ! t ! ant ! pol ! Part Object ++ slash.c2.s ;
	existSubject = False
    } ;

 IdRP = {s = []} ;
 
 FunRP p np rp = {
    s = np.s ! Nom ++ "нь"
    } ;
 
}

