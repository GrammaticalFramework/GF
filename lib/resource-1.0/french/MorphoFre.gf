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

flags optimize=all ;

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
    mkAdj heureux (heureu+"s") (heureu+"se") (heureu+"sement") ;

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
    {s = table {
       Ton x => prepCase x ++ Lui ;
       Aton Nom => il ;
       Aton Acc => le ; 
       Aton (CPrep P_de) => "en" ; --- hmm
       Aton (CPrep P_a) => lui ; 
       Poss {n = Sg ; g = Masc} => son ;
       Poss {n = Sg ; g = Fem}  => sa ;
       Poss {n = Pl}    => ses
       } ;
     a = {g = g ; n = n ; p = p} ;
     hasClit = True
    } ;

  elisPoss : Str -> Str = \s ->
   pre {s + "a" ; s + "on" / voyelle} ;


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

-- We very often form the verb stem by dropping out the infinitive ending.

  troncVerb : Tok -> Tok = Predef.tk 2 ;


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

--3 Macros for the complete conjugation type
--
-- The type $VForm$ has 55 forms, as defined in $types.Fra.gf$.
-- The worst-case macro takes 11 stems and two affix sets.
-- (We will actually never need all of these at the same time.)

  Verbe : Type = VForm => Str ;

  verbAffixes :
    (a,b,c,d,e,f,g,h,i,j,k : Str) -> Affixe -> AffixPasse -> Verbe =
    \tien, ten, tienn, t, tiendr, soi, soy, soie, tenu, tenus, tenir ->
    \affpres, affpasse ->
    table {
      Inf                   => tenir  ;
      Indi  Presn    Sg p     => tien   + affpres ! p ;
      Indi  Presn    Pl P3    => tienn  + affixPlOns ! P3 ;
      Indi  Presn    Pl p     => ten    + affixPlOns ! p ;
      Indi  Imparf  n  p     => ten    + affixImparf ! n ! p ;
      Indi  Passe   n  p     => t      + affpasse.ps ! n ! p ;
      Indi  Futur   n  p     => tiendr + affixFutur ! n ! p ;
      Condi         n  p     => tiendr + affixImparf ! n ! p ;
      Subjo SPres   Sg p    => soi    + affixSPres ! Sg ! p ;
      Subjo SPres   Pl P3   => soi    + "ent" ;
      Subjo SPres   Pl p    => soy    + affixSPres ! Pl ! p ;
      Subjo SImparf n  p    => t      + affpasse.si ! n ! p ;
      Imper        SgP2     => soie ;
      Imper        p        => soy    + affixImper ! p ;
      Part PPres            => ten    + "ant" ;
      Part (PPasse Masc Sg) => tenu ;
      Part (PPasse Fem  Sg) => tenu + "e" ;
      Part (PPasse Masc Pl) => tenus ;
      Part (PPasse Fem  Pl) => tenu + "es"
      } ;

-- Almost always seven stems are more than enough.

  verbHabituel :
    (a,b,c,d,e,f,g : Str) -> Affixe -> AffixPasse -> Verbe =
    \tien, ten, tienn, t, tiendr, tenu, tenir ->
    \affpres, affpasse ->
    verbAffixes tien ten tienn t tiendr tienn ten 
                (tien + affpres ! P1) tenu (tenu+"s") tenir affpres affpasse ;

--3 The first conjugation
--
-- There is quite some phonologically explained variation in the first conjugation.
-- The worst case has three different stems.

  auxConj1 : Str -> Str -> Str -> Verbe = \jet, jett, jeter ->
    verbHabituel jett jet jett jet jeter (jet+"é") (jet+"er") affixSgE affixPasseA ;

  conj1aimer : Str -> Verbe = \aimer -> 
    let {aim = troncVerb aimer} in
    auxConj1 aim aim aimer ;

  conj1céder : Str -> Verbe = \céder -> 
    let {
      ced = troncVerb céder ; 
      d   = Predef.dp 1 ced ;
      c   = Predef.tk 2 ced ; 
      cèd = c + "è" + d ; 
      céd = c + "é" + d
      } 
      in auxConj1 céd cèd céder ;

  conj1peser : Str -> Verbe = \céder -> ---- ? a verifier
    let {
      ced = troncVerb céder ; 
      d   = Predef.dp 1 ced ;
      c   = Predef.tk 2 ced ; 
      cèd = c + "è" + d ; 
      céd = c + "e" + d
      } 
      in auxConj1 céd cèd céder ;

  conj1jeter : Str -> Verbe = \jeter ->
    let {
      jet  = troncVerb jeter ;
      jett = jet + Predef.dp 1 jet
    } 
    in auxConj1 jet jett (jett + "er") ;

  conj1placer : Str -> Verbe = \placer -> 
    let {
      pla = Predef.tk 3 placer ;
      plac = preVoyelleFront (pla+"ç") (pla+"c")
    } in
    auxConj1 plac plac placer ;

  conj1manger : Str -> Verbe = \manger -> 
    let {
      mang  = Predef.tk 2 manger ;
      mange = preVoyelleFront (mang+"e") mang
    } in
    auxConj1 mange mange manger ;

  conj1assiéger : Str -> Verbe = \assiéger ->
    let {assi = Predef.tk 4 assiéger} in
    auxConj1 (preVoyelleFront (assi+"ége") (assi+"ég")) (assi+"èg") assiéger ;

  conj1payer : Str -> Verbe = \payer -> 
    let {pa = Predef.tk 3 payer} in
    auxConj1 (pa + "y") (pa + "i") (pa + "ier") ;

  conj1envoyer : Str -> Verbe = \envoyer ->
    let {renv = Predef.tk 4 envoyer} in
    auxConj1 (renv + "oy") (renv + "oi") (renv + "err") ;

