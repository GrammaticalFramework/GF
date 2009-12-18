concrete LogicGer of Logic = SymbolsX ** LogicI - [Exist] with
  (LexLogic = LexLogicGer),
  (Lang = LangGer),
  (Syntax = SyntaxGer),
  (Symbolic = SymbolicGer) ** open SyntaxGer, (P = ParadigmsGer) in {

lin
  --- to get the extraposited clause in correct place
  Exist xs A B = 
    Lang.SSubjS
    (mkS (mkCl (indef xs.p2 
      (mkCN (mkCN A xs.p1) (P.mkAdv "derart")))))
    that_Subj B ;

} ;
