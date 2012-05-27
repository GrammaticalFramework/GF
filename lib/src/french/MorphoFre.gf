--# -path=.:../romance:../common:../../prelude

--1 A Simple French Resource Morphology
--
-- Aarne Ranta 2002 -- 2005
--
-- This resource morphology contains definitions needed in the resource
-- syntax. To build a lexicon, it is better to use $ParadigmsFre$, which
-- gives a higher-level access to this module.

resource MorphoFre = CommonRomance, ResFre ** 
  open PhonoFre, Prelude, Predef in {

flags optimize=noexpand ;

--2 Front vowels
--
-- In verb conjugation, we will need the concept of frontal vowel.

oper
  voyelleFront : Strs = strs {"e" ; "i" ; "y" ; "é" ; "è"} ;
  preVoyelleFront : (_,_ : Str) -> Str = \t,u -> pre {t ; u / voyelleFront} ;


--2 Nouns
--
-- The following macro is useful for creating the forms of number-dependent
-- tables, such as common nouns.

  numForms : Str -> Str -> Number => Str = \bon,bons ->
    table {Sg => bon ; Pl => bons} ; 

-- For example, the regular noun forms are defined as follows:

  nomReg : Str -> Number => Str = \bu -> numForms bu (bu + "s") ;

-- Common nouns are inflected in number and have an inherent gender.

  CNom = {s : Number => Str ; g : Gender} ;

  mkCNom : (Number => Str) -> Gender -> CNom = \mecmecs,gen -> 
    {s = mecmecs ; g = gen} ;

  mkCNomIrreg : Str -> Str -> Gender -> CNom = \mec,mecs -> 
    mkCNom (numForms mec mecs) ;

  mkCNomReg : Str -> Gender -> CNom = \mec -> 
    mkCNom (nomReg mec) ;

  mkCNomNiveau : Str -> Gender -> CNom = \niveau -> 
    mkCNomIrreg niveau (niveau + "x") ;

  mkCNomCheval : Str -> Gender -> CNom = \cheval -> 
    let {cheva = Predef.tk 1 cheval} in 
    mkCNomIrreg cheval (cheva + "ux") ;

  mkCNomInvar : Str -> Gender -> CNom = \cas -> 
    mkCNomIrreg cas cas ;

  mkNomReg : Str -> Gender -> CNom = \cas -> 
    let cass = case Predef.dp 2 cas of {
      "al" => init cas + "ux" ;
      "au" => cas + "x" ;
      "eu" => cas + "x" ;
      "ou" => cas + "x" ;
      _ => case last cas of {
      "s" => cas ;
      "x" => cas ;
      "z" => cas ;
      _   => cas + "s"
      }
    }
    in mkCNomIrreg cas cass ;
      

--2 Adjectives
--
-- Adjectives are conveniently seen as gender-dependent nouns.
-- Here are some patterns. First one that describes the worst case.

  mkAdj : (_,_,_,_ : Str) -> Adj = \vieux,vieuxs,vieille,vieillement ->
    {s = table {
       AF Masc n => numForms vieux vieuxs ! n ;
       AF Fem  n => nomReg vieille ! n ;
       AA => vieillement
       }
    } ;

-- Then the regular and invariant patterns.

  adjReg : Str -> Gender => Number => Str = \bu -> table {
    Masc => (mkNomReg bu Masc).s ;
    Fem  => nomReg (case last bu of {
      "e" => bu ;
      _ => bu + "e"
      })
    } ;

  adjInvar : Str -> Gender => Number => Str = \bien -> 
    \\_,_ => bien ;

-- Adjectives themselves are records. Here the most common cases:

  adjGrand : Str -> Adj = \grand -> 
    let grande = case last grand of {
      "e" => grand ;
      _ => grand + "e"
      }
    in
    mkAdj grand (grand + "s") grande (grande + "ment") ;

-- Masculine form used for adverbial; also covers "carré".

  adjJoli : Str -> Adj = \joli -> 
    mkAdj joli (joli + "s") (joli + "e") (joli + "ment") ;

  adjHeureux : Str -> Adj = \heureux ->
    let {heureu = Predef.tk 1 heureux} in 
    mkAdj heureux heureux (heureu+"se") (heureu+"sement") ;

  adjBanal : Str -> Adj = \banal ->
    let {bana = Predef.tk 1 banal} in 
    mkAdj banal (bana + "ux") (banal+"e") (banal+"ement") ;

  adjJeune : Str -> Adj = \jeune -> 
    mkAdj jeune (jeune+"s") jeune (jeune+"ment") ;

  adjIndien : Str -> Adj = \indien -> 
    mkAdj indien (indien+"s") (indien+"ne") (indien+"nement") ;

  adjFrancais : Str -> Adj = \francais -> 
    mkAdj francais francais (francais+"e") (francais+"ement") ;

  adjCher : Str -> Adj = \cher ->
    let {ch = Predef.tk 2 cher} in
    mkAdj cher (cher + "s") (ch + "ère") (ch + "èrement") ; 

  mkAdjReg : Str -> Adj = \creux ->
    case Predef.dp 3 creux of {
      "eux" => adjHeureux creux ;
      _ => case Predef.dp 2 creux of {
        "al" => adjBanal creux ;
        "en" => adjIndien creux ;
        "on" => adjIndien creux ;
        "er" => adjCher creux ;
        _ => case Predef.dp 1 creux of {
          "s" => adjFrancais creux ;
          "x" => adjFrancais creux ;
          "e" => adjJeune creux ;
          "é" => adjJoli creux ;
          "i" => adjJoli creux ;
          _ => adjGrand creux
          }
        }
      } ;


--2 Personal pronouns
--
-- All the eight personal pronouns can be built by the following macro.
-- The use of "en" as atonic genitive is debatable.

  mkPronoun : (_,_,_,_,_,_,_ : Str) -> 
              Gender -> Number -> Person -> Pronoun =
    \il,le,lui,Lui,son,sa,ses,g,n,p ->
    let
      alui : Case -> Str = \x -> prepCase x ++ Lui ;
    in {
    s = table {
      Nom        => {c1 = [] ; c2 = []  ; comp = il ; ton = Lui} ;
      Acc        => {c1 = le ; c2 = []  ; comp = [] ; ton = Lui} ;
      CPrep P_a  => {c1 = [] ; c2 = lui ; comp = [] ; ton = alui (CPrep P_a)} ;
      c          => {c1 = [] ; c2 = []  ; comp, ton = alui c}
      } ;
    poss = \\n,g => case <n,g> of {
      <Sg,Masc> => son ;
      <Sg,Fem>  => sa ;
      _         => ses
      } ;
    a = Ag g n p ;
    hasClit = True ;
    isPol = False ;
    isNeg = False
    } ;

  elisPoss : Str -> Str = \s ->
   pre {
     voyelle => s + "on" ;
     _ => s + "a"
     } ;


--2 Determiners
--
-- Determiners, traditionally called indefinite pronouns, are inflected
-- in gender and number. It is usually enough to give the two singular
-- forms to form the plurals.

  pronForms : Str -> Str -> Gender -> Number -> Str = \tel,telle,g,n -> case g of {
    Masc => nomReg tel ! n ;
    Fem  => nomReg telle ! n
    } ;

-- The following macro generates the phrases "est-ce que", "est-ce qu'",
-- and "est-ce qui" (the last one used e.g. in "qu'est-ce qui").

  estCeQue : Case -> Str = \c ->
    "est-ce" ++ case c of {
       Nom => "qui" ;
       Acc => elisQue ;
       _   => nonExist  --- dont?
      } ;


--2 Verbs

--3 Parameters

-- The full conjunction is a table on $VForm$, as in "Bescherelle".

param
  Temps    = Presn | Imparf | Passe | Futur ;
  TSubj    = SPres | SImparf ;
  TPart    = PPres | PPasse Gender Number ;
  VForm    = Inf
           | Indi Temps Number Person 
           | Condi Number Person 
           | Subjo TSubj Number Person
           | Imper NumPersI
           | Part TPart ;

-- This is a conversion to the type in $CommonRomance$.

oper
  vvf : (VForm => Str) -> (VF => Str) = \aller -> table { 
    VInfin _       => aller ! Inf ;
    VFin (VPres   Indic) n p => aller ! Indi Presn n p ; 
    VFin (VPres   Subjunct) n p => aller ! Subjo SPres n p ;
    VFin (VImperf Indic) n p => aller ! Indi Imparf n p ;     --# notpresent
    VFin (VImperf Subjunct) n p => aller ! Subjo SImparf n p ;  --# notpresent
    VFin VPasse n p  => aller ! Indi Passe n p ;  --# notpresent
    VFin VFut n p    => aller ! Indi Futur n p ;  --# notpresent
    VFin VCondit n p => aller ! Condi n p ;  --# notpresent
    VImper np    => aller ! Imper np ;
    VPart g n    => aller ! Part (PPasse g n) ;
    VGer         => aller ! Part PPres -- *en* allant
    } ;

  Verbe : Type = VForm => Str ;

-- the worst case

  mkVerb12 : 
    (tenir,tiens,tient,tenons,tenez,tiennent,tienne,tenions,tiensI,tint,tiendra,tenu : Str) -> Verbe =
    \tenir,tiens,tient,tenons,tenez,tiennent,tienne,tenions,tiensI,tint,tiendra,tenu -> 
    let 
      tiens2 : Str = case tiens of {
        _ + "e" => tiens + "s" ;
        _       => tiens
        } ;
      tiendr = init tiendra ;
      ten = Predef.tk 3 tenons ;
      affpasse : AffixPasse * Int = case tint of {
        _ + "a"  => <affixPasseA,1> ;
        _ + "it" => <affixPasseI,2> ;
        _ + "ut" => <affixPasseU,2> ;
        _ + "nt" => <affixPasse "in" "în",3> ;
        _        => Predef.error ("cannot form past tense from" ++ tint)
        } ;
      tin = Predef.tk affpasse.p2 tint ;
      tienn = init tienne ;
      tenS = Predef.tk 4 tenions ;
      tenus : Str = case tenu of {_ +"s" => tenu ; _ => tenu + "s"} ;
    in table {
      Inf                   => tenir ;
      Indi  Presn   Sg P1   => tiens ;
      Indi  Presn   Sg P2   => tiens2 ;
      Indi  Presn   Sg P3   => tient ;
      Indi  Presn   Pl P1   => tenons ;
      Indi  Presn   Pl P2   => tenez ;
      Indi  Presn   Pl P3   => tiennent ;

      Indi  Imparf  n  p    => ten    + affixImparf ! n ! p ;
      Indi  Passe   n  p    => tin    + affpasse.p1.ps ! n ! p ;
      Indi  Futur   n  p    => tiendr + affixFutur ! n ! p ;
      Condi         n  p    => tiendr + affixImparf ! n ! p ;
      Subjo SPres   Sg p    => tienn  + affixSPres ! Sg ! p ;
      Subjo SPres   Pl P3   => tienn  + "ent" ;
      Subjo SPres   Pl p    => tenS   + affixImparf ! Pl ! p ;
      Subjo SImparf n  p    => tin    + affpasse.p1.si ! n ! p ;
      Imper        SgP2     => tiensI ;
      Imper        p        => tenS   + affixImper ! p ;
      Part PPres            => ten    + "ant" ;
      Part (PPasse Masc Sg) => tenu ;
      Part (PPasse Fem  Sg) => tenu + "e" ;
      Part (PPasse Masc Pl) => tenus ;
      Part (PPasse Fem  Pl) => tenu + "es"
      } ;

  mkVerb7 : (tenir,tiens,tenons,tiennent,tint,tiendra,tenu : Str) -> Verbe =
    \tenir,tiens,tenons,tiennent,tint,tiendra,tenu -> 
    let
      tient : Str = case tiens of {
        _ + "e"                  => tiens ;
        _ + ("cs" | "ts" | "ds") => init tiens ;
        tien + ("x"| "s")        => tien + "t" ;
        _ => Predef.error ("mkVerb7: not valid present singular first:" ++ tiens)
        } ;
      tenez = Predef.tk 3 tenons + "ez" ;
      tenions = Predef.tk 3 tenons + "ions" ;
      tienne = Predef.tk 2 tiennent ;
      tiensI = tiens
    in
    mkVerb12 tenir tiens tient tenons tenez tiennent tienne tenions tiensI tint tiendra tenu ;


--3 Affixes
--
-- It is convenient to have sets of affixes as data objects.

  Affixe : Type = Person => Str ;

  lesAffixes : (_,_,_ : Str) -> Affixe = \x,y,z -> table {
      P1 => x ;
      P2 => y ;
      P3 => z
      } ;

-- Much of variation can be described in terms of affix sets:

  affixSgE      : Affixe = lesAffixes "e" "es" "e" ;

  affixSgS      : Affixe = lesAffixes "s" "s" "t" ;

  affixSgSsansT : Affixe = lesAffixes "s" "s" [] ;

  affixSgX      : Affixe = lesAffixes "x" "x" "t" ;

  affixPlOns    : Affixe = lesAffixes "ons" "ez" "ent" ;

  affixSgAi     : Affixe = lesAffixes "ai" "as" "a" ;

  affixSgAis    : Affixe = \\p => "ai" + affixSgS ! p ;

  affixPlIons   : Affixe = table {
      P3 => "aient" ;
      p  => "i" + affixPlOns ! p
      } ;

-- Often affix sets come in pairs, for the singular and the plural.

  affixImparf : Number => Affixe = table {
      Sg => affixSgAis ;
      Pl => affixPlIons
      } ;

  affixFutur : Number => Affixe = table {
      Sg => affixSgAi ;
      Pl => table {
        P3 => "ont" ;
        p  => affixPlOns ! p
        }
      } ;

  affixSPres : Number => Affixe = table {
      Sg => affixSgE ;
      Pl => table {
        P3 => "ent" ;
        p  => affixPlIons ! p
        }
      } ;

  affixPlMes : (_,_ : Str) -> Affixe = 
     \è, â -> lesAffixes (â + "mes") (â + "tes") (è + "rent") ;

  affixPasseAi : Number => Affixe = table {
      Sg => affixSgAi ;
      Pl => affixPlMes "è" "â" 
      } ;

  affixPasseS : (i,î : Str) -> Number => Affixe = \i,î -> table {
      Sg => table {p => i + affixSgS ! p} ;
      Pl => affixPlMes i î
      } ;

  affixSImparfSse : (i,î : Str) -> Number => Affixe =  \i,î -> table {
      Sg => table {
        P3 => î + "t" ;
        p  => i + "ss" + affixSgE ! p
        } ;
      Pl => table {p  => i + "ss" + affixSPres ! Pl ! p}
      } ;

  AffixPasse : Type = {ps : Number => Affixe ; si : Number => Affixe} ;

  affixPasse : (_,_ : Str) -> AffixPasse = \i, î ->
    {ps = affixPasseS i î ; si = affixSImparfSse i î} ;

  affixPasseA : AffixPasse = {ps = affixPasseAi ; si = affixSImparfSse "a" "â"} ;

  affixPasseI : AffixPasse = affixPasse "i" "î" ;

  affixPasseU : AffixPasse = affixPasse "u" "û" ;

  affixPasseNonExist : AffixPasse = 
    let {aff : Number => Affixe = 
                 table {_ => lesAffixes nonExist nonExist nonExist}} in
      {ps = aff ; si = aff} ;

  affixImper : NumPersI => Str = table {
     SgP2 => "e" ; 
     PlP1 => "ons" ;
     PlP2 => "ez"
     } ;

  formesPresAi : (v,all : Str) -> Number => Affixe = \v,all -> table {
       Sg => \\p  => v + affixSgAi ! p ;
       Pl => table {
         P3 => v + "ont" ;
         p  => all + affixPlOns ! p
         } 
       } ;

}
