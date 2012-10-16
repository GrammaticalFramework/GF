--# -path=.:../abstract:../common:../../prelude

--1 Thai auxiliary operations.
--
---- This module contains operations that are needed to make the
---- resource syntax work. To define everything that is needed to
---- implement $Test$, it moreover contains regular lexical
---- patterns needed for $Lex$.
--
resource ResCmn = ParamX ** open Prelude in {

  flags coding = utf8 ;

  oper

-- strings ----

  defaultStr = "" ;

  than_s = "bi3" ;
  progressive_s = defaultStr ;
  possessive_s = "de" ; -- also used for AP + NP
  deAdvV_s = "de" ; -- between Adv and V
  deVAdv_s = "de2" ; -- between V and Adv
  imperneg_s = neg_s ;
  conjThat = emptyStr ; ----
  reflPron = word "zi4ji3" ;   -- pron + refl
  passive_s = defaultStr ;
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

  copula : Verb = mkVerb "shi4" [] [] [] [] "bu4" ;

  regVerb : (walk : Str) -> Verb = \v -> 
    mkVerb v "le" "zhao1" "zai4" "guo4" "mei2" ;

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
            APerf    => "bu4" ++ v.s ++ v.pp ;
            ADurStat => "bu4" ++ v.s ;
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
