abstract Test = {

cat S ;
cat E ;

fun Exist : (E -> S) -> S ;
    Even  : E -> S ;

fun a : E ;
    f,fa,fb : E -> S ;

fun IsString  : String -> S ;
    IsInteger : Int    -> S ;
    IsFloat   : Float  -> S ;

}