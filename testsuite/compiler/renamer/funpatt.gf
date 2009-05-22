abstract funpatt = {

-- this should raise error
-- we cannot pattern match on functions

cat D ;
fun D1 : Int -> D ;
    D2 : Int -> D ;

fun d : D -> Int ;
def d (D1 _) = 1 ;
    d (D2 _) = 2 ;

}