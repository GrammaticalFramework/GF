--# -path=.:abstract:common:prelude

concrete IdiomLav of Idiom = CatLav ** open
  VerbLav,
  ParadigmsLav,
  ResLav,
  Prelude
in {

flags

  coding = utf8 ;
  optimize = all_subs ;

lin

  ImpersCl vp =
    let agr = AgrP3 Sg Masc
    in {
      s = \\mood,pol =>
        buildVerb vp.v mood pol agr Pos vp.rightPol ++  -- Verb
        vp.compl ! agr  -- Object(s), complements, adverbial modifiers
    } ;

  GenericCl vp =
    let agr = AgrP3 Sg Masc
    in {
      s = \\mood,pol =>
        buildVerb vp.v mood pol agr Pos vp.rightPol ++
        vp.compl ! agr
    } ;

  ExistNP np = {
    s = \\mood,pol => buildVerb (mkV "būt") mood pol np.agr np.pol Pos ++ np.s ! Nom
  } ;

  ExistIP ip = {
    s = \\mood,pol => ip.s ! Nom ++ buildVerb (mkV "būt") mood pol (AgrP3 ip.num Masc) Pos Pos
  } ;

  -- FIXME: needs restriction so that only VMood Indicative _ _ Present is allowed;
  -- can't do that on VP level...
  ProgrVP v = v ;

  ImpPl1 vp =
    let agr = AgrP1 Pl Masc
    in {
      s =
        vp.v.s ! Pos ! (VInd P1 Pl Pres) ++  -- Verb
        vp.compl ! agr  -- Object(s), complements, adverbial modifiers
    }
    | { s = vp.v.s ! Pos ! (VInd P1 Pl Fut) ++ vp.compl ! agr }  --# notpresent
    ;

  ImpP3 np vp = {
    s = "lai" ++ np.s ! Nom ++ buildVerb vp.v (Ind Simul Pres) Pos np.agr np.pol vp.rightPol ++ vp.compl ! np.agr ;
  } ;

  -- FIXME: placeholder
  CleftNP np rs = { s = \\_,_ => NON_EXISTENT } ;
  CleftAdv ad s = { s = \\_,_ => NON_EXISTENT } ;

}
