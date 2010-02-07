--# -path=.:../abstract:../common:../../prelude
--
--1 Urdu auxiliary operations.
--
-- This module contains operations that are needed to make the
-- resource syntax work. 

resource ResUrd = ParamX  ** open Prelude,Predef in {

  flags optimize=all ;

  param 
    Case = Dir | Obl | Voc ;
    Gender = Masc | Fem ;
	VTense = Subj | Perf | Imperf;
    UPerson = Pers1
	    | Pers2_Casual
	    | Pers2_Familiar 
	    | Pers2_Respect
	    | Pers3_Near
	    | Pers3_Distant;
		
	Order = ODir | OQuest ;
	
	--2 For $Relative$
 
    RAgr = RNoAg | RAg Agr ;
    RCase = RC Number Case ;

-- for Numerial
   
   CardOrd = NCard | NOrd ;
  
  -----------------------------------------
  -- Urd Pronouns
  -----------------------------------------
   Pronoun = P Number Gender Case UPerson;
   DemPronForm = 	DPF Number Case; 
   PersPronForm = PPF Number UPerson Case;
--   PossPronForm = PossF Number UPerson Gender; -- to be implemented
   RefPronForm = RefPF;
--   InterrPronForm = IntPF Number Case;
--   InterrPronForm1 = IntPF1;
--   InterrPronForm2 = IntPF2 Number Case Gender;
--   InterrPronForm3 = IntPF3 Number Gender;
--   IndefPronForm = IPF Case Gender;
--   IndefPronForm1 = IPF1 Case;
--   IndefPronForm2 = IPF2;
--   RelPronForm = RPF Number Case;
--   RelPronForm1 = RPF1 Number Gender;
--   RelPronForm2 = RPF2 Case;
--   RelPronForm3 = RPF3;
	
  -----------------------------------------------
  -- Determiners
  -----------------------------------------------
  
  Determiner = DT Number Gender;
  
  
  --------------------------------------------
  -- Propositions
  --------------------------------------------
  
  Proposition = PP Number Gender;
  
  -----------------------------------------------
  --Verbs
  ----------------------------------------------
  
  

      VerbForm = VF VTense UPerson Number Gender
                | Inf
                | Root
                | Inf_Obl
                | Inf_Fem;				

	
  oper
    Noun = {s : Number => Case => Str ; g : Gender} ;

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
		     _ + "ya" => mkN05 (s);
                 _ + ("a"|"e"|"h") =>  mkN01 (s);
                 _ + "y" => mkN03 (s);
                 _ + ("aN"|"wN") => mkN04 (s);
                 _ + "w^" => mkN12 (s);
             _			  => regNoun2 (s)				 
                 };
	regNoun2 : Str -> Noun;
	regNoun2 s = let c = if_then_else Bool (eq (last s) "a" ) True (if_then_else Bool (eq (last s) "h") True (if_then_else Bool (eq (last s) "e") True False))
     in case c of {
      False => mkN02 (s);
	  True => mkN01 (s)
     };	  
	  
    reggNoun : Str -> Gender -> Noun ;
    reggNoun s g = let c = if_then_else Bool (eq (last s) "a" ) True (if_then_else Bool (eq (dp 2 s) "aN") True (if_then_else Bool (eq (dp 2 s) "wN") True False))
	 in case <s,g,c> of {
		         <_ + "t",Fem,_> => mkN10 (s);
				 <_ + "t",Masc,_> => mkN02 (s);
				 <_ + "w",Masc,_> => mkN11 (s);
                 <_ + "w",Fem,_> 	=> mkN07 (s);
				 <_ + "ya",Fem,_> => mkN05 (s);
                 <_ + "ya",Masc,_> => mkN02 (s);
                 <_,Fem,False>		=> mkN08 (s);
                 <_,Fem,_>		=> mkN09 (s)
                 				 
                 };
    
-- masculine nouns end with alif, choTi_hay, ain Translitration: (a, h, e)
-- Arabic nouns ends with h. also taken as Masc

     mkN01 : Str -> Noun ;
     mkN01 lRka = let end = last (lRka) ;
                 lRk = if_then_else Str (eq end "e") lRka (tk 1 lRka)
             in mkNoun (lRka)     (lRk+"E")  (lRk+"E")
                       (lRk+"E")  (lRk+"wN") (lRk+"w")
                       Masc ;

-- masculine nouns does not end with a, h, e, an

     mkN02 : Str -> Noun ;
     mkN02 mrd = let mrdwN = mrd+"wN" ;
              mrdw  = tk 1 mrdwN
              in mkNoun mrd mrd   mrd
                      mrd mrdwN mrdw
                      Masc ;

-- feminine Nouns end with y

     mkN03 : Str -> Noun ;
     mkN03 krsy = let krsyaN  = krsy+"aN" ;
		 krsywN  = krsy+"wN" ;
		 krsyw   = tk 1 krsywN
             in mkNoun krsy   krsy   krsy
                       krsyaN krsywN krsyw
                       Fem ;

-- feminine nouns end with a, aN, wN
     mkN04 : Str -> Noun ;
     mkN04 n = case last n of {
     "a" => let bla = n
        in mkNoun bla          bla         bla
                  (bla+"y^yN") (bla+"w^N") (bla+"w^")
                  Fem ;
      _   => let maN = n ; -- ends with aN and wN
            ma  = tk 1 maN
        in mkNoun maN         maN        maN
                  (ma+"y^yN") (ma+"w^N") (ma+"w^N")
                  Fem 

            };
  --feminine nouns end with ya
    
      mkN05 : Str -> Noun ;
      mkN05 gRya = let gRy = (tk 1 gRya)
             in mkNoun gRya       gRya       gRya
                       (gRya+"N") (gRy+"wN") (gRy+"w")
                       Fem ;

-- feminine nouns end with w
      
      mkN07 : Str -> Noun ;
      mkN07 khshbw =  mkNoun khshbw     khshbw         khshbw
                            (khshbw + "y^yN") (khshbw + "w^N") (khshbw + "w^")
                            Fem ;

-- Loan arabic feminine nouns end with t
-- this is a noun that shows  state, condition 

      mkN10 : Str -> Noun ;
      mkN10 ndamt = mkNoun ndamt        ndamt        ndamt
                     (ndamt+"yN") (ndamt+"wN") (ndamt+"w")
                     Fem ;
-- Worst case function
      mkN : (_,_,_,_,_,_ : Str) -> Gender -> Noun ;
      mkN sgNom sgObl sgVoc plNom plObl plVoc g = 
      mkNoun sgNom sgObl sgVoc plNom plObl plVoc g ;

      mkN06 : Str -> Noun ;
      mkN06 rya = mkNoun rya          rya         rya 
                   (rya+"y^yN") (rya+"w^N") rya
                   Fem ;

-- feminine nouns that do not end with a, N, w, wN
     
      mkN08 : Str -> Noun ;
      mkN08 ktab = mkNoun ktab ktab ktab
                    (ktab+"yN") (ktab+"wN") (ktab+"w")
                    Fem ;

-- Loan arabic feminine nouns
     
      mkN09 : Str -> Noun ;
      mkN09 ahsan = mkNoun ahsan        ahsan                             ahsan
                     (ahsan+"at") (variants{ahsan+"at";ahsan+"wN"}) (ahsan+"w")
                     Fem ;

