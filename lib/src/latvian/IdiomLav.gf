--# -path=.:../abstract:../common:../prelude

concrete IdiomLav of Idiom = CatLav ** open
  Prelude,
  ResLav,
  VerbLav,
  ParadigmsVerbsLav
in {

flags
  coding = utf8 ;
  optimize = all_subs ;

lin
  ImpersCl vp =
    let agr = AgP3 Sg Masc
    in {
      s = \\mood,pol =>
        buildVerb vp.v mood pol agr False vp.objNeg ++  -- Verb
        vp.compl ! agr  -- Object(s), complements, adverbial modifiers
    } ;

  GenericCl vp =
    let agr = AgP3 Sg Masc
    in {
      s = \\mood,pol =>
        buildVerb vp.v mood pol agr False vp.objNeg ++
        vp.compl ! agr
    } ;

  ExistNP np =
    let
      v = lin V mkVerb_Irreg_Be ;
      agr = np.a
    in {
      s = \\mood,pol =>
        buildVerb v mood pol agr np.isNeg False ++
        np.s ! Nom
    } ;

  ExistIP ip =
    let
      v = lin V mkVerb_Irreg_Be ;
      agr = AgP3 ip.n Masc
	in {
      s = \\mood,pol =>
        ip.s ! Nom ++
        buildVerb v mood pol agr False False
    } ;

  -- FIXME: needs restriction so that only VerbMood Indicative _ _ Present is allowed;
  -- can't do that on VP level...
  ProgrVP v = v ;

  ImpPl1 vp =
    let agr = AgP1 Pl Masc
    in {
      s =
        vp.v.s ! Pos ! (Indicative P1 Pl Pres) ++  -- Verb
        vp.compl ! agr  -- Object(s), complements, adverbial modifiers
    }
    | { s = vp.v.s ! Pos ! (Indicative P1 Pl Fut) ++ vp.compl ! agr }  --# notpresent
    ;

  ImpP3 np vp = {
    s = "lai" ++ np.s ! Nom ++ buildVerb vp.v (Ind Simul Pres) Pos np.a np.isNeg vp.objNeg ++ vp.compl ! np.a ;
  } ;

  -- FIXME: placeholder
  CleftNP np rs = { s = \\_,_ => NON_EXISTENT } ;
  CleftAdv ad s = { s = \\_,_ => NON_EXISTENT } ;

}
