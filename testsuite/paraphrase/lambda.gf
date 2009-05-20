abstract lambda = {

fun f1 : Int -> Int ;
def f1 = (\x -> x) ;

fun f2 : Int ;
def f2 = f1 1 ;

cat D ;
data D1 : D ;
     D2 : D ;

fun d : D -> Int -> Int ;
def d D1 = \x -> x ;
    d D2 = \x -> 2 ;

}