-- Loan persian maculine nouns end with w

      mkN11 : Str -> Noun ;
      mkN11 alw = mkNoun alw alw         alw
                   alw (alw+"w^N") (alw+"w^")
                   Masc ;


-- Loan persian maculine nouns end with w^

      mkN12 : Str -> Noun ;
      mkN12 bhao = mkNoun (bhao)      (bhao)     (bhao)
                          (bhao)      (bhao)     (bhao)
                    Masc ;


-- a useful oper
--    eq : Str -> Str -> Bool = \s1,s2-> (pbool2bool (eqStr s1 s2)) ;

  
  oper
     -- Combining all verb patterns
    Verb = {s : VerbForm => Str} ;


    --Common Verb Forms between all type of verbs
    CommonVF = {s : VTense => UPerson => Number => Gender => Str} ;
 
   mkVerb : (x1: Str) -> Verb = \inf  ->
     	 let root = (tk 2 inf); inf_obl = ((tk 1 inf) + "E"); inf_fem = ((tk 1 inf) + "y")
	in { s = table {
          
               VF tense person number gender => (mkCmnVF root tense person number gender).s  ;
               Inf     => inf ;
               Root    => root ;
               Inf_Obl => inf_obl ;
               Inf_Fem => inf_fem 
          
          
       }
     } ;
   rem_y : Str -> Str;
   rem_y str = let b = take 1 str; yth = drop 1 str; a1	= take 4 yth; a2 = take 1 yth; 	th= if_then_else Str (eq a1 "(a)y") (drop 5 str) (drop 2 str);	st = if_then_else Str (eq a1 "(a)y") (b ++ "(i)"++th) (if_then_else Str (eq a2 "y") (b ++ th)  str)
              in rt st;
	rt: Str -> Str;
	rt r = r;
   mkCmnVF : Str -> VTense -> UPerson -> Number -> Gender -> {s:Str} =
    \root,t,p,n,g ->
     {s = 
      let form1 = case (last root) of {
                  "a"|"A"|"w" => root + "w^N" ;
                  _           => root + "wN"
                 };
          form2 =  case (last root) of {
                  "a"|"A"|"w" => root + "y^N" ;
                  _           => root + "yN"
                 };
	 in
       case <t,p,n,g> of {
        <Subj,Pers1,Sg,_> => form1 ;
        <Subj,Pers1,Pl,_> => form2 ;
        <Subj,_,_,_>      => (mkImpert root p n g).s ;
        <Perf,_,_,_>      => case root of {
		                      "hw" => (mkPastInd root p n g).s ;
							  "ja" => (mkPastInd "gy" p n g).s ;
							  "kr" => (mkPastInd "k" p n g).s ;
							  "dE" => (mkPastInd "d" p n g).s ;
							  "lE" => (mkPastInd "l" p n g).s ;
							  _    => (mkPastInd root p n g).s };
        <Imperf,Pers2_Familiar,Sg,Masc>         => root + "tE";
        <Imperf,Pers2_Familiar,Sg,Fem>         => variants{root+"ty" ; root+"tyN"};	
        <Imperf,Pers2_Familiar,Pl,Masc>         => root + "tE";
        <Imperf,Pers2_Familiar,Pl,Fem>         => root+"tyN";
        <Imperf,Pers2_Respect,Sg,Masc>         => root + "tE";
        <Imperf,Pers2_Respect,Sg,Fem>         => variants{root+"ty" ; root+"tyN"};	
        <Imperf,Pers2_Respect,Pl,Masc>         => root + "tE";
        <Imperf,Pers2_Respect,Pl,Fem>         => root+"tyN";
		<Imperf,_,Sg,Masc>					  => root+"ta";
		<Imperf,_,Sg,Fem>					  => root+"ty";
		<Imperf,_,Pl,Masc>					  => root+"te";
		<Imperf,_,Pl,Fem>					  => root+"tyN"
        }
       
     } ;
   
   mkPastInd : Str -> UPerson -> Number -> Gender -> {s:Str} = \root,p,n,g ->
    {s = let roo = root ;
             a = case (last root) of {
                  "a"|"A"|"w"|"k" => "ya" ;
                  _           => "a"
                 } ;
             y = case (last root) of {
                  "a"|"A"|"w" => "y^y" ;
                  _           => "y"
                 } ;
             e = case (last root) of {
                  "a"|"A"|"w"|"k" => "y^E" ;
                  _           => "E"
                 } ;
            yN = case (last root) of {
                  "a"|"A"|"w" => "y^yN" ;
                  _           => "yN"
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
       <Pers2_Familiar,Sg,Fem>  => variants{roo+y ; roo+yN} ;
       <Pers2_Familiar,Pl,Masc> => roo+e ;
       <Pers2_Familiar,Pl,Fem>  => roo+yN ;       
       
       <Pers2_Respect,Sg,Masc>  => roo+e ;
       <Pers2_Respect,Sg,Fem>   => variants{roo+yN ; roo+y} ;
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
                  "a"|"A"|"w" => "w^" ;
                  _           => "w"
               } ;
             yN = case (last root) of {
                  "a"|"A"|"w" => "y^yN" ;
                  _           => "yN" 
               } ;
             yE = case (last root) of {
                  "a"|"A"|"w" => "y^yE" ;
                  _           => "yE" 
               } ;
             e = case (last root) of {
                  "a"|"A"|"w" => "y^E" ;
                  _           => "E" 
               } in
      case <p,n,g> of {
       <Pers1,_,_>          => nonExist ;
       <Pers2_Casual,Sg,_>  => root ;
       <Pers2_Casual,Pl,_>  => roo+w ;
       <Pers2_Familiar,_,_> => roo+w ;
       <Pers2_Respect,Sg,_> => variants{roo+w; roo+yN; roo+yE} ;
       <Pers2_Respect,Pl,_> => variants{roo+yN; roo+yE} ;
       <_,Sg,_>              => roo+e ; 
       <_,Pl,_>              => roo+yN 
      }; 
    };       


  
