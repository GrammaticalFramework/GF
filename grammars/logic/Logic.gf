-- many-sorted predicate calculus
-- AR 1999, revised 2001

abstract Logic = {

flags startcat=Prop ; -- this is what you want to parse

cat 
  Prop ;       -- proposition
  Dom ;        -- domain of quantification
  Elem Dom ;   -- individual element of a domain
  Proof Prop ; -- proof of a proposition
  Text ;       -- theorem with proof etc. 

fun 
  -- texts
  Statement : Prop -> Text ;
  ThmWithProof : (A : Prop) -> Proof A -> Text ;
  ThmWithTrivialProof : (A : Prop) -> Proof A -> Text ;

  -- logically complex propositions
  Disj : (A,B : Prop) -> Prop ;
  Conj : (A,B : Prop) -> Prop ;
  Impl : (A,B : Prop) -> Prop ;
  Abs  : Prop ;
  Neg  : Prop -> Prop ;

  Univ  : (A : Dom) -> (Elem A -> Prop) -> Prop ;
  Exist : (A : Dom) -> (Elem A -> Prop) -> Prop ;
 
  -- progressive implication à la type theory
  ImplP : (A : Prop) -> (Proof A -> Prop) -> Prop ;

  -- inference rules
data  
  ConjI  : (A,B : Prop) -> Proof A -> Proof B -> Proof (Conj A B) ;
fun  
  ConjEl : (A,B : Prop) -> Proof (Conj A B) -> Proof A ;
  ConjEr : (A,B : Prop) -> Proof (Conj A B) -> Proof B ;
data  
  DisjIl : (A,B : Prop) -> Proof A -> Proof (Disj A B) ;
  DisjIr : (A,B : Prop) -> Proof B -> Proof (Disj A B) ;
fun  
  DisjE  : (A,B,C : Prop) -> Proof (Disj A B) -> 
              (Proof A -> Proof C) -> (Proof B -> Proof C) -> Proof C ;
data
  ImplI  : (A,B : Prop) -> (Proof A -> Proof B) -> Proof (Impl A B) ;
fun
  ImplE  : (A,B : Prop) -> Proof (Impl A B) -> Proof A -> Proof B ;
data
  NegI   : (A : Prop) -> (Proof A -> Proof Abs) -> Proof (Neg A) ;
fun
  NegE   : (A : Prop) -> Proof (Neg A) -> Proof A -> Proof Abs ;
  AbsE   : (C : Prop) -> Proof Abs -> Proof C ;
data
  UnivI  : (A : Dom) -> (B : Elem A -> Prop) -> 
              ((x : Elem A) -> Proof (B x)) -> Proof (Univ A B) ;
fun
  UnivE  : (A : Dom) -> (B : Elem A -> Prop) -> 
              Proof (Univ A B) -> (a : Elem A) -> Proof (B a) ;
data
  ExistI : (A : Dom) -> (B : Elem A -> Prop) -> 
              (a : Elem A) -> Proof (B a) -> Proof (Exist A B) ;
fun
  ExistE : (A : Dom) -> (B : Elem A -> Prop) -> (C : Prop) -> 
              Proof (Exist A B) -> ((x : Elem A) -> Proof (B x) -> Proof C) -> 
              Proof C ;

  -- use a hypothesis
  Hypo : (A : Prop) -> Proof A -> Proof A ;

  -- pronoun
  Pron : (A : Dom) -> Elem A -> Elem A ;

def 
  -- proof normalization; does not tc 13/9/2005

  ConjEl _ _ (ConjI _ _ a _) = a ;
  ConjEr _ _ (ConjI _ _ _ b) = b ;
  DisjE _ _ _ (DisjIl _ _ a) d _ = d a ;
  DisjE _ _ _ (DisjIr _ _ b) _ e = e b ;
  ImplE _ _ (ImplI _ _ b) a = b a ;
  NegE _ (NegI _ b) a = b a ;
  UnivE _ _ (UnivI _ _ b) a = b a ;
  ExistE A B _ (ExistI A B a b) d = d a b ;
 
---  ExistE _ _ _ (ExistI _ _  a b) d = d a b ; 
--- does not tc 13/9/2005: {a{-2-}<>a{-0-}}
--- moreover: no problem with
--- ConjEr _ _ (ConjI _ _ a _) = a ;
--- But this changes when A B are used instead of _ _

  -- Hypo and Pron are identities
  Hypo _ a = a ;
  Pron _ a = a ;

} ;
