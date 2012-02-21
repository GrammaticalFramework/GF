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
                in mkN (chokro)     (chokr+"ی")       (chokr+"ا")  (chokr+"ا")    
                       (chokr+"ا")   (chokr+"ن")       (chokr+"ا")  (chokr+"ا")  
                    Masc ;


-- 2. karkhano
  mkN02 : Str -> Noun ;
  mkN02 karkhano =let karkhan = (tk 1 karkhano) 
					in mkN (karkhano)    (karkhan+"ی")       (karkhan+"ا")     (karkhano)
                   (karkhan+"ا")    (karkhan+"ن")  (karkhan+"و")         (karkhan+"ا") 
                Fem ;

-- 3.  gher, shehar
  mkN03 : Str -> Noun ;
  mkN03 gher = mkN (gher)    (gher)       (gher)     (gher)
                   (gher)    (gher+"ن")  (gher+"و")        (gher)
                Masc ;
				
-- 4. paki, mez, gah
  mkN04 : Str -> Noun ;
  mkN04 paki = mkN (paki)    (paki)       (paki)     (paki)
                   (paki)    (paki+"ن")  (paki)        (paki)
                Fem ;

-- 5. msculine: bar, hotel, pathar
  mkN05 : Str -> Noun ;
  mkN05 bar = mkN (bar)    (bar)       (bar)     (bar)
                   (bar)    (bar+"ن")  (bar+"و")      (bar) 
                Masc ;
				
-- 6. pe
  mkN06 : Str -> Noun ;
  mkN06 pe = mkN (pe)    (pe)       (pe)     (pe)
                   (pe+"۶ر")    (pe+"۶رن")  (pe+"۶رو")    (pe+"۶ر")
                Masc ;

-- 7. Feminine : ma
  mkN07 : Str -> Noun ;
  mkN07 ma = mkN (ma)    (ma)       (ma)     (ma)
                   (ma+"۶ر")    (ma+"۶رن")  (ma+"۶رو")    (ma+"۶ر")
                Fem ;
				
-- 8. msculine: topi, takre
  mkN08 : Str -> Noun ;
  mkN08 topi = mkN (topi)    (topi)       (topi)     (topi)
                   (topi+"ون")    (topi+"ن")  (topi+"و")          (topi+"ون")
                Masc ;

-- 9. Feminine: bere, bili, kurse
  mkN09 : Str -> Noun ;
  mkN09 bili = mkN (bili)    (bili)       (bili)     (bili)
                   (bili+"ون")    (bili+"ن")  (bili+"ن")         (bili+"ون") 
                Fem ;
				
-- 10. msculine: bha
  mkN010 : Str -> Noun ;
  mkN010 bha = mkN (bha)    (bha)       (bha)     (bha)
                   (bha+"ر")    (bha+"رن")  (bha+"رو")    (bha+"ر")
                Masc ;

-- 11. Feminine: bhen
  mkN11 : Str -> Noun ;
  mkN11 bhen = let bhe= (tk 1 bhen) 
					in mkN (bhen)    (bhen)       (bhen)     (bhen)
                   (bhe+"نر")    (bhe+"نرن")  (bhen+"ون")    (bhe+"نر")
                Fem ;
				
--12. msculine: raja, darya
  mkN12 : Str -> Noun ;
  mkN12 raja = mkN (raja)    (raja)       (raja)     (raja)
                   (raja)    (raja+"۶ن")  (raja+"۶و")          (raja)
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
     Inf_Fem  => ((tk 1 root) + "ی") ;
     Inf_Obl  => (tk 1 root) ;
     Ablative => ((tk 1 root) + "وN") ;


     VF tense person number gender  => (mkCmnVF root root2 tense person number gender).s 
    }
  } ;

  mkIrrgVerb : (inf,root: Str) -> Verb = \inf,root ->
   let root  = root ;  
    in { 
     s = table {

     Root     => root ;

     Inf      => inf ;
     Inf_Fem  => ((tk 1 inf) + "ی") ;
     Inf_Obl  => (tk 1 inf) ;
     Ablative => ((tk 1 inf) + "وN") ;


     VF tense person number gender  => (mkCmnVF (root+"ی") (root+"ی") tense person number gender).s 
    }
  } ;
  

