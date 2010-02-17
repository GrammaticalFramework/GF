--# -path=.:englishExtended
abstract HigherOrder = Merge ** {

fun SingleValuedRelation : (c : Class) -> (El c -> Formula) -> Formula;
def SingleValuedRelation c f = forall c (\x -> forall c (\y -> impl (and (f (var c c ? x)) (f (var c c ? y))) (equal (var c Entity ? x) (var c Entity ? y))));

fun AntisymmetricRelation : (c : Class) -> (El c -> El c -> Formula) -> Formula ;
def AntisymmetricRelation c f = forall c (\x -> forall c (\y -> impl (and (f (var c c ? x) (var c c ? y)) (f (var c c ? y) (var c c ? x))) (equal (var c Entity ? x) (var c Entity ? y))));

fun IntentionalRelation : (c1,c2 : Class) -> (El c1 -> El c2 -> Formula) -> Formula ;
def IntentionalRelation c1 c2 f = forall c1 (\x -> forall c2 (\y -> inScopeOfInterest (var c1 CognitiveAgent ? x) (var c2 Entity ? y)));
-- assume binary predicate, since it is mostly used for that

fun ReflexiveRelation : (c : Class) -> (El c -> El c -> Formula) -> Formula ;
def ReflexiveRelation c f = forall c (\x -> f (var c c ? x) (var c c ? x));

fun SymmetricRelation : (c : Class) -> (El c -> El c -> Formula) -> Formula ;
def SymmetricRelation c f = forall c (\x -> forall c(\y -> impl (f (var c c ? x) (var c c ? y)) (f (var c c ? y) (var c c ? x))));

fun EquivalenceRelation : (c : Class) -> (El c -> El c -> Formula) -> Formula ;
def EquivalenceRelation c f = and (and (ReflexiveRelation c f) (SymmetricRelation c f)) (TransitiveRelation c f);

fun TransitiveRelation : (c : Class) -> (El c -> El c -> Formula) -> Formula ;
def TransitiveRelation c f = forall c (\x -> forall c (\y -> forall c(\z -> impl (and (f (var c c ? x) (var c c ? y)) (f (var c c ? y) (var c c ? z))) (f (var c c ? x) (var c c ? z)))));

fun IrreflexiveRelation : (c : Class) -> (El c -> El c -> Formula) -> Formula ;
def IrreflexiveRelation c f = forall c (\x -> not (f (var c c ? x) (var c c ? x)));

fun AsymmetricRelation : (c : Class) -> (El c -> El c -> Formula) -> Formula ;
def AsymmetricRelation c f = and (AntisymmetricRelation c f) (IrreflexiveRelation c f);

fun PropositionalAttitude : (c : Class) -> (El c -> El c -> Formula) -> Formula ;
def PropositionalAttitude c f = (AsymmetricRelation c f);

fun ObjectAttitude : (c1,c2 : Class) -> (El c1 -> El c2 -> Formula) -> Formula ;
def ObjectAttitude c1 c2 f = IntentionalRelation c1 c2 f ;

fun IntransitiveRelation : (c : Class) -> (El c -> El c -> Formula) -> Formula ;
def IntransitiveRelation c f = forall c (\x -> forall c (\y -> forall c(\z -> impl (and (f (var c c ? x) (var c c ? y)) (f (var c c ? y) (var c c ? z))) (not (f (var c c ? x) (var c c ? z))))));

fun PartialOrderingRelation : (c : Class) -> (El c -> El c -> Formula) -> Formula ;
def PartialOrderingRelation c f = and (and (TransitiveRelation c f) (AntisymmetricRelation c f)) (ReflexiveRelation c f);

fun TrichotomizingRelation : (c : Class) -> (El c -> El c -> Formula) -> Formula ;
def TrichotomizingRelation c f = forall c (\x -> forall c (\y ->
or
(or
(and
(and (f (var c c ? x) (var c c ? y))
(not (equal (var c Entity ? x) (var c Entity ? y))))
(not (f (var c c ? y) (var c c ? x))))
(and
(and (not (f (var c c ? x) (var c c ? y)))
(equal (var c Entity ? x) (var c Entity ? y)))
(not (f (var c c ? y) (var c c ? x)))))
(and
(and (f (var c c ? y) (var c c ? x))
(not (equal (var c Entity ? x) (var c Entity ? y))))
(not (f (var c c ? x) (var c c ? y))))));

fun TotalOrderingRelation : (c : Class) -> (El c -> El c -> Formula) -> Formula ;
def TotalOrderingRelation c f = and (PartialOrderingRelation c f) (TrichotomizingRelation c f) ;

fun OneToOneFunction : (c1, c2 : Class) -> (El c1 -> Ind c2) -> Formula ;
def OneToOneFunction c1 c2 f = forall c1(\x -> 
                                forall c1(\y -> impl (not(equal (var c1 Entity ? x) (var c1 Entity ? y))) (not (equal (el c2 Entity ? (f (var c1 c1 ? x))) (el c2 Entity ? (f (var c1 c1 ? y)))))));
                                                         
fun SequenceFunction : (c : Class) -> (El Integer -> Ind c) -> Formula ;
def SequenceFunction c f = OneToOneFunction Integer c f ;

fun AssociativeFunction : (c : Class) -> (El c -> El c -> Ind c) -> Formula ;
def AssociativeFunction c f = forall c(\x -> 
                               forall c(\y ->
                                forall c(\z -> equal (el c Entity ? (f (var c c ? x) (el c c ? (f (var c c ? y) (var c c ? z))))) (el c Entity ? (f (el c c ? (f (var c c ? x) (var c c ? y))) (var c c ? z))))));

fun CommutativeFunction : (c1,c2 : Class) -> (El c1 -> El c1 -> Ind c2) -> Formula ;
def CommutativeFunction c1 c2 f = forall c1 (\x -> 
                                   forall c1 (\y ->
                                    equal (el c2 Entity ? (f (var c1 c1 ? x) (var c1 c1 ? y))) (el c2 Entity ? (f (var c1 c1 ? y) (var c1 c1 ? y)))));

fun identityElement : (c : Class) -> (El c -> El c -> Ind c) -> El c -> Formula ;
def identityElement c f elem = forall c(\x -> equal (el c Entity ? (f (var c c ? x) elem)) (var c Entity ? x));

fun distributes : (c : Class) -> (El c -> El c -> Ind c) -> (El c -> El c -> Ind c) -> Formula ;
def distributes c f g = forall c (\x -> forall c (\y -> forall c (\z -> equal (el c Entity ? (g (el c c ? (f (var c c ? x) (var c c ? y))) (var c c ? z))) (el c Entity ? (f (el c c ? (g (var c c ? x) (var c c ? z))) (el c c ? (g (var c c ? y) (var c c ? z))))))));
 
fun inverse : (c : Class) -> (El c -> El c -> Formula) -> (El c -> El c -> Formula) -> Formula ;
def inverse c f g = forall c (\x -> forall c (\y -> equiv (f (var c c ? x) (var c c ? y)) (g (var c c ? y) (var c c ? x))));                                     

fun subRelation2El : (c1,c2,c3,c4 : Class) -> (El c1 -> El c2 -> Formula) -> (El c3 -> El c4 -> Formula) -> Formula ;
def subRelation2El c1 c2 c3 c4 f g = forall c1 (\x -> forall c2 (\y -> impl (f (var c1 c1 ? x) (var c2 c2 ? y)) (g (var c1 c3 ? x) (var c2 c4 ? y))));

fun KappaFn : (c : Class) -> (Ind c -> Formula) -> Class ;




};