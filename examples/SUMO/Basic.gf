--# -path=.:englishExtended:common:prelude:abstract
abstract Basic = {

cat
  Class;
  El Class;
  Ind Class;
  SubClass (c1,c2 : Class);
  Inherits Class Class ;
  [El Class];
  [Class];
  Formula;
  Desc Class;
  Var Class;
  Stmt ;


-- class-forming operations
data 
  both : Class -> Class -> Class ;
  either : Class -> Class -> Class ;
  
  KappaFn : (c : Class) -> (Var c -> Formula) -> Class ;


-- inheritance between classes   
data
  -- simple sub-class relations
  inhz : (c : Class) -> Inherits c c;
  inhs : (c1, c2, c3 : Class) -> SubClass c1 c2 -> Inherits c2 c3 -> Inherits c1 c3;

  -- (both c1 c2) is subclass of c1 and of c2
  bothL : (c1, c2 : Class) -> SubClass (both c1 c2) c1 ;
  bothR : (c1, c2 : Class) -> SubClass (both c1 c2) c2 ;

  -- relationship with other subclasses
  bothC : (c1, c2, c3 : Class) -> Inherits c3 c1 -> Inherits c3 c2 -> Inherits c3 (both c1 c2);

  -- (either c1 c2) is superclass of c1 and of c2
  eitherL : (c1, c2 : Class) -> Inherits c1 (either c1 c2);
  eitherR : (c1, c2 : Class) -> Inherits c2 (either c1 c2);

  -- relationship with other subclasses
  eitherC : (c1,c2,c3 : Class) -> SubClass c1 c3 -> SubClass c2 c3 -> SubClass (either c1 c2) c3 ; 

  -- sub-class axiom for KappaFn
  kappa : (c : Class) -> (p : Var c -> Formula) -> Inherits (KappaFn c p) c ;


-- coercion from Var to El
data 
  var : (c1 , c2 : Class) -> Inherits c1 c2 -> Var c1 -> El c2 ;


-- coercion from Ind to El 
data 
  el : (c1, c2 : Class) -> Inherits c1 c2 -> Ind c1 -> El c2;


-- first-order logic operations for Formula
data 
  not : Formula -> Formula;
  and : Formula -> Formula -> Formula;
  or : Formula -> Formula -> Formula;
  impl : Formula -> Formula -> Formula;
  equiv : Formula -> Formula -> Formula;

-- quantification over instances of a Class
data
  exists : (c : Class) -> (Var c -> Formula) -> Formula;
  forall : (c : Class) -> (Var c -> Formula) -> Formula;


-- Desc category
data
  desc : (c1,c2 : Class) -> Inherits c1 c2 -> Desc c2 ;

fun descClass : (c : Class) -> Desc c -> Class ;
def descClass _ (desc c _ _) = c ;

fun descInh : (c : Class) -> (p : Desc c) -> Inherits (descClass c p) c ;
--def descInh c1 (desc c2 c1 i) = i ;

fun desc2desc : (c1,c2 : Class) -> Inherits c1 c2 -> Desc c1 -> Desc c2 ;
--def desc2desc _ _ inh dsc = desc ? ? (plusInh ? ? ? inh (descInh ? dsc)) ;

--fun plusInh : (c1,c2,c3 : Class) -> Inherits c1 c2 -> Inherits c2 c3 -> Inherits c1 c3 ;
--def plusInh _ _ _ inhz                 inh2 = inh2 ;
--    plusInh _ _ _ (inhs _ _ _ sc inh1) inh2 = inhs ? ? ? sc (plusInh ? ? ? inh1 inh2) ;


-- statements 
data 
  subClassStm : (c1,c2 : Class) -> SubClass c1 c2 -> Stmt ;
  instStm : (c : Class) -> Ind c -> Stmt ;
  formStm : Formula -> Stmt ;

};
