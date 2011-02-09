--# -path=.:present

concrete DiscourseFin of Discourse = 
  LexiconFin,
  NounFin, VerbFin - [SlashV2VNP,SlashVV, Slash2V3, Slash3V3],
  AdjectiveFin, AdverbFin,  
  StructuralFin - [nobody_NP,nothing_NP],
  TenseX
** open SyntaxFin, (P = ParadigmsFin), (R = ParamX), (E = ExtraFin), Prelude in {

lincat
  Clause = E.ClPlus ;
  Marker = E.Part ;

lin
  PreSubjS marker temp pol cl = 
    E.S_SVO marker temp pol cl ;
  PreVerbS marker temp pol cl = 
    E.S_VSO marker temp pol cl ;
  PreObjS marker temp pol cl = 
    E.S_OSV marker temp pol cl ;
  PreAdvS marker temp pol cl = 
    E.S_ASV marker temp pol cl ;

  NoFocClause np vps obj adv = 
    E.PredClPlus np (mkVP (mkVP vps obj) adv) ;
  FocSubjClause np vps obj adv = 
    E.PredClPlusFocSubj np (mkVP (mkVP vps obj) adv) ;
  FocVerbClause np vps obj adv = 
    E.PredClPlusFocVerb np (mkVP (mkVP vps obj) adv) ;
--  FocObjClause np vps obj adv = 
--    lin ClPlus (E.PredClPlusFocObj np (mkVP vps adv) obj) ;
  FocAdvClause np vps obj adv = 
    lin ClPlus (E.PredClPlusFocAdv np (mkVP vps obj) adv) ;

  neutralMarker  = E.noPart ;
  remindMarker   = E.han_Part ;
  contrastMarker = E.pas_Part ;

}