-- a useful oper
    eq : Str -> Str -> Bool = \s1,s2-> (pbool2bool (eqStr s1 s2)) ;

   
   -----------------------------------------
   -- Pronouns opers
   -----------------------------------------
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
   makeIP : (x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12:Str) -> PronForm =
    \y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12 -> {
      s = table {
       P Sg Mas Dir _ => y1;
       P Sg Mas Obl _ => y2;	   
	   P Sg Mas Voc _ => y3;
	   P Sg Fem Dir _ => y4;
       P Sg Fem Obl _ => y5;	   
	   P Sg Fem Voc _ => y6;
	   P Pl Mas Dir _ => y7;
       P Pl Mas Obl _ => y8;	   
	   P Pl Mas Voc _ => y9;
	   P Pl Fem Dir _ => y10;
       P Pl Fem Obl _ => y11;	   
	   P Pl Fem Voc _ => y12
	   };
	  }; 
	   
   DemonPronForm = {s:DemPronForm => Str};
  mkDemonPronForm : (x1,x2,x3,x4,x5,x6:Str) -> DemonPronForm =
  \y1,y2,y3,y4,y5,y6 -> {
   s = 
    table {
	 DPF Sg Dir => y1;
	 DPF Sg Obl => y2;
	 DPF Sg Voc => y3;
	 DPF Pl Dir => y4;
	 DPF Pl Obl => y5;
	 DPF Pl Voc => y6
	 };
	}; 
   makeDemonPronForm : Str -> Str -> Str -> DemonPronForm ;
   makeDemonPronForm  yeh is inn = mkDemonPronForm 	yeh	is	""	yeh	inn	"";	
   
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
						

	------- PossPronForm yet to be implemented
 RefPron = {s:RefPronForm => Str};
   mkRefPron : (x:Str) -> RefPron =
   \y -> {
     s = 
	  table {
	    RefPF => y
		};
	 };	
    
  makeRefPron : Str -> RefPron;
  makeRefPron str = mkRefPron "khud";  
  
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
{-
--  makeIntPronForm : IntPronForm ;
--  makeIntPronForm  = mkIntPronForm 	"k(a)ya"	"k(i)s"		"k(a)wn"	"k(a)ya"	"k(i)n "		"k(a)wn";	

 IntPronForm1 = {s:InterrPronForm1 => Str};
   mkIntPronForm1 : (x:Str) -> IntPronForm1 =
   \y -> {
     s = 
	  table {
	    IntPF1 => y
		};
	 };	
    
  makeIntPronForm1 : Str -> IntPronForm1;
  makeIntPronForm1 str = mkIntPronForm1 str;  

 IntPronForm2 = {s:InterrPronForm2 => Str};
  mkIntPronForm2 : (x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12:Str) -> IntPronForm2 =
  \y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12 -> {
   s = 
    table {
	 IntPF2 Sg Dir Masc => y1;
	 IntPF2 Sg Dir Fem => y2;
	 IntPF2 Sg Obl Masc => y3;
	 IntPF2 Sg Obl Fem => y4;
	 IntPF2 Sg Voc Masc => y5;
	 IntPF2 Sg Voc Fem => y6;
	 IntPF2 Pl Dir Masc => y7;
	 IntPF2 Pl Dir Fem => y8;
	 IntPF2 Pl Obl Masc => y9;
	 IntPF2 Pl Obl Fem => y10;
	 IntPF2 Pl Voc Masc => y11;
	 IntPF2 Pl Voc Fem => y12
	 };
	};  
  makeIntPronForm2 : Str -> Str -> Str -> IntPronForm2;
  makeIntPronForm2 ktna ktne ktny = mkIntPronForm2 ktna	ktny	ktne	ktny	ktna	ktny	ktne	""	ktne	""	ktne	"";	
 
  IntPronForm3 = {s:InterrPronForm3 => Str};
  mkIntPronForm3 : (x1,x2,x3,x4:Str) -> IntPronForm3 =
  \y1,y2,y3,y4 -> {
   s = 
    table {
	 IntPF3 Sg Masc => y1;
	 IntPF3 Sg Fem => y2;
	 IntPF3 Pl Masc => y3;
	 IntPF3 Pl Fem => y4
	  };
	}; 
  makeIntPronForm3 : Str -> Str -> Str ->IntPronForm3 ;
  makeIntPronForm3  kysa kyse kysy = mkIntPronForm3 	kysa	kysy	kyse	kysy;	

  IndfPronForm = {s:IndefPronForm => Str};
  mkIndfPronForm : (x1,x2,x3,x4,x5,x6:Str) -> IndfPronForm =
  \y1,y2,y3,y4,y5,y6 -> {
   s = 
    table {
	 IPF Dir Masc => y1;
	 IPF Dir Fem => y2;
	 IPF Obl Masc => y3;
	 IPF Obl Fem => y4;
	 IPF Voc Masc => y5;
	 IPF Voc Fem => y6
	 };
	}; 
   makeIndfPronForm : Str -> Str -> IndfPronForm ;
  makeIndfPronForm  flaN flany = mkIndfPronForm 	flaN	flany	flaN	flany	flaN	flany;		
  
  IndfPronForm1 = {s:IndefPronForm1 => Str};
  mkIndfPronForm1 : (x1,x2,x3:Str) -> IndfPronForm1 =
  \y1,y2,y3 -> {
   s = 
    table {
	 IPF1 Dir => y1;
	 IPF1 Obl => y2;
	 IPF1 Voc => y3
	 };
	}; 
  makeIndfPronForm1 : Str -> IndfPronForm1 ;
  makeIndfPronForm1  khuch = mkIndfPronForm1 	khuch	khuch	khuch;

  IndfPronForm2 = {s:IndefPronForm2 => Str};
  mkIndfPronForm2 : (x:Str) -> IndfPronForm2 =
  \y -> {
   s = 
    table {
	 IPF2 => y
	 };
	}; 
	
   makeIndfPronForm2 : Str -> IndfPronForm2 ;
   makeIndfPronForm2  w = mkIndfPronForm2 	w;  
   
   
   RelvPronForm = {s:RelPronForm => Str};
   mkRelvPronForm : (x1,x2,x3,x4,x5,x6:Str) -> RelvPronForm =
   \y1,y2,y3,y4,y5,y6 -> {
   s = 
    table {
	 RPF Sg Dir => y1;
	 RPF Sg Obl => y2;
	 RPF Sg Voc => y3;
	 RPF Pl Dir => y4;
	 RPF Pl Obl => y5;
	 RPF Pl Voc => y6
	 };
	}; 
   makeRelvPronForm : RelvPronForm ;
   makeRelvPronForm  = mkRelvPronForm 	"jw"	"j(i)s"		""		"jw"	"j(i)"		"";
   
   RelvPronForm1 = {s:RelPronForm1 => Str};
   mkRelvPronForm1 : (x1,x2,x3,x4:Str) -> RelvPronForm1 =
   \y1,y2,y3,y4 -> {
   s = 
    table {
	 RPF1 Sg Masc => y1;
	 RPF1 Sg Fem => y2;
	 RPF1 Pl Masc => y3;
	 RPF1 Pl Fem => y4
	 };
	}; 
   makeRelvPronForm1 : Str -> Str -> Str -> RelvPronForm1 ;
   makeRelvPronForm1  jwnsa	jwnse jwnsy = mkRelvPronForm1 	jwnsa	jwnsy	jwnse	jwnsy;
   
   RelvPronForm2 = {s:RelPronForm2 => Str};
   mkRelvPronForm2 : (x1,x2,x3:Str) -> RelvPronForm2 =
   \y1,y2,y3 -> {
   s = 
    table {
	 RPF2 Dir => y1;
	 RPF2 Obl => y2;
	 RPF2 Voc => y3
	 };
	}; 
   makeRelvPronForm2 : Str -> RelvPronForm2 ;
   makeRelvPronForm2  aysa = mkRelvPronForm2 	aysa	aysa	aysa;
   
   RelvPronForm3 = {s:RelPronForm3 => Str};
   mkRelvPronForm3 : (x:Str) -> RelvPronForm3 =
   \y -> {
   s = 
    table {
	 RPF3 => y
	 };
	}; 
   makeRelvPronForm3 : Str -> RelvPronForm3 ;
   makeRelvPronForm3  aya = mkRelvPronForm3 	aya;
   
   -}
   
   -----------------------------------------------
   -- Urd Adjectives
   -----------------------------------------------
   
    Adjective = { s: Number => Gender => Case => Degree => Str };    


    mkAdjective : (x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21,x22,x23,x24,x25,x26,x27,x28,x29,x30,x31,x32,x33,x34,x35,x36:Str) -> Adjective = 
    \y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12,y13,y14,y15,y16,y17,y18,y19,y20,y21,y22,y23,y24,y25,y26,y27,y28,y29,y30,y31,y32,y33,y34,y35,y36 -> {
     s = table {
	    Sg => table {
		        Masc => table {
				        Dir => table {
						     Posit  => y1 ;
                             Compar => y2 ;
                             Superl => y3
							 };
						Obl => table {
						     Posit  => y4 ;
                             Compar => y5 ;
                             Superl => y6
							 };
						Voc => table {
						     Posit  => y7 ;
                             Compar => y8 ;
                             Superl => y9
							 }
							};
				Fem => table {
				        Dir => table {
						     Posit  => y10 ;
                             Compar => y11 ;
                             Superl => y12
							 };
						Obl => table {
						     Posit  => y13 ;
                             Compar => y14 ;
                             Superl => y15
							 };
						Voc => table {
						     Posit  => y16 ;
                             Compar => y17 ;
                             Superl => y18
							 }
							}
					};		
			Pl => table {
		        Masc => table {
				        Dir => table {
						     Posit  => y19 ;
                             Compar => y20 ;
                             Superl => y21
							 };
						Obl => table {
						     Posit  => y22 ;
                             Compar => y23 ;
                             Superl => y24
							 };
						Voc => table {
						     Posit  => y25 ;
                             Compar => y26 ;
                             Superl => y27
							 }
							}; 
				Fem => table {
				        Dir => table {
						     Posit  => y28 ;
                             Compar => y29 ;
                             Superl => y30
							 };
						Obl => table {
						     Posit  => y31 ;
                             Compar => y32 ;
                             Superl => y33
							 };
						Voc => table {
						     Posit  => y34 ;
                             Compar => y35 ;
                             Superl => y36
							 }
							}
                        }
                    }
            };					
							 
 
    regAdjective : Str -> Adjective; 
	regAdjective x =  case x of {
	      acch + ("a"|"aN") => mkAdjective x            ("bht" ++ x)          ("sab sE" ++ x)          (acch + "E") ("bht" ++ acch + "E") ("sab sE" ++ acch + "E") (acch + "E") ("bht" ++ acch + "E") ("sab sE" ++ acch + "E")
		                                   (acch + "y") ("bht" ++ acch + "y") ("sab sE" ++ acch + "y") (acch + "y") ("bht" ++ acch + "y") ("sab sE" ++ acch + "y") (acch + "y") ("bht" ++ acch + "y") ("sab sE" ++ acch + "y")
									       (acch +"E")  ("bht" ++ acch + "E") ("sab sE" ++ acch + "E") (acch + "E") ("bht" ++ acch + "E") ("sab sE" ++ acch + "E") (acch + "E") ("bht" ++ acch + "E") ("sab sE" ++ acch + "E")
		                                   (acch + "y") ("bht" ++ acch + "y") ("sab sE" ++ acch + "y") (acch + "y") ("bht" ++ acch + "y") ("sab sE" ++ acch + "y") (acch + "y") ("bht" ++ acch + "y") ("sab sE" ++ acch + "y");
									
          _                 => mkAdjective  x x x x x x x x x
                                            x x x x x x x x x
                                            x x x x x x x x x
                                            x x x x x x x x x									 
                            }; 
					 
		 

  ------------------------------------------------------
  -- Determiners Opers
  ------------------------------------------------------

  IDeterminer = {s:Gender => Str ; n : Number};
  Deter = {s:Determiner => Str ; n:Number};
  makeDet : Str -> Str -> Str -> Str -> Number -> Deter = \s1,s2,s3,s4,n -> {
   s = table {
        DT Sg Masc => s1;
		DT Sg Fem  => s2;
		DT Pl Masc => s3;
		DT Pl Fem  => s4
		};
	n = n	
	};	
	
  makeIDet : Str -> Str -> Number -> IDeterminer = \s1,s2,n -> {
   s = table {
        Masc => s1;
		Fem  => s2
	 };
	 n = n
    };		 
  
  ----------------------------------------------
  -- Proposition opers
  ---------------------------------------------
  Prepo = {s:Proposition => Str ; n:Number};
  makePrep : Str -> Str -> Str -> Str -> Number -> Prepo = \s1,s2,s3,s4,n -> {
   s = table {
        PP Sg Masc => s1;
		PP Sg Fem  => s2;
		PP Pl Masc => s3;
		PP Pl Fem  => s4
		};
	n = n	
	};	
  ----------------------------------------------------------
  -- Grammar part
  ----------------------------------------------------------
  
  param
    Agr = Ag Gender Number UPerson ;
