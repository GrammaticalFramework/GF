--# -path=.:../romance:../../prelude

instance SyntaxSpa of SyntaxRomance = 
  TypesSpa ** open Prelude, (CO=Coordination), MorphoSpa in {
oper
  nameNounPhrase = \jean -> 
    normalNounPhrase
      (\\c => prepCase c ++ jean.s) 
      jean.g 
      Sg ;

  nounPhraseOn = mkNameNounPhrase "se" Masc ; --- can be plural dep. on object

  pronImpers = pronIl ; ---- should be [] ?

  partitiveNounPhrase = \n,vino ->
    normalNounPhrase 
      (table {
         CPrep P_de => elisDe ++ vino.s ! n ;
         c => prepCase c ++ artDef vino.g n (CPrep P_de) ++ vino.s ! n
         }
      )
      vino.g
      n ;

  chaqueDet  = mkDeterminer1 Sg "cada" ;
  tousDet    = mkDeterminer  Pl ["todos los"] ["todas las"] ; --- gli
  plupartDet = mkDeterminer1 Pl ["la mayor parte de"] ;  --- dei, degli, delle
  unDet      = mkDeterminer  Sg artUno artUna ;
  plDet      = mkDeterminer1 Pl [] ;                       --- dei, degli, delle

  quelDet  = mkDeterminer1 Sg "cuál" ; ----

  npGenPoss = \n,ton,mec ->
    \\c => artDef mec.g n c ++ ton.s ! Poss n mec.g ++ mec.s ! n ; --- mia madre

  npGenPossNum = \nu,ton,mec ->
    \\c => artDef mec.g Pl c ++ ton.s ! Poss Pl mec.g ++ nu.s ! mec.g ++ mec.s ! Pl ; 

  existNounPhrase np = 
    let
      verbHay =
        {s = table {
          VFin (VPres Ind) Sg P3 => "hay" ;
          v => verbHaber.s ! v
          } ;
         aux = verbHaber.aux
        }
    in
    sats2clause (
      mkSatsObject (pronEmpty Sg) (mkTransVerbCas verbHay accusative) np) ;

  reflPron : Number => Person => NPFormA => Str = \\n,p => 
    case p of {
      P3 => table {
        Ton x => prepCase x ++ "sé" ;
        Aton _ => "si" ;
        Poss Sg Masc => "suo" ;
        Poss Sg Fem  => "sua" ;
        Poss Pl Masc => "suoi" ;
        Poss Pl _    => "sue"
        } ;
      _ => (personPron Masc n p).s
    } ;

  personPron : Gender -> Number -> Person -> Pronoun = \g,n,p -> 
    case <n,p> of {
      <Sg,P1> => pronJe ;
      <Sg,P2> => pronTu ;
      <Sg,P3> => case g of {
        Masc => pronIl ;
        Fem  => pronElle 
        } ;
      <Pl,P1> => pronNous ;
      <Pl,P2> => pronVous ;
      <Pl,P3> => case g of {
        Masc => pronIls ;
        Fem  => pronIls 
        }
      } ;

{- ----
  existNounPhrase = \delvino -> {
    s = \\m => 
        case m of {
          Ind => "hay" ;
          Con => "haya"
          } ++ delvino.s ! stressed accusative
    } ;
-}

  mkAdjSolo : Str -> Bool -> Adjective = \adj,p ->
    mkAdjective (adjSolo adj) p ;

  mkAdjUtil : Str -> Str -> Bool -> Adjective = \adj,as,p ->
    mkAdjective (adjUtil adj as) p ;

  mkAdjDegrSolo : Str -> Bool -> AdjDegr = \adj,p ->
    mkAdjDegrLong (adjSolo adj) p ;

  mkAdjDegrUtil : Str -> Str -> Bool -> AdjDegr = \adj,as,p ->
    mkAdjDegrLong (adjUtil adj as) p ;

  comparConj = "que" ;

-- The commonest case for functions is common noun + "de".

  funGen : CommNounPhrase -> Function = \mere -> 
    mere ** complementCas genitive ;

-- Chains of "cui" - "cui" do not arise.

  funRelPron = \mere,lequel -> 
    {s = table {
           RComplex g n c => variants {
               case mere.c of {
                 CPrep P_de => artDef mere.g n c ++ 
                               lequel.s ! RSimple dative ++ mere.s ! n ;
                 _ => nonExist} ;
               artDef mere.g n c ++ mere.s ! n ++ 
                  mere.s2 ++ lequel.s ! RComplex g n mere.c
               } ;
           _ => nonExist
         } ;
     g = RG mere.g
    } ;

-- Verbs

  negVerb = \va -> "no" ++ va ;

  copula = verbSer ;

  isClitCase = \c -> case c of { 
     Acc => True ;
     CPrep P_a => True ; -- dative
     _   => False
     } ;

-- Spanish only has one compound auxiliary.

  auxVerb ve = verbHaber ; 

-- The negation of a verb.

  posNeg = \b,v,c -> 
    if_then_else Str b
      (v ++ c)
      ("no" ++ v ++ c) ;

  embedConj = "que" ;

-- Relative pronouns

  identRelPron = {
    s = table {
      RSimple c => relPronForms ! c ;
      RComplex g n c => composRelPron g n c
      } ; 
    g = RNoGen
    } ;

  suchPron = talPron ;

  composRelPron = ilqualPron ;

  allRelForms = \lequel,g,n,c ->
    variants {
      lequel.s ! RSimple c ;
      lequel.s ! RComplex g n c
      } ;

-- Interrogative pronouns

  nounIntPron = \n, mec ->
    {s = \\c => prepCase c ++ qualPron mec.g n ++ mec.s ! n ;
     g = mec.g ; 
     n = n
    } ; 

  intPronWho = \num -> {
    s = \\c => prepCase c ++ "quién" ;
    g = Masc ; --- can we decide this?
    n = num
  } ;

  intPronWhat = \num -> {
    s = table {
          c => prepCase c ++ "qué"
          } ;
    g = Masc ; --- can we decide this?
    n = num
  } ;

-- Questions
{- ----
  questVerbPhrase = \jean,dort ->
    {s = table {
      DirQ   => (predVerbPhrase jean dort).s ! Ind ;
      IndirQ => "si" ++ (predVerbPhrase jean dort).s ! Ind
      }
    } ;

  existNounPhraseQuest = \delvino -> 
    let cedelvino = (existNounPhrase delvino).s ! Ind 
    in {
      s = \\m => case m of {DirQ => [] ; _ => "si"} ++ cedelvino
      } ;

  intSlash = \Qui, Tuvois ->
    let {qui = Tuvois.s2 ++ Qui.s ! Tuvois.c ; tuvois = Tuvois.s ! Ind} in
    {s = table {
      DirQ   => qui ++ tuvois ; 
      IndirQ => qui ++ tuvois
      }
    } ;
-}

  intSlash = \Qui, Tuvois ->
    {s = \\b,cl =>
      let 
        qui = Tuvois.s2 ++ Qui.s ! Tuvois.c ; 
        tuvois = Tuvois.s ! b ! cl
      in
      table {
        DirQ   => qui ++ tuvois ; 
        IndirQ => qui ++ tuvois
        }
    } ;

---- moved from MorphoIta

-- A macro for defining gender-dependent tables will be useful.
-- Its first application is in the indefinite article.

  genForms = \matto, matta ->
    table {Masc => matto ; Fem => matta} ; 

  artUno : Str = "un" ;
  artUna : Str = "una" ;

  artIndef = \g,n,c -> case n of {
    Sg  => prepCase c ++ genForms artUno artUna ! g ;
    _   => prepCase c ++ []
    } ;

  artDef = \g,n,c -> artDefTable ! g ! n ! c ;

-- The composable pronoun "il quale" is inflected by varying the definite
-- article and the determiner "quale" in the expected way.

  ilqualPron : Gender -> Number -> Case -> Str = \g,n,c -> 
    artDef g n c ++ qualPron g n ;

  pronJe = mkPronoun
    "yo"   --- (variants {"yo" ; []}) etc
    "me"
    "me"
    "mí"
    "mi" "mi" "mis" "mis"
    PNoGen     -- gender cannot be known from pronoun alone
    Sg
    P1
    Clit1 ;

  pronTu = mkPronoun
    "tu"
    "te"
    "te"
    "tí"
    "tu" "tu" "tus" "tus"
    PNoGen
    Sg
    P2
    Clit1 ;

  pronIl = mkPronoun
    "el"
    "lo"
    "le"
    "él"
    "su" "su" "sus" "sus"
    (PGen Masc)
    Sg
    P3
    Clit2 ;

  pronElle = mkPronoun
    "ella"
    "la"
    "le"
    "ella"
    "su" "su" "sus" "sus"
    (PGen Fem)
    Sg
    P3
    Clit2 ;

  pronNous = mkPronoun
    "nosotros"  ---- nosotras
    "nos"
    "nos"
    "nosotros"
    "nuestro" "nuestra" "nuestros" "nuestras"
    (PGen Masc)
    Pl
    P1
    Clit3 ;

  pronVous = mkPronoun
    "vosotros"  ---- vosotras
    "vos"
    "vos"
    "vosotros"
    "vuestro" "vuestra" "vuestros" "vuestras"
    (PGen Masc)
    Pl
    P2
    Clit3 ;

  pronIls = mkPronoun
    "ellos"
    "los"
    "les"
    "ellos"
    "su" "su" "sus" "sus"
    (PGen Masc)
    Pl
    P3
    Clit1 ;

  pronElles = mkPronoun
    "ellas"
    "las"
    "les"
    "ellas"
    "su" "su" "sus" "sus"
    (PGen Fem)
    Pl
    P3
    Clit1 ;

  commentAdv = ss "como" ;
  quandAdv = ss "cuando" ;
  ouAdv = ss "donde" ;
  pourquoiAdv = ss "porqué" ;

  etConj = ss "y" ** {n = Pl} ;
  ouConj = ss "o" ** {n = Sg}  ;
  etetConj = sd2 "y" "y" ** {n = Pl}  ;
  ououConj = sd2 "o" "o" ** {n = Sg}  ;
  niniConj = sd2 "no" "ni" ** {n = Sg}  ; ----
  siSubj = ss "si" ** {m = Ind} ;
  quandSubj = ss "cuando" ** {m = Ind} ;

  ouiPhr = ss ["Sí ."] ;  
  nonPhr = ss ["No ."] ;

  negNe = "no" ; negPas = [] ;

}

