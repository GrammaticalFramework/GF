abstract ParseEngAbs = 
  Parse, 
  ExtraEngAbs - [
   -- Don't include the uncontracted clauses. Instead
   -- use them as variants of the contracted ones.
   UncNegCl, UncNegQCl, UncNegRCl, UncNegImpSg, UncNegImpPl
  ]
  ** {

-- Syntactic additions

fun VerbCN : V -> CN -> CN ; -- running man

fun NumOfNP : Num -> NP -> NP ; -- ten of the dogs

-- Lexical additions

fun a8few_Det : Det ;
fun another_Predet : Predet ;
fun any_Predet : Predet ;
fun anybody_NP : NP ;
fun anything_NP : NP ;
fun at8least_AdN : AdN ;
fun at8most_AdN : AdN ;
fun both_Det : Det ;
fun either_Det : Det ;
fun exactly_AdN : AdN ;
fun most_Det : Det ;
fun neither_Det : Det ;
fun no_Det : Det ;
fun nobody_NP : NP ;
fun nothing_NP : NP ;
fun only_AdV : AdV ;
fun should_VV : VV ;
fun several_Det : Det ;

}