--	Agr = {g : Gender; n : Number; p : UPerson}
-- in order to access individual elements of a type i.e Agr we can use case , write a function with typ from Agr -> Gender and use case as given below
--	case np.a of {
--	  Ag g _ _ => g
--	  }
    NPCase = NPC Case | NPObj | NPErg ;

  oper
      np2pronCase :  (PersPronForm => Str) -> NPCase -> Str = \ppf,npc -> case npc of {
       NPC c => ppf ! PPF Sg Pers1 c;
       NPObj => ppf ! PPF Sg Pers1 Dir ;
       NPErg => ppf ! PPF Sg Pers1 Dir ++ "ne"
      } ;

    
	toNP : ( Case => Str) -> NPCase -> Str = \pn, npc -> case npc of {
      NPC c => pn !  c ;
      NPObj => pn !  Dir ;
      NPErg => pn !  Obl ++ "ne"
      } ;
	detcn2NP : (Determiner => Str) -> Noun -> NPCase -> Number -> Str = \dt,cn,npc,nn -> case npc of {
       NPC c => dt ! DT Sg Masc ++ cn.s ! nn ! Dir ;
       NPObj => dt ! DT Sg Masc ++ cn.s ! nn ! Dir ;
       NPErg => dt ! DT Sg Masc ++ cn.s ! nn ! Obl ++ "ne"
      } ;  
	det2NP : (Determiner => Str) -> NPCase -> Str = \dt,npc -> case npc of {
       NPC c => dt ! DT Sg Masc ;
       NPObj => dt ! DT Sg Masc ;
       NPErg => dt ! DT Sg Masc ++ "ne"
      } ;    
	  
	detquant2det : (DemPronForm => Str) -> Str -> (Determiner) -> Str =\dt,n,dm -> case dm of {
       DT Sg Masc => dt ! DPF Sg Dir ++ n ;
       DT Sg Fem => dt ! DPF Sg Dir ++ n ;
       DT Pl Masc => dt ! DPF Pl Dir ++ n ;
	   DT Pl Fem => dt ! DPF Pl Dir ++ n 
        
      } ;    
