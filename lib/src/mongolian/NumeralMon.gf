--# -path=.:../abstract:../common:../prelude

concrete NumeralMon of Numeral = CatMon ** open ResMon, MorphoMon in {

 flags  coding=utf8 ;

lincat 
 Digit = {s : Place => DForm => CardOrd => Str} ;
 Sub10 = {s : Place => DForm => CardOrd => Str ; n : Number} ;
 Sub100, Sub1000 = {s : Place => CardOrd => Str ; n : Number} ; 
 Sub1000000 = {s : CardOrd => Str; n : Number} ;

oper
 mkCardOrd : Str -> CardOrd => Str = \unit -> 
   let 
    vt = MorphoMon.vowelType unit 
   in 
    table {
        NCard => unit ;
        NOrd => unit + dugaar2 ! vt
        } ;
		  
 mkNum : Str -> Str -> {s : Place => DForm => CardOrd => Str} = \unit,unitten ->
   let 
    vt = MorphoMon.vowelType unit 
   in {
    s = table {
        Indep => table {
                    Unit => mkCardOrd unit ;
                    Teen => mkCardOrd ("арван" ++ unit) ;
                    Ten => mkCardOrd unitten ;
                    Hundred => mkCardOrd (unitToattrUnit unit ++ "зуу") 
                    } ;
        Attr => table {
                    Unit => table {
                        NCard => unitToattrUnit unit ;
                        NOrd => unit + dugaar2 ! vt 
                        } ;
                    Teen => table {
                        NCard => "арван" + (unitToattrUnit unit) ;
                        NOrd => ("арван" ++ unit) + dugaar2 ! vt 
                        } ;
	                Ten => table {
                        NCard => tenToattrTen unitten ;
                        NOrd => unitten + dugaar2 ! vt 
                        } ;
                    Hundred => table {
                        NCard => (unitToattrUnit unit ++ "зуу" + "н") ;
                        NOrd => (unitToattrUnit unit ++ "зуу")+ dugaar2 ! vt
                        }
                    }
        }
    } ; 
     
 unitToattrUnit : Str -> Str = \unit -> case unit of {
    "нэг"    => "нэгэн" ;
    "хоёр"   => "хоёр" ;
    "гурав"  => "гурван" ;
    "дөрөв"  => "дөрвөн" ;
    "тав"    => "таван" ;
    "зургаа" => "зургаан" ;
    "долоо"  => "долоон" ;
    "найм"   => "найман" ;
    "ес"     => "есөн" 
    } ;
     
 tenToattrTen : Str -> Str = \ten -> case ten of {
    "арав" => "арван" ;
    "хорь" => "хорин" ;
    "гуч"  => "гучин" ;
    "дөч"  => "дөчин" ;
    "тавь" => "тавин" ;
    "жар"  => "жаран" ;
    "дал"  => "далан" ;
    "ная"  => "наян" ;
    "ер"   => "ерэн" 
    } ;
    
lin 
 num x = x ;
 n2 = mkNum "хоёр" "хорь" ;
 n3 = mkNum "гурав" "гуч" ; 
 n4 = mkNum "дөрөв" "дөч" ;
 n5 = mkNum "тав" "тавь" ;
 n6 = mkNum "зургаа" "жар" ;
 n7 = mkNum "долоо" "дал" ;
 n8 = mkNum "найм" "ная" ;
 n9 = mkNum "ес" "ер" ;

 pot01 = mkNum "нэг" "арав" ** {n = Sg} ;
   
 pot0 d = d ** {n = Pl} ;
 
 pot110 = {
    s = \\p,co => pot01.s ! p ! Ten ! co ; n = Pl 
    } ;
    
 pot111 = {
    s = \\p,co => pot01.s ! p ! Teen ! co ; n = Pl 
    } ;
    
 pot1to19 d = {
    s = \\p => d.s ! p ! Teen 
    } ** {n = Pl} ;
    
 pot0as1 n = {
    s = \\p => n.s ! p ! Unit ; n = n.n
    } ;
 
 pot1 d = {
    s = \\p => d.s ! p ! Ten ; n = Pl
    } ; 
    
 pot1plus d e = {
    s = \\p,co => d.s ! Attr ! Ten ! NCard  ++ e.s ! Indep ! Unit ! co ; n = Pl
    } ;
    
 pot1as2 n = n ;
 pot2 d = {
    s = \\p => d.s ! p ! Hundred  ; n = Pl
    } ;
    
 pot2plus d e = {
    s = \\p,co => d.s ! Attr ! Hundred ! NCard ++ e.s ! Indep ! co ; n = Pl
    } ;
    
 pot2as3 n = {
    s = n.s ! Indep ; n = n.n
    } ;
    
 pot3 n = {
    s = \\co => n.s ! Attr ! NCard ++ mkCardOrd "мянга" ! co ; n = Pl
    } ;
    
 pot3plus n m = {
    s = \\co => n.s ! Attr ! NCard ++ "мянга" ++ m.s ! Indep ! co ; n = Pl
    } ;

lincat 
 Dig = TDigit ;

lin
 IDig d = d ;

 IIDig d i = {
    s = \\co => d.s ! NCard ++ i.s ! co ;
    n = Pl
    } ;

 D_0 = mkDig "0" ;
 D_1 = mk3Dig "1" "1-р" Sg ;
 D_2 = mkDig "2" ;
 D_3 = mkDig "3" ;
 D_4 = mkDig "4" ;
 D_5 = mkDig "5" ;
 D_6 = mkDig "6" ;
 D_7 = mkDig "7" ;
 D_8 = mkDig "8" ;
 D_9 = mkDig "9" ;

oper
 mk2Dig : Str -> Str -> TDigit = \c,o -> mk3Dig c o Pl ;
 mkDig : Str -> TDigit = \c -> mk2Dig c (c + "-р") ;
 mk3Dig : Str -> Str -> Number -> TDigit = \c,o,n -> {
    s = table {
        NCard => c ; 
        NOrd => o
        } ; 
    n = n
    } ;

 TDigit = {
    s : CardOrd => Str ;
    n : Number
    } ;

}

