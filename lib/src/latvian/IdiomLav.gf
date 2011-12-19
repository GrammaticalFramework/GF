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
    let a = AgP3 Sg Masc
    in {
      s = \\mood,pol =>
        buildVerb vp.v mood pol a ++	-- Verb
        vp.s2 ! a						-- Object(s), complements, adverbial modifiers
    } ;

  GenericCl vp =
    let a = AgP3 Sg Masc
    in {
      s = \\mood,pol =>
        buildVerb vp.v mood pol a ++
        vp.s2 ! a
    } ;

  ExistNP np =
    let
      v = lin V mkVerb_toBe ;
      a = np.a
    in {
      s = \\mood,pol =>
        buildVerb v mood pol a ++
        np.s ! Nom
    } ;

  ExistIP ip =
    let
      v = lin V mkVerb_toBe ;
      a = AgP3 ip.n Masc
	in {
      s = \\mood,pol =>
        ip.s ! Nom ++
        buildVerb v mood pol a
    } ;

  -- FIXME: needs restriction so that only VerbMood Indicative _ _ Present is allowed;
  -- can't do that on VP level...
  ProgrVP v = v ;

  ImpPl1 vp =
    let a = AgP1 Pl
    in {
      s =
        vp.v.s ! Pos ! (Indicative P1 Pl Pres) ++	-- Verb
        vp.s2 ! a									-- Object(s), complements, adverbial modifiers
    } | {
      s =
        vp.v.s ! Pos ! (Indicative P1 Pl Fut) ++
        vp.s2 ! a
    } ;

  ImpP3 np vp = {
    s = "lai" ++ np.s ! Nom ++ buildVerb vp.v (Ind Simul Pres) Pos np.a ++ vp.s2 ! np.a ;
  } ;

  -- FIXME: placeholder
  CleftNP np rs = { s = \\_,_ => NON_EXISTENT } ;
  CleftAdv ad s = { s = \\_,_ => NON_EXISTENT } ;

}
