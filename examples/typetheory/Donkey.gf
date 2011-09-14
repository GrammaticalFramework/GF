abstract Donkey = Types ** {

flags startcat = S ;

cat 
  S ; 
  CN ;
  NP Set ;
  VP Set ;
  V2 Set Set ;
  V  Set ;
  AP Set ;
  PN Set ;

data
  PredVP  : ({A} : Set)   -> NP A -> VP A -> S ;
  ComplV2 : ({A,B} : Set) -> V2 A B -> NP B -> VP A ;
  UseV    : ({A} : Set)   -> V A -> VP A ;
  UseAP   : ({A} : Set)   -> AP A -> VP A ;
  If      : (A : S) -> (El (iS A) -> S) -> S ;
  An      : (A : CN) -> NP (iCN A) ;
  Every   : (A : CN) -> NP (iCN A) ;
  The     : (A : CN)   -> El (iCN A) -> NP (iCN A) ;
  Pron    : ({A} : CN) -> El (iCN A) -> NP (iCN A) ;
  UsePN   : ({A} : Set) -> PN A -> NP A ;
  ModCN   : (A : CN) -> AP (iCN A) -> CN ;

  Man, Donkey, Woman : CN ;
  Own, Beat : V2 (iCN Man) (iCN Donkey) ;
  Love : ({A,B} : Set) -> V2 A B ;
  Walk, Talk : V (iCN Man) ;
  Old : ({A} : Set) -> AP A ;
  Pregnant : AP (iCN Woman) ;
  John : PN (iCN Man) ;

-- Montague semantics in type theory

fun
  iS  : S -> Set ;
  iCN : CN -> Set ;
  iNP : ({A} : Set) -> NP A -> (El A -> Set) -> Set ;
  iVP : ({A} : Set) -> VP A -> (El A -> Set) ;
  iAP : ({A} : Set) -> AP A -> (El A -> Set) ;
  iV  : ({A} : Set) -> V A -> (El A -> Set) ;
  iV2 : ({A,B} : Set) -> V2 A B -> (El A -> El B -> Set) ;
  iPN : ({A} : Set) -> PN A -> El A ;
def
  iS  (PredVP A Q F) = iNP A Q (\x -> iVP A F x) ;
  iS  (If A B) = Pi (iS A) (\x -> iS (B x)) ;
  iVP _ (ComplV2 A B F R) x = iNP B R (\y -> iV2 A B F x y) ;
  iVP _ (UseV A F) x = iV A F x ;
  iVP _ (UseAP A F) x = iAP A F x ;
  iNP _ (An A) F = Sigma (iCN A) F ;
  iNP _ (Every A) F = Pi (iCN A) F ;
  iNP _ (Pron _ x) F = F x ;
  iNP _ (The _ x) F = F x ;
  iNP _ (UsePN A a) F = F (iPN A a) ;
  iCN (ModCN A F) = Sigma (iCN A) (\x -> iAP (iCN A) F x) ;

--- for the type-theoretical lexicon

data
  Man', Donkey', Woman' : Set ;
  Own', Beat' : El Man' -> El Donkey' -> Set ;
  Love' : ({A,B} : Set) -> El A -> El B -> Set ;
  Old' : ({A} : Set) -> El A -> Set ;
  Walk', Talk' : El Man' -> Set ;
  Pregnant' : El Woman' -> Set ;
  John' : El Man' ;
def
  iCN Man = Man' ;
  iCN Woman = Woman' ;
  iCN Donkey = Donkey' ;
  iV2 _ _ Beat = Beat' ;
  iV2 _ _ Own = Own' ;
  iV2 _ _ (Love A B) = Love' A B ;
  iV _ Walk = Walk' ;
  iV _ Talk = Talk' ;
  iAP _ (Old A) = Old' A ;
  iAP _ Pregnant = Pregnant' ;
  iPN _ John = John' ;

}