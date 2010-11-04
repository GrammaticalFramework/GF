--# -path=.:prelude
--
----1 A Simple Punjabi Resource Morphology
----
----  Muhammad Humayoun 2010
----
---- This resource morphology contains definitions needed in the resource
---- syntax. To build a lexicon, it is better to use $ParadigmsPnb$, which
---- gives a higher-level access to this module.
--
resource MorphoPnb = Cat ** open ResPnb, Prelude, Predef in {

   flags optimize=noexpand ;
   coding = utf8;

 oper

------------------------------------------------------------------
----Nouns
------------------------------------------------------------------

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

{-
1. masculine nouns end with alif, choTi_hay, ain
   Arabic nouns ends with h. also taken as Masc
   e.g.
   koRa, munda, wela, bistra, braamda
   brqa', 
-} 

  mkN01 : Str -> Noun ;
  mkN01 koRa = let end = last (koRa) ;
                   koR = if_then_else Str (eq end "ع") koRa (tk 1 koRa)
                in mkN (koRa)        (koR+"ے")       (koR+"یا")      (koR+"یوں")
                       (koR+"ے")    (koR+"یاں")      (koR+"یو")      ""
                    Masc ;


-- 2. msculine: gher, shehar, din, des, huth
  mkN02 : Str -> Noun ;
  mkN02 gher = mkN (gher)    (gher)       (variants{gher; gher+"ا"})     (gher+"وں")
                   (gher)    (gher+"اں")  (gher+"و")                     ""
                Masc ;

-- 3. sekhi, kuRi, boli
  mkN03 : Str -> Noun ;
  mkN03 kuRi = mkN (kuRi)            (kuRi)       (kuRi+"ے")     ""
                   (kuRi+"اں")       (kuRi+"اں")  (kuRi+"وں")    ""
                  Fem ;

-- 4. gal, saltanat, tareekh, shaksiat, kitab
  mkN04 : Str -> Noun ;
  mkN04 gal = mkN (gal)            (gal)       (variants{gal; gal+"ے"})   (gal+"وں")
                  (gal+"اں")       (gal+"اں")  (gal+"و")                  ""
                Fem ;


-- 5. maaN
  mkN05 : Str -> Noun ;
  mkN05 maaN = let maa = tk 1 maaN
                in mkN (maaN)        (maaN)       (variants{(maa+"ئے");(maa+"وے")})      (maa+"واں")
                       (maa+"واں")   (maa+"واں")  (maa+"وو")      ""
                    Fem ;

-- 6. kunwaN
  mkN06 : Str -> Noun ;
  mkN06 kunwaN = let kunw = tk 2 kunwaN
                   in mkN (kunwaN)    (kunw+"یں")  (kunw+"یں") (kunw+"وں")
                          (kunw+"یں") (kunw+"یاں") (kunw+"بو") ""
                      Masc ;

-- 7. merd
  mkN07 : Str -> Noun ;
  mkN07 merd = mkN (merd) (merd)      (merd)       ""
                   (merd) (merd+"اں") (merd+"و")   ""
                  Masc ;
-- 8. aaTa, 
  mkN08 : Str -> Noun ;
  mkN08 aaTa = let aaT = tk 1 aaTa 
            in mkN (aaTa) (aaT+"ے")     (variants{aaT+"ے"; aaT+"یا"})     (aaT+"یوں")
                   (aaTa) (aaT+"ے")     (variants{aaT+"ے"; aaT+"یا"})     ""
                  Masc ;
                  
--9. lok
  mkN09 : Str -> Noun ;
  mkN09 lok = mkN ""    ""          ""         ""
                  (lok) (lok+"ا")   (lok+"و")  ""
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

------------------------------------------------------------------
----Verbs
------------------------------------------------------------------
 
--1. Basic stem form, direct & indirect causatives exists
-- v1 nechna nechaana nechwana

  mkV1 : (_,_,_: Str) -> Verb1 = \inf, c1, c2 ->
   let root  = (tk 2 inf) ; 
       root1 = (tk 2 c1)  ;  
       root2 = (tk 2 c2) ;  
    in { 
     s = table {

     Root     => root ;

     Inf      => inf ;
     Inf_Fem  => ((tk 1 inf) + "ی") ;
     Inf_Obl  => (tk 1 inf) ;
     Ablative => ((tk 1 inf) + "وں") ;

     Caus1_Inf => c1 ;
     Caus1_Fem => ((tk 1 c1) + "ی") ;
     Caus1_Obl => (tk 1 c1) ;
     Caus1_Ablative => ((tk 1 c1) + "وں") ;

     Caus2_Inf => c2 ;
     Caus2_Fem => ((tk 1 c2) + "ی") ;
     Caus2_Obl => (tk 1 c2) ;
     Caus2_Ablative => ((tk 1 c2) + "وں") ;

     MVF1 tense person number gender  => (mkCmnVF root tense person number gender).s ;
     Caus1 tense person number gender => (mkCmnVF root1 tense person number gender).s ;
     Caus2 tense person number gender => (mkCmnVF root2 tense person number gender).s 
    }
  } ;


mkCmnVF : Str -> Tense -> Person -> Number -> Gender -> {s:Str}= \root,t,p,n,g ->
  {s = case (last root) of {
     ("ا"|"آ"|"و"|"ی") => (mkCmnVF1 root t p n g).s ;
     _ => (mkCmnVF2 root t p n g).s
   }
  };

 mkCmnVF1 : Str -> Tense -> Person -> Number -> Gender -> {s:Str}= \root,t,p,n,g ->
  {s = let nadaa = root + "ندا" ; --root + variants{"ندا";"وندا"};
           nadii = root + "ندی" ; --root + variants{"ندی";"وندی"} ;
           nade  = root + "ندے" ; --root + variants{"ندے";"وندے"} ;
           nadiiaaN = root + "ندیاں"  --root + variants{"ندیاں";"وندیاں"}
   in 
  case <t,p,n,g> of {
    <Subj,Pers1,         Sg,_> => root + "واں" ;
    <Subj,Pers1,         Pl,_> => root + "ئے" ;
    <Subj,Pers2_Casual,  Sg,_> => root ;
    <Subj,Pers2_Casual,  Pl,_> => root + "ؤ" ;
    <Subj,Pers2_Respect, _, _> => root + "ؤ" ;

    <Subj,_,             Sg,_> => root + "ئے" ;
    <Subj,_,             Pl,_> => root+"ن" ;

    <Perf, Pers1,        Sg,Masc> => root + "یا" ;
    <Perf, Pers1,        Sg,Fem>  => root + "ئی" ;
    <Perf, Pers1,        Pl,Masc> => root + "ئے" ;
    <Perf, Pers1,        Pl,Fem>  => root + "ئیاں" ;
    <Perf, Pers2_Casual, Sg,Masc> => root + "یا" ;
    <Perf, Pers2_Casual, Sg,Fem>  => root + "ئی" ;
    <Perf, Pers2_Casual, Pl,Masc> => root + "ئے" ;
    <Perf, Pers2_Casual, Pl,Fem>  => root + "ئیاں" ;
    <Perf, Pers2_Respect,_,_>     => root + "ئے" ;     

    <Perf, _,            Sg,Masc> => root + "یا" ;
    <Perf, _,            Sg,Fem>  => root + "ئی" ;
    <Perf, _,            Pl,Masc> => root + "ئے" ;
    <Perf, _,            Pl,Fem>  => root + "ئیاں" ;

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
  

 mkCmnVF2 : Str -> Tense -> Person -> Number -> Gender -> {s:Str}= \root,t,p,n,g ->
  {s = let daa = root + "دا" ;
           dii = root + "دی" ;
           de  = root + "دے" ;
           diiaaN = root + "دیاں"
   in 
  case <t,p,n,g> of {
    <Subj,Pers1,         Sg,_> => root + "اں" ;
    <Subj,Pers1,         Pl,_> => root+"ئے" ;
    <Subj,Pers2_Casual,  Sg,_> => root ;
    <Subj,Pers2_Casual,  Pl,_> => root + "و"  ;
    <Subj,Pers2_Respect, _, _> => root + "و"  ;

    <Subj,_,             Sg,_> => root + "ے"  ;
    <Subj,_,             Pl,_> => root+"ن" ;

    <Perf, Pers1,        Sg,Masc> => root+"یا"; 
    <Perf, Pers1,        Sg,Fem>  => root + "ی" ;
    <Perf, Pers1,        Pl,Masc> => root + "ے"  ;
    <Perf, Pers1,        Pl,Fem>  => root + "یاں" ;
    <Perf, Pers2_Casual, Sg,Masc> => root+"یا"; 
    <Perf, Pers2_Casual, Sg,Fem>  => root + "ی" ;
    <Perf, Pers2_Casual, Pl,Masc> => root + "ے"  ;
    <Perf, Pers2_Casual, Pl,Fem>  => root + "یاں" ;
    <Perf, Pers2_Respect,_,_>     => root + "ے"  ;

    <Perf, _,            Sg,Masc> => root+"یا" ;
    <Perf, _,            Sg,Fem>  => root + "ی" ;
    <Perf, _,            Pl,Masc> => root + "ے"  ;
    <Perf, _,            Pl,Fem>  => root + "یاں" ;

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
 mkV4 : Str -> Verb4 = \inf ->
   let root  = (tk 2 inf); 
    in { s = table {
     Root4     => root ;

     Inf4      => inf ;
     Inf_Fem4  => ((tk 1 inf) + "ی") ;
     Inf_Obl4  => (tk 1 inf) ;
     Ablative4 => ((tk 1 inf) + "وں") ;

     MVF4 tense person number gender   => (mkCmnVF root tense person number gender).s 
    }
  } ;



----------------------------------------------------------------
  mkPN : Str -> {s:Str} = \x -> {s = x};
  mkAdj3 : Str -> {s:Str} = \x -> {s = x}; 
  mkAdv : Str -> {s:Str} = \x -> {s = x};

  mkAdj1 : Str -> Adjective1 ;
  mkAdj1 piilaa = let end = last (piilaa) ;
                   piil = if_then_else Str (eq end "ع") piilaa (tk 1 piilaa)
                in adj1 (piilaa)    (piil+"ے")  (variants{piil+"یا"; piil+"ے"}) (piil+"یوں")  (piil+"ے")  (piil+"یاں")   (piil+"یو")   ""
                        (piil++"ی") (piil++"ی") (variants{piil+"ی" ; piil+"یے"})  (piil+"یوں") (piil++"ی")  (piil++"یاں")   (piil++"یو") "" ;

  adj1 :(x1,_,_,_,_,_,_, _,_,_,_,_,_,_,_, x16 : Str) -> {s : Gender => Number => Case => Str} = 
   \msd,mso,msv,msa, mpd,mpo,mpv,mpa, fsd,fso,fsv,fsa, fpd,fpo,fpv,fpa -> {
    s = table {
     Masc => (cmnAdj msd mso msv msa mpd mpo mpv mpa).s ;
     Fem  => (cmnAdj fsd fso fsv fsa fpd fpo fpv fpa).s
     }
   };
 
  mkAdj2 : Str -> Adjective2 ;
  mkAdj2 romii = cmnAdj romii romii         (romii+"ا")  (romii+"یوں")
                        romii (romii++"اں") (romii++"و")  "" ;

 cmnAdj : (x1,_,_,_,_,_,_,x8 : Str) -> {s : Number => Case => Str} = 
      \sd,so,sv,sa, pd,po,pv,pa -> {
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
      } 
   } ;
 
      
}


{-


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
    
-- Proposition  
 
  makePrep : Str -> Preposition = \str -> {s = str};
   
----2 Pronouns
   PronForm = {s:Pronoun => Str};
   makeDemPron : (x1,x2,x3,x4,x5,x6:Str) -> PronForm = 
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

--   DemonPronForm = {s:DemPronForm => Str};
  mkDemonPronForm : (x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12:Str) -> DemPronForm =
  \y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12 -> {
   s = table {
	        Sg => table {
				Masc => table {
						     Dir => y1 ;
                             Obl => y2 ;
                             Voc => y3
							 };
				Fem => table {
						     Dir => y4 ;
                             Obl => y5 ;
                             Voc => y6
							 }
						};
			Pl => table {
				Masc => table {
						     Dir => y7 ;
                             Obl => y8 ;
                             Voc => y9
							 };
				Fem => table {
						     Dir  => y10 ;
                             Obl => y11 ;
                             Voc => y12
							 }
					} 
				}
               };    
   makeDemonPronForm : Str -> Str -> Str -> DemPronForm ;
   makeDemonPronForm  yeh is inn = mkDemonPronForm 	yeh	is	"" yeh is "" yeh inn "" yeh inn "";	
--   makePossPronForm myra myry hmara hmary = mkDemonPronForm myra myra myra myry myry myry hmara hmara hmara hmary hmary hmary;
   
   PersPron = {s: PersPronForm => Str};
   
   mkPersPron:(x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21,x22,x23,x24,x25,x26,x27,x28,x29,x30,x31,x32,x33,x34,x35,x36:Str) -> PersPron = 
    \y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12,y13,y14,y15,y16,y17,y18,y19,y20,y21,y22,y23,y24,y25,y26,y27,y28,y29,y30,y31,y32,y33,y34,y35,y36 -> {
     s = 
	  table {
	      PPF Sg Pers1 Dir => y1;
          PPF Sg Pers1 Obl => y2;
	      PPF Sg Pers1 Voc => y3;
	      PPF Sg Pers2_Casual Dir => y4;
	      PPF Sg Pers2_Casual Obl => y5;
          PPF Sg Pers2_Casual Voc => y6;
	      PPF Sg Pers2_Familiar Dir => y7;
	      PPF Sg Pers2_Familiar Obl => y8;
	      PPF Sg Pers2_Familiar Voc => y9;
          PPF Sg Pers2_Respect Dir => y10;
	      PPF Sg Pers2_Respect Obl => y11;
	      PPF Sg Pers2_Respect Voc => y12;
	      PPF Sg Pers3_Near Dir => y13;
          PPF Sg Pers3_Near Obl => y14;
	      PPF Sg Pers3_Near Voc => y15;
	      PPF Sg Pers3_Distant Dir => y16;
	      PPF Sg Pers3_Distant Obl => y17;
          PPF Sg Pers3_Distant Voc => y18;
	      PPF Pl Pers1 Dir => y19;
          PPF Pl Pers1 Obl => y20;
	      PPF Pl Pers1 Voc => y21;
	      PPF Pl Pers2_Casual Dir => y22;
	      PPF Pl Pers2_Casual Obl => y23;
          PPF Pl Pers2_Casual Voc => y24;
	      PPF Pl Pers2_Familiar Dir => y25;
	      PPF Pl Pers2_Familiar Obl => y26;
	      PPF Pl Pers2_Familiar Voc => y27;
          PPF Pl Pers2_Respect Dir => y28;
	      PPF Pl Pers2_Respect Obl => y29;
	      PPF Pl Pers2_Respect Voc => y30;
	      PPF Pl Pers3_Near Dir => y31;
          PPF Pl Pers3_Near Obl => y32;
	      PPF Pl Pers3_Near Voc => y33;
	      PPF Pl Pers3_Distant Dir => y34;
	      PPF Pl Pers3_Distant Obl => y35;
          PPF Pl Pers3_Distant Voc => y36
		 }; 
      };
	  
   makePersPron : PersPron;
   makePersPron     = mkPersPron	"m(a)yN"	"m(o)j'|h"		""		"t(o)w "		"t(o)j|h"		"t(o)w "		"t(o)m"		"t(o)m"		"t(o)m"		"Ap"		"Ap"		"Ap"		"y(i)h"		"a(i)s"		""		"w(o)h"		"a(o)s"		""
									"h(a)m"		"h(a)m"			""		"t(o)m" 		"t(o)m"			"t(o)m"			"t(o)m"		"t(o)m"		"t(o)m"		"Ap"		"Ap"		"Ap"		"y(i)h"		"a(i)n"		""		"w(o)h"		"a(o)n"		"" ;
						
  mkPron : (x1,x2,x3:Str) -> {s:Case => Str} = 
     \y1,y2,y3 -> { s =
                      table {
                        Dir => y1;
                        Obl => y2;
                        Voc => y3
                        }
                      };  
                                   
	------- PossPronForm yet to be implemented
  
-- IntPronForm = {s:InterrPronForm => Str};
  IntPronForm = {s: Case => Str};
  mkIntPronForm : (x1,x2,x3:Str) -> IntPronForm =
  \y1,y2,y3 -> {
   s = 


    table {
	            Dir => y1;
	            Obl => y2;
	            Voc => y3
		 }
	}; 

-}