------------------------------------------
-- Agreement transformations
-----------------------------------------
 oper
    toAgr : Number -> UPerson -> Gender -> Agr = \n,p,g -> 
      
	   Ag g n p;
      

    fromAgr : Agr -> {n : Number ; p : UPerson ; g : Gender} = \a -> case a of {
      Ag g n p => {n = n ; p = p ; g = g} 
	  } ;
	  
	conjAgr : Agr -> Agr -> Agr = \a0,b0 -> 
      let a = fromAgr a0 ; b = fromAgr b0 
      in
      toAgr
        (conjNumber a.n b.n)
--        (conjUPerson a.p b.p) a.g ;
        b.p a.g;

	  
	
	giveNumber : Agr -> Number =\a -> case a of {
	   Ag _ n _ => n
	};
	giveGender : Agr -> Gender =\a -> case a of {
	   Ag g _ _ => g
	};
--	giveCase : Agr -> UPerson =\a -> case a of {
--	   Ag _ _ c => c
--	};

    defaultAgr : Agr = agrP3 Masc Sg ;
    agrP3 : Gender -> Number -> Agr = \g,n -> Ag g n Pers3_Distant ;	
    personalAgr : Agr = agrP1 Masc Sg ;
    agrP1 : Gender -> Number -> Agr = \g,n -> Ag g n Pers1 ;
	
 param
      CPolarity = 
       CPos
       | CNeg Bool ;  -- contracted or not

 oper
    contrNeg : Bool -> Polarity -> CPolarity = \b,p -> case p of {
    Pos => CPos ;
    Neg => CNeg b
    } ;

       

   -- NP : Type = {s : PersPronForm => Str ; a : Agr} ;
	NP : Type = {s : NPCase => Str ; a : Agr} ;

   
 param
    CTense = CPresent | CPast | CFuture ;
  oper 
    copula : CTense -> Number -> UPerson -> Gender -> Str = \t,n,p,g -> 
      case <t,n,p,g> of {
        <CPresent,Sg,Pers1,_   > => "hwN" ;
        <CPresent,Sg,Pers2_Casual,_   > => "hE" ;
        <CPresent,Sg,Pers2_Familiar,_   > => "hw" ;
		<CPresent,Sg,Pers2_Respect,_   > => "hyN" ;
        <CPresent,Sg,Pers3_Near,_   > => "hE" ;
        <CPresent,Sg,Pers3_Distant,_   > => "hE" ;
		<CPresent,Pl,Pers1,_   > => "hyN" ;
        <CPresent,Pl,Pers2_Casual,_   > => "hw" ;
        <CPresent,Pl,Pers2_Familiar,_   > => "hw" ;
		<CPresent,Pl,Pers2_Respect,_   > => "hyN" ;
        <CPresent,Pl,Pers3_Near,_   > => "hyN" ;
        <CPresent,Pl,Pers3_Distant,_   > => "hyN" ;
		<CPast,Sg,Pers1,Masc   > => "th-a" ;
		<CPast,Sg,Pers1,Fem   > => "th-y" ;
        <CPast,Sg,Pers2_Casual,Masc   > => "th-a" ;
		<CPast,Sg,Pers2_Casual,Fem   > => "th-y" ;
        <CPast,Sg,Pers2_Familiar,Masc   > => "th-a" ;
		<CPast,Sg,Pers2_Familiar,Fem   > => "th-y" ;
		<CPast,Sg,Pers2_Respect,Masc   > => "th-E" ;
		<CPast,Sg,Pers2_Respect,Fem   > => "th-yN" ;
        <CPast,Sg,Pers3_Near,Masc   > => "th-a" ;
		<CPast,Sg,Pers3_Near,Fem   > => "th-y" ;
        <CPast,Sg,Pers3_Distant,Masc  > => "th-a" ;
		<CPast,Sg,Pers3_Distant,Fem  > => "th-y" ;
		<CPast,Pl,Pers1,Masc   > => "th-E" ;
		<CPast,Pl,Pers1,Fem   > => "th-yN" ;
        <CPast,Pl,Pers2_Casual,Masc   > => "th-E" ;
		<CPast,Pl,Pers2_Casual,Fem   > => "th-yN" ;
        <CPast,Pl,Pers2_Familiar,Masc   > => "th-E" ;
		<CPast,Pl,Pers2_Familiar,Fem   > => "th-yN" ;
		<CPast,Pl,Pers2_Respect,Masc   > => "th-E" ;
		<CPast,Pl,Pers2_Respect,Fem   > => "th-yN" ;
        <CPast,Pl,Pers3_Near,Masc   > => "th-E" ;
		<CPast,Pl,Pers3_Near,Fem   > => "th-yN" ;
		<CPast,Pl,Pers3_Distant,Masc   > => "th-E" ;
		<CPast,Pl,Pers3_Distant,Fem   > => "th-yN" ;
		<CFuture,Sg,Pers1,Masc   > => "ga" ;
		<CFuture,Sg,Pers1,Fem   > => "gy" ;
        <CFuture,Sg,Pers2_Casual,Masc   > => "ga" ;
		<CFuture,Sg,Pers2_Casual,Fem   > => "gi" ;
        <CFuture,Sg,Pers2_Familiar,Masc   > => "gE" ;
		<CFuture,Sg,Pers2_Familiar,Fem   > => "gy" ;
		<CFuture,Sg,Pers2_Respect,Masc   > => "gE" ;
		<CFuture,Sg,Pers2_Respect,Fem   > => "gy" ;
        <CFuture,Sg,Pers3_Near,Masc   > => "ga" ;
		<CFuture,Sg,Pers3_Near,Fem   > => "gy" ;
        <CFuture,Sg,Pers3_Distant,Masc  > => "ga" ;
		<CFuture,Sg,Pers3_Distant,Fem  > => "gy" ;
		<CFuture,Pl,Pers1,Masc   > => "gE" ;
		<CFuture,Pl,Pers1,Fem   > => "gy" ;
        <CFuture,Pl,Pers2_Casual,Masc   > => "gE" ;
		<CFuture,Pl,Pers2_Casual,Fem   > => "gy" ;
        <CFuture,Pl,Pers2_Familiar,Masc   > => "gE" ;
		<CFuture,Pl,Pers2_Familiar,Fem   > => "gy" ;
		<CFuture,Pl,Pers2_Respect,Masc   > => "gE" ;
		<CFuture,Pl,Pers2_Respect,Fem   > => "gy" ;
        <CFuture,Pl,Pers3_Near,Masc   > => "gE" ;
		<CFuture,Pl,Pers3_Near,Fem   > => "gE" ;
		<CFuture,Pl,Pers3_Distant,Masc  > => "gE" ;
		<CFuture,Pl,Pers3_Distant,Fem  > => "gy" 
        
        
        } ;

 param
    VPPTense = 
	  VPPres
	  |VPPast
	  |VPFutr
	  |VPGen;
    VPHTense = 
       VPGenPres  -- impf hum       nahim    "I go"
     | VPImpPast  -- impf Ta        nahim    "I went"
	 | VPFut      -- fut            na/nahim "I shall go"
     | VPContPres -- stem raha hum  nahim    "I am going"
     | VPContPast -- stem raha Ta   nahim    "I was going"
	 | VPContFut
     | VPPerfPres -- perf hum       na/nahim "I have gone"
     | VPPerfPast -- perf Ta        na/nahim "I had gone"          
	 | VPPerfFut
	 | VPPerfPresCont
	 | VPPerfPastCont
	 | VPPerfFutCont
     | VPSubj     -- subj           na       "I may go"
