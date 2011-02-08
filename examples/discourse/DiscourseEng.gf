--# -path=.:alltenses

concrete DiscourseEng of Discourse = 
  LexiconEng,
  NounEng, VerbEng,
  AdjectiveEng, AdverbEng,
  StructuralEng - [nobody_NP, nothing_NP],
  TenseX
** open SyntaxEng, (P = ParadigmsEng), (R = ParamX), Prelude in {

lincat
  Clause  = {subj : NP ; vp : VP} ;
  Part    = {a : Adv ; isPre : Bool} ;

lin
  ClauseS part temp pol cl = 
    mkS temp pol (mkCl (mkNP cl.subj part) cl.vp) ;
  SubjKinS part temp pol cl = 
    mkS temp pol (mkCl (mkNP (mkNP cl.subj (kin.s ! pol.p)) part) cl.vp) ;
  VerbKinS part temp pol cl = 
    mkS temp pol (mkCl (mkNP cl.subj part) (mkVP cl.vp (kin.s ! pol.p))) ;
  AdvKinS  part temp pol adv cl = 
    mkS temp pol (mkCl (mkNP cl.subj part) (mkVP (mkVP cl.vp adv) (kin.s ! pol.p))) ;
  PreAdvS part temp pol adv cl = 
    mkS adv (mkS part (mkS temp pol (mkCl cl.subj cl.vp))) ;
  PreAdvKinS part temp pol adv cl = 
    mkS adv (mkS part (mkS (kin.s ! pol.p) (mkS temp pol (mkCl cl.subj cl.vp)))) ;
  PreAdvSubjKinS  part temp pol adv cl = 
    mkS adv (mkS part (mkS temp pol (mkCl (mkNP cl.subj (kin.s ! pol.p)) cl.vp))) ;
  PreAdvVerbKinS  part temp pol adv cl = 
    mkS adv (mkS part (mkS temp pol (mkCl cl.subj (mkVP cl.vp (kin.s ! pol.p))))) ;

  PredClause subj v = {subj = subj ; vp = v} ;

  noPart     = {a = P.mkAdv [] ; isPre = False} ;
  han_Part   = {a = P.mkAdv "as you know" ; isPre = True} ;
  pas_Part   = {a = P.mkAdv "no" ; isPre = True} ;

oper 
  kin : {s : R.Polarity => Adv}  = 
    {s = table {R.Pos => P.mkAdv "too" ; R.Neg => P.mkAdv "either"}} ;

}
