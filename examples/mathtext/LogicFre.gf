concrete LogicFre of Logic = SymbolsX ** LogicI - [Exist] with
  (LexLogic = LexLogicFre),
  (Lang = LangFre),
  (Syntax = SyntaxFre),
  (Symbolic = SymbolicFre) ** open SyntaxFre in {

lin
  --- to get the mood of the that clause correct
  Exist xs A B = 
    Lang.SSubjS
    (mkS (mkCl (indef xs.p2 
      (mkCN such_A (mkCN A xs.p1)))))
    that_Subj B ;

} ;
