--# -path=.:englishExtended:common:prelude:abstract
abstract Basic = open Conjunction in {
cat Class;
   El Class;
   Ind Class;
   SubClassC (c1,c2 : Class) (Var c2 -> Formula);
   SubClass (c1,c2 : Class);
   Inherits Class Class ;
   [El Class];
   [Class];
   Formula;
   Desc Class;
   Var Class;
   Stmt ;
   
-- inheritance between classes   
data 
inhz : (c : Class) -> Inherits c c;
inhs : (c1, c2, c3 : Class) -> (p : Var c2 -> Formula) -> SubClassC c1 c2 p -> Inherits c2 c3 -> Inherits c1 c3;
inhsC : (c1, c2, c3 : Class) -> SubClass c1 c2 -> Inherits c2 c3 -> Inherits c1 c3;


-- coercion from Var to El

data 
var : (c1 , c2 : Class) -> Inherits c1 c2 -> Var c1 -> El c2 ;


-- coercion from Ind to El 
data 
el : (c1, c2 : Class) -> Inherits c1 c2 -> Ind c1 -> El c2;


-- class-forming operations
data 
both : Class -> Class -> Class ;
either : Class -> Class -> Class ;


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

-- axioms for both
data 

-- (both c1 c2) is subclass of c1 and of c2
bothL : (c1, c2 : Class) -> Inherits (both c1 c2) c1 ;
bothR : (c1, c2 : Class) -> Inherits (both c1 c2) c2 ; 

-- relationship with other subclasses
bothC : (c1, c2, c3 : Class) -> Inherits c3 c1 -> Inherits c3 c2 -> Inherits c3 (both c1 c2);

-- axioms for either 
data 

-- (either c1 c2) is superclass of c1 and of c2
eitherL : (c1, c2 : Class) -> Inherits c1 (either c1 c2);
eitherR : (c1, c2 : Class) -> Inherits c2 (either c1 c2);

-- relationship with other subclasses
eitherC : (c1,c2,c3 : Class) -> Inherits c1 c3 -> Inherits c2 c3 -> Inherits (either c1 c2) c3 ; 


-- Desc category
data desc : (c1,c2 : Class) -> Inherits c1 c2 -> Desc c2 ;

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
subClassCStm : (c1,c2 : Class) -> (p : Var c2 -> Formula) -> SubClassC c1 c2 p -> Stmt ;
instStm : (c : Class) -> Ind c -> Stmt ;
formStm : Formula -> Stmt ;



};