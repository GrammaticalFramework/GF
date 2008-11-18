abstract ParseEngAbs = 
  Parse, 
  ExtraEngAbs - [
   UncNegCl, UncNegQCl, UncNegRCl, UncNegImpSg, UncNegImpPl,
   StrandRelSlash,
   that_RP
  ],

  Lexicon [N3, distance_N3, 
	      VQ, wonder_VQ, 
	      V2A, paint_V2A, 
	      V2Q, ask_V2Q,
	      V2V, beg_V2V,
	      V2S, answer_V2S,
	      VA, become_VA],
  BigLexEngAbs

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
fun both_Det : Det ;
fun either_Det : Det ;
fun exactly_AdN : AdN ;
fun most_Det : Det ;
fun neither_Det : Det ;
fun only_AdV : AdV ;
fun should_VV : VV ;
fun several_Det : Det ;

}