-- This is a collective dispatcher.

  mkVerbReg : Str -> Verbe = \parler ->
    case parler of {
      _ + "ir"              => conj2finir parler ;
      _ + "re"              => conj3rendre parler ;
      _ + "éger"            => conj1assiéger parler ;
      _ + ("eler" | "eter") => conj1jeter parler ;
      _ + "éder"            => conj1céder parler ;
      _ + "cer"             => conj1placer parler ;
      _ + "ger"             => conj1manger parler ;
      _ + "yer"             => conj1payer parler ;
      _                     => conj1aimer parler
    } ;

{-
    let
      e = last (Predef.tk 4 parler) ;
      c = last (Predef.tk 3 parler) ;
      verb_é = pbool2bool (occur "é" (e + last (Predef.tk 3 parler))) ;
      verb_e = andB (pbool2bool (occur e "e")) (pbool2bool (occur c "cmnprsv"))
    in
    case Predef.dp 4 parler of {
      "éger" => conj1assiéger parler ;
      "eler" => conj1jeter parler ;
      "eter" => conj1jeter parler ;
      _ => case verb_é of {
        True => conj1céder parler ;
        _ => case verb_e of {
----          True => conj1peser parler ;
          False | _ => case Predef.dp 3 parler of {
            "cer" => conj1placer parler ;
            "ger" => conj1manger parler ;
            "yer" => conj1payer parler ;
            _ => case Predef.dp 2 parler of {
              "ir" => conj2finir parler ;
              "re" => conj3rendre parler ;
              _ => conj1aimer parler
              }
            }
          }
        }
      } ;
-}

-- The following can be more reliable.

  mkVerb3Reg : Str -> Str -> Str -> Verbe = \jeter,jette,jettera ->
    auxConj1 
      (Predef.tk 2 jeter) 
      (Predef.tk 1 jette)  
      (Predef.tk 1 jettera) ;

--3 The second conjugation
--
-- There are just two different cases.

  conj2finir : Str -> Verbe = \finir ->
    let {
      fin  = troncVerb finir ; 
      fini = fin + "i" ; 
      finiss = fin + "iss"
      } in
    verbHabituel fini finiss finiss fin finir fini finir affixSgS affixPasseI ;

  conj2haïr : Str -> Verbe = \haïr ->
    let {ha    = troncVerb haïr ;
         hai   = ha + "i" ; 
         haï   = ha + "ï" ; 
         haiss = ha + "ïss"
        } in
    verbHabituel hai haiss haiss ha haïr haï haïr affixSgS (affixPasse "ï" "ï") ;


--3 The third conjugation
--
-- This group is very heterogeneous. Most verbs have "re" in the infinitive,
-- but the first example does not!

  conj3tenir : Str -> Verbe = \tenir ->
    let {t = Predef.tk 4 tenir} in
    verbHabituel 
      (t+"ien") (t+"en") (t+"ienn") t (t+"iendr") (t+"enu") tenir
      affixSgS (affixPasse "in" "în") ;

