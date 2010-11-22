concrete LogicEng of Logic = open 
  SyntaxEng, (P = ParadigmsEng), SymbolicEng, Prelude in {
lincat
  Stm  = Text ;
  Prop = {pos,neg : S ; isAtom : Bool} ; 
  Atom = Cl ; 
  Ind  = NP ; 
  Dom  = CN ; 
  Var  = NP ; 
  [Prop] = ListS ; 
  [Var]  = NP ; 
lin
  SProp p = mkText p.pos ;
  And ps = complexProp (mkS and_Conj ps) ;
  Or ps = complexProp (mkS or_Conj ps) ;
  If A B = complexProp (mkS if_then_Conj (mkListS A.pos B.pos)) ;
  Not A = complexProp A.neg ;
  All xs A B = complexProp (mkS (mkAdv for_Prep 
    (mkNP all_Predet (mkNP a_Quant plNum (mkCN A xs)))) B.pos) ;
  Exist xs A B = complexProp (mkS (mkAdv for_Prep 
    (mkNP somePl_Det (mkCN A xs))) B.pos) ;
  PAtom p = 
    {pos = mkS p ; neg = mkS negativePol p ; isAtom = True} ;
  IVar x = x ;
  VString s = symb s ;
  BaseProp A B = mkListS A.pos B.pos ; 
  ConsProp A As = mkListS A.pos As ;
  BaseVar x = x ;
  ConsVar x xs = mkNP and_Conj (mkListNP x xs) ;
oper 
  complexProp : S -> {pos,neg : S ; isAtom : Bool} = \s -> {
    pos = s ; 
    neg = negS s ; 
    isAtom = False 
    } ;
  negS : S -> S = \s -> mkS negativePol (mkCl (mkNP it_Pron) 
      (mkNP the_Quant (mkCN (mkCN (P.mkN "case")) s))) ; 
  if_Then_Conj : Conj = P.mkConj "if" "then" ;
}
