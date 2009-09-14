concrete NumeralRon of Numeral = CatRon ** 
  open  MorphoRon, CatRon, Prelude in {

param DForm = unit | teen | ten | attr ;


lincat Digit = {s : NumF => CardOrd => DForm => Str ; size : Size} ;
lincat Sub10 = {s : NumF => CardOrd => DForm => Str ; size : Size} ;
lincat Sub100 = {s : NumF => CardOrd  => Str ; size : Size} ;
lincat Sub1000 = {s : NumF => CardOrd => Str ; size : Size} ;
lincat Sub1000000 = { s : NumF => CardOrd => Str; size : Size } ;



oper mkOrdinalForm : Str -> Gender ->  Str =
\two, g ->  case g of 
                  { Masc => case two of 
                            {x+"t"    => two+"ulea"; 
                             x + "ie" => x + "iilea";
                             _        => two+"lea" 
                            };      
                    Fem => case two of
                            { x + ("ã"|"u")   => x +"a"; 
                              x + "ie"        => x +"ia";
                              x + ("ii"|"îi") => x + "a" ;
                              x + "i"         => two + "a";
                              x + "ie"         => x +"a" ;
                              _               => two +"a" 
                            }
                   };                        
 
                
oper mkOrdinal : Str -> Gender -> ACase -> Str =
\two, g, fl ->  mkOrd (mkOrdinalForm two g) g fl;  

oper mkOrd : Str -> Gender -> ACase -> Str =
\two, g, fl -> let cc = variants{(artPos g Sg ANomAcc)++ two ; 
                                   (artDem g Sg ANomAcc) ++ "de-"+(artPos g Sg ANomAcc) ++ two
                                   } in
         case fl of
                { ANomAcc => cc ;             
                  AGenDat => (artDem g Sg AGenDat)++"de-"+(artPos g Sg ANomAcc)++ two ;
                  AVoc => cc
                };  


oper mkNum : Str -> Str -> Str -> Str -> Digit = 
 \two -> \twelve -> \twenty -> \doispe -> mkNumVSpc two twelve twelve twenty two doispe doispe two (mkOrdinalForm two Fem);


oper mkNumVSpc : Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> Digit = 
  \two -> \twelve -> \douasprezece -> \twenty -> \doua -> \doispe -> \douaspe -> \o -> \una-> 
  {s = table { Formal => table {
                                 NCard Masc  => table {unit => two ; teen => twelve ; 
                                                       ten => twenty ; attr => two 
                                                       } ;
                                 NCard Fem  => table {unit => doua ; teen => douasprezece ;
                                                      ten  => twenty ; attr => o
                                                      } ;                      
                                 NOrd Masc  => table {unit => mkOrdinalForm two Masc ; 
                                                      teen => mkOrdinalForm twelve Masc ;   
                                                      ten  => mkOrdinalForm twenty Masc ;   
                                                      attr => mkOrdinalForm two Masc       
                                                       } ;
                                 NOrd Fem   => table {unit => mkOrdinalForm doua Fem  ;
                                                      teen => mkOrdinalForm douasprezece Fem ;   
                                                      ten  => mkOrdinalForm twenty Fem ;   
                                                      attr => una       
                                                      }                      
                                 } ;
                Informal => table {
                                 NCard Masc  => table {unit => two ; teen => doispe ; 
                                                       ten => twenty ; attr => two
                                                       } ;
                                 NCard Fem   => table {unit => doua ; teen => douaspe ;
                                                       ten => twenty ; attr => o
                                                       } ; 
                                 NOrd Masc   => table {unit => mkOrdinalForm two Masc ;
                                                       teen => mkOrdinalForm doispe Masc ;   
                                                       ten  => mkOrdinalForm twenty Masc ;   
                                                       attr => mkOrdinalForm two Masc      
                                                        } ;                                 
                                 NOrd Fem    => table {unit => mkOrdinalForm doua Fem ;
                                                       teen => mkOrdinalForm douaspe Fem ;   
                                                       ten  => mkOrdinalForm twenty Fem ;   
                                                       attr => una      
                                                        }
                                } 
       
       };
   size = less20 ;
   lock_Digit = <>
  } ;

oper regNum : Str -> Digit = 
  \trei -> mkNum trei (trei + "sprezece") (trei + "zeci") (trei + "ºpe") ;


oper mkMidF : Str -> Str -> Sub100 =
\unsprezece, unspe -> 
{ s = table { Formal =>table {
                              NCard g => unsprezece ;
                              NOrd g  => mkOrdinalForm unsprezece g
                              };       
              Informal => table{
                               NCard g => unspe;
                               NOrd g  => mkOrdinalForm unspe g                            
                               }                 
            } ;
size = less20 ;
lock_Sub100 = <>
};


 
lin num = \d ->
 { s = \\o => \\c => table { NCard g => d.s ! o ! (NCard g) ;
                             NOrd g => let ss = d.s ! o ! (NOrd g)
                                               in 
                                   case d.size of 
                                          { sg => (artDem g Sg c) ++ ss ;
                                            _  => mkOrd ss g c
                                            }
                            }; 
   size = d.size
 } ; 
-- Latin A Supplement chars

lin n2 = mkNumVSpc "doi" "doispreze" "douãsprezece" "douãzeci" "douã" "doiºpe" "douãºpe" "douã" "doua";
lin n3 = regNum "trei";
lin n4 = mkNum "patru" "paisprezece" "patruzeci" "paiºpe";
lin n5 = mkNum "cinci" "cinsprezece" "cincizeci" "cinºpe";
lin n6 = mkNum "ºase" "ºaisprezece" "ºaizeci" "ºaiºpe";
lin n7 = mkNum "ºapte" "ºaptesprezece" "ºaptezeci" "ºaptispe";
lin n8 = mkNum "opt" "optsprezece" "optzeci" "optiºpe";
lin n9 = regNum "nouã";

lin pot01 = let num = mkNumVSpc "unu" "unsprezece" "unsprezece" "zece" "o" "unºpe" "unºpe" "una" "una"
              in 
         { s = num.s ;
           size = sg 
          };            

lin pot0 d = d ;

lin pot110 = mkMidF "zece" "zece" ;           

lin pot111 = mkMidF "unsprezece"  "unºpe" ; 
                                       

lin pot1to19 = \d -> 
  {s = \\o,c  => d.s ! o ! c ! teen ;                      
  size = less20} ;
               
lin pot0as1  = \d -> 
  {s = \\o,c => d.s ! o ! c ! unit;                                  
  size = d.size} ;
                   
lin pot1  = \d -> 
  {s = \\o,c => d.s ! o ! c ! ten ;                                        
  size = pl} ;

                 
lin pot1plus d e = 
  {s = \\o => table {               
                NCard g => d.s ! o ! (NCard g) ! ten ++ "ºi" ++ e.s ! o ! (NCard g) ! attr ;
                NOrd g  => d.s ! o ! (NCard g) ! ten ++ "ºi" ++e.s ! o ! (NOrd g) ! attr                  
                    };
          
   size = pl} ;
     
lin pot1as2 n = n ;

lin pot2 d = 
  {s = \\o => table {
                NCard g => d.s ! o ! (NCard Fem) ! unit ++ (mksute d.size) ; 
                NOrd g  => d.s ! o ! (NCard Fem)! unit ++ (mkSute d.size g)       
                   };
                     
  size = pl} ;
              
lin pot2plus d e = 
  {s = \\o, c => d.s ! o ! (NCard Fem) ! unit ++ (mksute d.size) ++ e.s ! o ! c ;    
   size = pl} ;

lin pot2as3 n = 
 {s = \\o, c => n.s ! o ! c ;
  size = n.size                     
  };          
  
lin pot3 n = 
  {s = \\o => table {  
                   NCard g => mkmie n.size (n.s ! o ! (NCard Fem)) (n.s ! o ! (NCard Fem)) ;
                   NOrd g  => mkMie n.size g (n.s ! o ! (NCard Fem)) (n.s ! o ! (NCard Fem))  
                        };
  size = n.size                       
  } ;


lin pot3plus n m = 
 {s = \\o, c => (mkmie n.size (n.s ! o ! (NCard Fem)) (n.s ! o ! (NCard Fem))) ++ m.s ! Formal ! c;                   
  size = pl                              
   };

oper mksute : Size -> Str = \sz -> table {sg => "sutã" ; _ => "sute" } ! sz ; 
oper mkSute : Size -> Gender -> Str = \sz, g -> 
table {sg => mkOrdinalForm "sutã" g  ;
       _  => mkOrdinalForm "sute" g  } ! sz ;

oper mkmie : Size -> Str -> Str -> Str = \sz, attr, indep -> 
  table {sg => "o" ++ "mie" ;
         less20 => attr ++ "mii" ;
         pl => indep ++ "de" ++ "mii"} ! sz ;


oper mkMie : Size -> Gender -> Str -> Str -> Str = \sz, g, attr, indep ->
table { sg      => "o" ++ mkOrdinalForm "mie" g  ;
        less20  => attr ++ mkOrdinalForm "mii" g ;
        pl      => indep ++ "de" ++ mkOrdinalForm "mii" g  } ! sz ; 



--numerals as sequences of digits :

lincat 
    Dig = {s : CardOrd => Str; n : Number} ;

lin 
   IDig d = d ;

   IIDig d i = {
     s = \\o => d.s ! NCard Masc ++ i.s ! o ;
      n = Pl
    } ;
lin
    D_0 = mkDig "0" ;
    D_1 = mk3Dig "1" "1ul" "1a" Sg ; ---- gender
    D_2 = mkDig "2";
    D_3 = mkDig "3" ;
    D_4 = mkDig "4" ;
    D_5 = mkDig "5" ;
    D_6 = mkDig "6" ;
    D_7 = mkDig "7" ;
    D_8 = mkDig "8" ;
    D_9 = mkDig "9" ;


oper mkDig : Str -> Dig = \c -> mk3Dig c (c + "lea") (c + "a") Pl ;

oper  mk3Dig : Str -> Str -> Str-> Number -> Dig = \c,u,o,n -> {
      s = table {NCard g => c ; NOrd Masc => u ; NOrd Fem => o } ; 
      n = n;
      lock_Dig = <> 
      } ;

    TDigit = {s : CardOrd => Str; n : Number} ;


}
