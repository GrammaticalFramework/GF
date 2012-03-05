--# -path=.:../abstract:../common:../../prelude
--
--1 Pnbu auxiliary operations.
--
-- This module contains operations that are needed to make the
-- resource syntax work. 

resource ResPes =  ParamX **  open Prelude,Predef in {

  flags optimize=all ;
  coding = utf8;

  param
    
    Order = ODir | OQuest ;

    Animacy = Animate | Inanimate ;
    PMood = Del | Imper | PCond ;
    PPerson = PPers1
	    | PPers2
	    | PPers3;
    
    VerbForm1 = VF Polarity VTense2 PPerson Number
		| Vvform AgrPes
		| Imp Polarity Number
		| Inf 
		| Root1 | Root2 ;
    VTense2 = PPresent2 PrAspect | PPast2 PstAspect | PFut2 FtAspect| Infr_Past2 InfrAspect;
    PrAspect = PrPerf | PrImperf ;
    PstAspect = PstPerf | PstImperf | PstAorist ;
    FtAspect =  FtAorist ; -- just keep FtAorist
    InfrAspect = InfrPerf | InfrImperf ;
 
    AgrPes = AgPes Number PPerson;
    Ezafa = bEzafa | aEzafa | enClic;
    NPCase = NPC Ezafa ;
    CardOrd = NCard | NOrd ;
    RAgr = RNoAg | RAg AgrPes ;
 --   RCase = RC Number Case ;
 param
      CPolarity = 
       CPos
       |CNeg Bool;  -- contracted or not
      
  oper

    Noun = {s : Ezafa => Number => Str ; animacy : Animacy ; definitness : Bool } ;

    Verb = {s : VerbForm1 => Str} ;
    
    Compl : Type = {s : Str ; ra : Str ; c : VType} ;
    
    Adjective = {s:Ezafa => Str ; adv : Str} ;
    
    NP : Type = {s : NPCase => Str ; a : AgrPes ; animacy : Animacy } ;
    Determiner = {s : Str ; n :Number ; isNum : Bool ; fromPron : Bool} ;
    VPHSlash = VPH ** {c2 : Compl} ;
    
  oper
    contrNeg : Bool -> Polarity -> CPolarity = \b,p -> case p of {
    Pos => CPos ;
    Neg => CNeg b
    } ;  
    
 -----------------------
 --- Verb Phrase
 -----------------------
 
oper 
 
 VPH : Type = {
      s    : VPHForm => {inf : Str} ;
      obj  : {s : Str ; a : AgrPes} ; 
      subj : VType ;
      comp : AgrPes => Str;
      vComp : AgrPes => Str;
      inf : Str;
      ad  : Str;
      embComp : Str ;
      wish : Bool ;
      } ;
 param      
  
    VPHForm = 
       VPTense Polarity VPPTense AgrPes -- 9 * 12
--     | VPReq
       | VPImp Polarity Number
--     | VPReqFut
     | VVForm AgrPes
     | VPStem1
     | VPStem2
     ;
    
    VPHTense = 
       VPres  -- impf hum       nahim    "I گْ"
     | VPast  -- impf Ta        nahim    "I weنت"
     | VFut      -- fut            na/nahim "I سهلل گْ"
     | VPerfPres -- perf hum       na/nahim "I هوe گْنe"
     | VPerfPast -- perf Ta        na/nahim "I هد گْنe"          
     | VPerfFut
     | VCondSimul
     | VCondAnter -- subj           na       "I می گْ"
     ;
 

    VType = VIntrans | VTrans | VTransPost ;
     
 VPPTense = 
	  VPPres Anteriority 
	  |VPPast Anteriority 
	  |VPFutr Anteriority
	  |VPCond Anteriority ;
oper

  predV : Verb -> VPH = \verb -> {
      s = \\vh => 
	   case vh of {
	     VPTense pol (VPPres Simul) (AgPes n p) => { inf = verb.s ! VF pol (PPresent2 PrImperf) p n } ;
	     VPTense pol (VPPres Anter) (AgPes n p) => { inf = verb.s ! VF pol (PPresent2 PrPerf) p n } ;
	     VPTense pol (VPPast Simul) (AgPes n p) => { inf =verb.s ! VF pol (PPast2 PstAorist) p n } ;
	     VPTense pol (VPPast Anter) (AgPes n p) => { inf =verb.s ! VF pol (PPast2 PstPerf) p n } ;
	     VPTense pol (VPFutr Simul) (AgPes n p) =>  { inf =  verb.s ! VF pol (PFut2 FtAorist) p n } ;
	     VPTense pol (VPFutr Anter) (AgPes n p) =>  { inf =  verb.s ! VF pol (PPresent2 PrPerf) p n } ; -- this is to be confirmed
	     VPTense pol (VPCond Simul) (AgPes n p) => { inf = verb.s ! VF pol (PPast2 PstImperf)  p n } ;
	     VPTense pol (VPCond Anter) (AgPes n p) => { inf = verb.s ! VF pol (PPast2 PstImperf)  p n } ; 
	     VVForm (AgPes n p) => {inf = verb.s ! Vvform (AgPes n p)} ;
	     VPStem1 => { inf =  verb.s ! Root1};
	     VPStem2 => { inf =  verb.s ! Root2} ;
	     VPImp pol n => { inf = verb.s ! Imp pol n} 
	     
		 };
	    obj = {s = [] ; a = defaultAgrPes} ;
		subj = VIntrans ;
		inf = verb.s ! Inf;
		ad = [];
        embComp = [];
	wish = False ;
        vComp = \\_ => [] ;
        comp = \\_ => []
      } ;
    
   predVc : (Verb ** {c2,c1 : Str}) -> VPHSlash = \verb -> 
    predV verb ** {c2 = {s = verb.c1 ; ra = [] ; c = VTrans} } ; 
----------------------
-- Verb Phrase complimantation
------------------------
{-
  insertObject : NP -> VPHSlash -> VPH = \np,vps -> {
      s = vps.s ;
--      obj =  {s = variants { vps.obj.s  ++ np.s ++ vps.c2.s ; vps.obj.s  ++ np.s  }  ; a = np.a} ;
      obj =  {s = case vps.c2.s of {
                 "را" =>  np.s ++ vps.c2.s  ++ vps.obj.s;
		 _    =>  vps.c2.s ++ np.s ++ vps.obj.s 
	     };	 
		 a = np.a} ;	    
      subj = vps.c2.c ;
	  inf = vps.inf;
	  ad = vps.ad;
      embComp = vps.embComp;
 --     wish = vps.wish ;
      comp = vps.comp
      } ;
-}	
   insertObjc : (AgrPes => Str) -> VPHSlash -> VPHSlash = \obj,vp -> 
    insertObj obj vp ** {c2 = vp.c2} ;
    insertVVc : (AgrPes => Str) -> VPHSlash -> VPHSlash = \obj,vp -> 
    insertVV obj vp ** {c2 = vp.c2} ;
    
 {-
 insertSubj : PPerson -> Str -> Str = \p,s -> 
      case p of { Pers1 => s ++ "wN" ; _ => s ++ "E"};
  -}   
    insertObj : (AgrPes => Str) -> VPH -> VPH = \obj1,vp -> {
     s = vp.s ;
     obj = vp.obj ;
     subj = vp.subj ;
	 inf = vp.inf;
	 ad = vp.ad;
     embComp = vp.embComp;
     wish = vp.wish ;
     vComp = vp.vComp ;
     comp = \\a =>    vp.comp ! a  ++ obj1 ! a 
     } ;
     
  insertVV : (AgrPes => Str) -> VPH -> VPH = \obj1,vp -> {
     s = vp.s ;
--     obj = vp.obj ;
     obj = vp.obj ;
     subj = vp.subj ;
	 inf = vp.inf;
	 ad = vp.ad;
     embComp = vp.embComp; 
     wish = True ;
     vComp = \\a => vp.comp ! a ++ obj1 ! a ;
     comp = vp.comp  
     } ;
     
    insertObj2 : (Str) -> VPH -> VPH = \obj1,vp -> {
     s = vp.s;
     obj = vp.obj ;
     subj = vp.subj ;
	 inf = vp.inf;
	 ad = vp.ad;
     embComp = vp.embComp ++ obj1;
     wish = vp.wish ;
     vComp = vp.vComp ;
     comp = \\a =>    vp.comp ! a --  ++ obj1
     
     } ;
     insertObj3 : (Str) -> VPH -> VPH = \obj1,vp -> {
     s = vp.s;
     obj = {s = obj1 ++ vp.obj.s ; a = vp.obj.a };
     subj = vp.subj ;
	 inf = vp.inf;
	 ad = vp.ad;
     embComp = vp.embComp;
     wish = vp.wish ;
     vComp = vp.vComp ;
     comp = vp.comp
     
     } ;
	 
    
    insertObjc2 : Str -> VPHSlash -> VPHSlash = \obj,vp -> 
    insertObj2 obj vp ** {c2 = vp.c2} ;
    insertObjc3 : Str -> VPHSlash -> VPHSlash = \obj,vp -> 
    insertObj3 obj vp ** {c2 = vp.c2} ;
{-
	infVP : Bool -> VPH -> Agr -> Str = \isAux,vp,a ->
     vp.obj.s ++ vp.inf ++ vp.comp ! a ;
 -}    
    infVV : Bool -> VPH -> {s : AgrPes => Str} = \isAux,vp -> 
	                       {s = \\agr => case agr of {
		                  AgPes n p => (vp.ad ++ vp.comp ! (toAgr n p)) ++ (vp.s ! VVForm (AgPes n p)).inf }};
   
    insertObjPre : (AgrPes => Str) -> VPHSlash -> VPH = \obj,vp -> {
     s = vp.s ;
     obj = vp.obj ;
     inf = vp.inf ;
     subj = vp.subj ;
	 ad = vp.ad ;
     embComp = vp.embComp;
     wish = vp.wish ;
     vComp = vp.vComp ; 
    -- comp = \\a => case vp.c2.s of {"را" =>   obj ! a  ++ vp.c2.s ++ vp.comp ! a ; _ => vp.c2.s ++ obj ! a ++ vp.comp ! a}  -- gives linking error
    comp = \\a =>  vp.c2.s ++ obj ! a  ++ vp.c2.ra ++ vp.comp ! a 
    } ;

    insertAdV : Str -> VPH -> VPH = \ad,vp -> {
     s = vp.s ;
     obj = vp.obj ;
     inf = vp.inf ;
	 subj = vp.subj;
     ad  = vp.ad ++ ad ;
     embComp = vp.embComp;
     wish = vp.wish ;
     vComp = vp.vComp ;
     comp = vp.comp
    } ;
  
	conjThat : Str = "که" ;
 {-   checkPron : NP -> Str -> Str = \np,str ->  case (np.isPron) of {
                                True => np.s ! NPC Obl;
                                False => np.s ! NPC Obl ++ str} ;
		
    insertEmbCompl : VPH -> Str -> VPH = \vp,emb -> {
     s = vp.s ;
     obj = vp.obj ;
     inf = vp.inf ;
     subj = vp.subj;
     ad  = vp.ad;
     embComp = vp.embComp ++ emb;
     wish = vp.wish ;
     comp = vp.comp
    } ;
    
    insertTrans : VPH -> VType -> VPH = \vp,vtype -> {
     s = vp.s ;
     obj = vp.obj ;
     inf = vp.inf ;
     subj = case vtype of {VIntrans => VTransPost ; VTrans => VTrans ; _ => vtype} ; -- still some problem not working properly
     ad  = vp.ad;
     embComp = vp.embComp ;
     wish = vp.wish ;
     comp = vp.comp
    } ;
-}
---------------------------
--- Clauses
---------------------------
Clause : Type = {s : VPHTense => Polarity => Order => Str} ;
mkClause : NP -> VPH -> Clause = \np,vp -> {
      s = \\vt,b,ord => 
        let 
          subj = np.s ! NPC bEzafa;
          agr  = np.a ;
	  n    = (fromAgr agr).n;
	  p    = (fromAgr agr).p;
          vps  = case <b,vt> of {

		    <Pos,VPres>  => vp.s ! VPTense Pos (VPPres Simul) (AgPes n p) ;
		    <Neg,VPres>  => vp.s ! VPTense Neg (VPPres Simul) (AgPes n p) ;
		    <Pos,VPerfPres> => vp.s ! VPTense Pos (VPPres Anter) (AgPes n p) ;
		    <Neg,VPerfPres> => vp.s ! VPTense Neg (VPPres Anter) (AgPes n p) ;
		    <Pos,VPast>  => vp.s !  VPTense Pos (VPPast Simul) (AgPes n p) ;
		    <Neg,VPast>  => vp.s !  VPTense Neg (VPPast Simul) (AgPes n p) ;
		    <Pos,VPerfPast> => vp.s !  VPTense Pos (VPPast Anter) (AgPes n p) ;
		    <Pos,VFut>  => case vp.wish of
		                   {True => vp.s ! VPTense Pos (VPPres Simul) (AgPes n p) ;
				    False => vp.s ! VPTense Pos (VPFutr Simul) (AgPes n p) };
		    <Pos,VPerfFut> => case vp.wish of
		                   {True => vp.s ! VPTense Pos (VPPres Anter) (AgPes n p) ;
				    False => vp.s ! VPTense Pos (VPFutr Anter) (AgPes n p) };  -- verb form need to be confirmed
		    <Pos,VCondSimul> => vp.s ! VPTense Pos (VPCond Simul) (AgPes n p) ;
		    <Pos,VCondAnter> => vp.s ! VPTense Pos (VPCond Anter) (AgPes n p); -- verb form to be confirmed
		    <Neg,VPerfPast> => vp.s !  VPTense Neg (VPPast Anter) (AgPes n p) ;
		    <Neg,VFut>  => case vp.wish of
		                   {True => vp.s ! VPTense Neg (VPPres Simul) (AgPes n p) ;
				    False => vp.s ! VPTense Neg (VPFutr Simul) (AgPes n p) };
		    <Neg,VPerfFut> => case vp.wish of
		                   {True => vp.s ! VPTense Neg (VPPres Anter) (AgPes n p) ;
				    False => vp.s ! VPTense Neg (VPFutr Anter) (AgPes n p) };  -- verb form need to be confirmed
		    <Neg,VCondSimul> => vp.s ! VPTense Neg (VPCond Simul) (AgPes n p) ;
		    <Neg,VCondAnter> => vp.s ! VPTense Neg (VPCond Anter) (AgPes n p) -- verb form to be confirmed
		    	    
		      };
					
		    
          quest =
            case ord of
              { ODir => [];
                OQuest => "آیا" }; 
	 
           
            
        in
		
		quest ++ subj ++ vp.ad ++ vp.comp ! np.a ++ vp.obj.s ++ vps.inf ++ vp.vComp ! np.a ++ vp.embComp

};

--Clause : Type = {s : VPHTense => Polarity => Order => Str} ;
mkSClause : Str -> AgrPes -> VPH -> Clause = \subj,agr,vp -> {
      s = \\vt,b,ord => 
        let 
	  n    = (fromAgr agr).n;
	  p    = (fromAgr agr).p;
          vps  = case <b,vt> of {

		    <Pos,VPres>  => vp.s ! VPTense Pos (VPPres Simul) (AgPes n p) ;
		    <Neg,VPres>  => vp.s ! VPTense Neg (VPPres Simul) (AgPes n p) ;
		    <Pos,VPerfPres> => vp.s ! VPTense Pos (VPPres Anter) (AgPes n p) ;
		    <Neg,VPerfPres> => vp.s ! VPTense Neg (VPPres Anter) (AgPes n p) ;
		    <Pos,VPast>  => vp.s !  VPTense Pos (VPPast Simul) (AgPes n p) ;
		    <Neg,VPast>  => vp.s !  VPTense Neg (VPPast Simul) (AgPes n p) ;
		    <Pos,VPerfPast> => vp.s !  VPTense Pos (VPPast Anter) (AgPes n p) ;
		    <Pos,VFut>  => case vp.wish of
		                   {True => vp.s ! VPTense Pos (VPPres Simul) (AgPes n p) ;
				    False => vp.s ! VPTense Pos (VPFutr Simul) (AgPes n p) };
		    <Pos,VPerfFut> => case vp.wish of
		                   {True => vp.s ! VPTense Pos (VPPres Anter) (AgPes n p) ;
				    False => vp.s ! VPTense Pos (VPFutr Anter) (AgPes n p) };  -- verb form need to be confirmed
		    <Pos,VCondSimul> => vp.s ! VPTense Pos (VPCond Simul) (AgPes n p) ;
		    <Pos,VCondAnter> => vp.s ! VPTense Pos (VPCond Anter) (AgPes n p); -- verb form to be confirmed
		    <Neg,VPerfPast> => vp.s !  VPTense Neg (VPPast Anter) (AgPes n p) ;
		    <Neg,VFut>  => case vp.wish of
		                   {True => vp.s ! VPTense Neg (VPPres Simul) (AgPes n p) ;
				    False => vp.s ! VPTense Neg (VPFutr Simul) (AgPes n p) };
		    <Neg,VPerfFut> => case vp.wish of
		                   {True => vp.s ! VPTense Neg (VPPres Anter) (AgPes n p) ;
				    False => vp.s ! VPTense Neg (VPFutr Anter) (AgPes n p) };  -- verb form need to be confirmed
		    <Neg,VCondSimul> => vp.s ! VPTense Neg (VPCond Simul) (AgPes n p) ;
		    <Neg,VCondAnter> => vp.s ! VPTense Neg (VPCond Anter) (AgPes n p) -- verb form to be confirmed
		    	    
		      };
					
		    
          quest =
            case ord of
              { ODir => [];
                OQuest => "آیا" }; 
	 
           
            
        in
		
		quest ++ subj ++ vp.ad ++ vp.comp ! agr ++ vp.obj.s ++ vps.inf ++ vp.vComp ! agr ++ vp.embComp

};
	 
  predAux : Aux -> VPH = \verb -> {
     s = \\vh => 
       
	     case vh of {
	     VPTense pol (VPPres Simul) (AgPes n p) => { inf = verb.inf ! AX pol (AuxPresent PrImperf) p n } ;
	     VPTense pol (VPPres Anter) (AgPes n p) => { inf = verb.inf ! AX pol (AuxPresent PrPerf) p n } ;
	     VPTense pol (VPPast Simul) (AgPes n p) => { inf = verb.inf ! AX pol (AuxPast PstAorist) p n } ;
	     VPTense pol (VPPast Anter) (AgPes n p) => { inf = verb.inf ! AX pol (AuxPresent PrPerf) p n } ;
	     VPTense pol (VPFutr Simul) (AgPes n p) =>  { inf =  verb.inf ! AX pol (AuxFut FtAorist) p n } ;
	     VPTense pol (VPFutr Anter) (AgPes n p) =>  { inf =  verb.inf ! AX pol (AuxFut FtAorist) p n } ; -- this is to be confirmed
	     VPTense pol (VPCond Simul) (AgPes n p) => { inf = verb.inf ! AX pol (AuxFut FtAorist)  p n } ;
	     VPTense pol (VPCond Anter) (AgPes n p) => { inf = verb.inf ! AX pol (AuxPast PstImperf)  p n } ;
	     VVForm  (AgPes n p) => {inf = ""} ; -- to be checked
	     VPStem1 => { inf =  ""};
	     VPStem2 => { inf =  "بود"} ;
	     VPImp _ _ => { inf = ""} -- need to be confirmed 
--	     _ => { inf = ""} 
		 };
	    obj = {s = [] ; a = defaultAgrPes} ;
		subj = VIntrans ;
		inf = "بودن";
		ad = [];
        embComp = [];
	wish = False ;
        vComp = \\_ => [] ;
        comp = \\_ => []
      } ;


  Aux = {
      inf :  AuxForm => Str ;
    } ;

  auxBe : Aux = {
    inf  =  table {

     AX pol tense person number   => (mkAux pol tense person number).s 
    } ;
    } ;
    
  mkAux : Polarity -> AuxTense -> PPerson -> Number -> {s:Str}= \pol,t,p,n ->
  {s =
   let bodh = "بوده" ;
       nbodh = "نبوده" ;
       hast = "هست" ;
       nhast = "نیست" ;
       bod  = "بود" ;
       khah = "خواه" ;
       mekhah = "می" ++ khah ;
       bash = "باش" ;
       nbod  = "نبود" ;
       nkhah = "نخواه" ;
       nmekhah = "نمی" ++ khah ;
       nbash = "نباش"
    in  
  case <pol,t,p,n> of {
    <Pos,AuxPresent PrPerf,PPers1,Sg> => bodh ++ "ام" ;
    <Pos,AuxPresent PrPerf,PPers1,Pl> => bodh ++ "ایم" ;
    <Pos,AuxPresent PrPerf,PPers2,Sg> => bodh ++ "ای" ;
    <Pos,AuxPresent PrPerf,PPers2,Pl> => bodh ++ "اید" ;
    <Pos,AuxPresent PrPerf,PPers3,Sg> => bodh ++ "است" ;
    <Pos,AuxPresent PrPerf,PPers3,Pl> => bodh ++ "اند" ;
    
    <Pos,AuxPresent PrImperf,PPers1,Sg> =>  hast + "م" ;
    <Pos,AuxPresent PrImperf,PPers1,Pl> => hast + "یم" ;
    <Pos,AuxPresent PrImperf,PPers2,Sg> => hast + "ی" ;
    <Pos,AuxPresent PrImperf,PPers2,Pl> => hast + "ید" ;
    <Pos,AuxPresent PrImperf,PPers3,Sg> => "است" ;
    <Pos,AuxPresent PrImperf,PPers3,Pl> => hast + "ند" ;
    
    
    <Pos,AuxPast PstPerf,PPers1,Sg> => "";
    <Pos,AuxPast PstPerf,PPers1,Pl> => "" ;
    <Pos,AuxPast PstPerf,PPers2,Sg> => "" ;
    <Pos,AuxPast PstPerf,PPers2,Pl> => "" ;
    <Pos,AuxPast PstPerf,PPers3,Sg> => "" ;
    <Pos,AuxPast PstPerf,PPers3,Pl> => "" ;
    
    <Pos,AuxPast PstImperf,PPers1,Sg> => "می" ++ bod + "م" ;
    <Pos,AuxPast PstImperf,PPers1,Pl> => "می" ++ bod + "یم" ;
    <Pos,AuxPast PstImperf,PPers2,Sg> => "می" ++ bod + "ی";
    <Pos,AuxPast PstImperf,PPers2,Pl> => "می" ++ bod + "ید" ;
    <Pos,AuxPast PstImperf,PPers3,Sg> => "می" ++ bod ;
    <Pos,AuxPast PstImperf,PPers3,Pl> => "می" ++ bod + "ند" ;
    
    <Pos,AuxPast PstAorist,PPers1,Sg> => bod + "م" ;
    <Pos,AuxPast PstAorist,PPers1,Pl> => bod + "یم" ;
    <Pos,AuxPast PstAorist,PPers2,Sg> => bod  + "ی";
    <Pos,AuxPast PstAorist,PPers2,Pl> => bod + "ید" ;
    <Pos,AuxPast PstAorist,PPers3,Sg> => bod ;
    <Pos,AuxPast PstAorist,PPers3,Pl> => bod + "ند" ;
    
   {- 
    <Pos,AuxFut FtImperf,PPers1,Sg> => mekhah + "م"   ++  bash + "م" ;
    <Pos,AuxFut FtImperf,PPers1,Pl> => mekhah + "یم" ++  bash + "یم" ;
    <Pos,AuxFut FtImperf,PPers2,Sg> => mekhah + "ی" ++  bash + "ی" ;
    <Pos,AuxFut FtImperf,PPers2,Pl> => mekhah + "ید" ++  bash + "ید" ;
    <Pos,AuxFut FtImperf,PPers3,Sg> => mekhah + "د" ++  bash + "د" ;
    <Pos,AuxFut FtImperf,PPers3,Pl> => mekhah + "ند" ++  bash + "ند" ;
    -}
    <Pos,AuxFut FtAorist,PPers1,Sg> => khah + "م"  ++ bod  ;
    <Pos,AuxFut FtAorist,PPers1,Pl> => khah + "یم"  ++ bod ;
    <Pos,AuxFut Ftorist,PPers2,Sg> => khah + "ی"  ++ bod ;
    <Pos,AuxFut FtAorist,PPers2,Pl> => khah + "ید"  ++ bod ;
    <Pos,AuxFut FtAorist,PPers3,Sg> => khah + "د"  ++ bod ;
    <Pos,AuxFut FtAorist,PPers3,Pl> => khah + "ند"  ++ bod ;
    
  -- nagatives
  
  <Neg,AuxPresent PrPerf,PPers1,Sg> => nbodh ++ "ام" ;
    <Neg,AuxPresent PrPerf,PPers1,Pl> => nbodh ++ "ایم" ;
    <Neg,AuxPresent PrPerf,PPers2,Sg> => nbodh ++ "ای" ;
    <Neg,AuxPresent PrPerf,PPers2,Pl> => nbodh ++ "اید" ;
    <Neg,AuxPresent PrPerf,PPers3,Sg> => nbodh ++ "است" ;
    <Neg,AuxPresent PrPerf,PPers3,Pl> => nbodh ++ "اند" ;
    
    <Neg,AuxPresent PrImperf,PPers1,Sg> =>  nhast + "م" ;
    <Neg,AuxPresent PrImperf,PPers1,Pl> => nhast + "یم" ;
    <Neg,AuxPresent PrImperf,PPers2,Sg> => nhast + "ی" ;
    <Neg,AuxPresent PrImperf,PPers2,Pl> => nhast + "ید" ;
    <Neg,AuxPresent PrImperf,PPers3,Sg> => "نیست" ;
    <Neg,AuxPresent PrImperf,PPers3,Pl> => nhast + "ند" ;
    
    
    <Neg,AuxPast PstPerf,PPers1,Sg> => "";
    <Neg,AuxPast PstPerf,PPers1,Pl> => "" ;
    <Neg,AuxPast PstPerf,PPers2,Sg> => "" ;
    <Neg,AuxPast PstPerf,PPers2,Pl> => "" ;
    <Neg,AuxPast PstPerf,PPers3,Sg> => "" ;
    <Neg,AuxPast PstPerf,PPers3,Pl> => "" ;
    
    <Neg,AuxPast PstImperf,PPers1,Sg> => "نمی" ++ bod + "م" ;
    <Neg,AuxPast PstImperf,PPers1,Pl> => "نمی" ++ bod + "یم" ;
    <Neg,AuxPast PstImperf,PPers2,Sg> => "نمی" ++ bod + "ی";
    <Neg,AuxPast PstImperf,PPers2,Pl> => "نمی" ++ bod + "ید" ;
    <Neg,AuxPast PstImperf,PPers3,Sg> => "نمی" ++ bod ;
    <Neg,AuxPast PstImperf,PPers3,Pl> => "نمی" ++ bod + "ند" ;
    
    <Neg,AuxPast PstAorist,PPers1,Sg> => nbod + "م" ;
    <Neg,AuxPast PstAorist,PPers1,Pl> => nbod + "یم" ;
    <Neg,AuxPast PstAorist,PPers2,Sg> => nbod  + "ی";
    <Neg,AuxPast PstAorist,PPers2,Pl> => nbod + "ید" ;
    <Neg,AuxPast PstAorist,PPers3,Sg> => nbod ;
    <Neg,AuxPast PstAorist,PPers3,Pl> => nbod + "ند" ;
    
   {- 
    <Neg,AuxFut FtImperf,PPers1,Sg> => nmekhah + "م"   ++  bash + "م" ;
    <Neg,AuxFut FtImperf,PPers1,Pl> => nmekhah + "یم" ++  bash + "یم" ;
    <Neg,AuxFut FtImperf,PPers2,Sg> => nmekhah + "ی" ++  bash + "ی" ;
    <Neg,AuxFut FtImperf,PPers2,Pl> => nmekhah + "ید" ++  bash + "ید" ;
    <Neg,AuxFut FtImperf,PPers3,Sg> => nmekhah + "د" ++  bash + "د" ;
    <Neg,AuxFut FtImperf,PPers3,Pl> => nmekhah + "ند" ++  bash + "ند" ;
    -}
    <Neg,AuxFut FtAorist,PPers1,Sg> => nkhah + "م"  ++ bod  ;
    <Neg,AuxFut FtAorist,PPers1,Pl> => nkhah + "یم"  ++ bod ;
    <Neg,AuxFut Ftorist,PPers2,Sg> => nkhah + "ی"  ++ bod ;
    <Neg,AuxFut FtAorist,PPers2,Pl> => nkhah + "ید"  ++ bod ;
    <Neg,AuxFut FtAorist,PPers3,Sg> => nkhah + "د"  ++ bod ;
    <Neg,AuxFut FtAorist,PPers3,Pl> => nkhah + "ند"  ++ bod 
  
  
    
  {-  
    <Infr_Past2 InfrPerf,PPers1,Sg> => khordh ++ bvdh ++ "ام" ;
    <Infr_Past2 InfrPerf,PPers1,Pl> => khordh ++ bvdh ++ "ایم" ;
    <Infr_Past2 InfrPerf,PPers2,Sg> => khordh ++ bvdh ++ "ای" ;
    <Infr_Past2 InfrPerf,PPers2,Pl> => khordh ++ bvdh ++ "اید" ;
    <Infr_Past2 InfrPerf,PPers3,Sg> => khordh ++ bvdh ++ "است" ;
    <Infr_Past2 InfrPerf,PPers3,Pl> => khordh ++ bvdh ++ "اند" ;
    
    <Infr_Past2 InfrImperf,PPers1,Sg> => mekhordh ++ "ام" ;
    <Infr_Past2 InfrImperf,PPers1,Pl> => mekhordh ++ "ایم" ;
    <Infr_Past2 InfrImperf,PPers2,Sg> => mekhordh ++ "ای" ;
    <Infr_Past2 InfrImperf,PPers2,Pl> => mekhordh ++ "اید" ;
    <Infr_Past2 InfrImperf,PPers3,Sg> => mekhordh ++ "است" ;
    <Infr_Past2 InfrImperf,PPers3,Pl> => mekhordh ++ "اند" 
    
    
    -}
  }
 } ;
  
  param
   AuxTense = AuxPresent PrAspect | AuxPast PstAspect | AuxFut FtAspect ;
   AuxForm = AX Polarity AuxTense PPerson Number ;
   
 
 oper
 toHave : Polarity -> VTense2 -> Number -> PPerson -> {s:Str} = \pol,t,n,p -> {
   s = let dasht = "داشت";
	   ndasht = "نداشت" ;
           dashteh = "داشته";
           ndashteh = "نداشته" ;
           dar = "دار" ;
	   ndar = "ندار" ;
	   khah = "خواه" ;
	   nkhah = "نخواه" ;
	   bvdh = "بوده" ;
    in case <pol,t,p,n> of {
    <Pos,PPresent2 PrPerf,PPers1,Sg> => dashteh ++ "ام" ;  
    <Pos,PPresent2 PrPerf,PPers1,Pl> => dashteh ++ "ایم" ;
    <Pos,PPresent2 PrPerf,PPers2,Sg> => dashteh ++ "ای" ;
    <Pos,PPresent2 PrPerf,PPers2,Pl> => dashteh ++ "اید" ;
    <Pos,PPresent2 PrPerf,PPers3,Sg> =>  dashteh ++ "است" ;
    <Pos,PPresent2 PrPerf,PPers3,Pl> => dashteh ++ "اند" ;
    
    <Pos,PPresent2 PrImperf,PPers1,Sg> => dar + "م" ;
    <Pos,PPresent2 PrImperf,PPers1,Pl> => dar + "یم" ;
    <Pos,PPresent2 PrImperf,PPers2,Sg> => dar + "ی" ;
    <Pos,PPresent2 PrImperf,PPers2,Pl> => dar + "ید" ;
    <Pos,PPresent2 PrImperf,PPers3,Sg> => dar + "د" ;
    <Pos,PPresent2 PrImperf,PPers3,Pl> => dar + "ند" ;
    
    
    <Pos,PPast2 PstPerf,PPers1,Sg> => dashteh ++ "بودم" ;
    <Pos,PPast2 PstPerf,PPers1,Pl> => dashteh ++ "بودیم" ;
    <Pos,PPast2 PstPerf,PPers2,Sg> => dashteh ++ "بودی" ;
    <Pos,PPast2 PstPerf,PPers2,Pl> => dashteh ++ "بودید" ;
    <Pos,PPast2 PstPerf,PPers3,Sg> => dashteh ++ "بود" ;
    <Pos,PPast2 PstPerf,PPers3,Pl> => dashteh ++ "بودند" ;
    
    <Pos,PPast2 PstImperf,PPers1,Sg> => dasht + "م" ;
    <Pos,PPast2 PstImperf,PPers1,Pl> => dasht + "یم" ;
    <Pos,PPast2 PstImperf,PPers2,Sg> => dasht  + "ی";
    <Pos,PPast2 PstImperf,PPers2,Pl> => dasht + "ید" ;
    <Pos,PPast2 PstImperf,PPers3,Sg> => dasht ;
    <Pos,PPast2 PstImperf,PPers3,Pl> => dasht + "ند" ;
    
    <Pos,PPast2 PstAorist,PPers1,Sg> => dasht + "م" ;
    <Pos,PPast2 PstAorist,PPers1,Pl> => dasht + "یم" ;
    <Pos,PPast2 PstAorist,PPers2,Sg> => dasht  + "ی";
    <Pos,PPast2 PstAorist,PPers2,Pl> => dasht + "ید" ;
    <Pos,PPast2 PstAorist,PPers3,Sg> => dasht ;
    <Pos,PPast2 PstAorist,PPers3,Pl> => dasht + "ند" ;
    
   
    <Pos,PFut2 FtAorist,PPers1,Sg> => khah + "م"  ++ dasht  ;
    <Pos,PFut2 FtAorist,PPers1,Pl> => khah + "یم"  ++ dasht ;
    <Pos,PFut2 Ftorist,PPers2,Sg> => khah + "ی"  ++ dasht ;
    <Pos,PFut2 FtAorist,PPers2,Pl> => khah + "ید"  ++ dasht ;
    <Pos,PFut2 FtAorist,PPers3,Sg> => khah + "د"  ++ dasht ;
    <Pos,PFut2 FtAorist,PPers3,Pl> => khah + "ند"  ++ dasht  ;
    
    
    <Pos,Infr_Past2 InfrPerf,PPers1,Sg> => dashteh ++ bvdh ++ "ام" ;
    <Pos,Infr_Past2 InfrPerf,PPers1,Pl> => dashteh ++ bvdh ++ "ایم" ;
    <Pos,Infr_Past2 InfrPerf,PPers2,Sg> => dashteh ++ bvdh ++ "ای" ;
    <Pos,Infr_Past2 InfrPerf,PPers2,Pl> => dashteh ++ bvdh ++ "اید" ;
    <Pos,Infr_Past2 InfrPerf,PPers3,Sg> => dashteh ++ bvdh ++ "است" ;
    <Pos,Infr_Past2 InfrPerf,PPers3,Pl> => dashteh ++ bvdh ++ "اند" ;
    
    <Pos,Infr_Past2 InfrImperf,PPers1,Sg> => dashteh ++ "ام" ;
    <Pos,Infr_Past2 InfrImperf,PPers1,Pl> => dashteh ++ "ایم" ;
    <Pos,Infr_Past2 InfrImperf,PPers2,Sg> => dashteh ++ "ای" ;
    <Pos,Infr_Past2 InfrImperf,PPers2,Pl> => dashteh ++ "اید" ;
    <Pos,Infr_Past2 InfrImperf,PPers3,Sg> => dashteh ++ "است" ;
    <Pos,Infr_Past2 InfrImperf,PPers3,Pl> => dashteh ++ "اند" ;
    
 -- negatives
 
    <Neg,PPresent2 PrPerf,PPers1,Sg> => ndashteh ++ "ام" ;  
    <Neg,PPresent2 PrPerf,PPers1,Pl> => ndashteh ++ "ایم" ;
    <Neg,PPresent2 PrPerf,PPers2,Sg> => ndashteh ++ "ای" ;
    <Neg,PPresent2 PrPerf,PPers2,Pl> => ndashteh ++ "اید" ;
    <Neg,PPresent2 PrPerf,PPers3,Sg> =>  ndashteh ++ "است" ;
    <Neg,PPresent2 PrPerf,PPers3,Pl> => ndashteh ++ "اند" ;
    
    <Neg,PPresent2 PrImperf,PPers1,Sg> => ndar + "م" ;
    <Neg,PPresent2 PrImperf,PPers1,Pl> => ndar + "یم" ;
    <Neg,PPresent2 PrImperf,PPers2,Sg> => ndar + "ی" ;
    <Neg,PPresent2 PrImperf,PPers2,Pl> => ndar + "ید" ;
    <Neg,PPresent2 PrImperf,PPers3,Sg> => ndar + "د" ;
    <Neg,PPresent2 PrImperf,PPers3,Pl> => ndar + "ند" ;
    
    
    <Neg,PPast2 PstPerf,PPers1,Sg> => ndashteh ++ "بودم" ;
    <Neg,PPast2 PstPerf,PPers1,Pl> => ndashteh ++ "بودیم" ;
    <Neg,PPast2 PstPerf,PPers2,Sg> => ndashteh ++ "بودی" ;
    <Neg,PPast2 PstPerf,PPers2,Pl> => ndashteh ++ "بودید" ;
    <Neg,PPast2 PstPerf,PPers3,Sg> => ndashteh ++ "بود" ;
    <Neg,PPast2 PstPerf,PPers3,Pl> => ndashteh ++ "بودند" ;
    
    <Neg,PPast2 PstImperf,PPers1,Sg> => ndasht + "م" ;
    <Neg,PPast2 PstImperf,PPers1,Pl> => ndasht + "یم" ;
    <Neg,PPast2 PstImperf,PPers2,Sg> => ndasht  + "ی";
    <Neg,PPast2 PstImperf,PPers2,Pl> => ndasht + "ید" ;
    <Neg,PPast2 PstImperf,PPers3,Sg> => ndasht ;
    <Neg,PPast2 PstImperf,PPers3,Pl> => ndasht + "ند" ;
    
    <Neg,PPast2 PstAorist,PPers1,Sg> => ndasht + "م" ;
    <Neg,PPast2 PstAorist,PPers1,Pl> => ndasht + "یم" ;
    <Neg,PPast2 PstAorist,PPers2,Sg> => ndasht  + "ی";
    <Neg,PPast2 PstAorist,PPers2,Pl> => ndasht + "ید" ;
    <Neg,PPast2 PstAorist,PPers3,Sg> => ndasht ;
    <Neg,PPast2 PstAorist,PPers3,Pl> => ndasht + "ند" ;
    
   
    <Neg,PFut2 FtAorist,PPers1,Sg> => nkhah + "م"  ++ dasht  ;
    <Neg,PFut2 FtAorist,PPers1,Pl> => nkhah + "یم"  ++ dasht ;
    <Neg,PFut2 Ftorist,PPers2,Sg> => nkhah + "ی"  ++ dasht ;
    <Neg,PFut2 FtAorist,PPers2,Pl> => nkhah + "ید"  ++ dasht ;
    <Neg,PFut2 FtAorist,PPers3,Sg> => nkhah + "د"  ++ dasht ;
    <Neg,PFut2 FtAorist,PPers3,Pl> => nkhah + "ند"  ++ dasht  ;
    
    
    <Neg,Infr_Past2 InfrPerf,PPers1,Sg> => ndashteh ++ bvdh ++ "ام" ;
    <Neg,Infr_Past2 InfrPerf,PPers1,Pl> => ndashteh ++ bvdh ++ "ایم" ;
    <Neg,Infr_Past2 InfrPerf,PPers2,Sg> => ndashteh ++ bvdh ++ "ای" ;
    <Neg,Infr_Past2 InfrPerf,PPers2,Pl> => ndashteh ++ bvdh ++ "اید" ;
    <Neg,Infr_Past2 InfrPerf,PPers3,Sg> => ndashteh ++ bvdh ++ "است" ;
    <Neg,Infr_Past2 InfrPerf,PPers3,Pl> => ndashteh ++ bvdh ++ "اند" ;
    
    <Neg,Infr_Past2 InfrImperf,PPers1,Sg> => ndashteh ++ "ام" ;
    <Neg,Infr_Past2 InfrImperf,PPers1,Pl> => ndashteh ++ "ایم" ;
    <Neg,Infr_Past2 InfrImperf,PPers2,Sg> => ndashteh ++ "ای" ;
    <Neg,Infr_Past2 InfrImperf,PPers2,Pl> => ndashteh ++ "اید" ;
    <Neg,Infr_Past2 InfrImperf,PPers3,Sg> => ndashteh ++ "است" ;
    <Neg,Infr_Past2 InfrImperf,PPers3,Pl> => ndashteh ++ "اند" 
    
     
     };
     
   } ;
  
   predProg : VPH -> VPH = \verb -> {
     s = \\vh => 
       case vh of {
	     VPTense pol (VPPres Simul) (AgPes n p) => { inf = (toHave Pos (PPresent2 PrImperf) n p).s ++  (verb.s ! VPTense pol (VPPres Simul) (AgPes n p)).inf } ;
	     VPTense pol (VPPres Anter) (AgPes n p) => { inf = (verb.s ! VPTense pol (VPPres Anter) (AgPes n p)).inf } ;
	     VPTense pol (VPPast Simul) (AgPes n p) => { inf = (toHave Pos (PPast2 PstAorist) n p).s ++ (verb.s ! VPTense pol (VPCond Simul) (AgPes n p)).inf } ;
	     VPTense pol (VPPast Anter) (AgPes n p) => { inf = (verb.s ! VPTense pol (VPPast Anter) (AgPes n p)).inf } ;
	     VPTense pol (VPFutr Simul) (AgPes n p) =>  { inf =  (verb.s ! VPTense pol (VPFutr Simul) (AgPes n p)).inf } ;
	     VPTense pol (VPFutr Anter) (AgPes n p) =>  { inf =  (verb.s ! VPTense pol (VPFutr Anter) (AgPes n p)).inf } ; -- this is to be confirmed
	     VPTense pol (VPCond Simul) (AgPes n p) => { inf = (toHave Pos (PPast2 PstAorist) n p).s ++ (verb.s ! VPTense pol (VPCond Simul) (AgPes n p)).inf } ;
	     VPTense pol (VPCond Anter) (AgPes n p) => { inf = (toHave Pos (PPast2 PstAorist) n p).s ++ (verb.s ! VPTense pol (VPCond Anter) (AgPes n p)).inf } ; 
	     VVForm (AgPes n p) => {inf = (verb.s ! VVForm (AgPes n p)).inf} ;
	     VPStem1 => { inf =  (verb.s ! VPStem1).inf};
	     VPStem2 => { inf =  (verb.s ! VPStem2).inf} ;
	     VPImp pol n => { inf = (verb.s ! VPImp pol n).inf}  -- need to be confirmed
--	     _ => { inf = (verb.s ! VPStem1).inf} 
		 };
	   
      obj = verb.obj ;
      subj =  VIntrans ;
      inf = verb.inf;
      ad = verb.ad;
      wish = verb.wish;
      vComp = verb.vComp ;
      embComp = verb.embComp ;
      comp = verb.comp 
      } ;
      
-------------------------
-- Ezafa construction
------------------------
oper
mkEzafa : Str -> Str ;
mkEzafa str = case str of {
             st + "اه" => str ;
	     st + "وه" => str ;
	     st + "ه" => str ++ "ی" ;
	     st + "او" => str ;
	     st + "وو" => str ;
	     st + "و" => str + "ی" ;
	     st + "ا" => str + "ی" ;
	     _ => str
	};
mkEnclic : Str -> Str ;
mkEnclic str = case str of {
                 st + "ا" => str ++ "یی" ;
	         st + "و" => str ++ "یی" ;
		 st + "ی" => str ++ "یی" ;
		 st + "ه" => str ++ "یی" ;
	                _ => str + "ی"
	};
		
IndefArticle : Str ;
IndefArticle = "یک";
taryn : Str ;
taryn = "ترین" ;

---------------
-- making negatives
---------------
addN : Str -> Str ;
addN str = 
            case str of { 
	       "ا" + st => "نی" + str ;  
	       "آ" + st => "نیا" + st ;
	         _  => "ن" + str
       };
addBh2 : Str -> Str ; -- should use drop instead but it gives linking error
addBh2 str1 =
       case str1 of {
            "می" + str => 
                case  str of { 
	           "ا" + st => Prelude.glue "بی" str ;  -- need to use '+' but it gives linking error
	           "آ" + st => Prelude.glue "بیا" st ;
	            _    => Prelude.glue "ب" str
                    };
	      _     => ""	    
		  };  

-----------------------------
-- Noun Phrase
-----------------------------
{-toNP : Str -> Str = \pn, npc -> case npc of {
      NPC c => pn !  c ;
      NPObj => pn !  Dir ;
      NPErg => pn !  Obl 
      } ;
-}

 partNP : Str -> Str = \str -> (Prelude.glue str "ه") ++ "شده" ;
-- partNP : Str -> Str = \str ->  str + "ه" ++ "شده" ;

       
  
------------------------------------------
-- Agreement transformations
-----------------------------------------
    toAgr : Number  -> PPerson -> AgrPes = \n,p ->       
	   AgPes n p;
      

    fromAgr : AgrPes -> {n : Number ; p : PPerson } = \agr -> case agr of {
      AgPes n p => {n = n ; p = p } 
	  } ;
	  
	conjAgrPes : AgrPes -> AgrPes -> AgrPes = \a0,b0 -> 
      let a = fromAgr a0 ; b = fromAgr b0 
      in
      toAgr
        (conjNumber a.n b.n)
        b.p;	  
	
	giveNumber : AgrPes -> Number =\a -> case a of {
	   AgPes n _   => n
	};

    
--    defaultAgr : Agr = agrP3 Sg Inanimate ;
--    agrP3 : Number -> Animacy -> Agr = \n,a -> Ag n PPers3 a ;
    defaultAgrPes : AgrPes = agrPesP3 Sg ;
    agrPesP3 : Number -> AgrPes = \n -> AgPes n PPers3 ;	
--    personalAgr : Agr = agrP1 Sg ;
    agrPesP1 : Number -> AgrPes = \n -> AgPes n PPers1 ;
	
--------------------------------------------------------
-- Reflexive Pronouns
-----------------------------------

reflPron : AgrPes => Str = table {
    AgPes Sg PPers1   => "خودم" ;
    AgPes Sg PPers2   => "خودت" ;
    AgPes Sg PPers3   => "خودش" ;
    AgPes Pl PPers1   => "خودمان" ;
    AgPes Pl PPers2   => "خودتان" ;
    AgPes Pl PPers3   => "خودشان" 
    
    } ;
    
  getPron : Animacy -> Number -> Str = \ani,number ->
   case <ani,number> of {
    <Animate,Sg> => "او" ;
    <Animate,Pl> => ["آن ها"] ;
    <Inanimate,Sg> => "آن" ;
    <Inanimate,Pl> => ["آن ها"] 
   };
   

}