mkCmnVF : Str -> Str -> VTense -> PPerson -> Number -> Gender -> {s:Str}= \root,root2,t,p,n,g ->
  {s = case (last root) of {
     ("ا"|"۽"|"ی") => (mkCmnVF1 root t p n g).s ;
     _ => (mkCmnVF1 root t p n g).s
   }
  };

 mkCmnVF1 : Str -> VTense -> PPerson -> Number -> Gender -> {s:Str}= \root,t,p,n,g ->
  {s = let nadaa = root + "ندو" ; --root + variants{"ندا";"وندا"};
          nadii = root + "ون" ; --root + variants{"ندی";"وندی"} ;
          nade  = root + "ندی" ; --root + variants{"ندی";"یندین"} ;
           nadiiaaN = root + "ندو";  --root + variants{"ندیاN";"وندیاN"};
	   ndi = root + "ندی";
	   nda = root + "ندا" ;
	   ndywn = root + "ندیون" ;
		   ndyn = root + "ندین" ;
	   
   in 
  case <t,p,n,g> of {
    <Subj,Pers1,         Sg,_> => root + "ان" ;
    <Subj,Pers1,         Sg,_> => root + "ان" ;
	<subj, Pers1,        pl,Masc>  => root + "ون" ;
	<subj, Pers1,        pl,Fem>  => root + "ون" ;
    <Subj,Pers2_Casual,  Sg,_> => root +"ین";
    <Subj,Pers2_Casual,  Pl,_> => root + "و" ;
    <Subj,Pers2_Respect, _, _> => root + "و" ;
	
	<Subj,Pers3_Near,  Sg,Masc> => root +"ی";
	<Subj,Pers3_Near,  sg,Fem> => root +"ی";
	<Subj,Pers3_Near,  pl,Masc> => root +"ن";
	<Subj,Pers3_Near,  pl,Fem> => root +"ن";
	<Subj,Pers3_Distant,Sg,Masc> => root +"ی";
	<Subj,Pers3_Distant,Sg,Fem> => root +"ی";
	<Subj,Pers3_Distant,Pl,Masc> => root +"ن";
	<Subj,Pers3_Distant,Pl,Fem> => root +"ن";
    

    <Perf, Pers1,Sg,Masc> => root + "یل" ;
    <Perf, Pers1,Sg,Fem>  => root + "یل" ;
    <Perf, Pers1,Pl,Masc> => root + "یل" ;
    <Perf, Pers1,Pl,Fem>  => root + "یل" ;
    <Perf, Pers2_Casual,Sg,Masc> => root + "یل" ;
    <Perf, Pers2_Casual,Sg,Fem>  => root + "یل" ;
    <Perf, Pers2_Casual,Pl,Masc> => root + "یل" ;
    <Perf, Pers2_Casual,Pl,Fem>  => root + "یل" ;
    <Perf, Pers2_Respect,Sg,Masc> => root + "یل" ;   
	<Perf, Pers2_Respect,Sg,Fem>  => root + "یل" ;    
	<Perf, Pers2_Respect,Pl,Masc>  => root + "یل" ;    
	<Perf, Pers2_Respect,Pl,Fem>   => root + "یل" ;    	

    <Perf, _,            Sg,Masc> => root + "یل" ;
    <Perf, _,            Sg,Fem>  => root + "یل" ;
    <Perf, _,            Pl,Masc> => root + "یل" ;
    <Perf, _,            Pl,Fem>  => root + "یل" ;

    <Imperf, Pers1,Sg, Masc> => root + "ندو"  ;
    <Imperf, Pers1,Sg, Fem>  => root + "ندی" ;
    <Imperf, Pers1,Pl, Masc> => root + "ندا"  ;
    <Imperf, Pers1,Pl, Fem>  => root + "ندیون"  ;

    <Imperf, Pers2_Casual,  Sg, Masc> => root + "ندو" ;
    <Imperf, Pers2_Casual,  Sg, Fem>  => root + "ندی"  ;
    <Imperf, Pers2_Casual,  Pl, Masc> => root + "ندا"  ;
    <Imperf, Pers2_Casual,  Pl, Fem>  => root + "ندیون"  ;
    
	<Imperf, Pers2_Respect, Sg, Masc>    => root + "ندا" ;
    <Imperf, Pers2_Respect, Sg, Fem> => root + "ندیون" ;
	<Imperf, Pers2_Respect, Pl, Masc> => root + "ندا" ;	
    <Imperf, Pers2_Respect, Pl, Fem>  => root + "ندیون"  ;
    
	<Imperf, _, Sg, Masc> => root + "ندو"  ;
    <Imperf, _, Sg, Fem>  => root + "ندی"  ;
	<Imperf, _, Pl, Masc> => root + "ندا"  ;
    <Imperf, _, Pl, Fem>  => root + "ندیون"  
	
  }
 } ;
  

 mkCmnVF2 : Str -> VTense -> PPerson -> Number -> Gender -> {s:Str}= \inf,t,p,n,g ->
  {s = 
  case <t,p,n,g> of {
    <_, _, _,_>  => inf
	}
 };
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
  
}
