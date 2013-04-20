--# -path=.:../../prelude
--
----1 A Simple Urdu Resource Morphology
----
----  Shafqat Virk, Aarne Ranta,2009
----
---- This resource morphology contains definitions needed in the resource
---- syntax. To build a lexicon, it is better to use $ParadigmsUrd$, which
---- gives a higher-level access to this module.
--
resource MorphoUrd = ResUrd ** open CommonHindustani,Prelude,Predef,ParamX in {

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
		     _ + "یا" => mkN05 (s);
                 _ + ("ا"|"ع"|"ہ") =>  mkN01 (s);
                 _ + "ی" => mkN03 (s);
                 _ + ("اں"|"وں") => mkN04 (s);
                 _ + "ؤ" => mkN12 (s);
		 _ + "ت" => mkN10 s ;
             _			  => regNoun2 (s)				 
                 };
	regNoun2 : Str -> Noun;
	regNoun2 s = let c = if_then_else Bool (eq (last s) "ا" ) True (if_then_else Bool (eq (last s) "ہ") True (if_then_else Bool (eq (last s) "ع") True False))
     in case c of {
      False => mkN02 (s);
	  True => mkN01 (s)
     };	  
	  
    reggNoun : Str -> Gender -> Noun ;
    reggNoun s g = let c = if_then_else Bool (eq (last s) "ا" ) True (if_then_else Bool (eq (dp 2 s) "اں") True (if_then_else Bool (eq (dp 2 s) "وں") True False))
	 in case <s,g,c> of {
		         <_ + "ت",Fem,_> => mkN10 (s);
				 <_ + "ت",Masc,_> => mkN02 (s);
				 <_ + "و",Masc,_> => mkN11 (s);
                 <_ + "و",Fem,_> 	=> mkN07 (s);
				 <_ + "یا",Fem,_> => mkN05 (s);
                 <_ + "یا",Masc,_> => mkN02 (s);
                 <_,Fem,False>		=> mkN08 (s);
                 <_,Fem,_>		=> mkN09 (s)
                 				 
                 };
    
-- masculine nouns end with alif, choTi_hay, ain Translitration: (a, h, e)
-- Arabic nouns ends with h. also taken as Masc

     mkN01 : Str -> Noun ;
     mkN01 lRka = let end = last (lRka) ;
                 lRk = if_then_else Str (eq end "ع") lRka (tk 1 lRka)
             in mkNoun (lRka)     (lRk+"ے")  (lRk+"ے")
                       (lRk+"ے")  (lRk+"وں") (lRk+"و")
                       Masc ;

-- masculine nouns does not end with a, h, e, an

     mkN02 : Str -> Noun ;
     mkN02 mrd = let mrdwN = mrd+"وں" ;
              mrdw  = tk 1 mrdwN
              in mkNoun mrd mrd   mrd
                      mrd mrdwN mrdw
                      Masc ;

-- feminine Nouns end with y

     mkN03 : Str -> Noun ;
     mkN03 krsy = let krsyaN  = krsy+"اں" ;
		 krsywN  = krsy+"وں" ;
		 krsyw   = tk 1 krsywN
             in mkNoun krsy   krsy   krsy
                       krsyaN krsywN krsyw
                       Fem ;

-- feminine nouns end with a, aN, wN
     mkN04 : Str -> Noun ;
     mkN04 n = case last n of {
     "ا" => let bla = n
        in mkNoun bla          bla         bla
                  (bla+"ئیں") (bla+"ؤں") (bla+"ؤ")
                  Fem ;
      _   => let maN = n ; -- ends with aN and wN
            ma  = tk 1 maN
        in mkNoun maN         maN        maN
                  (ma+"ئیں") (ma+"ؤں") (ma+"ؤں")
                  Fem 

            };
  --feminine nouns end with ya
    
      mkN05 : Str -> Noun ;
      mkN05 gRya = let gRy = (tk 1 gRya)
             in mkNoun gRya       gRya       gRya
                       (gRya+"ں") (gRy+"وں") (gRy+"و")
                       Fem ;