-- Many verbs have "is" in the past participle. But there is so much variation
-- that the worst-case macro needs seven forms.

  auxConj3is : (_,_,_,_,_,_,_ : Str) -> Verbe =
    \quier, quér, quièr, qu, querr, quis, quiss ->
    verbAffixes 
      quier quér quièr qu querr quièr quér
      (quier + "s") quis quiss (quér + "ir") affixSgS affixPasseI ;

  auxConj3ir : (_,_,_ : Str) -> Verbe = \sen, sent, i -> 
    auxConj3is sen sent sent sent (sent+"ir") (sent+i) (sent+i+"s") ;

  conj3quérir : Str -> Verbe = \quérir ->
    let {qu = Predef.tk 4 quérir} in
    auxConj3is (qu+"ier") (qu+"ér") (qu+"ièr") qu (qu+"err") (qu+"is") (qu+"is") ;

  conj3sentir : Str -> Verbe = \sentir ->
    let {
      sent = troncVerb sentir ;
      sen  = Predef.tk 1 sent
    } in
    auxConj3ir sen sent "i" ;

  conj3vêtir : Str -> Verbe = \vêtir -> 
    let {
      s = Predef.tk 5 vêtir ;
      vet = auxConj3ir "vêt" "vêt" "u"
    } in
    table {
      Indi Presn Sg P3 => s + "vêt" ;
      p              => s + vet ! p
      };
  
  auxConj3vrir : (_,_,_ : Str) -> Verbe = \ouvr, i, ouvert ->
    verbAffixes 
      ouvr ouvr ouvr ouvr (ouvr + i + "r") ouvr ouvr
      (ouvr + "e") ouvert (ouvert + "s") (ouvr + "ir") affixSgE affixPasseI  ;

  conj3couvrir  : Str -> Verbe = \couvrir -> 
    let {couv = Predef.tk 3 couvrir} in
    auxConj3vrir (couv+"r") "i" (couv+"ert") ;

  conj3cueillir : Str -> Verbe = \cueillir -> 
    let {cueill = troncVerb cueillir} in
    auxConj3vrir cueill "e" (cueill + "i") ;

  conj3assaillir : Str -> Verbe = \assaillir -> 
    let {assaill = troncVerb assaillir} in
    auxConj3vrir assaill "i" (assaill + "i") ;

-- The verb "faillir" has lots of alternatives forms.

  conj3faillir : Str -> Verbe = \faillir ->
    let {
      fa    = Predef.tk 5 faillir ;
      faudr = fa + "udr" ;
      tfa   = conj3assaillir faillir
      } in
    table {
      Indi Presn Sg p   => fa + "u" + affixSgX ! p ;
      Subjo SPres n p => fa + variants {"illiss" ; "ill"} + affixSPres ! n ! p ;

      Indi Futur n p => variants {tfa ! Indi Futur n p ; faudr + affixFutur ! n ! p} ;
      Condi      n p => variants {tfa ! Condi n p     ; faudr + affixImparf ! n ! p} ;

      Imper _         => nonExist ;
      p               => tfa ! p
      };

  conj3bouillir : Str -> Verbe = \bouillir -> 
    let {
      bou = Predef.tk 5 bouillir ;
      tbou = conj3assaillir bouillir
    } in
    table {
      Indi Presn Sg p  => bou + affixSgS ! p ;
      Imper SgP2     => bou + "s" ;
      p              => tbou ! p
    };

-- Notice that here we don't need another conjugation, as Bescherelle does.

  conj3dormir : Str -> Verbe = conj3sentir ;

-- The verbs "mourir" and "courir" have much in common, except the first two
-- persons in the present indicative singular, and the past participles.

  auxConj3ourir : (_,_,_ : Str) -> Verbe = \meur, mour, mort ->
    verbAffixes 
      meur mour meur mour (mour + "r") meur mour
      (meur + "s") mort (mort + "s") (mour + "ir") affixSgS affixPasseU ;

  conj3courir : Str -> Verbe = \courir -> 
    let {cour = troncVerb courir} in
    auxConj3ourir cour cour (cour + "u") ;

  conj3mourir : Str -> Verbe = \mourir ->
    let {m = Predef.tk 5 mourir} in
    auxConj3ourir (m + "eur") (m + "our") (m + "ort") ;

-- A little auxiliary to cover "fuir" and "ouïr". 
-- *N.B.* some alternative forms for "ouïr" are still missing.

  auxConj3ui : AffixPasse -> (_,_,_ : Str) -> Verbe = \affpasse, o, ou, ouï ->
    let {oi : Str = o + "i" ; oy : Str = o + "y" ; ouïr : Str = ouï + "r"} in
    verbHabituel oi oy oi ou ouïr ouï ouïr affixSgS affpasse ;

  conj3fuir : Str -> Verbe = \fuir ->
    let {fu = troncVerb fuir} in 
    auxConj3ui affixPasseI fu fu (fu + "i") ;

  conj3ouïr : Str -> Verbe = \ouir ->
    let {o = Predef.tk 3 ouir} in
    auxConj3ui (affixPasse "ï" "ï") o (o + "u") (o + "uï") ;

