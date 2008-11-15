abstract Symbols = {

cat Var ; Formula ; Term ;

fun plus_Term : Term -> Term -> Term ;
fun minus_Term : Term -> Term -> Term ;
fun div_Term : Term -> Term -> Term ;
fun times_Term : Term -> Term -> Term ;
fun neg_Term : Term -> Term ;
fun int_Term : Int -> Term ;
fun var_Term : Var -> Term ;

fun eq_Formula : Term -> Term -> Formula ;
fun lt_Formula : Term -> Term -> Formula ;
fun gt_Formula : Term -> Term -> Formula ;
fun le_Formula : Term -> Term -> Formula ;
fun ge_Formula : Term -> Term -> Formula ;
fun ne_Formula : Term -> Term -> Formula ;

fun X_Var : Var ;
fun Y_Var : Var ;

}