-- feminine nouns end with w
      
      mkN07 : Str -> Noun ;
      mkN07 khshbw =  mkNoun khshbw     khshbw         khshbw
                            (khshbw + "ئیں") (khshbw + "ؤں") (khshbw + "ؤ")
                            Fem ;

-- Loan arabic feminine nouns end with t
-- this is a noun that shows  state, condition 

      mkN10 : Str -> Noun ;
      mkN10 ndamt = mkNoun ndamt        ndamt        ndamt
                     (ndamt+"یں") (ndamt+"وں") (ndamt+"و")
                     Fem ;
-- Worst case function
      mkN : (_,_,_,_,_,_ : Str) -> Gender -> Noun ;
      mkN sgNom sgObl sgVoc plNom plObl plVoc g = 
      mkNoun sgNom sgObl sgVoc plNom plObl plVoc g ;

      mkN06 : Str -> Noun ;
      mkN06 rya = mkNoun rya          rya         rya 
                   (rya+"ئیں") (rya+"ؤں") rya
                   Fem ;

-- feminine nouns that do not end with a, N, w, wN
     
      mkN08 : Str -> Noun ;
      mkN08 ktab = mkNoun ktab ktab ktab
                    (ktab+"یں") (ktab+"وں") (ktab+"و")
                    Fem ;

-- Loan arabic feminine nouns
     
      mkN09 : Str -> Noun ;
      mkN09 ahsan = mkNoun ahsan        ahsan                             ahsan
                     (ahsan+"ات")  (ahsan+"ات") (ahsan+"و") 
                     Fem ;
-- (variants{ahsan+"ات";ahsan+"وں"})
-- Loan persian maculine nouns end with w

      mkN11 : Str -> Noun ;
      mkN11 alw = mkNoun alw alw         alw
                   alw (alw+"ؤں") (alw+"ؤ")
                   Masc ;


-- Loan persian maculine nouns end with w^

      mkN12 : Str -> Noun ;
      mkN12 bhao = mkNoun (bhao)      (bhao)     (bhao)
                          (bhao)      (bhao)     (bhao)
                    Masc ;

-- Adjectives
  compoundAdj : Str -> Str -> Adjective = \s1,s2 -> mkCompoundAdj (regAdjective s1) (regAdjective s2) ;
   mkCompoundAdj : Adjective -> Adjective -> Adjective ;
   mkCompoundAdj adj1 adj2 = {s = \\n,g,c,d => adj1.s ! n ! g ! c ! d ++ adj2.s ! n ! g ! c ! d} ;

  regAdjective : Str -> Adjective; 
  regAdjective x =  case x of {
	              acch + ("ا"|"اں") => mkAdjective x  ("بہت" ++ x)          ("سب سے" ++ x)          (acch + "ے") ("بہت" ++ acch + "ے") ("سب سے" ++ acch + "ے") (acch + "ے") ("بہت" ++ acch + "ے") ("سب سے" ++ acch + "ے")
		                                      (acch + "ی") ("بہت" ++ acch + "ی") ("سب سے" ++ acch + "ی") (acch + "ی") ("بہت" ++ acch + "ی") ("سب سے" ++ acch + "ی") (acch + "ی") ("بہت" ++ acch + "ی") ("سب سے" ++ acch + "ی")
						      (acch +"ے")  ("بہت" ++ acch + "ے") ("سب سے" ++ acch + "ے") (acch + "ے") ("بہت" ++ acch + "ے") ("سب سے" ++ acch + "ے") (acch + "ے") ("بہت" ++ acch + "ے") ("سب سے" ++ acch + "ے")
		                                      (acch + "ی") ("بہت" ++ acch + "ی") ("سب سے" ++ acch + "ی") (acch + "ی") ("بہت" ++ acch + "ی") ("سب سے" ++ acch + "ی") (acch + "ی") ("بہت" ++ acch + "ی") ("سب سے" ++ acch + "ی");
									
                        _                 => mkAdjective  x  ("بہت" ++ x)  	("سب سے" ++ x)  x ("بہت" ++ x) ("سب سے" ++ x) x ("بہت" ++ x) ("سب سے" ++ x)
							  x  ("بہت" ++ x) 	("سب سے" ++ x) 	x ("بہت" ++ x) ("سب سے" ++ x) x ("بہت" ++ x) ("سب سے" ++ x)
							  x  ("بہت" ++ x) 	("سب سے" ++ x)  x ("بہت" ++ x) ("سب سے" ++ x) x ("بہت" ++ x) ("سب سے" ++ x)
							  x  ("بہت" ++ x) 	("سب سے" ++ x)  x ("بہت" ++ x) ("سب سے" ++ x) x ("بہت" ++ x) ("سب سے" ++ x)
																 
                            }; 



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
    