-- The verb "gésir" lacks many forms.

  conj3gésir : Str -> Verbe = \gésir -> 
    let {g = Predef.tk 4 gésir} in
    table {
      Inf              => g + "ésir" ;
      Indi  Presn   Sg p => g + lesAffixes "is" "is" "ît" ! p ; 
      Indi  Presn   Pl p => g + "is" + affixPlOns ! p ;
      Indi  Imparf n  p => g + "is" + affixImparf ! n ! p ;
      Part PPres       => g + "isant" ;
      _                => nonExist
      } ;

-- Here is an auxiliary for a large, and heterogeneous, group of verbs whose
-- infinitive ends in "oir". It has two special cases, depending on the ending
-- of the first two persions in the present indicative singular.

  auxConj3oir : Affixe -> AffixPasse -> (_,_,_,_,_,_,_,_ : Str) -> Verbe =
     \affpres, affpasse -> 
     \peu, pouv, peuv, p, pourr, veuill, voul, v ->
     let {pu : Str = p + "u"} in
     verbAffixes 
       peu pouv peuv p pourr veuill voul (peu+affpres!P1) pu (pu+"s") (v+"oir")
       affpres affpasse ;

  auxConj3usX : (_,_,_,_,_,_,_,_ : Str) -> Verbe = 
    auxConj3oir affixSgX affixPasseU ;
  auxConj3usS : (_,_,_,_,_,_,_,_ : Str) -> Verbe = 
    auxConj3oir affixSgS affixPasseU ;

  conj3cevoir : Str -> Verbe = \cevoir ->
    let {re = Predef.tk 6 cevoir} in
    auxConj3usS (re+"çoi") (re+"cev") (re+"çoiv") (re+"ç") 
                (re+"cevr") (re+"çoiv") (re+"cev") (re+"cev") ;

  conj3voir : Str -> Verbe = \voir -> 
    let {
      v = Predef.tk 3 voir ;
      voi = v + "oi"
      } in
    auxConj3oir 
      affixSgS affixPasseI voi (v + "oy") voi v (v + "err") voi (v + "oy") v ;

  conj3pourvoir : Str -> Verbe = \pourvoir ->
    let {
      pourv = Predef.tk 3 pourvoir ;
      pourvoi = pourv + "oi" ;
      pourvoy = pourv + "oy"
      } in
    auxConj3usS pourvoi pourvoy pourvoi pourv pourvoir pourvoi pourvoy pourv ;  

  conj3savoir : Str -> Verbe = \savoir ->
    let {
      s = Predef.tk 5 savoir ;
      tsavoir = auxConj3usS "ai" "av" "av" "" "aur" "ach" "ach" "av"
      } in
    table {
     Imper p        => s + "ach" + affixImper ! p ;
     Part PPres     => s + "achant" ;
     p => s + tsavoir ! p 
     } ;

  conj3devoir : Str -> Verbe = \devoir ->
    let {
      s = Predef.tk 6 devoir ;
      tdevoir = auxConj3usS "doi" "dev" "doiv" "d" "devr" "doiv" "dev" "dev"
      } in
    table {
      Part (PPasse Masc Sg) => s + "dû" ;
      p => s + tdevoir ! p
     } ;

  conj3pouvoir : Str -> Verbe = \pouvoir ->
    let {
      p = Predef.tk 6 pouvoir ;
      tpouvoir = auxConj3usX "eu" "ouv" "euv" "" "ourr" "uiss" "uiss" "ouv"
      } in
    table {
      Indi Presn Sg P1 => p + variants {"eux" ; "uis"} ;
      t => p + tpouvoir ! t
      } ;

  conj3mouvoir : Str -> Verbe = \mouvoir -> 
    let {
      s = Predef.tk 7 mouvoir ;
      mu = adjReg "mû" ;
      tmouvoir = auxConj3usS "meu" "mouv" "meuv" "m" "mouvr" "meuv" "mouv" "mouv"
      } in
    table {
      Part (PPasse g n) => s + mu ! g ! n ;
      p => s + tmouvoir ! p
      } ;

  auxConj3seul3sg : (_,_,_,_,_ : Str) -> Verbe = 
    \faut, fall, pl, faudr, faill -> table {
      Inf                 => fall + "oir" ;
      Indi  Presn     Sg P3 => faut ;
      Indi  Imparf   Sg P3 => fall + "ait" ;
      Indi  Passe    Sg P3 => pl + "ut" ;
      Indi  Futur    Sg P3 => faudr + "a" ;
      Condi          Sg P3 => faudr + "ait" ;
      Subjo SPres   Sg P3 => faill + "e" ;
      Subjo SImparf Sg P3 => pl + "ût" ;
      Part PPres          => fall + "ant" ;
      Part (PPasse g n)   => adjReg (pl + "u") ! g ! n ;
      _                   => nonExist
      } ;

  conj3pleuvoir : Str -> Verbe = \pleuvoir ->
    let {
      pleuv = Predef.tk 3 pleuvoir ;
      pl    = Predef.tk 3 pleuv
      } in
    auxConj3seul3sg (pl + "eut") pleuv pl (pleuv + "r") pleuv ;

  conj3falloir : Str -> Verbe = \falloir ->
    let {
      fa   = Predef.tk 5 falloir ;
      fau  = fa + "u" ;
      fall = Predef.tk 3 falloir
      } in
    auxConj3seul3sg (fau + "t") fall fall (fau + "dr") (fa + "ill") ;

  conj3valoir : Str -> Verbe = \valoir ->
    let {
      va = Predef.tk 4 valoir ;
      val = va + "l"
    } in
    auxConj3usX (va + "u") val val val (va + "udr") (va + "ill") val val ;

  conj3vouloir : Str -> Verbe = \vouloir ->
    let {
      v  = Predef.tk 6 vouloir ;
      vo = v + "o" ;
      voul = vo + "ul" ;
      veul = v + "eul"
    } in
    auxConj3usX (v + "eu") voul veul voul (vo + "udr") (v + "euill") voul voul ;

