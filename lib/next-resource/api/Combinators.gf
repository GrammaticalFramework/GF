--1 Combinators: a High-Level Syntax API

-- This module defines some "grammatical functions" that give shortcuts to
-- typical constructions. [``Constructors`` Constructors.html] and the
-- language-specific ``Paradigms`` modules are usually needed
-- to construct arguments of these functions.

incomplete resource Combinators = open Cat, Structural, Constructors in {

  oper

--2 Predication

    pred : overload {
      pred : V  -> NP -> Cl ;             -- x converges
      pred : V2 -> NP -> NP -> Cl ;       -- x intersects y
      pred : V3 -> NP -> NP -> NP -> Cl ; -- x intersects y at z
      pred : V  -> NP -> NP -> Cl ;       -- x and y intersect
      pred : A  -> NP -> Cl ;             -- x is even
      pred : A2 -> NP -> NP -> Cl ;       -- x is divisible by y
      pred : A  -> NP -> NP -> Cl ;       -- x and y are equal
      pred : N  -> NP -> Cl ;             -- x is a maximum
      pred : CN -> NP -> Cl ;             -- x is a local maximum
      pred : NP -> NP -> Cl ;             -- x is the neutral element
      pred : N  -> NP -> NP -> Cl ;       -- x and y are inverses 
      pred : Adv -> NP -> Cl ;            -- x is in scope
      pred : Prep -> NP -> NP -> Cl       -- x is outside y
      } ;

--2 Function application

    app : overload {
      app : N  -> NP ;
      app : N2 -> NP -> NP ; 
      app : N3 -> NP -> NP -> NP ;
      app : N2 -> NP -> NP -> NP ;
      app : N2 -> N  -> CN ;

      app : N2 -> NP -> CN ;         -- divisor of x
      app : N3 -> NP -> NP -> CN ;   -- path from x to y
      app : N2 -> NP -> NP -> CN ;   -- path between x and y
      } ;

--2 Coordination

    coord : overload {
      coord : Conj  -> Adv -> Adv -> Adv ;
      coord : Conj  -> AP -> AP -> AP ;
      coord : Conj  -> NP -> NP -> NP ;
      coord : Conj  -> S  -> S  -> S ;
      coord : Conj  -> ListAdv -> Adv ;
      coord : Conj  -> ListAP -> AP ;
      coord : Conj  -> ListNP -> NP ;
      coord : Conj  -> ListS  -> S ;

      } ;

--2 Modification

    mod : overload {
      mod : A -> N -> CN ;
      mod : AP -> CN -> CN ;
      mod : AdA -> A -> AP ;
      mod : Det -> N -> NP ;
      mod : Det -> CN -> NP ;
      mod : Quant -> N -> NP ;
      mod : Quant -> CN -> NP ;
      mod : Predet -> N -> NP ;
      mod : Numeral -> N -> NP


      } ;

--2 Negation

    neg : overload {
      neg : Imp -> Utt ;
      neg : Cl -> S ;
      neg : QCl -> QS ;
      neg : RCl -> RS 
    };

--2 Text append

-- This is not in ground API, because it would destroy parsing.

    appendText : Text -> Text -> Text ;

--.

    pred = overload {
      pred : V  -> NP -> Cl
           = \v,np -> mkCl np v ;
      pred : V2 -> NP -> NP -> Cl
           = \v,np,ob -> mkCl np v ob ;
      pred : V3 -> NP -> NP -> NP -> Cl 
           = \v,np,ob,ob2 -> mkCl np v ob ob2 ;
      pred : V  -> NP -> NP -> Cl
           = \v,x,y -> mkCl (mkNP and_Conj x y) v ;
      pred : A  -> NP -> Cl 
           = \a,np -> mkCl np a ;
      pred : A2 -> NP -> NP -> Cl
           = \a,x,y -> mkCl x a y ;
      pred : A  -> NP -> NP -> Cl      
           = \a,x,y -> mkCl (mkNP and_Conj x y) a ;
      pred : N -> NP -> Cl
           = \n,x -> mkCl x (mkNP a_Art n) ;
      pred : CN -> NP -> Cl
           = \n,x -> mkCl x (mkNP a_Art n) ;
      pred : NP -> NP -> Cl
           = \n,x -> mkCl x n ;
      pred : N2 -> NP -> NP -> Cl 
           = \n,x,y -> mkCl x (mkNP a_Art (mkCN n y)) ;
      pred : N -> NP -> NP -> Cl 
           = \n,x,y -> mkCl (mkNP and_Conj x y) (mkNP a_Art plNum n) ;
      pred : Adv -> NP -> Cl 
           = \a,x -> mkCl x a ;
      pred : Prep -> NP -> NP -> Cl        
           = \p,x,y -> mkCl x (mkAdv p y) ;
      } ;

    app = overload {
      app : N  -> NP
           = \n -> mkNP the_Art n ;
      app : N2 -> NP -> NP 
           = \n,x -> mkNP the_Art (mkCN n x) ;
      app : N3 -> NP -> NP -> NP
           = \n,x,y -> mkNP the_Art (mkCN n x y) ;
      app : N2 -> NP -> NP -> NP
           = \n,x,y -> mkNP the_Art (mkCN n (mkNP and_Conj x y)) ;
      app : N2 -> N -> CN
           = \f,n -> mkCN f (mkNP a_Art plNum n) ;
      app : N2 -> NP -> CN 
           = mkCN ;
      app : N3 -> NP -> NP -> CN 
           = mkCN ;
      app : N2 -> NP -> NP -> CN 
           = \n,x,y -> mkCN n (mkNP and_Conj x y) ;
      } ;

    coord = overload {
      coord : Conj -> Adv -> Adv -> Adv
           = mkAdv ;
      coord : Conj -> AP -> AP -> AP
           = mkAP ;
      coord : Conj -> NP -> NP -> NP
           = mkNP ;
      coord : Conj -> S  -> S  -> S  
           = mkS ;
      coord : Conj -> ListAdv -> Adv
           = mkAdv ;
      coord : Conj -> ListAP -> AP
           = mkAP ;
      coord : Conj -> ListNP -> NP
           = mkNP ;
      coord : Conj -> ListS  -> S  
           = mkS ;
      } ;

    mod = overload {
      mod : A -> N -> CN
           = mkCN ;
      mod : AP -> CN -> CN
           = mkCN ;
      mod : AdA -> A -> AP
           = mkAP ;
      mod : Det -> N -> NP 
	   = mkNP ;
      mod : Det -> CN -> NP 
	   = mkNP ;
      mod : Quant -> N -> NP
           = mkNP ;
      mod : Quant -> CN -> NP
           = mkNP ;
      mod : Predet -> N -> NP 
           = \p,n -> mkNP p (mkNP a_Art n) ;
      mod : Numeral -> N -> NP
           = mkNP ;
      } ;

    neg = overload {
      neg : Imp -> Utt 
	   = mkUtt negativePol ;
      neg : Cl -> S 
	   = mkS negativePol ;
      neg : QCl -> QS 
           = mkQS negativePol ;
      neg : RCl -> RS 
           = mkRS negativePol ;
    };


}
