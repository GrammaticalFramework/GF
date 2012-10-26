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
  possessive_s = "的" ; -- also used for AP + NP
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

    AdvType = ATPlace | ATTime | ATManner ;

-- parts of speech

oper

  VP = {verb : Verb ; compl : Str ; prePart : Str} ;
  NP = {s : Str} ; 

-- for morphology

  Noun : Type = {s : Str; c : Str} ;
  Adj  : Type = {s : Str; monoSyl: Bool} ;
  Verb : Type = {s : Str ; pp,ds,dp,ep : Str ; neg : Str} ;

  regNoun : Str -> Str -> Noun = \s,c -> {s = word s ; c = word c};

  mkAdj : Str -> Bool -> Adj = \s,b -> {s = word s ; monoSyl = b};

  complexAP : Str -> Adj = \s -> {s = s ; monoSyl = False} ;

  simpleAdj : Str -> Adj = \s -> case s of {
    ? => mkAdj s True ; -- monosyllabic
    _ => mkAdj s False
    } ;

  copula : Verb = mkVerb "是" [] [] [] [] "不" ;

  regVerb : (walk : Str) -> Verb = \v -> 
    mkVerb v "了" "着" "在" "过" "没" ;

  mkVerb : (v : Str) -> (pp,ds,dp,ep,neg : Str) -> Verb = \v,pp,ds,dp,ep,neg -> 
    {s = word v ; pp = pp ; ds = ds ; dp = dp ; ep = ep ; neg = neg} ;

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
            APlain   => v.neg ++ v.s ; --- neg?
            APerf    => "不" ++ v.s ++ v.pp ;
            ADurStat => "不" ++ v.s ;
            ADurProg => v.neg ++ v.dp ++ v.s ;  -- mei or bu
            AExper   => v.neg ++ v.s ++ v.ep
            }
     } ;

  infVP : VP -> Str = \vp -> vp.prePart ++ vp.verb.s ++ vp.compl ; 

  predV : Verb -> VP = \v -> {
      verb = v ; 
      compl = [] ;
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
     prePart = adv.s
     } ; 

   insertExtra : SS -> VP -> VP = \ext,vp ->
     insertObjPost ext vp ;

-- clauses: keep np and vp separate to enable insertion of IAdv

   Clause : Type = {
     s  : Polarity => Aspect => Str ; 
     np : Str; 
     vp : Polarity => Aspect => Str
     } ; 


   mkClause = overload {
     mkClause : Str -> Verb -> Clause = \np,v -> mkClauseCompl np (useVerb v) [] ;
     mkClause : Str -> (Polarity => Aspect => Str) -> Str -> Clause = mkClauseCompl ;
     mkClause : Str -> Verb -> Str -> Clause = \subj,verb,obj ->
       mkClauseCompl subj (useVerb verb) obj ;
     mkClause : Str -> VP -> Clause = \np,vp -> 
       mkClauseCompl np (\\p,a => vp.prePart ++ useVerb vp.verb ! p ! a) vp.compl ;
     } ;
 
   mkClauseCompl : Str -> (Polarity => Aspect => Str) -> Str -> Clause = \np,vp,compl -> {
     s = \\p,a => np ++ vp ! p ! a ++ compl ;
     np = np ;
     vp = \\p,a => vp ! p ! a ++ compl
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
    
  mkPreposition : Str -> Str -> Preposition = \s,b -> {
    prepMain = word s ;
    prepPre = word b
    } ;
    
  mkSubj : Str -> Str -> {prePart : Str ; sufPart : Str} = \p,s -> {
    prePart = word p ;
    sufPart = word s
    } ;

  Preposition = {prepMain : Str ; prepPre : Str} ;  

-- added by AR

  mkNP : Str -> NP = ss ;

  appPrep : Preposition -> Str -> Str = \prep,s -> 
    prep.prepPre ++ s ++ prep.prepMain ;

}