-- The following two are both "asseoir" in the Bescherelle, which however 
-- points out that the latter conjugation has an infinitive form without "e"
-- since the orthographic rectifications of 1990.

  conj3asseoir : Str -> Verbe = \asseoir -> 
    let {
      ass = Predef.tk 4 asseoir ;
      tasseoir = auxConj3is "ied" "ey" "ey" "" "iér" "is" "is"
    } in 
    table {
      Inf => ass + "eoir" ;
      Indi Presn Sg P3 => ass + "ied" ;
      t => ass + tasseoir ! t
      } ;

  conj3assoir : Str -> Verbe = \assoir -> 
    let {
      ass = Predef.tk 3 assoir ;
      tassoir = auxConj3is "oi" "oy" "oi" "" "oir" "is" "is"
    } in 
    table {
      Inf => ass + variants {"oir" ; "eoir"} ;
      t => ass + tassoir ! t
      } ;

  conj3seoir : Str -> Verbe = \seoir -> 
    let {
      s = Predef.tk 4 seoir ;
      tseoir = conj3asseoir seoir
    } in
    table {
      Indi Presn   Pl P3 => s + "iéent" ;
      Indi _      _  P1 => nonExist ;
      Indi _      _  P2 => nonExist ;
      Indi Passe  _  _  => nonExist ;
      Condi       _  P1 => nonExist ;
      Condi       _  P2 => nonExist ;
      Subjo SPres Sg P3 => s + "iée" ;
      Subjo SPres Pl P3 => s + "iéent" ;
      Subjo _     _  _  => nonExist ;
      Imper _           => nonExist ;
      Part PPres        => s + "éant" ;      
      t => tseoir ! t
      } ;

-- Here we don't need a new conjugation.

  conj3messeoir : Str -> Verbe = \messeoir ->
    let {tmesseoir = conj3seoir messeoir} in
    table {
      Part (PPasse _ _) => nonExist ;
      p => tmesseoir ! p
      } ;

  conj3surseoir : Str -> Verbe = \surseoir ->
    let {
      surs = Predef.tk 4 surseoir ;
      tsurseoir = auxConj3is "oi" "oy" "oi" "" "eoir" "is" "is"
    } in
    table {
      Inf => surseoir ;
      t   => surs + tsurseoir ! t
      } ;

-- Here we interpolate and include the imperfect and subjunctive forms,
-- which Bescherelle leaves out.

  conj3choir : Str -> Verbe = \choir ->
    let {
      e = Predef.tk 5 choir ;
      tchoir = 
        auxConj3usS "choi" "choy" "choi" "ch" 
          (variants {"choir" ; "cherr"}) "choi" "choy" "ch"
    } in
    \\p => e + tchoir ! p ;

  conj3échoir : Str -> Verbe = \échoir -> 
    let {techoir = conj3choir échoir} in
    table {
      Indi _      _  P1 => nonExist ;
      Indi _      _  P2 => nonExist ;
      Indi Presn Pl P3   => Predef.tk 3 échoir + variants {"oient" ; "éent"} ;
      Subjo _    _  P1 => nonExist ;
      Subjo _    _  P2 => nonExist ;
      Condi       _  P1 => nonExist ;
      Condi       _  P2 => nonExist ;
      Imper _          => nonExist ;
      Part PPres       => Predef.tk 3 échoir + "éant" ;      
      t => techoir ! t 
      } ;
 
