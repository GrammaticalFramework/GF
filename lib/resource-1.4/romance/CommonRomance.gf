----1 Auxiliary operations common for Romance languages
--
-- This module contains operations that are shared by the Romance
-- languages. The complete set of auxiliary operations needed to
-- implement [Test Test.html] is defined in [ResRomance ResRomance.html],
-- which depends on [DiffRomance DiffRomance.html].
--

resource CommonRomance = ParamX ** open Prelude in {

  flags optimize=all ;

--2 Enumerated parameter types for morphology
--
-- These types are the ones found in school grammars.
-- Their parameter values are atomic.

param

  Gender = Masc | Fem ;

  Mood   = Indic | Conjunct ;

  Direct = DDir | DInv ;

-- Adjectives are inflected in gender and number, and there is also an 
-- adverbial form (e.g. "infiniment"), which has different paradigms and 
-- can even be irregular ("bien").
-- Comparative adjectives are moreover inflected in degree
-- (which in Romance is usually syntactic, though).

  AForm = AF Gender Number | AA ;

-- Gender is not morphologically determined for first and second person pronouns.

  PronGen = PGen Gender | PNoGen ;

-- Cardinal numerals have gender, ordinal numerals have full number as well.

  CardOrd = NCard Gender | NOrd Gender Number ;

-- The following coercions are useful:

oper
  prongen2gender : PronGen -> Gender = \p -> case p of {
    PGen g => g ;
    PNoGen => variants {Masc ; Fem} --- the best we can do for je, tu, nous, vous
    } ;


  aform2gender : AForm -> Gender = \a -> case a of {
    AF g _ => g ;
    _      => Masc -- "le plus lentement"
    } ;
  aform2number : AForm -> Number = \a -> case a of {
    AF _ n => n ;
    _      => Sg -- "le plus lentement"
    } ;
  
  conjGender : Gender -> Gender -> Gender = \m,n -> 
    case m of {
      Fem => n ;
      _ => Masc 
      } ;

  conjAgr : Agr -> Agr -> Agr = \a,b -> {
    g = conjGender a.g b.g ;
    n = conjNumber a.n b.n ;
    p = conjPerson a.p b.p
    } ;


--3 Verbs 
--
-- In the current syntax, we use 
-- a reduced conjugation with only the present tense infinitive, 
-- indicative, subjunctive, and imperative forms.
-- But our morphology has full Bescherelle conjunctions:
-- so we use a coercion between full and reduced verbs.
-- The full conjugations and the coercions are defined separately for French
-- and Italian, since they are not identical. The differences are mostly due
-- to Bescherelle structuring the forms in different groups; the
-- gerund and the present participles show real differences.
--
-- For Italian contracted forms, $VInfin$ should have
-- an alternative form, whose proper place is $Diff$.

param 
  VF =
     VInfin Bool
   | VFin   TMood Number Person 
   | VImper NumPersI 
   | VPart  Gender Number 
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

-- Clitic slots.

  CAgr = CPron Gender Number Person | CRefl | CNone ; --- Agr
---  CAgr = CPron {g : Gender ; n : Number ; p : Person} | CRefl | CNone ; --- Agr

oper
  aagr : Gender -> Number -> AAgr = \g,n ->
    {g = g ; n = n} ;
  agrP3 : Gender -> Number -> Agr = \g,n ->
    aagr g n ** {p = P3} ;


  vf2numpers : VF -> (Number * Person) = \v -> case v of {
    VFin _ n p => <n,p> ;
    _ => <Sg,P3> ----
    } ;

  presInd = VPres Indic ;

-- The imperative forms depend on number and person.

  vImper : Number -> Person -> VF = \n,p -> case <n,p> of {
    <Sg,P2> => VImper SgP2 ; 
    <Pl,P1> => VImper PlP1 ; 
    <Pl,P2> => VImper PlP2 ;
    _       => VInfin False
    } ; 

---

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

    Noun = {s : Number => Str ; g : Gender} ;

    Adj = {s : AForm => Str} ;

    appVPAgr : VPAgr -> AAgr -> AAgr = \vp,agr -> 
      case vp of {
        VPAgrSubj   => agr ;
        VPAgrClit a => a
        } ;

    vpAgrNone : VPAgr = VPAgrClit (aagr Masc Sg) ;

  oper
    mkOrd : {s : Degree => AForm => Str} -> {s : AAgr => Str} ;
    mkOrd x = {s = \\ag => x.s ! Posit ! AF ag.g ag.n} ;

-- This is used in Spanish and Italian to bind clitics with preceding verb.

    bindIf : Bool -> Str = \b -> if_then_Str b BIND [] ;

  param
    VPAgr = 
       VPAgrSubj                    -- elle est partie, elle s'est vue
     | VPAgrClit                    -- elle a dormi; elle les a vues
         {g : Gender ; n : Number} ;

  oper
  VP : Type = {
      s : VPForm => {
        fin : Agr  => Str ;              -- ai  
        inf : AAgr => Str                -- dit 
        } ;
      agr    : VPAgr ;                   -- dit/dite dep. on verb, subj, and clitic
      neg    : Polarity => (Str * Str) ; -- ne-pas
      clAcc  : CAgr ;                    -- le/se
      clDat  : CAgr ;                    -- lui
      clit2  : Str ;                     -- y en
      comp   : Agr => Str ;              -- content(e) ; à ma mère ; hier
      ext    : Polarity => Str ;         -- que je dors / que je dorme
      } ;


}

