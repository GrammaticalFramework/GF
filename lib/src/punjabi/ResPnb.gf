--# -path=.:../abstract:../common:../../prelude
--
--1 Pnbu auxiliary operations.
--
-- This module contains operations that are needed to make the
-- resource syntax work. 

resource ResPnb = ParamX  ** open Prelude,Predef in {

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
  
  -----------------------------------------
  -- Punjabi Pronouns
  -----------------------------------------
  
   Pronoun = P Number Gender Case PPerson;
   PersPronForm = PPF Number PPerson Case;
   
-------------------------------------------
--Verbs
-------------------------------------------

      
    VerbForm4 =
      VF VTense PPerson Number Gender
      | Inf | Inf_Fem | Inf_Obl | Ablative
      | Root ;
      
  oper
    Noun = {s : Number => Case => Str ; g : Gender} ;
    Verb = {s : VerbForm4 => Str} ;
    Preposition = {s : Str};
    DemPronForm = {s : Number => Gender => Case => Str};
    PossPronForm = {s : Number => Gender => Case => Str};
    Determiner = {s : Number => Gender => Str ; n : Number};
  
-- a useful oper
    eq : Str -> Str -> Bool = \s1,s2-> (pbool2bool (eqStr s1 s2)) ;
 
   -----------------------------------------------
   -- Pnb Adjectives
   -----------------------------------------------
   Adjective1 = {s : Number => Gender => Case => Str} ;
--    Adjective2 = {s : Number => Case => Str} ;  


  mkAdj1 : Str -> Adjective1 ;
  mkAdj1 piilaa = let end = last (piilaa) ;
                   piil = if_then_else Str (eq end "ع") piilaa (tk 1 piilaa)
                in adj1 (piilaa)    (piil+"ے")  (variants{piil+"یا"; piil+"ے"}) (piil+"یوں")  (piil+"ے")  (piil+"یاں")   (piil+"یو")   ""
                        (piil+"ی") (piil+"ی") (variants{piil+"ی" ; piil+"یے"})  (piil+"یوں") (piil+"ی")  (piil+"یاں")   (piil+"یو") "" ;

  adj1 :(x1,_,_,_,_,_,_, _,_,_,_,_,_,_,_, x16 : Str) -> {s : Number => Gender => Case => Str} = 
   \msd,mso,msv,msa, mpd,mpo,mpv,mpa, fsd,fso,fsv,fsa, fpd,fpo,fpv,fpa -> {
    s = table {
     Sg => (cmnAdj msd mso msv msa fsd fso fsv fsa).s ;
     Pl  => (cmnAdj mpd mpo mpv mpa fpd fpo fpv fpa).s
     }
   };
 
--  mkAdj2 : Str -> Adjective2 ;
--  mkAdj2 romii = cmnAdj romii romii         (romii+"ا")  (romii+"یوں")
--                        romii (romii++"اں") (romii++"و")  "" ;
  mkAdj3 : Str -> Adjective1 ;
  mkAdj3 lal = adj1 lal lal lal lal lal lal lal lal lal lal lal lal lal lal lal lal ;


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
  RefPron = "خود";
  
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
           (Pers3_Near|Pers3_Distant) => ppf ! Dir ++ "نے" ;
	   _			     => ppf ! Dir
	   }
      } ;
    
	toNP : ( Case => Str) -> NPCase -> Str = \pn, npc -> case npc of {
      NPC c => pn !  c ;
      NPObj => pn !  Dir ;
      NPErg => pn !  Obl ++ "نے"
      } ;
	detcn2NP : (Determiner) -> Noun -> NPCase -> Number -> Str = \dt,cn,npc,nn -> case npc of {
       NPC c => dt.s ! Sg ! Masc ++ cn.s ! nn ! c ;
       NPObj => dt.s ! Sg ! Masc ++ cn.s ! nn ! Dir ;
       NPErg => dt.s ! Sg ! Masc ++ cn.s ! nn ! Obl ++ "نے"
      } ;  
    det2NP : (Determiner) -> NPCase -> Str = \dt,npc -> case npc of {
       NPC c => dt.s ! Sg ! Masc ;
       NPObj => dt.s ! Sg ! Masc ;
       NPErg => dt.s ! Sg  ! Masc ++ "نے"
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
    CTense = CPresent | CPast | CFuture ;
    
  oper 
    copula : CTense -> Number -> PPerson -> Gender -> Str = \t,n,p,g -> 
      case <t,n,p,g> of {
        <CPresent,Sg,Pers1,_   > => "واں" ;
        <CPresent,Sg,Pers2_Casual,_   > => "ایں" ;
	<CPresent,Sg,Pers2_Respect,_   > => "او" ;
        <CPresent,Sg,_,_   > => "اے" ;
--        <CPresent,Sg,Pers3_Distant,_   > => "اے" ;
	<CPresent,Pl,Pers1,_   > => "واں" ;
        <CPresent,Pl,Pers2_Casual,_   > => "او" ;
	<CPresent,Pl,Pers2_Respect,_   > => "او" ;
        <CPresent,Pl,_,_   > => "نے" ;
--        <CPresent,Pl,Pers3_Distant,_   > => "نے" ;
	<CPast,Sg,Pers1,_   > => "ساں" ;
--        <CPast,Sg,Pers2_Casual,Masc   > => "سی" ;
	<CPast,Sg,Pers2_Casual,_   > => "سیں" ;
	<CPast,Sg,Pers2_Respect,_   > => "سو" ;
--	<CPast,Sg,Pers2_Respect,Fem   > => "سیں" ;
        <CPast,Sg,_,_   > => "سی" ;
--	<CPast,Sg,Pers3_Near,Fem   > => "تh-ی" ;
--      <CPast,Sg,Pers3_Distant,_  > => "سی" ;
--	<CPast,Sg,Pers3_Distant,Fem  > => "تh-ی" ;
	<CPast,Pl,Pers1,_   > => "ساں" ;
        <CPast,Pl,Pers2_Casual,_   > => "سو" ;
	<CPast,Pl,Pers2_Respect,_   > => "سو" ;
        <CPast,Pl,_,_   > => "سں" ;
--	<CPast,Pl,Pers3_Distant,_   > => "سن" ;
	<CFuture,Sg,Pers1,Masc   > => "گا" ;
	<CFuture,Sg,Pers1,Fem   > => "گی" ;
        <CFuture,Sg,Pers2_Casual,Masc   > => "گا" ;
	<CFuture,Sg,Pers2_Casual,Fem   > => "گی" ;
	<CFuture,Sg,Pers2_Respect,Masc   > => "گے" ;
	<CFuture,Sg,Pers2_Respect,Fem   > => "گے" ;
        <CFuture,Sg,Pers3_Near,Masc   > => "گا" ;
	<CFuture,Sg,Pers3_Near,Fem   > => "گی" ;
        <CFuture,Sg,Pers3_Distant,Masc  > => "گا" ;
	<CFuture,Sg,Pers3_Distant,Fem  > => "گی" ;
	<CFuture,Pl,Pers1,Masc   > => "گے" ;
	<CFuture,Pl,Pers1,Fem   > => "گیاں" ;
        <CFuture,Pl,Pers2_Casual,Masc   > => "گے" ;
	<CFuture,Pl,Pers2_Casual,Fem   > => "گیاں" ;
	<CFuture,Pl,Pers2_Respect,Masc   > => "گے" ;
	<CFuture,Pl,Pers2_Respect,Fem   > => "گیاں" ;
        <CFuture,Pl,Pers3_Near,Masc   > => "گے" ;
	<CFuture,Pl,Pers3_Near,Fem   > => "گیاں" ;
	<CFuture,Pl,Pers3_Distant,Masc  > => "گے" ;
	<CFuture,Pl,Pers3_Distant,Fem  > => "گیاں" 
        
        
        } ;

 param
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

    Compl : Type = {s : Str ; c : VType} ;

   predV : Verb -> VPH = \verb -> {
      s = \\vh => 
	   case vh of {
	     VPTense VPPres (Ag g n p) => {fin = copula CPresent n p g ; inf = verb.s ! VF Imperf p n g } ;
		 VPTense VPPast (Ag g n p) => {fin = [] ; inf =verb.s ! VF Perf p n g} ;
		 VPTense VPFutr (Ag g n p) =>  {fin = copula CFuture n p g ; inf =  verb.s ! VF Subj p n g } ;
		 VPTense VPPerf (Ag g n p) => { fin = [] ; inf = verb.s ! Root ++ cka g n } ; 
		 VPStem => {fin = []  ; inf =  verb.s ! Root};
		 VPInf => {fin = verb.s!Inf_Obl  ; inf =  verb.s ! Root};
		 VPImp => {fin = verb.s!VF Subj Pers3_Near Pl Masc  ; inf =  verb.s ! Root};
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
	   (mkAdj1 "ریا").s ! n ! g ! Dir ;
    pya : Gender -> Number -> Str = \g,n -> 
	   (mkAdj1 "پیا").s ! n ! g ! Dir ;	   

	cka : Gender -> Number -> Str = \g,n -> 
	  (mkAdj1 "گیا").s ! n ! g ! Dir ;
	  
	hw : PPerson -> Number -> Str = \pp,n ->    
	 case <pp,n> of {
	 <Pers1,_> => "ہوواں";
	 <Pers2_Casual,Sg>    => "ہوویں";
	 <Pers2_Casual,Pl>    => "ہوو";
	 <Pers2_Respect,_>    => "ہوو";
	 <Pers3_Distant,Sg>    => "ہووے";
	 <Pers3_Distant,Pl>    => "ہون";
	 <Pers3_Near,Sg>    => "ہووے";
	 <Pers3_Near,Pl>    => "ہون"
	 
	 };
	 
	predAux : Aux -> VPH = \verb -> {
     s = \\vh => 
       let  

		 inf  = verb.inf ;
         part = verb.ppart ;

       in
       case vh of {
	     VPTense VPPres (Ag g n p) => {fin = copula CPresent n p g ; inf = part } ;
         VPTense VPPast (Ag g n p) => {fin = copula CPast n p g ; inf = part } ;
         VPTense VPFutr (Ag g n p) => {fin = copula CFuture n p g ; inf = part ++ hw p n  } ;
         VPStem => {fin = []  ; inf = "رہ" };
		 _ => {fin = part ; inf = [] }
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
					  {fin = copula CPresent n p g ; inf = (vp.s ! VPStem).inf ++ raha g n } ;
					VPContPast => 
					  {fin = copula CPast n p g ; inf = (vp.s ! VPStem).inf ++ raha g n } ;
					VPContFut  => 
					  {fin = copula CFuture n p g ; inf = (vp.s ! VPStem).inf ++ raha g n ++ hw p n} ;
					VPPerfPres =>
					  {fin = copula CPresent n p g ; inf = (vp.s ! VPTense VPPerf agr).inf } ;  
					--  {fin = copula CPresent n p g ; inf = (vp.s ! VPStem).inf ++ cka g n } ;
					VPPerfPast => 
                      -- {fin = copula CPast n p g ; inf = (vp.s ! VPStem).inf ++ cka g n } ;
		                        {fin = copula CPast n p g ; inf = (vp.s ! VPTense VPPerf agr).inf } ;  
					VPPerfFut  => 
					  {fin = copula CFuture n p g ; inf = (vp.s ! VPTense VPPerf agr).inf  ++ hw p n } ;
					VPPerfPresCont => 
					  {fin = copula CPresent n p g ; inf = (vp.s ! VPTense VPPres agr).inf ++ raha g n } ;					
					VPPerfPastCont => 
					  {fin = copula CPast n p g ; inf = (vp.s ! VPTense VPPres agr).inf ++ raha g n } ;					
					VPPerfFutCont => 
					  {fin = copula CFuture n p g ; inf = (vp.s ! VPTense VPPres agr).inf ++ raha g n  ++ hw p n } ;					
					VPSubj   => case vp.prog of { True => {fin = (vp.s !  VPTense VPFutr agr).inf ++ hw p n ; inf = "شاید" } ;
					                                _    => {fin = (vp.s !  VPTense VPFutr agr).inf ; inf = "شاید" } } 
                   
					};
					
		    
          quest =
            case ord of
              { ODir => [];
                OQuest => "كی" }; 
		  na =
            case b of
              { Pos => [];
                Neg => "نا" };
           nahim =
            case b of 
              { Pos => [];
                Neg => "نیں" };
        in
		case vt of {
		VPSubj => quest ++ np.s ! subj ++ vp.obj.s ++ vp.ad ++ vp.comp ! np.a  ++ na ++  vps.inf ++ vps.fin ++ vp.embComp ;
		_      => quest ++ np.s ! subj ++ vp.obj.s ++ vp.ad ++ vp.comp ! np.a  ++ nahim  ++  vps.inf ++ vps.fin ++ vp.embComp};

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
					VPSubj   => {fin = insertSubj p (vp.s ! VPStem).inf ; inf = "ژاید"  }
                    
					};

		  quest =
            case ord of
              { ODir => [];
                OQuest => "كی" }; 
		  na =
            case b of
              { Pos => [];
                Neg => "نا" };
          nahim =
            case b of 
              { Pos => [];
                Neg => "نیں" };		
        in
		case t of {
		VPSubj => quest ++ subj ++ vp.obj.s ++ vp.ad ++ vp.comp ! agr  ++ na ++  vps.inf ++ vps.fin ++ vp.embComp;
		_      => quest ++ subj ++ vp.obj.s ++ vp.ad ++ vp.comp ! agr  ++ nahim ++  vps.inf ++ vps.fin ++ vp.embComp};
    } ;
    
    insertSubj : PPerson -> Str -> Str = \p,s -> 
      case p of { Pers1 => s ++ "وں" ; _ => s ++ "ے"};
     
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
--     obj = vp.obj ;
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
--      case isAux of {False =>  vp.obj.s ++ (vp.comp ! (toAgr Sg Pers1 Masc)) ++ vp.inf  ; True => vp.obj.s ++ (vp.comp ! (toAgr Sg Pers1 Masc)) ++ (vp.s ! VPImp).fin  }; -- need to be checked and should be covered in urdu as well
        case isAux of {False =>  (vp.comp ! (toAgr Sg Pers1 Masc)) ++ vp.inf  ; True => (vp.comp ! (toAgr Sg Pers1 Masc)) ++ (vp.s ! VPImp).fin  }; -- need to be checked and should be covered in urdu as well
    infV2V : Bool -> VPH -> Str = \isAux,vp -> 
--      case isAux of {False =>  vp.obj.s ++ (vp.comp ! (toAgr Sg Pers1 Masc)) ++ vp.inf ++ "دی"  ; True => vp.obj.s ++ (vp.comp ! (toAgr Sg Pers1 Masc)) ++ (vp.s ! VPImp).fin  ++ "دی"}; -- need to be checked and should be covered in urdu as well
      case isAux of {False =>  (vp.comp ! (toAgr Sg Pers1 Masc)) ++ vp.inf ++ "دی"  ; True => (vp.comp ! (toAgr Sg Pers1 Masc)) ++ (vp.s ! VPImp).fin  ++ "دی"}; -- need to be checked and should be covered in urdu as well  

    insertObject : NP -> VPHSlash -> VPH = \np,vps -> {
      s = vps.s ;
      obj = case np.isPron of { 
            False => {s =  vps.obj.s  ++ np.s ! objVType vps.c2.c ++ vps.c2.s ; a = np.a} ;
	    _     => {s =  vps.obj.s  ++ np.s ! objVType vps.c2.c ; a = np.a}
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

    insertAdV : Str -> VPH -> VPH = \ad,vp -> {
     s = vp.s ;
     obj = vp.obj ;
     inf = vp.inf ;
	 subj = vp.subj;
     ad  = vp.ad ++ ad ;
     embComp = vp.embComp;
     prog = vp.prog ;
     comp = vp.comp
    } ;
	conjThat : Str = "كہ" ;
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

