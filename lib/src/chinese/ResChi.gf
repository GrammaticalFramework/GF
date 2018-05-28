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

  than_s = "比" ;
  progressive_s = defaultStr ;
  de_s, possessive_s = "的" ; -- also used for AP + NP
  deAdvV_s = "地" ; -- between Adv and V
  deVAdv_s = "得" ; -- between V and Adv
  imperneg_s = neg_s ;
  conjThat = emptyStr ; ----
  reflPron = word "自己" ;   -- pron + refl
  passive_s = "被" ;
  relative_s = possessive_s ; -- relative
  superlative_s = "最" ; -- superlative, sup + adj + de
  zai_s = "在" ;  -- copula for place
  you_s = "有" ; -- to have

  copula_s = "是" ;
  exist_s = word "存在" ;
  neg_s = "不" ;
  question_s = "吗" ;
  yi_s = "一" ;
  ordinal_s = "第" ;
  xie_s = "些" ;
  the_s = "那" ;
  geng_s = "更" ; -- more, in comparison
  hen_s = "很" ; -- very, or predicating a monosyllabic adjective
  taN_s = "它" ;

  zai_V = mkVerb "在" [] [] [] [] "不" ;
  fullstop_s = "。" ;
  questmark_s = "？" ;
  exclmark_s = "！" ;
  ge_s = "个" ;
  di_s = "是" ; -- used in QuestSlash
  ba_s = "把" ;  -- ba4, object marker
  ba0_s = "吧" ; -- ba, used in imperatives
  men_s = "们" ;
  zan_s = "咱" ;

  say_s = "说" ; -- used in embedded sentences: she answers him that we sleep

  duncomma = "、" ;
  chcomma = "，" ;

  emptyStr = [] ;


-- Write the characters that constitute a word separately. This enables straightforward tokenization.

  bword : Str -> Str -> Str = \x,y -> x ++ y ; -- change to x + y to treat words as single tokens

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
    compl : Str ;    -- after verb
    isAdj : Bool ;   -- whether it is an adjectival predication and behaves differently in relative 
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

  copula : Verb = mkVerb "是" [] [] [] [] "不" ;
  hen_copula : Verb = 
    {s = hen_s ; sn = [] ; pp = [] ; ds = [] ; dp = [] ; ep = [] ; neg = "不"} ; --- 
  nocopula : Verb = 
    {s = [] ; sn = [] ; pp = [] ; ds = [] ; dp = [] ; ep = [] ; neg = "不"} ; --- 
  adjcopula : Verb = 
    {s = "是" ; sn = [] ; pp = [] ; ds = [] ; dp = [] ; ep = [] ; neg = "不"} ; --- 

  regVerb : (walk : Str) -> Verb = \v -> 
    mkVerb v "了" "着" "在" "过" "不" ; -- 没" ;

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
            APerf    => "不" ++ v.sn ++ v.pp ;
            ADurStat => "不" ++ v.sn ;
            ADurProg => v.neg ++ v.dp ++ v.sn ;  -- mei or bu
            AExper   => v.neg ++ v.sn ++ v.ep
            }
     } ;

  infVP : VP -> Str = \vp -> vp.topic ++ vp.prePart ++ vp.verb.s ++ vp.compl ; 

  predV : Verb -> Str -> VP = \v,part -> {
      verb = v ; 
      compl = part ;
      prePart, topic = [] ;
      isAdj = False ;
      } ; 

  insertObj : NP -> VP -> VP = \np,vp -> vp ** {
     compl = np.s ++ vp.compl ;
     } ; 

  insertObjPost : NP -> VP -> VP = \np,vp -> vp ** {
     compl = vp.compl ++ np.s ;
     } ; 

   insertAdv : SS -> VP -> VP = \adv,vp -> vp ** {
     prePart = adv.s ++ vp.prePart ;
     } ; 

   insertTopic : SS -> VP -> VP = \adv,vp -> vp ** {
     topic = adv.s ++ vp.topic
     } ; 
   insertAdvPost : SS -> VP -> VP = \adv,vp -> vp ** {
     prePart = vp.prePart ++ adv.s ;
     } ; 

   insertPP : SS -> VP -> VP = \pp,vp -> vp ** {
     prePart = vp.prePart ++ pp.s ;
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

  Preposition = {prepPre : Str ; prepPost : Str ; advType : AdvType ; hasDe : Bool} ;  
    
  mkPreposition : Str -> Str -> AdvType -> Preposition = \s1,s2,at -> {
    prepPre  = word s1 ;
    prepPost = word s2 ;
    advType  = at ;
    hasDe = advTypeHasDe at ;
    } ;

  advTypeHasDe : AdvType -> Bool = \at -> case at of {
      ATPoss => True ;
      _ => False
      } ; 
    
  getAdvType : Str -> AdvType = \s -> case s of {
    "的"     => ATPoss ;
    "在" + _ => ATPlace True ; -- certain that True
    _ => ATPlace False         -- uncertain whether ATPlace
    } ;

  possessiveIf : Bool -> Str = \hasDe -> case hasDe of {
    True => [] ;   --- to avoid double "de" 
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
