--# -path=.:../romance:../../prelude

instance SyntaxIta of SyntaxRomance = 
  TypesIta ** open Prelude, (CO=Coordination), MorphoIta in {

flags optimize=all ;

oper
  nameNounPhrase = \jean -> 
    normalNounPhrase
      (\\c => prepCase c ++ jean.s) 
      jean.g 
      Sg ;

  nounPhraseOn = mkNameNounPhrase "si" Masc ; --- can be plural dep. on object

  pronImpers : NounPhrase = pronNounPhrase pronIl ; ---- should be empty

  partitiveNounPhrase = \n,vino ->
    normalNounPhrase 
      (table {
         CPrep P_di => elisDe ++ vino.s ! n ;
         c => prepCase c ++ artDef vino.g n (CPrep P_di) ++ vino.s ! n
         }
      )
      vino.g
      n ;

  chaqueDet  = mkDeterminer1 Sg "ogni" ;
  tousDet    = mkDeterminer  Pl ["tutti i"] ["tutte le"] ; --- gli
  plupartDet = mkDeterminer1 Pl ["la maggior parte di"] ;  --- dei, degli, delle
  unDet      = mkDeterminer  Sg artUno artUna ;
  plDet      = mkDeterminer1 Pl [] ;                       --- dei, degli, delle

  quelDet  = mkDeterminer1 Sg "quale" ;

  npGenPoss = \n,ton,mec ->
    \\c => artDef mec.g n c ++ ton.s ! Poss n mec.g ++ mec.s ! n ; --- mia madre

  npGenPossNum = \nu,ton,mec ->
    \\c => artDef mec.g Pl c ++ ton.s ! Poss Pl mec.g ++ nu.s ! mec.g ++ mec.s ! Pl ; 

  existNounPhrase np = 
    let ci = MorphoIta.pronNous in
    sats2clause (
      insertObject (mkSatsObject (pronEmpty np.n) (mkTransVerbCas verbEssere dative) ci) 
        accusative [] np) ;


{- ----
  existNounPhrase = \delvino -> {
    s = \\m => 
        case m of {
          Ind => case delvino.n of {Sg => "c'è" ;      Pl => ["ci sono"]} ;
          Con => case delvino.n of {Sg => ["ci sia"] ; Pl => ["ci siano"]}
          } ++ delvino.s ! stressed accusative  --- ce ne sono ; have to define "ci"
    } ;
-}

  ---- check this!
  reflPron : Number => Person => NPFormA => Str = \\n,p => 
    case p of {
      P3 => table {
        Ton x => prepCase x ++ "sé" ;
        Aton _ => "se" ;
        Poss Sg Masc => "su" ;
        Poss Sg _    => "su" ;
        Poss Pl _    => "sus"
        } ;
      _ => (personPron Masc n p).s
    } ;


  mkAdjSolo : Str -> Bool -> Adjective = \adj,p ->
    mkAdjective (adjSolo adj) p ;

  mkAdjTale : Str -> Bool -> Adjective = \adj,p ->
    mkAdjective (adjTale adj) p ;

  mkAdjDegrSolo : Str -> Bool -> AdjDegr = \adj,p ->
    mkAdjDegrLong (adjSolo adj) p ;

  mkAdjDegrTale : Str -> Bool -> AdjDegr = \adj,p ->
    mkAdjDegrLong (adjTale adj) p ;

  comparConj = variants {"di" ; "che"} ;

-- The commonest case for functions is common noun + "di".

  funGen : CommNounPhrase -> Function = \mere -> 
    mere ** complementCas genitive ;

-- Chains of "cui" - "cui" do not arise.

  funRelPron = \mere,lequel -> 
    {s = table {
           RComplex g n c => variants {
               case mere.c of {
                 CPrep P_di => artDef mere.g n c ++ 
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

  negVerb = \va -> "non" ++ va ;

  copula = verbEssere ;

  isClitCase = \c -> case c of { 
     Acc => True ;
     CPrep P_a => True ; -- dative
     _   => False
     } ;

  auxVerb ve = case ve.aux of {
    AHabere => verbAvere ;
    AEsse   => verbEssere
    } ;

-- The negation of a verb.

  posNeg = \b,v,c -> 
    if_then_else Str b
      (v ++ c)
      ("non" ++ v ++ c) ;

  embedConj = "che" ;

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

  pronIl = MorphoIta.pronIl ;

-- Interrogative pronouns

  nounIntPron = \n, mec ->
    {s = \\c => prepCase c ++ qualPron mec.g n ++ mec.s ! n ;
     g = mec.g ; 
     n = n
    } ; 

  intPronWho = \num -> {
    s = \\c => prepCase c ++ "chi" ;
    g = Masc ; --- can we decide this?
    n = num
  } ;

  intPronWhat = \num -> {
    s = table {
          c => prepCase c ++ "che" ++ optStr "cosa" 
          } ;
    g = Masc ; --- can we decide this?
    n = num
  } ;

-- Questions
{- ----
  questVerbPhrase = \jean,dort ->
    {s = table {
      DirQ   => (predVerbPhrase jean dort).s ! Ind ;
      IndirQ => "se" ++ (predVerbPhrase jean dort).s ! Ind
      }
    } ;

  existNounPhraseQuest = \delvino -> 
    let cedelvino = (existNounPhrase delvino).s ! Ind 
    in {
      s = \\m => case m of {DirQ => [] ; _ => "se"} ++ cedelvino
      } ;

  intSlash = \Qui, Tuvois ->
    let {qui = Tuvois.s2 ++ Qui.s ! Tuvois.c ; tuvois = Tuvois.s ! Ind} in
    {s = table {
      DirQ   => qui ++ tuvois ; 
      IndirQ => ifCe Tuvois.c ++ qui ++ tuvois
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
        IndirQ => ifCe Tuvois.c ++ qui ++ tuvois
        }
    } ;

-- An auxiliary to distinguish between
-- "je ne sais pas" ("ce qui dort" / "ce que tu veux" / "à qui tu penses").

  ifCe : Case -> Str = \c -> case c of { ---
    Nom => "ciò" ;
    Acc => "ciò" ; 
    _   => []
    } ;
{- ----
  questAdverbial = \quand, jean, dort ->
    let {jeandort = (predVerbPhrase jean dort).s ! Ind} in
    {s = table {
      DirQ   => quand.s ++ jeandort ;  --- inversion? 
      IndirQ => quand.s ++ jeandort
      }
    } ;
-}
---- moved from MorphoIta

-- A macro for defining gender-dependent tables will be useful.
-- Its first application is in the indefinite article.

  genForms = \matto, matta ->
    table {Masc => matto ; Fem => matta} ; 

  artUno : Str = elision "un" "un" "uno" ;
  artUna : Str = elision "una" "un'" "una" ;

  artIndef = \g,n,c -> case n of {
    Sg  => prepCase c ++ genForms artUno artUna ! g ;
    _   => prepCase c ++ []
    } ;

  artDef = \g,n,c -> artDefTable ! g ! n ! c ;

-- The composable pronoun "il quale" is inflected by varying the definite
-- article and the determiner "quale" in the expected way.

  ilqualPron : Gender -> Number -> Case -> Str = \g,n,c -> 
    artDef g n c ++ qualPron g n ;


-- moved from ResIta

  commentAdv = ss "comme" ;
  quandAdv = ss "quando" ;
  ouAdv = ss "dove" ;
  pourquoiAdv = ss "perché" ;

  etConj = ss "e" ** {n = Pl} ;
  ouConj = ss "o" ** {n = Sg}  ;
  etetConj = sd2 "e" "e" ** {n = Pl}  ;
  ououConj = sd2 "o" "o" ** {n = Sg}  ;
  niniConj = sd2 "né" "né" ** {n = Sg}  ; --- requires ne !
  siSubj = ss "se" ** {m = Ind} ;
  quandSubj = ss "quando" ** {m = Ind} ;

  ouiPhr = ss ["Sì ."] ;  
  nonPhr = ss ["No ."] ;

  negNe = "non" ; negPas = [] ;

}

