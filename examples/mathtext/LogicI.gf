incomplete concrete LogicI of Logic = SymbolsX ** open 
  LexLogic, 
  Syntax, 
  Symbolic, 
  (Lang = Lang), -- for SSubjS
  Prelude in {
lincat
  Prop = S ; 
  Atom = Cl ; 
  Ind = NP ; 
  Dom = N ; 
  Var = NP ; 
  [Prop] = [S] ; 
  [Var] = NP * Bool ;
lin
  And = mkS and_Conj ;
  Or = mkS or_Conj ;
  If A B = mkS (mkAdv if_Subj A) B ;
  Iff A B = Lang.SSubjS A iff_Subj B ;
  Not A = 
    Lang.SSubjS
      (mkS negativePol (mkCl 
        (mkVP (mkNP the_Quant case_N)))) that_Subj A ; 
  All xs A B = mkS (mkAdv for_Prep (mkNP all_Predet 
                 (mkNP all_Det (mkCN A xs.p1)))) B ;
  Exist xs A B = mkS (mkCl (indef xs.p2 
                   (mkCN (mkCN A xs.p1) (mkAP (mkAP such_A) B)))) ;
  PAtom = mkS ;
  NAtom = mkS negativePol ;
  MkVar s = symb (dollar s.s) ;
  BaseProp = mkListS ;
  ConsProp = mkListS ;
  BaseVar x = <x,False> ;
  ConsVar x xs = <mkNP and_Conj (mkListNP x xs.p1), True> ;

  PExp e = symb (mkSymb (dollar e.s)) ;
  IExp e = symb (dollar e.s) ;

lincat
  Pred1 = VP ;
  Pred2 = VPSlash ;
lin
  PredPred1 f x = mkCl x f ;
  PredPred2 f x y = mkCl x (mkVP f y) ;

oper 
  dollar : Str -> Str = \s -> "$" ++ s ++ "$" ;
}
