abstract varpatt = {

-- this should raise error
-- we cannot pattern match on functions

cat D ;
fun D1 : D ;
    D2 : D ;

fun d : D -> Int ;
def d x = 1 ;

}