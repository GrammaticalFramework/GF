--# -path=.:../abstract:../common:../../prelude
--
--1 Hindustaniu auxiliary operations.
--
-- This module contains operations that are needed to make the
-- resource syntax work. 

--resource ResHindustani = ParamX  ** open Prelude,Predef in {
interface ResHindustani = DiffHindustani ** open CommonHindustani, Prelude, Predef in {

  
  flags optimize=all ;
  coding = utf8;
  
param
   
	
--	Order = ODir | OQuest ;
	
--2 For $Relative$
 
    RAgr = RNoAg | RAg Agr ;
    RCase = RC Number Case ;

-- for Numerial
   
   CardOrd = NCard | NOrd ;
  
  -----------------------------------------
  -- Hindustani Pronouns
  -----------------------------------------
  
   Pronoun = P Number Gender Case UPerson;
   PersPronForm = PPF Number UPerson Case;
   
-------------------------------------------
--Verbs
-------------------------------------------

                
  oper
    Noun = {s : Number => Case => Str ; g : Gender} ;

    Preposition = {s : Gender => Str};
    DemPronForm = {s : Number => Gender => Case => Str};
    PossPronForm = {s : Number => Gender => Case => Str};
    Determiner = {s : Number => Gender => Case => Str ; n : Number};
  
-- a useful oper
    eq : Str -> Str -> Bool = \s1,s2-> (pbool2bool (eqStr s1 s2)) ; 

  RefPron : Str;
  RefPron = kwd ;
  
  ----------------------------------------------------------
  -- Grammar part
  ----------------------------------------------------------
  

  toNP : ( Case => Str) -> NPCase -> Str = \pn, npc -> case npc of {
      NPC c => pn !  c ;
      NPObj => pn !  Dir ;
      NPErg => pn !  Obl ++ nE
      } ;
  detcn2NP : (Determiner) -> Noun -> NPCase -> Number -> Str = \dt,cn,npc,nn -> case npc of {
--       NPC c => dt.s ! Sg ! Masc ++ cn.s ! nn ! c ; --changed while phrasebook e.g tyry beti where gender of determiner 'tyry' should be dependent on gender of common noum e.g 'beti' 
       NPC c => dt.s ! nn ! cn.g ! c ++ cn.s ! nn ! c ;
       NPObj => dt.s ! nn ! cn.g ! Obl ++ cn.s ! nn ! Dir ; 
       NPErg => dt.s ! nn ! cn.g ! Obl ++ cn.s ! nn ! Obl ++ nE
      } ;  
  det2NP : (Determiner) -> NPCase -> Str = \dt,npc -> case npc of {
       NPC c => dt.s ! Sg ! Masc ! c ;
       NPObj => dt.s ! Sg ! Masc ! Dir ;
       NPErg => dt.s ! Sg  ! Masc ! Obl ++ nE
      } ;    
	  
------------------------------------------
-- Agreement transformations
-----------------------------------------
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

--	NP : Type = {s : NPCase => Str ; a : Agr} ;

  oper
    
	objVType : VType -> NPCase = \vt -> case vt of {
      VTrans => NPObj ;
      VTransPost => NPC Dir ;
      _ => NPC Obl
      } ;

	VPHSlash = VPH ** {c2 : Compl} ;

    Compl : Type = {s : Str ; c : VType} ;


    predVc : (Verb ** {c2,c1 : Str}) -> VPHSlash = \verb -> 
    predV verb ** {c2 = {s = verb.c1 ; c = VTrans} } ;
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
         VPTense VPPres (Ag g n p) => {fin = copula CPresent n p g ; inf = (verb.s!VPStem).inf ++ raha g n} ;
         VPTense VPPast (Ag g n p) => {fin = copula CPast n p g ; inf = (verb.s!VPStem).inf ++ raha g n} ;
         VPTense VPFutr (Ag g n p) => {fin = copula CFuture n p g ; inf = (verb.s!VPStem).inf ++ raha g n  } ;
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
     insertVV : Str -> VPH -> Str -> VPH = \obj1,vp,emb -> {
     s = vp.s ;
     obj = vp.obj ;
     subj = vp.subj ;
	 inf = vp.inf;
	 ad = vp.ad;
     embComp = vp.embComp ++ emb ;
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
     vp.obj.s ++ vp.comp ! a ++ vp.inf  ;

   infVV : Bool -> VPH -> Str = \isAux,vp -> 
      case isAux of {False =>  vp.obj.s ++ (vp.comp ! (toAgr Sg Pers1 Masc)) ++ vp.inf ; True => (vp.s ! VPImp).inf  ++ vp.obj.s ++ (vp.comp ! (toAgr Sg Pers1 Masc)) } ;
    infV2V : Bool -> VPH -> Str = \isAux,vp -> 
      case isAux of {False =>  vp.obj.s ++ (vp.comp ! (toAgr Sg Pers1 Masc)) ++ (vp.s ! VPInf).fin ++ ky  ; True => vp.obj.s ++ (vp.comp ! (toAgr Sg Pers1 Masc)) ++ (vp.s ! VPImp).fin  ++ ky};


    insertObject : NP -> VPHSlash -> VPH = \np,vps -> {
      s = vps.s ;
      obj = {s =  vps.obj.s  ++ np.s ! objVType vps.c2.c ++ vps.c2.s ; a = np.a} ;
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
    
--	conjThat : Str = "كہ" ;
    
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
     subj = vtype;
     ad  = vp.ad;
     embComp = vp.embComp ;
     prog = vp.prog ;
     comp = vp.comp
    } ;
    
  compoundAdj : Str -> Str -> Adjective = \s1,s2 -> mkCompoundAdj (regAdjective s1) (regAdjective s2) ;
   mkCompoundAdj : Adjective -> Adjective -> Adjective ;
   mkCompoundAdj adj1 adj2 = {s = \\n,g,c,d => adj1.s ! n ! g ! c ! d ++ adj2.s ! n ! g ! c ! d} ;
  

}

