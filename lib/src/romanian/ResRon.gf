--1 Romance auxiliary operations.
--

resource ResRon = ParamX - [Temp,TTAnt,Tense,TPres,TPast,TFut,TCond], PhonoRon ** open Prelude in {

flags optimize= all ;

  

--2 Enumerated parameter types for morphology
--
-- These types are the ones found in school grammars.
-- Their parameter values are atomic.

param

  Gender = Masc | Fem ;

  NGender = NMasc | NFem | NNeut ;
 
  Mood   = Indic | Conjunct ;

  Direct = DDir | DInv ;

  NumF  = Formal | Informal ;
 
  Animacy = Animate | Inanimate ;
 
 -- Refl = NoRefl | ARefl | DRefl ;
 
  Clitics = Normal | Composite | Short | Vocative ;  
 
  Size = sg | less20 | pl ;
 
  ParClit = PAcc | PDat  ;

  VClit = VNone | VOne ParClit | VRefl | VMany ;

  PrepDir = Dir ParClit | NoDir ;

-- Adjectives are inflected in number, gender, have specific form for enclitic determined
--article, and specific forms for Nominative-Accusative/Dative-Genitive/Voccative

  AForm = AF Gender Number Species ACase | AA ;

-- Gender is not morphologically determined for first and second person pronouns.

  PronGen = PGen Gender | PNoGen ;

-- Cardinal numerals have gender, ordinal numerals have full number as well.

  ACase = ANomAcc | AGenDat | AVoc ;
  Species  =  Indef | Def ;
  NCase = No | Da | Ac | Ge | Vo ;
  
  CardOrd = NCard Gender | NOrd Gender;







--3 Verbs 


-- the form we build on syntactical level, based on VForm
-- it represents the main verb forms in Romanian
 
param
  Temps1    = TPresn | TImparf | TPComp | TPSimple | TPPerfect | TFutur ;
  TSubj1    = TSPres | TSPast ;
 -- TPart1    = TGer | TPPasse Gender Number Species ACase;
  
  VerbForm    = TInf
           | TIndi Temps1 Number Person 
           | TCondi Number Person 
           | TSubjo TSubj1 Number Person
           | TImper NumPersI
           | TGer 
           | TPPasse Gender Number Species ACase ;

 -- the form we build on morphological level :
 
  Temps    = Presn | Imparf | PSimple | PPerfect ;
  TSubj    = SPres ;
  --TPart    = PPasse Gender Number Species ACase;
  
  VForm    = Inf
           | Indi Temps Number Person 
           | Subjo TSubj Number Person
           | Imper NumPersI
           | Ger
           | PPasse Gender Number Species ACase ;

-- form for compatibility with the other Romance languages, to be used in case that
-- Romanian will be integrated in the Romance category
{-
param 
  VF =
     VInfin Bool
   | VFin   TMood Number Person 
   | VImper NumPersI 
   | VPart  Gender Number Species ACase
   | VGer
   ;
-}
  TMood = 
     VPres  Mood
   | VImperff   --# notpresent
   | VPasse Mood --# notpresent
   | VFut  --# notpresent
   | VCondit  --# notpresent
   ;

  NumPersI  = SgP2 | PlP1 | PlP2 ;


  VPForm =
     VPFinite TMood Anteriority
   | VPImperat
   | VPGerund
   | VPInfinit Anteriority Bool ;

  RTense =
     RPres 
   | RPast   --# notpresent
   | RFut    --# notpresent
   | RCond   --# notpresent
   ;

-- Agreement of adjectives, verb phrases, and relative pronouns.

oper
  AAgr : Type = {g : Gender ; n : Number} ;
  Agr  : Type = AAgr ** {p : Person} ;
  RAgr : Type = {s : Clitics => Str} ; 

 


  oper

    -- clitics : Gender -> Number
    genForms : Str -> Str -> Gender => Str = \bon,bonne ->
      table {
        Masc => bon ; 
        Fem => bonne
        } ; 

    RNoAg : RAgr = genClit "" "" "" "";

    aagrForms : (x1,_,_,x4 : Str) -> (AAgr => Str) = \tout,toute,tous,toutes ->
      table {
        {g = g ; n = Sg} => genForms tout toute ! g ;
        {g = g ; n = Pl} => genForms tous toutes ! g
        } ;

    Noun = {s : Number => Species => ACase => Str; g : NGender; a : Animacy} ;
    Adj = {s : AForm => Str} ;
   

  Compl : Type = {s : Str ; c : NCase ; isDir : PrepDir ; needIndef : Bool ; prepDir : Str} ;

oper 
NounPhrase : Type = {
    s : NCase => {comp : Str ;
                  clit : Clitics => Str} ;
    a : Agr ;
    indForm : Str ;
    hasClit : Bool ;
    hasRef : Bool ;
    isPronoun : Bool 
    } ; 
    
Pronoun : Type = {s : NCase => {comp, c1, c2 : Str};
                  a : Agr ;
                  poss : Number => Gender => Str                
                  };



heavyNP : {s : NCase => Str ; a : Agr; hasClit : Bool; ss : Str} -> NounPhrase = \np -> {
    s = \\c => {comp = np.s ! c ; 
                clit = \\cs => if_then_Str np.hasClit ((genCliticsCase np.a c).s ! cs) [] };
              

    a = np.a ;
    indForm = np.ss ; 
    hasClit = np.hasClit ;
    isPronoun = False;
    hasRef = False
     
    } ;
 

 appCompl : Compl -> NounPhrase -> Str = \comp,np ->
    comp.s ++ (np.s ! comp.c).comp ;
 
oper convCase : NCase -> ACase =
\nc -> case nc of
 {Da | Ge => AGenDat;
  No | Ac => ANomAcc;
  _       => AVoc} ;
oper convACase : ACase -> NCase = 
\ac -> case ac of
{ANomAcc => No ;
 AGenDat => Ge ;
 _       => Vo};

--oper genRAgr : (x1,_,x3 : Str) -> RAgr = \ma,m,me -> genClit ma m me ** {hasClit = True};

oper genClit : (x1,_,_,x4 : Str) -> {s : Clitics => Str} = \ma, m, me, mma ->
{s = table {Normal => ma;
            Short => m;
            Composite => me ;
            Vocative => mma 
             }}; 

oper genCliticsCase : Agr -> NCase -> {s : Clitics => Str} = \agr, c ->
case c of 
{Da => cliticsDa agr.g agr.n agr.p ;
 Ac  => cliticsAc agr.g agr.n agr.p ;
 _ => {s = \\_ => []} 
};

oper aRefl : Agr -> RAgr = 
 \a -> case <a.g,a.n,a.p> of
                   {<_,_,P3> => {s = (genClit "se" "s-" "se" "").s } ;
                    _ => {s = (cliticsAc a.g a.n a.p).s }
                   };

oper dRefl : Agr -> RAgr = 
\a -> case <a.g,a.n,a.p> of
                  {<_,_,P3> => {s = (genClit "îºi" "-ºi" "ºi" "").s } ;
                   _ => {s = (cliticsDa a.g a.n a.p).s }
                  };

oper cliticsAc : Gender -> Number -> Person -> {s: Clitics => Str} = 
\g,n,p -> case <g,n,p> of
{<_,Sg,P1> => genClit "mã" "m-" "mã" "-mã"; <_,Pl,P1> => genClit "ne" "ne-" "ne" "-ne"; 
<_,Sg,P2> => genClit "te" "te-" "te" "-te"; <_,Pl,P2> => genClit "vã" "v-" "vã" "-vã";
<Masc,Sg,P3> => genClit "îl" "l-" "-l" "-l"; <Masc,Pl,P3> => genClit "îi" "i-" "-i" "-i";
<Fem,Sg,P3> => genClit "o" "-o" "-o" "-o"; <Fem,Pl,P3> => genClit "le" "le-" "le" "-le" 
};

oper cliticsDa : Gender -> Number -> Person -> {s : Clitics => Str} = 
\g,n,p -> case <g,n,p> of
{<_,Sg,P1> => genClit "îmi" "mi-" "mi" "-mi"; <_,Pl,P1> => genClit "ne" "ne-" "ni" "-ne"; 
<_,Sg,P2> => genClit "îþi" "þi-" "þi" "-þi"; <_,Pl,P2> => genClit "vã" "v-" "vi" "-vã";
<_,Sg,P3> => genClit "îi" "i-" "i" "-i"; <_,Pl,P3> => genClit "le" "le-" "li" "-le"
};

oper
  VPC : Type = {
                               -- for conjunctive mood where the negation comes    
       s : VPForm => {
        sa : Str ;                     -- sa  
        sv : Agr => Str                -- merge
        } ;           
      neg    : Polarity => Str ; 
      clitAc  : RAgr ;                     
      clitDa  : RAgr ;                     
      clitRe  : RAgr ;        
      nrClit  : VClit ;             
      comp    : Agr => Str ;              -- content(e) ; à ma mère ; hier
      ext     : Polarity => Str ;         -- que je dors / que je dorme
      } ;

-- fix for Refl + Dat

flattenClitics : VClit -> RAgr -> RAgr -> RAgr -> Bool -> Bool -> {s1 : Str ; s2 : Str } = 
\vc, clA, clD, clR, isFemSg, b -> 
                    let par = if_then_else Clitics b Short Normal;
                        pcomb = if_then_else Clitics b Short Composite  
                        
in
case isFemSg of
{True => {s1 = clD.s ! par ++ clR.s ! par ; s2 = clA.s ! Short};
 _    => case vc of
           {VOne PAcc  => {s1 = clA.s ! par ; s2 = ""};
            VOne PDat  => {s1 = clD.s ! par ; s2 = ""};
            VRefl => {s1 = clR.s ! par ; s2 = ""};
            _     => {s1 = clD.s ! Composite ++ clR.s ! pcomb ++ clA.s ! pcomb ; s2 = ""}
             }
};

{-
{<False,_,False,_> => {s1 = clD.s ! par ; s2 = ""};
 <False,False,_,_> => {s1 = clR.s ! par ; s2 = ""};
 <_,_,_,True> => {s1 = clD.s ! par ++ clR.s ! par ; s2 = clA.s ! Short};
 <_,False,False,_> => {s1 = clA.s ! par ; s2 = ""};
 _  => {s1 = clD.s ! Composite ++ clR.s ! Composite ++ clA.s ! pcomb ; s2 = ""}
};
-}

flattenSimpleClitics : VClit -> RAgr -> RAgr -> RAgr -> Str =
\vc, clA, clD, clR ->case vc of 
                   {VOne _ => clD.s ! Normal ++ clA.s ! Normal;
                    _      => clD.s ! Composite ++ clR.s ! Composite ++ clA.s ! Composite 
                   };


-- we rely on the fact that there are not more than 2 clitics for a verb 

oper getSize : Size -> Str =
\s -> case s of
{ pl => "de" ;
  _ => ""
};




    
}
