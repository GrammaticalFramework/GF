concrete LogicIta of Logic = GrammarIta ** open ResIta, Formal, Prelude in {


lincat
  T, I = SS ;
lin
  And x y = infixSS "&" x y ;
  Or x y = infixSS "v" x y ;
  If x y = infixSS "->" x y ;
  Not x = prefixSS "~" x ;
  All P = prefixSS (parenth ("A" ++ P.$0)) P ;
  Exist P = prefixSS (parenth ("E" ++ P.$0)) P ;
  Past P = prefixSS "Past" P ;

lin
  iN f = star (f.s ! Sg) ;
  iA f = star (f.s ! Masc ! Sg) ;
  iV f = star (f.s ! VInf) ;
  iV2 f x y = star (f.s ! VInf) (cc2 x y) ;

oper star : Str -> SS -> SS = \f,x -> prefixSS f (ss (parenth x.s)) ;

{-

lincat
  T, I = TermPrec ;
lin
  And = infixl 2 "&" ;
  Or  = infixl 2 "v" ;
  If  = infixr 1 "->" ;
--  Not = prefix 3 "~" ;
--  All : (I -> T) -> T ;
--  Exist : (I -> T) -> T ;
--  Past : T -> T ;

lin
  iS   : S -> T ;
  iCl  : Cl -> T ;
  iNP  : NP -> (I -> T) -> T ;
  iVP  : VP -> I -> T ;
  iAP  : AP -> I -> T ;
  iCN  : CN -> I -> T ;
  iDet : Det -> (I -> T) -> (I -> T) -> T ;
  iN   : N -> I -> T ;
  iA   : A -> I -> T ;
  iV   : V -> I -> T ;
  iV2  : V2 -> I -> I -> T ;
  iAdA : AdA -> (I -> T) -> I -> T ;
  iTense : Tense -> T -> T ;
  iPol  : Pol  -> T -> T ;
  iConj : Conj -> T -> T -> T ;
-}

}
