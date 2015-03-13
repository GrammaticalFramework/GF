--# -path=.:../abstract:../common:../prelude

concrete AdverbMon of Adverb = CatMon ** open ResMon, Prelude in {

 flags  coding=utf8 ;

lin
 PositAdvAdj a = a ;
   
 ComparAdvAdj cadv a np = {
    s = (appCompl cadv.c2 np.s) ++ cadv.s ++ a.s  
    } ;
     
 ComparAdvAdjS cadv a s = {
    s = s.s ! (Part Object) ++ cadv.c2.s ++ cadv.s ++ a.s
    } ;

 PrepNP prep np = {s = np.s ! prep.rc ++ prep.s} ;

 AdAdv = cc2 ;

 PositAdAAdj a = a ;
   
 SubjS subj s = {s = subj.s ++ s.s ! Sub Condl} ;

 AdnCAdv cadv = {
    s = cadv.s ++ cadv.c2.s
    } ;

}

