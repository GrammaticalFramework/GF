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
  Part    = Adv ;

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
  PreAdvAdvKinS  part temp pol adv1 adv2 cl = 
    mkS adv1 (mkS part (mkS temp pol (mkCl cl.subj (mkVP (mkVP cl.vp adv2) (kin.s ! pol.p))))) ;

  PredClause subj v = {subj = subj ; vp = v} ;

---  AnterVerbS part kin t pol cl = 
---    mkS t anteriorAnt pol (mkCl (mkNP cl.subj part) (mkVP cl.vp (kin.s ! pol.p))) ;

  noPart     = P.mkAdv [] ;
  han_Part   = P.mkAdv "as you know" ;
  pa_Part    = P.mkAdv "and nobody else" ;
  pas_Part   = P.mkAdv "and nobody else" ;
  ko_Part    = P.mkAdv "whether" ;
  kos_Part   = P.mkAdv "whether" ;
  kohan_Part = P.mkAdv "whether" ;
  pahan_Part = P.mkAdv "and nobody else as you know" ;


oper 
  kin : {s : R.Polarity => Adv}  = 
    {s = table {R.Pos => P.mkAdv "too" ; R.Neg => P.mkAdv "either"}} ;

}
