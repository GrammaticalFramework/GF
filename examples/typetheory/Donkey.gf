abstract Donkey = Types ** {

flags startcat = S ;

cat 
  S ; 
  CN ;
  NP Set ;
  VP Set ;
  V2 Set Set ;
  V  Set ;

data
  PredVP  : ({A} : Set) -> NP A -> VP A -> S ;
  ComplV2 : ({A,B} : Set) -> V2 A B -> NP B -> VP A ;
  UseV    : ({A} : Set)   -> V A -> VP A ;
  If      : (A : S) -> (El (iS A) -> S) -> S ;
  An      : (A : CN) -> NP (iCN A) ;
  The     : (A : CN)   -> El (iCN A) -> NP (iCN A) ;
  Pron    : ({A} : CN) -> El (iCN A) -> NP (iCN A) ;

  Man, Donkey : CN ;
  Own, Beat : V2 (iCN Man) (iCN Donkey) ;
  Walk, Talk : V (iCN Man) ;

-- Montague semantics in type theory

fun
  iS  : S -> Set ;
  iCN : CN -> Set ;
  iNP : ({A} : Set) -> NP A -> (El A -> Set) -> Set ;
  iVP : ({A} : Set) -> VP A -> (El A -> Set) ;
  iV  : ({A} : Set) -> V A -> (El A -> Set) ;
  iV2 : ({A,B} : Set) -> V2 A B -> (El A -> El B -> Set) ;
def
  iS  (PredVP A Q F) = iNP A Q (\x -> iVP A F x) ;
  iS  (If A B) = Pi (iS A) (\x -> iS (B x)) ;
  iVP _ (ComplV2 A B F R) x = iNP B R (\y -> iV2 A B F x y) ;
  iVP _ (UseV A F) x = iV A F x ;
  iNP _ (An A) F = Sigma (iCN A) F ;
  iNP _ (Pron _ x) F = F x ;
  iNP _ (The _ x) F = F x ;


--- for the type-theoretical lexicon

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