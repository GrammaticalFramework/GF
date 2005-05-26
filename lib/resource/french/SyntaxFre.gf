--# -path=.:../romance:../../prelude

instance SyntaxFre of SyntaxRomance = TypesFre ** 
  open Prelude, (CO=Coordination), MorphoFre in {

flags optimize=parametrize ;

oper
  nameNounPhrase = \jean -> 
    normalNounPhrase
      (\\c => prepCase c ++ jean.s) 
      jean.g 
      Sg ;

  nounPhraseOn = mkNameNounPhrase "on" Masc ;

  pronImpers : NounPhrase = pronNounPhrase pronIl ;

  partitiveNounPhrase = \n,vin ->
    normalNounPhrase 
      (table {
         Gen => elisDe ++ vin.s ! n ;
         c => prepCase c ++ artDef vin.g n Gen ++ vin.s ! n
         }
      )
      vin.g
      n ; 

  chaqueDet  = mkDeterminer1 Sg "chaque" ;

  toutDet : Determiner = 
    {s = \\g => genForms "tout" "toute" ! g ++ artDef g Sg nominative ;
     n = Sg
    } ;
  tousDet : Numeral -> Determiner = \nu ->
    {s = \\g => genForms "tous" "toutes" ! g ++ artDef g Pl nominative ++ nu.s ! g ;
     n = Pl
    } ;

  plupartDet = mkDeterminer1 Pl ["la plupart des"] ;
  unDet      = mkDeterminer  Sg "un" "une" ;
  plDet      = mkDeterminer1 Pl "des" ; ---

  quelDet  = mkDeterminer Sg "quel" "quelle" ;
  quelsDet = mkDeterminer Pl "quels" "quelles" ;

  npGenPoss = \n,ton,mec ->
    \\c => prepCase c ++ ton.s ! Poss n mec.g ++ mec.s ! n ;

  npGenPossNum = \nu,ton,mec ->
    \\c => prepCase c ++ ton.s ! Poss Pl mec.g ++ nu.s ! mec.g ++ mec.s ! Pl ;

  existNounPhrase = \unemaison -> 
    sats2clause (
      insertObject (mkSatsObject pronImpers (mkTransVerbCas verbAvoir dative) pronY) 
        accusative [] unemaison) ;

  reflPron : Number => Person => NPFormA => Str = \\n,p => 
    case p of {
      P3 => table {
        Ton x => prepCase x ++ "soi" ;
        Aton _ => elision "s" ;
        Poss Sg Masc => "son" ;
        Poss Sg Fem  => "sa" ;
        Poss Pl _    => "ses"
        } ;
      _ => (personPron Masc n p).s
    } ;

  comparConj = elisQue ;

  mkAdjDegrReg : Str -> Bool -> AdjDegr = \adj,p ->
    mkAdjDegrLong (adjGrand adj) p ;

-- The commonest case for functions is common noun + "de".

  funDe : CommNounPhrase -> Function = \mere -> 
    mere ** complementCas genitive ;

-- Chains of "dont" - "dont" do not arise.

  funRelPron : Function -> RelPron -> RelPron = \mere,lequel -> 
    {s = table {
           RComplex g n c => variants {
               case mere.c of { ---
                 Gen => lequel.s ! RSimple Gen ++ 
                          artDef mere.g n c ++ mere.s ! n ;
                 _ => nonExist} ; 
               artDef mere.g n c ++ mere.s ! n ++ 
                  mere.s2 ++ lequel.s ! RComplex g n mere.c
               } ;
           _ => nonExist
         } ;
     g = RG mere.g
    } ;


-- Verbs

  negVerb = \va -> elisNe ++ va ++ "pas" ;

--  copula = \b,w -> let etre = (predVerb verbEtre).s in  etre ! b ! Masc ! w ;
  copula = verbEtre ;


  isClitCase = \c -> case c of { 
     Acc => True ;
     Dat => True ;
     _   => False  --- this is not quite correct
     } ;

  auxVerb ve = case ve.aux of {
    AHabere => verbAvoir ;
    AEsse   => verbEtre
    } ;

{- ---G
  progressiveVerbPhrase : VerbPhrase -> VerbGroup = \vp ->
   predClauseBeGroup
     (complCopula (\\g,n,p => 
       "en" ++ "train" ++ elisDe ++ vp.s !  VIInfinit ! g ! n ! p)) ;
-}

-- The "ne - pas" negation.

  posNeg = \b,v,c -> 
    if_then_else Str b
      (v ++ c)
      (elisNe ++ v ++ "pas" ++ c) ; --- exception: infinitive!

-- Exampe: 'to be or not to be'.

  etreNetre : Bool -> Verb = \b -> 
    {s = \\w => posNeg b (verbEtre.s ! w) [] ; aux = AHabere} ; ---- v reveals a BUG in refresh 

  embedConj = elisQue ;

-- Relative pronouns

  identRelPron = {
    s = table {
      RSimple c => relPronForms ! c ;
      RComplex g n c => composRelPron g n c
      } ; 
    g = RNoGen
    } ;

  suchPron = telPron ;

  composRelPron = lequelPron ;

  allRelForms = \lequel,g,n,c ->
    variants {
      lequel.s ! RSimple c ;
      lequel.s ! RComplex g n c
      } ;

-- Interrogative pronouns

  nounIntPron = \n, mec ->
    {s = \\c => prepCase c ++ quelPron mec.g n ++ mec.s ! n ;
     g = mec.g ; 
     n = n
    } ; 

  intPronWho = \num -> {
    s = \\c => prepCase c ++ "qui" ;
    g = Masc ; --- can we decide this?
    n = num
  } ;

  intPronWhat = \num -> {
    s = table {
          Gen => ["de quoi"] ;
          Acc => ["à quoi"]  ;
          c => elisQue
          } ;
    g = Masc ; --- can we decide this?
    n = num
  } ;

-- Questions

  intSlash = \Qui, Tuvois ->
    {s = \\b,cl =>
      let 
        qui = Tuvois.s2 ++ Qui.s ! Tuvois.c ; 
        tuvois = Tuvois.s ! b ! cl
      in
      table {
        DirQ   => qui ++ optStr (estCeQue Acc) ++ tuvois ; 
        IndirQ => ifCe Tuvois.c ++ qui ++ tuvois
        }
    } ;

-- An auxiliary to distinguish between
-- "je ne sais pas" ("ce qui dort" / "ce que tu veux" / "à qui tu penses").

  ifCe : Case -> Str = \c -> case c of {
    Nom => "ce" ;
    Acc => "ce" ;
    _   => []
    } ;

----- moved from Morpho

--2 Articles
--
-- A macro for defining gender-dependent tables will be useful.
-- Its first application is in the indefinite article.
--
-- Notice that the plural genitive is special: "de femmes".

  genForms : Str -> Str -> Gender => Str = \bon,bonne ->
    table {Masc => bon ; Fem => bonne} ; 

  artIndef = \g,n,c -> case <n,c> of {
    <Sg,_>   => prepCase c ++ genForms "un" "une" ! g ;
    <Pl,Gen> => elisDe ;
    _        => prepCase c ++ "des"
    } ;

  artDef = \g,n,c -> artDefTable ! g ! n ! c ;

  pronJe = mkPronoun
    (elision "j")
    (elision "m")
    (elision "m")
    "moi"
    "mon" (elisPoss "m") "mes"
    PNoGen     -- gender cannot be known from pronoun alone
    Sg
    P1
    Clit1 ;

  pronTu = mkPronoun
    "tu"
    (elision "t")
    (elision "t")
    "toi"
    "ton" (elisPoss "t") "tes"
    PNoGen
    Sg
    P2
    Clit1 ;

  pronIl = mkPronoun
    "il"
    (elision "l")
    "lui"
    "lui"
    "son" (elisPoss "s") "ses"
    (PGen Masc)
    Sg
    P3
    Clit2 ;

  pronElle = mkPronoun
    "elle"
    elisLa
    "lui"
    "elle"
    "son" (elisPoss "s") "ses"
    (PGen Fem)
    Sg
    P3
    Clit2 ;

  pronNous = mkPronoun
    "nous"
    "nous"
    "nous"
    "nous"
    "notre" "notre" "nos"
    PNoGen
    Pl
    P1
    Clit3 ;

  pronVous = mkPronoun
    "vous"
    "vous"
    "vous"
    "vous"
    "votre" "votre" "vos"
    PNoGen
    Pl   --- depends!
    P2
    Clit3 ;

  pronIls = mkPronoun
    "ils"
    "les"
    "leur"
    "eux"
    "leur" "leur" "leurs"
    (PGen Masc)
    Pl
    P3
    Clit1 ;

  pronElles = mkPronoun
    "elles"
    "les"
    "leur"
    "elles"
    "leur" "leur" "leurs"
    (PGen Fem)
    Pl
    P3
    Clit1 ;

-- moved from ResFra

  commentAdv = ss "comment" ;
  quandAdv = ss "quand" ;
  ouAdv = ss "où" ;
  pourquoiAdv = ss "pourquoi" ;

  etConj = ss "et" ** {n = Pl} ;
  ouConj = ss "ou" ** {n = Sg}  ;
  etetConj = sd2 "et" "et" ** {n = Pl}  ;
  ououConj = sd2 "ou" "ou" ** {n = Sg}  ;
  niniConj = sd2 "ni" "ni" ** {n = Sg}  ; --- requires ne !
  siSubj = ss elisSi ** {m = Ind} ;
  quandSubj = ss "quand" ** {m = Ind} ;

  ouiPhr = ss ["Oui ."] ;  
  nonPhr = ss ["Non ."] ; --- and also Si!

  negNe = elisNe ; negPas = "pas" ;

}
