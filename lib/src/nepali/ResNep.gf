--# -path=.:../abstract:../common:../../prelude
--
--1 Pnbu auxiliary operations.
--
-- This module contains operations that are needed to make the
-- resource syntax work. 

resource ResNep = ParamX  ** open Prelude, Predef in {

  flags optimize=all ;
  coding = utf8;

  param 
    Case = Nom | Acc | Ins | Dat | Abl | Loc ;
    Gender = Masc | Fem ;
	VTense = NPresent | NPast PTypes | NFuture FTypes;
    PTypes = Simpl | Hab | Unknown ;
    FTypes  = Defin | NDefin ;
    NPerson = Pers1 
	    | Pers2_L
	    | Pers2_M
	    | Pers2_H
	    | Pers3_L
        | Pers3_M
        | Pers3_H ;
		
	Order = ODir | OQuest ;
	
--2 For $Relative$
 
    RAgr = RNoAg | RAg Agr ;
    RCase = RC Number Case ;

-- for Numerial
   
   CardOrd = NCard | NOrd ;

------------------------------------------
--Verbs
-------------------------------------------
      
    VerbForm =
      VF VTense Aspect Polarity NPerson Number Gender
       | Root -- Root form 'kha' is the root of 'khanu'
       | Inf  -- Infinitive form 'khanau'
       | ProgRoot Aspect Number Gender
       | PVForm  -- Partial verb form 'khan' is teh PVForm of 'khanu'
       | Imp ;
      
  -- Aspect Perfective and non-perfective
    Aspect = Perf | Imperf ; 
  
  oper
    -- Noun = {s : Number => Case => Str ; g : Gender ; isHum : Bool } ; -- TODO ADD HUMAN/NON-HUMAN CASE
    Noun = {s : Number => Case => Str ; g : Gender } ;
 
    Verb = {s : VerbForm => Str} ;

    Preposition = {s : Str};

--    DemPronForm = {s : Number => Gender => Case => Str};
--    PossPronForm = {s : Number => Gender => Case => Str};
    --Determiner = {s : Number => Gender => Str ; n : Number};
    
    Determiner = {s : Number => Gender => Str ; n : Number};


-- Nepali Adjectives

   npAdjective = {s : Number => Gender => Str} ;

   mkAdjnp : Str -> npAdjective = \str ->
     case str of {
        st + "ो" => mkAdj1 str (st+"ी") (st+"ा") ;
        _        => mkAdj1 str str str
        } ;
   
   mkAdj1 : (x1,_,x3 : Str) -> npAdjective = 
     \sm, sf, smf -> {
        s = table {
            Sg => table {
                Masc => sm ;
                Fem  => sf 
            } ;
            Pl => table {
                Masc => smf ;
                Fem  => smf 
            } 
        }
     };


-- Reflective Pronoun
  --eg. (i will do myself)
  reflPron : Str;
  reflPron = "आफैं"; -- आफैं
  
  eko : Str;
  eko = "एको";
  
  eka : Str;
  eka = "एका";
  
  sbvn : Str;
  sbvn = "सबँन्धा" ;
  
  ----------------------------------------------------------
  -- Grammar part
  ----------------------------------------------------------
  
  param
    Agr = Ag Gender Number NPerson ;
    NPCase = NPC Case | NPObj | NPErg ;

  oper

    
    np2pronCase : (Case => Str) -> NPCase -> Agr -> Str = 
      \ppf,npc,a -> case npc of {
        NPC c => ppf ! c ;
        NPObj => ppf ! Nom ;
        NPErg => ppf ! Ins --Nom ++ "ले" 
        } ;
    
    
	toNP : (Case => Str) -> NPCase -> Str = \pn, npc -> case npc of {
      NPC c => pn ! c ;
      NPObj => pn ! Nom ;
      NPErg => pn ! Ins --Nom ++ "ले"
      } ;
	
    -- ???? Hardcorded gender and Number
    -- this/these
    detcn2NP : (Determiner) -> Noun -> NPCase -> Number -> Str = \dt,cn,npc,nn -> case npc of {
       NPC c => dt.s ! dt.n ! Masc ++ cn.s ! nn ! c ;
       NPObj => dt.s ! dt.n ! Masc ++ cn.s ! nn ! Nom ;
       NPErg => dt.s ! dt.n ! Masc ++ cn.s ! nn ! Ins --Nom ++ "ले"
       } ;  
    
    det2NP : (Determiner) -> NPCase -> Str = \dt,npc -> case npc of {
       NPC c => dt.s ! dt.n ! Masc ;
       NPObj => dt.s ! dt.n ! Masc ;
       NPErg => dt.s ! dt.n ! Masc ++ "ले"
      } ;    

------------------------------------
-- Agreement transformations
------------------------------------

  oper

    toAgr : Number -> NPerson -> Gender -> Agr = \n,p,g ->       
	   Ag g n p;
      
    
    fromAgr : Agr -> {n : Number ; p : NPerson ; g : Gender} = 
      \a -> case a of {
       Ag g n p => {n = n ; p = p ; g = g} 
	   } ;
	
      
	conjAgr : Agr -> Agr -> Agr = \a0,b0 -> 
      let a = fromAgr a0 ; b = fromAgr b0 
      in
      toAgr
        (conjNumber a.n b.n)
        b.p a.g;	  
	
	
    giveNumber : Agr -> Number = \a -> case a of {
	   Ag _ n _ => n
	};
    
	giveGender : Agr -> Gender = \a -> case a of {
	   Ag g _ _ => g
	};
        
    defaultAgr : Agr = agrP3 Masc Sg ;
    
    agrP3 : Gender -> Number -> Agr = 
      \g,n -> Ag g n Pers3_L ;	
    
    personalAgr : Agr = agrP1 Masc Sg ;
    
    agrP1 : Gender -> Number -> Agr = 
      \g,n -> Ag g n Pers1 ;
	
 param
      CPolarity = 
       CPos
       | CNeg Bool ;  -- contracted or not

 oper
    contrNeg : Bool -> Polarity -> CPolarity = 
     \b,p -> case p of {
       Pos => CPos ;
       Neg => CNeg b
       } ;


	NP : Type = {s : NPCase => Str ; a : Agr} ;

   
 param
    CTense = CPrsnt | CPast | CFuture ;
    
  -- if the noun is of type occupation/Introductiary case it will take ho, instead of chh (in case of present)   
  oper 
    copula : CTense -> Polarity -> Number -> NPerson -> Gender -> Str = 
      \t, po, n, pn, g -> 
      case <t,po,pn,n,g> of {
        -- Resembles with "मकँफरेणफृेग" function for positive
        -- <CPrsnt, Pos,      _,  _, _>  => mkVPreNPReg "" Pos pn n g ;
        -- Present Positive
        <CPrsnt, Pos, Pers1,   Sg,   _>  => "छु" ; -- छु 
        <CPrsnt, Pos, Pers1,   Pl,   _>  => "छौं" ; -- छौं      
        <CPrsnt, Pos, Pers2_L, Sg, Masc> => "छस्" ; -- छस्
        <CPrsnt, Pos, Pers2_L, Sg, Fem>  => "छेस्" ; -- छेस्      
        <CPrsnt, Pos, Pers2_L, Pl,   _>  => "छौ" ; -- छौ 
        <CPrsnt, Pos, Pers2_M, Pl, Fem>  => "छ्यौ" ;  -- छ्यौ
        <CPrsnt, Pos, Pers2_M,  _,   _>  => "छौ" ; -- छौ      
        <CPrsnt, Pos, Pers3_L, Sg, Masc> => "छ" ;  -- छ
        <CPrsnt, Pos, Pers3_L, Sg, Fem>  => "छे" ;  -- छे
        <CPrsnt, Pos, Pers3_L, Pl,   _>  => "छन्" ;  -- छन्      
        <CPrsnt, Pos, Pers3_M, Sg, Fem>  => "छिन्" ;  -- छिन्
        <CPrsnt, Pos, Pers3_M, _,    _>  => "छन्" ;  -- छन्      
        <CPrsnt, Pos,      _ , _,    _>  => "हुनुहुन्छ" ; --हुनुहुन्छ
          
        -- Present Negative
        <CPrsnt, Neg, Pers1,   Sg,   _>  => "छैनँ" ; -- छैनँ
        <CPrsnt, Neg, Pers1,   Pl,   _>  => "छैनौं" ; -- छैनौं
        <CPrsnt, Neg, Pers2_L, Sg,   _>  => "छैनस्" ; -- छैनस्
        <CPrsnt, Neg, Pers2_L, Pl,   _>  => "छैनौ" ; -- छैनौ
	    <CPrsnt, Neg, Pers2_M,  _,   _>  => "छैनौ" ; -- छैनौ        
        <CPrsnt, Neg, Pers3_L, Sg,   _>  => "छैन" ; --छैन
        <CPrsnt, Neg, Pers3_L, Pl,   _>  => "छैनन्" ; -- छैनन्
        <CPrsnt, Neg, Pers3_M,  _,   _>  => "छैनन्" ; -- छैनन्
        <CPrsnt, Neg,       _,  _,   _>  => "हुनुहुन्‌न" ; -- हुनुहुन्‌न
        
        -- Resemples with "मकँफसतशफघेन" case, should refactor to make it
        -- take common function
        
        -- Past Positive
        <CPast, Pos, Pers1,   Sg,    _> => "थिएँ" ; -- थिएँ
        <CPast, Pos, Pers1,   Pl,    _> => "थियौँ" ; -- थियौँ          
        <CPast, Pos, Pers2_L, Sg,    _> => "थिइस्" ; -- थिइस्
        <CPast, Pos, Pers2_L, Pl,    _> => "थियौ" ; -- थियौ
        <CPast, Pos, Pers2_M,  _,    _> => "थियौ" ; -- थियौ          
        <CPast, Pos, Pers3_L, Sg, Masc> => "थियो" ; -- थियो
        <CPast, Pos, Pers3_L, Sg, Fem>  => "थिई" ; --थिई
        <CPast, Pos, Pers3_L, Pl,   _>  => "थिए" ; -- थिए
        <CPast, Pos, Pers3_M, Sg, Fem>  => "थिइन्" ; -- थिइन्
        <CPast, Pos, Pers3_M,  _,   _>  => "थिए" ; -- थिए
        <CPast, Pos,       _,  _,   _>  => "हुनुहुन्‌थ्यो" ; -- हुनुहुन्‌थ्यो 
        
        -- Past Positive
        <CPast, Neg, Pers1,   Sg,    _> => "थिनँ" ; -- थिनँ
        <CPast, Neg, Pers1,   Pl,    _> => "थेनौं" ; -- थेनौं
        <CPast, Neg, Pers2_L, Sg,    _> => "थिनस्" ; -- थिनस्        
        <CPast, Neg, Pers2_L, Pl,    _> => "थेनौ" ; -- थेनौ
        <CPast, Neg, Pers2_M,  _,    _> => "थेनौ" ; -- थेनौ        
        <CPast, Neg, Pers3_L, Sg, Masc> => "थेन" ; -- थेन
        <CPast, Neg, Pers3_L, Sg, Fem>  => "थिन" ; --थिन        
        <CPast, Neg, Pers3_L, Pl,   _>  => "थेनन्" ; -- थेनन्
        <CPast, Neg, Pers3_M, Sg, Fem>  => "थिनन्" ; -- थिनन्
        <CPast, Neg, Pers3_M,  _,   _>  => "थेनन्" ; -- थेनन्
        <CPast, Neg,       _,  _,   _>  => "हुनुहुन्‌नथ्यो" ; -- हुनुहुन्‌नथ्यो  
        
        
        -- Can be covered by the function "मकँऊुतधणफ"
        -- Future Positive
        <CFuture, Pos, Pers1,   Sg,   _>  => "हुनेछु" ; -- हुनेछु
        <CFuture, Pos, Pers1,   Pl,   _>  => "हुनेछौं" ; -- हुनेछौं      
        <CFuture, Pos, Pers2_L, Sg,   _>  => "हुनेछस्" ; -- हुनेछस्
        <CFuture, Pos, Pers2_L, Pl,   _>  => "हुनेछौं" ; -- हुनेछौ
        <CFuture, Pos, Pers2_M,  _,   _>  => "हुनेछौं" ; -- हुनेछौ               
        <CFuture, Pos, Pers3_L, Sg,   _>  => "हुनेछ" ; -- हुनेछ
        <CFuture, Pos, Pers3_L, Pl,   _>  => "हुनेछन्" ; -- हुनेछन्      
        <CFuture, Pos, Pers3_M,  _, Masc> => "हुनेछन्" ; -- हुनेछन्
        <CFuture, Pos, Pers3_M, Sg, Fem>  => "हुनेछन्" ; -- हुनेछिन्      
        <CFuture, Pos, Pers3_M, Pl, Fem>  => "हुनेछन्" ; -- हुनेछन्            
        <CFuture, Pos,       _,  _,   _>  => "हुनुहुनेछ" ; -- हुनुहुनेछ      
          
        -- Negative Case
        <CFuture, Neg, Pers1,   Sg,   _>  => "हुनेछैन" ; -- हुनेछैन
        <CFuture, Neg, Pers1,   Pl,   _>  => "हुनेछैनैँ" ; -- हुनेछैनैँ
        <CFuture, Neg, Pers2_L, Sg,   _>  => "हुनेछैनस्" ; -- हुनेछैनस्
        <CFuture, Neg, Pers2_L, Pl,   _>  => "हुनेछैनै" ; -- हुनेछैनै
        <CFuture, Neg, Pers2_M,  _,   _>  => "हुनेछैनै" ; -- हुनेछैनै           
        <CFuture, Neg, Pers3_L, Sg,   _>  => "हुनेछैन्" ; -- हुनेछैन्
        <CFuture, Neg, Pers3_L, Pl,   _>  => "हुनेछैनन्" ; -- हुनेछैनन्
        <CFuture, Neg, Pers3_M, Sg,   _>  => "हुनेछैनन्" ; -- हुनेछैनन्          
        <CFuture, Neg, Pers3_M, Pl,   _>  => "हुनेछैनै" ; -- हुनेछैनै
        <CFuture, Neg,       _,  _,   _>  => "हुनुहुनेछैन्" -- हुनुहुनेछैन्
    } ;
    
    -- For Human, occupation/Introductiary case case, (HAVENT INTEGRATED YET)
    copulaOpn : CTense -> Polarity -> Number -> NPerson -> Gender -> Str = 
      \t, po, n, pn, g -> 
      case <t,po,pn,n,g> of {
        -- Resembles with "मकँफरेणफृेग" function for positive
        -- <CPrsnt, Pos,      _,  _, _>  => mkVPreNPReg "" Pos pn n g ;
        -- Present Positive
        <CPrsnt, Pos, Pers1,   Sg,   _>  => "हुँ" ; -- हुँ
        <CPrsnt, Pos, Pers1,   Pl,   _>  => "हौँ" ; -- हौँ
        <CPrsnt, Pos, Pers2_L, Sg,   _> => "होस्" ; -- होस्
        --<CPrsnt, Pos, Pers2_L, Sg, Fem>  => "होस्" ; -- छेस्      
        <CPrsnt, Pos, Pers2_L, Pl,   _>  => "हौ" ; -- हौ
        --<CPrsnt, Pos, Pers2_M, Pl, Fem>  => "छ्यौ" ;  -- छ्यौ
        <CPrsnt, Pos, Pers2_M,  _,   _>  => "हौ" ; --  हौ
        <CPrsnt, Pos, Pers3_L, Sg, Masc> => "हो" ;  -- हो
        --<CPrsnt, Pos, Pers3_L, Sg, Fem>  => "हुन्" ; -- हुन्
        <CPrsnt, Pos, Pers3_L,  _,   _>  => "हुन्" ;  -- हुन्     
        --<CPrsnt, Pos, Pers3_M, Sg, Fem>  => "हौ" ;  -- हौ
        <CPrsnt, Pos, Pers3_M, _,    _>  => "हौ" ;  -- हौ
        <CPrsnt, Pos,      _ , _,    _>  => "हुनुहुन्छ" ; --हुनुहुन्छ
          
        -- Present Negative
        <CPrsnt, Neg, Pers1,   Sg,   _>  => "हैन" ; -- 
        <CPrsnt, Neg, Pers1,   Pl,   _>  => "हैनौं" ; -- हैनौं
        <CPrsnt, Neg, Pers2_L, Sg,   _>  => "हैनस्" ; -- हैनस्
        <CPrsnt, Neg, Pers2_L, Pl,   _>  => "हैनौ" ; -- हैनौ
	    <CPrsnt, Neg, Pers2_M,  _,   _>  => "हैनौ" ; -- हैनौ        
        <CPrsnt, Neg, Pers3_L, Sg,   _>  => "हैन" ; --हैन
        <CPrsnt, Neg, Pers3_L, Pl,   _>  => "हैनन्" ; -- हैनन्
        <CPrsnt, Neg, Pers3_M,  _,   _>  => "हैनन्" ; -- हैनन्
        <CPrsnt, Neg,       _,  _,   _>  => "हुनुहुन्‌न" ; -- हुनुहुन्‌न
        
        <_,_,_,_,_> => copula t po n pn g 
        } ;
    

 
  param
     
    VPHTense = 
       VPGenPres  -- impf hum       nahim    "ी गो"
     | VPSmplPast  -- impf Ta        nahim    "ी ौेनत"
	 | VPFut      -- fut            na/nahim "ी सहालल गो"
     | VPPerfPres -- perf hum       na/nahim "ी हावे गोने"
     | VPPerfPast -- perf Ta        na/nahim "ी हाद गोने"          
	 | VPPerfFut
     | VPCondPres     -- subj           na       "ी माय गो"
     | VPCondPast     -- subj           na       "ी माय गो"
     ;

    {-
    VPHForm = 
       VPTense VPPTense Aspect Agr -- 9 * 12
     | VPReq
     | VPImp
     | VPReqFut
     | VPInf
     | VPStem
     ;
   -}
        
    VType = VIntrans | VTrans | VTransPost ;

  oper
    
	objVType : VType -> NPCase = \vt -> 
     case vt of {
       VTrans => NPObj ;
       _      => NPC Nom
       } ;

    VPH : Type = {
      s    : VerbForm => {inf : Str} ;
      obj  : {s : Str ; a : Agr} ; 
      subj : VType ;
      comp : Agr => Str;
      inf : Str;
      ad  : Str;
      embComp : Str ;
      } ;
	
	VPHSlash = VPH ** {c2 : Compl} ;
    Compl : Type = {s : Str ; c : VType} ;

    predV : Verb -> VPH = \verb -> 
     {s = \\vf => 
	   case vf of {
	     VF t a pl p n g => {inf = verb.s ! VF t a pl p n g } ;
	     Root => {inf = verb.s ! Root } ;
         Inf => {inf = verb.s ! Inf } ;
	     Imp => {inf = verb.s ! Imp } ;
         PVForm => {inf = verb.s ! PVForm } ;
         ProgRoot a n g => {inf = verb.s ! ProgRoot a n g }  
		 };
	    obj = {s = [] ; a = defaultAgr} ;
		subj = VIntrans ;
        inf = verb.s ! Inf;
		ad = [];
        embComp = [];
        comp = \\_ => []
      } ;

    predVc : (Verb ** {c2,c1 : Str}) -> VPHSlash = \verb -> 
    predV verb ** {c2 = {s = verb.c1 ; c = VTrans} } ;

       
{-
-------------------------
-- added for cauitives
    predVcc : (Verb **{c2:Compl}) -> VPHSlash = \verb ->
    predV verb ** {c2 = {s = "" ; c = VTrans} } ;
------------------------
-}	 
{-       
    pya : Gender -> Number -> Str = \g,n -> 
	   (mkAdj1 "पया").s ! n ! g ! Dir ;	   

	cka : Gender -> Number -> Str = \g,n -> 
	  (mkAdj1 "छका").s ! n ! g ! Dir ;
	  
	hw : PPerson -> Number -> Str = \pp,n ->    
	 case <pp,n> of {
	 <Pers1,_> => "हौौाण";
	 <Pers2_Casual,Sg>    => "हौौयण";
	 <Pers2_Casual,Pl>    => "हौौ";
	 <Pers2_Respect,_>    => "हौौ";
	 <Pers3_Distant,Sg>    => "हौौै";
	 <Pers3_Distant,Pl>    => "हौन";
	 <Pers3_Near,Sg>    => "हौौै";
	 <Pers3_Near,Pl>    => "हौन"
	 
	 };
	-} 
    
	predAux : Aux -> VPH = \verb -> {
     s = \\vh => 
       let  
		 inf  = verb.inf ;
         part = verb.ppart ;
       in
       case vh of {
	      VF NPresent  _ pl p n g => {inf = copula CPrsnt pl n p g } ;
	      VF (NPast _) _ pl p n g => {inf = copula CPast pl n p g } ;
	      VF (NFuture _) _ pl p n g => {inf = copula CFuture pl n p g } ;
		  Root => { inf = verb.inf} ;
          Inf => {inf = verb.inf} ;
	      Imp => {inf = verb.inf} ;
          ProgRoot a n g => {inf = "" } ; 
          PVForm => {inf = ""} 
        };
       obj = {s = [] ; a = defaultAgr} ;
       subj = VIntrans ;
       inf = verb.inf;
       ad = [];
       embComp = [];
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
    
  raha : VTense -> Aspect -> Gender -> Number -> NPerson -> {s:Str} = \t,a,g,n,p -> {
    s = case <t,a,g,n,p> of {
      <NPresent,Perf,Masc,Sg,Pers1> => "इरहन्" ;
      <_,_,_,_,_> => "इरहन्" 
      }
    } ;

  predProg : VPH -> VPH = \verb -> {
     s = \\vh => 
       case vh of {
         VF NPresent a pl p n g => {inf =  (verb.s ! ProgRoot a n g).inf ++ copula CPrsnt pl n p g } ;
         VF (NPast _) a pl p n g => {inf = (verb.s ! ProgRoot a n g).inf ++ copula CPast pl n p g } ;
         VF (NFuture _) a pl p n g => {inf = (verb.s ! ProgRoot a n g).inf ++ copula CFuture pl n p g } ;
		 Root => {inf = (verb.s ! Root).inf } ;
         Inf => {inf = (verb.s ! ProgRoot Imperf Sg Masc).inf } ;
	     Imp => {inf = (verb.s ! Imp).inf } ;
         PVForm => {inf = (verb.s ! PVForm).inf } ;
         ProgRoot a n g => {inf = (verb.s ! ProgRoot a n g).inf } 
		 };
      obj = verb.obj ;
      subj =  VIntrans ;
      inf = verb.inf;
      ad = verb.ad;
      embComp = verb.embComp;
      comp = verb.comp 
      } ;
   
   Clause : Type = {s : VPHTense => Polarity => Order => Str} ;
      
   -- TODO, ERGATIVE CASE FROM NOUN INFLETION
   mkClause : NP -> VPH -> Clause = \np,vp -> {
      s = \\vt,b,ord => 
        let 
          subjagr : NPCase * Agr = case vt of {
             VPSmplPast  => case vp.subj of {
               VTrans     => <NPErg, vp.obj.a> ;
               VTransPost => <NPErg, defaultAgr> ;
               _          => <NPC Nom, np.a>
             } ;
             
             VPPerfPast  => case vp.subj of {
               VTrans     => <NPErg, vp.obj.a> ;
               VTransPost => <NPErg, defaultAgr> ;
               _          => <NPC Nom, np.a>
             } ;

            _ => <NPC Nom, np.a>
            } ;
          subj = subjagr.p1 ;
          agr  = subjagr.p2 ;
		  n    = (fromAgr agr).n;
		  p    = (fromAgr agr).p;
		  g    = (fromAgr agr).g;
          vps  = case <vt,b> of {
			   <VPGenPres,Pos>  => vp.s ! VF NPresent Imperf Pos p n g ;
               <VPGenPres,Neg>  => vp.s ! VF NPresent Imperf Neg p n g ;
               <VPFut,Pos>      => vp.s ! VF (NFuture Defin) Imperf Pos p n g ;
               <VPFut,Neg>      => vp.s ! VF (NFuture Defin) Imperf Neg p n g ;
               <VPSmplPast,Pos> => vp.s ! VF (NPast Simpl) Imperf Pos p n g ;
               <VPSmplPast,Neg> => vp.s ! VF (NPast Simpl) Imperf Neg p n g ;
               
               <VPPerfPres,Pos> => vp.s ! VF NPresent Perf Pos p n g ;
               <VPPerfPres,Neg> => vp.s ! VF NPresent Perf Neg p n g ;
               <VPPerfPast,Pos> => vp.s ! VF (NPast Simpl) Perf Pos p n g ;
               <VPPerfPast,Neg> => vp.s ! VF (NPast Simpl) Perf Neg p n g ;
               <VPPerfFut,Pos>  => vp.s ! VF (NFuture Defin) Perf Pos p n g ;
               <VPPerfFut,Neg>  => vp.s ! VF (NFuture Defin) Perf Neg p n g ;
  
                <VPCondPres, Pos> => vp.s ! VF (NFuture Defin) Imperf Pos p n g ;
                <VPCondPres, Neg> => vp.s ! VF (NFuture Defin) Imperf Neg p n g ;
                <VPCondPast, Pos> => vp.s ! VF (NFuture Defin) Imperf Pos p n g ;
                <VPCondPast, Neg> => vp.s ! VF (NFuture Defin) Imperf Neg p n g 
                {-
                <_,   Pos>         => vp.s !  VF (NFuture Defin) Imperf Pos p n g  ;
                <_,   Neg>         => vp.s !  VF (NFuture Defin) Imperf Neg p n g                  
				-}
                };
				    
          quest =
            case ord of
              { ODir => [];
                OQuest => "के" }; 
		  
        in
		quest ++ np.s ! subj ++ vp.ad ++ vp.obj.s ++ vp.comp ! np.a  ++  vps.inf ++ vp.embComp
		--quest ++ np.s ! subj ++ vp.ad ++ vp.comp ! np.a ++ vp.obj.s ++ vps.inf ++ vp.embComp
      } ;

 
  mkSClause : Str -> Agr -> VPH -> Clause =
    \subj,agr,vp -> {
      s = \\t,b,ord => 
        let 
		  n    = (fromAgr agr).n;
		  p    = (fromAgr agr).p;
		  g    = (fromAgr agr).g;
          vps  = case <t,b> of {
			   <VPGenPres,Pos>  => vp.s ! VF NPresent Imperf Pos p n g ;
               <VPGenPres,Neg>  => vp.s ! VF NPresent Imperf Neg p n g ;
               <VPFut,Pos>      => vp.s ! VF (NFuture Defin) Imperf Pos p n g ;
               <VPFut,Neg>      => vp.s ! VF (NFuture Defin) Imperf Neg p n g ;
               <VPSmplPast,Pos> => vp.s ! VF (NPast Simpl) Imperf Pos p n g ;
               <VPSmplPast,Neg> => vp.s ! VF (NPast Simpl) Imperf Neg p n g ;
               
               <VPPerfPres,Pos> => vp.s ! VF NPresent Perf Pos p n g ;
               <VPPerfPres,Neg> => vp.s ! VF NPresent Perf Neg p n g ;
               <VPPerfPast,Pos> => vp.s ! VF (NPast Simpl) Perf Pos p n g ;
               <VPPerfPast,Neg> => vp.s ! VF (NPast Simpl) Perf Neg p n g ;
               <VPPerfFut,Pos>  => vp.s ! VF (NFuture Defin) Perf Pos p n g ;
               <VPPerfFut,Neg>  => vp.s ! VF (NFuture Defin) Perf Neg p n g ;
  
                <VPCondPres, Pos> => vp.s ! VF (NFuture Defin) Imperf Pos p n g ;
                <VPCondPres, Neg> => vp.s ! VF (NFuture Defin) Imperf Neg p n g ;
                <VPCondPast, Pos> => vp.s ! VF (NFuture Defin) Imperf Pos p n g ;
                <VPCondPast, Neg> => vp.s ! VF (NFuture Defin) Imperf Neg p n g 
                {-
                <_,   Pos>         => vp.s !  VF (NFuture Defin) Imperf Pos p n g  ;
                <_,   Neg>         => vp.s !  VF (NFuture Defin) Imperf Neg p n g                  
				-}
                };
				    
          quest =
            case ord of
              { ODir => [];
                OQuest => "के" }; 
		  
        in
		quest ++ subj ++ vp.obj.s ++ vp.ad ++ vp.comp ! agr  ++  vps.inf ++ vp.embComp
	--	quest ++ subj ++ vp.ad ++ vp.comp ! agr ++ vp.obj.s ++ vps.inf ++ vp.embComp
      } ;
 {-   
    insertSubj : PPerson -> Str -> Str = \p,s -> 
      case p of { Pers1 => s ++ "ौण" ; _ => s ++ "ै"};
-}     
    insertObj : (Agr => Str) -> VPH -> VPH = \obj1,vp -> {
     s = vp.s ;
     obj = vp.obj ;
     subj = vp.subj ;
	 inf = vp.inf;
	 ad = vp.ad;
     embComp = vp.embComp;
     comp = \\a =>    vp.comp ! a  ++ obj1 ! a 
     } ;

     insertVV : {s:Agr => Str} -> VPH -> Str -> VPH -> VPH = \obj1,vp,emb,vp2 -> {
      s = vp.s ;
--    obj = vp.obj ;
      obj = vp2.obj ;
      subj = vp.subj ;
	  inf = vp.inf;
	  ad = vp.ad;
      embComp = vp.embComp ++ emb; 
--    comp = \\a => vp.comp ! a  ++ obj1.s ! a
      comp = \\a => obj1.s ! a ++  vp.comp ! a  
      } ;
     
    insertObj2 : (Str) -> VPH -> VPH = \obj1,vp -> {
     s = vp.s;
     obj = vp.obj ;
     subj = vp.subj ;
	 inf = vp.inf;
	 ad = vp.ad;
     embComp = vp.embComp ++ obj1;
     comp = vp.comp     
     } ;
     	 
    insertObjc : (Agr => Str) -> VPHSlash -> VPHSlash = \obj,vp -> 
    insertObj obj vp ** {c2 = vp.c2} ;

    insertObjc2 : Str -> VPHSlash -> VPHSlash = \obj,vp -> 
    insertObj2 obj vp ** {c2 = vp.c2} ;

	infVP : Bool -> VPH -> {s:Agr => Str} = \isAux,vp ->
     {s= \\a => vp.obj.s ++ (vp.s! PVForm).inf ++ vp.comp ! a };

    infVV :  VPH -> {s:Agr => Str} = \vp -> {
      s = \\ agr => vp.comp ! agr ++ (vp.s ! PVForm) . inf
      } ; 


    infV2V :  VPH -> {s :Agr => Str} = \vp -> {
      s = \\agr => vp.comp ! agr ++ (vp.s ! PVForm).inf --++ "लाइ"    
      } ; 
    
    insertObject : NP -> VPHSlash -> VPH = \np,vps -> {
      s = vps.s ;
      obj =  {s =  np.s ! objVType vps.c2.c   ++  vps.c2.s ++ vps.obj.s ; a = np.a} ;
 --      obj =  {s =  vps.obj.s ; a = np.a} ;
	    --_     => {s =  vps.obj.s  ++ np.s ! objVType vps.c2.c ; a = np.a}
	    ---};
      subj = vps.c2.c ;
	  inf = vps.inf;
	  ad = vps.ad;
      embComp = vps.embComp;
      comp = vps.comp
--     comp = \\a => vps.comp ! a ++ np.s ! (objVType vps.c2.c) ++ vps.c2.s
      } ;
	  
	insertObjPre : (Agr => Str) -> VPHSlash -> VPH = \obj,vp -> {
     s = vp.s ;
     obj = vp.obj ;
     inf = vp.inf ;
     subj = vp.subj ;
	 ad = vp.ad ;
     embComp = vp.embComp;
     comp = \\a =>   obj ! a  ++ vp.c2.s ++ vp.comp ! a 
    } ;

    insertAdV : Str -> VPH -> VPH = \ad,vp -> {
     s = vp.s ;
     obj = vp.obj ;
     inf = vp.inf ;
	 subj = vp.subj;
     ad  = vp.ad ++ ad ;
     embComp = vp.embComp;
     comp = vp.comp
    } ;
    
    conjThat : Str = "की" ; -- की
    
    {-
    checkPron : NP -> Str -> Str = \np,str ->  case (np.isPron) of {
                                True => np.s ! NPC Obl;
                                False => np.s ! NPC Obl ++ str} ;
	-}	
    insertEmbCompl : VPH -> Str -> VPH = \vp,emb -> {
     s = vp.s ;
     obj = vp.obj ;
     inf = vp.inf ;
     subj = vp.subj;
     ad  = vp.ad;
     embComp = vp.embComp ++ emb;
     comp = vp.comp
    } ;
        
    insertTrans : VPH -> VType -> VPH = \vp,vtype -> {
      s = vp.s ;
      obj = vp.obj ;
      inf = vp.inf ;
      subj = case vtype of {
             VIntrans => VTransPost ; 
             VTrans   => VTrans ; 
             _        => vtype
             } ; 
      ad  = vp.ad;
      embComp = vp.embComp ;
      comp = vp.comp
      } ;
 }
