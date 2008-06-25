--# -path=.:mathematical:present:resource-1.0/api:prelude

concrete LogicEng of Logic = LogicI with
  (LexTheory = LexTheoryEng), 
  (Prooftext = ProoftextEng),
  (Grammar = GrammarEng), 
  (Symbolic = SymbolicEng), 
  (Symbol = SymbolEng), 
  (Combinators = CombinatorsEng), 
  (Constructors = ConstructorsEng), 
  ;

{-
ImplI Abs Abs (\h -> DisjE Abs Abs Abs (DisjIr Abs Abs (Hypoth Abs h)) 
(\x -> Hypoth Abs x) (\y -> Hypoth Abs y))

assume that we have a contradiction . by the hypothesis we have a contradiction . 
a fortiori we have a contradiction or we have a contradiction . 
we have two cases. assume that we have a contradiction . 
by the hypothesis we have a contradiction . assume that we have a contradiction . 
by the hypothesis we have a contradiction . therefore we have a contradiction . 
therefore if we have a contradiction then we have a contradiction .
-}
