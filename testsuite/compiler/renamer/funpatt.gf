abstract funpatt = {

-- this should raise error
-- we cannot pattern match on functions

cat D ;
fun D1 : D ;
    D2 : D ;

fun d : D -> Int ;
def d D1 = 1 ;
    d D2 = 2 ;

}