-- IQuant
  
makeIQuant : Str -> {s : Number => Gender => Case => Str} = \str -> {
  s = table {
	        Sg => table {
				Masc => table {
						     Dir => str ++ "سا" ;
						      _ => str ++ "سے" 
                             
							 };
				Fem => table {
						     _ => str ++ "سی"
							 }
						};
		Pl => table {
				Masc => table {
						     _ => str ++ "سے"
							 };
				Fem => table {
						     _ => str ++ "سی"
							 }
					} 
				}
               };    
   
    
-- Proposition  
 
  makePrep : Str -> Str -> Preposition = \s1,s2 -> {s =
  table {
                Masc => s1;
		Fem  => s2
	 }; } **  { lock_Prep = <>};
   
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
   makePersPron     = mkPersPron	"m(a)یں"	"m(o)j'|ہ"		""		"t(o)و "		"t(o)j|ہ"		"t(o)و "		"t(o)م"		"t(o)م"		"t(o)م"		"آپ"		"آپ"		"آپ"		"y(i)ہ"		"a(i)س"		""		"w(o)ہ"		"a(o)س"		""
									"h(a)م"		"h(a)م"			""		"t(o)م" 		"t(o)م"			"t(o)م"			"t(o)م"		"t(o)م"		"t(o)م"		"آپ"		"آپ"		"آپ"		"y(i)ہ"		"a(i)ن"		""		"w(o)ہ"		"a(o)ن"		"" ;
						
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
-- defined in ResUrd

