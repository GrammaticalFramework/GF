--# -path=.:../../prelude
--
----1 A Simple Sindhi Resource Morphology
----
----  by Jherna Devi, Shafqat Virk,2012
----
---- This resource morphology contains definitions needed in the resource
---- syntax. To build a lexicon, it is better to use $ParadigmsSnd$, which
---- gives a higher-level access to this module.
--
resource MorphoSnd = ResSnd ** open Prelude,Predef in {

 
 flags optimize=all ;
   coding = utf8;

----2 Nouns
oper
   
    mkN : (x1,_,_,_,_,_,_,x8 : Str) -> Gender -> Noun = 
      \sd,so,sv,sa, pd,po,pv,pa, g -> {
      s = table {
      Sg => table {
        Dir => sd ;
        Obl => so ;
        Voc => sv ;
        Abl => sa 
	  } ;
      Pl => table {
        Dir => pd ;
        Obl => po ;
        Voc => pv ;
        Abl => pa 
	  }
      } ;

      g = g
      } ;

	  
-- 1. msculine: chokro, kuto, hat  
	   mkN01 : Str -> Noun ;
  mkN01 chokro = let chokr = (tk 1 chokro) 
                in mkN (chokro)     (chokr+"y")       (chokr+"a")  (chokr+"a")    
                       (chokr+"a")   (chokr+"n")       (chokr+"a")  (chokr+"a")  
                    Masc ;


-- 2. karkhano
  mkN02 : Str -> Noun ;
  mkN02 karkhano =let karkhan = (tk 1 karkhano) 
					in mkN (karkhano)    (karkhan+"y")       (karkhan+"a")     (karkhano)
                   (karkhan+"a")    (karkhan+"n")  (karkhan+"W")         (karkhan+"a") 
                Fem ;

-- 3.  gher, shehar
  mkN03 : Str -> Noun ;
  mkN03 gher = mkN (gher)    (gher)       (gher)     (gher)
                   (gher)    (gher+"n")  (gher+"W")        (gher)
                Masc ;
				
-- 4. paki, mez, gah
  mkN04 : Str -> Noun ;
  mkN04 paki = mkN (paki)    (paki)       (paki)     (paki)
                   (paki)    (paki+"n")  (paki)        (paki)
                Fem ;

-- 5. msculine: bar, hotel, pathar
  mkN05 : Str -> Noun ;
  mkN05 bar = mkN (bar)    (bar)       (bar)     (bar)
                   (bar)    (bar+"n")  (bar+"W")      (bar) 
                Masc ;
				
-- 6. pe
  mkN06 : Str -> Noun ;
  mkN06 pe = mkN (pe)    (pe)       (pe)     (pe)
                   (pe+"e'r")    (pe+"e'rn")  (pe+"e'rW")    (pe+"e'r")
                Masc ;

-- 7. Feminine : ma
  mkN07 : Str -> Noun ;
  mkN07 ma = mkN (ma)    (ma)       (ma)     (ma)
                   (ma+"e'r")    (ma+"e'rn")  (ma+"e'rW")    (ma+"e'r")
                Fem ;
				
-- 8. msculine: topi, takre
  mkN08 : Str -> Noun ;
  mkN08 topi = mkN (topi)    (topi)       (topi)     (topi)
                   (topi+"Wn")    (topi+"n")  (topi+"W")          (topi+"Wn")
                Masc ;

-- 9. Feminine: bere, bili, kurse
  mkN09 : Str -> Noun ;
  mkN09 bili = mkN (bili)    (bili)       (bili)     (bili)
                   (bili+"Wn")    (bili+"n")  (bili+"n")         (bili+"Wn") 
                Fem ;
				
-- 10. msculine: bha
  mkN010 : Str -> Noun ;
  mkN010 bha = mkN (bha)    (bha)       (bha)     (bha)
                   (bha+"r")    (bha+"rn")  (bha+"rW")    (bha+"r")
                Masc ;

-- 11. Feminine: bhen
  mkN11 : Str -> Noun ;
  mkN11 bhen = let bhe= (tk 1 bhen) 
					in mkN (bhen)    (bhen)       (bhen)     (bhen)
                   (bhe+"nr")    (bhe+"nrn")  (bhen+"Wn")    (bhe+"nr")
                Fem ;
				
--12. msculine: raja, darya
  mkN12 : Str -> Noun ;
  mkN12 raja = mkN (raja)    (raja)       (raja)     (raja)
                   (raja)    (raja+"e'n")  (raja+"e'W")          (raja)
                Masc ;

-- 13. msculine: fan, son, kher,
  mkN13 : Str -> Noun ;
  mkN13 son = mkN (son)    (son)       (son)     (son)
                   (son)    (son)      (son)     (son)
                Masc ;
				
-- 14. Feminine: pen, samand
  mkN14 : Str -> Noun ;
  mkN14 pen = mkN (pen)    (pen)       (pen)     (pen)
                   (pen)    (pen) 	pen      ""
                Fem ;

				
   
----2 Determiners

  IDeterminer = {s:Gender => Str ; n : Number};
 
  makeDet : Str -> Str -> Str -> Str -> Number -> Determiner = \s1,s2,s3,s4,n -> {
   s = table {
      Sg => table {
        Masc => s1 ;
        Fem => s2 
	  } ;
      Pl => table {
        Masc => s3 ;
        Fem => s4 
	  }
      } ;

      n = n
	};	
	
  makeIDet : Str -> Str -> Number -> IDeterminer = \s1,s2,n -> {
   s = table {
        Masc => s1;
		Fem  => s2
	 };
	 n = n
    };
  
  makeIQuant : Str -> Str -> Str -> Str -> {s:Number => Gender => Str} = \s1,s2,s3,s4 -> {
   s = table {
      Sg => table {
        Masc => s1 ;
        Fem => s2 
	  } ;
      Pl => table {
        Masc => s3 ;
        Fem => s4 
	  }
      } 
	};	
    
-- Proposition  

  makePrep : Str -> Preposition = \str -> {s = str } **  { lock_Prep = <>};
   
----2 Pronouns
  --PronForm = {s:Pronoun => Str};

  DemonPronForm = {s:DemPronForm => Str};
  mkDemonPronForm : (x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16:Str) -> DemPronForm =
  \y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12,y13,y14,y15,y16 -> {
   s = table {
	        Sg => table {
				Masc => table {
				  Dir => y1 ;
				  Obl => y2 ;
				  Voc => y3 ;
				  Abl => y4
							 };
				Fem => table {
				  Dir => y5 ;
				  Obl => y6 ;
				  Voc => y7 ;
				  Abl => y8
							 }
						};
			Pl => table {
				Masc => table {
				  Dir => y9 ;
				  Obl => y10 ;
				  Voc => y11 ;
				  Abl => y12
							 };
				Fem => table {
				  Dir  => y13 ;
				  Obl => y14 ;
				  Voc => y15 ;
				  Abl => y16
 							 }
					} 
				}
               };    
			  
   makeDemonPronForm : Str -> Str -> Str -> DemPronForm ;
   makeDemonPronForm  yeh is inn = mkDemonPronForm 	yeh	is	"" yeh is "" yeh inn "" yeh inn "" "" "" "" "";	
--   makePossPronForm myra myry hmara hmary = mkDemonPronForm myra myra myra myry myry myry hmara hmara hmara hmary hmary hmary;

  mkPron : (x1,x2,x3,x4:Str) -> {s:Case => Str} = 
     \y1,y2,y3,y4 -> { s =
                      table {
                        Dir => y1;
                        Obl => y2;
                        Voc => y3;
			Abl => y4
                        }
                      };  
                                 
	------- PossPronForm yet to be implemented
	
 
-- IntPronForm = {s:InterrPronForm => Str};
  IntPronForm = {s: Case => Str};
  mkIntPronForm : (x1,x2,x3,x4:Str) -> IntPronForm =
  \y1,y2,y3,y4 -> {
   s = 
    table {
	            Dir => y1;
	            Obl => y2;
	            Voc => y3;
		    Abl => y4
		 }
	};
	

----2 Adjectives
-- defined in ResSnd

------------------------------------------------------------------
----Verbs
------------------------------------------------------------------
 
--1. Basic stem form, direct & indirect causatives exists
-- v1 nechna nechaana nechwana

  mkVerb : (_: Str) -> Verb = \inf ->
   let root  = (tk 1 inf) ; 
       inf = inf  ;  
       root2 = (tk 2 inf) ;  
    in { 
     s = table {

     Root     => root ;

     Inf      => inf ;
     Inf_Fem  => ((tk 1 root) + "y") ;
     Inf_Obl  => (tk 1 root) ;
     Ablative => ((tk 1 root) + "WN") ;


     VF tense person number gender  => (mkCmnVF root root2 tense person number gender).s 
    }
  } ;

  mkIrrgVerb : (inf,root: Str) -> Verb = \inf,root ->
   let root  = root ;  
    in { 
     s = table {

     Root     => root ;

     Inf      => inf ;
     Inf_Fem  => ((tk 1 inf) + "y") ;
     Inf_Obl  => (tk 1 inf) ;
     Ablative => ((tk 1 inf) + "WN") ;


     VF tense person number gender  => (mkCmnVF (root+"y") (root+"y") tense person number gender).s 
    }
  } ;
  

mkCmnVF : Str -> Str -> VTense -> PPerson -> Number -> Gender -> {s:Str}= \root,root2,t,p,n,g ->
  {s = case (last root) of {
     ("a"|"A"|"y") => (mkCmnVF1 root t p n g).s ;
     _ => (mkCmnVF1 root t p n g).s
   }
  };

 mkCmnVF1 : Str -> VTense -> PPerson -> Number -> Gender -> {s:Str}= \root,t,p,n,g ->
  {s = let nadaa = root + "ndW" ; --root + variants{"nda";"Wnda"};
          nadii = root + "Wn" ; --root + variants{"ndy";"Wndy"} ;
          nade  = root + "ndy" ; --root + variants{"ndy";"yndyn"} ;
           nadiiaaN = root + "ndW";  --root + variants{"ndyaN";"WndyaN"};
	   ndi = root + "ndy";
	   nda = root + "nda" ;
	   ndywn = root + "ndyWn" ;
		   ndyn = root + "ndyn" ;
	   
   in 
  case <t,p,n,g> of {
    <Subj,Pers1,         Sg,_> => root + "an" ;
    <Subj,Pers1,         Sg,_> => root + "an" ;
	<subj, Pers1,        pl,Masc>  => root + "Wn" ;
	<subj, Pers1,        pl,Fem>  => root + "Wn" ;
    <Subj,Pers2_Casual,  Sg,_> => root +"yn";
    <Subj,Pers2_Casual,  Pl,_> => root + "W" ;
    <Subj,Pers2_Respect, _, _> => root + "W" ;
	
	<Subj,Pers3_Near,  Sg,Masc> => root +"y";
	<Subj,Pers3_Near,  sg,Fem> => root +"y";
	<Subj,Pers3_Near,  pl,Masc> => root +"n";
	<Subj,Pers3_Near,  pl,Fem> => root +"n";
	<Subj,Pers3_Distant,Sg,Masc> => root +"y";
	<Subj,Pers3_Distant,Sg,Fem> => root +"y";
	<Subj,Pers3_Distant,Pl,Masc> => root +"n";
	<Subj,Pers3_Distant,Pl,Fem> => root +"n";
    

    <Perf, Pers1,Sg,Masc> => root + "yL" ;
    <Perf, Pers1,Sg,Fem>  => root + "yL" ;
    <Perf, Pers1,Pl,Masc> => root + "yL" ;
    <Perf, Pers1,Pl,Fem>  => root + "yL" ;
    <Perf, Pers2_Casual,Sg,Masc> => root + "yL" ;
    <Perf, Pers2_Casual,Sg,Fem>  => root + "yL" ;
    <Perf, Pers2_Casual,Pl,Masc> => root + "yL" ;
    <Perf, Pers2_Casual,Pl,Fem>  => root + "yL" ;
    <Perf, Pers2_Respect,Sg,Masc> => root + "yL" ;   
	<Perf, Pers2_Respect,Sg,Fem>  => root + "yL" ;    
	<Perf, Pers2_Respect,Pl,Masc>  => root + "yL" ;    
	<Perf, Pers2_Respect,Pl,Fem>   => root + "yL" ;    	

    <Perf, _,            Sg,Masc> => root + "yL" ;
    <Perf, _,            Sg,Fem>  => root + "yL" ;
    <Perf, _,            Pl,Masc> => root + "yL" ;
    <Perf, _,            Pl,Fem>  => root + "yL" ;

    <Imperf, Pers1,Sg, Masc> => root + "ndW"  ;
    <Imperf, Pers1,Sg, Fem>  => root + "ndy" ;
    <Imperf, Pers1,Pl, Masc> => root + "nda"  ;
    <Imperf, Pers1,Pl, Fem>  => root + "ndyWn"  ;

    <Imperf, Pers2_Casual,  Sg, Masc> => root + "ndW" ;
    <Imperf, Pers2_Casual,  Sg, Fem>  => root + "ndy"  ;
    <Imperf, Pers2_Casual,  Pl, Masc> => root + "nda"  ;
    <Imperf, Pers2_Casual,  Pl, Fem>  => root + "ndyWn"  ;
    
	<Imperf, Pers2_Respect, Sg, Masc>    => root + "nda" ;
    <Imperf, Pers2_Respect, Sg, Fem> => root + "ndyWn" ;
	<Imperf, Pers2_Respect, Pl, Masc> => root + "nda" ;	
    <Imperf, Pers2_Respect, Pl, Fem>  => root + "ndyWn"  ;
    
	<Imperf, _, Sg, Masc> => root + "ndW"  ;
    <Imperf, _, Sg, Fem>  => root + "ndy"  ;
	<Imperf, _, Pl, Masc> => root + "nda"  ;
    <Imperf, _, Pl, Fem>  => root + "ndyWn"  
	
  }
 } ;
  

 mkCmnVF2 : Str -> VTense -> PPerson -> Number -> Gender -> {s:Str}= \inf,t,p,n,g ->
  {s = 
  case <t,p,n,g> of {
    <_, _, _,_>  => inf
	}
 };
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
  
}
