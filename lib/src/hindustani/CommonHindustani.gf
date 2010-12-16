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
		<CFuture,Sg,Pers2_Casual,Fem   > => "gy" ;
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
   raha : Gender -> Number -> Str = \g,n -> 
	   (regAdjective "rha").s ! n ! g ! Dir ! Posit ;

  cka : Gender -> Number -> Str = \g,n -> 
	  (regAdjective "cka").s ! n ! g ! Dir ! Posit ;
	  
  hw : UPerson -> Number -> Str = \pp,n ->    
	 case <pp,n> of {
	 <Pers1,_> => "hwN";
	 <_,Pl>    => "hwN";
	 <_,_>		=> "hw"
	 };
	 
   -----------------------------------------------
   -- Hindustani Adjectives
   -----------------------------------------------
   	 
  Adjective = { s: Number => Gender => Case => Degree => Str };
  regAdjective : Str -> Adjective; 
  regAdjective x =  case x of {
	              acch + ("a"|"aN") => mkAdjective x  ("bht" ++ x)          ("sb sE" ++ x)          (acch + "E") ("bht" ++ acch + "E") ("sb sE" ++ acch + "E") (acch + "E") ("bht" ++ acch + "E") ("sb sE" ++ acch + "E")
		                                      (acch + "y") ("bht" ++ acch + "y") ("sb sE" ++ acch + "y") (acch + "y") ("bht" ++ acch + "y") ("sb sE" ++ acch + "y") (acch + "y") ("bht" ++ acch + "y") ("sb sE" ++ acch + "y")
						      (acch +"E")  ("bht" ++ acch + "E") ("sb sE" ++ acch + "E") (acch + "E") ("bht" ++ acch + "E") ("sb sE" ++ acch + "E") (acch + "E") ("bht" ++ acch + "E") ("sb sE" ++ acch + "E")
		                                      (acch + "y") ("bht" ++ acch + "y") ("sb sE" ++ acch + "y") (acch + "y") ("bht" ++ acch + "y") ("sb sE" ++ acch + "y") (acch + "y") ("bht" ++ acch + "y") ("sb sE" ++ acch + "y");
									
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
      case p of { Pers1 => s ++ "wN" ; _ => s ++ "E"};
      
 mkOrd : Str -> Str =
 \s -> case s of {
                    "ayk"                  => "phla";
                    "dw"                  => "dwsra";
                    "tyN"                => "tesra";
                    "car"                => "cwth'a";
                    "ch'" 		 => "ch'Ta";
                     _                   =>  s ++ "waN"
                  };     
}

