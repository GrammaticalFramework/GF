--# -path=.:../../prelude:../abstract:../common:../../prelude
--
----1 A Simple Hinu Resource Morphology
----
----  Shafqat Virk, Aarne Ranta,2009
----
---- This resource morphology contains definitions needed in the resource
---- syntax. To build a lexicon, it is better to use $ParadigmsHin$, which
---- gives a higher-level access to this module.
--
resource MorphoHin = ResHin ** open Prelude,Predef,ParamX,CommonHindustani in {
  flags optimize=all ;
   coding = utf8;

----2 Nouns
oper
    mkNoun : (x1,_,_,_,_,x6 : Str) -> Gender -> Noun = 
      \sd,so,sv,pd,po,pv,g -> {
      s = table {
      Sg => table {
        Dir => sd ;
        Obl => so ;
        Voc => sv 
	  } ;
      Pl => table {
        Dir => pd ;
        Obl => po ;
        Voc => pv 
	  }
      } ;

      g = g
      } ;

    

    regNoun : Str -> Noun ;
    regNoun s = case s of {
		     _ + "या" => mkN05 (s);
                 _ + ("ा") =>  mkN01 (s);
                 _ + "ी" => mkN03 (s);
                 _ + ("ाँ"|"ा") => mkN04 (s);
		 _ + "ाँव" => mkN12 s;
                 _ + "w^" => mkN12 (s);
             _			  => regNoun2 (s)				 
                 };
	regNoun2 : Str -> Noun;
	regNoun2 s = let c = if_then_else Bool (eq (last s) "" ) True (if_then_else Bool (eq (last s) "ह") True (if_then_else Bool (eq (last s) "e") True False))
     in case c of {
      False => mkN02 (s);
	  True => mkN01 (s)
     };	  
	  
    reggNoun : Str -> Gender -> Noun ;
    reggNoun s g = let c = if_then_else Bool (eq (last s) "" ) True (if_then_else Bool (eq (dp 2 s) "ण") True (if_then_else Bool (eq (dp 2 s) "wण") True False))
	 in case <s,g,c> of {
		         <_ + "त",Fem,_> => mkN10 (s);
				 <_ + "त",Masc,_> => mkN02 (s);
				 <_ + "ू",Masc,_> => mkN11 (s);
                 <_ + "w",Fem,_> 	=> mkN07 (s);
				 <_ + "य",Fem,_> => mkN05 (s);
                 <_ + "य",Masc,_> => mkN02 (s);
		 <_ + "ी",Masc,_> => mkN13 (s);
                 <_,Fem,False>		=> mkN08 (s);
                 <_,Fem,_>		=> mkN09 (s)
                 				 
                 };
    
-- masculine nouns end with alif, choTi_hay, ain Translitration: (a, h, e)
-- Arabic nouns ends with h. also taken as Masc

     mkN01 : Str -> Noun ;
     mkN01 lRka = let end = last (lRka) ;
                 lRk = if_then_else Str (eq end "e") lRka (tk 1 lRka)
             in mkNoun (lRka)     (lRk+"े")  (lRk+"े")
                       (lRk+"े")  (lRk+"ों") (lRk+"ो")
                       Masc ;

-- masculine nouns does not end with a, h, e, an

     mkN02 : Str -> Noun ;
     mkN02 mrd = let mrdwN = mrd+"ोँ" ;
              mrdw  = tk 1 mrdwN
              in mkNoun mrd mrd   mrd
                      mrd mrdwN mrdw
                      Masc ;

-- feminine Nouns end with y

     mkN03 : Str -> Noun ;
     mkN03 krsy = let krsyaN  = krsy+"ँ" ;
		 krsywN  = krsy+"योँ" ;
		 krsyw   = tk 1 krsywN
             in mkNoun krsy   krsy   krsy
                       krsyaN krsywN krsyw
                       Fem ;

-- masculine nouns ending at i: e.g Admi:
 mkN13 : Str -> Noun ;
     mkN13 krsy = let 
		 krsywN  = krsy+"योँ" ;
		 krsyw   = tk 1 krsywN
             in mkNoun krsy   krsy   krsy
                       krsy krsywN krsyw
                       Masc ;
		       
-- feminine nouns end with a, aN, wN
     mkN04 : Str -> Noun ;
     mkN04 n = case last n of {
     "ा" =>  mkNoun n          n         n
                  (n+"ाेँ") (n+"ाोँ") (n+"ाो")
                  Fem ;
      _   => let maN = n ; -- ends with aN and wN
            ma  = tk 1 maN
        in mkNoun maN         maN        maN
                  (maN+"ाँेँ") (maN+"ाँोँ") (maN+"ाँो")
                  Fem 

            };
  --feminine nouns end with ya
    
      mkN05 : Str -> Noun ;
      mkN05 gRya = let gRy = (tk 1 gRya)
             in mkNoun gRya       gRya       gRya
                       (gRya+"ँ") (gRy+"ोँ") (gRy+"ो")
                       Fem ;

-- feminine nouns end with w
      
      mkN07 : Str -> Noun ;
      mkN07 khshbw =  mkNoun khshbw     khshbw         khshbw
                            (khshbw + "ेँ") (khshbw + "ोँ") (khshbw + "ो")
                            Fem ;

-- Loan arabic feminine nouns end with t
-- this is a noun that shows  state, condition 

      mkN10 : Str -> Noun ;
      mkN10 ndamt = mkNoun ndamt        ndamt        ndamt
                     (ndamt+"ें") (ndamt+"w:ं") (ndamt+"ो")
                     Fem ;
-- Worst case function
      mkN : (_,_,_,_,_,_ : Str) -> Gender -> Noun ;
      mkN sgNom sgObl sgVoc plNom plObl plVoc g = 
      mkNoun sgNom sgObl sgVoc plNom plObl plVoc g ;

      mkN06 : Str -> Noun ;
      mkN06 rya = mkNoun rya          rya         rya 
                   (rya+"y^यण") (rya+"w^ण") rya
                   Fem ;

-- feminine nouns that do not end with a, N, w, wN
     
      mkN08 : Str -> Noun ;
      mkN08 ktab = mkNoun ktab ktab ktab
                    (ktab+"ेँ") (ktab+"ोँ") (ktab+"ो")
                    Fem ;

-- Loan arabic feminine nouns
     
      mkN09 : Str -> Noun ;
      mkN09 ahsan = mkNoun ahsan        ahsan                             ahsan
                     (ahsan+"ात")  (ahsan+"ात") (ahsan+"ो") 
                     Fem ;
-- (variants{ahsan+"त";ahsan+"wण"})
-- Loan persian maculine nouns end with w

      mkN11 : Str -> Noun ;
      mkN11 alw = mkNoun alw alw         alw
                   alw (alw+"ोँ") (alw+"ो")
                   Masc ;


-- Loan persian maculine nouns end with w^

      mkN12 : Str -> Noun ;
      mkN12 bhao = mkNoun (bhao)      (bhao)     (bhao)
                          (bhao)      (bhao)     (bhao)
                    Masc ;
		    

----2 Determiners
  IDeterminer = {s:Gender => Case => Str ; n : Number};
  makeDet : Str -> Str -> Str -> Str -> Number -> Determiner = \s1,s2,s3,s4,n -> {
   s = table {
      Sg => table { 
        Masc => table {_ => s1} ;
        Fem => table {_ => s2} 
	  } ;
      Pl => table {
        Masc => table { _ => s3} ;
        Fem => table {_ => s4} 
	  }
      } ;

      n = n
	};	
	
  makeIDet : Str -> Str -> Number -> IDeterminer = \s1,s2,n -> {
   s = table {
        Masc => table {_ =>s1};
	Fem  => table {_ =>s2} 
	 };
	 n = n
    };
    
-- Proposition  
 
  makePrep : Str -> Str -> Preposition = \s1,s2 -> {s = table { Masc => s1 ; Fem => s2 } } **  { lock_Prep = <>};
   
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
   makeDemonPronForm : Str -> Str -> Str -> Str -> DemPronForm ;
   makeDemonPronForm  yeh ye is inn = mkDemonPronForm 	yeh	is	"" yeh is "" ye inn "" ye inn "";	
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
   makePersPron     = mkPersPron	"m(a)यण"	"m(o)j'|ह"		""		"t(o)w "		"t(o)j|ह"		"t(o)w "		"t(o)म"		"t(o)म"		"t(o)म"		"अप"		"अप"		"अप"		"y(i)ह"		"a(i)स"		""		"w(o)ह"		"a(o)स"		""
									"h(a)म"		"h(a)म"			""		"t(o)म" 		"t(o)म"			"t(o)म"			"t(o)म"		"t(o)म"		"t(o)म"		"अप"		"अप"		"अप"		"y(i)ह"		"a(i)न"		""		"w(o)ह"		"a(o)न"		"" ;
						
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

----2 Adjectives

  makeIrregA : Str -> Adjective = \str -> {s = \\_,_,_,_ => str} ;
  compoundAdj : Str -> Str -> Adjective = \s1,s2 -> mkCompoundAdj (regAdjective s1) (regAdjective s2) ;
   mkCompoundAdj : Adjective -> Adjective -> Adjective ;
   mkCompoundAdj adj1 adj2 = {s = \\n,g,c,d => adj1.s ! n ! g ! c ! d ++ adj2.s ! n ! g ! c ! d} ;
   
   
   regAdjective : Str -> Adjective; 
  regAdjective x =  case x of {
	              acch + ("ा"|"न") => mkAdjective x  ("बहुत" ++ x)          ("सब से" ++ x)          (acch + "े") ("बहुत" ++ acch + "े") ("सब से" ++ acch + "े") (acch + "े") ("बहुत" ++ acch + "े") ("सब से" ++ acch + "े")
		                                      (acch + "ी") ("बहुत" ++ acch + "ी") ("सब से" ++ acch + "ी") (acch + "ी") ("बहुत" ++ acch + "ी") ("सब से" ++ acch + "ी") (acch + "ी") ("बहुत" ++ acch + "ी") ("सब से" ++ acch + "ी")
						      (acch +"े")  ("बहुत" ++ acch + "े") ("सब से" ++ acch + "े") (acch + "े") ("बहुत" ++ acch + "े") ("सब से" ++ acch + "े") (acch + "े") ("बहुत" ++ acch + "े") ("सब से" ++ acch + "े")
		                                      (acch + "ी") ("बहुत" ++ acch + "ी") ("सब से" ++ acch + "ी") (acch + "ी") ("बहुत" ++ acch + "ी") ("सब से" ++ acch + "ी") (acch + "ी") ("बहुत" ++ acch + "ी") ("सब से" ++ acch + "ी");
									
                        _                 => mkAdjective  x  ("बहुत" ++ x)  	("सब से" ++ x)  x ("बहुत" ++ x) ("सब से" ++ x) x ("बहुत" ++ x) ("सब से" ++ x)
							  x  ("बहुत" ++ x) 	("सब से" ++ x) 	x ("बहुत" ++ x) ("सब से" ++ x) x ("बहुत" ++ x) ("सब से" ++ x)
							  x  ("बहुत" ++ x) 	("सब से" ++ x)  x ("बहुत" ++ x) ("सब से" ++ x) x ("बहुत" ++ x) ("सब से" ++ x)
							  x  ("बहुत" ++ x) 	("सब से" ++ x)  x ("बहुत" ++ x) ("सब से" ++ x) x ("बहुत" ++ x) ("सब से" ++ x)
																 
                            }; 		
  

----3 Verbs
  CommonVF = {s : VTense => UPerson => Number => Gender => Str} ;
 
   mkVerb : (x1: Str) -> Verb = \inf  ->
     	 let root = (tk 2 inf); inf_obl = ((tk 1 inf) + "े"); inf_fem = ((tk 2 inf) + "यी")
	in { s = table {
          
               VF tense person number gender => (mkCmnVF root tense person number gender).s  ;
               Inf     => inf ;
               Root    => root ;
               Inf_Obl => inf_obl ;
               Inf_Fem => inf_fem 
          
          
       } ;
       cvp = []
     } ;
   rem_y : Str -> Str;
   rem_y str = let b = take 1 str; yth = drop 1 str; a1	= take 4 yth; a2 = take 1 yth; 	th= if_then_else Str (eq a1 "(a)य") (drop 5 str) (drop 2 str);	st = if_then_else Str (eq a1 "(a)य") (b ++ "(i)"++th) (if_then_else Str (eq a2 "य") (b ++ th)  str)
              in rt st;
	rt: Str -> Str;
	rt r = r;
   mkCmnVF : Str -> VTense -> UPerson -> Number -> Gender -> {s:Str} =
    \root,t,p,n,g ->
     {s = 
      let form1 = case (last root) of
          {
	  "ा"|"ो"|"ी"  => root + "ऊँ";
	  "े" => (tk 1 root)+ "ूँ";
	  _ => root + "ूँ"
	  };
          form2 = case (last root) of
	  {
	  "ा"|"ो"  => root + "एँ";
	  "ी" => root + "येँ";
	  "े" => (tk 1 root)+ "ेँ";
	  _ => root + "ेँ"
	  }
	 in
       case <t,p,n,g> of {
        <Subj,Pers1,Sg,_> => form1 ;
        <Subj,Pers1,Pl,_> => form2 ;
        <Subj,_,_,_>      => (mkImpert root p n g).s ;
        <Perf,_,_,_>      => case root of {
		                      "हो" => (mkPastInd root p n g).s ;
				      "जा" => (mkPastInd "गय" p n g).s ;
				      "कर" => (mkPastInd "किय" p n g).s ;
				     -- "दE" => (mkPastInd "द" p n g).s ;
				     -- "लE" => (mkPastInd "ल" p n g).s ;
				      _    => (mkPastInd root p n g).s };
        <Imperf,Pers2_Familiar,Sg,Masc>         => root + "ते";
        <Imperf,Pers2_Familiar,Sg,Fem>         => root + "ती"; --variants{root+"तय" ; root+"तयण"};	
        <Imperf,Pers2_Familiar,Pl,Masc>         => root + "ते";
        <Imperf,Pers2_Familiar,Pl,Fem>         => root+"ती";
        <Imperf,Pers2_Respect,Sg,Masc>         => root + "ते";
        <Imperf,Pers2_Respect,Sg,Fem>         => root + "ती"; --variants{root+"तय" ; root+"तयण"};	
        <Imperf,Pers2_Respect,Pl,Masc>         => root + "ते";
        <Imperf,Pers2_Respect,Pl,Fem>         => root+"ती";
		<Imperf,_,Sg,Masc>					  => root+"ता";
		<Imperf,_,Sg,Fem>					  => root+"ती";
		<Imperf,_,Pl,Masc>					  => root+"ते";
		<Imperf,_,Pl,Fem>					  => root+"ती"
        }
       
     } ;
   
   mkPastInd : Str -> UPerson -> Number -> Gender -> {s:Str} = \root,p,n,g ->
    {s = let roo = root ;
             a = case (last root) of {
                  "ा"|"ो"|"ी" => roo + "या" ;
		  "े" => (tk 1 roo) + "िया" ; --* here is the problem
                   _           => roo + "ा"
                 } ;
             y = case (last root) of {
                  "ा"|"ो" => roo + "यी" ;
		  "ी" => roo ;
		  "े" => (tk 1 roo) + "ी" ;
		   "िय" => (tk 2 roo) + "ी" ;
                  _           => roo + "ी"
                 } ;
             e = case (last root) of {
                  "ा"|"ो"|"ी"|"क" => roo + "ये" ;
		  "े" => (tk 1 roo) + "ी" ;
                  _           => roo + "े"
                 } ;
            yN = case (last root) of {
                  "ा"|"ो"|"ी" => roo + "यीँ" ;
		  "िय" => (tk 2 roo) + "ी" ;
		  "े" => (tk 1 roo) + "ीँ" ;
                  _           => roo + "यँ"
                 } ;

     in 
     case <p,n,g> of {
       <Pers1,Sg,Masc> => a ; --*
       <Pers1,Sg,Fem>  => y ;
       <Pers1,Pl,Masc> => e ;
       <Pers1,Pl,Fem>  => yN ;

       <Pers2_Casual,Sg,Masc> => a ; --*
       <Pers2_Casual,Sg,Fem>  => y ;
       <Pers2_Casual,Pl,Masc> => e ;       
       <Pers2_Casual,Pl,Fem>  => yN ;

       <Pers2_Familiar,Sg,Masc> => e ;
       <Pers2_Familiar,Sg,Fem>  => y; --variants{roo+y ; roo+yN} ;
       <Pers2_Familiar,Pl,Masc> => e ;
       <Pers2_Familiar,Pl,Fem>  => yN ;       
       
       <Pers2_Respect,Sg,Masc>  => e ;
       <Pers2_Respect,Sg,Fem>   => yN; --variants{roo+yN ; roo+y} ;
       <Pers2_Respect,Pl,Masc>  => e ;
       <Pers2_Respect,Pl,Fem>   => yN ;
       <_,Sg,Masc>              => a; --*
       <_,Sg,Fem>              => y ; 
	   <_,Pl,Masc>              =>  e; 
       <_,Pl,Fem>              => yN 
       
     } ;
    } ;

   mkImpert : Str -> UPerson -> Number -> Gender -> {s:Str} = \root,p,n,g ->
    {s = let roo =  root ;
             w = case (last root) of {
                  "ा" => "ओ" ;
		  "ो" => "ओ" ;
                  _           => "ो"
               } ;
             yN = case (last root) of {
                  "ा"|"ो" => "एँ" ;
                  _           => "एँ" 
               } ;
             e = case (last root) of {
                  "ा"|"ो" => "ए" ;
		  "े" => "" ;
		  "ी" => "ये" ;
                  _           => "ए" 
               } in
      case <p,n,g> of {
       <Pers1,_,_>          => ""; --nonExist ;
       <Pers2_Casual,Sg,_>  => root ;
       <Pers2_Casual,Pl,_>  => roo+w ;
       <Pers2_Familiar,_,_> => roo+w ;
       <Pers2_Respect,Sg,_> => roo+w; --variants{roo+w; roo+yN; roo+yE} ;
       <Pers2_Respect,Pl,_> => roo+yN; --variants{roo+yN; roo+yE} ;
       <_,Sg,_>              => roo+e ; 
       <_,Pl,_>              => roo+yN 
      }; 
    };       

}
