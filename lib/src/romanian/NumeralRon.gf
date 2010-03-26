concrete NumeralRon of Numeral = CatRon ** 
  open  MorphoRon, CatRon, Prelude in {

flags coding = utf8 ;

param DForm = unit | teen | ten | teen_inf ;
param Placement = indep | attr ;

lincat Digit = {s : CardOrd => DForm => Str ; size : Size} ;
lincat Sub10 = {s : CardOrd => DForm => Placement => Str ; size : Size} ;
lincat Sub100 = {s : CardOrd => NumF => Placement => Str ; size : Size} ;
lincat Sub1000 = {s : CardOrd => NumF => Placement => Str ; size : Size} ;
lincat Sub1000000 = { s : CardOrd => NumF => Placement => Str; size : Size } ;



oper mkOrdinalForm : Str -> Gender ->  Str =
\two, g ->  case g of 
                  { Masc => case two of 
                            {x+"t"    => two+"ulea"; 
                             x + "ie" => x + "iilea";
                             _        => two+"lea" 
                            };      
                    Fem => case two of
                            { x + ("ă"|"u")   => x +"a"; 
                              x + "ei"        => two + "a";
                              x + "ii"        => x + "ia" ;
                              x + "i"         => x + "ea";
                              x + "ie"         => x +"a" ;
                              _               => two +"a" 
                            }
                   };                        
 
                
oper mkOrdinal : Str -> Gender -> ACase -> Str =
\two, g, fl ->  mkOrd (mkOrdinalForm two g) g fl;  

oper mkOrd : Str -> Gender -> ACase -> Str =
\two, g, fl -> let cc = (artPos g Sg ANomAcc) ++ two  
                        in
         case fl of
                { ANomAcc => cc ;             
                  AGenDat => (artDem g Sg AGenDat)++"de-"+(artPos g Sg ANomAcc)++ two ;
                  AVoc => cc
                };  


oper mkNum : Str -> Str -> Str -> Str -> Digit = 
 \two -> \twelve -> \twenty -> \doispe -> mkNumVSpc two twelve twelve twenty two doispe doispe (mkOrdinalForm two Masc) (mkOrdinalForm two Fem);


oper mkNumVSpc : Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> Digit = 
  \two -> \twelve -> \douasprezece -> \twenty -> \dou -> \doispe -> \douaspe -> \doilea -> \doua ->  
  {s = table { 
               NCard Masc  => table {unit => two ; teen => twelve ;
                                     ten => twenty ; teen_inf => doispe
                                    } ;
               NCard Fem  => table {unit => dou ; teen => douasprezece ;
                                    ten  => twenty ; teen_inf => douaspe 
                                   } ;                      
               NOrd Masc  => table {unit     => doilea ; 
                                    teen     => mkOrdinalForm twelve Masc ;   
                                    ten      => mkOrdinalForm twenty Masc ;   
                                    teen_inf => mkOrdinalForm doispe Masc       
                                   } ;
               NOrd Fem   => table {unit     => doua  ;
                                    teen     => mkOrdinalForm douasprezece Fem ;   
                                    ten      => mkOrdinalForm twenty Fem ;   
                                    teen_inf => mkOrdinalForm douaspe Fem        
                                   }                      
              } ;      
   size = less20 ;
   lock_Digit = <>
  } ;

oper regNum : Str -> Digit = 
  \trei -> mkNum trei (trei + "sprezece") (trei + "zeci") (trei + "şpe") ;


oper mkMidF : Str -> Str -> Sub100 =
\unsprezece, unspe -> 
{ s = table {NCard g => table { Formal   => \\_ => unsprezece  ;
                                Informal => \\_ => unspe  
                               };
             NOrd g  => table {Formal    => \\_ =>  mkOrdinalForm unsprezece g;
                               Informal  => \\_ => mkOrdinalForm unspe g 
                              }                 
            };
            
 size = less20 ;
 lock_Sub100 = <>
 };


lin num = \d ->
 { s = \\cse => table { NCard g => \\f => d.s ! (NCard g) ! f ! indep  ;
                        NOrd g => \\f =>  let ss = d.s ! (NOrd g) ! f ! indep
                                                 in 
                                       case d.size of 
                                              { sg => (artDem g Sg cse) ++ ss ;
                                                _  => mkOrd ss g cse
                                               }
                       };
   sp =  \\cse => table { NCard g => \\f => d.s ! (NCard g) ! f ! attr  ;
                        NOrd g => \\f =>  let ss = d.s ! (NOrd g) ! f ! indep
                                                 in 
                                       case d.size of 
                                              { sg => (artDem g Sg cse) ++ ss ;
                                                _  => mkOrd ss g cse
                                               }
                       };
   size = d.size
 } ; 
-- Latin A Supplement chars

lin n2 = mkNumVSpc "doi" "doispreze" "douăsprezece" "douăzeci" "două" "doişpe" "douăşpe" "doilea" "doua";
lin n3 = regNum "trei";
lin n4 = mkNum "patru" "paisprezece" "patruzeci" "paişpe";
lin n5 = mkNum "cinci" "cinsprezece" "cincizeci" "cinşpe";
lin n6 = mkNum "şase" "şaisprezece" "şaizeci" "şaişpe";
lin n7 = mkNum "şapte" "şaptesprezece" "şaptezeci" "şaptispe";
lin n8 = mkNum "opt" "optsprezece" "optzeci" "optişpe";
lin n9 = regNum "nouă";

lin pot01 = let num = mkNumVSpc "un" "unsprezece" "unsprezece" "zece" "o" "unşpe" "unşpe" "dintâi" "dintâi" ;
                dep = mkNumVSpc "unu" "unsprezece" "unsprezece" "zece" "una" "unşpe" "unşpe" "unulea" "una" 
                        
              in 
         { s = \\o,c => table {indep => num.s ! o ! c ;
                               attr  => dep.s ! o ! c
                                } ;
           size = sg 
          };            

lin pot0 d = { s = \\o, c => \\_ => d.s ! o ! c ;
               size = less20
              };

lin pot110 = mkMidF "zece" "zece" ;           

lin pot111 = mkMidF "unsprezece" "unşpe" ; 
                                       
lin pot1to19 = \d -> 
  {s = \\c => table { Formal   => \\_ => d.s ! c ! teen ;
                      Informal => \\_ => d.s ! c ! teen_inf 
                  };                        
   size = less20
  };
               
lin pot0as1  = \d -> 
  {s = \\c,_,p => d.s ! c ! unit ! p ;                                  
   size = d.size
  };
                   
lin pot1  = \d -> 
  {s = \\c => \\_,_ => d.s ! c ! ten ;                                        
   size = pl
  };


                 
lin pot1plus d e = 
  {s = table { 
          NCard g => \\_,_ => d.s ! (NCard g) ! ten ++ "şi" ++ e.s ! (NCard g) ! unit ! attr  ;
          NOrd g  => \\_,_ => d.s ! (NCard g) ! ten ++ "şi" ++ e.s ! (NOrd g) ! unit ! attr 
             };
   size = pl 
   };          
     
lin pot1as2 n = n ;

lin pot2 d = 
  {s = table {
              NCard g => \\_,_ => d.s ! (NCard Fem) ! unit ! indep ++ (mksute d.size) ; 
              NOrd g  => \\_,_ => d.s ! (NCard Fem) ! unit ! indep ++ (mkSute d.size g)       
             };
                     
  size = pl} ;
             
lin pot2plus d e = 
  {s = \\c,f,_ => d.s ! (NCard Fem) ! unit ! indep ++ (mksute d.size) ++ e.s ! c ! f ! attr ;    
   size = pl} ;

lin pot2as3 n = n ;
 
lin pot3 n = 
  {s =  table {  
              NCard g => \\f,p => mkmie n.size (n.s ! (NCard Fem) ! f ! indep)  ;
              NOrd g  => \\f,p => mkMie n.size g (n.s ! (NCard Fem) ! f ! indep)   
              };
  size = pl                     
  } ;


lin pot3plus n m = 
 {s = \\c, f, p => mkmie n.size (n.s ! (NCard Fem) ! f ! indep)  ++ m.s ! c ! f ! attr;                   
  size = pl                              
   };

oper mksute : Size -> Str = \sz -> table {sg => "sută" ; _ => "sute" } ! sz ; 
oper mkSute : Size -> Gender -> Str = \sz, g -> 
table {sg => mkOrdinalForm "sută" g  ;
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
    D_1 = mk3Dig "1" "1ul" "1a" sg ; ---- gender
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
