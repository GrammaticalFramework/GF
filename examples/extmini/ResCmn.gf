resource ResCmn = open Prelude in {
flags coding=utf8;
-- parameters

param
    TTense = TPres | TPerf | TPast | TFut ;
    Aspect = Perf | DurStat | DurProg | Exper ;
    Number   = Sg | Pl ;
    SForm = Phr PosType | Sent;
    PosType = APhrase | NPhrase | VPhrase ;
    DeForm = DeNoun | NdNoun ;    -- parameter created for noun with/out partical "de"

-- parts of speech

oper

  VP = { verb : Verb ; compl : Str ; prePart : Str} ;
  NP = {s : Str ; n : Number } ; 
  copula  : Verb = { s = table {
                            True => table { _    => "是"  };
                            False => table { _   => "不是" }};
                     vinf = "是" } ;

-- for morphology

  Noun : Type = {s : Str; Counter: Str} ;
  Adj  : Type = {s : Str; monoSyl: Bool} ;
  Verb : Type = {s : Bool => Aspect => Str ; vinf : Str} ;

  regNoun : Str -> Str -> Noun = \s,c -> {s = s; Counter = c};

  mkAdj : Str -> Bool -> Adj = \s,b -> {s = s; monoSyl = b};

  regVerb : (walk : Str) -> Verb = \v -> {
           s = table {
                True => table { Perf    => v ++ "了" ;
                                DurStat => v ++ "着" ;
                                DurProg => "在" ++ v ;
                                Exper   => v ++ "过" } ;
                False => table {Perf    => "不" ++ v ++ "了" ;
                                DurStat => "不" ++ v ;
                                DurProg => "没" ++ "在" ++ v ;
                                Exper   => "没" ++ v ++ "过" }};
            vinf = v} ;
                          
  mkVerb : (believe : Str) -> (PerfPart : Str) 
                           -> (DurStatPart : Str)
                           -> (DurProgPart : Str) 
                           -> (ExperPart : Str) -> Verb = \v,pp,ds,dp,ep -> {
            s = table {
                True => table { Perf    => v ++ pp ;
                                DurStat => v ++ ds ;
                                DurProg => dp ++ v ;
                                Exper   => v ++ ep } ;
                False => table {Perf    => "不" ++ v ++ pp ;
                                DurStat => "不" ++ v ;
                                DurProg => "没" ++ dp ++ v ;
                                Exper   => "没" ++ v ++ ep }} ;
            vinf = v} ;

-- for structural words

  mkDet : Str -> Number -> {s : Str ; n : Number} = \s,n -> {
    s = s ;
    n = n
    } ;

  pronNP : (s : Str) -> Number -> NP =   \s,n -> {
    s = s ;
    n = n
    } ;
    
  mkPrep : Str -> Str -> {s : Str ; prePart : Str} = \s,b -> {
    s = s ;
    prePart = b} ;
    
  mkAdv : Str -> Str -> {s : Str ; prePart : Str} = \b,s -> {
    s = s ;
    prePart = b} ;
  
  mkSubj : Str -> Str -> {prePart : Str ; sufPart : Str} = \p,s -> {
    prePart = p ;
    sufPart = s} ;

-- Proper Noun

  PropN : (s : Str) -> Number -> NP =   \s,n -> {
    s = s ;
    n = n
   } ;

    }
