-------------------------------------------------------------------------
--
-- Abstract Syntax for RDF according to the RDF and RDFS specifications
--
-- (c) Krasimir Angelov
--
-------------------------------------------------------------------------

abstract RDF = {

cat Value (class : Class) ;

cat Resource (class : Class) ;
fun res   : (c : Class) -> Resource c -> Value c ;

cat [Resource (class : Class)] ;

cat URI ;
fun uri : (c : Class) -> URI -> Resource c ;

cat BNode ;
fun bnode  : (c : Class) -> BNode -> Resource c ;
    nodeId : String -> BNode ;

cat DataType ;
fun datatype : DataType -> URI ;

cat Literal ;
fun lit    : Literal -> Value literal_C ;
    int    : Int    -> Literal ;
    float  : Float  -> Literal ;
    string : String -> DataType -> Literal ;

cat Property (domain, range : Class) ;
fun property : (d, r : Class) -> Property d r -> URI ;

cat Container (class : Class) ;
fun container : (c : Class) -> Container c -> Resource c ;
    bag  : Resource bag_C -> [Resource resource_C] -> Container bag_C ;
    seq  : Resource seq_C -> [Resource resource_C] -> Container seq_C ;
    alt  : Resource alt_C -> [Resource resource_C] -> Container alt_C ;

cat Statement ;
fun statement : Statement -> Resource statement_C ;
    assert   : (d,r : Class) ->                         Resource d -> Property d r -> Value r -> Statement ;
    r_assert : (d,r : Class) -> Resource statement_C -> Resource d -> Property d r -> Value r -> Statement ;

cat Attribute (class : Class) (subject : Resource class) ;
fun assign   : (d,r : Class) ->                         (s : Resource d) -> Property d r -> Value r -> Attribute d s ;
    r_assign : (d,r : Class) -> Resource statement_C -> (s : Resource d) -> Property d r -> Value r -> Attribute d s ;

cat [Attribute (class : Class) (subject : Resource class)] ;

cat Description ;
fun description : Description -> Resource bag_C ;
    describe    :                   (c : Class) -> (s : Resource c) -> [Attribute c s] -> Description ;
    r_describe  : Resource bag_C -> (c : Class) -> (s : Resource c) -> [Attribute c s] -> Description ;

cat Class ;
fun class : Class -> Resource class_C ;

fun resource_C           : Class ;
    class_C              : Class ;
    property_C           : Class ;
    constraintResource_C : Class ;
    constraintProperty_C : Class ;
    literal_C            : Class ;
    statement_C          : Class ;
    bag_C                : Class ;
    seq_C                : Class ;
    alt_C                : Class ;

cat Inheritance (c1,c2 : Class) ;
fun inheritance : (c1,c2 : Class) -> Inheritance c1 c2 -> Statement ;
    upcast : (c1,c2 : Class) -> Inheritance c1 c2 -> Resource c1 -> Resource c2 ;

}