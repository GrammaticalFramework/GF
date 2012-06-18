--# -path=.:../abstract:../common:../../prelude
--
--1 Hindustaniu auxiliary operations.
--
-- This module contains operations that are needed to make the
-- resource syntax work. 
resource CommonHindustani = ParamX ** open Prelude, Predef in {
--interface CommonHindustani = ParamX  ** open Prelude,Predef,StringsHindustani1  in {
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
      cvp : Str ;
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
	    
   Adjective = { s: Number => Gender => Case => Degree => Str };
   
	
   Verb : Type = {s : VerbForm => Str ; cvp : Str} ;
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
	
--  insertSubj : UPerson -> Str -> Str = \p,s -> 
--      case p of { Pers1 => s ++ "wN" ; _ => s ++ "E"};
      
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

