concrete NumeralRon of Numeral = CatRon ** 
  open  MorphoRon, CatRon, Prelude in {

flags
  coding=cp1250;

param DForm = unit | teen | ten | teen_inf | attr;

lincat Digit = {s : CardOrd => DForm => Str ; size : Size} ;
lincat Sub10 = {s : CardOrd => DForm => Str ; size : Size} ;
lincat Sub100 = {s : CardOrd => NumF => Str ; size : Size} ;
lincat Sub1000 = {s : CardOrd => NumF => Str ; size : Size} ;
lincat Sub1000000 = { s : CardOrd => NumF => Str; size : Size } ;



oper mkOrdinalForm : Str -> Gender ->  Str =
\two, g ->  case g of 
                  { Masc => case two of 
                            {x+"t"    => two+"ulea"; 
                             x + "ie" => x + "iilea";
                             _        => two+"lea" 
                            };      
                    Fem => case two of
                            { x + "a"         => two ;
                              x + ("ã"|"u")   => x +"a"; 
                              x + "ei"        => two + "a";
                              x + "ii"         => x + "ia" ;
                              x + "i"         => x + "ea";
                              x + "ie"         => x +"a" ;
                              _               => two +"a" 
                            }
                   };                        
 
                
oper mkOrdinal : Str -> Gender -> ACase -> Str =
\two, g, fl ->  mkOrd (mkOrdinalForm two g) g fl;  

oper mkOrd : Str -> Gender -> ACase -> Str =
\two, g, fl -> let cc = variants{(artPos g Sg)++ two ; 
                                   (artDem g Sg ANomAcc) ++ "de-"+(artPos g Sg) ++ two
                                   } in
         case fl of
                { ANomAcc => cc ;             
                  AGenDat => (artDem g Sg AGenDat)++"de-"+(artPos g Sg)++ two ;
                  AVoc => cc
                };  


oper mkNum : Str -> Str -> Str -> Str -> Digit = 
 \two -> \twelve -> \twenty -> \doispe -> mkNumVSpc two twelve twelve twenty two doispe doispe (mkOrdinalForm two Masc) (mkOrdinalForm two Fem) two two;


oper mkNumVSpc : Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> Digit = 
  \two -> \twelve -> \douasprezece -> \twenty -> \dou -> \doispe -> \douaspe -> \doilea -> \doua ->
  \unu -> \una ->  
  {s = table { 
               NCard Masc  => table {unit => two ; teen => twelve ;
                                     ten => twenty ; teen_inf => doispe ; attr => unu
                                    } ;
               NCard Fem  => table {unit => dou ; teen => douasprezece ;
                                    ten  => twenty ; teen_inf => douaspe ; attr => una
                                   } ;                      
               NOrd Masc  => table {unit     => doilea ; 
                                    teen     => mkOrdinalForm twelve Masc ;   
                                    ten      => mkOrdinalForm twenty Masc ;   
                                    teen_inf => mkOrdinalForm doispe Masc ;      
                                    attr     => mkOrdinalForm unu Masc
                                   } ;
               NOrd Fem   => table {unit     => doua  ;
                                    teen     => mkOrdinalForm douasprezece Fem ;   
                                    ten      => mkOrdinalForm twenty Fem ;   
                                    teen_inf => mkOrdinalForm douaspe Fem ;
                                    attr     => mkOrdinalForm una Fem      
                                   }                      
              } ;      
   size = less20 ;
   lock_Digit = <>
  } ;

oper regNum : Str -> Digit = 
  \trei -> mkNum trei (trei + "sprezece") (trei + "zeci") (trei + "ºpe") ;


oper mkMidF : Str -> Str -> Sub100 =
\unsprezece, unspe -> 
{ s = table {NCard g => table { Formal   => unsprezece  ;
                                Informal => unspe  
                               };
             NOrd g  => table {Formal    =>  mkOrdinalForm unsprezece g;
                               Informal  => mkOrdinalForm unspe g 
                              }                 
            };
            
 size = less20 ;
 lock_Sub100 = <>
 };


lin num = \d ->
 { s = \\cse => table { NCard g => \\f => d.s ! (NCard g) ! f ;
                        NOrd g => \\f =>  let ss = d.s ! (NOrd g) ! f 
                                                 in 
                                       case d.size of 
                                              { sg => (artDem g Sg cse) ++ ss ;
                                                _  => mkOrd ss g cse
                                               }
                       }; 
   size = d.size
 } ; 
-- Latin A Supplement chars

lin n2 = mkNumVSpc "doi" "doispreze" "douãsprezece" "douãzeci" "douã" "doiºpe" "douãºpe" "doilea" "doua" "doi" "douã";
lin n3 = regNum "trei";
lin n4 = mkNum "patru" "paisprezece" "patruzeci" "paiºpe";
lin n5 = mkNum "cinci" "cinsprezece" "cincizeci" "cinºpe";
lin n6 = mkNum "ºase" "ºaisprezece" "ºaizeci" "ºaiºpe";
lin n7 = mkNum "ºapte" "ºaptesprezece" "ºaptezeci" "ºaptiºpe";
lin n8 = mkNum "opt" "optsprezece" "optzeci" "optiºpe";
lin n9 = regNum "nouã";

lin pot01 = let num = mkNumVSpc "un" "unsprezece" "unsprezece" "zece" "o" "unºpe" "unºpe" "dintâi" "dintâi" "unu" "una"              
              in 
         { s = \\o,c =>  num.s ! o ! c ;
           size = sg 
          };            

lin pot0 d = { s = \\o, c => d.s ! o ! c ;
               size = less20
              };

lin pot110 = mkMidF "zece" "zece" ;           

lin pot111 = mkMidF "unsprezece" "unºpe" ; 
                                       
lin pot1to19 = \d -> 
  {s = \\c => table { Formal    => d.s ! c ! teen ;
                      Informal  => d.s ! c ! teen_inf 
                  };                        
   size = less20
  };
               
lin pot0as1  = \d -> 
  {s = \\c,_ => d.s ! c ! unit ;                                  
   size = d.size
  };
                   
lin pot1  = \d -> 
  {s = \\c,_ => d.s ! c ! ten ;                                        
   size = pl
  };


                 
lin pot1plus d e = 
  {s = table { 
          NCard g => \\_ => d.s ! (NCard g) ! ten ++ "ºi" ++ e.s ! (NCard g) ! attr  ;
          NOrd g  => \\_ => d.s ! (NCard g) ! ten ++ "ºi" ++ e.s ! (NOrd g)  ! attr 
             };
   size = pl 
   };          
     
lin pot1as2 n = n ;

lin pot2 d = 
  {s = table {
              NCard g => \\_ => d.s ! (NCard Fem) ! unit  ++ (mksute d.size) ; 
              NOrd g  => \\_ => d.s ! (NCard Fem) ! unit  ++ (mkSute d.size g)       
             };
                     
  size = pl} ;
             
lin pot2plus d e = 
  {s = \\c,f => d.s ! (NCard Fem) ! unit ++ (mksute d.size) ++ e.s ! c ! f  ;    
   size = pl} ;

lin pot2as3 n = n ;
 
lin pot3 n = 
  {s =  table {  
              NCard g => \\f => mkmie n.size (n.s ! (NCard Fem) ! f )  ;
              NOrd g  => \\f => mkMie n.size g (n.s ! (NCard Fem) ! f )   
              };
  size = pl                     
  } ;


lin pot3plus n m = 
 {s = \\c, f => mkmie n.size (n.s ! (NCard Fem) ! f )  ++ m.s ! c ! f ;                   
  size = pl                              
   };

oper mksute : Size -> Str = \sz -> table {sg => "sutã" ; _ => "sute" } ! sz ; 
oper mkSute : Size -> Gender -> Str = \sz, g -> 
table {sg => mkOrdinalForm "sutã" g  ;
       _  => mkOrdinalForm "sute" g  } ! sz ;

oper mkmie : Size -> Str -> Str = \sz, attr -> 
  table {sg     => "o" ++ "mie" ;
         less20 => attr ++ "mii" ;
         pl     => attr ++ "de" ++ "mii"} ! sz ;


oper mkMie : Size -> Gender -> Str -> Str = \sz, g, attr ->
table { sg      => "o" ++ mkOrdinalForm "mie" g  ;
        less20  => attr ++ mkOrdinalForm "mii" g ;
        pl      => attr ++ "de" ++ mkOrdinalForm "mii" g  } ! sz ; 



--numerals as sequences of digits :

lincat 
    Dig = {s : CardOrd => Str; n : Size ; isDig : Bool} ;

lin 
   IDig d = d ;

   IIDig d i = {
     s = \\o => d.s ! NCard Masc ++ i.s ! o ;
      n = case d.n of
              { sg => if_then_else Size (i.isDig) less20 pl ;
                _  => pl           
              };
      isDig = False
    } ;
lin
    D_0 = mkDig "0" ;
    D_1 = mk3Dig "1" "1ul" "1a" sg ; 
    D_2 = mkDig "2";
    D_3 = mkDig "3" ;
    D_4 = mkDig "4" ;
    D_5 = mkDig "5" ;
    D_6 = mkDig "6" ;
    D_7 = mkDig "7" ;
    D_8 = mkDig "8" ;
    D_9 = mkDig "9" ;


oper mkDig : Str -> Dig = \c -> mk3Dig c (c + "lea") (c + "a") less20 ;

oper  mk3Dig : Str -> Str -> Str-> Size -> Dig = \c,u,o,n -> {
      s = table {NCard g => c ; NOrd Masc => u ; NOrd Fem => o } ; 
      n = n;
      isDig = True ;
      lock_Dig = <> 
      } ;

    TDigit = {s : CardOrd => Str; n : Size ; isDig : Bool} ;


}
