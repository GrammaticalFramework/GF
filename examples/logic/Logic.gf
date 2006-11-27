-- many-sorted predicate calculus
-- AR 1999, revised 2001 and 2006

abstract Logic = {

cat 
  Prop ;       -- proposition
  Dom ;        -- domain of quantification
  Elem Dom ;   -- individual element of a domain
  Proof Prop ; -- proof of a proposition
  Hypo Prop ;  -- hypothesis of a proposition
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
 
  -- inference rules

  ConjI  : (A,B : Prop) -> Proof A -> Proof B -> Proof (Conj A B) ;  
  ConjEl : (A,B : Prop) -> Proof (Conj A B) -> Proof A ;
  ConjEr : (A,B : Prop) -> Proof (Conj A B) -> Proof B ;
  DisjIl : (A,B : Prop) -> Proof A -> Proof (Disj A B) ;
  DisjIr : (A,B : Prop) -> Proof B -> Proof (Disj A B) ;
  DisjE  : (A,B,C : Prop) -> Proof (Disj A B) -> 
              (Hypo A -> Proof C) -> (Hypo B -> Proof C) -> Proof C ;
  ImplI  : (A,B : Prop) -> (Hypo A -> Proof B) -> Proof (Impl A B) ;
  ImplE  : (A,B : Prop) -> Proof (Impl A B) -> Proof A -> Proof B ;
  NegI   : (A : Prop) -> (Hypo A -> Proof Abs) -> Proof (Neg A) ;
  NegE   : (A : Prop) -> Proof (Neg A) -> Proof A -> Proof Abs ;
  AbsE   : (C : Prop) -> Proof Abs -> Proof C ;
  UnivI  : (A : Dom) -> (B : Elem A -> Prop) -> 
              ((x : Elem A) -> Proof (B x)) -> Proof (Univ A B) ;
  UnivE  : (A : Dom) -> (B : Elem A -> Prop) -> 
              Proof (Univ A B) -> (a : Elem A) -> Proof (B a) ;
  ExistI : (A : Dom) -> (B : Elem A -> Prop) -> 
              (a : Elem A) -> Proof (B a) -> Proof (Exist A B) ;
  ExistE : (A : Dom) -> (B : Elem A -> Prop) -> (C : Prop) -> 
              Proof (Exist A B) -> ((x : Elem A) -> Proof (B x) -> Proof C) -> 
              Proof C ;

  -- use a hypothesis
  Hypoth : (A : Prop) -> Hypo A -> Proof A ;

  -- pronoun
  Pron : (A : Dom) -> Elem A -> Elem A ;

} ;