-- Verbs with the infinitive ending "re" are a major group within the third
-- conjugation. The worst-case macro takes 2 sets of affixes and 7 stems.

  auxConj3re : Affixe -> AffixPasse -> (_,_,_,_,_,_,_ : Str) -> Verbe =
     \affpr, affp -> \prend, pren, prenn, pr, prendr, pris, priss ->
    verbAffixes prend pren prenn pr prendr prenn pren 
                (prend + affpr ! P1) pris priss (prendr + "e") affpr affp ;

  auxConj3tre : (_,_ : Str) -> Verbe = \bat, batt -> 
    auxConj3re affixSgSsansT affixPasseI 
             bat batt batt batt (batt + "r") (batt + "u") (batt + "us") ;

  conj3rendre : Str -> Verbe = \rendre -> 
    let {rend = troncVerb rendre} in
    auxConj3tre rend rend ;

  conj3battre : Str -> Verbe = \battre -> 
    let {bat = Predef.tk 3 battre} in
    auxConj3tre bat (bat + "t") ;

  conj3prendre : Str -> Verbe = \prendre ->
    let {pr = Predef.tk 5 prendre} in
    auxConj3re 
       affixSgSsansT affixPasseI (pr + "end") (pr + "en") 
       (pr + "enn") pr (pr + "endr") (pr + "is") (pr + "is") ;

  conj3mettre : Str -> Verbe = \mettre ->
    let {m = Predef.tk 5 mettre ; met = m + "et"} in
    auxConj3re 
      affixSgSsansT affixPasseI met (met + "t") 
      (met + "t") m (met + "tr") (m + "is") (m + "is") ;

  conj3peindre : Str -> Verbe = \peindre -> 
    let {pe = Predef.tk 5 peindre ; peign = pe + "ign"} in
    auxConj3re 
      affixSgS affixPasseI
      (pe + "in") peign peign peign (pe + "indr") (pe + "int") (pe + "ints") ;

-- We don't need a separate conjugation for "joindre" and "craindre".

  conj3joindre = conj3peindre ;

  conj3craindre = conj3peindre ;

  conj3vaincre : Str -> Verbe = \vaincre -> 
    let {
      vainc = troncVerb vaincre ; 
      vainqu = Predef.tk 1 vainc + "qu"
     } in
     auxConj3re 
        affixSgSsansT affixPasseI
        vainc vainqu vainqu vainqu (vainc + "r") (vainc + "u") (vainc + "us") ;

  conj3traire : Str -> Verbe = \traire -> 
    let {
      tra  = Predef.tk 3 traire ; 
      trai = tra + "i" ; 
      tray = tra + "y" 
    } in
    auxConj3re 
      affixSgS affixPasseNonExist
      trai tray trai [] (trai + "r") (trai + "t") (trai + "ts") ;

-- The verb "faire" has a great many irregularities. Following Bescherelle, 
-- we have left out the plural 2nd person variant "faisez", which is a
-- 'grossier barbarisme'.

  conj3faire : Str -> Verbe = \faire -> 
    let {
      fai  = troncVerb faire ; 
      fais = fai + "s" ;
      f    = Predef.tk 2 fai ;
      tfaire = auxConj3re 
                 affixSgS affixPasseI 
                 fai fais (f + "ass") f (f + "er") (fai + "t") (fai + "ts")
      } in 
    table {
      Inf              => faire ;
      Indi  Presn  Pl P2 => fai + "tes" ;
      Indi  Presn  Pl P3 => f + "ont" ;
      Subjo SPres Pl p => f + "ass" + affixSPres ! Pl ! p ;
      Imper      PlP2  => fai + "tes" ;
      t => tfaire ! t
      } ;

  auxConj3oire : (_,_,_,_ : Str) -> Verbe = \boi, buv, boiv, b -> 
     auxConj3re 
       affixSgS affixPasseU boi buv boiv b (boi + "r") (b + "u") (b + "us") ;

  auxConj3ît : Verbe -> Str -> Verbe = \conj,plaît ->
    table {
      Indi Presn Sg P3 => plaît ;
      t => conj ! t
      } ;

  conj3plaire : Str -> Verbe = \plaire -> 
    let {
      pl = Predef.tk 4 plaire ;
      tplaire = auxConj3oire (pl + "ai") (pl + "ais") (pl + "ais") pl  
    } in
    auxConj3ît tplaire (pl + "aît") ;

  conj3connaître : Str -> Verbe = \connaître -> 
    let {
      conn = Predef.tk 5 connaître ;
      connaiss = conn + "aiss" ;
      tconnaitre = 
        auxConj3re 
          affixSgS affixPasseU (conn + "ai") connaiss connaiss 
          conn (conn + "aîtr") (conn + "u") (conn + "us")
    } in 
    auxConj3ît tconnaitre (conn + "aît") ;

  conj3naître : Str -> Verbe = \naître -> 
    let {
      n = Predef.tk 5 naître ;
      tnaitre = auxConj3re 
                   affixSgS affixPasseI
                   (n + "ai") (n + "aiss") (n + "aiss") (n + "aqu") 
                   (n + "aîtr") (n + "é") (n + "és")
    } in
    auxConj3ît tnaitre (n + "aît") ;

