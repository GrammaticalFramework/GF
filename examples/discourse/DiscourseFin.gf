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

  NoFocClause np vp = 
    E.PredClPlus np vp ;
  FocSubjClause np vp = 
    E.PredClPlusFocSubj np vp ;
  FocVerbClause np vp = 
    E.PredClPlusFocVerb np vp ;
  FocObjClause np vp obj = 
    lin ClPlus (E.PredClPlusFocObj np vp obj) ;
  FocAdvS np vp adv = 
    lin ClPlus (E.PredClPlusFocAdv np vp adv) ;

{-
  ClauseS marker temp pol np vp = 
    E.S_SVO marker temp pol (E.PredClPlus np vp) ;
  FocSubjS marker temp pol np vp = 
    E.S_SVO marker temp pol (E.PredClPlusFocSubj np vp) ;
  FocVerbS marker temp pol np vp = 
    E.S_SVO marker temp pol (E.PredClPlusFocVerb np vp) ;
  FocObjS marker temp pol np vp obj = 
    E.S_SVO marker temp pol (E.PredClPlusFocObj np vp obj) ;
  FocAdvS marker temp pol np vp adv = 
    E.S_SVO marker temp pol (E.PredClPlusFocAdv np vp adv) ;
-}
  neutralMarker  = E.noPart ;
  remindMarker   = E.han_Part ;
  contrastMarker = E.pas_Part ;

}
