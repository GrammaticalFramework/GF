--1 Romance auxiliary operations.
--

resource ResRon = ParamX ** open Prelude in {

flags optimize=all ;

  flags optimize=all ;

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
 
  param Size = sg | less20 | pl ;
 
  Case = Acc | Dat | Gen ;
 
-- Adjectives are inflected in number, gender, have specific form for enclitic determined
--article, and specific forms for Nom-Accusative/Dative-Genitive/Voccative

  AForm = AF Gender Number Species ACase | AA ;

-- Gender is not morphologically determined for first and second person pronouns.

  PronGen = PGen Gender | PNoGen ;

-- Cardinal numerals have gender, ordinal numerals have full number as well.

  ACase = ANomAcc | AGenDat | AVoc ;
  Species  =  Def | Indef ;
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

param 
  VF =
     VInfin Bool
   | VFin   TMood Number Person 
   | VImper NumPersI 
   | VPart  Gender Number Species ACase
   | VGer
   ;

  TMood = 
     VPres  Mood
   | VImperf Mood   --# notpresent
   | VPasse  --# notpresent
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
   | RPasse  --# notpresent
   | RFut    --# notpresent
   | RCond   --# notpresent
   ;

-- Agreement of adjectives, verb phrases, and relative pronouns.

oper
  AAgr : Type = {g : Gender ; n : Number} ;
  Agr  : Type = AAgr ** {p : Person} ;

param
  RAgr = RAg {g : Gender ; n : Number} | RNoAg ; --- AAgr


  oper
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

    Noun = {s : Number => Species => ACase => Str; g : NGender; a : Animacy} ;
    Adj = {s : AForm => Str} ;
 --   A  = {s : Degree => AForm => Str ; isPre : Bool} ;

  Compl : Type = {s : Str ; c : NCase ; isDir : Bool} ;

--  complAcc : Compl = {s = [] ; c = Acc ; isDir = True} ;
--  complGen : Compl = {s = [] ; c = Gen ; isDir = True} ;
--  complDat : Compl = {s = [] ; c = Dat ; isDir = True} ;






 
     
}