--	 | VPImp
     ;

    VPHForm = 
       VPTense VPPTense Agr -- 9 * 12
     | VPReq
     | VPImp
     | VPReqFut
     | VPInf
     | VPStem
     ;

    VType = VIntrans | VTrans | VTransPost ;

  oper
    
	objVType : VType -> NPCase = \vt -> case vt of {
      VTrans => NPObj ;
      _ => NPC Obl
      } ;

    VPH : Type = {
--	  s    : Polarity => VPHForm => Order => {fin, inf,inf2, neg,quest : Str} ;
      s    : VPHForm => {fin, inf,inf2 : Str} ;
--      s : Verb;
      obj  : {s : Str ; a : Agr} ; 
      subj : VType ;
      comp : Agr => Str;
	  inf : Str;
	  ad  : Str
      } ;
	
	VPHSlash = VPH ** {c2 : Compl} ;

    Compl : Type = {s : Str ; c : VType} ;
	  
	  
   

   predV : Verb -> VPH = \verb -> {
      s = \\vh => 
	   case vh of {
	     VPTense VPPres (Ag g n p) => {fin = copula CPresent n p g ; inf2 = verb.s ! VF Imperf p n g; inf = [] } ;
		 VPTense VPPast (Ag g n p) => {fin = [] ; inf2 =verb.s ! VF Perf p n g ; inf = []} ;
		 VPTense VPFutr (Ag g n p) =>  {fin = copula CFuture n p g ; inf2 =  verb.s ! VF Subj p n g ; inf = [] } ;
		 VPTense VPGen (Ag g n p) => {fin = []; inf2 = verb.s ! Root ; inf = [] } ;
		 VPImp => {fin = verb.s ! Root ; inf = [] ; inf2 = verb.s ! Inf_Obl};
		 _ => {fin = [] ; inf2 = verb.s ! Root ; inf = [] } 
		 };
		 
 {-      
       case vh of {
         VPTense VPGenPres (Ag g n p) => {fin = copula CPresent n p g ; inf2 = verb.s ! VF Imperf p n g; inf = [] } ;
         VPTense VPImpPast (Ag g n p) => {fin = [] ; inf2 =verb.s ! VF Perf p n g ; inf = []} ;
         VPTense VPFut (Ag g n p) =>  {fin = copula CFuture n p g ; inf2 =  verb.s ! VF Subj p n g ; inf = [] } ;
         VPTense VPContPres (Ag g n p) => {fin = copula CPresent n p g ; inf2 = verb.s ! Root ++ raha g n ; inf = [] } ;
         VPTense VPContPast (Ag g n p) => {fin = copula CPast n p g ; inf2 = verb.s ! Root ++ raha g n ; inf = [] } ;
--		 VPTense VPContFut (Ag g n p) => {fin = copula CFuture n p g  ; inf2 = verb.s ! Root ++ raha g n ++ hw p n ; inf = [] } ;
         VPTense VPPerfPres (Ag g n p) => {fin = copula CPresent n p g ; inf2 = verb.s ! Root ++ cka g n ; inf = [] } ;
         VPTense VPPerfPast (Ag g n p) => {fin = copula CPast n p g ; inf2 = verb.s !Root ++ cka g n ; inf = [] } ;
		 VPTense VPPerfFut (Ag g n p) =>  {fin = copula CFuture n p g ; inf2 = verb.s ! Root ++ cka g n ++ hw p n  ; inf = [] } ;
--		 VPTense VPPerfPresCont (Ag g n p) => {fin = copula CPresent n p g ; inf2 = verb.s ! VF Imperf p n g ++ raha g n ; inf = [] } ; 
--		 VPTense VPPerfPastCont (Ag g n p) => {fin = copula CPast n p g ; inf2 = verb.s ! VF Imperf p n g ++ raha g n ; inf = [] } ;  
--		 VPTense VPPerfFutCont (Ag g n p) =>  {fin = copula CFuture n p g ; inf2 = verb.s ! VF Imperf p n g ++ raha g n ++ hw p n ; inf = []  } ;
--       VPTense VPSubj (Ag g n p) => {fin = [] ++ verb.s ! VF Subj p n g ; inf2 = [] ; inf = "Xayd" } ;
         
		 VPImp => {fin = verb.s ! Root ; inf = [] ; inf2 = verb.s ! Inf_Obl};
         _ => {fin = [] ; inf2 = verb.s ! Root ; inf = []}  ----
         } ; 
		 
  -}		 
--        s = verb;
	    obj = {s = [] ; a = defaultAgr} ;
		subj = VTrans ;
		inf = verb.s ! Inf;
		ad = [];
      comp = \\_ => []
      } ;

    predVc : (Verb ** {c2,c1 : Str}) -> VPHSlash = \verb -> 
    predV verb ** {c2 = {s = verb.c1 ; c = VTrans} } ;

	 
    raha : Gender -> Number -> Str = \g,n -> 
	   (regAdjective "rha").s ! n ! g ! Dir ! Posit ;
--      (regAdjective "rha").s !Adj1 (AdjF1 g  n  Dir) ;
	cka : Gender -> Number -> Str = \g,n -> 
	  (regAdjective "cka").s ! n ! g ! Dir ! Posit ;
