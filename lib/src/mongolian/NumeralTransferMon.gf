--# -path=.:../abstract:../common:../prelude

concrete NumeralTransferMon of NumeralTransfer = NumeralMon ** open ResMon, MorphoMon, CatMon in {

 flags  coding=utf8 ;

lin 
 digits2numeral d = {
    s = d.s ; 
	sp = \\rc => d.sp ! rc ; 
	n = d.n
	} ;

 digits2num d = d ;
 
 num2digits n = n ;

 dn10 d = {
    s = \\_,_,co => d.s ! co ;
    n = d.n
    } ;

 dn100 d1 d2 = {
    s = \\_,co => d1.s ! co ++ d2.s ! co ;
    n = Pl
    } ; 

 dn1000 d1 d2 d3 = {
    s = \\_,co => d1.s ! co ++ d2.s ! co ++ d3.s ! co ;
    n = Pl
    } ;

 dn1000000a d1 d2 d3 d4 = {
    s = \\co => d1.s ! co ++ d2.s ! co ++ d3.s ! co ++ d4.s ! co ;
    n = Pl
    } ;

 dn1000000b d1 d2 d3 d4 d5 = dn1000000a d1 d2 d3 d4 ** {
    s = \\co => d5.s ! co ;
    n = Pl
    } ;

 dn1000000c d1 d2 d3 d4 d5 d6 = dn1000000b d1 d2 d3 d4 d5 ** {
    s = \\co => d6.s ! co ;
    n = Pl
    } ;

 dn d = {
    s = \\_,_,co => d.s ! co
    } ;

 nd10 d = {
    s = \\co => d.s ! Indep ! Unit ! co ;
    n = Sg
    } ;

 nd100 d = {
    s = \\co => d.s ! Indep ! co ;
    n = Pl
    } ;

 nd1000 = nd100 ;

 nd1000000 d = d ;

 dconcat d1 d2 = {
    s = \\co => d1.s ! co ++ d2.s ! co ;
    n = Pl
    } ;

 nd d = {
    s = \\co => d.s ! Indep ! Unit ! co ;
    n = Pl
    } ;

}
