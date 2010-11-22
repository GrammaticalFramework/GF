concrete LogicEng of Logic = open 
  SyntaxEng, (P = ParadigmsEng), SymbolicEng, Prelude in {
lincat
  Stm  = Text ;
  Prop = S ;
  Atom = Cl ; 
  Ind  = NP ; 
  Dom  = CN ; 
  Var  = NP ; 
  [Prop] = [S] ; 
  [Var]  = NP ; 
lin
  SProp = mkText ;
  And = mkS and_Conj ;      -- A, B ... and C
  Or = mkS or_Conj ;        -- A, B ... or C
  If A B =                  -- if A B
    mkS (mkAdv if_Subj A) B ;  
  Not A =                   -- it is not the case that A
    mkS negativePol (mkCl 
      (mkVP (mkNP the_Quant 
         (mkCN case_CN A)))) ; 
  All xs A B =              -- for all A's xs, B
    mkS (mkAdv for_Prep 
      (mkNP all_Predet (mkNP a_Quant 
         plNum (mkCN A xs)))) B ;
  Exist xs A B =            -- for some A's xs, B
    mkS (mkAdv for_Prep 
      (mkNP somePl_Det (mkCN A xs))) B ;
  PAtom = mkS ;
  IVar x = x ;
  VString s = symb s ;
  BaseProp A B = mkListS A B ; 
  ConsProp A As = mkListS A As ;
  BaseVar x = x ;
  ConsVar x xs = mkNP and_Conj (mkListNP x xs) ;
oper
  case_CN : CN = mkCN (P.mkN "case") ;
}
