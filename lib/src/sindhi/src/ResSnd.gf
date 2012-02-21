--# -path=.:../abstract:../common:../../prelude
--
--1 Sndu auxiliary operations.
--
-- This module contains operations that are needed to make the
-- resource syntax work. 

resource ResSnd = ParamX  ** open Prelude,Predef in {

  flags optimize=all ;
  coding = utf8;

  param 
    Case = Dir | Obl | Voc | Abl ;
    Gender = Masc | Fem ;
	VTense = Subj | Perf | Imperf;
    PPerson = Pers1
	    | Pers2_Casual
	    | Pers2_Respect
	    | Pers3_Near
	    | Pers3_Distant;
		
	Order = ODir | OQuest ;
	
--2 For $Relative$
 
    RAgr = RNoAg | RAg Agr ;
    RCase = RC Number Case ;

-- for Numerial
   
   CardOrd = NCard | NOrd ;
      
    VerbForm4 =
      VF VTense PPerson Number Gender
      | Inf | Inf_Fem | Inf_Obl | Ablative
      | Root ;
     
  oper
    Noun = {s : Number => Case => Str ; g : Gender} ;
    Verb = {s : VerbForm4 => Str} ;
    Preposition = {s : Str};
    DemPronForm = {s : Number => Gender => Case => Str};
   -- PossPronForm = {s : Number => Gender => Case => Str};
    Determiner = {s : Number => Gender => Str ; n : Number};
 
   -----------------------------------------------
   -- Snd Adjectives
   -----------------------------------------------
   Adjective1 = {s : Number => Gender => Case => Str} ;

  mkAdj1 : Str -> Adjective1 ;
  mkAdj1 nyrw = let end = last (nyrw) ;
                   --nyr = if_then_else Str (eq end "y") nyrw (tk 1 nyrw)
				   nyr = (tk 1 nyrw)
                in adj1 (nyrw)    (nyr+"y")  ( nyr+"a") (nyr+"a")  (nyrw)  (nyr+"y")   (nyr+"y")   (nyr+"y")
                        (nyr+"a") (nyr+"n") ( nyr+"a")  (nyr+"a") (nyr+"yWn")  (nyr+"yn")   (nyr+"yn") (nyr+"yWn")  ;
						
						

  adj1 :(x1,_,_,_,_,_,_, _,_,_,_,_,_,_,_, x16 : Str) -> {s : Number => Gender => Case => Str} = 
   \msd,mso,msv,msa, fsd,fso,fsv,fsa, mpd,mpo,mpv,mpa, fpd,fpo,fpv,fpa -> {
    s = table {
     Sg => (cmnAdj msd mso msv msa fsd fso fsv fsa).s ;
     Pl  => (cmnAdj mpd mpo mpv mpa fpd fpo fpv fpa).s
     }
   };
   
 mkAdj2 : Str -> Adjective1 ;
 mkAdj2 young = adj1 (young)    (young)  (young ) (young)  (young)  (young)   (young)  (young) 
                        (young) (young) (young )  (young) (young+"yn")  (young+"yn")   (young+"yn") (young+"yn") ;
						
						

 
  
  mkAdj3 : Str -> Adjective1 ;
  mkAdj3 acank = adj1 acank acank acank acank acank acank acank acank acank acank acank acank acank acank acank acank ;


 cmnAdj : (x1,_,_,_,_,_,_,x8 : Str) -> {s : Gender => Case => Str} = 
      \sd,so,sv,sa, pd,po,pv,pa -> {
      s = table {
      Masc => table {
        Dir => sd ;
        Obl => so ;
        Voc => sv ;
        Abl => sa 
	  } ;
      Fem => table {
        Dir => pd ;
        Obl => po ;
        Voc => pv ;
        Abl => pa 
	  }
      } 
   } ;
 
					 
		 

  RefPron : Str;
  RefPron = "pat'";
  
  ----------------------------------------------------------
  -- Grammar part
  ----------------------------------------------------------
 
  param
    Agr = Ag Gender Number PPerson ;
    NPCase = NPC Case | NPObj | NPErg ;

  oper
    np2pronCase :  (Case => Str) -> NPCase -> Agr -> Str = \ppf,npc,a -> case npc of {
       NPC c => ppf ! c;
       NPObj => ppf ! Obl ;
       NPErg => case (fromAgr a).p of {
           (Pers3_Near|Pers3_Distant) => ppf ! Dir ++ "jy" ;
	   _			     => ppf ! Dir
	   }
      } ;
    
	toNP : ( Case => Str) -> NPCase -> Str = \pn, npc -> case npc of {
      NPC c => pn !  c ;
      NPObj => pn !  Dir ;
      NPErg => pn !  Obl
      } ;
	  
	detcn2NP : (Determiner) -> Noun -> NPCase -> Number -> Str = \dt,cn,npc,nn -> case npc of {
       NPC c => dt.s ! Sg ! Masc ++ cn.s ! nn ! c ;
       NPObj => dt.s ! Sg ! Masc ++ cn.s ! nn ! Dir ;
       NPErg => dt.s ! Sg ! Masc ++ cn.s ! nn ! Obl
      } ;
	  
    det2NP : (Determiner) -> NPCase -> Str = \dt,npc -> case npc of {
       NPC c => dt.s ! Sg ! Masc ;
       NPObj => dt.s ! Sg ! Masc ;
       NPErg => dt.s ! Sg  ! Masc
      } ;    


	  oper
------------------------------------------
-- Agreement transformations
-----------------------------------------
  
  toAgr : Number -> PPerson -> Gender -> Agr = \n,p,g ->       
	   Ag g n p;
      

    fromAgr : Agr -> {n : Number ; p : PPerson ; g : Gender} = \a -> case a of {
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

	NP : Type = {s : NPCase => Str ; a : Agr ; isPron : Bool} ;
 
 param
    CTense = CPresent | CPast | CFuture | CContinuous;
    
  oper 
    copula : CTense -> Number -> PPerson -> Gender -> Str = \t,n,p,g -> 
case <t,n,p,g> of {
<CPresent,Sg,Pers1,Masc > => "T'W";
<CPresent,Sg,Pers1,Fem > => "T'y" ;
<CPresent,Sg,Pers2_Casual,Masc > => "T'W" ;
<CPresent,Sg,Pers2_Casual,Fem > => "T'y" ;
<CPresent,Sg,Pers2_Respect,Masc > => "T'a" ;
<CPresent,Sg,Pers2_Respect,Fem > => "T'yWn" ;
<CPresent,Sg,Pers3_Near,Masc > => "T'W" ;
<CPresent,Sg,Pers3_Near,Fem > => "T'y" ;
<CPresent,Sg,Pers3_Distant,Masc > => "T'W" ;
<CPresent,Sg,Pers3_Distant,Fem > => "T'y" ;
<CPresent,Pl,Pers1,Masc > => "T'a" ;
<CPresent,Pl,Pers1,Fem > => "T'yWn" ;
<CPresent,Pl,Pers2_Casual,Masc > => "T'a" ;
<CPresent,Pl,Pers2_Casual,Fem > => "T'y" ;
<CPresent,Pl,Pers2_Respect,Masc > => "T'a" ;
<CPresent,Pl,Pers2_Respect,Fem > => "T'yWn" ;
<CPresent,Pl,Pers3_Near,Masc > => "T'a" ;
<CPresent,Pl,Pers3_Near,Fem > => "T'yWn" ;
<CPresent,Pl,Pers3_Distant,Masc > => "T'a" ;
<CPresent,Pl,Pers3_Distant,Fem > => "T'yWn" ;
<CPast,Sg,Pers1,Masc > => "h'ym" ;
<CPast,Sg,Pers1,Fem > => "h'ym" ;
<CPast,Sg,Pers2_Casual,Masc > => "h'e'yn" ;
<CPast,Sg,Pers2_Casual,Fem > => "h'e'yn" ;
<CPast,Sg,Pers2_Respect,Masc > => "h'e'W" ;
<CPast,Sg,Pers2_Respect,Fem > => "h'e'yWn" ;
<CPast,Sg,Pers3_Near,_ > => "ah'y" ;
--	<CPast,Sg,Pers3_Near,Fem > => "ah'e'" ;
<CPast,Sg,Pers3_Distant,Masc > => "h'yW" ;
<CPast,Sg,Pers3_Distant,Fem > => "h'e'y" ;

<CPast,Pl,Pers1,Masc > => "h'e'asyn" ;
<CPast,Pl,Pers1,Fem > => "h'yWsyn" ;
<CPast,Pl,Pers2_Casual,_ > => "h'e'a" ;
<CPast,Pl,Pers2_Respect,_ > => "h'yW" ;
<CPast,Pl,Pers3_Near,Masc > => "h'e'a" ;
<CPast,Pl,Pers3_Near,Fem > => "h'e'yWn" ;
<CPast,Pl,Pers3_Distant,Masc > => "h'e'a" ;
<CPast,Pl,Pers3_Distant,Fem > => "h'yWn" ;

<CFuture,Sg,Pers1,Masc > => "h'Wnds" ;
<CFuture,Sg,Pers1,Fem > => "h'Wnds" ;
<CFuture,Sg,Pers2_Casual,Masc > => "h'Wndyn" ;
<CFuture,Sg,Pers2_Casual,Fem > => "h'Wndyn" ;
<CFuture,Sg,Pers2_Respect,Masc > => "h'WndWe' " ;
<CFuture,Sg,Pers2_Respect,Fem > => "h'WndWe' " ;
<CFuture,Sg,Pers3_Near,Masc > => "h'WndW " ;
<CFuture,Sg,Pers3_Near,Fem > => "h'Wndy" ;
<CFuture,Sg,Pers3_Distant,Masc > => "h'WndW " ;
<CFuture,Sg,Pers3_Distant,Fem > => "h'Wndy" ;
<CFuture,Pl,Pers1,Masc > => "h'Wndasyn" ;
<CFuture,Pl,Pers1,Fem > => "h'WndyWnsyn" ;
<CFuture,Pl,Pers2_Casual,Masc > => "h'WndWe' " ;
<CFuture,Pl,Pers2_Casual,Fem > => "h'WndyWyn" ;
<CFuture,Pl,Pers2_Respect,Masc > => "h'WndWe' " ;
<CFuture,Pl,Pers2_Respect,Fem > => "h'WndyWyn" ;
<CFuture,Pl,Pers3_Near,Masc > => "h'Wnda" ;
<CFuture,Pl,Pers3_Near,Fem > => "h'WndyWn" ;
<CFuture,Pl,Pers3_Distant,Masc > => "h'Wnda" ;
<CFuture,Pl,Pers3_Distant,Fem > => "h'WndyWn" ;

<CContinuous,Sg,Pers1,Masc > => "ah'yan" ;
<CContinuous,Sg,Pers1,Fem > => "ah'yan" ;
<CContinuous,Sg,Pers2_Casual,Masc > => "ah'yn" ;
<CContinuous,Sg,Pers2_Casual,Fem > => "ah'yn" ;
<CContinuous,Sg,Pers2_Respect,Masc > => "ah'yW " ;
<CContinuous,Sg,Pers2_Respect,Fem > => "ah'yW " ;
<CContinuous,Sg,Pers3_Near,Masc > => "ah'y " ;
<CContinuous,Sg,Pers3_Near,Fem > => "ah'y" ;
<CContinuous,Sg,Pers3_Distant,Masc > => "ah'y " ;
<CContinuous,Sg,Pers3_Distant,Fem > => "ah'y" ;
<CContinuous,Pl,Pers1,Masc > => "ah'yWn" ;
<CContinuous,Pl,Pers1,Fem > => "ah'yWn" ;
<CContinuous,Pl,Pers2_Casual,Masc > => "ah'yW  " ;
<CContinuous,Pl,Pers2_Casual,Fem > => "ah'yW " ;
<CContinuous,Pl,Pers2_Respect,Masc > => "ah'yW  " ;
<CContinuous,Pl,Pers2_Respect,Fem > => "ah'yW " ;
<CContinuous,Pl,Pers3_Near,Masc > => "ah'n" ;
<CContinuous,Pl,Pers3_Near,Fem > => "ah'n" ;
<CContinuous,Pl,Pers3_Distant,Masc > => "ah'n" ;
<CContinuous,Pl,Pers3_Distant,Fem > => "ah'n" 


} ;
 param
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
      s    : VPHForm => {fin, inf : Str} ;
      obj  : {s : Str ; a : Agr} ; 
      subj : VType ;
      comp : Agr => Str;
      inf : Str;
      ad  : Str;
      embComp : Str ;
      prog : Bool ;
      } ;
	
	VPHSlash = VPH ** {c2 : Compl} ;

 oper
    Compl : Type = {s : Str ; c : VType} ;

   predV : Verb -> VPH = \verb -> {
      s = \\vh => 
	   case vh of {
	     VPTense VPPres (Ag g n p) => {fin = copula CPresent n p g ; inf = verb.s ! VF Subj p n g } ;
		 VPTense VPPast (Ag g n p) => {fin = copula CPast n p g ; inf =verb.s ! VF Perf p n g} ;
		 VPTense VPFutr (Ag g n p) =>  {fin = copula CFuture n p g ; inf =  verb.s ! VF Imperf p n g } ;
		 VPTense VPPerf (Ag g n p) => { fin = [] ; inf = verb.s ! Root ++ cka g n } ; 
		 VPStem => {fin = []  ; inf =  verb.s ! Root};
		 VPInf => {fin = verb.s!Inf_Obl  ; inf =  verb.s ! Root};
		 VPImp => {fin = verb.s!VF Subj Pers3_Near Pl Masc  ; inf =  verb.s ! Root};
		 VPReq => {fin = []  ; inf =  verb.s!VF Subj Pers1 Pl Masc};
		 _ => {fin = [] ; inf = verb.s ! Root} 
		 };
	    obj = {s = [] ; a = defaultAgr} ;
		subj = VIntrans ;
		inf = verb.s ! Inf;
		ad = [];
        embComp = [];
	prog = False ;
        comp = \\_ => []
      } ;

    predVc : (Verb ** {c2,c1 : Str}) -> VPHSlash = \verb -> 
    predV verb ** {c2 = {s = verb.c1 ; c = VTrans} } ;
-------------------------
-- added for cauitives
   predVcc : (Verb **{c2:Compl}) -> VPHSlash = \verb ->
    predV verb ** {c2 = {s = "" ; c = VTrans} } ;
------------------------
	 
    raha : Gender -> Number -> Str = \g,n -> 
	   (mkAdj1 "rya").s ! n ! g ! Dir ;
    rahanDa : Gender -> Number -> Str = \g,n -> 
	   (mkAdj1 "rh'nda").s ! n ! g ! Dir ;	   
	   
    pya : Gender -> Number -> Str = \g,n -> 
	   (mkAdj1 "pya").s ! n ! g ! Dir ;	   

	cka : Gender -> Number -> Str = \g,n -> 
	  (mkAdj1 "gya").s ! n ! g ! Dir ;
	  
	hw : PPerson -> Number -> Str = \pp,n ->    
	 case <pp,n> of {
	 <Pers1,_> => "hwwaN";
	 <Pers2_Casual,Sg>    => "hwwyN";
	 <Pers2_Casual,Pl>    => "hww";
	 <Pers2_Respect,_>    => "hww";
	 <Pers3_Distant,Sg>    => "hwwE";
	 <Pers3_Distant,Pl>    => "hwn";
	 <Pers3_Near,Sg>    => "hwwE";
	 <Pers3_Near,Pl>    => "hwn"
	 
	 };
	 
	predAux : Aux -> VPH = \verb -> {
     s = \\vh => 
       let  

	 inf  = verb.inf ;
         part = verb.ppart ;

       in
       case vh of {
	 VPTense VPPres (Ag g n p) => {fin = copula CContinuous n p g ; inf = part } ;
         VPTense VPPast (Ag g n p) => {fin = copula CPast n p g ; inf = part } ;
         VPTense VPFutr (Ag g n p) => {fin = copula CFuture n p g ; inf = part ++ hw p n  } ;
         VPStem => {fin = []  ; inf = "rh" };
		 _ => {fin = part ; inf = inf }
		 };
	  obj = {s = [] ; a = defaultAgr} ;
      subj = VIntrans ;
      inf = verb.inf;
	  ad = [];
      embComp = [];
      prog = False ;
      comp = \\_ => []
      } ;
    
  Aux = {
      inf,ppart,prpart : Str
    } ;

  auxBe : Aux = {
    inf  = "" ;
    ppart = "" ;
    prpart = ""
    } ;
    
  predProg : VPH -> VPH = \verb -> {
     s = \\vh => 
       case vh of {
         VPTense VPPres (Ag g n p) => {fin = copula CPresent n p g ; inf = (verb.s!VPTense VPPres (Ag g n p)).inf ++ pya g n} ;
         VPTense VPPast (Ag g n p) => {fin = copula CPast n p g ; inf = (verb.s!VPTense VPPres (Ag g n p)).inf ++ pya g n} ;
         VPTense VPFutr (Ag g n p) => {fin = copula CFuture n p g ; inf = (verb.s!VPTense VPPres (Ag g n p)).inf } ;
	 VPTense VPPerf (Ag g n p) => {fin = copula CPast n p g ; inf = (verb.s!VPTense VPPres (Ag g n p)).inf ++ raha g n } ;
         VPStem => {fin = []  ; inf = (verb.s!VPStem).inf };
		 _ => {fin = [] ; inf = [] }
		 };
      obj = verb.obj ;
      subj =  VIntrans ;
      inf = verb.inf;
      ad = verb.ad;
      embComp = verb.embComp;
      prog = True ;
      comp = verb.comp 
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

				    VPGenPres  => vp.s !  VPTense VPPres agr ;
					VPImpPast  => vp.s !  VPTense VPPast agr ;
				    
					VPFut      => case vp.prog of { True => {fin = (vp.s !  VPTense VPFutr agr).fin ; inf = (vp.s !  VPTense VPFutr agr).inf ++ hw p n} ;
					                                _    => vp.s !  VPTense VPFutr agr } ;
					VPContPres => 
					  {fin = copula CContinuous n p g ; inf = (vp.s ! VPTense VPPres agr).inf ++ raha g n } ;
					VPContPast => 
					  {fin = copula CPast n p g ; inf = (vp.s ! VPTense VPPres agr).inf ++ raha g n } ;
					VPContFut  => 
					  {fin = copula CFuture n p g ; inf = (vp.s ! VPTense VPPres agr).inf ++ raha g n } ;
					VPPerfPres =>
					  {fin = copula CContinuous n p g ; inf = (vp.s ! VPTense VPPast agr).inf } ;  
					--  {fin = copula CPresent n p g ; inf = (vp.s ! VPStem).inf ++ cka g n } ;
					VPPerfPast => 
                      -- {fin = copula CPast n p g ; inf = (vp.s ! VPStem).inf ++ cka g n } ;
		                        {fin = copula CPast n p g ; inf = (vp.s ! VPTense VPPast agr).inf } ;  
					VPPerfFut  => 
					  {fin = copula CFuture n p g ; inf = (vp.s ! VPTense VPPast agr).inf } ;
					VPPerfPresCont => 
					  {fin = copula CContinuous n p g ; inf = (vp.s ! VPTense VPFutr agr).inf ++ raha g n} ;					
					VPPerfPastCont => 
					  {fin = copula CPast n p g ; inf = (vp.s ! VPTense VPFutr agr).inf ++ rahanDa g n} ;					
					VPPerfFutCont => 
					  {fin = copula CFuture n p g ; inf = (vp.s ! VPTense VPFutr agr).inf ++ rahanDa g n} ;					
					VPSubj   => case vp.prog of { True => {fin = (vp.s !  VPTense VPFutr agr).inf ++ hw p n ; inf = "Xayd" } ;
					                                _    => {fin = (vp.s !  VPTense VPFutr agr).inf ; inf = "Xayd" } } 
                   
					};
					
		    
          quest =
            case ord of
              { ODir => [];
                OQuest => "c'a" }; 
		  na =
            case b of
              { Pos => [];
                Neg => "n" };
           nahim =
            case b of 
              { Pos => [];
                Neg => "n" };
        in
		case vt of {
		VPSubj => quest ++ np.s ! subj ++ vp.obj.s ++ vp.ad ++ vp.comp ! np.a ++  vps.inf  ++ na ++ vps.fin ++ vp.embComp ;
		_      => quest ++ np.s ! subj ++ vp.obj.s ++ vp.ad ++ vp.comp ! np.a  ++  vps.inf  ++ nahim ++ vps.fin ++ vp.embComp};

  } ;

  mkSClause : Str -> Agr -> VPH -> Clause =
    \subj,agr,vp -> {
      s = \\t,b,ord => 
        let 
		  n    = (fromAgr agr).n;
		  p    = (fromAgr agr).p;
		  g    = (fromAgr agr).g;
          vps  = case t of {
                    VPGenPres  => vp.s !  VPTense VPPres agr ;
					VPImpPast  => vp.s !  VPTense VPPast agr ;
					VPFut      => vp.s !  VPTense VPFutr agr ;
					VPContPres => 
					  {fin = copula CPresent n p g ; inf = (vp.s ! VPStem).inf ++ pya g n  } ;
					VPContPast => 
					  {fin = copula CPast n p g ; inf = (vp.s ! VPStem).inf ++ pya g n } ;
					VPContFut  => 
					  {fin = copula CFuture n p g  ; inf = (vp.s ! VPStem).inf ++ pya g n ++ hw p n  } ;
					VPPerfPres => 
					  {fin = copula CPresent n p g ; inf = (vp.s ! VPStem).inf ++ cka g n } ;
					VPPerfPast => 
                      {fin = copula CPast n p g ; inf = (vp.s ! VPStem).inf ++ cka g n } ;
					VPPerfFut  => 
					  {fin = copula CFuture n p g ; inf = (vp.s ! VPStem).inf ++ cka g n ++ hw p n } ;
					VPPerfPresCont => 
					 {fin = copula CPresent n p g ; inf = (vp.s ! VPStem).inf ++ pya g n } ; 
					VPPerfPastCont => 
					  {fin = copula CPast n p g ; inf = (vp.s ! VPStem).inf ++ pya g n } ; 
					VPPerfFutCont => 
					  {fin = copula CFuture n p g ; inf = (vp.s ! VPStem).inf ++ pya g n ++ hw p n } ;
					VPSubj   => {fin = (vp.s ! VPTense VPPres agr).inf ; inf = "Xayd"  }
                    
					};

		  quest =
            case ord of
              { ODir => [];
                OQuest => "c'a" }; 
		  na =
            case b of
              { Pos => [];
                Neg => "n" };
          nahim =
            case b of 
              { Pos => [];
                Neg => "n" };		
        in
		case t of {
		VPSubj => quest ++ subj ++ vp.obj.s ++ vp.ad ++ vp.comp ! agr  ++  vps.inf ++ na ++ vps.fin ++ vp.embComp;
		_      => quest ++ subj ++ vp.obj.s ++ vp.ad ++ vp.comp ! agr  ++  vps.inf ++ nahim ++  vps.fin ++ vp.embComp};
    } ;
    
    insertSubj : PPerson -> Str -> Str = \p,s -> 
      case p of { Pers1 => s ++ "wN" ; _ => s ++ ""};
     
    insertObj : (Agr => Str) -> VPH -> VPH = \obj1,vp -> {
     s = vp.s ;
     obj = vp.obj ;
     subj = vp.subj ;
	 inf = vp.inf;
	 ad = vp.ad;
     embComp = vp.embComp;
     prog = vp.prog ;
     comp = \\a =>    vp.comp ! a  ++ obj1 ! a 
     } ;
     insertVV : Str -> VPH -> Str -> VPH -> VPH = \obj1,vp,emb,vp2 -> {
     s = vp.s ;
     obj = vp2.obj ;
     subj = vp.subj ;
	 inf = vp.inf;
	 ad = vp.ad;
     embComp = vp.embComp ++ emb; -- this should be covered in urdu as well
     prog = vp.prog ;
     comp = \\a =>    vp.comp ! a  ++ obj1  
     } ;
     
    insertObj2 : (Str) -> VPH -> VPH = \obj1,vp -> {
     s = vp.s;
     obj = vp.obj ;
     subj = vp.subj ;
	 inf = vp.inf;
	 ad = vp.ad;
     embComp = vp.embComp ++ obj1;
     prog = vp.prog ;
     comp = vp.comp
     
     } ;
	 
    insertObjc : (Agr => Str) -> VPHSlash -> VPHSlash = \obj,vp -> 
    insertObj obj vp ** {c2 = vp.c2} ;
    insertObjc2 : Str -> VPHSlash -> VPHSlash = \obj,vp -> 
    insertObj2 obj vp ** {c2 = vp.c2} ;

	infVP : Bool -> VPH -> Agr -> Str = \isAux,vp,a ->
     vp.obj.s ++ vp.inf ++ vp.comp ! a ;
    infVV : Bool -> VPH -> Str = \isAux,vp -> 
        case isAux of {False =>  (vp.comp ! (toAgr Sg Pers1 Masc)) ++ vp.inf  ; True => (vp.comp ! (toAgr Sg Pers1 Masc)) ++ (vp.s ! VPImp).fin  }; -- need to be checked and should be covered in urdu as well
    infV2V : Bool -> VPH -> Str = \isAux,vp -> 
      case isAux of {False =>  (vp.comp ! (toAgr Sg Pers1 Masc)) ++ vp.inf ++ "dy"  ; True => (vp.comp ! (toAgr Sg Pers1 Masc)) ++ (vp.s ! VPImp).fin  ++ "dy"}; -- need to be checked and should be covered in urdu as well  

    insertObject : NP -> VPHSlash -> VPH = \np,vps -> {
      s = vps.s ;
      obj = case np.isPron of { 
            False => {s =  vps.obj.s  ++ np.s ! objVType vps.c2.c ++ vps.c2.s ; a = np.a} ;
	    _     => {s =  vps.obj.s  ++ np.s ! objVType vps.c2.c ++ vps.c2.s ; a = np.a}
	    };
      subj = vps.c2.c ;
	  inf = vps.inf;
	  ad = vps.ad;
      embComp = vps.embComp;
      prog = vps.prog ;
      comp = vps.comp
      } ;
	  
	insertObjPre : (Agr => Str) -> VPHSlash -> VPH = \obj,vp -> {
     s = vp.s ;
     obj = vp.obj ;
     inf = vp.inf ;
     subj = vp.subj ;
	 ad = vp.ad ;
     embComp = vp.embComp;
     prog = vp.prog ;
     comp = \\a =>   obj ! a  ++ vp.c2.s ++ vp.comp ! a 
    } ;

    insertAdV  : Str -> VPH -> VPH = \ad,vp -> {
     s = vp.s ;
     obj = vp.obj ;
     inf = vp.inf ;
	 subj = vp.subj;
     ad  = vp.ad ++ ad ;
     embComp = vp.embComp;
     prog = vp.prog ;
     comp = vp.comp
    } ;
	conjThat : Str = "t" ;
    checkPron : NP -> Str -> Str = \np,str ->  case (np.isPron) of {
                                True => np.s ! NPC Obl;
                                False => np.s ! NPC Obl ++ str} ;
		
    insertEmbCompl : VPH -> Str -> VPH = \vp,emb -> {
     s = vp.s ;
     obj = vp.obj ;
     inf = vp.inf ;
     subj = vp.subj;
     ad  = vp.ad;
     embComp = vp.embComp ++ emb;
     prog = vp.prog ;
     comp = vp.comp
    } ;
    
    insertTrans : VPH -> VType -> VPH = \vp,vtype -> {
     s = vp.s ;
     obj = vp.obj ;
     inf = vp.inf ;
     subj = case vtype of {VIntrans => VTransPost ; VTrans => VTrans ; _ => vtype} ; -- still some problem not working properly
     ad  = vp.ad;
     embComp = vp.embComp ;
     prog = vp.prog ;
     comp = vp.comp
    } ;

}

