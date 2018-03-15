--# -path=.:../common:../abstract

concrete ExtendEus of Extend =
  CatEus ** ExtendFunctor - [GenNP,ICompAP]
  with (Grammar=GrammarEus)
  ** open Prelude, ResEus in {

  lin
    GenNP np = -- NP -> Quant ; -- this man's
      { s = artDef ;
	indep, isDef = True ;
	pref = np.s ! Gen } ;


    ICompAP ap = -- AP -> IComp ; -- "how old"
      { s = "nola" ++ ap.s ! Hau } ; --TODO agreement -- change type of IComp
 } ;
  