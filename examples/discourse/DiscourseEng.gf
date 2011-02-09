--# -path=.:present

concrete DiscourseEng of Discourse = 
  LexiconEng,
  NounEng, VerbEng - [SlashV2VNP,SlashVV, Slash2V3, Slash3V3],
  AdjectiveEng, AdverbEng,  
  StructuralEng - [nobody_NP,nothing_NP],
  TenseX
** open SyntaxEng, (P = ParadigmsEng), (R = ParamX), (E = ExtraEng), (L = LangEng), Prelude in {

lincat
  Clause = {s : R.Polarity => {subj : NP ; vps : VPSlash ; obj : NP ; adv : Adv}} ;
  Marker = Adv ;

lin
  PreSubjS marker temp pol cla = 
    let cl = cla.s ! pol.p in
    mkS marker (mkS temp pol 
      (mkCl cl.subj (mkVP (mkVP cl.vps cl.obj) cl.adv))) ;

  PreVerbS marker temp pol cla = 
    let cl = cla.s ! pol.p in
    mkS marker (mkS temp pol 
      (mkCl cl.subj (mkVP actually_AdV (mkVP (mkVP E.do_VV (mkVP cl.vps cl.obj)) cl.adv)))) ;

  PreObjS marker temp pol cla = 
    let cl = cla.s ! pol.p in
    mkS marker (mkS (mkCl cl.obj
      (mkRS temp pol (mkRCl E.that_RP (mkClSlash cl.subj (L.AdvVPSlash cl.vps cl.adv)))))) ;

  PreAdvS marker temp pol cla = 
    let cl = cla.s ! pol.p in
    mkS marker (mkS cl.adv
      (mkS temp pol (mkCl cl.subj (mkVP cl.vps cl.obj)))) ;

  NoFocClause np vps obj adv = 
    {s = \\p => {subj = np ; vps = vps ; obj = obj ; adv = adv}} ;
  FocSubjClause np vps obj adv = 
    {s = \\p => {subj = mkNP np (too p) ; vps = vps ; obj = obj ; adv = adv}} ;
  FocVerbClause np vps obj adv = 
    {s = \\p => {subj = np ; vps = L.AdVVPSlash even_AdV vps ; obj = obj ; adv = adv}} ;
  FocObjClause np vps obj adv = 
    {s = \\p => {subj = np ; vps = vps ; obj = mkNP obj (too p) ; adv = adv}} ;
  FocAdvClause np vps obj adv = 
    {s = \\p => {subj = np ; vps = vps ; obj = obj ; adv = lin Adv (ss (adv.s ++ (too p).s))}} ;

  neutralMarker  = P.mkAdv [] ;
  remindMarker   = P.mkAdv "as we know" ;
  contrastMarker = P.mkAdv "no but" ;

oper
  too : R.Polarity -> Adv = \p -> case p of {R.Pos => P.mkAdv "too" ; R.Neg => P.mkAdv "either"} ;
  even_AdV = P.mkAdV "even" ;
  actually_AdV = P.mkAdV "actually" ;

}
