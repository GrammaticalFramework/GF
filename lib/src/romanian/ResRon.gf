--1 Romance auxiliary operations.
--

resource ResRon = ParamX - [Temp,TTAnt,Tense,TPres,TPast,TFut,TCond] ** open Prelude in {

flags optimize= all ;

  
--------------------------------------------------------------------------
----------------------- 1 BASIC PARAMETERS--------------------------------
--------------------------------------------------------------------------


param

  Mood   = Indic | Conjunct ;

  Direct = DDir | DInv ;

-- there are 3 genders in Romanian, the Neuter is a combination of Masculine for Sg and Feminine for Pl
 
  NGender = NMasc | NFem | NNeut ;

-- genders for Agreement, to which the 3 genders ultimately reduce 

  Gender = Masc | Fem ;

-- formal and informal form for numerals (the formal form is used as default)  

  NumF  = Formal | Informal ;
 
-- animacy feature of the nouns, which has consequences on syntactical level
 
  Animacy = Animate | Inanimate ;
  
-- basic forms of the clitics
  
  Clitics = Normal | Composite | Short | Imperative ;  
 
-- special size parameter used for Numerals
 
  Size = sg | less20 | pl ;
 
-- the cases that require clitics :
 
  ParClit = PAcc | PDat  ;

-- parameter that counts the number of clitics in a verb phrase 
  
  VClit = VNone | VOne ParClit | VRefl | VMany ;

-- parameter that specifies whether a preposition would require clitics or not  
  
  PrepDir = Dir ParClit | NoDir ;

-- the 5 cases in Romanian

  NCase = No | Da | Ac | Ge | Vo ;
  
-- the 3 distinct forms of the declension a noun/adjective, based on the syncretism Nominative-Accusative and Dative-Genitive   
  
  ACase = ANomAcc | AGenDat | AVoc ;
  
-- due to the enclitical defined article, a parameter for species is needed 
  
  Species  =  Indef | Def ;
  
-- Adjectives are inflected in number, gender, have specific form for enclitic determined
--article, and specific forms for Nominative-Accusative/Dative-Genitive/Voccative

  AForm = AF Gender Number Species ACase | AA ;

-- Cardinal numerals have gender, ordinal numerals have full number as well.

  CardOrd = NCard Gender | NOrd Gender;

-- Parameter indicating the presence of clitic doubling / referential form for noun phrases

  NForm = HasClit | HasRef Bool ;
  
-------------------------------------------------  
--------------------2 Verbs ---------------------
------------------------------------------------- 


-- the form we build on syntactical level, based on VForm
-- it represents the main verb forms in Romanian
 
param
  
  Temps    = Presn | Imparf | PSimple | PPerfect ;
  TSubj    = SPres ;
  
-- the form we build on morphological level :
  
  VForm    = Inf
           | Indi Temps Number Person 
           | Subjo TSubj Number Person
           | Imper NumPersI
           | Ger
           | PPasse Gender Number Species ACase ;

  TMood    = VPres  Mood | VImperff | VPasse Mood | VFut | VCondit ;

  NumPersI = SgP2 | PlP1 | PlP2 ;

  VPForm   = VPFinite TMood Anteriority
            | VPImperat
            | VPGerund
            | VPInfinit Anteriority Bool ;

  RTense = RPres | RPast | RFut | RCond ;

oper 
 copula    : VerbPhrase = 
    let t = table {Inf => "fi" ;
                Indi Presn Sg P1 => "sunt" ; Indi Presn Sg P2 => "eºti" ; Indi Presn Sg P3 => "este" ;
                Indi Presn Pl P1 => "suntem" ; Indi Presn Pl P2 => "sunteþi" ; Indi Presn Pl P3 => "sunt" ;
                Indi PSimple Sg P1 => "fusei" ; Indi PSimple Sg P2 => "fuseºi" ; Indi PSimple Sg P3 => "fuse" ;
                Indi PSimple Pl P1 => "fuserãm" ; Indi PSimple Pl P2 => "fuserãþi" ; Indi PSimple Pl P3 => "fuserã" ;
                Indi Imparf Sg P1 => "eram" ; Indi Imparf Sg P2 => "erai" ; Indi Imparf Sg P3 => "era" ;
                Indi Imparf Pl P1 => "eram" ; Indi Imparf Pl P2 => "eraþi" ; Indi Imparf Pl P3 => "erau" ;
                Indi PPerfect Sg P1 => "fusesem" ; Indi PPerfect Sg P2 => "fuseseºi" ; Indi PPerfect Sg P3 => "fusese" ;
                Indi PPerfect Pl P1 => "fusesem" ; Indi PPerfect Pl P2 => "fuseseþi" ; Indi PPerfect Pl P3 => "fuseserã" ;
                Subjo SPres Sg P1 => "fiu" ; Subjo SPres Sg P2 => "fii" ; Subjo SPres Sg P3 => "fie" ;
                Subjo SPres Pl P1 => "fim" ; Subjo SPres Pl P2 => "fiþi" ; Subjo SPres Pl P3 => "fie" ;
                Imper SgP2 => "fii" ; Imper PlP2 => "fiþi" ; Imper PlP1 => "fim" ;
                Ger => "fiind"; 
                PPasse g n a d => case <g,n,d,a> of 
                   {<Masc,Sg,ANomAcc,Def> => "fostul"; <Masc,Sg,_,Indef> => "fost";                   <Masc,Sg,AGenDat,Def> => "fostului"; <Masc,Sg,AVoc,Def> => "fostule";  
                   <Masc,Pl,ANomAcc,Def> => "foºtii"; <Masc,Pl,_,Indef> => "foºti";                   <Masc,Pl,_,Def> => "foºtilor"; 
                   <Fem,Sg,ANomAcc,Def> => "fosta"; <Fem,Sg,ANomAcc,Indef> => "fostã";                   <Fem,Sg,AGenDat,Def> => "fostei"; <Fem,Sg,AGenDat,Indef> => "foste";<Fem,Sg,AVoc,Def> => "fosto"; <Fem,Sg,AVoc,Indef> => "fostã";
                   <Fem,Pl,ANomAcc,Def> => "fostele"; <Fem,Pl,_,Indef> => "foste";<Fem,Pl,_,Def> => "fostelor"
                   }                
                } in
  {s = t; isRefl = \\_ => RNoAg; nrClit = VNone ; pReflClit = Composite ;
      isFemSg = False ; neg = table {Pos => "" ; Neg => "nu"} ;
      clAcc = RNoAg ; clDat = RNoAg ; 
      comp  = \\_ => "";  
      ext   = \\_ => ""      
  } ;
  
-- auxiliary for Past Tense :  

 pComp : Number => Person => Str = table {Sg => table {P1 => "am" ; P2 => "ai" ; P3 => "a"} ;
                                         Pl => table {P1 => "am" ; P2 => "aþi"; P3 => "au"}
                                         };
                                         
-- auxiliary for Future Simple :
                                         
 pFut : Number => Person => Str = table  {Sg => table {P1 => "voi" ; P2 => "vei" ; P3 => "va"} ;
                                         Pl => table {P1 => "vom" ; P2 => "veþi"; P3 => "vor"}
                                         };                                          

--auxiliary for Condional Present :

 pCond : Number => Person => Str = table {Sg => table {P1 => "aº" ; P2 => "ai" ; P3 => "ar"} ;
                                         Pl => table {P1 => "am" ; P2 => "aþi"; P3 => "ar"}
                                         };
   
-- short form of the verb, conjunctive present, without the auxiliary
  
 conjVP : VerbPhrase -> Agr -> Str = \vp,agr ->
      let
        inf  = vp.s ! Subjo SPres agr.n agr.p ;
        neg  = vp.neg ! Pos ; 
      in
       neg ++ inf ;      

-- VPC form of the verb, needed for building a clause 

 useVP : VerbPhrase -> VPC = \vp -> 
    let
      verb = vp.s ;
      vinf  : Bool -> Str = \b -> verb ! Inf ;
      vger  = verb ! Ger ;

      vimp : Agr -> Str = \a -> case <a.n,a.p> of 
       {<Sg,P2>  => verb ! Imper SgP2 ;
        <Pl,P2>  => verb ! Imper PlP2 ;
        _        => verb ! Subjo SPres a.n a.p           
       } ;
      vf : Str -> (Agr -> Str) -> {
                      sa : Str ;                    
                      sv : Agr => Str 
                                  } = 
                           \fin,inf -> {
                               sa = fin ; 
                               sv = \\a => inf a
                                       } ;
   

    in {
    s = table {
      VPFinite tm Simul => case tm of 
                             {VPres Indic => vf "" (\a -> verb ! Indi Presn a.n a.p) ;
                              VPres Conjunct => vf "sã" (\a -> verb ! Subjo SPres a.n a.p) ;
                              VImperff  => vf "" (\a -> verb ! Indi Imparf a.n a.p)  ;
                              VPasse  Indic => vf "" (\a -> pComp ! a.n ! a.p ++ verb ! PPasse Masc Sg Indef ANomAcc) ; 
                              VPasse  Conjunct => vf "sã" (\a -> copula.s! Inf ++ verb ! PPasse Masc Sg Indef ANomAcc) ;
                              VFut => vf "" (\a -> pFut ! a.n ! a.p ++ verb ! Inf) ;
                              VCondit => vf "" (\a -> pCond ! a.n ! a.p ++ verb ! Inf) 
                              } ;  
      VPFinite tm Anter => case tm of 
                              {VPres Indic => vf "" (\a -> pComp ! a.n ! a.p ++ verb ! PPasse Masc Sg Indef ANomAcc) ; 
                              (VPres Conjunct | VPasse Conjunct) => vf "sã" (\a -> copula.s! Inf ++ verb ! PPasse Masc Sg Indef ANomAcc) ;
                              VFut => vf "" (\a -> pFut !a.n ! a.p ++ copula.s! Inf ++ verb ! PPasse Masc Sg Indef ANomAcc) ;   
                              VCondit => vf "" (\a -> pCond ! a.n ! a.p ++ copula.s ! Inf ++ verb ! PPasse Masc Sg Indef ANomAcc);
                              _       => vf "" (\a -> verb ! Indi PPerfect a.n a.p) 
                              }; 
      VPInfinit Anter b=> vf "a" (\a -> copula.s ! Inf ++ verb ! PPasse Masc Sg Indef ANomAcc);  
      VPImperat        => vf "sã" (\a -> verb ! Subjo SPres a.n a.p) ; -- fix it later !
      VPGerund         => vf "" (\a -> vger) ;
      VPInfinit Simul b => vf "a" (\a -> verb ! Inf) 
      } ;
    agr    = vp.agr ; 
    neg    = vp.neg ; 
    clitAc  = vp.clAcc ; 
    clitDa  = vp.clDat ; 
    clitRe = RNoAg ; 
    nrClit = vp.nrClit ;
    pReflClit = vp.pReflClit;
    comp   = vp.comp ; 
    ext    = vp.ext 
    } ;       
 
-- basic UseV function 
 
 predV : Verb -> VerbPhrase = \verb -> 
    {
    s = verb.s ; 
    isRefl = verb.isRefl;
    isFemSg = False ;
    nrClit = verb.nrClit ; pReflClit = verb.pReflClit;
    neg    = table {Pos => ""; Neg => "nu"} ;
    clAcc  = RNoAg ; 
    clDat  = RNoAg ; 
    comp   = \\a => [] ;
    ext    = \\p => [] 
    } ;     
            
-- various helper functions for VerbRon     
        
useVerb : Verb -> VerbPhrase =\verb -> 
    {
    s = verb.s ; 
    isRefl = verb.isRefl;
    nrClit = verb.nrClit;
    isFemSg = False ; pReflClit = verb.pReflClit ;
    neg    = table {Pos => ""; Neg => "nu"} ;
    clAcc  = RNoAg ;  nrClit = verb.nrClit; 
    clDat  = RNoAg ; 
    comp   = \\a => [] ;
    ext    = \\p => [] ; 
    lock_V = <>
    } ;
        
 insertExtrapos : (Polarity => Str) -> VerbPhrase -> VerbPhrase = \co,vp -> { 
    s     = vp.s ;
    isFemSg = vp.isFemSg ;
    clAcc = vp.clAcc ; isRefl = vp.isRefl;
    clDat = vp.clDat ; pReflClit = vp.pReflClit ;
    neg   = vp.neg ;
    comp  = vp.comp ; nrClit = vp.nrClit ;
    ext   = \\p => vp.ext ! p ++ co ! p 
    } ;  
 insertObje : (Agr => Str) -> RAgr -> RAgr -> Bool -> VClit -> VerbPhrase -> VerbPhrase = \obj,clA, clD, agg, vc, vp -> {
   s = vp.s ; isRefl = vp.isRefl;
   isFemSg= orB agg vp.isFemSg ; 
   nrClit = vc; pReflClit = vp.pReflClit;
   neg    = table {Pos => ""; Neg => "nu"} ;
   clAcc  = {s = \\cs => vp.clAcc.s ! cs ++ clA.s ! cs };
   clDat  = {s = \\cs => vp.clDat.s ! cs ++ clD.s ! cs };
   comp = \\a => obj ! a ++  vp.comp ! a  ; 
   ext = vp.ext 
    };

 insertSimpObj : (Agr => Str) -> VerbPhrase -> VerbPhrase = \obj,vp -> {
   s = vp.s ; isRefl = vp.isRefl; isFemSg = vp.isFemSg ; neg = vp.neg ;
   clAcc = vp.clAcc ; clDat = vp.clDat ;
   nrClit = vp.nrClit ; pReflClit = vp.pReflClit ;
   comp = \\a => vp.comp ! a ++ obj ! a ; 
   ext = vp.ext 
   };

 insertSimpObjPre : (Agr => Str) -> VerbPhrase -> VerbPhrase = \obj,vp -> {
   s = vp.s ; isRefl = vp.isRefl; isFemSg = vp.isFemSg ; neg = vp.neg ;
   clAcc = vp.clAcc ; clDat = vp.clDat ; pReflClit = vp.pReflClit ;
   nrClit = vp.nrClit ; 
   comp = \\a => obj ! a ++ vp.comp ! a  ;
   ext = vp.ext 
   };
  
insertAdv : Str -> VerbPhrase -> VerbPhrase = \co,vp -> { 
    s     = vp.s ;
    isRefl = vp.isRefl;
    isFemSg = vp.isFemSg ; pReflClit = vp.pReflClit ;
    clAcc = vp.clAcc ; nrClit = vp.nrClit ;
    clDat = vp.clDat ; 
    neg   = vp.neg ; 
    comp  = \\a => vp.comp ! a ++ co ;
    ext   = vp.ext 
    } ;
  
-----------------------------------------------------------------   
---------------3 CATEGORY DEFINITIONS ---------------------------  
-----------------------------------------------------------------
oper 

 Noun = {s : Number => Species => ACase => Str; g : NGender; a : Animacy} ;
 Adj = {s : AForm => Str} ;
 
 Verbe : Type = { s : VForm => Str};
 Verb : Type = {s : VForm => Str ; isRefl : Agr => RAgr; nrClit : VClit ; pReflClit : Clitics};   
 Compl : Type = {s : Str ; c : NCase ; isDir : PrepDir ; needIndef : Bool ; prepDir : Str} ;
 NounPhrase : Type = {s : NCase => {comp : Str ; clit : Clitics => Str} ;
                      a : Agr ; 
                      indForm : Str ; --needed for prepositions that demand the indefinite form of a NP  
                      nForm : NForm ; -- indicates the presence of clitic doubling and referential form
                      isPronoun : Bool -- in the case of pronouns, just the clitics are used, and not the comp form
                     } ;   
 VerbPhrase :Type = {
      s : VForm => Str ;
      isRefl : Agr => RAgr ;             -- the clitics for reflexive verbs
      nrClit : VClit ;                   -- number of clitics of the verb phrase
      pReflClit : Clitics ;              -- clitic parameter for reflexive clitic, in case it is present in the verb phrase, along with another clitic 
      isFemSg : Bool ;                   -- needed for the correct placement of the Accusative clitic    
      neg    : Polarity => Str ;         -- negation
      clAcc  : RAgr ;                    -- clitic for the Accusative case (direct object)
      clDat  : RAgr ;                    -- clitic for the Dative case (indirect object without preposition)
      comp   : Agr => Str ;              -- object of the verb phraes 
      ext    : Polarity => Str ;         -- object sentece of the verb phrase
      } ;
 VPC : Type = {                                  
       s : VPForm => {
        sa :  Str ;                
        sv : Agr => Str                
        } ;           
      neg    : Polarity => Str ; 
      clitAc  : RAgr ;                     
      clitDa  : RAgr ;                     
      clitRe  : RAgr ;        
      nrClit  : VClit ;             
      comp    : Agr => Str ;              
      ext     : Polarity => Str ;         
      } ;    
            
-----------------------------------------------------------------------------
------------------------- 4 CLITICS -----------------------------------------
-----------------------------------------------------------------------------           
oper   
-- for the treatment of clitics 
  
 RAgr : Type = {s : Clitics => Str} ; 

 RNoAg : RAgr = genClit "" "" "" "";

 genClit : (x1,_,_,x4 : Str) -> {s : Clitics => Str} = \ma, m, me, mma ->
   {s = table {Normal => ma;
               Short => m;
               Composite => me ;
               Imperative => mma 
               }}; 

 genCliticsCase : Agr -> NCase -> {s : Clitics => Str} = \agr, c ->
   case c of 
     {Da => cliticsDa agr.g agr.n agr.p ;
      Ac  => cliticsAc agr.g agr.n agr.p ;
      _ => {s = \\_ => []} 
     };

 aRefl : Agr -> RAgr =  \a -> 
   case <a.g,a.n,a.p> of
     {<_,_,P3> => {s = (genClit "se" "s-" "se" "").s } ;
      _ => {s = (cliticsAc a.g a.n a.p).s }
     };

 dRefl : Agr -> RAgr = \a -> 
   case <a.g,a.n,a.p> of
    {<_,_,P3> => {s = (genClit "îºi" "-ºi" "ºi" "").s } ;
     _ => {s = (cliticsDa a.g a.n a.p).s }
    };

 cliticsAc : Gender -> Number -> Person -> {s: Clitics => Str} = \g,n,p -> 
   case <g,n,p> of
    {<_,Sg,P1> => genClit "mã" "m-" "mã" "-mã"; <_,Pl,P1> => genClit "ne" "ne-" "ne" "-ne"; 
     <_,Sg,P2> => genClit "te" "te-" "te" "-te"; <_,Pl,P2> => genClit "vã" "v-" "vã" "-vã";
     <Masc,Sg,P3> => genClit "îl" "l-" "-l" "-l"; <Masc,Pl,P3> => genClit "îi" "i-" "-i" "-i";
     <Fem,Sg,P3> => genClit "o" "-o" "-o" "-o"; <Fem,Pl,P3> => genClit "le" "le-" "le" "-le" 
    };

 cliticsDa : Gender -> Number -> Person -> {s : Clitics => Str} = \g,n,p -> 
   case <g,n,p> of
    {<_,Sg,P1> => genClit "îmi" "mi-" "mi" "-mi"; <_,Pl,P1> => genClit "ne" "ne-" "ni" "-ne"; 
     <_,Sg,P2> => genClit "îþi" "þi-" "þi" "-þi"; <_,Pl,P2> => genClit "vã" "v-" "vi" "-vã";
     <_,Sg,P3> => genClit "îi" "i-" "i" "-i"; <_,Pl,P3> => genClit "le" "le-" "li" "-le"
    };

     
 flattenClitics : VClit -> RAgr -> RAgr -> RAgr -> Bool -> Bool -> Clitics -> {s1 : Str ; s2 : Str } = \vc, clA, clD, clR, isFemSg, b, pReflClit -> 
                    let par = if_then_else Clitics b Short Normal;
                        pcomb = if_then_else Clitics b Short Composite ;
                        pRefl = if_then_else Clitics b pReflClit Composite                         
                        
   in
  case isFemSg of
      {True => {s1 = clD.s ! par ++ clR.s ! par ; s2 = clA.s ! Short};
       _    => case vc of
           {VOne PAcc  => {s1 = clA.s ! par ; s2 = ""};
            VOne PDat  => {s1 = clD.s ! par ; s2 = ""};
            VRefl => {s1 = clR.s ! par ; s2 = ""};
            _     => {s1 = clD.s ! Composite ++ clR.s ! pRefl ++ clA.s ! pcomb ; s2 = ""}
             }
      };

 flattenSimpleClitics : VClit -> RAgr -> RAgr -> RAgr -> Str = \vc, clA, clD, clR ->
    case vc of 
     {VOne _ => clD.s ! Normal ++ clA.s ! Normal;
      _      => clD.s ! Composite ++ clR.s ! Composite ++ clA.s ! Composite 
     };

-- we rely on the fact that there are not more than 2 clitics for a verb 


-----------------------------------------------------------------------------
------------------------- 5 ARTICLES ----------------------------------------
-----------------------------------------------------------------------------             
oper 

-- demonstrative article 
-- used as Determined article in order to emphasise on the noun/adjective, and for Dative/Genitive for of ordinals

 artDem : Gender -> Number -> ACase -> Str = \g,n,c ->
   case <g,n,c> of
      {<Masc,Sg,ANomAcc> => "cel"; <Masc,Pl,ANomAcc> => "cei"; <Masc,Sg,AGenDat> => "celui"; 
       <Fem,Sg,ANomAcc>  => "cea"; <Fem,Pl,ANomAcc>  => "cele"; <Fem,Sg,AGenDat>  => "celei";
       <_,Pl,AGenDat>    => "celor";
       <Masc,Sg,AVoc> => "cel"; 
       <Masc,Pl,AVoc> => "cei"; <Fem,Sg,AVoc> => "cea"; <Fem,Pl,AVoc> => "cele"
      };

-- undefined article (proclitical) -- 
-- we keep the non-articled form of the noun and glue it with the article on syntactical level

 artUndef : Gender -> Number -> NCase -> Str = \g,n,a ->
   case <g,n,a> of
      {<Masc,Sg,No> => "un"; <Masc,Sg,Ac> => "un" ; <Masc,Sg,Ge> => "unui"; <Masc,Sg,Da> => "unui" ;<_,_,Vo> => "" ;
       <_,Pl,No> => "niºte"; <_,Pl,Ac> => "niºte"; <_,Pl,Da> => "unor"; <_,Pl,Ge> => "unor" ; 
       <Fem,Sg,No> => "o"; <Fem,Sg,Ac> => "o"; <Fem,Sg,Da> => "unei"; <Fem,Sg,Ge> => "unei"
      };
     
-- possesive article 
-- used for Cardinals and for Genitive case		  				    	

 artPos : Gender -> Number -> ACase -> Str = \g,n,c ->
   case <g,n,c> of
      {<Masc,Sg,AGenDat> => "alui"; <Masc,Sg,_> => "al";
       <Masc,Pl,AGenDat> => "alor"; <Masc,Pl,_> => "ai";
       <Fem,Sg,AGenDat>  => "alei"; <Fem,Sg,_>  => "a";
       <Fem,Pl,AGenDat>  => "ale";  <Fem,Pl,_>  => "ale"
      };           
            
-----------------------------------------------------------------------------
------------------------- 6 VARIOUS HELPER FUNCTIONS ------------------------
-----------------------------------------------------------------------------           

oper 
   
--Reflexive pronouns

 reflPron : Number -> Person -> ACase -> Str = \n,p,c -> 
   case <n,p,c> of
     {<Sg,P1,AGenDat> => "mie" ; <Sg,P1,_> => "mine";
      <Sg,P2,AGenDat> => "þie" ; <Sg,P2,_> => "tine";
      <_,P3,AGenDat> => "sieºi" ; <_,P3,_> => "sine" ;
      <Pl,P1,AGenDat> => "nouã" ; <Pl,P1,_> => "noi" ;
      <Pl,P2,AGenDat> => "vouã" ; <Pl,P2,_> => "voi"   
     };

 reflPronHard : Gender -> Number -> Person -> Str = \g,n,p -> 
   case <g,n,p> of
     {<Masc,Sg,P1> => "însumi" ; <Fem,Sg,P1> => "însãmi";
      <Masc,Sg,P2> => "însuþi" ; <Fem,Sg,P2> => "însãþi";
      <Masc,Sg,P3> => "însuºi" ; <Fem,Sg,P3> => "însãºi";
      <Masc,Pl,P1> => "înºine" ; <Fem,Pl,P1> => "însene";  
      <Masc,Pl,P2> => "înºivã";  <Fem,Pl,P2> => "înseva";
      <Masc,Pl,P3> => "înºiºi";  <Fem,Pl,P3> => "înseºi"};   
   
   
-- Agreements :

-- for relatives 
  
 AAgr : Type = {g : Gender ; n : Number} ;
  
-- for agreement between subject and predicate
  
 Agr  : Type = AAgr ** {p : Person} ;


-- clause building function :

 mkClause : Str ->  Agr -> VerbPhrase -> 
    {s : Direct => RTense => Anteriority => Polarity => Mood => Str} =
    \subj,agr,vpr -> {
      s = \\d,t,a,b,m => 
        let 
          tm = case t of {
            RPast  => VPasse m ;   
            RFut   => VFut ;        
            RCond  => VCondit ;        
            RPres  => VPres m
            } ;
          cmp = case <<t,a,m> : RTense * Anteriority * Mood> of {
            <RPast,Simul,Indic> | <RPres, Anter,Indic> => True ; --# notpresent
            <RCond, _, _> => True;  --# notpresent
            _             => False
            } ;
          vp    = useVP vpr ;
          vps   = (vp.s ! VPFinite tm a).sv ;
          sa    = (vp.s ! VPFinite tm a ).sa ; 
          verb  = vps ! agr ; 
          neg   = vp.neg ! b ;
          clpr  = flattenClitics vpr.nrClit vpr.clAcc vpr.clDat (vpr.isRefl ! agr) (andB vpr.isFemSg cmp) cmp vpr.pReflClit; 
          compl = vp.comp ! agr ++ vp.ext ! b
        in
        case d of {
          DDir => 
            subj ++ sa ++ neg ++ clpr.s1 ++ verb ++ clpr.s2;
          DInv => 
            sa ++ neg ++ clpr.s1 ++verb ++ clpr.s2 ++subj 
          }
        ++ compl
    } ;    
 
-- various : 

 heavyNP : {s : NCase => Str ; a : Agr; hasClit : NForm; ss : Str} -> NounPhrase = \np -> {
    s = \\c => {comp = np.s ! c ; 
                clit = \\cs => case np.hasClit of
                                 {HasClit => (genCliticsCase np.a c).s ! cs ; 
                                  _       => [] }};
    a = np.a ;
    indForm = np.ss ; 
    nForm = np.hasClit;
    isPronoun = False  
    } ;
 
 genForms : Str -> Str -> Gender => Str = \bon,bonne ->
      table {
        Masc => bon ; 
        Fem => bonne
        } ; 
   
 aagrForms : (x1,_,_,x4 : Str) -> (AAgr => Str) = \tout,toute,tous,toutes ->
      table {
        {g = g ; n = Sg} => genForms tout toute ! g ;
        {g = g ; n = Pl} => genForms tous toutes ! g
        } ;
 
 appCompl : Compl -> NounPhrase -> Str = \comp,np ->
    comp.s ++ (np.s ! comp.c).comp ;
 
 convCase : NCase -> ACase =\nc -> 
   case nc of
     {Da | Ge => AGenDat;
      No | Ac => ANomAcc;
      _       => AVoc} ;
 
 convACase : ACase -> NCase = \ac -> 
    case ac of
     {ANomAcc => No ;
      AGenDat => Ge ;
      _       => Vo};

 getSize : Size -> Str =\s -> 
    case s of
     {pl => "de" ;
      _ => ""
     };

 nextClit : VClit -> ParClit ->  VClit = \vc,pc ->
    case vc of
     {VNone => VOne pc;
       _     => VMany
     };
  
 isAgrFSg : Agr -> Bool = \ag ->
    case <ag.n,ag.g,ag.p> of
     {<Sg,Fem,P3> => True ;
      _           => False
     };

 clitFromNoun : NounPhrase -> NCase -> RAgr = \np,nc ->
    {s = (np.s ! nc).clit; hasClit = True};

 agrGender : NGender -> Number -> Gender =\ng,n ->
   case <ng,n> of
    {<NMasc,_>   => Masc ;
     <NFem,_>    => Fem ;
     <NNeut, Sg> => Masc ;
     _           => Fem};

 getNumber : Size -> Number =\n -> 
   case n of
    {sg => Sg;
     _  => Pl };

 getClit : Animacy -> Bool =\a -> 
   case a of
    {Animate => True;
     _       => False};
   
}

