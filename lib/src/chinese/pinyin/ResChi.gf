--# -path=.:../abstract:../common:../../prelude

--1 Thai auxiliary operations.
--
---- This module contains operations that are needed to make the
---- resource syntax work. To define everything that is needed to
---- implement $Test$, it moreover contains regular lexical
---- patterns needed for $Lex$.
--
resource ResChi = ParamX ** open Prelude in {

  flags coding = utf8 ;

  oper

-- strings ----

  defaultStr = "" ;

  than_s = "bi3" ;
  progressive_s = defaultStr ;
  de_s, possessive_s = "de" ; -- also used for AP + NP
  deAdvV_s = "de" ; -- between Adv and V
  deVAdv_s = "de2" ; -- between V and Adv
  imperneg_s = neg_s ;
  conjThat = emptyStr ; ----
  reflPron = word "zi4ji3" ;   -- pron + refl
  passive_s = "bei4" ;
  relative_s = possessive_s ; -- relative
  superlative_s = "zui4" ; -- superlative, sup + adj + de
  zai_s = "zai4" ;  -- copula for place
  you_s = "you3" ; -- to have

  copula_s = "shi4" ;
  exist_s = word "cun2zai4" ;
  neg_s = "bu4" ;
  question_s = "ma3" ;
  yi_s = "yi1" ;
  ordinal_s = "di4" ;
  xie_s = "xie1" ;
  the_s = "na3" ;
  geng_s = "geng1" ; -- more, in comparison
  hen_s = "hen3" ; -- very, or predicating a monosyllabic adjective
  taN_s = "ta1" ;

  zai_V = mkVerb "zai4" [] [] [] [] "bu4" ;
  fullstop_s = "。" ;
  questmark_s = "？" ;
  exclmark_s = "！" ;
  ge_s = "ge4" ;
  di_s = "shi4" ; -- used in QuestSlash
  ba_s = "ba3" ;  -- ba4, object marker
  ba0_s = "ba1" ; -- ba, used in imperatives
  men_s = "men" ;
  zan_s = "za2" ;

  say_s = "shui4" ; -- used in embedded sentences: she answers him that we sleep

  duncomma = "、" ;
  chcomma = "，" ;

  emptyStr = [] ;


-- Write the characters that constitute a word separately. This enables straightforward tokenization.

  bword : Str -> Str -> Str = \x,y -> x + y ; -- change to x + y to treat words as single tokens

  word : Str -> Str = \s -> case s of {
      x@? + y@? + z@? + u@? + v@? + w@? + a@? + b@? => bword x (bword y (bword z (bword u (bword v (bword w (bword a b)))))) ;
      x@? + y@? + z@? + u@? + v@? + w@? + a@? => bword x (bword y (bword z (bword u (bword v (bword w a))))) ;
      x@? + y@? + z@? + u@? + v@? + w@? => bword x (bword y (bword z (bword u (bword v w)))) ;
      x@? + y@? + z@? + u@? + v@? => bword x (bword y (bword z (bword u v))) ;
      x@? + y@? + z@? + u@? => bword x (bword y (bword z u)) ;
      x@? + y@? + z@? => bword x (bword y z) ;
      x@? + y@? => bword x y ;
      _ => s
      } ;

  ssword : Str -> SS = \s -> ss (word s) ;

------------------------------------------------ from Jolene

-- parameters

param
    Aspect = APlain | APerf | ADurStat | ADurProg | AExper ;  ---- APlain added by AR
    ConjForm = CPhr CPosType | CSent;
    CPosType = CAPhrase | CNPhrase | CVPhrase ;
    DeForm = DeNoun | NdNoun ;    -- parameter created for noun with/out partical "de"

    AdvType = ATPlace Bool | ATTime | ATManner ; -- ATPlace True = has zai_s already

-- parts of speech

oper

  VP = {verb : Verb ; compl : Str ; prePart : Str} ;
  NP = {s : Str} ; 

-- for morphology

  Noun : Type = {s : Str ; c : Str} ;
  Adj  : Type = {s : Str ; monoSyl: Bool} ;
  Verb : Type = {s,sn : Str ; pp,ds,dp,ep : Str ; neg : Str} ; --- sn=[] needed for "hen" as copula

  regNoun : Str -> Str -> Noun = \s,c -> {s = word s ; c = word c};

  mkAdj : Str -> Bool -> Adj = \s,b -> {s = word s ; monoSyl = b};

  complexAP : Str -> Adj ** {hasAdA : Bool} = 
    \s -> {s = s ; monoSyl = False ; hasAdA = False} ; --- not used for adding AdA

  simpleAdj : Str -> Adj = \s -> case s of {
    ? => mkAdj s True ; -- monosyllabic
    _ => mkAdj s False
    } ;

  copula : Verb = mkVerb "shi4" [] [] [] [] "bu4" ;
  hen_copula : Verb = 
    {s = hen_s ; sn = [] ; pp = [] ; ds = [] ; dp = [] ; ep = [] ; neg = "bu4"} ; --- 
  nocopula : Verb = 
    {s = [] ; sn = [] ; pp = [] ; ds = [] ; dp = [] ; ep = [] ; neg = "bu4"} ; --- 
  adjcopula : Verb = 
    {s = "shi4" ; sn = [] ; pp = [] ; ds = [] ; dp = [] ; ep = [] ; neg = "bu4"} ; --- 

  regVerb : (walk : Str) -> Verb = \v -> 
    mkVerb v "le" "zhao1" "zai4" "guo4" "bu4" ; -- 没" ;

  noVerb : Verb = regVerb [] ; ---?? -- used as copula for verbal adverbs

  mkVerb : (v : Str) -> (pp,ds,dp,ep,neg : Str) -> Verb = \v,pp,ds,dp,ep,neg -> 
    {s,sn = word v ; pp = pp ; ds = ds ; dp = dp ; ep = ep ; neg = neg} ;

  useVerb : Verb -> Polarity => Aspect => Str = \v -> 
    table {
          Pos => table {
            APlain   => v.s ;
            APerf    => v.s ++ v.pp ;
            ADurStat => v.s ++ v.ds ;
            ADurProg => v.dp ++ v.s ;
            AExper   => v.s ++ v.ep
            } ;
          Neg => table {
            APlain   => v.neg ++ v.sn ; --- neg?
            APerf    => "bu4" ++ v.sn ++ v.pp ;
            ADurStat => "bu4" ++ v.sn ;
            ADurProg => v.neg ++ v.dp ++ v.sn ;  -- mei or bu
            AExper   => v.neg ++ v.sn ++ v.ep
            }
     } ;

  infVP : VP -> Str = \vp -> vp.prePart ++ vp.verb.s ++ vp.compl ; 

  predV : Verb -> Str -> VP = \v,part -> {
      verb = v ; 
      compl = part ;
      prePart = [] ;
      } ; 

  insertObj : NP -> VP -> VP = \np,vp -> {
     verb  = vp.verb ;
     compl = np.s ++ vp.compl ;
     prePart = vp.prePart
     } ; 

  insertObjPost : NP -> VP -> VP = \np,vp -> {
     verb  = vp.verb ;
     compl = vp.compl ++ np.s ;
     prePart = vp.prePart
     } ; 

   insertAdv : SS -> VP -> VP = \adv,vp -> {
     verb  = vp.verb ;
     compl = vp.compl ;
     prePart = adv.s ++ vp.prePart
     } ; 
   insertAdvPost : SS -> VP -> VP = \adv,vp -> {
     verb  = vp.verb ;
     compl = vp.compl ;
     prePart = vp.prePart ++ adv.s
     } ; 

   insertPP : SS -> VP -> VP = \pp,vp -> {
     verb  = vp.verb ;
     compl = vp.compl ;
     prePart = vp.prePart ++ pp.s
     } ; 

   insertExtra : SS -> VP -> VP = \ext,vp ->
     insertObjPost ext vp ;

-- clauses: keep np and vp separate to enable insertion of IAdv

   Clause : Type = {
     s  : Polarity => Aspect => Str ; 
     np : Str; 
     vp : VP 
     } ; 


   mkClause = overload {
     mkClause : Str -> Verb -> Clause = \np,v -> 
       mkClauseCompl np (predV v []) [] ;
     mkClause : Str -> Verb -> Str -> Clause = \subj,verb,obj ->
       mkClauseCompl subj (predV verb []) obj ;
     mkClause : Str -> VP -> Clause = \np,vp -> 
       mkClauseCompl np vp [] ;
     mkClause : Str -> VP -> Str -> Clause = 
       mkClauseCompl ;
     } ;
 
   mkClauseCompl : Str -> VP -> Str -> Clause = \np,vp,compl -> {
     s = \\p,a => np ++ vp.prePart ++ useVerb vp.verb ! p ! a ++ vp.compl ++ compl ;
     np = np ;
     vp = insertObj (ss compl) vp ;
     } ;
   

-- for structural words

param 
  DetType = DTFull Number | DTNum | DTPoss ;  -- this, these, five, our
  NumType = NTFull | NTVoid Number ;          -- five, sg, pl

oper
  Determiner = {s : Str ; detType : DetType} ;
  Quantifier = Determiner ** {pl : Str} ;

  mkDet = overload {
    mkDet : Str ->            Determiner = \s   -> {s = s ; detType = DTFull Sg} ;
    mkDet : Str -> Number  -> Determiner = \s,n -> {s = s ; detType = DTFull n} ;
    mkDet : Str -> DetType -> Determiner = \s,d -> {s = s ; detType = d} ;
    } ;

  mkQuant = overload {
    mkQuant : Str ->                   Quantifier = \s     -> {s,pl = s ; detType = DTFull Sg} ;
    mkQuant : Str ->        DetType -> Quantifier = \s,d   -> {s,pl = s ; detType = d} ;
    mkQuant : Str -> Str -> DetType -> Quantifier = \s,p,d -> {s    = s ; detType = d ; pl = p} ;
    } ;

  pronNP : (s : Str) -> NP = \s -> {
    s = word s
    } ;

  Preposition = {prepPre : Str ; prepPost : Str ; advType : AdvType} ;  
    
  mkPreposition : Str -> Str -> AdvType -> Preposition = \s1,s2,at -> {
    prepPre  = word s1 ;
    prepPost = word s2 ;
    advType = at
    } ;
    
  getAdvType : Str -> AdvType = \s -> case s of {
    "zai4" + _ => ATPlace True ; -- certain that True
    _ => ATPlace False         -- uncertain whether ATPlace
    } ;

  mkSubj : Str -> Str -> {prePart : Str ; sufPart : Str} = \p,s -> {
    prePart = word p ;
    sufPart = word s
    } ;


-- added by AR

  mkNP     : Str -> NP = ss ;  -- not to be used in lexicon building

  appPrep : Preposition -> Str -> Str = \prep,s -> 
    prep.prepPre ++ s ++ prep.prepPost ;

}
