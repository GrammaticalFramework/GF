--# -path=.:../abstract:../common:../../prelude
--
--1 Hindustaniu auxiliary operations.
--
-- This module contains operations that are needed to make the
-- resource syntax work. 
resource CommonHindustani = ParamX  ** open Prelude,Predef in {

  flags coding = utf8 ;

 oper
  
  VPH = {
      s    : VPHForm => {fin, inf : Str} ;
      obj  : {s : Str ; a : Agr} ; 
      subj : VType ;
      comp : Agr => Str;
      inf : Str;
      ad  : Str;
      embComp : Str ;
      prog : Bool ;
      } ;
  NP : Type = {s : NPCase => Str ; a : Agr} ;    
 param      
  VPHForm = 
       VPTense VPPTense Agr -- 9 * 12
     | VPReq
     | VPImp
     | VPReqFut
     | VPInf
     | VPStem
     ;
  VPPTense = 
	  VPPres
	  |VPPast
	  |VPFutr
	  |VPPerf;
      
  VPHTense = 
       VPGenPres  -- impf hum       nahim    "I گo"
     | VPImpPast  -- impf Ta        nahim    "I وعنت"
	 | VPFut      -- fut            na/nahim "I سہالل گo"
     | VPContPres -- stem raha hum  nahim    "I ام گoiنگ"
     | VPContPast -- stem raha Ta   nahim    "I واس گoiنگ"
	 | VPContFut
     | VPPerfPres -- perf hum       na/nahim "I ہاvع گoنع"
     | VPPerfPast -- perf Ta        na/nahim "I ہاد گoنع"          
	 | VPPerfFut
	 | VPPerfPresCont
	 | VPPerfPastCont
	 | VPPerfFutCont
     | VPSubj     -- subj           na       "I مای گo"
     ;   
  Agr = Ag Gender Number UPerson ;
  Gender = Masc | Fem ;
  Case = Dir | Obl | Voc ;
  UPerson = Pers1
	    | Pers2_Casual
	    | Pers2_Familiar 
	    | Pers2_Respect
	    | Pers3_Near
	    | Pers3_Distant;
  VType = VIntrans | VTrans | VTransPost ;
  VerbForm = VF VTense UPerson Number Gender
                | Inf
                | Root
                | Inf_Obl
                | Inf_Fem;
  VTense = Subj | Perf | Imperf;
  CTense = CPresent | CPast | CFuture ;
  NPCase = NPC Case | NPObj | NPErg ;
  Order = ODir | OQuest ;
  
  
  oper 
    copula : CTense -> Number -> UPerson -> Gender -> Str = \t,n,p,g -> 
      case <t,n,p,g> of {
        <CPresent,Sg,Pers1,_   > => "ہوں" ;
        <CPresent,Sg,Pers2_Casual,_   > => "ہے" ;
        <CPresent,Sg,Pers2_Familiar,_   > => "ہو" ;
		<CPresent,Sg,Pers2_Respect,_   > => "ہیں" ;
        <CPresent,Sg,Pers3_Near,_   > => "ہے" ;
        <CPresent,Sg,Pers3_Distant,_   > => "ہے" ;
		<CPresent,Pl,Pers1,_   > => "ہیں" ;
        <CPresent,Pl,Pers2_Casual,_   > => "ہو" ;
        <CPresent,Pl,Pers2_Familiar,_   > => "ہو" ;
		<CPresent,Pl,Pers2_Respect,_   > => "ہیں" ;
        <CPresent,Pl,Pers3_Near,_   > => "ہیں" ;
        <CPresent,Pl,Pers3_Distant,_   > => "ہیں" ;
		<CPast,Sg,Pers1,Masc   > => "تh-ا" ;
		<CPast,Sg,Pers1,Fem   > => "تh-ی" ;
        <CPast,Sg,Pers2_Casual,Masc   > => "تh-ا" ;
		<CPast,Sg,Pers2_Casual,Fem   > => "تh-ی" ;
        <CPast,Sg,Pers2_Familiar,Masc   > => "تh-ا" ;
		<CPast,Sg,Pers2_Familiar,Fem   > => "تh-ی" ;
		<CPast,Sg,Pers2_Respect,Masc   > => "تh-ے" ;
		<CPast,Sg,Pers2_Respect,Fem   > => "تh-یں" ;
        <CPast,Sg,Pers3_Near,Masc   > => "تh-ا" ;
		<CPast,Sg,Pers3_Near,Fem   > => "تh-ی" ;
        <CPast,Sg,Pers3_Distant,Masc  > => "تh-ا" ;
		<CPast,Sg,Pers3_Distant,Fem  > => "تh-ی" ;
		<CPast,Pl,Pers1,Masc   > => "تh-ے" ;
		<CPast,Pl,Pers1,Fem   > => "تh-یں" ;
        <CPast,Pl,Pers2_Casual,Masc   > => "تh-ے" ;
		<CPast,Pl,Pers2_Casual,Fem   > => "تh-یں" ;
        <CPast,Pl,Pers2_Familiar,Masc   > => "تh-ے" ;
		<CPast,Pl,Pers2_Familiar,Fem   > => "تh-یں" ;
		<CPast,Pl,Pers2_Respect,Masc   > => "تh-ے" ;
		<CPast,Pl,Pers2_Respect,Fem   > => "تh-یں" ;
        <CPast,Pl,Pers3_Near,Masc   > => "تh-ے" ;
		<CPast,Pl,Pers3_Near,Fem   > => "تh-یں" ;
		<CPast,Pl,Pers3_Distant,Masc   > => "تh-ے" ;
		<CPast,Pl,Pers3_Distant,Fem   > => "تh-یں" ;
		<CFuture,Sg,Pers1,Masc   > => "گا" ;
		<CFuture,Sg,Pers1,Fem   > => "گی" ;
        <CFuture,Sg,Pers2_Casual,Masc   > => "گا" ;
		<CFuture,Sg,Pers2_Casual,Fem   > => "گی" ;
        <CFuture,Sg,Pers2_Familiar,Masc   > => "گے" ;
		<CFuture,Sg,Pers2_Familiar,Fem   > => "گی" ;
		<CFuture,Sg,Pers2_Respect,Masc   > => "گے" ;
		<CFuture,Sg,Pers2_Respect,Fem   > => "گی" ;
        <CFuture,Sg,Pers3_Near,Masc   > => "گا" ;
		<CFuture,Sg,Pers3_Near,Fem   > => "گی" ;
        <CFuture,Sg,Pers3_Distant,Masc  > => "گا" ;
		<CFuture,Sg,Pers3_Distant,Fem  > => "گی" ;
		<CFuture,Pl,Pers1,Masc   > => "گے" ;
		<CFuture,Pl,Pers1,Fem   > => "گی" ;
        <CFuture,Pl,Pers2_Casual,Masc   > => "گے" ;
		<CFuture,Pl,Pers2_Casual,Fem   > => "گی" ;
        <CFuture,Pl,Pers2_Familiar,Masc   > => "گے" ;
		<CFuture,Pl,Pers2_Familiar,Fem   > => "گی" ;
		<CFuture,Pl,Pers2_Respect,Masc   > => "گے" ;
		<CFuture,Pl,Pers2_Respect,Fem   > => "گی" ;
        <CFuture,Pl,Pers3_Near,Masc   > => "گے" ;
		<CFuture,Pl,Pers3_Near,Fem   > => "گے" ;
		<CFuture,Pl,Pers3_Distant,Masc  > => "گے" ;
		<CFuture,Pl,Pers3_Distant,Fem  > => "گی" 
        
        
        } ;
   raha : Gender -> Number -> Str = \g,n -> 
	   (regAdjective "رہا").s ! n ! g ! Dir ! Posit ;

  cka : Gender -> Number -> Str = \g,n -> 
	  (regAdjective "چكا").s ! n ! g ! Dir ! Posit ;
	  
  hw : UPerson -> Number -> Str = \pp,n ->    
	 case <pp,n> of {
	 <Pers1,_> => "ہوں";
	 <_,Pl>    => "ہوں";
	 <_,_>		=> "ہو"
	 };
	 
   -----------------------------------------------
   -- Hindustani Adjectives
   -----------------------------------------------
   	 
  Adjective = { s: Number => Gender => Case => Degree => Str };
  regAdjective : Str -> Adjective; 
  regAdjective x =  case x of {
	              acch + ("ا"|"اں") => mkAdjective x  ("بہت" ++ x)          ("سب سے" ++ x)          (acch + "ے") ("بہت" ++ acch + "ے") ("سب سے" ++ acch + "ے") (acch + "ے") ("بہت" ++ acch + "ے") ("سب سے" ++ acch + "ے")
		                                      (acch + "ی") ("بہت" ++ acch + "ی") ("سب سے" ++ acch + "ی") (acch + "ی") ("بہت" ++ acch + "ی") ("سب سے" ++ acch + "ی") (acch + "ی") ("بہت" ++ acch + "ی") ("سب سے" ++ acch + "ی")
						      (acch +"ے")  ("بہت" ++ acch + "ے") ("سب سے" ++ acch + "ے") (acch + "ے") ("بہت" ++ acch + "ے") ("سب سے" ++ acch + "ے") (acch + "ے") ("بہت" ++ acch + "ے") ("سب سے" ++ acch + "ے")
		                                      (acch + "ی") ("بہت" ++ acch + "ی") ("سب سے" ++ acch + "ی") (acch + "ی") ("بہت" ++ acch + "ی") ("سب سے" ++ acch + "ی") (acch + "ی") ("بہت" ++ acch + "ی") ("سب سے" ++ acch + "ی");
									
                        _                 => mkAdjective  x x x x x x x x x
                                                        x x x x x x x x x
                                                        x x x x x x x x x
                                                        x x x x x x x x x									 
                            }; 
					 

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
	
   Verb : Type = {s : VerbForm => Str} ;

 predV : Verb -> VPH ;
  predV v = {
         s = \\vh => 
	   case vh of {
	         VPTense VPPres (Ag g n p) => {fin = copula CPresent n p g ; inf = v.s ! VF Imperf p n g } ;
		 VPTense VPPast (Ag g n p) => {fin = [] ; inf =v.s ! VF Perf p n g} ;
		 VPTense VPFutr (Ag g n p) =>  {fin = copula CFuture n p g ; inf =  v.s ! VF Subj p n g } ;
		 VPTense VPPerf (Ag g n p) => { fin = [] ; inf = v.s ! Root ++ cka g n } ; 
		 VPStem => {fin = []  ; inf =  v.s ! Root};
		 VPInf => {fin = v.s ! Inf_Obl  ; inf =  v.s ! Root}; -- for V2V like sonE ky altja krna , check if it is being used anywhere else
		 VPImp => {fin = v.s ! VF Subj Pers3_Near Pl Masc  ; inf =  v.s ! Root};
		 _ => {fin = [] ; inf = v.s ! Root} 
		 };
	    obj = {s = [] ; a = defaultAgr} ;
		subj = VIntrans ;
		inf = v.s ! Inf;
		ad = [];
        embComp = [];
	prog = False ;
        comp = \\_ => []
      } ;	    
							 
   defaultAgr : Agr = agrP3 Masc Sg ;
   agrP3 : Gender -> Number -> Agr = \g,n -> Ag g n Pers3_Distant ;
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
        b.p a.g;	  
	
	giveNumber : Agr -> Number =\a -> case a of {
	   Ag _ n _ => n
	};
	giveGender : Agr -> Gender =\a -> case a of {
	   Ag g _ _ => g
	};
  insertSubj : UPerson -> Str -> Str = \p,s -> 
      case p of { Pers1 => s ++ "وں" ; _ => s ++ "ے"};
      
 mkOrd : Str -> Str =
 \s -> case s of {
                    "ایك"                  => "پہلا";
                    "دو"                  => "دوسرا";
                    "تیں"                => "تعسرا";
                    "چار"                => "چوتھا";
                    "چھ" 		 => "چھٹا";
                     _                   =>  s ++ "واں"
                  };     
}

