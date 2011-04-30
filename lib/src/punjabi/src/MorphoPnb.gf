--# -path=.:../../prelude
--
----1 A Simple Punjabi Resource Morphology
----
----  Shafqat Virk, Aarne Ranta,2010
----
---- This resource morphology contains definitions needed in the resource
---- syntax. To build a lexicon, it is better to use $ParadigmsPnb$, which
---- gives a higher-level access to this module.
--
resource MorphoPnb = ResPnb ** open Prelude,Predef in {

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

    
    
-- masculine nouns end with alif, choTi_hay, ain Translitration: (a, h, e)
-- Arabic nouns ends with h. also taken as Masc
  mkN01 : Str -> Noun ;
  mkN01 koRa = let end = last (koRa) ;
                   koR = if_then_else Str (eq end "e") koRa (tk 1 koRa)
                in mkN (koRa)        (koR+"E")       (koR+"ya")      (koR+"ywN")
                       (koR+"E")    (koR+"yaN")      (koR+"yw")      ""
                    Masc ;


-- 2. msculine: gher, shehar, din, des, huth
  mkN02 : Str -> Noun ;
  mkN02 gher = mkN (gher)    (gher)       (variants{gher; gher+"a"})     (gher+"wN")
                   (gher)    (gher+"aN")  (gher+"w")                     ""
                Masc ;

-- 3. sekhi, kuRi, boli
  mkN03 : Str -> Noun ;
  mkN03 kuRi = mkN (kuRi)            (kuRi)       (kuRi+"E")     ""
                   (kuRi+"aN")       (kuRi+"aN")  (kuRi+"wN")    ""
                  Fem ;

-- 4. gal, saltanat, tareekh, shaksiat, kitab
  mkN04 : Str -> Noun ;
  mkN04 gal = mkN (gal)            (gal)       (variants{gal; gal+"E"})   (gal+"wN")
                  (gal+"aN")       (gal+"aN")  (gal+"w")                  ""
                Fem ;


-- 5. maaN
  mkN05 : Str -> Noun ;
  mkN05 maaN = let maa = tk 1 maaN
                in mkN (maaN)        (maaN)       (variants{(maa+"y^E");(maa+"wE")})      (maa+"waN")
                       (maa+"waN")   (maa+"waN")  (maa+"ww")      ""
                    Fem ;

-- 6. kunwaN
  mkN06 : Str -> Noun ;
  mkN06 kunwaN = let kunw = tk 2 kunwaN
                   in mkN (kunwaN)    (kunw+"yN")  (kunw+"yN") (kunw+"wN")
                          (kunw+"yN") (kunw+"yaN") (kunw+"bw") ""
                      Masc ;

-- 7. merd
  mkN07 : Str -> Noun ;
  mkN07 merd = mkN (merd) (merd)      (merd)       ""
                   (merd) (merd+"aN") (merd+"w")   ""
                  Masc ;
-- 8. aaTa, 
  mkN08 : Str -> Noun ;
  mkN08 aaTa = let aaT = tk 1 aaTa 
            in mkN (aaTa) (aaT+"E")     (variants{aaT+"E"; aaT+"ya"})     (aaT+"ywN")
                   (aaTa) (aaT+"E")     (variants{aaT+"E"; aaT+"ya"})     ""
                  Masc ;
                  
--9. lok
  mkN09 : Str -> Noun ;
  mkN09 lok = mkN ""    ""          ""         ""
                  (lok) (lok+"a")   (lok+"w")  ""
                Masc ;

--10. Masc. no inflection
  mkN10 : Str -> Noun ;
  mkN10 x = mkN x x x x
                x x x ""
             Masc ;

--11. Fem. no inflection
  mkN11 : Str -> Noun ;
  mkN11 x = mkN x x x x
                x x x ""
             Fem ;
  -- 12 Masc no inflection
  mkN12 : Str -> Noun ;
  mkN12 x = mkN x x x x
                x x x ""
             Masc ;	     

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
   PronForm = {s:Pronoun => Str};
{-   makeDemPron : (x1,x2,x3,x4,x5,x6:Str) -> PronForm = 
    \y1,y2,y3,y4,y5,y6 -> {
	 s = table {
         P Sg _ Dir _ => y1;
         P Sg _ Obl _ => y2;
         P Sg _ Voc _ => y3;
         P Pl _ Dir _ => y4;
         P Pl _ Obl _ => y5;
         P Pl _ Voc _ => y6
         };
      };
-}
--   DemonPronForm = {s:DemPronForm => Str};
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
{- 
 
   PersPron = {s: PersPronForm => Str};
   
   mkPersPron:(x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21,x22,x23,x24,x25,x26,x27,x28,x29,x30,x31,x32,x33,x34,x35,x36,x37,x38,x39,x40:Str) -> PersPron = 
    \y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12,y13,y14,y15,y16,y17,y18,y19,y20,y21,y22,y23,y24,y25,y26,y27,y28,y29,y30,y31,y32,y33,y34,y35,y36,y37,y38,y39,y40 -> {
     s = 
	  table {
	      PPF Sg Pers1 Dir => y1;
	      PPF Sg Pers1 Obl => y2;
	      PPF Sg Pers1 Voc => y3;
	      PPF Sg Pers1 Abl => y4;
	      PPF Sg Pers2_Casual Dir => y5;
	      PPF Sg Pers2_Casual Obl => y6;
	      PPF Sg Pers2_Casual Voc => y7;
	      PPF Sg Pers2_Casual Abl => y8;
	      PPF Sg Pers2_Respect Dir => y9;
	      PPF Sg Pers2_Respect Obl => y10;
	      PPF Sg Pers2_Respect Voc => y11;
	      PPF Sg Pers2_Respect Abl => y12;
	      PPF Sg Pers3_Near Dir => y13;
	      PPF Sg Pers3_Near Obl => y14;
	      PPF Sg Pers3_Near Voc => y15;
	      PPF Sg Pers3_Near Abl => y16;
	      PPF Sg Pers3_Distant Dir => y17;
	      PPF Sg Pers3_Distant Obl => y18;
	      PPF Sg Pers3_Distant Voc => y19;
	      PPF Sg Pers3_Distant Abl => y20;
	      PPF Pl Pers1 Dir => y21;
	      PPF Pl Pers1 Obl => y22;
	      PPF Pl Pers1 Voc => y23;
	      PPF Pl Pers1 Abl => y24;
	      PPF Pl Pers2_Casual Dir => y25;
	      PPF Pl Pers2_Casual Obl => y26;
	      PPF Pl Pers2_Casual Voc => y27;
	      PPF Pl Pers2_Casual Abl => y28;
	      PPF Pl Pers2_Respect Dir => y29;
	      PPF Pl Pers2_Respect Obl => y30;
	      PPF Pl Pers2_Respect Voc => y31;
	      PPF Pl Pers2_Respect Abl => y32;
	      PPF Pl Pers3_Near Dir => y33;
	      PPF Pl Pers3_Near Obl => y34;
	      PPF Pl Pers3_Near Voc => y35;
	      PPF Pl Pers3_Near Abl => y36;
	      PPF Pl Pers3_Distant Dir => y37;
	      PPF Pl Pers3_Distant Obl => y38;
	      PPF Pl Pers3_Distant Voc => y39;
	      PPF Pl Pers3_Distant Abl => y40
		 }; 
      };
	  
   makePersPron : PersPron;
   makePersPron     = mkPersPron	"myN"		""		""		"mytwN"
					"twN"		""		""		"tytwN"
					"tsy"		""		""		"twatwN"
					"aw"		""		""		"aw"
					"aw"		""		""		"aw"
					"asy"		"" 		""		"satwN"
					"tsy"		""		""		"twatwN"
					"tsy"		""		""		"twatwN"
					"aw"		""		""		"aw"
					"aw"		""		""		"aw";
-}

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
-- defined in ResPnb

------------------------------------------------------------------
----Verbs
------------------------------------------------------------------
 
--1. Basic stem form, direct & indirect causatives exists
-- v1 nechna nechaana nechwana

  mkVerb : (_: Str) -> Verb = \inf ->
   let root  = (tk 2 inf) ; 
--       root1 = (tk 2 c1)  ;  
--       root2 = (tk 2 c2) ;  
    in { 
     s = table {

     Root     => root ;

     Inf      => inf ;
     Inf_Fem  => ((tk 1 inf) + "y") ;
     Inf_Obl  => (tk 1 inf) ;
     Ablative => ((tk 1 inf) + "wN") ;

{-     Caus1_Inf => c1 ;
     Caus1_Fem => ((tk 1 c1) + "y") ;
     Caus1_Obl => (tk 1 c1) ;
     Caus1_Ablative => ((tk 1 c1) + "wN") ;

     Caus2_Inf => c2 ;
     Caus2_Fem => ((tk 1 c2) + "y") ;
     Caus2_Obl => (tk 1 c2) ;
     Caus2_Ablative => ((tk 1 c2) + "wN") ;
-}
     VF tense person number gender  => (mkCmnVF root tense person number gender).s 
--     Caus1 tense person number gender => (mkCmnVF root1 tense person number gender).s ;
--     Caus2 tense person number gender => (mkCmnVF root2 tense person number gender).s 
    }
  } ;


mkCmnVF : Str -> VTense -> PPerson -> Number -> Gender -> {s:Str}= \root,t,p,n,g ->
  {s = case (last root) of {
     ("a"|"A"|"w"|"y") => (mkCmnVF1 root t p n g).s ;
     _ => (mkCmnVF2 root t p n g).s
   }
  };

 mkCmnVF1 : Str -> VTense -> PPerson -> Number -> Gender -> {s:Str}= \root,t,p,n,g ->
  {s = let nadaa = root + "nda" ; --root + variants{"nda";"wnda"};
           nadii = root + "ndy" ; --root + variants{"ndy";"wndy"} ;
           nade  = root + "ndE" ; --root + variants{"ndE";"wndE"} ;
           nadiiaaN = root + "ndyaN"  --root + variants{"ndyaN";"wndyaN"}
   in 
  case <t,p,n,g> of {
    <Subj,Pers1,         Sg,_> => root + "waN" ;
    <Subj,Pers1,         Pl,_> => root + "y^E" ;
    <Subj,Pers2_Casual,  Sg,_> => root ;
    <Subj,Pers2_Casual,  Pl,_> => root + "w^" ;
    <Subj,Pers2_Respect, _, _> => root + "w^" ;

    <Subj,_,             Sg,_> => root + "y^E" ;
    <Subj,_,             Pl,_> => root+"n" ;

    <Perf, Pers1,        Sg,Masc> => root + "ya" ;
    <Perf, Pers1,        Sg,Fem>  => root + "y^y" ;
    <Perf, Pers1,        Pl,Masc> => root + "y^E" ;
    <Perf, Pers1,        Pl,Fem>  => root + "y^yaN" ;
    <Perf, Pers2_Casual, Sg,Masc> => root + "ya" ;
    <Perf, Pers2_Casual, Sg,Fem>  => root + "y^y" ;
    <Perf, Pers2_Casual, Pl,Masc> => root + "y^E" ;
    <Perf, Pers2_Casual, Pl,Fem>  => root + "y^yaN" ;
    <Perf, Pers2_Respect,_,_>     => root + "y^E" ;     

    <Perf, _,            Sg,Masc> => root + "ya" ;
    <Perf, _,            Sg,Fem>  => root + "y^y" ;
    <Perf, _,            Pl,Masc> => root + "y^E" ;
    <Perf, _,            Pl,Fem>  => root + "y^yaN" ;

    <Imperf, Pers1,         Sg, Masc> => nadaa ;
    <Imperf, Pers1,         Sg, Fem>  => nadii ;
    <Imperf, Pers1,         Pl, Masc> => nade ;
    <Imperf, Pers1,         Pl, Fem>  => nadiiaaN ;

    <Imperf, Pers2_Casual,  Sg, Masc> => nadaa ;
    <Imperf, Pers2_Casual,  Sg, Fem>  => nadii ;
    <Imperf, Pers2_Casual,  Pl, Masc> => nade ;
    <Imperf, Pers2_Casual,  Pl, Fem>  => nadiiaaN ;
    <Imperf, Pers2_Respect, Sg, _>    => nade ;
    <Imperf, Pers2_Respect, Pl, Masc> => nade ;
    <Imperf, Pers2_Respect, Pl, Fem>  => variants {nade;nadiiaaN} ;
    <Imperf, _,             Sg, Masc> => nadaa ;
    <Imperf, _,             Sg, Fem>  => nadii ;
    <Imperf, _,             Pl, Masc> => nade ;
    <Imperf, _,             Pl, Fem>  => nadiiaaN
  }
 } ;
  

 mkCmnVF2 : Str -> VTense -> PPerson -> Number -> Gender -> {s:Str}= \root,t,p,n,g ->
  {s = let daa = root + "da" ;
           dii = root + "dy" ;
           de  = root + "dE" ;
           diiaaN = root + "dyaN"
   in 
  case <t,p,n,g> of {
    <Subj,Pers1,         Sg,_> => root + "aN" ;
    <Subj,Pers1,         Pl,_> => root+"y^E" ;
    <Subj,Pers2_Casual,  Sg,_> => root ;
    <Subj,Pers2_Casual,  Pl,_> => root + "w"  ;
    <Subj,Pers2_Respect, _, _> => root + "w"  ;

    <Subj,_,             Sg,_> => root + "E"  ;
    <Subj,_,             Pl,_> => root+"n" ;

    <Perf, Pers1,        Sg,Masc> => root+"ya"; 
    <Perf, Pers1,        Sg,Fem>  => root + "y" ;
    <Perf, Pers1,        Pl,Masc> => root + "E"  ;
    <Perf, Pers1,        Pl,Fem>  => root + "yaN" ;
    <Perf, Pers2_Casual, Sg,Masc> => root+"ya"; 
    <Perf, Pers2_Casual, Sg,Fem>  => root + "y" ;
    <Perf, Pers2_Casual, Pl,Masc> => root + "E"  ;
    <Perf, Pers2_Casual, Pl,Fem>  => root + "yaN" ;
    <Perf, Pers2_Respect,_,_>     => root + "E"  ;

    <Perf, _,            Sg,Masc> => root+"ya" ;
    <Perf, _,            Sg,Fem>  => root + "y" ;
    <Perf, _,            Pl,Masc> => root + "E"  ;
    <Perf, _,            Pl,Fem>  => root + "yaN" ;

    <Imperf, Pers1,         Sg, Masc> => daa ;
    <Imperf, Pers1,         Sg, Fem>  => dii ;
    <Imperf, Pers1,         Pl, Masc> => de ;
    <Imperf, Pers1,         Pl, Fem>  => diiaaN ;

    <Imperf, Pers2_Casual,  Sg, Masc> => daa ;
    <Imperf, Pers2_Casual,  Sg, Fem>  => dii ;
    <Imperf, Pers2_Casual,  Pl, Masc> => de ;
    <Imperf, Pers2_Casual,  Pl, Fem>  => diiaaN ;
    <Imperf, Pers2_Respect, Sg, _>    => de ;
    <Imperf, Pers2_Respect, Pl, Masc> => de ;
    <Imperf, Pers2_Respect, Pl, Fem>  => variants {de;diiaaN} ;
    <Imperf, _,             Sg, Masc> => daa ;
    <Imperf, _,             Sg, Fem>  => dii ;
    <Imperf, _,             Pl, Masc> => de ;
    <Imperf, _,             Pl, Fem>  => diiaaN
  }
 } ;


--v4
{- mkV4 : Str -> Verb4 = \inf ->
   let root  = (tk 2 inf); 
    in { s = table {
     Root     => root ;

     Inf4      => inf ;
     Inf_Fem4  => ((tk 1 inf) + "y") ;
     Inf_Obl4  => (tk 1 inf) ;
     Ablative4 => ((tk 1 inf) + "wN") ;

     MVF4 tense person number gender   => (mkCmnVF root tense person number gender).s 
    }
  } ;
-}
}