-- The conjugation of "paître" is defective in a curious way, especially
-- if compared with "repaître". According to Bescherelle, the invariable 
-- past participle is only used as a term of "fauconnerie" (one would expect it
-- to be defective rather than invariable).

  conj3paître : Str -> Verbe = \paître ->
    let {tpaitre = conj3connaître paître} in
    table {
      Indi Passe _ _     => nonExist ;
      Subjo SImparf _ _ => nonExist ;
      Part (PPasse _ _) => Predef.tk 5 paître + "u" ;
      p => tpaitre ! p
    } ;

  conj3repaître = conj3connaître ;

  conj3croître : Str -> Verbe = \croître ->
    let {cr = Predef.tk 5 croître} in
    auxConj3re 
      affixSgS (affixPasse "û" "û") (cr + "oî") (cr + "oiss") 
      (cr + "oiss") cr (cr + "oîtr") (cr + "û") (cr + "ûs") ;

  conj3croire : Str -> Verbe = \croire -> 
    let {cr = Predef.tk 4 croire} in
    auxConj3oire (cr + "oi") (cr + "oy") (cr + "oi") cr ;

  conj3boire : Str -> Verbe = \boire -> 
    let {b = Predef.tk 4 boire} in
    auxConj3oire (b + "oi") (b + "uv") (b + "oiv") b ;

-- The verb "clore" shows a systematic absence of past forms, 
-- including the imperfect indicative. What is more capricious, is the absence 
-- of the plural first and second persons in the present indicative and
-- the imperative.

  conj3clore : Str -> Verbe = \clore -> 
    let {
      clo = troncVerb clore ;
      clos = clo + "s" ;
      tclore = auxConj3re 
                 affixSgS affixPasseNonExist clo clos clos 
                 nonExist (clo + "r") clos clos
    } in
    table {
      Indi Presn Sg P3 => Predef.tk 1 clo + "ôt" ;
      Indi Presn Pl P1 => nonExist ;
      Indi Presn Pl P2 => nonExist ;
      Indi Imparf _ _ => nonExist ;
      Imper PlP1 => nonExist ;
      Imper PlP2 => nonExist ;
      t => tclore ! t
    } ;

  conj3conclure : Str -> Verbe = \conclure ->
    let {
      conclu = troncVerb conclure ;
      concl = Predef.tk 1 conclu
    } in
    auxConj3re 
      affixSgS affixPasseU
      conclu conclu conclu concl (conclu + "r") conclu (conclu + "s") ;

  conj3absoudre : Str -> Verbe = \absoudre ->
    let {
      abso = Predef.tk 4 absoudre ;
      tabsoudre = conj3résoudre absoudre
    } in
    table {
      Indi Passe _ _ => nonExist ;
      Subjo SImparf _ _ => nonExist ;
      Part (PPasse Masc _) => abso + "us" ;
      Part (PPasse Fem n) => nomReg (abso + "ute") ! n ;
      p => tabsoudre ! p
      } ;

  conj3résoudre : Str -> Verbe = \résoudre ->
    let {reso = Predef.tk 4 résoudre} in
    auxConj3re 
      affixSgS affixPasseU (reso + "u") (reso + "lv") (reso + "lv") 
      (reso + "l") (reso + "udr") (reso + "lu") (reso + "lus") ;

  conj3coudre : Str -> Verbe = \coudre ->
     let {
       cou  = Predef.tk 3 coudre ;
       cous = cou + "s"
     } in
     auxConj3re 
        affixSgSsansT affixPasseI
        (cou +"d") cous cous cous (cou + "dr") (cous + "u") (cous + "us") ;

  conj3moudre : Str -> Verbe = \moudre ->
     let {
       mou = Predef.tk 3 moudre ;
       moul = mou + "l"
     } in
     auxConj3re 
       affixSgSsansT affixPasseU
       (mou + "d") moul moul moul (mou + "dr") (moul + "u") (moul + "us") ;

  conj3suivre : Str -> Verbe = \suivre ->
    let {
      suiv  = troncVerb suivre ;
      sui   = Predef.tk 1 suiv ;
      suivi = suiv + "i"
    } in  
    auxConj3re 
      affixSgS affixPasseI sui suiv suiv suiv (suiv + "r") suivi (suivi+"s") ;

  conj3vivre : Str -> Verbe = \vivre ->
    let {
      viv = troncVerb vivre ;
      vi  = Predef.tk 1 viv ;
      véc = Predef.tk 1 vi + "éc"
    } in 
    auxConj3re 
      affixSgS affixPasseU vi viv viv véc (viv + "r") (véc + "u") (véc + "us") ;

  conj3lire : Str -> Verbe = \lire -> 
    let {
      li  = troncVerb lire ;
      lis = li + "s" ;
      l   = Predef.tk 1 li
    } in 
    auxConj3re affixSgS affixPasseU li lis lis l (li + "r") (l + "u") (l + "us") ;

  conj3dire : Str -> Verbe = \dire ->
    let {
      di  = troncVerb dire ;
      dis = di + "s" ;
      dit = di + "t" ;
      d   = Predef.tk 1 di ;
      tdire = auxConj3re 
                affixSgS affixPasseI di dis dis d (di + "r") dit (dit+"s")
    } in 
    table {
      Indi  Presn  Pl P2  => di + "tes" ;
      Imper      PlP2   => di + "tes" ;
      t => tdire ! t
      } ;

  conj3rire : Str -> Verbe = \rire ->
    let {
      ri  = troncVerb rire ;
      r   = Predef.tk 1 ri
    } in  
    auxConj3re affixSgS affixPasseI ri ri ri r (ri + "r") ri (ri+"s") ;

  auxConj3scrire : (_,_,_,_: Str) -> Verbe = \ecri, ecriv, ecrivi, ecrit -> 
    auxConj3re 
      affixSgS affixPasseI ecri ecriv ecriv ecrivi (ecri + "r") ecrit (ecrit+"s") ;

  conj3écrire : Str -> Verbe = \écrire ->
    let {écri = troncVerb écrire} in
    auxConj3scrire écri (écri + "v") (écri + "v") (écri + "t") ;

  conj3confire : Str -> Verbe = \confire -> 
    let {confi = troncVerb confire} in
    auxConj3scrire confi (confi + "s") (Predef.tk 1 confi) (confi + "t") ;

  conj3cuire : Str -> Verbe = \cuire -> 
    let {cui = troncVerb cuire} in
    auxConj3scrire cui (cui + "s") (cui + "s") (cui + "t") ;


