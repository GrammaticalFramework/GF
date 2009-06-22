resource Coordination = open Prelude in {

param
  ListSize = TwoElem | ManyElem ;

oper 
  ListX = {s1,s2 : Str} ;

  twoStr : (x,y : Str) -> ListX = \x,y -> 
    {s1 = x ; s2 = y} ; 
  consStr : Str -> ListX -> Str -> ListX = \comma,xs,x -> 
    {s1 = xs.s1 ++ comma ++ xs.s2 ; s2 = x } ; 

  twoSS : (_,_ : SS) -> ListX = \x,y -> 
    twoStr x.s y.s ;
  consSS : Str -> ListX -> SS -> ListX = \comma,xs,x -> 
    consStr comma xs x.s ;

  Conjunction : Type = SS ;
  ConjunctionDistr : Type = {s1 : Str ; s2 : Str} ;

  conjunctX : Conjunction -> ListX -> Str = \or,xs ->
    xs.s1 ++ or.s ++ xs.s2 ;

  conjunctDistrX : ConjunctionDistr -> ListX -> Str = \or,xs ->
    or.s1 ++ xs.s1 ++ or.s2 ++ xs.s2 ;

  conjunctSS : Conjunction -> ListX -> SS = \or,xs ->
    ss (xs.s1 ++ or.s ++ xs.s2) ;

  conjunctDistrSS : ConjunctionDistr -> ListX -> SS = \or,xs ->
    ss (or.s1 ++ xs.s1 ++ or.s2 ++ xs.s2) ;

  -- all this lifted to tables

  ListTable : Type -> Type = \P -> {s1,s2 : P => Str} ; 

  twoTable : (P : Type) -> (_,_ : {s : P => Str}) -> ListTable P = \_,x,y ->
    {s1 = x.s ; s2 = y.s} ; 

  consTable : (P : Type) -> Str -> ListTable P -> {s : P => Str} -> ListTable P = 
    \P,c,xs,x ->
    {s1 = table P {o => xs.s1 ! o ++ c ++ xs.s2 ! o} ; s2 = x.s} ; 

  conjunctTable : (P : Type) -> Conjunction -> ListTable P -> {s : P => Str} = 
    \P,or,xs ->
    {s = table P {p => xs.s1 ! p ++ or.s ++ xs.s2 ! p}} ;

  conjunctDistrTable : 
    (P : Type) -> ConjunctionDistr -> ListTable P -> {s : P => Str} = \P,or,xs ->
    {s = table P {p => or.s1++ xs.s1 ! p ++ or.s2 ++ xs.s2 ! p}} ;

  -- ... and to two- and three-argument tables: how clumsy! ---

  ListTable2 : Type -> Type -> Type = \P,Q -> 
    {s1,s2 : P => Q => Str} ; 

  twoTable2 : (P,Q : Type) -> (_,_ : {s : P => Q => Str}) -> ListTable2 P Q = 
    \_,_,x,y ->
    {s1 = x.s ; s2 = y.s} ; 

  consTable2 : 
    (P,Q : Type) -> Str -> ListTable2 P Q -> {s : P => Q => Str} -> ListTable2 P Q =
     \P,Q,c,xs,x ->
    {s1 = table P {p => table Q {q => xs.s1 ! p ! q ++ c ++ xs.s2 ! p! q}} ; 
     s2 = x.s
    } ; 

  conjunctTable2 : 
    (P,Q : Type) -> Conjunction -> ListTable2 P Q -> {s : P => Q => Str} = 
    \P,Q,or,xs ->
    {s = table P {p => table Q {q => xs.s1 ! p ! q ++ or.s ++ xs.s2 ! p ! q}}} ;

  conjunctDistrTable2 : 
    (P,Q : Type) -> ConjunctionDistr -> ListTable2 P Q -> {s : P => Q => Str} = 
    \P,Q,or,xs ->
    {s = 
    table P {p => table Q {q => or.s1++ xs.s1 ! p ! q ++ or.s2 ++ xs.s2 ! p ! q}}} ;

  ListTable3 : Type -> Type -> Type -> Type = \P,Q,R -> 
    {s1,s2 : P => Q => R => Str} ; 

  twoTable3 : (P,Q,R : Type) -> (_,_ : {s : P => Q => R => Str}) -> 
              ListTable3 P Q R = 
    \_,_,_,x,y ->
    {s1 = x.s ; s2 = y.s} ; 

  consTable3 : 
    (P,Q,R : Type) -> Str -> ListTable3 P Q R -> {s : P => Q => R => Str} -> 
         ListTable3 P Q R =
     \P,Q,R,c,xs,x ->
    {s1 = \\p,q,r => xs.s1 ! p ! q ! r ++ c ++ xs.s2 ! p ! q ! r ; 
     s2 = x.s
    } ; 

  conjunctTable3 : 
    (P,Q,R : Type) -> Conjunction -> ListTable3 P Q R -> {s : P => Q => R => Str} = 
    \P,Q,R,or,xs ->
    {s = \\p,q,r => xs.s1 ! p ! q ! r ++ or.s ++ xs.s2 ! p ! q ! r} ;

  conjunctDistrTable3 : 
    (P,Q,R : Type) -> ConjunctionDistr -> ListTable3 P Q R -> 
       {s : P => Q => R => Str} = 
    \P,Q,R,or,xs ->
    {s = \\p,q,r => or.s1++ xs.s1 ! p ! q ! r ++ or.s2 ++ xs.s2 ! p ! q ! r} ;

  comma = "," ;

-- you can also do this to right-associative lists:

  consrStr : Str -> Str -> ListX -> ListX = \comma,x,xs -> 
    {s1 = x ++ comma ++ xs.s1 ; s2 = xs.s2 } ; 

  consrSS : Str -> SS -> ListX -> ListX = \comma,x,xs -> 
    consrStr comma x.s xs ;

  consrTable : (P : Type) -> Str -> {s : P => Str} -> ListTable P -> ListTable P = 
    \P,c,x,xs ->
    {s1 = table P {o => x.s ! o ++ c ++ xs.s1 ! o} ; s2 = xs.s2} ; 

  consrTable2 : (P,Q : Type) -> Str -> {s : P => Q => Str} -> 
    ListTable2 P Q -> ListTable2 P Q = 
    \P,Q,c,x,xs ->
    {s1 = table P {p => table Q {q => x.s ! p ! q ++ c ++ xs.s1 ! p ! q}} ; 
     s2 = xs.s2
    } ; 

  consrTable3 : (P,Q,R : Type) -> Str -> {s : P => Q => R => Str} -> 
    ListTable3 P Q R -> ListTable3 P Q R = 
    \P,Q,R,c,x,xs ->
    {s1 = table P {p => table Q {q => table R {
       r => x.s ! p ! q ! r ++ c ++ xs.s1 ! p ! q ! r
       }}} ; 
     s2 = xs.s2
    } ; 


} ;
