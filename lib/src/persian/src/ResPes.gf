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
       VPres  -- impf hum       nahim    "I go"
     | VPast  -- impf Ta        nahim    "I went"
     | VFut      -- fut            na/nahim "I shall go"
     | VPerfPres -- perf hum       na/nahim "I have gone"
     | VPerfPast -- perf Ta        na/nahim "I had gone"          
     | VPerfFut
     | VCondSimul
     | VCondAnter -- subj           na       "I may go"
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
                 "rA" =>  np.s ++ vps.c2.s  ++ vps.obj.s;
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
    -- comp = \\a => case vp.c2.s of {"rA" =>   obj ! a  ++ vp.c2.s ++ vp.comp ! a ; _ => vp.c2.s ++ obj ! a ++ vp.comp ! a}  -- gives linking error
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
  
	conjThat : Str = "kh" ;
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
                OQuest => "A:yA" }; 
	 
           
            
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
                OQuest => "A:yA" }; 
	 
           
            
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
	     VPStem2 => { inf =  "bvd"} ;
	     VPImp _ _ => { inf = ""} -- need to be confirmed 
--	     _ => { inf = ""} 
		 };
	    obj = {s = [] ; a = defaultAgrPes} ;
		subj = VIntrans ;
		inf = "bvdn";
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
   let bodh = "bvdh" ;
       nbodh = "nbvdh" ;
       hast = "hst" ;
       nhast = "nyst" ;
       bod  = "bvd" ;
       khah = "KvAh" ;
       mekhah = "my" ++ khah ;
       bash = "bAC" ;
       nbod  = "nbvd" ;
       nkhah = "nKvAh" ;
       nmekhah = "nmy" ++ khah ;
       nbash = "nbAC"
    in  
  case <pol,t,p,n> of {
    <Pos,AuxPresent PrPerf,PPers1,Sg> => bodh ++ "Am" ;
    <Pos,AuxPresent PrPerf,PPers1,Pl> => bodh ++ "Aym" ;
    <Pos,AuxPresent PrPerf,PPers2,Sg> => bodh ++ "Ay" ;
    <Pos,AuxPresent PrPerf,PPers2,Pl> => bodh ++ "Ayd" ;
    <Pos,AuxPresent PrPerf,PPers3,Sg> => bodh ++ "Ast" ;
    <Pos,AuxPresent PrPerf,PPers3,Pl> => bodh ++ "And" ;
    
    <Pos,AuxPresent PrImperf,PPers1,Sg> =>  hast + "m" ;
    <Pos,AuxPresent PrImperf,PPers1,Pl> => hast + "ym" ;
    <Pos,AuxPresent PrImperf,PPers2,Sg> => hast + "y" ;
    <Pos,AuxPresent PrImperf,PPers2,Pl> => hast + "yd" ;
    <Pos,AuxPresent PrImperf,PPers3,Sg> => "Ast" ;
    <Pos,AuxPresent PrImperf,PPers3,Pl> => hast + "nd" ;
    
    
    <Pos,AuxPast PstPerf,PPers1,Sg> => "";
    <Pos,AuxPast PstPerf,PPers1,Pl> => "" ;
    <Pos,AuxPast PstPerf,PPers2,Sg> => "" ;
    <Pos,AuxPast PstPerf,PPers2,Pl> => "" ;
    <Pos,AuxPast PstPerf,PPers3,Sg> => "" ;
    <Pos,AuxPast PstPerf,PPers3,Pl> => "" ;
    
    <Pos,AuxPast PstImperf,PPers1,Sg> => "my" ++ bod + "m" ;
    <Pos,AuxPast PstImperf,PPers1,Pl> => "my" ++ bod + "ym" ;
    <Pos,AuxPast PstImperf,PPers2,Sg> => "my" ++ bod + "y";
    <Pos,AuxPast PstImperf,PPers2,Pl> => "my" ++ bod + "yd" ;
    <Pos,AuxPast PstImperf,PPers3,Sg> => "my" ++ bod ;
    <Pos,AuxPast PstImperf,PPers3,Pl> => "my" ++ bod + "nd" ;
    
    <Pos,AuxPast PstAorist,PPers1,Sg> => bod + "m" ;
    <Pos,AuxPast PstAorist,PPers1,Pl> => bod + "ym" ;
    <Pos,AuxPast PstAorist,PPers2,Sg> => bod  + "y";
    <Pos,AuxPast PstAorist,PPers2,Pl> => bod + "yd" ;
    <Pos,AuxPast PstAorist,PPers3,Sg> => bod ;
    <Pos,AuxPast PstAorist,PPers3,Pl> => bod + "nd" ;
    
   {- 
    <Pos,AuxFut FtImperf,PPers1,Sg> => mekhah + "m"   ++  bash + "m" ;
    <Pos,AuxFut FtImperf,PPers1,Pl> => mekhah + "ym" ++  bash + "ym" ;
    <Pos,AuxFut FtImperf,PPers2,Sg> => mekhah + "y" ++  bash + "y" ;
    <Pos,AuxFut FtImperf,PPers2,Pl> => mekhah + "yd" ++  bash + "yd" ;
    <Pos,AuxFut FtImperf,PPers3,Sg> => mekhah + "d" ++  bash + "d" ;
    <Pos,AuxFut FtImperf,PPers3,Pl> => mekhah + "nd" ++  bash + "nd" ;
    -}
    <Pos,AuxFut FtAorist,PPers1,Sg> => khah + "m"  ++ bod  ;
    <Pos,AuxFut FtAorist,PPers1,Pl> => khah + "ym"  ++ bod ;
    <Pos,AuxFut Ftorist,PPers2,Sg> => khah + "y"  ++ bod ;
    <Pos,AuxFut FtAorist,PPers2,Pl> => khah + "yd"  ++ bod ;
    <Pos,AuxFut FtAorist,PPers3,Sg> => khah + "d"  ++ bod ;
    <Pos,AuxFut FtAorist,PPers3,Pl> => khah + "nd"  ++ bod ;
    
  -- nagatives
  
  <Neg,AuxPresent PrPerf,PPers1,Sg> => nbodh ++ "Am" ;
    <Neg,AuxPresent PrPerf,PPers1,Pl> => nbodh ++ "Aym" ;
    <Neg,AuxPresent PrPerf,PPers2,Sg> => nbodh ++ "Ay" ;
    <Neg,AuxPresent PrPerf,PPers2,Pl> => nbodh ++ "Ayd" ;
    <Neg,AuxPresent PrPerf,PPers3,Sg> => nbodh ++ "Ast" ;
    <Neg,AuxPresent PrPerf,PPers3,Pl> => nbodh ++ "And" ;
    
    <Neg,AuxPresent PrImperf,PPers1,Sg> =>  nhast + "m" ;
    <Neg,AuxPresent PrImperf,PPers1,Pl> => nhast + "ym" ;
    <Neg,AuxPresent PrImperf,PPers2,Sg> => nhast + "y" ;
    <Neg,AuxPresent PrImperf,PPers2,Pl> => nhast + "yd" ;
    <Neg,AuxPresent PrImperf,PPers3,Sg> => "nyst" ;
    <Neg,AuxPresent PrImperf,PPers3,Pl> => nhast + "nd" ;
    
    
    <Neg,AuxPast PstPerf,PPers1,Sg> => "";
    <Neg,AuxPast PstPerf,PPers1,Pl> => "" ;
    <Neg,AuxPast PstPerf,PPers2,Sg> => "" ;
    <Neg,AuxPast PstPerf,PPers2,Pl> => "" ;
    <Neg,AuxPast PstPerf,PPers3,Sg> => "" ;
    <Neg,AuxPast PstPerf,PPers3,Pl> => "" ;
    
    <Neg,AuxPast PstImperf,PPers1,Sg> => "nmy" ++ bod + "m" ;
    <Neg,AuxPast PstImperf,PPers1,Pl> => "nmy" ++ bod + "ym" ;
    <Neg,AuxPast PstImperf,PPers2,Sg> => "nmy" ++ bod + "y";
    <Neg,AuxPast PstImperf,PPers2,Pl> => "nmy" ++ bod + "yd" ;
    <Neg,AuxPast PstImperf,PPers3,Sg> => "nmy" ++ bod ;
    <Neg,AuxPast PstImperf,PPers3,Pl> => "nmy" ++ bod + "nd" ;
    
    <Neg,AuxPast PstAorist,PPers1,Sg> => nbod + "m" ;
    <Neg,AuxPast PstAorist,PPers1,Pl> => nbod + "ym" ;
    <Neg,AuxPast PstAorist,PPers2,Sg> => nbod  + "y";
    <Neg,AuxPast PstAorist,PPers2,Pl> => nbod + "yd" ;
    <Neg,AuxPast PstAorist,PPers3,Sg> => nbod ;
    <Neg,AuxPast PstAorist,PPers3,Pl> => nbod + "nd" ;
    
   {- 
    <Neg,AuxFut FtImperf,PPers1,Sg> => nmekhah + "m"   ++  bash + "m" ;
    <Neg,AuxFut FtImperf,PPers1,Pl> => nmekhah + "ym" ++  bash + "ym" ;
    <Neg,AuxFut FtImperf,PPers2,Sg> => nmekhah + "y" ++  bash + "y" ;
    <Neg,AuxFut FtImperf,PPers2,Pl> => nmekhah + "yd" ++  bash + "yd" ;
    <Neg,AuxFut FtImperf,PPers3,Sg> => nmekhah + "d" ++  bash + "d" ;
    <Neg,AuxFut FtImperf,PPers3,Pl> => nmekhah + "nd" ++  bash + "nd" ;
    -}
    <Neg,AuxFut FtAorist,PPers1,Sg> => nkhah + "m"  ++ bod  ;
    <Neg,AuxFut FtAorist,PPers1,Pl> => nkhah + "ym"  ++ bod ;
    <Neg,AuxFut Ftorist,PPers2,Sg> => nkhah + "y"  ++ bod ;
    <Neg,AuxFut FtAorist,PPers2,Pl> => nkhah + "yd"  ++ bod ;
    <Neg,AuxFut FtAorist,PPers3,Sg> => nkhah + "d"  ++ bod ;
    <Neg,AuxFut FtAorist,PPers3,Pl> => nkhah + "nd"  ++ bod 
  
  
    
  {-  
    <Infr_Past2 InfrPerf,PPers1,Sg> => khordh ++ bvdh ++ "Am" ;
    <Infr_Past2 InfrPerf,PPers1,Pl> => khordh ++ bvdh ++ "Aym" ;
    <Infr_Past2 InfrPerf,PPers2,Sg> => khordh ++ bvdh ++ "Ay" ;
    <Infr_Past2 InfrPerf,PPers2,Pl> => khordh ++ bvdh ++ "Ayd" ;
    <Infr_Past2 InfrPerf,PPers3,Sg> => khordh ++ bvdh ++ "Ast" ;
    <Infr_Past2 InfrPerf,PPers3,Pl> => khordh ++ bvdh ++ "And" ;
    
    <Infr_Past2 InfrImperf,PPers1,Sg> => mekhordh ++ "Am" ;
    <Infr_Past2 InfrImperf,PPers1,Pl> => mekhordh ++ "Aym" ;
    <Infr_Past2 InfrImperf,PPers2,Sg> => mekhordh ++ "Ay" ;
    <Infr_Past2 InfrImperf,PPers2,Pl> => mekhordh ++ "Ayd" ;
    <Infr_Past2 InfrImperf,PPers3,Sg> => mekhordh ++ "Ast" ;
    <Infr_Past2 InfrImperf,PPers3,Pl> => mekhordh ++ "And" 
    
    
    -}
  }
 } ;
  
  param
   AuxTense = AuxPresent PrAspect | AuxPast PstAspect | AuxFut FtAspect ;
   AuxForm = AX Polarity AuxTense PPerson Number ;
   
 
 oper
 toHave : Polarity -> VTense2 -> Number -> PPerson -> {s:Str} = \pol,t,n,p -> {
   s = let dasht = "dACt";
	   ndasht = "ndACt" ;
           dashteh = "dACth";
           ndashteh = "ndACth" ;
           dar = "dAr" ;
	   ndar = "ndAr" ;
	   khah = "KvAh" ;
	   nkhah = "nKvAh" ;
	   bvdh = "bvdh" ;
    in case <pol,t,p,n> of {
    <Pos,PPresent2 PrPerf,PPers1,Sg> => dashteh ++ "Am" ;  
    <Pos,PPresent2 PrPerf,PPers1,Pl> => dashteh ++ "Aym" ;
    <Pos,PPresent2 PrPerf,PPers2,Sg> => dashteh ++ "Ay" ;
    <Pos,PPresent2 PrPerf,PPers2,Pl> => dashteh ++ "Ayd" ;
    <Pos,PPresent2 PrPerf,PPers3,Sg> =>  dashteh ++ "Ast" ;
    <Pos,PPresent2 PrPerf,PPers3,Pl> => dashteh ++ "And" ;
    
    <Pos,PPresent2 PrImperf,PPers1,Sg> => dar + "m" ;
    <Pos,PPresent2 PrImperf,PPers1,Pl> => dar + "ym" ;
    <Pos,PPresent2 PrImperf,PPers2,Sg> => dar + "y" ;
    <Pos,PPresent2 PrImperf,PPers2,Pl> => dar + "yd" ;
    <Pos,PPresent2 PrImperf,PPers3,Sg> => dar + "d" ;
    <Pos,PPresent2 PrImperf,PPers3,Pl> => dar + "nd" ;
    
    
    <Pos,PPast2 PstPerf,PPers1,Sg> => dashteh ++ "bvdm" ;
    <Pos,PPast2 PstPerf,PPers1,Pl> => dashteh ++ "bvdym" ;
    <Pos,PPast2 PstPerf,PPers2,Sg> => dashteh ++ "bvdy" ;
    <Pos,PPast2 PstPerf,PPers2,Pl> => dashteh ++ "bvdyd" ;
    <Pos,PPast2 PstPerf,PPers3,Sg> => dashteh ++ "bvd" ;
    <Pos,PPast2 PstPerf,PPers3,Pl> => dashteh ++ "bvdnd" ;
    
    <Pos,PPast2 PstImperf,PPers1,Sg> => dasht + "m" ;
    <Pos,PPast2 PstImperf,PPers1,Pl> => dasht + "ym" ;
    <Pos,PPast2 PstImperf,PPers2,Sg> => dasht  + "y";
    <Pos,PPast2 PstImperf,PPers2,Pl> => dasht + "yd" ;
    <Pos,PPast2 PstImperf,PPers3,Sg> => dasht ;
    <Pos,PPast2 PstImperf,PPers3,Pl> => dasht + "nd" ;
    
    <Pos,PPast2 PstAorist,PPers1,Sg> => dasht + "m" ;
    <Pos,PPast2 PstAorist,PPers1,Pl> => dasht + "ym" ;
    <Pos,PPast2 PstAorist,PPers2,Sg> => dasht  + "y";
    <Pos,PPast2 PstAorist,PPers2,Pl> => dasht + "yd" ;
    <Pos,PPast2 PstAorist,PPers3,Sg> => dasht ;
    <Pos,PPast2 PstAorist,PPers3,Pl> => dasht + "nd" ;
    
   
    <Pos,PFut2 FtAorist,PPers1,Sg> => khah + "m"  ++ dasht  ;
    <Pos,PFut2 FtAorist,PPers1,Pl> => khah + "ym"  ++ dasht ;
    <Pos,PFut2 Ftorist,PPers2,Sg> => khah + "y"  ++ dasht ;
    <Pos,PFut2 FtAorist,PPers2,Pl> => khah + "yd"  ++ dasht ;
    <Pos,PFut2 FtAorist,PPers3,Sg> => khah + "d"  ++ dasht ;
    <Pos,PFut2 FtAorist,PPers3,Pl> => khah + "nd"  ++ dasht  ;
    
    
    <Pos,Infr_Past2 InfrPerf,PPers1,Sg> => dashteh ++ bvdh ++ "Am" ;
    <Pos,Infr_Past2 InfrPerf,PPers1,Pl> => dashteh ++ bvdh ++ "Aym" ;
    <Pos,Infr_Past2 InfrPerf,PPers2,Sg> => dashteh ++ bvdh ++ "Ay" ;
    <Pos,Infr_Past2 InfrPerf,PPers2,Pl> => dashteh ++ bvdh ++ "Ayd" ;
    <Pos,Infr_Past2 InfrPerf,PPers3,Sg> => dashteh ++ bvdh ++ "Ast" ;
    <Pos,Infr_Past2 InfrPerf,PPers3,Pl> => dashteh ++ bvdh ++ "And" ;
    
    <Pos,Infr_Past2 InfrImperf,PPers1,Sg> => dashteh ++ "Am" ;
    <Pos,Infr_Past2 InfrImperf,PPers1,Pl> => dashteh ++ "Aym" ;
    <Pos,Infr_Past2 InfrImperf,PPers2,Sg> => dashteh ++ "Ay" ;
    <Pos,Infr_Past2 InfrImperf,PPers2,Pl> => dashteh ++ "Ayd" ;
    <Pos,Infr_Past2 InfrImperf,PPers3,Sg> => dashteh ++ "Ast" ;
    <Pos,Infr_Past2 InfrImperf,PPers3,Pl> => dashteh ++ "And" ;
    
 -- negatives
 
    <Neg,PPresent2 PrPerf,PPers1,Sg> => ndashteh ++ "Am" ;  
    <Neg,PPresent2 PrPerf,PPers1,Pl> => ndashteh ++ "Aym" ;
    <Neg,PPresent2 PrPerf,PPers2,Sg> => ndashteh ++ "Ay" ;
    <Neg,PPresent2 PrPerf,PPers2,Pl> => ndashteh ++ "Ayd" ;
    <Neg,PPresent2 PrPerf,PPers3,Sg> =>  ndashteh ++ "Ast" ;
    <Neg,PPresent2 PrPerf,PPers3,Pl> => ndashteh ++ "And" ;
    
    <Neg,PPresent2 PrImperf,PPers1,Sg> => ndar + "m" ;
    <Neg,PPresent2 PrImperf,PPers1,Pl> => ndar + "ym" ;
    <Neg,PPresent2 PrImperf,PPers2,Sg> => ndar + "y" ;
    <Neg,PPresent2 PrImperf,PPers2,Pl> => ndar + "yd" ;
    <Neg,PPresent2 PrImperf,PPers3,Sg> => ndar + "d" ;
    <Neg,PPresent2 PrImperf,PPers3,Pl> => ndar + "nd" ;
    
    
    <Neg,PPast2 PstPerf,PPers1,Sg> => ndashteh ++ "bvdm" ;
    <Neg,PPast2 PstPerf,PPers1,Pl> => ndashteh ++ "bvdym" ;
    <Neg,PPast2 PstPerf,PPers2,Sg> => ndashteh ++ "bvdy" ;
    <Neg,PPast2 PstPerf,PPers2,Pl> => ndashteh ++ "bvdyd" ;
    <Neg,PPast2 PstPerf,PPers3,Sg> => ndashteh ++ "bvd" ;
    <Neg,PPast2 PstPerf,PPers3,Pl> => ndashteh ++ "bvdnd" ;
    
    <Neg,PPast2 PstImperf,PPers1,Sg> => ndasht + "m" ;
    <Neg,PPast2 PstImperf,PPers1,Pl> => ndasht + "ym" ;
    <Neg,PPast2 PstImperf,PPers2,Sg> => ndasht  + "y";
    <Neg,PPast2 PstImperf,PPers2,Pl> => ndasht + "yd" ;
    <Neg,PPast2 PstImperf,PPers3,Sg> => ndasht ;
    <Neg,PPast2 PstImperf,PPers3,Pl> => ndasht + "nd" ;
    
    <Neg,PPast2 PstAorist,PPers1,Sg> => ndasht + "m" ;
    <Neg,PPast2 PstAorist,PPers1,Pl> => ndasht + "ym" ;
    <Neg,PPast2 PstAorist,PPers2,Sg> => ndasht  + "y";
    <Neg,PPast2 PstAorist,PPers2,Pl> => ndasht + "yd" ;
    <Neg,PPast2 PstAorist,PPers3,Sg> => ndasht ;
    <Neg,PPast2 PstAorist,PPers3,Pl> => ndasht + "nd" ;
    
   
    <Neg,PFut2 FtAorist,PPers1,Sg> => nkhah + "m"  ++ dasht  ;
    <Neg,PFut2 FtAorist,PPers1,Pl> => nkhah + "ym"  ++ dasht ;
    <Neg,PFut2 Ftorist,PPers2,Sg> => nkhah + "y"  ++ dasht ;
    <Neg,PFut2 FtAorist,PPers2,Pl> => nkhah + "yd"  ++ dasht ;
    <Neg,PFut2 FtAorist,PPers3,Sg> => nkhah + "d"  ++ dasht ;
    <Neg,PFut2 FtAorist,PPers3,Pl> => nkhah + "nd"  ++ dasht  ;
    
    
    <Neg,Infr_Past2 InfrPerf,PPers1,Sg> => ndashteh ++ bvdh ++ "Am" ;
    <Neg,Infr_Past2 InfrPerf,PPers1,Pl> => ndashteh ++ bvdh ++ "Aym" ;
    <Neg,Infr_Past2 InfrPerf,PPers2,Sg> => ndashteh ++ bvdh ++ "Ay" ;
    <Neg,Infr_Past2 InfrPerf,PPers2,Pl> => ndashteh ++ bvdh ++ "Ayd" ;
    <Neg,Infr_Past2 InfrPerf,PPers3,Sg> => ndashteh ++ bvdh ++ "Ast" ;
    <Neg,Infr_Past2 InfrPerf,PPers3,Pl> => ndashteh ++ bvdh ++ "And" ;
    
    <Neg,Infr_Past2 InfrImperf,PPers1,Sg> => ndashteh ++ "Am" ;
    <Neg,Infr_Past2 InfrImperf,PPers1,Pl> => ndashteh ++ "Aym" ;
    <Neg,Infr_Past2 InfrImperf,PPers2,Sg> => ndashteh ++ "Ay" ;
    <Neg,Infr_Past2 InfrImperf,PPers2,Pl> => ndashteh ++ "Ayd" ;
    <Neg,Infr_Past2 InfrImperf,PPers3,Sg> => ndashteh ++ "Ast" ;
    <Neg,Infr_Past2 InfrImperf,PPers3,Pl> => ndashteh ++ "And" 
    
     
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
             st + "Ah" => str ;
	     st + "vh" => str ;
	     st + "h" => str ++ "y" ;
	     st + "Av" => str ;
	     st + "vv" => str ;
	     st + "v" => str + "y" ;
	     st + "A" => str + "y" ;
	     _ => str
	};
mkEnclic : Str -> Str ;
mkEnclic str = case str of {
                 st + "A" => str ++ "yy" ;
	         st + "v" => str ++ "yy" ;
		 st + "y" => str ++ "yy" ;
		 st + "h" => str ++ "yy" ;
	                _ => str + "y"
	};
		
IndefArticle : Str ;
IndefArticle = "yk";
taryn : Str ;
taryn = "tryn" ;

---------------
-- making negatives
---------------
addN : Str -> Str ;
addN str = 
            case str of { 
	       "A" + st => "ny" + str ;  
	       "A:" + st => "nyA" + st ;
	         _  => "n" + str
       };
addBh2 : Str -> Str ; -- should use drop instead but it gives linking error
addBh2 str1 =
       case str1 of {
            "my" + str => 
                case  str of { 
	           "A" + st => Prelude.glue "by" str ;  -- need to use '+' but it gives linking error
	           "A:" + st => Prelude.glue "byA" st ;
	            _    => Prelude.glue "b" str
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

 partNP : Str -> Str = \str -> (Prelude.glue str "h") ++ "Cdh" ;
-- partNP : Str -> Str = \str ->  str + "h" ++ "Cdh" ;

       
  
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
    AgPes Sg PPers1   => "Kvdm" ;
    AgPes Sg PPers2   => "Kvdt" ;
    AgPes Sg PPers3   => "KvdC" ;
    AgPes Pl PPers1   => "KvdmAn" ;
    AgPes Pl PPers2   => "KvdtAn" ;
    AgPes Pl PPers3   => "KvdCAn" 
    
    } ;
    
  getPron : Animacy -> Number -> Str = \ani,number ->
   case <ani,number> of {
    <Animate,Sg> => "Av" ;
    <Animate,Pl> => ["A:n hA"] ;
    <Inanimate,Sg> => "A:n" ;
    <Inanimate,Pl> => ["A:n hA"] 
   };
   

}

