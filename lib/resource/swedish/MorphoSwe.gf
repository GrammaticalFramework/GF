--1 A Simple Swedish Resource Morphology
--
-- Aarne Ranta 2002
--
-- This resource morphology contains definitions needed in the resource
-- syntax. It moreover contains copies of the most usual inflectional patterns
-- as defined in functional morphology (in the Haskell file $RulesSw.hs$).
--
-- We use the parameter types and word classes defined for morphology.

resource MorphoSwe = TypesSwe ** open Prelude in {

-- Nouns

oper
  mkNoun : (apa,apan,apor,aporna : Str) -> Subst =
  \apa,apan,apor,aporna ->  
 {s = table {
    SF Sg Indef c => mkCase c apa ;
    SF Sg Def c => mkCase c apan ;
    SF Pl Indef c => mkCase c apor ;
    SF Pl Def c => mkCase c aporna
    } ;
  h1 = case last apan of {
    "n" => Utr ;
    _ => Neutr
    }
  } ;

  reg2Noun : Str -> Str -> Subst = \bil,bilar -> 
   let 
     l  = last bil ;
     b  = Predef.tk 2 bil ; 
     ar = Predef.dp 2 bilar ;
     bile = Predef.tk 2 bilar
   in 
   case ar of {
      "or" => case l of {
         "a" => decl1Noun bil ;
         "r" => sLik bil ;
         "o" => mkNoun bil (bil + "n")  bilar (bilar + "na") ;
         _   => mkNoun bil (bil + "en") bilar (bilar + "na")
         } ;
      "ar" => ifTok Subst bil bilar 
                (decl5Noun bil) 
                (ifTok Subst bile bil 
                 (decl2Noun bil)
                 (case l of {
                    "e" => decl2Noun bil ; -- pojke-pojkar
                    _   => mkNoun bil (bile + "en") bilar (bilar + "na") -- mun-munnar
                    }
                 )
                ) ;
      "er" => case l of {
        "e" => sVarelse (init bil) ;
        "å" => sNivå bil ;
        _   => mkNoun bil (bil + "en") (bilar) (bilar + "na")
      } ;
      "en" => ifTok Subst bil bilar (sLik bil) (sRike bil) ; -- ben-ben
      _ => ifTok Subst bil bilar (
             case Predef.dp 3 bil of {
                "are" => sKikare (init bil) ; 
                _ => decl5Noun bil
                }
             )
             (decl5Noun bil) --- rest case with lots of garbage
      } ; 
         
--- this is a very rough heuristic as regards "ar/er"

  regNoun : Str -> Gender -> Subst = \bil,g -> case g of {
    Utr => case last bil of {
      "a" => decl1Noun bil ;
      _   => decl2Noun bil
      } ;
    Neutr => case last bil of {
      "e" => sRike bil ;
      _   => decl5Noun bil
      }
    } ;


  decl1Noun : Str -> Subst = \apa -> sApa (init apa) ;

  decl2Noun : Str -> Subst = \bil ->
    case last bil of {
      "e" => sPojke (init bil) ;
      "o" | "u" | "y" => mkNoun bil (bil + "n") (bil + "ar") (bil + "arna") ;
      _ => mkNoun bil (bil + "en") (bil + "ar") (bil + "arna")
      } ;

  decl3Noun : Str -> Subst = \sak ->
    case last sak of {
      "e" => sVarelse (init sak) ;
      "å" => sNivå sak ;
      _ => mkNoun sak (sak + "en") (sak + "er") (sak + "erna")
      } ;

  decl5Noun : Str -> Subst = \lik ->
    mkNoun lik (lik + "et") lik (lik + "en") ;


-- Adjectives


mkAdjPos : Str -> Str -> Str -> Str -> AdjFormPos -> Str ;
mkAdjPos liten litet lilla sma a = case a of {
  Strong gn => case gn of {
    ASg Utr => liten ;
    ASg Neutr => litet ;
    APl => sma
    } ;
  Weak sn => case sn of {
    AxSg NoMasc => lilla ;
    AxSg Masc => init lilla + "e" ;
    AxPl => sma
   }
  } ;

-- The worst-case macro for the full declension (including comparison forms)
-- is not so much worse.

mkAdjective : Str -> Str -> Str -> Str -> 
                     Str -> Str -> Str -> Adj ;
mkAdjective liten litet lilla sma mindre minst minsta = {s = table {
  AF (Posit p) c => mkCase c (mkAdjPos liten litet lilla sma p) ;
  AF Compar  c   => mkCase c mindre ;
  AF (Super SupStrong) c => mkCase c minst ;
  AF (Super SupWeak) c   => mkCase c minsta
  } 
} ;

-- It is handy to extract the positive part of a declension only, if
-- the other comparicon forms aren't needed or don't make sense.

extractPositive : Adj -> {s : AdjFormPos => Case => Str} ;
extractPositive adj = {s = \\a,c => adj.s ! (AF (Posit a) c)} ;

-- The notion of 'moderately irregular adjective' covers almost all adjectives.

adjIrreg : (_,_,_,_ : Str) -> Adj ;
adjIrreg god gott battre bast = 
  mkAdjective god gott (god + "a") (god + "a") battre bast (bast + "a") ;

-- Often it is possible to derive the $Pos Sg Neutr$ form even if the
-- comparison forms are irregular.

adjIrreg3 : (_,_,_: Str) -> Adj ;
adjIrreg3 ung yngre yngst = adjIrreg ung (ung + "t") yngre yngst ;

-- Some adjectives must be given $Pos Sg Utr$ $Pos Sg Neutr$, and $Pos Pl$,
-- e.g. those ending with unstressed "en".

adjAlmostReg : (_,_,_: Str) -> Adj ;
adjAlmostReg ljummen ljummet ljumma = 
  mkAdjective ljummen ljummet ljumma ljumma 
              (ljumma + "re") (ljumma + "st") (ljumma + "ste") ;

adjReg : Str -> Adj = \fin -> adjAlmostReg fin (fin + "t") (fin + "a") ;

adj2Reg : Str -> Str -> Adj = \vid,vitt -> adjAlmostReg vid vitt (vid + "a") ;


-- Verbs

  mkVerb : (supa,super,sup,söp,supit,supen : Str) -> Verb = 
   \finna,finner,finn,fann,funnit,funnen ->
    let funn = ptPretForms funnen in
    {s = table {
    VF (Pres Act) => finner ;
    VF (Pres Pass) => mkVoice Pass finn ;
    VF (Pret v) => mkVoice v fann ;
    VF (Imper v) => mkVoice v finn ;
    VI (Inf v) => mkVoice v finna ;
    VI (Supin v) => mkVoice v funnit ;
    VI (PtPret a c) => funn ! a ! c
    } ;
     s1 = []
   } ;

  vFinna : (_,_,_ : Str) -> Verb = \finn, fann, funn -> 
    mkVerb (finn + "a") (finn + "er") finn fann (funn + "it") (funn + "en") ;

-- Now this is more general and subsumes $vFinna$.

  vSälja : (_,_,_ : Str) -> Verb = \sälja, sålde, sålt -> 
    let
      a = last sälja ; 
      sälj = case a of {
        "a" => init sälja ;
        _ => sälja
        } ;
      er = case a of {
        "a" => "er" ;
        _ => "r"
        } ;
      såld = case Predef.dp 2 sålt of {
        "it" => Predef.tk 2 sålt + "en" ;
        "tt" => Predef.tk 2 sålt + "dd" ;
        _ => init sålt + "d"
        }
    in 
    mkVerb sälja (sälj + er) sälj sålde sålt såld ;

  regVerb : (_,_ : Str) -> Verb = \tala,talade -> 
    let 
      ade   = Predef.dp 3 talade ;
      de    = Predef.dp 2 ade ;
      tal   = Predef.tk 1 tala ;
      forms = case ade of {
        "ade" => vTala tal ;
        "dde" => case last tala of {
          "a" => vTyda (init tal) ;
          _ => mkVerb tala (tala + "r") tala (tala + "dde") (tala + "tt") (tala + "dd")
          } ;
        "tte" => vByta (init tal) ;
        "nde" => vVända (init tal) ;
        "rde" => vHyra tal ;
        _ => case de of {
          "te" => vLeka tal ;
          _    => vGräva tal
          }
        }
      in forms ** {s1 = []} ;

  ptPretForms : Str -> AdjFormPos => Case => Str = \funnen -> \\a,c =>  
  let 
    funn  = Predef.tk 2 funnen ;
    en    = Predef.dp 2 funnen ;
    funne = init funnen ;
    n     = last funnen ;
    m     = case last funn of {
      "n" => [] ;
      _ => "n"
      } ;
    funna = case en of {
     "en" => case a of {
       (Strong (ASg Utr)) => funn + "en" ;
       (Strong (ASg Neutr)) => funn + "et" ;
       (Weak (AxSg Masc)) => funn + m + "e" ;
       _ => funn + m + "a"
       } ;
     "dd" => case a of {
       (Strong (ASg Utr)) => funn + "dd" ;
       (Strong (ASg Neutr)) => funn + "tt" ;
       (Weak (AxSg Masc)) => funn + "dde" ;
       _ => funn + "dda"
       } ;
     "ad" => case a of {
       (Strong (ASg Utr)) => funn + "ad" ;
       (Strong (ASg Neutr)) => funn + "at" ;
       _ => funn + "ade"
       } ;
     _ => case n of {
       "d" => case a of {
         (Strong (ASg Utr)) => funne + "d" ;
         (Strong (ASg Neutr)) => funne + "t" ;
         (Weak (AxSg Masc)) => funne + "de" ;
         _ => funne + "da"
         } ;
       _ => case a of {
         (Strong (ASg Utr)) => funne + "t" ;
         (Strong (ASg Neutr)) => funne + "t" ;
         (Weak (AxSg Masc)) => funne + "te" ;
         _ => funne + "ta"
         }
      }
  }
  in 
  mkCase c funna ;

mkCase : Case -> Str -> Str = \c,f -> case c of {
      Nom => f ;
      Gen => f + case last f of {
        "s" | "x" => [] ;
        _ => "s"
        }
      } ;

mkVoice : Voice -> Str -> Str = \c,f -> case c of {
      Act  => f ;
      Pass => f + case last f of {
        "s" => "es" ;
        _ => "s"
        }
      } ;

-- The most common is a verb without a particle.

  mkVerbPart : (_,_,_,_,_,_,_ : Str) -> Verb = \supa,super,sup,söp,supit,supen,upp ->
    {s = (mkVerb supa super sup söp supit supen).s} ** {s1 = upp} ; 

-- Prepositions are just strings.
  Preposition = Str ;

-- Relative pronouns have a special case system. $RPrep$ is the form used
-- after a preposition (e.g. "det hus i vilket jag bor").
param
  RelCase = RNom | RAcc | RGen | RPrep ;

oper
  relPronForms : RelCase => GenNum => Str = table {
    RNom  => \\_ => "som" ;
    RAcc  => \\_ => variants {"som" ; []} ;
    RGen  => \\_ => "vars" ;
    RPrep => pronVilken
    } ;
  
  pronVilken = table {
      ASg Utr   => "vilken" ; 
      ASg Neutr => "vilket" ; 
      APl       => "vilka"
      } ;

  pronSådan = table {
      ASg Utr   => "sådan" ; 
      ASg Neutr => "sådant" ; 
      APl       => "sådana"
      } ;

-- What follows are machine-generated inflection paradigms from functional 
-- morphology. Hence they are low-level paradigms, without any 
-- abstractions or generalizations: the Haskell code is better in these respects.
-- 
-- The variable names are selected in such a way that the paradigms can be read
-- as inflection tables of certain words.

oper sApa : Str -> Subst = \ap -> 
 {s = table {
    SF Sg Indef Nom => ap + "a" ;
    SF Sg Indef Gen => ap + "as" ;
    SF Sg Def Nom => ap + "an" ;
    SF Sg Def Gen => ap + "ans" ;
    SF Pl Indef Nom => ap + "or" ;
    SF Pl Indef Gen => ap + "ors" ;
    SF Pl Def Nom => ap + "orna" ;
    SF Pl Def Gen => ap + "ornas"
    } ;
  h1 = Utr
  } ;

oper sBil : Str -> Subst = \bil -> 
 {s = table {
    SF Sg Indef Nom => bil ;
    SF Sg Indef Gen => bil + "s" ;
    SF Sg Def Nom => bil + "en" ;
    SF Sg Def Gen => bil + "ens" ;
    SF Pl Indef Nom => bil + "ar" ;
    SF Pl Indef Gen => bil + "ars" ;
    SF Pl Def Nom => bil + "arna" ;
    SF Pl Def Gen => bil + "arnas"
    } ;
  h1 = Utr
  } ;

oper sPojke : Str -> Subst = \pojk -> 
 {s = table {
    SF Sg Indef Nom => pojk + "e" ;
    SF Sg Indef Gen => pojk + "es" ;
    SF Sg Def Nom => pojk + "en" ;
    SF Sg Def Gen => pojk + "ens" ;
    SF Pl Indef Nom => pojk + "ar" ;
    SF Pl Indef Gen => pojk + "ars" ;
    SF Pl Def Nom => pojk + "arna" ;
    SF Pl Def Gen => pojk + "arnas"
    } ;
  h1 = Utr
  } ;

oper sNyckel : Str -> Subst = \nyck -> 
 {s = table {
    SF Sg Indef Nom => nyck + "el" ;
    SF Sg Indef Gen => nyck + "els" ;
    SF Sg Def Nom => nyck + "eln" ;
    SF Sg Def Gen => nyck + "elns" ;
    SF Pl Indef Nom => nyck + "lar" ;
    SF Pl Indef Gen => nyck + "lars" ;
    SF Pl Def Nom => nyck + "larna" ;
    SF Pl Def Gen => nyck + "larnas"
    } ;
  h1 = Utr
  } ;

oper sKam : Str -> Subst = \kam -> 
 {s = table {
    SF Sg Indef Nom => kam ;
    SF Sg Indef Gen => kam + "s" ;
    SF Sg Def Nom => kam + "men" ;
    SF Sg Def Gen => kam + "mens" ;
    SF Pl Indef Nom => kam + "mar" ;
    SF Pl Indef Gen => kam + "mars" ;
    SF Pl Def Nom => kam + "marna" ;
    SF Pl Def Gen => kam + "marnas"
    } ;
  h1 = Utr
  } ;

oper sSak : Str -> Subst = \sak -> 
 {s = table {
    SF Sg Indef Nom => sak ;
    SF Sg Indef Gen => sak + "s" ;
    SF Sg Def Nom => sak + "en" ;
    SF Sg Def Gen => sak + "ens" ;
    SF Pl Indef Nom => sak + "er" ;
    SF Pl Indef Gen => sak + "ers" ;
    SF Pl Def Nom => sak + "erna" ;
    SF Pl Def Gen => sak + "ernas"
    } ;
  h1 = Utr
  } ;

oper sVarelse : Str -> Subst = \varelse -> 
 {s = table {
    SF Sg Indef Nom => varelse ;
    SF Sg Indef Gen => varelse + "s" ;
    SF Sg Def Nom => varelse + "n" ;
    SF Sg Def Gen => varelse + "ns" ;
    SF Pl Indef Nom => varelse + "r" ;
    SF Pl Indef Gen => varelse + "rs" ;
    SF Pl Def Nom => varelse + "rna" ;
    SF Pl Def Gen => varelse + "rnas"
    } ;
  h1 = Utr
  } ;

oper sNivå : Str -> Subst = \nivå -> 
 {s = table {
    SF Sg Indef Nom => nivå ;
    SF Sg Indef Gen => nivå + "s" ;
    SF Sg Def Nom => nivå + "n" ;
    SF Sg Def Gen => nivå + "ns" ;
    SF Pl Indef Nom => nivå + "er" ;
    SF Pl Indef Gen => nivå + "ers" ;
    SF Pl Def Nom => nivå + "erna" ;
    SF Pl Def Gen => nivå + "ernas"
    } ;
  h1 = Utr
  } ;

oper sParti : Str -> Subst = \parti -> 
 {s = table {
    SF Sg Indef Nom => parti ;
    SF Sg Indef Gen => parti + "s" ;
    SF Sg Def Nom => parti + "et" ;
    SF Sg Def Gen => parti + "ets" ;
    SF Pl Indef Nom => parti + "er" ;
    SF Pl Indef Gen => parti + "ers" ;
    SF Pl Def Nom => parti + "erna" ;
    SF Pl Def Gen => parti + "ernas"
    } ;
  h1 = Neutr
  } ;

oper sMuseum : Str -> Subst = \muse -> 
 {s = table {
    SF Sg Indef Nom => muse + "um" ;
    SF Sg Indef Gen => muse + "ums" ;
    SF Sg Def Nom => muse + "et" ;
    SF Sg Def Gen => muse + "ets" ;
    SF Pl Indef Nom => muse + "er" ;
    SF Pl Indef Gen => muse + "ers" ;
    SF Pl Def Nom => muse + "erna" ;
    SF Pl Def Gen => muse + "ernas"
    } ;
  h1 = Neutr
  } ;

oper sRike : Str -> Subst = \rike -> 
 {s = table {
    SF Sg Indef Nom => rike ;
    SF Sg Indef Gen => rike + "s" ;
    SF Sg Def Nom => rike + "t" ;
    SF Sg Def Gen => rike + "ts" ;
    SF Pl Indef Nom => rike + "n" ;
    SF Pl Indef Gen => rike + "ns" ;
    SF Pl Def Nom => rike + "na" ;
    SF Pl Def Gen => rike + "nas"
    } ;
  h1 = Neutr
  } ;

oper sLik : Str -> Subst = \lik -> 
 {s = table {
    SF Sg Indef Nom => lik ;
    SF Sg Indef Gen => lik + "s" ;
    SF Sg Def Nom => lik + "et" ;
    SF Sg Def Gen => lik + "ets" ;
    SF Pl Indef Nom => lik ;
    SF Pl Indef Gen => lik + "s" ;
    SF Pl Def Nom => lik + "en" ;
    SF Pl Def Gen => lik + "ens"
    } ;
  h1 = Neutr
  } ;

oper sRum : Str -> Subst = \rum -> 
 {s = table {
    SF Sg Indef Nom => rum ;
    SF Sg Indef Gen => rum + "s" ;
    SF Sg Def Nom => rum + "met" ;
    SF Sg Def Gen => rum + "mets" ;
    SF Pl Indef Nom => rum ;
    SF Pl Indef Gen => rum + "s" ;
    SF Pl Def Nom => rum + "men" ;
    SF Pl Def Gen => rum + "mens"
    } ;
  h1 = Neutr
  } ;

oper sHus : Str -> Subst = \hus -> 
 {s = table {
    SF Sg Indef Nom => hus ;
    SF Sg Indef Gen => hus ;
    SF Sg Def Nom => hus + "et" ;
    SF Sg Def Gen => hus + "ets" ;
    SF Pl Indef Nom => hus ;
    SF Pl Indef Gen => hus ;
    SF Pl Def Nom => hus + "en" ;
    SF Pl Def Gen => hus + "ens"
    } ;
  h1 = Neutr
  } ;

oper sPapper : Str -> Subst = \papp -> 
 {s = table {
    SF Sg Indef Nom => papp + "er" ;
    SF Sg Indef Gen => papp + "ers" ;
    SF Sg Def Nom => papp + "ret" ;
    SF Sg Def Gen => papp + "rets" ;
    SF Pl Indef Nom => papp + "er" ;
    SF Pl Indef Gen => papp + "ers" ;
    SF Pl Def Nom => papp + "ren" ;
    SF Pl Def Gen => papp + "rens"
    } ;
  h1 = Neutr
  } ;

oper sNummer : Str -> Subst = \num -> 
 {s = table {
    SF Sg Indef Nom => num + "mer" ;
    SF Sg Indef Gen => num + "mers" ;
    SF Sg Def Nom => num + "ret" ;
    SF Sg Def Gen => num + "rets" ;
    SF Pl Indef Nom => num + "mer" ;
    SF Pl Indef Gen => num + "mers" ;
    SF Pl Def Nom => num + "ren" ;
    SF Pl Def Gen => num + "rens"
    } ;
  h1 = Neutr
  } ;

oper sKikare : Str -> Subst = \kikar -> 
 {s = table {
    SF Sg Indef Nom => kikar + "e" ;
    SF Sg Indef Gen => kikar + "es" ;
    SF Sg Def Nom => kikar + "en" ;
    SF Sg Def Gen => kikar + "ens" ;
    SF Pl Indef Nom => kikar + "e" ;
    SF Pl Indef Gen => kikar + "es" ;
    SF Pl Def Nom => kikar + "na" ;
    SF Pl Def Gen => kikar + "nas"
    } ;
  h1 = Utr
  } ;

oper sProgram : Str -> Subst = \program -> 
 {s = table {
    SF Sg Indef Nom => program ;
    SF Sg Indef Gen => program + "s" ;
    SF Sg Def Nom => program + "met" ;
    SF Sg Def Gen => program + "mets" ;
    SF Pl Indef Nom => program ;
    SF Pl Indef Gen => program + "s" ;
    SF Pl Def Nom => program + "men" ;
    SF Pl Def Gen => program + "mens"
    } ;
  h1 = Neutr
  } ;

oper aFin : Str -> Adj = \fin -> 
 {s = table {
    AF (Posit (Strong (ASg Utr))) Nom => fin ;
    AF (Posit (Strong (ASg Utr))) Gen => fin + "s" ;
    AF (Posit (Strong (ASg Neutr))) Nom => fin + "t" ;
    AF (Posit (Strong (ASg Neutr))) Gen => fin + "ts" ;
    AF (Posit (Strong APl)) Nom => fin + "a" ;
    AF (Posit (Strong APl)) Gen => fin + "as" ;
    AF (Posit (Weak (AxSg NoMasc))) Nom => fin + "a" ;
    AF (Posit (Weak (AxSg NoMasc))) Gen => fin + "as" ;
    AF (Posit (Weak (AxSg Masc))) Nom => fin + "e" ;
    AF (Posit (Weak (AxSg Masc))) Gen => fin + "es" ;
    AF (Posit (Weak AxPl)) Nom => fin + "a" ;
    AF (Posit (Weak AxPl)) Gen => fin + "as" ;
    AF Compar Nom => fin + "are" ;
    AF Compar Gen => fin + "ares" ;
    AF (Super SupStrong) Nom => fin + "ast" ;
    AF (Super SupStrong) Gen => fin + "asts" ;
    AF (Super SupWeak) Nom => fin + "aste" ;
    AF (Super SupWeak) Gen => fin + "astes"
    }
  } ;

oper aFager : Str -> Adj = \fag -> 
 {s = table {
    AF (Posit (Strong (ASg Utr))) Nom => fag + "er" ;
    AF (Posit (Strong (ASg Utr))) Gen => fag + "ers" ;
    AF (Posit (Strong (ASg Neutr))) Nom => fag + "ert" ;
    AF (Posit (Strong (ASg Neutr))) Gen => fag + "erts" ;
    AF (Posit (Strong APl)) Nom => fag + "era" ;
    AF (Posit (Strong APl)) Gen => fag + "eras" ;
    AF (Posit (Weak (AxSg NoMasc))) Nom => fag + "era" ;
    AF (Posit (Weak (AxSg NoMasc))) Gen => fag + "eras" ;
    AF (Posit (Weak (AxSg Masc))) Nom => fag + "ere" ;
    AF (Posit (Weak (AxSg Masc))) Gen => fag + "eres" ;
    AF (Posit (Weak AxPl)) Nom => fag + "era" ;
    AF (Posit (Weak AxPl)) Gen => fag + "eras" ;
    AF Compar Nom => fag + "erare" ;
    AF Compar Gen => fag + "erares" ;
    AF (Super SupStrong) Nom => fag + "erast" ;
    AF (Super SupStrong) Gen => fag + "erasts" ;
    AF (Super SupWeak) Nom => fag + "eraste" ;
    AF (Super SupWeak) Gen => fag + "erastes"
    }
  } ;

oper aGrund : Str -> Adj = \grun -> 
 {s = table {
    AF (Posit (Strong (ASg Utr))) Nom => grun + "d" ;
    AF (Posit (Strong (ASg Utr))) Gen => grun + "ds" ;
    AF (Posit (Strong (ASg Neutr))) Nom => grun + "t" ;
    AF (Posit (Strong (ASg Neutr))) Gen => grun + "ts" ;
    AF (Posit (Strong APl)) Nom => grun + "da" ;
    AF (Posit (Strong APl)) Gen => grun + "das" ;
    AF (Posit (Weak (AxSg NoMasc))) Nom => grun + "da" ;
    AF (Posit (Weak (AxSg NoMasc))) Gen => grun + "das" ;
    AF (Posit (Weak (AxSg Masc))) Nom => grun + "de" ;
    AF (Posit (Weak (AxSg Masc))) Gen => grun + "des" ;
    AF (Posit (Weak AxPl)) Nom => grun + "da" ;
    AF (Posit (Weak AxPl)) Gen => grun + "das" ;
    AF Compar Nom => grun + "dare" ;
    AF Compar Gen => grun + "dares" ;
    AF (Super SupStrong) Nom => grun + "dast" ;
    AF (Super SupStrong) Gen => grun + "dasts" ;
    AF (Super SupWeak) Nom => grun + "daste" ;
    AF (Super SupWeak) Gen => grun + "dastes"
    }
  } ;

oper aVid : Str -> Adj = \vi -> 
 {s = table {
    AF (Posit (Strong (ASg Utr))) Nom => vi + "d" ;
    AF (Posit (Strong (ASg Utr))) Gen => vi + "ds" ;
    AF (Posit (Strong (ASg Neutr))) Nom => vi + "tt" ;
    AF (Posit (Strong (ASg Neutr))) Gen => vi + "tts" ;
    AF (Posit (Strong APl)) Nom => vi + "da" ;
    AF (Posit (Strong APl)) Gen => vi + "das" ;
    AF (Posit (Weak (AxSg NoMasc))) Nom => vi + "da" ;
    AF (Posit (Weak (AxSg NoMasc))) Gen => vi + "das" ;
    AF (Posit (Weak (AxSg Masc))) Nom => vi + "de" ;
    AF (Posit (Weak (AxSg Masc))) Gen => vi + "des" ;
    AF (Posit (Weak AxPl)) Nom => vi + "da" ;
    AF (Posit (Weak AxPl)) Gen => vi + "das" ;
    AF Compar Nom => vi + "dare" ;
    AF Compar Gen => vi + "dares" ;
    AF (Super SupStrong) Nom => vi + "dast" ;
    AF (Super SupStrong) Gen => vi + "dasts" ;
    AF (Super SupWeak) Nom => vi + "daste" ;
    AF (Super SupWeak) Gen => vi + "dastes"
    }
  } ;

oper aVaken : Str -> Adj = \vak -> 
 {s = table {
    AF (Posit (Strong (ASg Utr))) Nom => vak + "en" ;
    AF (Posit (Strong (ASg Utr))) Gen => vak + "ens" ;
    AF (Posit (Strong (ASg Neutr))) Nom => vak + "et" ;
    AF (Posit (Strong (ASg Neutr))) Gen => vak + "ets" ;
    AF (Posit (Strong APl)) Nom => vak + "na" ;
    AF (Posit (Strong APl)) Gen => vak + "nas" ;
    AF (Posit (Weak (AxSg NoMasc))) Nom => vak + "na" ;
    AF (Posit (Weak (AxSg NoMasc))) Gen => vak + "nas" ;
    AF (Posit (Weak (AxSg Masc))) Nom => vak + "ne" ;
    AF (Posit (Weak (AxSg Masc))) Gen => vak + "nes" ;
    AF (Posit (Weak AxPl)) Nom => vak + "na" ;
    AF (Posit (Weak AxPl)) Gen => vak + "nas" ;
    AF Compar Nom => vak + "nare" ;
    AF Compar Gen => vak + "nares" ;
    AF (Super SupStrong) Nom => vak + "nast" ;
    AF (Super SupStrong) Gen => vak + "nasts" ;
    AF (Super SupWeak) Nom => vak + "naste" ;
    AF (Super SupWeak) Gen => vak + "nastes"
    }
  } ;

oper aKorkad : Str -> Adj = \korka -> 
 {s = table {
    AF (Posit (Strong (ASg Utr))) Nom => korka + "d" ;
    AF (Posit (Strong (ASg Utr))) Gen => korka + "ds" ;
    AF (Posit (Strong (ASg Neutr))) Nom => korka + "t" ;
    AF (Posit (Strong (ASg Neutr))) Gen => korka + "ts" ;
    AF (Posit (Strong APl)) Nom => korka + "de" ;
    AF (Posit (Strong APl)) Gen => korka + "des" ;
    AF (Posit (Weak (AxSg NoMasc))) Nom => korka + "de" ;
    AF (Posit (Weak (AxSg NoMasc))) Gen => korka + "des" ;
    AF (Posit (Weak (AxSg Masc))) Nom => korka + "de" ;
    AF (Posit (Weak (AxSg Masc))) Gen => korka + "des" ;
    AF (Posit (Weak AxPl)) Nom => korka + "de" ;
    AF (Posit (Weak AxPl)) Gen => korka + "des" ;
    AF Compar Nom => variants {} ;
    AF Compar Gen => variants {} ;
    AF (Super SupStrong) Nom => variants {} ;
    AF (Super SupStrong) Gen => variants {} ;
    AF (Super SupWeak) Nom => variants {} ;
    AF (Super SupWeak) Gen => variants {}
    }
  } ;

oper aAbstrakt : Str -> Adj = \abstrakt -> 
 {s = table {
    AF (Posit (Strong (ASg Utr))) Nom => abstrakt ;
    AF (Posit (Strong (ASg Utr))) Gen => abstrakt + "s" ;
    AF (Posit (Strong (ASg Neutr))) Nom => abstrakt ;
    AF (Posit (Strong (ASg Neutr))) Gen => abstrakt + "s" ;
    AF (Posit (Strong APl)) Nom => abstrakt + "a" ;
    AF (Posit (Strong APl)) Gen => abstrakt + "as" ;
    AF (Posit (Weak (AxSg NoMasc))) Nom => abstrakt + "a" ;
    AF (Posit (Weak (AxSg NoMasc))) Gen => abstrakt + "as" ;
    AF (Posit (Weak (AxSg Masc))) Nom => abstrakt + "e" ;
    AF (Posit (Weak (AxSg Masc))) Gen => abstrakt + "es" ;
    AF (Posit (Weak AxPl)) Nom => abstrakt + "a" ;
    AF (Posit (Weak AxPl)) Gen => abstrakt + "as" ;
    AF Compar Nom => abstrakt + "are" ;
    AF Compar Gen => abstrakt + "ares" ;
    AF (Super SupStrong) Nom => abstrakt + "ast" ;
    AF (Super SupStrong) Gen => abstrakt + "asts" ;
    AF (Super SupWeak) Nom => abstrakt + "aste" ;
    AF (Super SupWeak) Gen => abstrakt + "astes"
    }
  } ;

oper vTala : Str -> Verbum = \tal -> 
 {s = table {
    VF (Pres Act) => tal + "ar" ;
    VF (Pres Pass) => tal + "as" ;
    VF (Pret Act) => tal + "ade" ;
    VF (Pret Pass) => tal + "ades" ;
    VF (Imper Act) => tal + "a" ;
    VF (Imper Pass) => tal + "as" ;
    VI (Inf Act) => tal + "a" ;
    VI (Inf Pass) => tal + "as" ;
    VI (Supin Act) => tal + "at" ;
    VI (Supin Pass) => tal + "ats" ;
    VI (PtPret (Strong (ASg Utr)) Nom) => tal + "ad" ;
    VI (PtPret (Strong (ASg Utr)) Gen) => tal + "ads" ;
    VI (PtPret (Strong (ASg Neutr)) Nom) => tal + "at" ;
    VI (PtPret (Strong (ASg Neutr)) Gen) => tal + "ats" ;
    VI (PtPret (Strong APl) Nom) => tal + "ade" ;
    VI (PtPret (Strong APl) Gen) => tal + "ades" ;
    VI (PtPret (Weak (AxSg NoMasc)) Nom) => tal + "ade" ;
    VI (PtPret (Weak (AxSg NoMasc)) Gen) => tal + "ades" ;
    VI (PtPret (Weak (AxSg Masc)) Nom) => tal + "ade" ;
    VI (PtPret (Weak (AxSg Masc)) Gen) => tal + "ades" ;
    VI (PtPret (Weak AxPl) Nom) => tal + "ade" ;
    VI (PtPret (Weak AxPl) Gen) => tal + "ades"
    }
  } ;

oper vLeka : Str -> Verbum = \lek -> 
 {s = table {
    VF (Pres Act) => lek + "er" ;
    VF (Pres Pass) => mkVoice Pass lek ;
    VF (Pret Act) => lek + "te" ;
    VF (Pret Pass) => lek + "tes" ;
    VF (Imper v) => mkVoice v lek ;
    VI (Inf Act) => lek + "a" ;
    VI (Inf Pass) => lek + "as" ;
    VI (Supin Act) => lek + "t" ;
    VI (Supin Pass) => lek + "ts" ;
    VI (PtPret (Strong (ASg Utr)) Nom) => lek + "t" ;
    VI (PtPret (Strong (ASg Utr)) Gen) => lek + "ts" ;
    VI (PtPret (Strong (ASg Neutr)) Nom) => lek + "t" ;
    VI (PtPret (Strong (ASg Neutr)) Gen) => lek + "ts" ;
    VI (PtPret (Strong APl) Nom) => lek + "ta" ;
    VI (PtPret (Strong APl) Gen) => lek + "tas" ;
    VI (PtPret (Weak (AxSg NoMasc)) Nom) => lek + "ta" ;
    VI (PtPret (Weak (AxSg NoMasc)) Gen) => lek + "tas" ;
    VI (PtPret (Weak (AxSg Masc)) Nom) => lek + "te" ;
    VI (PtPret (Weak (AxSg Masc)) Gen) => lek + "tes" ;
    VI (PtPret (Weak AxPl) Nom) => lek + "ta" ;
    VI (PtPret (Weak AxPl) Gen) => lek + "tas"
    }
  } ;

oper vGräva : Str -> Verbum = \gräv -> 
 {s = table {
    VF (Pres Act) => gräv + "er" ;
    VF (Pres Pass) => mkVoice Pass gräv ;
    VF (Pret Act) => gräv + "de" ;
    VF (Pret Pass) => gräv + "des" ;
    VF (Imper v) => mkVoice v gräv ;
    VI (Inf Act) => gräv + "a" ;
    VI (Inf Pass) => gräv + "as" ;
    VI (Supin Act) => gräv + "t" ;
    VI (Supin Pass) => gräv + "ts" ;
    VI (PtPret (Strong (ASg Utr)) Nom) => gräv + "d" ;
    VI (PtPret (Strong (ASg Utr)) Gen) => gräv + "ds" ;
    VI (PtPret (Strong (ASg Neutr)) Nom) => gräv + "t" ;
    VI (PtPret (Strong (ASg Neutr)) Gen) => gräv + "ts" ;
    VI (PtPret (Strong APl) Nom) => gräv + "da" ;
    VI (PtPret (Strong APl) Gen) => gräv + "das" ;
    VI (PtPret (Weak (AxSg NoMasc)) Nom) => gräv + "da" ;
    VI (PtPret (Weak (AxSg NoMasc)) Gen) => gräv + "das" ;
    VI (PtPret (Weak (AxSg Masc)) Nom) => gräv + "de" ;
    VI (PtPret (Weak (AxSg Masc)) Gen) => gräv + "des" ;
    VI (PtPret (Weak AxPl) Nom) => gräv + "da" ;
    VI (PtPret (Weak AxPl) Gen) => gräv + "das"
    }
  } ;

oper vTyda : Str -> Verbum = \ty -> 
 {s = table {
    VF (Pres Act) => ty + "der" ;
    VF (Pres Pass) => variants {ty + "ds" ; ty + "des"} ;
    VF (Pret Act) => ty + "dde" ;
    VF (Pret Pass) => ty + "ddes" ;
    VF (Imper Act) => ty + "d" ;
    VF (Imper Pass) => ty + "ds" ;
    VI (Inf Act) => ty + "da" ;
    VI (Inf Pass) => ty + "das" ;
    VI (Supin Act) => ty + "tt" ;
    VI (Supin Pass) => ty + "tts" ;
    VI (PtPret (Strong (ASg Utr)) Nom) => ty + "dd" ;
    VI (PtPret (Strong (ASg Utr)) Gen) => ty + "dds" ;
    VI (PtPret (Strong (ASg Neutr)) Nom) => ty + "tt" ;
    VI (PtPret (Strong (ASg Neutr)) Gen) => ty + "tts" ;
    VI (PtPret (Strong APl) Nom) => ty + "dda" ;
    VI (PtPret (Strong APl) Gen) => ty + "ddas" ;
    VI (PtPret (Weak (AxSg NoMasc)) Nom) => ty + "dda" ;
    VI (PtPret (Weak (AxSg NoMasc)) Gen) => ty + "ddas" ;
    VI (PtPret (Weak (AxSg Masc)) Nom) => ty + "dde" ;
    VI (PtPret (Weak (AxSg Masc)) Gen) => ty + "ddes" ;
    VI (PtPret (Weak AxPl) Nom) => ty + "dda" ;
    VI (PtPret (Weak AxPl) Gen) => ty + "ddas"
    }
  } ;

oper vVända : Str -> Verbum = \vän -> 
 {s = table {
    VF (Pres Act) => vän + "der" ;
    VF (Pres Pass) => variants {vän + "ds" ; vän + "des"} ;
    VF (Pret Act) => vän + "de" ;
    VF (Pret Pass) => vän + "des" ;
    VF (Imper Act) => vän + "d" ;
    VF (Imper Pass) => vän + "ds" ;
    VI (Inf Act) => vän + "da" ;
    VI (Inf Pass) => vän + "das" ;
    VI (Supin Act) => vän + "t" ;
    VI (Supin Pass) => vän + "ts" ;
    VI (PtPret (Strong (ASg Utr)) Nom) => vän + "d" ;
    VI (PtPret (Strong (ASg Utr)) Gen) => vän + "ds" ;
    VI (PtPret (Strong (ASg Neutr)) Nom) => vän + "t" ;
    VI (PtPret (Strong (ASg Neutr)) Gen) => vän + "ts" ;
    VI (PtPret (Strong APl) Nom) => vän + "da" ;
    VI (PtPret (Strong APl) Gen) => vän + "das" ;
    VI (PtPret (Weak (AxSg NoMasc)) Nom) => vän + "da" ;
    VI (PtPret (Weak (AxSg NoMasc)) Gen) => vän + "das" ;
    VI (PtPret (Weak (AxSg Masc)) Nom) => vän + "de" ;
    VI (PtPret (Weak (AxSg Masc)) Gen) => vän + "des" ;
    VI (PtPret (Weak AxPl) Nom) => vän + "da" ;
    VI (PtPret (Weak AxPl) Gen) => vän + "das"
    }
  } ;

oper vByta : Str -> Verbum = \by -> 
 {s = table {
    VF (Pres Act) => by + "ter" ;
    VF (Pres Pass) => variants {by + "ts" ; by + "tes"} ;
    VF (Pret Act) => by + "tte" ;
    VF (Pret Pass) => by + "ttes" ;
    VF (Imper Act) => by + "t" ;
    VF (Imper Pass) => by + "ts" ;
    VI (Inf Act) => by + "ta" ;
    VI (Inf Pass) => by + "tas" ;
    VI (Supin Act) => by + "tt" ;
    VI (Supin Pass) => by + "tts" ;
    VI (PtPret (Strong (ASg Utr)) Nom) => by + "tt" ;
    VI (PtPret (Strong (ASg Utr)) Gen) => by + "tts" ;
    VI (PtPret (Strong (ASg Neutr)) Nom) => by + "tt" ;
    VI (PtPret (Strong (ASg Neutr)) Gen) => by + "tts" ;
    VI (PtPret (Strong APl) Nom) => by + "tta" ;
    VI (PtPret (Strong APl) Gen) => by + "ttas" ;
    VI (PtPret (Weak (AxSg NoMasc)) Nom) => by + "tta" ;
    VI (PtPret (Weak (AxSg NoMasc)) Gen) => by + "ttas" ;
    VI (PtPret (Weak (AxSg Masc)) Nom) => by + "tte" ;
    VI (PtPret (Weak (AxSg Masc)) Gen) => by + "ttes" ;
    VI (PtPret (Weak AxPl) Nom) => by + "tta" ;
    VI (PtPret (Weak AxPl) Gen) => by + "ttas"
    }
  } ;

oper vHyra : Str -> Verbum = \hyr -> 
 {s = table {
    VF (Pres Act) => hyr ;
    VF (Pres Pass) => variants {hyr + "s" ; hyr + "es"} ;
    VF (Pret Act) => hyr + "de" ;
    VF (Pret Pass) => hyr + "des" ;
    VF (Imper Act) => hyr ;
    VF (Imper Pass) => hyr + "s" ;
    VI (Inf Act) => hyr + "a" ;
    VI (Inf Pass) => hyr + "as" ;
    VI (Supin Act) => hyr + "t" ;
    VI (Supin Pass) => hyr + "ts" ;
    VI (PtPret (Strong (ASg Utr)) Nom) => hyr + "d" ;
    VI (PtPret (Strong (ASg Utr)) Gen) => hyr + "ds" ;
    VI (PtPret (Strong (ASg Neutr)) Nom) => hyr + "t" ;
    VI (PtPret (Strong (ASg Neutr)) Gen) => hyr + "ts" ;
    VI (PtPret (Strong APl) Nom) => hyr + "da" ;
    VI (PtPret (Strong APl) Gen) => hyr + "das" ;
    VI (PtPret (Weak (AxSg NoMasc)) Nom) => hyr + "da" ;
    VI (PtPret (Weak (AxSg NoMasc)) Gen) => hyr + "das" ;
    VI (PtPret (Weak (AxSg Masc)) Nom) => hyr + "de" ;
    VI (PtPret (Weak (AxSg Masc)) Gen) => hyr + "des" ;
    VI (PtPret (Weak AxPl) Nom) => hyr + "da" ;
    VI (PtPret (Weak AxPl) Gen) => hyr + "das"
    }
  } ;

-- machine-generated exceptional inflection tables from rules.Swe.gf

oper mor_1 : Subst = 
 {s = table {
    SF Sg Indef Nom => variants {"mor" ; "moder"} ;
    SF Sg Indef Gen => variants {"mors" ; "moders"} ;
    SF Sg Def Nom => "modern" ;
    SF Sg Def Gen => "moderns" ;
    SF Pl Indef Nom => "mödrar" ;
    SF Pl Indef Gen => "mödrars" ;
    SF Pl Def Nom => "mödrarna" ;
    SF Pl Def Gen => "mödrarnas"
    } ;
  h1 = Utr
  } ;

oper farbror_8 : Subst = 
 {s = table {
    SF Sg Indef Nom => variants {"farbror" ; "farbroder"} ;
    SF Sg Indef Gen => variants {"farbrors" ; "farbroders"} ;
    SF Sg Def Nom => "farbrodern" ;
    SF Sg Def Gen => "farbroderns" ;
    SF Pl Indef Nom => "farbröder" ;
    SF Pl Indef Gen => "farbröders" ;
    SF Pl Def Nom => "farbröderna" ;
    SF Pl Def Gen => "farbrödernas"
    } ;
  h1 = Utr
  } ;

oper gammal_16 : Adj = 
 {s = table {
    AF (Posit (Strong (ASg Utr))) Nom => "gammal" ;
    AF (Posit (Strong (ASg Utr))) Gen => "gammals" ;
    AF (Posit (Strong (ASg Neutr))) Nom => "gammalt" ;
    AF (Posit (Strong (ASg Neutr))) Gen => "gammalts" ;
    AF (Posit (Strong APl)) Nom => "gamla" ;
    AF (Posit (Strong APl)) Gen => "gamlas" ;
    AF (Posit (Weak (AxSg NoMasc))) Nom => "gamla" ;
    AF (Posit (Weak (AxSg NoMasc))) Gen => "gamlas" ;
    AF (Posit (Weak (AxSg Masc))) Nom => "gamle" ;
    AF (Posit (Weak (AxSg Masc))) Gen => "gamles" ;
    AF (Posit (Weak AxPl)) Nom => "gamla" ;
    AF (Posit (Weak AxPl)) Gen => "gamlas" ;
    AF Compar Nom => "äldre" ;
    AF Compar Gen => "äldres" ;
    AF (Super SupStrong) Nom => "äldst" ;
    AF (Super SupStrong) Gen => "äldsts" ;
    AF (Super SupWeak) Nom => "äldsta" ;
    AF (Super SupWeak) Gen => "äldstas"
    }
  } ;


oper stor_25 : Adj = 
 {s = table {
    AF (Posit (Strong (ASg Utr))) Nom => "stor" ;
    AF (Posit (Strong (ASg Utr))) Gen => "stors" ;
    AF (Posit (Strong (ASg Neutr))) Nom => "stort" ;
    AF (Posit (Strong (ASg Neutr))) Gen => "storts" ;
    AF (Posit (Strong APl)) Nom => "stora" ;
    AF (Posit (Strong APl)) Gen => "storas" ;
    AF (Posit (Weak (AxSg NoMasc))) Nom => "stora" ;
    AF (Posit (Weak (AxSg NoMasc))) Gen => "storas" ;
    AF (Posit (Weak (AxSg Masc))) Nom => "store" ;
    AF (Posit (Weak (AxSg Masc))) Gen => "stores" ;
    AF (Posit (Weak AxPl)) Nom => "stora" ;
    AF (Posit (Weak AxPl)) Gen => "storas" ;
    AF Compar Nom => "större" ;
    AF Compar Gen => "störres" ;
    AF (Super SupStrong) Nom => "störst" ;
    AF (Super SupStrong) Gen => "störsts" ;
    AF (Super SupWeak) Nom => "största" ;
    AF (Super SupWeak) Gen => "störstas"
    }
  } ;

oper ung_29 : Adj = 
 {s = table {
    AF (Posit (Strong (ASg Utr))) Nom => "ung" ;
    AF (Posit (Strong (ASg Utr))) Gen => "ungs" ;
    AF (Posit (Strong (ASg Neutr))) Nom => "ungt" ;
    AF (Posit (Strong (ASg Neutr))) Gen => "ungts" ;
    AF (Posit (Strong APl)) Nom => "unga" ;
    AF (Posit (Strong APl)) Gen => "ungas" ;
    AF (Posit (Weak (AxSg NoMasc))) Nom => "unga" ;
    AF (Posit (Weak (AxSg NoMasc))) Gen => "ungas" ;
    AF (Posit (Weak (AxSg Masc))) Nom => "unge" ;
    AF (Posit (Weak (AxSg Masc))) Gen => "unges" ;
    AF (Posit (Weak AxPl)) Nom => "unga" ;
    AF (Posit (Weak AxPl)) Gen => "ungas" ;
    AF Compar Nom => "yngre" ;
    AF Compar Gen => "yngres" ;
    AF (Super SupStrong) Nom => "yngst" ;
    AF (Super SupStrong) Gen => "yngsts" ;
    AF (Super SupWeak) Nom => "yngsta" ;
    AF (Super SupWeak) Gen => "yngstas"
    }
  } ;


oper jag_32 : ProPN = 
 {s = table {
    PNom => "jag" ;
    PAcc => "mig" ;
    PGen (ASg Utr) => "min" ;
    PGen (ASg Neutr) => "mitt" ;
    PGen APl => "mina"
    } ;
  h1 = Utr ;
  h2 = Sg ;
  h3 = P1
  } ;

oper du_33 : ProPN = 
 {s = table {
    PNom => "du" ;
    PAcc => "dig" ;
    PGen (ASg Utr) => "din" ;
    PGen (ASg Neutr) => "ditt" ;
    PGen APl => "dina"
    } ;
  h1 = Utr ;
  h2 = Sg ;
  h3 = P2
  } ;

oper han_34 : ProPN = 
 {s = table {
    PNom => "han" ;
    PAcc => "honom" ;
    PGen (ASg Utr) => "hans" ;
    PGen (ASg Neutr) => "hans" ;
    PGen APl => "hans"
    } ;
  h1 = Utr ;
  h2 = Sg ;
  h3 = P3
  } ;

oper hon_35 : ProPN = 
 {s = table {
    PNom => "hon" ;
    PAcc => "henne" ;
    PGen (ASg Utr) => "hennes" ;
    PGen (ASg Neutr) => "hennes" ;
    PGen APl => "hennes"
    } ;
  h1 = Utr ;
  h2 = Sg ;
  h3 = P3
  } ;

oper vi_36 : ProPN = 
 {s = table {
    PNom => "vi" ;
    PAcc => "oss" ;
    PGen (ASg Utr) => "vår" ;
    PGen (ASg Neutr) => "vårt" ;
    PGen APl => "våra"
    } ;
  h1 = Utr ;
  h2 = Pl ;
  h3 = P1
  } ;

oper ni_37 : ProPN = 
 {s = table {
    PNom => "ni" ;
    PAcc => "er" ;
    PGen (ASg Utr) => "er" ;
    PGen (ASg Neutr) => "ert" ;
    PGen APl => "era"
    } ;
  h1 = Utr ;
  h2 = Pl ;
  h3 = P2
  } ;

oper de_38 : ProPN = 
 {s = table {
    PNom => "de" ;
    PAcc => "dem" ;
    PGen (ASg Utr) => "deras" ;
    PGen (ASg Neutr) => "deras" ;
    PGen APl => "deras"
    } ;
  h1 = Utr ;
  h2 = Pl ;
  h3 = P3
  } ;

oper den_39 : ProPN = 
 {s = table {
    PNom => "den" ;
    PAcc => "den" ;
    PGen (ASg Utr) => "dess" ;
    PGen (ASg Neutr) => "dess" ;
    PGen APl => "dess"
    } ;
  h1 = Utr ;
  h2 = Sg ;
  h3 = P3
  } ;

oper det_40 : ProPN = 
 {s = table {
    PNom => "det" ;
    PAcc => "det" ;
    PGen (ASg Utr) => "dess" ;
    PGen (ASg Neutr) => "dess" ;
    PGen APl => "dess"
    } ;
  h1 = Neutr ;
  h2 = Sg ;
  h3 = P3
  } ;

oper man_1144 : Subst = 
 {s = table {
    SF Sg Indef Nom => "man" ;
    SF Sg Indef Gen => "mans" ;
    SF Sg Def Nom => "mannen" ;
    SF Sg Def Gen => "mannens" ;
    SF Pl Indef Nom => "män" ;
    SF Pl Indef Gen => "mäns" ;
    SF Pl Def Nom => "männen" ;
    SF Pl Def Gen => "männens" 
    } ;
  h1 = Utr
  } ;

oper liten_1146 : Adj = 
 {s = table {
    AF (Posit (Strong (ASg Utr))) Nom => "liten" ;
    AF (Posit (Strong (ASg Utr))) Gen => "litens" ;
    AF (Posit (Strong (ASg Neutr))) Nom => "litet" ;
    AF (Posit (Strong (ASg Neutr))) Gen => "litets" ;
    AF (Posit (Strong APl)) Nom => "små" ;
    AF (Posit (Strong APl)) Gen => "smås" ;
    AF (Posit (Weak (AxSg NoMasc))) Nom => "lilla" ;
    AF (Posit (Weak (AxSg NoMasc))) Gen => "lillas" ;
    AF (Posit (Weak (AxSg Masc))) Nom => "lille" ;
    AF (Posit (Weak (AxSg Masc))) Gen => "lilles" ;
    AF (Posit (Weak AxPl)) Nom => "små" ;
    AF (Posit (Weak AxPl)) Gen => "smås" ;
    AF Compar Nom => "mindre" ;
    AF Compar Gen => "mindres" ;
    AF (Super SupStrong) Nom => "minst" ;
    AF (Super SupStrong) Gen => "minsts" ;
    AF (Super SupWeak) Nom => "minsta" ;
    AF (Super SupWeak) Gen => "minstas"
    }
  } ;

oper hava_1198 : Verbum = 
 {s = table {
    VF (Pres Act) => "har" ;
    VF (Pres Pass) => "has" ;
    VF (Pret Act) => "hade" ;
    VF (Pret Pass) => "hades" ;
    VF (Imper Act) => "ha" ;
    VF (Imper Pass) => "has" ;
    VI (Inf Act) => "ha" ;
    VI (Inf Pass) => "has" ;
    VI (Supin Act) => "haft" ;
    VI (Supin Pass) => "hafts" ;
    VI (PtPret (Strong (ASg Utr)) Nom) => variants {} ;
    VI (PtPret (Strong (ASg Utr)) Gen) => variants {} ;
    VI (PtPret (Strong (ASg Neutr)) Nom) => variants {} ;
    VI (PtPret (Strong (ASg Neutr)) Gen) => variants {} ;
    VI (PtPret (Strong APl) Nom) => variants {} ;
    VI (PtPret (Strong APl) Gen) => variants {} ;
    VI (PtPret (Weak (AxSg NoMasc)) Nom) => variants {} ;
    VI (PtPret (Weak (AxSg NoMasc)) Gen) => variants {} ;
    VI (PtPret (Weak (AxSg Masc)) Nom) => variants {} ;
    VI (PtPret (Weak (AxSg Masc)) Gen) => variants {} ;
    VI (PtPret (Weak AxPl) Nom) => variants {} ;
    VI (PtPret (Weak AxPl) Gen) => variants {}
    }
  } ;

oper vara_1200 : Verbum = 
 {s = table {
    VF (Pres Act) => "är" ;
    VF (Pres Pass) => variants {} ;
    VF (Pret Act) => "var" ;
    VF (Pret Pass) => variants {} ;
    VF (Imper _) => "var" ;
    VI (Inf Act) => "vara" ;
    VI (Inf Pass) => variants {} ;
    VI (Supin Act) => "varit" ;
    VI (Supin Pass) => variants {} ;
    VI (PtPret (Strong (ASg Utr)) Nom) => variants {} ;
    VI (PtPret (Strong (ASg Utr)) Gen) => variants {} ;
    VI (PtPret (Strong (ASg Neutr)) Nom) => variants {} ;
    VI (PtPret (Strong (ASg Neutr)) Gen) => variants {} ;
    VI (PtPret (Strong APl) Nom) => variants {} ;
    VI (PtPret (Strong APl) Gen) => variants {} ;
    VI (PtPret (Weak (AxSg NoMasc)) Nom) => variants {} ;
    VI (PtPret (Weak (AxSg NoMasc)) Gen) => variants {} ;
    VI (PtPret (Weak (AxSg Masc)) Nom) => variants {} ;
    VI (PtPret (Weak (AxSg Masc)) Gen) => variants {} ;
    VI (PtPret (Weak AxPl) Nom) => variants {} ;
    VI (PtPret (Weak AxPl) Gen) => variants {}
    }
  } ;

-- for Numerals

param DForm = ental  | ton  | tiotal  ;

oper 
  LinDigit = {s : DForm => Str} ;

  mkTal : Str -> Str -> Str -> LinDigit = \två, tolv, tjugo -> 
    {s = table {ental => två ; ton => tolv ; tiotal => tjugo}} ;

  regTal : Str -> LinDigit = \fem -> 
    mkTal fem (fem + "ton") (fem + "tio") ;

}
