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

  than_s = "bǐ" ;
  progressive_s = defaultStr ;
  de_s, possessive_s = "de" ; -- also used for AP + NP
  deAdvV_s = "de" ; -- between Adv and V
  deVAdv_s = "dé" ; -- between V and Adv
  imperneg_s = neg_s ;
  conjThat = emptyStr ; ----
  reflPron = word "zìjǐ" ;   -- pron + refl
  passive_s = "beì" ;
  relative_s = possessive_s ; -- relative
  superlative_s = "zuì" ; -- superlative, sup + adj + de
  zai_s = "zaì" ;  -- copula for place
  you_s = "yoǔ" ; -- to have

  copula_s = "shì" ;
  exist_s = word "cúnzaì" ;
  neg_s = "bù" ;
  question_s = "mǎ" ;
  yi_s = "yī" ;
  ordinal_s = "dì" ;
  xie_s = "xiē" ;
  the_s = "nǎ" ;
  geng_s = "gēng" ; -- more, in comparison
  hen_s = "hěn" ; -- very, or predicating a monosyllabic adjective
  taN_s = "tā" ;

  zai_V = mkVerb "zaì" [] [] [] [] "bù" ;
  fullstop_s = "。" ;
  questmark_s = "？" ;
  exclmark_s = "！" ;
  ge_s = "gè" ;
  di_s = "shì" ; -- used in QuestSlash
  ba_s = "bǎ" ;  -- ba4, object marker
  ba0_s = "bā" ; -- ba, used in imperatives
  men_s = "men" ;
  zan_s = "zá" ;

  say_s = "shuì" ; -- used in embedded sentences: she answers him that we sleep

  duncomma = "、" ;
  chcomma = "，" ;

  emptyStr = [] ;


-- Write the characters that constitute a word separately. This enables straightforward tokenization.

  bword : Str -> Str -> Str = \x,y -> x + y ; -- change to x + y to treat words as single tokens

  word : Str -> Str = \s -> case s of {
      x@? + y@? + z@? + u@? + v@? + w@? + a@? + b@? + c@? + d@? + e@? => 
        bword x (bword y (bword z (bword u (bword v (bword w (bword a (bword b (bword c (bword d e))))))))) ;
      x@? + y@? + z@? + u@? + v@? + w@? + a@? + b@? + c@? + d@? => 
        bword x (bword y (bword z (bword u (bword v (bword w (bword a (bword b (bword c d)))))))) ;
      x@? + y@? + z@? + u@? + v@? + w@? + a@? + b@? + c@? => bword x (bword y (bword z (bword u (bword v (bword w (bword a (bword b c))))))) ;
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

    AdvType = ATPlace Bool | ATTime | ATManner | ATPoss ; -- ATPlace True = has zai_s already

-- parts of speech

oper

  VP = {
    topic : Str ;   -- topicalized item, before subject
    prePart : Str ; -- between subject and verb
    verb : Verb ; 
    compl : Str     -- after verb
    } ;

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

  copula : Verb = mkVerb "shì" [] [] [] [] "bù" ;
  hen_copula : Verb = 
    {s = hen_s ; sn = [] ; pp = [] ; ds = [] ; dp = [] ; ep = [] ; neg = "bù"} ; --- 
  nocopula : Verb = 
    {s = [] ; sn = [] ; pp = [] ; ds = [] ; dp = [] ; ep = [] ; neg = "bù"} ; --- 
  adjcopula : Verb = 
    {s = "shì" ; sn = [] ; pp = [] ; ds = [] ; dp = [] ; ep = [] ; neg = "bù"} ; --- 

  regVerb : (walk : Str) -> Verb = \v -> 
    mkVerb v "le" "zhaō" "zaì" "guò" "bù" ; -- 没" ;

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
            APerf    => "bù" ++ v.sn ++ v.pp ;
            ADurStat => "bù" ++ v.sn ;
            ADurProg => v.neg ++ v.dp ++ v.sn ;  -- mei or bu
            AExper   => v.neg ++ v.sn ++ v.ep
            }
     } ;

  infVP : VP -> Str = \vp -> vp.topic ++ vp.prePart ++ vp.verb.s ++ vp.compl ; 

  predV : Verb -> Str -> VP = \v,part -> {
      verb = v ; 
      compl = part ;
      prePart, topic = [] ;
      } ; 

  insertObj : NP -> VP -> VP = \np,vp -> {
     verb  = vp.verb ;
     compl = np.s ++ vp.compl ;
     prePart = vp.prePart ;
     topic = vp.topic
     } ; 

  insertObjPost : NP -> VP -> VP = \np,vp -> {
     verb  = vp.verb ;
     compl = vp.compl ++ np.s ;
     prePart = vp.prePart ;
     topic = vp.topic
     } ; 

   insertAdv : SS -> VP -> VP = \adv,vp -> {
     verb  = vp.verb ;
     compl = vp.compl ;
     prePart = adv.s ++ vp.prePart ;
     topic = vp.topic
     } ; 

   insertTopic : SS -> VP -> VP = \adv,vp -> {
     verb  = vp.verb ;
     compl = vp.compl ;
     prePart = vp.prePart ;
     topic = adv.s ++ vp.topic
     } ; 
   insertAdvPost : SS -> VP -> VP = \adv,vp -> {
     verb  = vp.verb ;
     compl = vp.compl ;
     prePart = vp.prePart ++ adv.s ;
     topic = vp.topic
     } ; 

   insertPP : SS -> VP -> VP = \pp,vp -> {
     verb  = vp.verb ;
     compl = vp.compl ;
     prePart = vp.prePart ++ pp.s ;
     topic = vp.topic
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
     s = \\p,a => vp.topic ++ np ++ vp.prePart ++ useVerb vp.verb ! p ! a ++ vp.compl ++ compl ;
     np = vp.topic ++ np ;
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
    mkDet : Str ->            Determiner = \s   -> {s = word s ; detType = DTFull Sg} ;
    mkDet : Str -> Number  -> Determiner = \s,n -> {s = word s ; detType = DTFull n} ;
    mkDet : Str -> DetType -> Determiner = \s,d -> {s = word s ; detType = d} ;
    } ;

  mkQuant = overload {
    mkQuant : Str ->                   Quantifier = \s     -> {s,pl = word s ; detType = DTFull Sg} ;
    mkQuant : Str ->        DetType -> Quantifier = \s,d   -> {s,pl = word s ; detType = d} ;
    mkQuant : Str -> Str -> DetType -> Quantifier = \s,p,d -> {s    = word s ; detType = d ; pl = p} ;
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
    "的"     => ATPoss ;
    "在" + _ => ATPlace True ; -- certain that True
    _ => ATPlace False         -- uncertain whether ATPlace
    } ;

  possessiveIf : AdvType -> Str = \at -> case at of {
    ATPoss => [] ;   --- to avoid double "de" 
    _ => possessive_s
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
