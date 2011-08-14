--# -path=alltenses

-- (c) 2011 Dana Dannells
-- Licensed under LGPL
-- Compiled with GF version 3.2

resource ResHeb =  open PatternsHeb, Prelude, Predef in {

  flags coding=utf8 ;

param

 Number = Sg | Pl | Dl ;
 Gender = Masc | Fem ;
 Species = Def | Indef ;
 Case = Nom | Acc | Dat ;
 Agr = Ag Gender Number Person;
 Person = Per1 | Per2 | Per3 ;
 Voice = Active | Passive | Reflexive ; 
 VPerNumGen = Vp1Sg | Vp1Pl | Vp2Sg Gender | Vp2Pl Gender | Vp3Sg Gender | Vp3Pl Gender ;
 Tense = Perf | Part | Imperf ;


oper
 
 VP = {v : Verb ; obj : Str} ; -- obj value to deal with direct objects 
 NP = {s :  Case => {obj : Str} ; a : Agr ; isDef : Bool ; sp : Species };

-------------------------------------------------  
-- Auxiliaries
-- Pronouns modify nouns in a noun phrase, they agree 
-- in gender and number with the head noun.

 pronNP : (s,a,d : Str) -> Gender -> Number -> Person ->  NP =
 \s,a,d,g,n,p ->  { 
    s =  
       table {
            Nom => {obj = s}  ;
	    Acc => {obj = a}  ;
	    Dat => {obj = []}
        };
    isDef = False ;
    sp = Indef ; 
    a = Ag g n p 
  } ;

-------------------------------------------------  
-- Predication

  agrV : Verb -> Tense ->  Agr -> Str = \v,t,a -> case a of {
    Ag g n p => v.s ! t ! (chooseForm g n p)  
  } ;
   
  chooseForm : Gender -> Number -> Person -> VPerNumGen = \g,n,p->
  case <g,n,p> of {
  <_,Sg,Per1> => Vp1Sg;
  <_,Pl,Per1> =>  Vp1Pl; 
  <_,Sg,Per2> => Vp2Sg g ; 
  <_,Pl,Per2> => Vp2Pl g ; 
  <_,Sg,Per3> => Vp3Sg g ; 
  <_,Pl,Per3> => Vp3Pl g ;
    _         => Vp3Sg Masc
  };
   
-------------------------------------------------  
-- Roots and patterns for verbs 

oper    
 
    Pattern : Type = {C1, C1C2, C2C3, C3 : Str}; 
    Root    : Type = {C1,C2,C3 : Str};	   -- most verb roots consist of three consonants
    Root4   : Type = Root ** {C4 : Str};   -- for verb roots with four consonants


-------------------------------------------------  
-- Morphology

oper    
   
   Noun : Type = {s : Number => Species => Str ; g : Gender} ; 
   Adj  : Type = {s : Number => Species => Gender => Str} ; 
   Verb : Type = {s : Tense => VPerNumGen  => Str } ;
   Verb2 : Type = Verb ** {c : Case} ; 

-------------------------------------------------  
-- Nouns  
-- Nouns have different endings, 
-- some are also duals: his- anashim, bait- batim, bat-banot. 

oper    

mkNoun : (bait,batim,batimD : Str) -> Gender -> Noun = \bait,batim,batimD,g -> {
	s = table {
		Sg => table{Indef => bait ; Def => defH bait};
		Pl => table{Indef => batim ; Def => defH batim} ;
		Dl => table{Indef => batimD ; Def => defH batimD}
		};
	g=g ;
  }; 

-- For some nouns it is not possible to infer the gender from the pefix, 
-- depending on the gender, a noun can either end with yM or wt. 

regNoun2 :  Str -> Gender -> Noun = \root,g -> 
	case root of {
	heret + c@? => table {
		Masc => mkNoun root (heret + replaceLastLet (c) + "yM" ) ("")  g;
		Fem => mkNoun root (heret + replaceLastLet (c) + "wt") ("") g
 		  } ! g
  } ;
		
-- For regular nouns, it is possible to infer the gender from the pefix.

regNoun : Str -> Noun = 
	\root -> case root of {
        malc + "h" => mkNoun root (malc + "wt") ("") Fem ;
	mecon + "yt" => mkNoun root (mecon + "ywt") ("") Fem ; --  (it -> iyot)	
	khan + "wt" => mkNoun root (khan + "ywt") ("") Fem; -- (ut -> uyot)	
	tsalakh + "t" => mkNoun root (tsalakh + "wt") ("") Fem ; --  (at -> ot)
	_ => mkNoun root (root + "yM") ("")  Masc 
  } ;

mkN = overload {
    mkN : (root: Str) -> Noun = regNoun ;
    mkN : (kaf : Str) -> Gender-> Noun = regNoun2 ; 
    mkN : (bait, batim : Str) -> Gender -> Noun = \bait,batim -> mkNoun bait batim ""; 
    mkN : (regel,  raglayim,  raglaim : Str) -> Gender -> Noun = mkNoun ; 
  } ;
	
replaceLastLet :  Str -> Str = \c -> 
	 case c of {"P" => "p" ; "M" => "m" ; "N" => "n" ; "Z." => "Z" ; "K" => "k"; _ => c} ;
 
-------------------------------------------------  
-- Adjectives
-- Adjectives are formed either linearly, 
-- by adding a suffix without affecting the stem 
-- or discontinuously, by adding feminine or plural marker 
-- that requires a shift of stress in the word and certain 
-- vowel deletions and modifications.    

oper

regA : Str ->  Adj = \root 
	-> case root of { kaTan + c@? =>
	mkAdj root (kaTan + replaceLastLet (c) + "h") (kaTan +
	replaceLastLet (c) + "yM") (kaTan + replaceLastLet (c) + "wt") 
   };

regA2 : Str ->  Adj = \bwleT
	-> mkAdj bwleT  ( bwleT + "t") ( bwleT + "yM" ) (bwleT + "wt" ); 
	
mkAdj : (_,_,_,_ : Str) -> Adj = \tov,tova,tovim,tovot -> {
    s = table {
      	Sg => table { 
		Indef => table { Masc => tov ; Fem => tova } ; 
		Def => table { Masc => defH tov ; Fem => defH tova }  
            	} ; 
        _ => table { 
		Indef => table {Masc => tovim ; Fem  => tovot } ; 
		Def => table { Masc => defH tovim ; Fem  => defH tovot }
               }
         }
   };


-------------------------------------------------  
-- Determination

defH : Str -> Str = \cn ->
	case cn of {_ => "h" + cn};	


-------------------------------------------------  
-- Verbs 
-- The way of forming verbs follows the traditional 
-- Hebrew pattern group classification, called Binyanim. 
-- Each pattern has a three consonant slot structure with special
-- inflectional characteristics. 
-- Verbs are formed by a [root + pattern] combination.  
    
oper

dirV2: Verb -> Verb2 =\v -> 
       {
       s = v.s ;
       c = Acc	
       }; 
       

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
  };
 

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
  };
 
  appPattern : Root -> Pattern -> Str = \r,p ->
    p.C1 + r.C1 + p.C1C2 + r.C2 + p.C2C3 + r.C3 + p.C3 ;

-- remove the first letter
  appPattern2 : Root -> Pattern -> Str = \r,p ->
    p.C1 + p.C1C2 + r.C2 + p.C2C3 + r.C3 + p.C3 ;

  getRoot : Str -> Root = \s -> case s of {
    C1@? + C2@? + C3 => {C1 = C1 ; C2 = C2 ; C3 = C3} ;
    _ => Predef.error ("cannot get root from" ++ s)
    } ;

} 
