abstract Donkey = Types ** {

flags startcat = S ;

cat 
  S ; 
  Cl ;
  CN ;
  Det ;
  Conj ;
  NP Set ;
  VP Set ;
  V2 Set Set ;
  V  Set ;
  AP Set ;
  PN Set ;
  RC Set ;

data
  IfS     : (A : S) -> (El (iS A) -> S) -> S ;              -- if A B
  ConjS   : Conj -> S -> S -> S ;                           -- A and B ; A or B
  PosCl   : Cl -> S ;                                       -- John walks
  NegCl   : Cl -> S ;                                       -- John doesn't walk
  PredVP  : ({A} : Set)   -> NP A -> VP A -> Cl ;           -- John (walks / doesn't walk)
  ComplV2 : ({A,B} : Set) -> V2 A B -> NP B -> VP A ;       -- loves John
  UseV    : ({A} : Set)   -> V A -> VP A ;                  -- walks
  UseAP   : ({A} : Set)   -> AP A -> VP A ;                 -- is old
  DetCN   : Det -> (A : CN) -> NP (iCN A) ;                 -- every man
  ConjNP  : Conj -> ({A} : Set) -> NP A -> NP A -> NP A ;   -- John and every man
  The     : (A : CN)   -> El (iCN A) -> NP (iCN A) ;        -- the donkey
  Pron    : ({A} : CN) -> El (iCN A) -> NP (iCN A) ;        -- he/she/it
  UsePN   : ({A} : Set) -> PN A -> NP A ;                   -- John
  ModAP   : (A : CN) -> AP (iCN A) -> CN ;                  -- old man
  ModRC   : (A : CN) -> RC (iCN A) -> CN ;                  -- man that walks
  RelVP   : ({A} : CN) -> VP (iCN A) -> RC (iCN A) ;        -- that walks
  An      : Det ;
  Every   : Det ; 
  And     : Conj ;
  Or      : Conj ;

  Man, Donkey, Woman : CN ;
  Own, Beat : V2 (iCN Man) (iCN Donkey) ;
  Love : ({A,B} : Set) -> V2 A B ; -- polymorphic verb
  Walk, Talk : V (iCN Man) ;       -- monomorphic verbs
  Old : ({A} : Set) -> AP A ;      -- polymorphic adjective
  Pregnant : AP (iCN Woman) ;      -- monomorphic adjective
  John : PN (iCN Man) ;

-- Montague semantics in type theory

fun
  iS    : S -> Set ;
  iCl   : Cl -> Set ;
  iCN   : CN -> Set ;
  iDet  : Det -> ({A} : Set) -> (El A -> Set) -> Set ;
  iConj : Conj -> Set -> Set -> Set ;
  iNP   : ({A} : Set) -> NP A -> (El A -> Set) -> Set ;
  iVP   : ({A} : Set) -> VP A -> (El A -> Set) ;
  iAP   : ({A} : Set) -> AP A -> (El A -> Set) ;
  iRC   : ({A} : Set) -> RC A -> (El A -> Set) ;
  iV    : ({A} : Set) -> V A -> (El A -> Set) ;
  iV2   : ({A,B} : Set) -> V2 A B -> (El A -> El B -> Set) ;
  iPN   : ({A} : Set) -> PN A -> El A ;
def
  iS (PosCl A) = iCl A ;
  iS (NegCl A) = Neg (iCl A) ;
  iS  (IfS A B) = Pi (iS A) (\x -> iS (B x)) ;
  iS (ConjS C A B) = iConj C (iS A) (iS B) ;
  iCl (PredVP A Q F) = iNP A Q (\x -> iVP A F x) ;
  iVP _ (ComplV2 A B F R) x = iNP B R (\y -> iV2 A B F x y) ;
  iVP _ (UseV A F) x = iV A F x ;
  iVP _ (UseAP A F) x = iAP A F x ;
  iNP _ (DetCN D A) F = iDet D (iCN A) F ;
  iNP _ (ConjNP C A Q R) F = iConj C (iNP A Q F) (iNP A R F) ;
  iNP _ (Pron _ x) F = F x ;
  iNP _ (The _ x) F = F x ;
  iNP _ (UsePN A a) F = F (iPN A a) ;
  iDet An A F = Sigma A F ;
  iDet Every A F = Pi A F ;
  iCN (ModAP A F) = Sigma (iCN A) (\x -> iAP (iCN A) F x) ;
  iCN (ModRC A F) = Sigma (iCN A) (\x -> iRC (iCN A) F x) ;
  iRC _ (RelVP A F) x = iVP (iCN A) F x ;
  iConj And = Prod ;
  iConj Or = Plus ;

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