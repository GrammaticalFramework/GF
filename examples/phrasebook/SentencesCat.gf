--# -coding=latin1
concrete SentencesCat of Sentences = NumeralCat ** SentencesI - [
  IsMass,
  IFemale, YouFamFemale, YouPolFemale, IMale, YouFamMale, YouPolMale,
  WeMale, WeFemale, YouPlurFamMale, YouPlurFamFemale, YouPlurPolFemale, YouPlurPolMale, TheyMale, TheyFemale, 
  PImperativeFamNeg, PImperativePolNeg, PImperativePlurNeg, --negative imperatives in subjunctive
  Superlative,
  AKnowPerson
 ] 
  with 
    (Syntax = SyntaxCat), 
    (Symbolic = SymbolicCat), 
    (Lexicon = LexiconCat) ** 
  open ParadigmsCat, BeschCat, SyntaxCat, ExtraCat, Prelude in {

--flags coding = utf8 ;

lincat
  Superlative = OrdSuperlative ; -- {ord: Ord ; isPre: Bool}

lin
      IsMass m q = mkCl (mkNP the_Det m) q ; -- le vin allemand est bon

      IFemale = 
        {name = mkNP (ProDrop i8fem_Pron) ; isPron = True ; poss = mkQuant i_Pron} ; 
      YouFamFemale = 
        {name = mkNP (ProDrop youSg8fem_Pron) ; isPron = True ; poss = mkQuant youSg_Pron} ;
      YouPolFemale = 
         {name = mkNP (ProDrop youPol8fem_Pron) ; isPron = True ; poss = mkQuant youPol_Pron};
      IMale = 
         {name = mkNP (ProDrop i_Pron) ; isPron = True ; poss = mkQuant i_Pron} ; 
      YouFamMale = 
         {name = mkNP (ProDrop youSg_Pron) ; isPron = True ; poss = mkQuant youSg_Pron} ; 
      YouPolMale = 
         {name = mkNP (ProDrop youPol_Pron) ; isPron = True ; poss = mkQuant youPol_Pron} ;
      He = 
        {name = mkNP (ProDrop he_Pron) ; isPron = True ; poss = mkQuant he_Pron} ; 
      She = 
        {name = mkNP (ProDrop she_Pron) ; isPron = True ; poss = mkQuant she_Pron} ; 
      WeMale = 
        {name = mkNP (ProDrop we_Pron) ; isPron = True ; poss = mkQuant we_Pron} ; 
      WeFemale = 
        {name = mkNP (ProDrop we8fem_Pron) ; isPron = True ; poss = mkQuant we_Pron} ; 
      YouPlurFamMale = 
        {name = mkNP (ProDrop youPl_Pron) ; isPron = True ; poss = mkQuant youPl_Pron} ; 
      YouPlurFamFemale = 
        {name = mkNP (ProDrop youPl8fem_Pron) ; isPron = True ; poss = mkQuant youPl_Pron} ; 
      YouPlurPolMale = 
        {name = mkNP (ProDrop youPolPl_Pron) ; isPron = True ; poss = mkQuant youPolPl_Pron} ;
      YouPlurPolFemale = 
        {name = mkNP (ProDrop youPolPl8fem_Pron) ; isPron = True ; poss = mkQuant youPolPl_Pron};
      TheyMale = 
        {name = mkNP (ProDrop they_Pron) ; isPron = True ; poss = mkQuant they_Pron} ; 
      TheyFemale = 
        {name = mkNP (ProDrop they8fem_Pron) ; isPron = True ; poss = mkQuant they_Pron} ; 

    PImperativeFamNeg  v = phrasePlease (ImpNeg (mkNP (ProDrop youSg_Pron)) v) ;
    PImperativePolNeg  v = phrasePlease (ImpNeg (mkNP (ProDrop youPol_Pron)) v) ;
    PImperativePlurNeg v = phrasePlease (ImpNeg (mkNP (ProDrop youPl_Pron)) v) ;

    AKnowPerson p q = 
      let coneixer : V2 = mkV2 (mkV (conèixer_27 "conèixer"))
      in  mkCl p.name coneixer  q.name ;

oper

   CNPlace : Type = {name : CN ; at : Prep ; to : Prep }  ;

   mkCNPlace : CN -> Prep -> Prep -> CNPlace = \p,i,t ->
	{ name = p ; at = i ; to = t ; } ;

   OrdSuperlative : Type = {ord: Ord ; isPre: Bool} ;

   placeNPSuperl : OrdSuperlative -> CNPlace -> NPPlace  = \sup,kind -> case sup.isPre of {
     True  => placeNPDet sup.ord kind ;
     False  => placeNPAdj sup.ord kind 
     } ;

   placeNPDet : Ord -> CNPlace -> NPPlace = \ord,kind ->
     let name : NP = mkNP (mkDet the_Art ord) kind.name in {
       name = name ;
       at = SyntaxCat.mkAdv kind.at name ;
       to = SyntaxCat.mkAdv kind.to name ;
    };


   placeNPAdj : Ord -> CNPlace -> NPPlace = \ord,kind ->
     let name : NP = mkNP the_Art (mkCN kind.name (mkAP ord)) in {
       name = name ;
       at = SyntaxCat.mkAdv kind.at name ;
       to = SyntaxCat.mkAdv kind.to name ;
     };
}
