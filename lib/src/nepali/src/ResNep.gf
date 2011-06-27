--# -path=.:../abstract:../common:../../prelude
--
--1 Nep auxiliary operations.
--  by Dinesh Simkhada and Shafqat Virk - 2011
--
-- This module contains operations that are needed to make the
-- resource syntax work. 

resource ResNep = ParamX  ** open Prelude, Predef in {

  flags optimize=all ;
  coding = utf8;

  param 
    Case = Nom | Acc | Ins | Dat | Abl | Loc ;
    Gender = Masc | Fem ;
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
  	VTense = NPresent | NPast PTypes | NFuture FTypes;
    PTypes = Simpl | Hab ; -- Unknown - Currently we didn't find the use of 'Unknown' type
    FTypes = Defin | NDefin ;    
  
    VerbForm =
      VF VTense Aspect Polarity NPerson Number Gender
       | Root -- Root form, 'kha' is the root of 'khanu'
       | Inf  -- Infinitive form 'khanau'
       | ProgRoot Aspect Number Gender
       | PVForm  -- Partial verb form 'khan' is teh PVForm of 'khanu'
       | Imp ;
      
  -- Aspect Perfective and non-perfective
    Aspect = Perf | Imperf ; 
    
    -- For distinguishing the type of noun
    -- Prefessions/Occupations, Humans all mapped to Living category
    NType = Living | NonLiving ;

  
  oper
  
    Noun = {s : Number => Case => Str ; g : Gender ; t : NType ; h : NPerson } ;
 
    Verb = {s : VerbForm => Str} ;

    Preposition = {s : Str};
  
    Determiner = {s : Number => Gender => Str ; n : Number};

-- Nepali Adjectives

   npAdjective = {s : Number => Gender => Str} ;

   mkAdjnp : Str -> npAdjective = \str ->
     case str of {
        st + t@"t" + "o" => mkAdj1 str str (st+t+"a") ; -- No Fem for red [couple of places which takes Fem but no general rule]
        st + "o"         => mkAdj1 str (st+"I") (st+"a") ;
        _                => mkAdj1 str str str
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
  -- Functions used at NounNep [TODO: inflection at morphological level and attach with VP might be good option]
  reflPron : Str ;
  reflPron = "APEM" ; -- आफैं
  
  eko : Str ;
  eko = "e:ko" ;
  
  eko : Str ;
  eki = "e:kI" ;
  
  eka : Str ;
  eka = "e:ka" ;
  
  sbvn : Str ;
  sbvn = "sbBnx:da" ;
  
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
       NPErg => ppf ! Ins --Nom ++ "le" 
       } ;    
    
	toNP : (Case => Str) -> NPCase -> Str = \pn, npc -> case npc of {
       NPC c => pn ! c ;
       NPObj => pn ! Nom ;
       NPErg => pn ! Ins --Nom ++ "le"
       } ;
	
    detcn2NP : (Determiner) -> Noun -> NPCase -> Number -> Str = \dt,cn,npc,nn -> case npc of {
       NPC c => dt.s ! dt.n ! Masc ++ cn.s ! nn ! c ;
       NPObj => dt.s ! dt.n ! Masc ++ cn.s ! nn ! Nom ;
       NPErg => dt.s ! dt.n ! Masc ++ cn.s ! nn ! Ins --Nom ++ "le"
       } ;  
    
    det2NP : (Determiner) -> NPCase -> Str = \dt,npc -> case npc of {
       NPC c => dt.s ! dt.n ! Masc ;
       NPObj => dt.s ! dt.n ! Masc ;
       NPErg => dt.s ! dt.n ! Masc ++ "le"
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
      toAgr (conjNumber a.n b.n) b.p a.g;	  
	
	
    giveNumber : Agr -> Number = 
     \a -> case a of {
	   Ag _ n _ => n
       } ;
    
	giveGender : Agr -> Gender = 
     \a -> case a of {
	   Ag g _ _ => g
	   } ;
        
    defaultAgr : Agr = agrP3 Masc Sg ;
    
    agrP3 : Gender -> Number -> Agr = 
      \g,n -> Ag g n Pers3_L ;	
    
    agrP1 : Gender -> Number -> Agr = 
      \g,n -> Ag g n Pers1 ;
    
    personalAgr : Agr = agrP1 Masc Sg ;
    
    	
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

    NP : Type = {s : NPCase => Str ; a : Agr ; t : NType } ;
   

  param
     
    VPHTense = 
       VPGenPres                   -- impf hum       nahim    "I go"
     | VPSmplPast  --# notpresent  -- impf Ta        nahim    "I went"
	 | VPFut       --# notpresent  -- fut            na/nahim "I shall go"
     | VPPerfPres                  -- perf hum       na/nahim "I have gone"
     | VPPerfPast  --# notpresent  -- perf Ta        na/nahim "I had gone"          
	 | VPPerfFut   --# notpresent
     | VPCondPres                  -- subj           na       "I may go"
     | VPCondPast  --# notpresent  -- subj           na       "I may go"
     ;
       
    VType = VIntrans | VTrans | VTransPost ;
    
    -- Tense defined for coupla case
    CTense = CPrsnt | CPast | CFuture ;

  
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


	predAux :  NType -> VPH =\ctype ->  {
      s = \\vh => 
       case vh of {
	      VF NPresent _ pl p n g =>  
             case ctype of { 
               Living => {inf = copulaPrLvng pl n p g } ;
	           _      => {inf = copulaPrGen  pl n p g }
               } ;
	      VF (NPast _) _ pl p n g => {inf = copulaPsGen pl n p g } ;
	      VF (NFuture _) _ pl p n g => {inf = copulaFtGen pl n p g } ;
	      
          Root => { inf = ""} ;
          Inf=> {inf = ""} ;
	      Imp => {inf = ""} ;
          ProgRoot a n g => {inf = "" } ; 
          PVForm => {inf = ""} 
        };
       obj = {s = [] ; a = defaultAgr} ;
       subj = VIntrans ;
       inf = "";
       ad = [];
       embComp = [];
       comp = \\_ => []
       } ;
 

  predProg : VPH -> VPH = \verb -> {
     s = \\vh => 
       case vh of {
         VF NPresent a pl p n g => {inf =  (verb.s ! ProgRoot a n g).inf ++ copulaPrGen pl n p g} ;
         VF (NPast _) a pl p n g => {inf = (verb.s ! ProgRoot a n g).inf ++ copulaPsGen pl n p g} ; --# notpresent
         VF (NFuture _) a pl p n g => {inf = (verb.s ! ProgRoot a n g).inf ++ copulaFtGen pl n p g} ; --# notpresent
		 
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
      
   -- TODO, ERGATIVE CASE FROM NOUN INFLETION [No Proper grammer resource found]
   mkClause : NP -> VPH -> Clause = \np,vp -> {
      s = \\vt,b,ord => 
        let 
          subjagr : NPCase * Agr = case vt of {
             VPSmplPast   => case vp.subj of {
               VTrans     => <NPErg, vp.obj.a> ;
               VTransPost => <NPErg, defaultAgr> ;
               _          => <NPC Nom, np.a>
               } ;
             
             VPPerfPast   => case vp.subj of {
               VTrans     => <NPErg, vp.obj.a> ;
               VTransPost => <NPErg, defaultAgr> ;
               _          => <NPC Nom, np.a>
               } ;
             _            => <NPC Nom, np.a>
            } ;
            subj = subjagr.p1 ;
            agr  = subjagr.p2 ;
            n    = (fromAgr agr).n;
		    p    = (fromAgr agr).p;
		    g    = (fromAgr agr).g;
            vps  = case <vt,b> of {
               <VPGenPres,Pos>  => vp.s ! VF NPresent Imperf Pos p n g ;
               <VPGenPres,Neg>  => vp.s ! VF NPresent Imperf Neg p n g ;
               <VPFut,Pos>      => vp.s ! VF (NFuture Defin) Imperf Pos p n g ; --# notpresent
               <VPFut,Neg>      => vp.s ! VF (NFuture Defin) Imperf Neg p n g ; --# notpresent
               <VPSmplPast,Pos> => vp.s ! VF (NPast Simpl) Imperf Pos p n g ; --# notpresent
               <VPSmplPast,Neg> => vp.s ! VF (NPast Simpl) Imperf Neg p n g ; --# notpresent
               
               <VPPerfPres,Pos> => vp.s ! VF NPresent Perf Pos p n g ;
               <VPPerfPres,Neg> => vp.s ! VF NPresent Perf Neg p n g ;
               <VPPerfPast,Pos> => vp.s ! VF (NPast Simpl) Perf Pos p n g ; --# notpresent
               <VPPerfPast,Neg> => vp.s ! VF (NPast Simpl) Perf Neg p n g ; --# notpresent
               <VPPerfFut,Pos>  => vp.s ! VF (NFuture Defin) Perf Pos p n g ; --# notpresent
               <VPPerfFut,Neg>  => vp.s ! VF (NFuture Defin) Perf Neg p n g ; --# notpresent
  
                <VPCondPres, Pos> => vp.s ! VF (NFuture Defin) Imperf Pos p n g ;
                <VPCondPres, Neg> => vp.s ! VF (NFuture Defin) Imperf Neg p n g ;
                <VPCondPast, Pos> => vp.s ! VF (NPast Hab) Perf Pos p n g ; --# notpresent
                <VPCondPast, Neg> => vp.s ! VF (NPast Hab) Perf Neg p n g  --# notpresent
                } ;
				    
          quest =
            case ord of
              { ODir => [];
                OQuest => "ke" }; 
		  
        in
		quest ++ np.s ! subj ++ vp.ad ++ vp.obj.s ++ vp.comp ! np.a  ++  vps.inf ++ vp.embComp
		--quest ++ np.s ! subj ++ vp.ad ++ vp.comp ! np.a ++ vp.obj.s ++ vps.inf ++ vp.embComp
      } ;

 
  mkSClause : Str -> Agr -> VPH -> Clause =
    \subj,agr,vp -> {
      s = \\t,b,ord => 
        let 
		  n   = (fromAgr agr).n;
		  p   = (fromAgr agr).p;
		  g   = (fromAgr agr).g;
          vps = case <t,b> of {
			   <VPGenPres,Pos>  => vp.s ! VF NPresent Imperf Pos p n g ;
               <VPGenPres,Neg>  => vp.s ! VF NPresent Imperf Neg p n g ;
               <VPFut,Pos>      => vp.s ! VF (NFuture Defin) Imperf Pos p n g ; --# notpresent
               <VPFut,Neg>      => vp.s ! VF (NFuture Defin) Imperf Neg p n g ; --# notpresent
               <VPSmplPast,Pos> => vp.s ! VF (NPast Simpl) Imperf Pos p n g ; --# notpresent
               <VPSmplPast,Neg> => vp.s ! VF (NPast Simpl) Imperf Neg p n g ; --# notpresent
               
               <VPPerfPres,Pos> => vp.s ! VF NPresent Perf Pos p n g ;
               <VPPerfPres,Neg> => vp.s ! VF NPresent Perf Neg p n g ;
               <VPPerfPast,Pos> => vp.s ! VF (NPast Simpl) Perf Pos p n g ; --# notpresent
               <VPPerfPast,Neg> => vp.s ! VF (NPast Simpl) Perf Neg p n g ; --# notpresent
               <VPPerfFut,Pos>  => vp.s ! VF (NFuture Defin) Perf Pos p n g ; --# notpresent
               <VPPerfFut,Neg>  => vp.s ! VF (NFuture Defin) Perf Neg p n g ; --# notpresent
  
                <VPCondPres, Pos> => vp.s ! VF (NFuture Defin) Imperf Pos p n g ;
                <VPCondPres, Neg> => vp.s ! VF (NFuture Defin) Imperf Neg p n g ;
                <VPCondPast, Pos> => vp.s ! VF (NPast Hab) Perf Pos p n g ; --# notpresent
                <VPCondPast, Neg> => vp.s ! VF (NPast Hab) Perf Neg p n g  --# notpresent
                } ;
				    
          quest =
            case ord of
              { ODir => [];
                OQuest => "ke" }; 
		  
        in
		quest ++ subj ++ vp.obj.s ++ vp.ad ++ vp.comp ! agr  ++  vps.inf ++ vp.embComp
	    --quest ++ subj ++ vp.ad ++ vp.comp ! agr ++ vp.obj.s ++ vps.inf ++ vp.embComp
      } ;

     
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
       obj = vp2.obj ;
       subj = vp.subj ;
	   inf = vp.inf;
	   ad = vp.ad;
       embComp = vp.embComp ++ emb; 
       comp = \\a => obj1.s ! a ++  vp.comp ! a  
       } ;
     
     insertObj2 : (Str) -> VPH -> VPH = \obj1,vp -> {
       s = vp.s;
       obj = vp.obj ;
       subj = vp.subj ;
	   inf = vp.inf;
	   ad = vp.ad;
       embComp = Prelude.glue vp.embComp obj1;
       comp = vp.comp
       } ;
     	 
    insertObjc : (Agr => Str) -> VPHSlash -> VPHSlash = \obj,vp -> 
      insertObj obj vp ** {c2 = vp.c2} ;

    insertObjc2 : Str -> VPHSlash -> VPHSlash = \obj,vp -> 
      insertObj2 obj vp ** {c2 = vp.c2} ;

	infVP : Bool -> VPH -> {s:Agr => Str} = \isAux,vp ->
      {s= \\a => vp.obj.s ++ (vp.s ! PVForm).inf ++ vp.comp ! a };

    infVV :  VPH -> {s:Agr => Str} = \vp -> {
      s = \\ agr => vp.comp ! agr ++ (vp.s ! PVForm).inf
      } ; 


    infV2V :  VPH -> {s :Agr => Str} = \vp -> {
      s = \\agr => vp.comp ! agr ++ (vp.s ! PVForm).inf -- ++ "lai:"    
      } ; 
    
    insertObject : NP -> VPHSlash -> VPH = \np,vps -> {
      s = vps.s ;
      obj =  {s =  np.s ! objVType vps.c2.c ++ vps.c2.s ++ vps.obj.s ; a = np.a} ;
      subj = vps.c2.c ;
	  inf = vps.inf;
	  ad = vps.ad;
      embComp = vps.embComp;
      comp = vps.comp
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
    
    conjThat : Str = "kI" ; -- की
    
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
      
  -- copula cases
  oper    
    -- For Human, occupation/Introductiary case 
    copulaPrLvng :  Polarity -> Number -> NPerson -> Gender -> Str = 
      \po,n,pn,g -> 
      case <po,pn,n,g> of {
        -- Resembles with 'mkVPreNPReg' function for positive --TODO
        -- Present Positive
        <Pos, Pers1,   Sg,   _>  => "huV" ; -- हुँ
        <Pos, Pers1,   Pl,   _>  => "hwV" ; -- हौँ
        <Pos, Pers2_L, Sg,   _> => "hosx:" ; -- होस्
        --<Pos, Pers2_L, Sg, Fem>  => "hosx:" ; -- छेस्      
        <Pos, Pers2_L, Pl,   _>  => "hw" ; -- हौ
        --<Pos, Pers2_M, Pl, Fem>  => "cx:yw" ;  -- छ्यौ
        <Pos, Pers2_M,  _,   _>  => "hw" ; --  हौ
        <Pos, Pers3_L, Sg, Masc> => "ho" ;  -- हो
        <Pos, Pers3_L, Sg, Fem>  => "hunx:" ; -- हुन्
        <Pos, Pers3_L, Pl,   _>  => "hunx:" ;  -- हुन्     
        --<Pos, Pers3_M, Sg, Fem>  => "hunx:" ;  -- हुन्     
        <Pos, Pers3_M, _,    _>  => "hunx:" ;  -- हुन्     --"hw" ;  -- हौ
        <Pos,      _ , _,    _>  => "hunuhunx:c" ; --हुनुहुन्छ
          
        -- Present Negative
        <Neg, Pers1,   Sg,   _>  => "hEn" ; -- 
        <Neg, Pers1,   Pl,   _>  => "hEnwM" ; -- हैनौं
        <Neg, Pers2_L, Sg,   _>  => "hEnsx:" ; -- हैनस्
        <Neg, Pers2_L, Pl,   _>  => "hEnw" ; -- हैनौ
	    <Neg, Pers2_M,  _,   _>  => "hEnw" ; -- हैनौ        
        <Neg, Pers3_L, Sg,   _>  => "hEn" ; --हैन
        <Neg, Pers3_L, Pl,   _>  => "hEnnx:" ; -- हैनन्
        <Neg, Pers3_M,  _,   _>  => "hEnnx:" ; -- हैनन्
        <Neg,       _,  _,   _>  => "hunuhunx:z+n"  -- हुनुहुन्‌न
        } ;
    
    copulaPrGen : Polarity -> Number -> NPerson -> Gender -> Str = 
      \po,n,pn,g -> 
      case <po,pn,n,g> of {
        <Pos, Pers1,   Sg,   _>  => "cu" ; -- छु 
        <Pos, Pers1,   Pl,   _>  => "cwM" ; -- छौं      
        <Pos, Pers2_L, Sg, Masc> => "csx:" ; -- छस्
        <Pos, Pers2_L, Sg, Fem>  => "cesx:" ; -- छेस्      
        <Pos, Pers2_L, Pl,   _>  => "cw" ; -- छौ 
        <Pos, Pers2_M, Pl, Fem>  => "cx:yw" ;  -- छ्यौ
        <Pos, Pers2_M,  _,   _>  => "cw" ; -- छौ      
        <Pos, Pers3_L, Sg, Masc> => "c" ;  -- छ
        <Pos, Pers3_L, Sg, Fem>  => "ce" ;  -- छे
        <Pos, Pers3_L, Pl,   _>  => "cnx:" ;  -- छन्      
        <Pos, Pers3_M, Sg, Fem>  => "cinx:" ;  -- छिन्
        <Pos, Pers3_M, _,    _>  => "cnx:" ;  -- छन्      
        <Pos,      _ , _,    _>  => "hunuhunx:c" ; --हुनुहुन्छ
          
        -- Present Negative
        <Neg, Pers1,   Sg,   _>  => "cEnV" ; -- छैनँ
        <Neg, Pers1,   Pl,   _>  => "cEnwM" ; -- छैनौं
        <Neg, Pers2_L, Sg,   _>  => "cEnsx:" ; -- छैनस्
        <Neg, Pers2_L, Pl,   _>  => "cEnw" ; -- छैनौ
	    <Neg, Pers2_M,  _,   _>  => "cEnw" ; -- छैनौ        
        <Neg, Pers3_L, Sg,   _>  => "cEn" ; --छैन
        <Neg, Pers3_L, Pl,   _>  => "cEnnx:" ; -- छैनन्
        <Neg, Pers3_M,  _,   _>  => "cEnnx:" ; -- छैनन्
        <Neg,       _,  _,   _>  => "hunuhunx:z+n" -- हुनुहुन्‌न
        } ;

    copulaPsGen : Polarity -> Number -> NPerson -> Gender -> Str = 
      \po,n,pn,g -> 
      case <po,pn,n,g> of {
        -- Past Positive
        <Pos, Pers1,   Sg,    _> => "Tie:V" ; -- थिएँ
        <Pos, Pers1,   Pl,    _> => "TiywV" ; -- थियौँ          
        <Pos, Pers2_L, Sg,    _> => "Tii:sx:" ; -- थिइस्
        <Pos, Pers2_L, Pl,    _> => "Tiyw" ; -- थियौ
        <Pos, Pers2_M,  _,    _> => "Tiyw" ; -- थियौ          
        <Pos, Pers3_L, Sg, Masc> => "Tiyo" ; -- थियो
        <Pos, Pers3_L, Sg, Fem>  => "TiI:" ; --थिई
        <Pos, Pers3_L, Pl,   _>  => "Tie:" ; -- थिए
        <Pos, Pers3_M, Sg, Fem>  => "Tii:nx:" ; -- थिइन्
        <Pos, Pers3_M,  _,   _>  => "Tie:" ; -- थिए
        <Pos,       _,  _,   _>  => "hunuhunx:z+Tx:yo" ; -- हुनुहुन्‌थ्यो 
        
        -- Past Positive
        <Neg, Pers1,   Sg,    _> => "TinV" ; -- थिनँ
        <Neg, Pers1,   Pl,    _> => "TenwM" ; -- थेनौं
        <Neg, Pers2_L, Sg,    _> => "Tinsx:" ; -- थिनस्        
        <Neg, Pers2_L, Pl,    _> => "Tenw" ; -- थेनौ
        <Neg, Pers2_M,  _,    _> => "Tenw" ; -- थेनौ        
        <Neg, Pers3_L, Sg, Masc> => "Ten" ; -- थेन
        <Neg, Pers3_L, Sg, Fem>  => "Tin" ; --थिन        
        <Neg, Pers3_L, Pl,   _>  => "Tennx:" ; -- थेनन्
        <Neg, Pers3_M, Sg, Fem>  => "Tinnx:" ; -- थिनन्
        <Neg, Pers3_M,  _,   _>  => "Tennx:" ; -- थेनन्
        <Neg,       _,  _,   _>  => "hunuhunx:z+nTx:yo" -- हुनुहुन्‌नथ्यो  
        } ;
        
        
    copulaFtGen : Polarity -> Number -> NPerson -> Gender -> Str = 
      \po,n,pn,g -> 
      case <po,pn,n,g> of {
         -- Future Positive
        <Pos, Pers1,   Sg,   _>  => "hunecu" ; -- हुनेछु
        <Pos, Pers1,   Pl,   _>  => "hunecwM" ; -- हुनेछौं      
        <Pos, Pers2_L, Sg,   _>  => "hunecsx:" ; -- हुनेछस्
        <Pos, Pers2_L, Pl,   _>  => "hunecwM" ; -- हुनेछौ
        <Pos, Pers2_M,  _,   _>  => "hunecwM" ; -- हुनेछौ               
        <Pos, Pers3_L, Sg,   _>  => "hunec" ; -- हुनेछ
        <Pos, Pers3_L, Pl,   _>  => "hunecnx:" ; -- हुनेछन्      
        <Pos, Pers3_M,  _, Masc> => "hunecnx:" ; -- हुनेछन्
        <Pos, Pers3_M, Sg, Fem>  => "hunecnx:" ; -- हुनेछिन्      
        <Pos, Pers3_M, Pl, Fem>  => "hunecnx:" ; -- हुनेछन्            
        <Pos,       _,  _,   _>  => "hunuhunec" ; -- हुनुहुनेछ      
          
        -- Negative Case
        <Neg, Pers1,   Sg,   _>  => "hunecEn" ; -- हुनेछैन
        <Neg, Pers1,   Pl,   _>  => "hunecEnEV" ; -- हुनेछैनैँ
        <Neg, Pers2_L, Sg,   _>  => "hunecEnsx:" ; -- हुनेछैनस्
        <Neg, Pers2_L, Pl,   _>  => "hunecEnE" ; -- हुनेछैनै
        <Neg, Pers2_M,  _,   _>  => "hunecEnE" ; -- हुनेछैनै           
        <Neg, Pers3_L, Sg,   _>  => "hunecEnx:" ; -- हुनेछैन्
        <Neg, Pers3_L, Pl,   _>  => "hunecEnnx:" ; -- हुनेछैनन्
        <Neg, Pers3_M, Sg,   _>  => "hunecEnnx:" ; -- हुनेछैनन्          
        <Neg, Pers3_M, Pl,   _>  => "hunecEnE" ; -- हुनेछैनै
        <Neg,       _,  _,   _>  => "hunuhunecEnx:" -- हुनुहुनेछैन्
        } ;

}
