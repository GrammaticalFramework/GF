abstract Donkey = Types ** {

cat 
  S ; 
  CN ;
  NP Set ;
  V2 Set Set ;
  V  Set ;

data
  PredV2 : ({A,B} : Set) -> V2 A B -> NP A -> NP B -> S ;
  PredV  : ({A} : Set)   -> V A -> NP A -> S ;
  If     : (A : S) -> (El (iS A) -> S) -> S ;
  An     : (A : CN) -> NP (iCN A) ;
  The    : (A : CN)   -> El (iCN A) -> NP (iCN A) ;
  Pron   : ({A} : CN) -> El (iCN A) -> NP (iCN A) ;

  Man, Donkey : CN ;
  Own, Beat : V2 (iCN Man) (iCN Donkey) ;
  Walk, Talk : V (iCN Man) ;

fun
  iS  : S -> Set ;
  iCN : CN -> Set ;
  iNP : ({A} : Set) -> NP A -> (El A -> Set) -> Set ;
  iV2 : ({A,B} : Set) -> V2 A B -> (El A -> El B -> Set) ;
  iV  : ({A} : Set) -> V A -> (El A -> Set) ;

def
  iS (PredV2 A B F Q R) = iNP A Q (\x -> iNP B R (\y -> iV2 A B F x y)) ;
  iS (PredV A F Q) = iNP A Q (iV A F) ;
  iS (If A B) = Pi (iS A) (\x -> iS (B x)) ;
  iNP _ (An A) F = Sigma (iCN A) F ;
  iNP _ (Pron _ x) F = F x ;
  iNP _ (The _ x) F = F x ;

-- for the lexicon

data
  Man', Donkey' : Set ;
  Own', Beat' : El Man' -> El Donkey' -> Set ;
  Walk', Talk' : El Man' -> Set ;

def
  iCN Man = Man' ;
  iCN Donkey = Donkey' ;
  iV2 _ _ Beat = Beat' ;
  iV2 _ _ Own = Own' ;
  iV _ Walk = Walk' ;
  iV _ Talk = Talk' ;

}