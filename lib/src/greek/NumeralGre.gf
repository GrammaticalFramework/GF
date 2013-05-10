concrete NumeralGre of Numeral = CatGre  ** open ResGre,Prelude in {

 flags coding= utf8 ;


lincat 
  Digit = {s : DForm => CardOrd => Str} ;
  Sub10 = {s : DForm => CardOrd => Str ; n : Number} ;
  Sub100     = {s : CardOrd =>  Str ; n : Number} ;
  Sub1000    = {s :  CardOrd => Str ; n : Number} ;
  Sub1000000 = {s : CardOrd =>  Str ; n : Number} ;




lin num x =  x ; 

lin n2 = mkNum "δύο" "δώδεκα" "είκοσι" "διακόσια" "δεύτερος" "δωδέκατος" "εικοστός" "διακοσιοστός" "δις" "δωδεκάκις" "εικοσάκις" "διακοσάκις" ;

lin n3 = mkNum3 "τρία" "δεκατρία" "τριάντα" "τριακόσια" "τρίτος" "τριακοστός" "τριακοσιοστός" "τρις" "δεκατριάκις" "τριαντάκις" "τριακοσάκις";

lin n4 = mkNum3 "τέσσερα"  "δεκατέσσερα" "σαράντα" "τετρακόσια" "τέταρτος" "τεσσαρακοστός" "τετρακοσιοστός" "τετράκις" "δεκατετράκις" "τεσσαρακοντάκις" "τετρακοσάκις" ;

lin n5 = mkNum2 "πέντε"  "δεκαπέντε"  "πενήντα" "πεντακόσια" "πέμπτος" "πεντηκοστός" "πεντακοσιοστός" "πεντάκις" "δεκαπεντάκις" "πεντηκοντάκις" "πεντακοσάκις";

lin n6 = mkNum2 "έξι" "δεκαέξι"  "εξήντα" "εξακόσια" "έκτος" "εξηκοστός" "εξακοσιοστός" "εξάκις" "δεκαεξάκις" "εξηκοντάκις" "εξακοσάκις" ;

lin n7 = mkNum2 "εφτά" "δεκαεφτά"  "εβδομήντα" "εφτακόσια" "έβδομος" "εβδομηκοστός" "εφτακοσιοστός" "εφτάκις" "δεκαεφτάκις" "εβδομηκοντάκις" "επτακοσάκις";

lin n8 = mkNum2 "οχτώ" "δεκαοχτώ" "ογδόντα" "οχτακόσια" "όγδοος"  "ογδοηκοστός" "οχτακοσιοστός" "οχτάκις" "δεκαοκτάκις" "ογδοηκοντάκις" "οκτακοσάκις";

lin n9 = mkNum2 "εννιά" "δεκαεννιά" "ενενήντα"   "εννιακόσια"  "ένατος"  "ενενηκοστός" "εννιακοσιοστός" "εννιάκις" "δεκαεννεάκις" "ενενηκοντάκις" "εννεακοσάκις";

lin pot01 = mkNumEna "ένα" "έντεκα" "ενδέκατος" "δέκα" "εκατό"  "πρώτος" "δέκατος" "εκατοστός" "εντεκάκις" "δεκάκις" "εκατοντάκις" ** {n = Sg} ;
lin pot0 d = d ** {n = Pl} ;
lin pot110 = {s=\\c => pot01.s ! ten  ! c;  n = Pl} ;
lin pot111 = spl ((mkNumEna "" "έντεκα" "ενδέκατος" "" "" "" "" "" "εντεκάκις" "" "").s !teen ) ;
lin pot1to19 d = {s = d.s ! teen } ** {n = Pl} ;
lin pot0as1 n = {s = n.s ! unit}  ** {n = n.n} ;
lin pot1 d = {s = d.s ! ten} ** {n = Pl} ;
lin pot1plus d e = {s = \\co => 
                    d.s ! ten ! co ++  e.s ! unit !co  ; n = Pl} ;
lin pot1as2 n = n ;
lin pot2 d = {s = d.s ! hundr isNot} ** {n = Pl} ;
lin pot2plus d e = {s = \\co => 
                    d.s ! hundr Is !   co ++ e.s ! co ; n = Pl} ;
lin pot2as3 n = n ;

lin pot3 n = {
  s = \\co => case n.n of { 
    Sg => Xilias co n.s n.n ++ cardOrdXiliaSg  "χίλια" "χιλιοστός" ! co  ;
    Pl => Xilias co n.s n.n ++ cardOrdXiliaPl "χιλιάδες" "χιλιοστός" ! co  }
  } ** {n = Pl} ;


lin pot3plus n m = {
    s = \\co => case n.n of { 
        Sg => Xilias co n.s n.n ++   cardOrdXiliaSg  "χίλια" "χιλιοστός" ! co ++ m.s ! co ;
        Pl =>  Xilias co n.s n.n ++  cardOrdXiliaPl "χιλιάδες"   "χιλιοστός" ! co ++ m.s ! co }
    } ** {n = Pl} ; 


oper 



invNum : CardOrd = NCard Fem Nom ;


Xilias : CardOrd -> (CardOrd => Str) -> Number -> Str = \co,d,n -> 
    case n of {Sg =>[] ; _ => 
       case co of {
         NOrd _ _ _ => d ! NCardX ; 
         _ => d ! invNum 
         }
     } ;



    -----regular form of numerals-------
    mkNum : (x1,_,_,_,_,_,_,_,_,_,_,x11 : Str) -> {s : DForm => CardOrd => Str} =
      \dyo,dwdeka,eikosi,diakosia,deyteros,dwdekatos,eikostos,diakosiostos,dis,dwdekakis,eikosakis, diakosakis -> 
      {s = table {
           unit => cardOrd dyo deyteros  dis;
           teen => cardOrd dwdeka dwdekatos dwdekakis;
           ten  => cardOrd  eikosi eikostos  eikosakis ;
           hundr _ => cardOrd4  diakosia diakosiostos diakosakis 
           }
          } ;

      


        -----case with complex teen ("δεκατος έβδομος") -------
      mkNum2 : (x1,_,_,_,_,_,_,_,_,_,x10 : Str) -> {s : DForm => CardOrd => Str} =
        \dyo,dwdeka,eikosi,diakosia,deyteros,eikostos,diakosiostos,dis, dwdekakis,eikosakis,  diakosakis -> 
        {s = table {
           unit => cardOrd dyo deyteros dis ;
           teen => cardOrd2 dwdeka deyteros dwdekakis ;
           ten  => cardOrd  eikosi eikostos  eikosakis;
           hundr _ => cardOrd4  diakosia diakosiostos diakosakis
           }
        } ;

     mkNum3 : (x1,_,_,_,_,_,_,_,_,_,x10 : Str) -> {s : DForm => CardOrd => Str} =
        \tria,dekatria,trianta,triakosia,tritos,triakostos,triakosiostos,tris,dekatriakis, triantakis, triakosakis -> 
        {s = table {
           unit => cardOrd4 tria tritos tris ;
           teen => cardOrd3 dekatria tritos dekatriakis ;
           ten  => cardOrd  trianta triakostos triantakis ;
           hundr _ => cardOrd4  triakosia triakosiostos triakosakis
           }
        } ;


      -----Number 1 is a case itself. ------
      mkNumEna : (x1,_,_,_,_,_,_,_,_,_,x11 : Str) -> {s : DForm => CardOrd => Str} =
        \ena,enteka,endekatos, deka,ekato, protos,dekatos,ekatostos, entekakis,dekakis, ekatontakis-> 
        {s = table {
           unit => cardOrd4 ena protos ena ;
           teen => cardOrd enteka endekatos entekakis;
           ten  => cardOrd  deka dekatos dekakis;
           hundr Is =>   cardOrd (ekato + "ν") ekatostos ekatontakis  ;
           hundr isNot =>  cardOrd  ekato ekatostos ekatontakis
           }
          } ;



     cardOrd : Str -> Str ->Str -> CardOrd => Str = \dyo,deyteros,dis ->
        table {
            NCard _  _ => dyo ;
            NCardX => dis ;
            NOrd g n c  => (regAdj deyteros).s ! Posit ! g ! n ! c  
      } ;

    cardOrd2 : Str -> Str -> Str ->  CardOrd => Str = \dyo,deyteros, dis ->
        table {
            NCard _  _ => dyo ;
            NCardX => dis;
            NOrd g n c  => (regAdj "δέκατος").s ! Posit ! g ! n ! c  ++ (regAdj deyteros).s ! Posit ! g ! n ! c  
      } ;


    cardOrd3 : Str -> Str ->Str -> CardOrd => Str = \tria,tritos, tris ->
        table {
            NCard g  c  => case <g,c> of {
                <Masc, Gen|CPrep P_Dat> => mkGen134 tria;
                <Masc, Nom > => mkMasc134 tria;
                <Masc, _> => mkMascAcc134 tria;
                <Fem, Nom | Acc | Vocative | CPrep P_se |CPrep PNul > => mkFem134 tria ;
                <Neut | Change,  Nom | Acc | Vocative|CPrep P_se |CPrep PNul > => tria  ;
                <Neut | Change,  Gen|CPrep P_Dat> => mkGen134 tria;
                <Fem, Gen|CPrep P_Dat> => mkGenFem134 tria
                } ; 
            NCardX => tris ;
            NOrd g n c  => (regAdj "δέκατος").s ! Posit ! g ! n ! c  ++ (regAdj tritos).s ! Posit ! g ! n ! c  
          } ;

    cardOrd4 : Str -> Str ->Str ->  CardOrd => Str = \tria,tritos, tris ->
        table {
            NCard g  c  => case <g,c> of {
                <Masc , Gen|CPrep P_Dat> => mkGen134 tria;
                <Masc, Nom > => mkMasc134 tria;
                <Masc, _> => mkMascAcc134 tria;
                <Fem, Nom | Acc | Vocative | CPrep P_se |CPrep PNul > => mkFem134 tria ;
                <Neut | Change,  Nom | Acc | Vocative |CPrep P_se |CPrep PNul > => tria  ;
                <Neut | Change,  Gen|CPrep P_Dat> => mkGen134 tria;
                <Fem, Gen|CPrep P_Dat> => mkGenFem134 tria
               } ; 
            NCardX => tris ;
            NOrd g n c  =>  (regAdj tritos).s ! Posit ! g ! n ! c  
          } ;


    cardOrdXiliaSg : Str -> Str -> CardOrd => Str = \xilia, xiliostos ->
        table {
            NCard g  c  => case <g,c> of {
                <Masc, Gen|CPrep P_Dat> => mkGen134 xilia;
                <Masc, Nom > => mkMasc134 xilia;
                <Masc, _> => mkMascAcc134 xilia;
                <Fem, Nom | Acc | Vocative | CPrep P_se |CPrep PNul > => mkFem134 xilia ;
                <Neut | Change,  Nom | Acc | Vocative |CPrep P_se |CPrep PNul > => xilia  ;
                <Neut | Change,  Gen|CPrep P_Dat> => mkGen134 xilia;
                <Fem, Gen|CPrep P_Dat> => mkGenFem134 xilia 
              } ; 
            NCardX => [] ;
            NOrd g n c  =>  (regAdj xiliostos).s ! Posit ! g ! n ! c  
          } ;


    cardOrdXiliaPl : Str -> Str ->  CardOrd => Str = \xiliades,xiliostos ->
        table {
           NCard g  c  => case <g,c> of {
                <_,Nom | Acc | Vocative | CPrep P_se |CPrep PNul> => xiliades ;
                <_,Gen|CPrep P_Dat> => mkPlxiliaGen xiliades
              } ; 
           NCardX => [] ;
           NOrd g n c  =>  (regAdj xiliostos).s ! Posit ! g ! n ! c  
          } ;

      


       mkGen134: Str -> Str = \s -> case s of
          { 
          x+ "τρία"    => x+ "τριών" ;
          x+ "ένα"     => x+  "ενός" ;
          x+ "τέσσερα" => x+  "τεσσάρων" ;
          x+ "όσια"    => x+  "οσίων";
          x+ "χίλια"   => x+  "χιλίων"
          };

      mkMasc134: Str -> Str = \s -> case s of
          { 
          x+ "τρία"    => x+  "τρείς" ;
          x+  "ένα"    => x+  "ένας" ;
          x+ "τέσσερα" => x+  "τέσσερεις" ;
          x+ "όσια"    => x+  "όσιοι";
          x+ "χίλια"   => x+  "χίλιοι"
          };


     mkMascAcc134: Str -> Str = \s -> case s of
          { 
          x+ "τρία"    => x+  "τρείς" ;
          x+  "ένα"    => x+  "έναν" ;
          x+ "τέσσερα" => x+  "τέσσερεις" ;
          x+ "όσια"    => x+  "όσιους";
          x+ "χίλια"   => x+  "χίλιους"
          };

    mkFem134: Str -> Str = \s -> case s of
          { 
          x+ "τρία"    => x+   "τρείς" ;
          x+   "ένα"   => x+  "μία" ;
          x+ "τέσσερα" => x+   "τέσσερεις" ;
          x+ "όσια"    => x+  "όσιες";
          x+ "χίλια"   => x+  "χίλιες"
          };

    mkGenFem134: Str -> Str = \s -> case s of
          { 
          x+ "τρία"    => x+  "τριών" ;
          x+   "ένα"   => x+  "μίας" ;
          x+ "τέσσερα" => x+ "τεσσάρων";
          x+ "όσια"    => x+  "οσίων";
          x+ "χίλια"   => x+  "χιλίων"
          };

  
    mkPlxiliaGen :Str -> Str = \s -> case s of
          { 
          x+ "χιλιάδες" => x+  "χιλιάδων" };



    spl : (CardOrd => Str) -> {s : CardOrd => Str ; n : Number} = \s -> {
        s = s ;
        n = Pl
      } ;
 


-- numerals as sequences of digits

   lincat 
    Dig = TDigit ;

  lin
    IDig d = d ;

    IIDig d i = {
      s = \\o => d.s ! NCard Neut  Nom ++ i.s ! o ;
      n = Pl
    } ;

    D_0 = mk2Dig "0" Pl;
    D_1 = mk3Dig "1"  Sg ; 
    D_2 = mk2Dig "2" Pl ;
    D_3 = mk2Dig "3" Pl;
    D_4 = mk2Dig "4" Pl;
    D_5 = mk2Dig "5" Pl;
    D_6 = mk2Dig "6" Pl;
    D_7 = mk2Dig "7" Pl;
    D_8 = mk2Dig "8" Pl;
    D_9 = mk2Dig "9" Pl ;

  oper
  
      mk3Dig : Str -> Number -> TDigit = \c,n -> {
      s = table {NCard _   _ => c ;
                 NCardX  => c ;
                 NOrd Masc _  _ => c + "ος" ; NOrd Fem _ _=> c + "η" ;
                 NOrd _ _  _=> c + "ο" 
                 } ; 
              n = n
          } ;


      mk2Dig : Str ->Number ->  TDigit = \c,n -> {
      s = table {NCard _   _ => c ; 
                 NCardX  => c ;
                 NOrd Masc _  _=> c + "ος" ; NOrd Fem _ _=> c + "η" ;
                 NOrd _ _  _=> c + "ο" 
                 } ;
            n = n
        } ;

    TDigit = { n : Number ;  s : CardOrd => Str } ;

}
