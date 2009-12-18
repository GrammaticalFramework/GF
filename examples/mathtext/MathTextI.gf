incomplete concrete MathTextI of MathText = Logic **
  open 
    Syntax,
    (Lang = Lang), ---- for ImpP3, SSubjS 
    Symbolic, 
    LexLogic in {

lincat
  Book = Text ;
  Section = Text ;
  [Section] = Text ;
  Paragraph = Text ;
  [Paragraph] = Text ;
  Statement = Text ;
  Declaration = Utt ;
  [Declaration] = Text ;
  Ident = NP ;
  Proof = Text ;
  Case = Text ;
  [Case] = Text ;
  Number = Card ;
 
lin
  MkBook ss = ss ;
  
  ParAxiom   id stm = mkText (mkText (Lang.UttCN (mkCN axiom_N id))) stm ;
  ParTheorem id stm pr = 
    mkText (mkText (mkText (Lang.UttCN (mkCN theorem_N id))) stm) pr ;

  ParDefInd  cont dum dens = 
    definition (mkText cont (mkText (mkCl (mkNP we_Pron) define_V3 dum dens))) ;
  ParDefPred1 cont arg dum dens = 
    definition (mkText cont (mkText (Lang.SSubjS 
      (mkS (mkCl (mkNP we_Pron) define_V2V arg dum)) 
      if_Subj dens))) ;
  ParDefPred2 cont arg dum obj dens = 
    definition (mkText cont (mkText (Lang.SSubjS 
      (mkS (mkCl (mkNP we_Pron) define_V2V arg (mkVP dum obj))) 
      if_Subj dens))) ;

  BaseSection s = s ;
  ConsSection s ss = mkText s ss ;
  BaseParagraph s = s ;
  ConsParagraph s ss = mkText s ss ;
  BaseCase s t = mkText s t ;
  ConsCase s ss = mkText s ss ;
  BaseDeclaration = emptyText ;
  ConsDeclaration s ss = mkText (mkPhr s) ss ;


  StProp ds prop = mkText ds (mkText prop) ;

  DecVar xs dom = 
    Lang.ImpP3 xs.p1 (mkVP (indef xs.p2 (mkCN dom))) ; 
 --   mkUtt (mkImp (mkVP let_V2V xs.p1 (mkVP (indef xs.p2 (mkCN dom))))) ; 
  DecProp prop = mkUtt prop ;

  PrEnd  = emptyText ;
  PrStep st pr = mkText st pr ;
  PrBy id prop proof = mkText (mkText (mkS (mkAdv by_Prep id) prop)) proof ;
  PrCase num cs = 
    mkText (mkPhr (mkCl (mkNP we_Pron) have_V2 (mkNP num case_N))) cs ;
  CProof id proof = mkText (mkPhr (mkUtt (mkNP (mkCN case_N id)))) proof ;

  IdStr s = symb s.s ;

  Two = mkCard n2_Numeral ;
  Three = mkCard n3_Numeral ;
  Four = mkCard n4_Numeral ;
  Five = mkCard n5_Numeral ;

oper
  definition : Text -> Text = mkText (mkText (Lang.UttCN (mkCN definition_N))) ;
}