--      (regAdjective "cka").s !Adj1 (AdjF1 g  n  Dir) ;  
	  
	hw : UPerson -> Number -> Str = \pp,n ->    
	 case <pp,n> of {
	 <Pers1,_> => "hwN";
	 <_,Pl>    => "hwN";
	 <_,_>		=> "hw"
	 };
	 
	predAux : Aux -> VPH = \verb -> {
     s = \\vh => 
       let  

		 inf  = verb.inf ;
         --fin  = verb.pres ! b ! agr ;
         --finp = verb.pres ! Pos ! agr ;
          part = verb.ppart ;

       in
       case vh of {
	     VPTense VPPres (Ag g n p) => {fin = copula CPresent n p g ; inf2 = part; inf = [] } ;
         VPTense VPPast (Ag g n p) => {fin = copula CPast n p g ; inf2 = part ; inf = []} ;
         VPTense VPFutr (Ag g n p) => {fin = copula CFuture n p g ; inf2 = part ++ hw p n ; inf = [] } ;
		 VPTense VPGen  (Ag g n p) => {fin = [] ; inf = "rh" ; inf2 = part};
		 _ => {fin = part ; inf = [] ; inf2 = []}
		 };
	   
{-	   
         VPTense VPGenPres (Ag g n p) => {fin = copula CPresent n p g ; inf2 = part; inf = [] } ;
         VPTense VPImpPast (Ag g n p) => {fin = copula CPast n p g ; inf2 = part ; inf = []} ;
         VPTense VPFut (Ag g n p) => {fin = copula CFuture n p g ; inf2 = part ++ hw p n ; inf = [] } ;
         VPTense VPContPres (Ag g n p) => {fin = copula CPresent n p g ; inf2 = part ++ raha g n ; inf = [] } ;
         VPTense VPContPast (Ag g n p) => {fin = copula CPast n p g ; inf2 = part ++ raha g n ; inf = []} ;
		 VPTense VPContFut (Ag g n p) => {fin = copula CFuture n p g  ; inf2 = part ++ raha g n ++ hw p n ; inf = [] } ;
         VPTense VPPerfPres (Ag g n p) => {fin = copula CPresent n p g ; inf2 = part ++ "rh" ++ cka g n ; inf = [] } ;
         VPTense VPPerfPast (Ag g n p) => {fin = copula CPast n p g ; inf2 = part ++ "rh" ++ cka g n ; inf = []} ;
--		 VPTense VPPerfFut (Ag g n p) =>  {fin = copula CFuture n p g ; inf2 = part ++ "rh" ++ cka g n ++ hw p n  ; inf = [] } ;
--		 VPTense VPPerfPresCont (Ag g n p) => {fin = copula CPresent n p g ; inf2 = part ++ raha g n ; inf = []} ; 
--		 VPTense VPPerfPastCont (Ag g n p) => {fin = copula CPast n p g ; inf2 = part ++ raha g n ; inf = []} ;  
--		 VPTense VPPerfFutCont (Ag g n p) =>  {fin = copula CFuture n p g ; inf2 = part ++ raha g n ++ hw p n ; inf = [] } ;
--         VPTense VPSubj (Ag g n p) => {fin = copula CPresent n p g ++ part ; inf2 = [] ; inf = "Xayd" } ;
         
         _ => {fin = part ; inf = [] ; inf2 = []} ----
         } ;
		 
-}		 
--      s = {s = \\_ => " "};
	  obj = {s = [] ; a = defaultAgr} ;
      subj = VIntrans ;
      inf = verb.inf;
	  ad = [];
      comp = \\_ => []
      } ;
	
	

    Aux = {
    --pres : Polarity => Agr => Str ; 
    --past : Polarity => Agr => Str ;  --# notpresent
	inf,ppart,prpart : Str
    } ;

    auxBe : Aux = {
    inf  = "" ;
    ppart = "" ;
    prpart = ""
    } ;

   	
	Clause : Type = {s : VPHTense => Polarity => Order => Str} ;
	mkClause : NP -> VPH -> Clause = \np,vp -> {
      s = \\vt,b,ord => 
        let 
          subjagr : NPCase * Agr = case vt of {
            VPImpPast => case vp.subj of {
              VTrans     => <NPErg, vp.obj.a> ;
              VTransPost => <NPErg, defaultAgr> ;
              _          => <NPC Dir, np.a>
              } ;
            _ => <NPC Dir, np.a>
            } ;
          subj = subjagr.p1 ;
          agr  = subjagr.p2 ;
		  n    = (fromAgr agr).n;
		  p    = (fromAgr agr).p;
		  g    = (fromAgr agr).g;
          vps  = case vt of {
{-			            VPGenPres  => {fin = copula CPresent n p g ; inf2 = vp.s.s ! VF Imperf p n g; inf = [] } ;
					VPImpPast  => {fin = [] ; inf2 = vp.s.s ! VF Perf p n g ; inf = []} ;
					VPFut      => {fin = copula CFuture n p g ; inf2 =  vp.s.s ! VF Subj p n g ; inf = [] } ;
					VPContPres => {fin = copula CPresent n p g ; inf2 = vp.s.s ! Root ++ raha g n ; inf = [] } ;
					VPContPast => {fin = copula CPast n p g ; inf2 = vp.s.s ! Root ++ raha g n ; inf = [] } ;
					VPContFut  => {fin = copula CFuture n p g  ; inf2 = vp.s.s ! Root ++ raha g n ++ hw p n ; inf = [] } ;
					VPPerfPres => {fin = copula CPresent n p g ; inf2 = vp.s.s ! Root ++ cka g n ; inf = [] } ;
					VPPerfPast => {fin = copula CPast n p g ; inf2 = vp.s.s !Root ++ cka g n ; inf = [] } ;				
					VPPerfFut  => {fin = copula CFuture n p g ; inf2 = vp.s.s ! Root ++ cka g n ++ hw p n  ; inf = [] } ;
					VPPerfPresCont => {fin = copula CPresent n p g ; inf2 = vp.s.s ! VF Imperf p n g ++ raha g n ; inf = [] } ;					
					VPPerfPastCont => {fin = copula CPast n p g ; inf2 = vp.s.s ! VF Imperf p n g ++ raha g n ; inf = [] } ;  					
					VPPerfFutCont => {fin = copula CFuture n p g ; inf2 = vp.s.s ! VF Imperf p n g ++ raha g n ++ hw p n ; inf = []  } ;					
					VPSubj   => {fin = [] ++ vp.s.s ! VF Subj p n g ; inf2 = [] ; inf = "Xayd" } ; 
					VPImp => {fin = vp.s.s ! Root ; inf = [] ; inf2 = vp.s.s ! Inf_Obl}
					};
-}		  
				    VPGenPres  => vp.s !  VPTense VPPres agr ;
					VPImpPast  => vp.s !  VPTense VPPast agr ;
					VPFut      => vp.s !  VPTense VPFutr agr ;
					VPContPres => 
					  {fin = copula CPresent n p g ; inf2 = (vp.s ! VPTense VPGen agr).inf2 ++ raha g n ; inf = [] } ;
					VPContPast => 
					  {fin = copula CPast n p g ; inf2 = (vp.s ! VPTense VPGen agr).inf2 ++ raha g n ; inf = [] } ;
					VPContFut  => 
					  {fin = copula CFuture n p g ; inf2 = (vp.s ! VPTense VPGen agr).inf2 ++ raha g n ++ hw p n   ; inf = [] } ;
					VPPerfPres => 
					  {fin = copula CPresent n p g ; inf2 = (vp.s ! VPTense VPGen agr).inf2 ++ cka g n ; inf = [] } ;
					VPPerfPast => 
                      {fin = copula CPast n p g ; inf2 = (vp.s ! VPTense VPGen agr).inf2 ++ cka g n ; inf = [] } ;					
					VPPerfFut  => 
					  {fin = copula CFuture n p g ; inf2 = (vp.s ! VPTense VPGen agr).inf2 ++ cka g n  ++ hw p n ; inf = [] } ;
					VPPerfPresCont => 
					  {fin = copula CPresent n p g ; inf2 = (vp.s ! VPTense VPPres agr).inf2 ++ raha g n ; inf = [] } ;					
					VPPerfPastCont => 
					  {fin = copula CPast n p g ; inf2 = (vp.s ! VPTense VPPres agr).inf2 ++ raha g n ; inf = [] } ;					
					VPPerfFutCont => 
					  {fin = copula CFuture n p g ; inf2 = (vp.s ! VPTense VPPres agr).inf2 ++ raha g n  ++ hw p n ; inf = [] } ;					
					VPSubj   => vp.s !  VPTense VPGen agr 
					};
					
		    
          quest =
            case ord of
              { ODir => [];
                OQuest => "kya" }; 
		  na =
            case b of
              { Pos => [];
                Neg => "na" };
           nahim =
            case b of 
              { Pos => [];
                Neg => "nhyN" };
        in
		case vt of {
		VPSubj => quest ++ np.s ! subj ++ vp.obj.s ++ vp.ad ++ vp.comp ! np.a  ++ vps.inf ++ na ++  vps.inf2 ++ vps.fin;
		_      => quest ++ np.s ! subj ++ vp.obj.s ++ vp.ad ++ vp.comp ! np.a  ++ vps.inf ++ nahim ++  vps.inf2 ++ vps.fin};

  } ;

  mkSClause : Str -> Agr -> VPH -> Clause =
    \subj,agr,vp -> {
      s = \\t,b,ord => 
        let 
		  n    = (fromAgr agr).n;
		  p    = (fromAgr agr).p;
		  g    = (fromAgr agr).g;
          vps  = case t of {
{-		            VPGenPres  => {fin = copula CPresent n p g ; inf2 = vp.s.s ! VF Imperf p n g; inf = [] } ;
					VPImpPast  => {fin = [] ; inf2 = vp.s.s ! VF Perf p n g ; inf = []} ;
					VPFut      => {fin = copula CFuture n p g ; inf2 =  vp.s.s ! VF Subj p n g ; inf = [] } ;
					VPContPres => {fin = copula CPresent n p g ; inf2 = vp.s.s ! Root ++ raha g n ; inf = [] } ;
					VPContPast => {fin = copula CPast n p g ; inf2 = vp.s.s ! Root ++ raha g n ; inf = [] } ;
					VPContFut  => {fin = copula CFuture n p g  ; inf2 = vp.s.s ! Root ++ raha g n ++ hw p n ; inf = [] } ;
					VPPerfPres => {fin = copula CPresent n p g ; inf2 = vp.s.s ! Root ++ cka g n ; inf = [] } ;
					VPPerfPast => {fin = copula CPast n p g ; inf2 = vp.s.s !Root ++ cka g n ; inf = [] } ;				
					VPPerfFut  => {fin = copula CFuture n p g ; inf2 = vp.s.s ! Root ++ cka g n ++ hw p n  ; inf = [] } ;
					VPPerfPresCont => {fin = copula CPresent n p g ; inf2 = vp.s.s ! VF Imperf p n g ++ raha g n ; inf = [] } ;					
					VPPerfPastCont => {fin = copula CPast n p g ; inf2 = vp.s.s ! VF Imperf p n g ++ raha g n ; inf = [] } ;  					
					VPPerfFutCont => {fin = copula CFuture n p g ; inf2 = vp.s.s ! VF Imperf p n g ++ raha g n ++ hw p n ; inf = []  } ;					
					VPSubj   => {fin = [] ++ vp.s.s ! VF Subj p n g ; inf2 = [] ; inf = "Xayd" } ; 
					VPImp => {fin = vp.s.s ! Root ; inf = [] ; inf2 = vp.s.s ! Inf_Obl}
					};
-}		  
		  
					VPGenPres  => vp.s !  VPTense VPPres agr ;
					VPImpPast  => vp.s !  VPTense VPPast agr ;
					VPFut      => vp.s !  VPTense VPFutr agr ;
					VPContPres => 
					  {fin = copula CPresent n p g ; inf2 = (vp.s ! VPTense VPGen agr).inf2 ++ raha g n ; inf = [] } ;
					VPContPast => 
					  {fin = copula CPast n p g ; inf2 = (vp.s ! VPTense VPGen agr).inf2 ++ raha g n ; inf = []} ;
					VPContFut  => 
					  {fin = copula CFuture n p g  ; inf2 = (vp.s ! VPTense VPGen agr).inf2 ++ raha g n ++ hw p n ; inf = [] } ;
					VPPerfPres => 
					  {fin = copula CPresent n p g ; inf2 = (vp.s ! VPTense VPGen agr).inf2 ++ cka g n ; inf = [] } ;
					VPPerfPast => 
                      {fin = copula CPast n p g ; inf2 = (vp.s ! VPTense VPGen agr).inf2 ++ cka g n ; inf = []} ;
					VPPerfFut  => 
					  {fin = copula CFuture n p g ; inf2 = (vp.s ! VPTense VPGen agr).inf2 ++ cka g n ++ hw p n  ; inf = [] } ;
					VPPerfPresCont => 
					 {fin = copula CPresent n p g ; inf2 = (vp.s ! VPTense VPGen agr).inf2 ++ raha g n ; inf = []} ; 
					VPPerfPastCont => 
					  {fin = copula CPast n p g ; inf2 = (vp.s ! VPTense VPGen agr).inf2 ++ raha g n ; inf = []} ; 
					VPPerfFutCont => 
					  {fin = copula CFuture n p g ; inf2 = (vp.s ! VPTense VPGen agr).inf2 ++ raha g n ++ hw p n ; inf = [] } ;
					VPSubj   => vp.s !  VPTense VPGen agr 
					};

		  quest =
            case ord of
              { ODir => [];
                OQuest => "kya" }; 
		  na =
            case b of
              { Pos => [];
                Neg => "na" };
          nahim =
            case b of 
              { Pos => [];
                Neg => "nhyN" };		
        in
		case t of {
		VPSubj => quest ++ subj ++ vp.obj.s ++ vp.ad ++ vp.comp ! agr  ++ vps.inf ++ na ++  vps.inf2 ++ vps.fin;
		_      => quest ++ subj ++ vp.obj.s ++ vp.ad ++ vp.comp ! agr  ++ vps.inf ++ nahim ++  vps.inf2 ++ vps.fin};
    } ;
	
  

  

    insertObj : (Agr => Str) -> VPH -> VPH = \obj1,vp -> {
     s = vp.s ;
     obj = vp.obj ;
     subj = vp.subj ;
	 inf = vp.inf;
	 ad = vp.ad;
     comp = \\a =>    vp.comp ! a  ++ obj1 ! a 
     --     s2 = \\a => vp.s2 ! a ++ obj ! a
     } ;
	 
	insertObjc : (Agr => Str) -> VPHSlash -> VPHSlash = \obj,vp -> 
    insertObj obj vp ** {c2 = vp.c2} ;

	infVP : Bool -> VPH -> Agr -> Str = \isAux,vp,a ->
     vp.obj.s ++ vp.inf ++
     case isAux of {True => [] ; False => ""}    ++ vp.comp ! a ;

    insertObject : NP -> VPHSlash -> VPH = \np,vps -> {
      s = vps.s ;
      obj = {s =  vps.obj.s  ++ np.s ! objVType vps.c2.c ++ vps.c2.s ; a = np.a} ;
--      obj = {s =  vps.obj.s ++ vps.c2.s ++ np.s ! objVType vps.c2.c  ; a = np.a} ;
      subj = vps.c2.c ;
	  inf = vps.inf;
	  ad = vps.ad;
      comp = vps.comp
      } ;
	  
	insertObjPre : (Agr => Str) -> VPHSlash -> VPH = \obj,vp -> {
     s = vp.s ;
     obj = vp.obj ;
     inf = vp.inf ;
     subj = vp.subj ;
	 ad = vp.ad ;
     comp = \\a =>   obj ! a  ++ vp.c2.s ++ vp.comp ! a 
    } ;

    insertAdV : Str -> VPH -> VPH = \ad,vp -> {
     s = vp.s ;
     obj = vp.obj ;
     inf = vp.inf ;
	 subj = vp.subj;
     ad  = vp.ad ++ ad ;
     comp = \\a => vp.comp ! a
    } ;
	conjThat : Str = "kh" ;

}

