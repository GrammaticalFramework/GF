  --# -path=.:../abstract:../../prelude:../common

 resource ParadigmsHeb = open 
    Predef, 
    Prelude, 
    MorphoHeb,
    ResHeb,
    CatHeb
    in {

    flags optimize = noexpand;  coding=utf8 ;

 oper
          
  mkNoun : (bait,batim,batimD : Str) -> Gender -> Noun = \bait,batim,batimD,g -> {
	  s = table {
		  Sg => table{Indef => bait ; Def =>  ("ה" +bait)};
		  Pl => table{Indef => batim ; Def =>  ("ה" + batim)} ;
		  Dl => table{Indef => batimD ; Def =>  ("ה" +batimD)}
		  } ;
	  g=g ;
    }; 

  -- For some nouns it is not possible to infer the gender from the pefix, 
  -- depending on the gender, a noun can either end with yM or wt. 

  regNoun2 :  Str -> Gender -> Noun = \root,g -> 
	  case root of {
	  heret + c@? => table {
		  Masc => mkNoun root (heret + replaceLastLet (c) + "ים" ) ("")  g;
		  Fem => mkNoun root (heret + replaceLastLet (c) + "ות") ("") g
		    } ! g
    } ;
		  
  -- For regular nouns, it is possible to infer the gender from the pefix.

  regNoun : Str -> Noun = 
	  \root -> case root of {
	  malc + "ה" => mkNoun root (malc + "ות") ("") Fem ;
	  mecon + "ית" => mkNoun root (mecon + "יות") ("") Fem ; --  (it -> iyot)	
	  khan + "ות" => mkNoun root (khan + "יות") ("") Fem; -- (ut -> uyot)	
	  tsalakh + "ת" => mkNoun root (tsalakh + "ות") ("") Fem ; --  (at -> ot)
	  _ => mkNoun root (root + "ים") ("")  Masc 
    } ;

  mkN = overload {
      mkN : (root: Str) -> Noun = regNoun ;
      mkN : (kaf : Str) -> Gender-> Noun = regNoun2 ; 
      mkN : (bait, batim : Str) -> Gender -> Noun = \bait,batim -> mkNoun bait batim ""; 
      mkN : (regel,  raglayim,  raglaim : Str) -> Gender -> Noun = mkNoun ; 
    } ;
	  
  mkProperNoun : Str -> Gender -> PN = \str,gen -> 
      { 
	s = \\_ => str ;
        g = gen ;
        lock_PN = <>
    } ;
    
  mkPron : (s,a,d : Str) -> Gender -> Number -> Person -> Pron  = 
   \s,a,d,g,n,p ->  { 
    s =  
       table {
            Nom => {obj = s}  ;
	    Acc => {obj = a}  ;
	    Dat => {obj = []}
        };
    isDef = False ;
    sp = Indef ; 
    a = Ag g n p ;
    lock_Pron = <>
    } ;

  mkPrep : Str -> Bool -> Prep = \prepstr,ispre ->
     {
        s = prepstr; 
	isPre = ispre ; lock_Prep = <>
 	} ;


  mkPN  = overload {
    mkPN : Str -> Gender -> PN 
    = mkProperNoun ;
   } ;


   regA : Str ->  Adj = \root 
	-> case root of { 
	kaTan + c@? => mkAdj root (kaTan + replaceLastLet (c) + "ה") (kaTan +
	replaceLastLet (c) + "ים") (kaTan + replaceLastLet (c) + "ות") 
   };

   regA2 : Str ->  Adj = \bwleT
	-> mkAdj bwleT  ( bwleT + "ת") ( bwleT + "ים" ) (bwleT + "ות" ); 
	
   mkAdj : (_,_,_,_ : Str) -> Adj = \tov,tova,tovim,tovot -> {
    s = table {
      	Sg => table { 
		Indef => table { Masc => tov ; Fem => tova } ; 
		Def => table { Masc => ("ה" + tov) ; Fem =>  ("ה"
    + tova) }  
            	} ; 
        _ => table { 
		Indef => table {Masc => tovim ; Fem  => tovot } ; 
		Def => table { Masc =>  ("ה" + tovim) ; Fem  =>  ("ה" + tovot) }
               }
         }
   };
 
  mkAdv = overload { 
    mkAdv : Str -> Adv = \s -> {s = s ; lock_Adv = <>} ;
    } ;


 dirV2: Verb -> Verb2 =\v -> 
       {
       s = v.s ;
       c = Acc	
       } ; 
       

 mkVPaal : Str -> Verb = \v ->
  let root = getRoot v
    in {s = table { 
   Perf => table {        
      Vp1Sg       => appPattern root C1aC2aC3ti ;
      Vp1Pl       => appPattern root C1aC2aC3nu ;
	
      Vp2Sg Masc => appPattern root C1aC2aC3ta ;
      Vp2Sg Fem  => appPattern root C1aC2aC3t ;
      Vp2Pl Masc => appPattern root C1aC2aC3tem ;
      Vp2Pl Fem  => appPattern root C1aC2aC3ten ;
      
      Vp3Sg Masc => appPattern root C1aC2aC3 ;
      Vp3Sg Fem  => appPattern root C1aC2aC3a ;
      Vp3Pl Masc => appPattern root C1aC2aC3u ;
      Vp3Pl Fem  => appPattern root C1aC2aC3u 
	} ;

   Part => table {           
      Vp1Sg       => appPattern root C1oC2eC3 ;
      Vp1Pl       => appPattern root C1oC2C3im ;
	
      Vp2Sg Masc => appPattern root C1oC2eC3 ;
      Vp2Sg Fem  => appPattern root C1oC2eC3et ;
      Vp2Pl Masc => appPattern root C1oC2C3im ;
      Vp2Pl Fem  => appPattern root C1oC2C3ot ;
      
      Vp3Sg Masc => appPattern root C1oC2eC3;
      Vp3Sg Fem  => appPattern root C1oC2eC3et ;
      Vp3Pl Masc => appPattern root C1oC2C3im ;
      Vp3Pl Fem  => appPattern root C1oC2C3ot
	} ;
 
   Imperf => table {        
      Vp1Sg       => appPattern root eC1C2oC3 ;
      Vp1Pl       => appPattern root niC1C2oC3 ;
	
      Vp2Sg Masc => appPattern root tiC1C2oC3 ;
      Vp2Sg Fem  => appPattern root tiC1C2eC3i ;
      Vp2Pl Masc => appPattern root tiC1C2eC3o ;
      Vp2Pl Fem  => appPattern root tiC1C2eC3o ;
      
      Vp3Sg Masc => appPattern root yiC1C2oC3 ;
      Vp3Sg Fem  => appPattern root tiC1C2oC3 ;
      Vp3Pl Masc => appPattern root yiC1C2eC3u ;
      Vp3Pl Fem  => appPattern root yiC1C2eC3u  
	} 
      }
  } ;
 
mkVHifhil : Str -> Verb = \v ->
  let root = getRoot v
    in {s = table { 
   Perf => table {        
      Vp1Sg       => appPattern root hiC1C2aC3ti ;
      Vp1Pl       => appPattern root hiC1C2aC3nu ;
	
      Vp2Sg Masc => appPattern root hiC1C2aC3ta ;
      Vp2Sg Fem  => appPattern root hiC1C2aC3t ;
      Vp2Pl Masc => appPattern root hiC1C2aC3tem ;
      Vp2Pl Fem  => appPattern root hiC1C2aC3ten ;
      
      Vp3Sg Masc => appPattern root hiC1C2iC3 ;
      Vp3Sg Fem  => appPattern root hiC1C2iC3a ;
      Vp3Pl Masc => appPattern root hiC1C2iC3u ;
      Vp3Pl Fem  => appPattern root hiC1C2iC3u 
	} ;

   Part => table {           
      Vp1Sg       => appPattern root C1oC2eC3 ;
      Vp1Pl       => appPattern root C1oC2C3im ;
	
      Vp2Sg Masc => appPattern root C1oC2eC3 ;
      Vp2Sg Fem  => appPattern root C1oC2eC3et ;
      Vp2Pl Masc => appPattern root C1oC2C3im ;
      Vp2Pl Fem  => appPattern root C1oC2C3ot ;
      
      Vp3Sg Masc => appPattern root C1oC2eC3;
      Vp3Sg Fem  => appPattern root C1oC2eC3et ;
      Vp3Pl Masc => appPattern root C1oC2C3im ;
      Vp3Pl Fem  => appPattern root C1oC2C3ot
	};
   Imperf => table {        
      Vp1Sg       => appPattern root eC1C2oC3 ;
      Vp1Pl       => appPattern root niC1C2oC3 ;
	
      Vp2Sg Masc => appPattern root tiC1C2oC3 ;
      Vp2Sg Fem  => appPattern root tiC1C2eC3i ;
      Vp2Pl Masc => appPattern root tiC1C2eC3o ;
      Vp2Pl Fem  => appPattern root tiC1C2eC3o ;
      
      Vp3Sg Masc => appPattern root yiC1C2oC3 ;
      Vp3Sg Fem  => appPattern root tiC1C2oC3 ;
      Vp3Pl Masc => appPattern root yiC1C2eC3u ;
      Vp3Pl Fem  => appPattern root yiC1C2eC3u  
	} 	
     }
   } ;

mkVHifhil2 : Str -> Verb = \v ->
  let root = getRoot v  
     in {s = table { 
   Perf => table {        
      Vp1Sg       => appPattern2 root hiC1C2aC3ti ;
      Vp1Pl       => appPattern2 root hiC1C2aC3nu ;
	
      Vp2Sg Masc => appPattern2 root hiC1C2aC3ta ;
      Vp2Sg Fem  => appPattern2 root hiC1C2aC3t ;
      Vp2Pl Masc => appPattern2 root hiC1C2aC3tem ;
      Vp2Pl Fem  => appPattern2 root hiC1C2aC3ten ;
      
      Vp3Sg Masc => appPattern2 root hiC1C2iC3 ;
      Vp3Sg Fem  => appPattern2 root hiC1C2iC3a ;
      Vp3Pl Masc => appPattern2 root hiC1C2iC3u ;
      Vp3Pl Fem  => appPattern2 root hiC1C2iC3u 
	} ;

   Part => table {           
      Vp1Sg       => appPattern2 root C1oC2eC3 ;
      Vp1Pl       => appPattern2 root C1oC2C3im ;
	
      Vp2Sg Masc => appPattern2 root C1oC2eC3 ;
      Vp2Sg Fem  => appPattern2 root C1oC2eC3et ;
      Vp2Pl Masc => appPattern2 root C1oC2C3im ;
      Vp2Pl Fem  => appPattern2 root C1oC2C3ot ;
      
      Vp3Sg Masc => appPattern2 root C1oC2eC3;
      Vp3Sg Fem  => appPattern2 root C1oC2eC3et ;
      Vp3Pl Masc => appPattern2 root C1oC2C3im ;
      Vp3Pl Fem  => appPattern2 root C1oC2C3ot
	} ;
   Imperf => table {        
      Vp1Sg       => appPattern2 root eC1C2oC3 ;
      Vp1Pl       => appPattern2 root niC1C2oC3 ;
	
      Vp2Sg Masc => appPattern2 root tiC1C2oC3 ;
      Vp2Sg Fem  => appPattern2 root tiC1C2eC3i ;
      Vp2Pl Masc => appPattern2 root tiC1C2eC3o ;
      Vp2Pl Fem  => appPattern2 root tiC1C2eC3o ;
      
      Vp3Sg Masc => appPattern2 root yiC1C2oC3 ;
      Vp3Sg Fem  => appPattern2 root tiC1C2oC3 ;
      Vp3Pl Masc => appPattern2 root yiC1C2eC3u ;
      Vp3Pl Fem  => appPattern2 root yiC1C2eC3u  
	} 
     }
  } ;
 
mkVHitpael : Str -> Verb = \v ->
  let root = getRoot v
    in {s = table { 
   Perf => table {        
      Vp1Sg       => appPattern root hitC1C2aC3ti ;
      Vp1Pl       => appPattern root hitC1C2aC3nu ;
	
      Vp2Sg Masc => appPattern root hitC1C2aC3ta ;
      Vp2Sg Fem  => appPattern root hitC1C2aC3t ;
      Vp2Pl Masc => appPattern root hitC1C2aC3tem ;
      Vp2Pl Fem  => appPattern root hitC1C2aC3ten ;
      
      Vp3Sg Masc => appPattern root hitC1C2iC3 ;
      Vp3Sg Fem  => appPattern root hitC1C2iC3a ;
      Vp3Pl Masc => appPattern root hitC1C2iC3u ;
      Vp3Pl Fem  => appPattern root hitC1C2iC3u 
	} ;

   Part => table {           
      Vp1Sg       => appPattern root C1oC2eC3 ;
      Vp1Pl       => appPattern root C1oC2C3im ;
	
      Vp2Sg Masc => appPattern root C1oC2eC3 ;
      Vp2Sg Fem  => appPattern root C1oC2eC3et ;
      Vp2Pl Masc => appPattern root C1oC2C3im ;
      Vp2Pl Fem  => appPattern root C1oC2C3ot ;
      
      Vp3Sg Masc => appPattern root C1oC2eC3;
      Vp3Sg Fem  => appPattern root C1oC2eC3et ;
      Vp3Pl Masc => appPattern root C1oC2C3im ;
      Vp3Pl Fem  => appPattern root C1oC2C3ot
	};

   Imperf => table {        
      Vp1Sg       => appPattern root tiC1C2oC3 ;
      Vp1Pl       => appPattern root tiC1C2oC3 ;
	
      Vp2Sg Masc => appPattern root titC1C2C3 ;
      Vp2Sg Fem  => appPattern root titC1C2C3i ;
      Vp2Pl Masc => appPattern root titC1C2C3o ;
      Vp2Pl Fem  => appPattern root titC1C2C3nah ;
      
      Vp3Sg Masc => appPattern root yitC1C2C3 ;
      Vp3Sg Fem  => appPattern root titC1C2C3 ;
      Vp3Pl Masc => appPattern root yitC1C2C3u ;
      Vp3Pl Fem  => appPattern root titC1C2C3nah  
	} 	
     }
   } ;

mkVHufal : Str -> Verb = \v ->
  let root = getRoot v
    in {s = table { 
   Perf => table {        
      Vp1Sg       => appPattern root hiC1C2aC3ti ;
      Vp1Pl       => appPattern root hiC1C2aC3nu ;
	
      Vp2Sg Masc => appPattern root hiC1C2aC3ta ;
      Vp2Sg Fem  => appPattern root hiC1C2aC3t ;
      Vp2Pl Masc => appPattern root hiC1C2aC3tem ;
      Vp2Pl Fem  => appPattern root hiC1C2aC3ten ;
      
      Vp3Sg Masc => appPattern root hoC1C2C3 ;
      Vp3Sg Fem  => appPattern root hoC1C2C3a ;
      Vp3Pl Masc => appPattern root hoC1C2C3u ;
      Vp3Pl Fem  => appPattern root hoC1C2C3u 
	} ;

   Part => table {           
      Vp1Sg       => appPattern root C1oC2eC3 ;
      Vp1Pl       => appPattern root C1oC2C3im ;
	
      Vp2Sg Masc => appPattern root C1oC2eC3 ;
      Vp2Sg Fem  => appPattern root C1oC2eC3et ;
      Vp2Pl Masc => appPattern root C1oC2C3im ;
      Vp2Pl Fem  => appPattern root C1oC2C3ot ;
      
      Vp3Sg Masc => appPattern root C1oC2eC3;
      Vp3Sg Fem  => appPattern root C1oC2eC3et ;
      Vp3Pl Masc => appPattern root C1oC2C3im ;
      Vp3Pl Fem  => appPattern root C1oC2C3ot
	} ;

   Imperf => table {        
      Vp1Sg       => appPattern root eC1C2C3 ;
      Vp1Pl       => appPattern root niC1C2C3 ;
	
      Vp2Sg Masc => appPattern root taC1C2aC3 ;
      Vp2Sg Fem  => appPattern root taC1C2eC3i ;
      Vp2Pl Masc => appPattern root taC1C2eC3o ;
      Vp2Pl Fem  => appPattern root taC1C2aC3nah ;
      
      Vp3Sg Masc => appPattern root yaC1C2aC3 ;
      Vp3Sg Fem  => appPattern root taC1C2aC3 ;
      Vp3Pl Masc => appPattern root yaC1C2aC3u ;
      Vp3Pl Fem  => appPattern root taC1C2aC3nah  
	} 	
     }
   } ;

mkVPual : Str -> Verb = \v ->
  let root = getRoot v
    in {s = table { 
   Perf => table {        
      Vp1Sg       => appPattern root C1uC2aC3ti ;
      Vp1Pl       => appPattern root C1uC2aC3nu ;
	
      Vp2Sg Masc => appPattern root C1uC2aC3ti ;
      Vp2Sg Fem  => appPattern root C1uC2aC3t ;
      Vp2Pl Masc => appPattern root C1uC2aC3tem ;
      Vp2Pl Fem  => appPattern root C1uC2aC3ten ;
      
      Vp3Sg Masc => appPattern root hoC1C2C3 ;
      Vp3Sg Fem  => appPattern root hoC1C2C3a ;
      Vp3Pl Masc => appPattern root hoC1C2C3u ;
      Vp3Pl Fem  => appPattern root hoC1C2C3u 
	} ;

   Part => table {           
      Vp1Sg       => appPattern root C1oC2eC3 ;
      Vp1Pl       => appPattern root C1oC2C3im ;
	
      Vp2Sg Masc => appPattern root C1oC2eC3 ;
      Vp2Sg Fem  => appPattern root C1oC2eC3et ;
      Vp2Pl Masc => appPattern root C1oC2C3im ;
      Vp2Pl Fem  => appPattern root C1oC2C3ot ;
      
      Vp3Sg Masc => appPattern root C1oC2eC3;
      Vp3Sg Fem  => appPattern root C1oC2eC3et ;
      Vp3Pl Masc => appPattern root C1oC2C3im ;
      Vp3Pl Fem  => appPattern root C1oC2C3ot
	};

   Imperf => table {        
      Vp1Sg       => appPattern root eC1C2C3 ;
      Vp1Pl       => appPattern root niC1C2C3 ;
	
      Vp2Sg Masc => appPattern root taC1C2aC3 ;
      Vp2Sg Fem  => appPattern root taC1C2eC3i ;
      Vp2Pl Masc => appPattern root taC1C2eC3o ;
      Vp2Pl Fem  => appPattern root taC1C2aC3nah ;
      
      Vp3Sg Masc => appPattern root yaC1C2aC3 ;
      Vp3Sg Fem  => appPattern root taC1C2aC3 ;
      Vp3Pl Masc => appPattern root yaC1C2aC3u ;
      Vp3Pl Fem  => appPattern root taC1C2aC3nah  
	} 	
     }
   } ;


  }
