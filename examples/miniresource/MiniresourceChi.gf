concrete MiniresourceChi of Miniresource = open Prelude in {

-- module GrammarChi

  flags coding = utf8;

  lincat
    S   = {s : Str} ; 
    Cl = {s : Bool => Str} ; 
    NP = NounPhrase ;  
      -- {s : Str} ;     
    VP = VerbPhrase ;  
      -- {verb : Verb ; compl : Str} ;  
    AP = {s : Str; monoSyl: Bool} ;
    CN = Noun ;        -- {s : Str; c : Str} ;
    Det = {s : Str ; n : Number} ;
    N = Noun ;         -- {s : Str; c : Str} ;
    A = Adj ;          -- {s : Str; monoSyl: Bool} ; 
    V = Verb;          -- {s : Str ; pp,ds,dp,ep : Str ; neg : Str}
    V2 = Verb ;
    AdA = {s : Str} ; 
    Pol = {s : Str ; b : Bool} ;
    Tense = {s : Str} ;
    Conj = {s : SForm => Str} ;    

  lin
    UseCl t p cl = {s = t.s ++ p.s ++ cl.s ! p.b} ; 

    PredVP np vp = {
       s  = \\p => np.s ++ neg p ++ vp.verb.s ++ vp.compl
       } ;

    ComplV2 v2 np = {
     verb  = v2 ;
     compl = np.s
     } ; 

    UseV v = {
      verb = v ; 
      compl = []
      } ; 

    DetCN det cn = case det.n of {
            Sg => {s = det.s ++ cn.c ++ cn.s ; n = Sg } ;
            Pl => {s = det.s ++ "些" ++ cn.s ; n = Pl }             
      } ;
      
    ModCN ap cn = case ap.monoSyl of {
            True => {s = ap.s ++ cn.s ; c = cn.c} ;
            False => {s = ap.s ++ "的" ++ cn.s ; c = cn.c} 
            } ;

    CompAP ap = {
      verb = copula ;
      compl = ap.s ++ "的"
      } ;

    AdAP ada ap = {
      s = ada.s ++ ap.s ;
      monoSyl = False
      } ;

    ConjNP co x y = {
      s = x.s ++ co.s ! Phr NPhrase ++ y.s
      } ;

    ConjS  co x y = {s = x.s ++ co.s ! Sent ++ y.s} ;  

    UseN n = n ;
    UseA adj = adj ;

    a_Det = mkDet "一" Sg ;
    every_Det = mkDet "每" Sg ;        
    the_Det = mkDet "那" Sg ;

    this_Det = mkDet "这" Sg ;
    these_Det = mkDet "这" Pl ;
    that_Det = mkDet "那" Sg ;
    those_Det = mkDet "那" Pl ;

    i_NP = pronNP "我" ;
    youSg_NP = pronNP "你" ;
    he_NP = pronNP "他" ;
    she_NP = pronNP "她" ;
    we_NP = pronNP "我们" ;
    youPl_NP = pronNP "你们" ;
    they_NP = pronNP "他们" ;

    very_AdA = ss (word "非常") ;    
    
    and_Conj = {s = table {
                    Phr NPhrase => "和" ;
                    Phr APhrase => "而" ;
                    Phr VPhrase => "又" ;
                    Sent =>  []
                          }
                } ;

    or_Conj  = {s = table {
                    Phr _ => "或" ;
                    Sent => word "还是"
                          }
                } ;

    Pos  = {s = [] ; b = True} ;
    Neg  = {s = [] ; b = False} ;
    Pres = {s = []} ;
    Perf = {s = []} ;

-- module TestChi

lin
  man_N = mkN "男人" ;  
  woman_N = mkN "女人" ;
  house_N = mkN "房子" ;
  tree_N = mkN "树" "棵";
  big_A = mkA "大" ;
  small_A = mkA "小" ;
  green_A = mkA "绿" ;
  walk_V = mkV "走" ;
  arrive_V = mkV "到" ;
  love_V2 = mkV2 "爱" ;
  please_V2 = mkV2 "麻烦" ;

-- module ResChi

-- parameters

param
    Number = Sg | Pl ;
    SForm = Phr PosType | Sent;
    PosType = APhrase | NPhrase | VPhrase ;

-- parts of speech

oper

  VerbPhrase = {verb : Verb ; compl : Str} ;
  NounPhrase = {s : Str} ; 

-- for morphology

  Noun : Type = {s : Str; c : Str} ;
  Adj  : Type = {s : Str; monoSyl: Bool} ;
  Verb : Type = {s : Str} ;

  mkNoun : Str -> Str -> Noun = \s,c -> {s = word s ; c = word c};

  mkAdj : Str -> Adj = \s -> case s of {
    ? => {s = word s ; monoSyl = True} ;
    _ => {s = word s ; monoSyl = False}
    } ;

  copula : Verb = mkVerb "是" ;

  mkVerb : (v : Str) -> Verb = \v -> 
    {s = word v} ;

  neg : Bool -> Str = \b -> case b of {True => [] ; False => "不"} ;

-- for structural words

  mkDet : Str -> Number -> {s : Str ; n : Number} = \s,n -> {
    s = word s ;
    n = n
    } ;

  pronNP : (s : Str) -> NounPhrase = \s -> {
    s = word s
    } ;
    
-- Write the characters that constitute a word separately. 
-- This enables straightforward tokenization.

  bword : Str -> Str -> Str = \x,y -> x ++ y ; 
  -- change to x + y to treat words as single tok ens

  word : Str -> Str = \s -> case s of {
      x@? + y@? + z@? + u@? => bword x (bword y (bword z u)) ;
      x@? + y@? + z@? => bword x (bword y z) ;
      x@? + y@? => bword x y ;
      _ => s
      } ;

-- module ParadigmsChi

oper
  mkN = overload {
    mkN : (man : Str) -> N 
      = \n -> lin N (mkNoun n "个") ;  
    mkN : (man : Str) -> Str -> N 
      = \n,c -> lin N (mkNoun n c)
    } ;  
      
  mkA : (small : Str) -> A 
      = \a -> lin A (mkAdj a) ;
      
  mkV : (walk : Str) -> V 
      = \s -> lin V (mkVerb s) ; 

  mkV2 = overload {
    mkV2 : (love : Str) -> V2 
      = \love -> lin V2 (mkVerb love) ;
    mkV2 : (love : V) -> V2 
      = \love -> lin V2 love ;
   } ;

}