--3 Very irregular verbs
--
-- Here we cannot do even with the 'worst case macro'.

  conj3aller : Str -> Verbe = \aller ->
    let {
      s = Predef.tk 5 aller ;
      pres = formesPresAi "v" "all" ;
      taller = verbHabituel 
                            "all" "all" "aill" "all" "ir" "allé" "aller"
                            affixSgS affixPasseA
    } in
    table {
      Indi  Presn    Sg P1 => s + "vais" ;
      Indi  Presn    n  p  => s + pres ! n ! p ;
      Indi  Imparf  n  p  => s + "all" + affixImparf ! n ! p ;
      Imper        SgP2  => s + "va" ;
      t                  => s + taller ! t
      } ;

  conjÊtre : Str -> Verbe = \etre -> 
    let {
      s = Predef.tk 4 etre ;
      sg = lesAffixes "suis" "es" "est" ;
      pl = lesAffixes "sommes" "êtes" "sont" ;
      tetre = verbHabituel 
                "soi" "soy" "soi" "f" "ser" "été" "être" affixSgS affixPasseU
    } in
    table {
      Indi  Presn    Sg p  => s + sg ! p ;
      Indi  Presn    Pl p  => s + pl ! p ;
      Indi  Imparf  n  p  => s + "ét"   + affixImparf ! n ! p ;
      Subjo SPres  Sg p  => s + "soi"  + affixSgS ! p ;
      Subjo SPres  Pl P3 => s + "soient" ;
      Subjo SPres  Pl p  => s + "soy"  + affixPlOns ! p ;
      Part PPres         => s + "étant" ;
      t                  => s + tetre ! t
      } ;

  conjAvoir : Str -> Verbe = \avoir ->
    let {
      s = Predef.tk 5 avoir ;
      pres = formesPresAi [] "av" ;
      tavoir = verbHabituel 
                 "ai" "ay" "ai" "e" "aur" "eu" "avoir" affixSgS affixPasseU
    } in
    table {
      Indi  Presn    n  p  => s + pres ! n ! p ;
      Indi  Imparf  n  p  => s + "av" + affixImparf ! n ! p ;
      Subjo SPres  Sg P3 => s + "ait" ;
      Subjo SPres  Pl P3 => s + "aient" ;
      Subjo SPres  Pl p  => s + "ay"  + affixPlOns ! p ;
      Imper        SgP2  => s + "aie" ;
      t                  => s + tavoir ! t
      } ;

--- for Numerals

param DForm = unit  | teen  | jten  | ten  | tenplus  ;
param Place = indep  | attr  ;

}