----3 Verbs
  CommonVF = {s : VTense => UPerson => Number => Gender => Str} ;
 
   mkVerb : (x1: Str) -> Verb = \inf  ->
     	 let root = (tk 2 inf); inf_obl = ((tk 1 inf) + "ے"); inf_fem = ((tk 1 inf) + "ی")
	in { s = table {
          
               VF tense person number gender => (mkCmnVF root tense person number gender).s  ;
               Inf     => inf ;
               Root    => root ;
               Inf_Obl => inf_obl ;
               Inf_Fem => inf_fem 
          
          
       };
       cvp = [] 
     } ;
   rem_y : Str -> Str;
   rem_y str = let b = take 1 str; yth = drop 1 str; a1	= take 4 yth; a2 = take 1 yth; 	th= if_then_else Str (eq a1 "(a)ی") (drop 5 str) (drop 2 str);	st = if_then_else Str (eq a1 "(a)ی") (b ++ "(i)"++th) (if_then_else Str (eq a2 "ی") (b ++ th)  str)
              in rt st;
	rt: Str -> Str;
	rt r = r;
   mkCmnVF : Str -> VTense -> UPerson -> Number -> Gender -> {s:Str} =
    \root,t,p,n,g ->
     {s = 
      let form1 = case (last root) of {
                  "ا"|"آ"|"و" => root + "ؤں" ;
                  _           => root + "وں"
                 };
          form2 =  case (last root) of {
                  "ا"|"آ"|"و" => root + "ئں" ;
                  _           => root + "یں"
                 };
	 in
       case <t,p,n,g> of {
        <Subj,Pers1,Sg,_> => form1 ;
        <Subj,Pers1,Pl,_> => form2 ;
        <Subj,_,_,_>      => (mkImpert root p n g).s ;
        <Perf,_,_,_>      => case root of {
		                      "ہو" => (mkPastInd root p n g).s ;
				      "جا" => (mkPastInd "گی" p n g).s ;
				      "کر" => (mkPastInd "ک" p n g).s ;
				      "دے" => (mkPastInd "د" p n g).s ;
				      "لے" => (mkPastInd "ل" p n g).s ;
				      _    => (mkPastInd root p n g).s };
        <Imperf,Pers2_Familiar,Sg,Masc>         => root + "تے";
        <Imperf,Pers2_Familiar,Sg,Fem>         => root + "تی"; --variants{root+"تی" ; root+"تیں"};	
        <Imperf,Pers2_Familiar,Pl,Masc>         => root + "تے";
        <Imperf,Pers2_Familiar,Pl,Fem>         => root+"تیں";
        <Imperf,Pers2_Respect,Sg,Masc>         => root + "تے";
        <Imperf,Pers2_Respect,Sg,Fem>         => root + "تی"; --variants{root+"تی" ; root+"تیں"};	
        <Imperf,Pers2_Respect,Pl,Masc>         => root + "تے";
        <Imperf,Pers2_Respect,Pl,Fem>         => root+"تیں";
		<Imperf,_,Sg,Masc>					  => root+"تا";
		<Imperf,_,Sg,Fem>					  => root+"تی";
		<Imperf,_,Pl,Masc>					  => root+"تے";
		<Imperf,_,Pl,Fem>					  => root+"تیں"
        }
       
     } ;
   
   mkPastInd : Str -> UPerson -> Number -> Gender -> {s:Str} = \root,p,n,g ->
    {s = let roo = root ;
             a = case (last root) of {
                  "ا"|"آ"|"و"|"ک" => "یا" ;
                  _           => "ا"
                 } ;
             y = case (last root) of {
                  "ا"|"آ"|"و" => "ئی" ;
                  _           => "ی"
                 } ;
             e = case (last root) of {
                  "ا"|"آ"|"و"|"ک" => "ئے" ;
                  _           => "ے"
                 } ;
            yN = case (last root) of {
                  "ا"|"آ"|"و" => "ئیں" ;
                  _           => "یں"
                 } ;

     in 
     case <p,n,g> of {
       <Pers1,Sg,Masc> => roo+a ;
       <Pers1,Sg,Fem>  => roo+y ;
       <Pers1,Pl,Masc> => roo+e ;
       <Pers1,Pl,Fem>  => roo+yN ;

       <Pers2_Casual,Sg,Masc> => roo+a ;
       <Pers2_Casual,Sg,Fem>  => roo+y ;
       <Pers2_Casual,Pl,Masc> => roo+e ;       
       <Pers2_Casual,Pl,Fem>  => roo+yN ;

       <Pers2_Familiar,Sg,Masc> => roo+e ;
       <Pers2_Familiar,Sg,Fem>  => roo+y; --variants{roo+y ; roo+yN} ;
       <Pers2_Familiar,Pl,Masc> => roo+e ;
       <Pers2_Familiar,Pl,Fem>  => roo+yN ;       
       
       <Pers2_Respect,Sg,Masc>  => roo+e ;
       <Pers2_Respect,Sg,Fem>   => roo+yN; --variants{roo+yN ; roo+y} ;
       <Pers2_Respect,Pl,Masc>  => roo+e ;
       <Pers2_Respect,Pl,Fem>   => roo+yN ;
       <_,Sg,Masc>              => roo + a; 
       <_,Sg,Fem>              => roo+y ; 
	   <_,Pl,Masc>              => roo + e; 
       <_,Pl,Fem>              => roo+yN 
       
     } ;
    } ;

   mkImpert : Str -> UPerson -> Number -> Gender -> {s:Str} = \root,p,n,g ->
    {s = let roo =  root ;
             w = case (last root) of {
                  "ا"|"آ"|"و" => "ؤ" ;
                  _           => "و"
               } ;
             yN = case (last root) of {
                  "ا"|"آ"|"و" => "ئیں" ;
                  _           => "یں" 
               } ;
             yE = case (last root) of {
                  "ا"|"آ"|"و" => "ئیے" ;
                  _           => "یے" 
               } ;
             e = case (last root) of {
                  "ا"|"آ"|"و" => "ئے" ;
                  _           => "ے" 
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
