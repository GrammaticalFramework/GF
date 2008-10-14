abstract Check = {

cat Typ ; Exp Typ ;

fun plus : (t : Typ) -> (_,_ : Exp t) -> Exp t ;

fun TInt, TFloat : Typ ;

fun Zero : Exp TInt ;
fun Pi : Exp TFloat ;

fun sqrt : Exp TFloat -> Exp TFloat ;

}
