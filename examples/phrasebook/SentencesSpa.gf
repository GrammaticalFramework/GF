concrete SentencesSpa of Sentences = NumeralSpa ** SentencesI - [
  IsMass,
  IFemale, YouFamFemale, YouPolFemale, IMale, YouFamMale, YouPolMale,
  WeMale, WeFemale, YouPlurFamMale, YouPlurFamFemale, YouPlurPolFemale, YouPlurPolMale, TheyMale, TheyFemale, 
  WherePlace, WherePerson, ABePlace,
  PImperativeFamNeg, PImperativePlurNeg, --negative imperatives in subjunctive
  Superlative
 ] 
  with 
    (Syntax = SyntaxSpa), 
    (Symbolic = SymbolicSpa), 
    (Lexicon = LexiconSpa) ** 
  open ParadigmsSpa, BeschSpa, SyntaxSpa, ExtraSpa, Prelude in {

flags coding = utf8 ;

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

      --IL 2012-10-12
      --Negative imperative is done with subjunctive.
      --PImperativePolNeg is fine in RGL, but fam and plur are wrong
      --A special ImpNeg in ExtraSpa is defined for that
      PImperativeFamNeg  v = phrasePlease (ImpNeg (mkNP (ProDrop youSg_Pron)) v) ; 
      PImperativePlurNeg v = phrasePlease (ImpNeg (mkNP (ProDrop youPl_Pron)) v) ;
    
      ABePlace p place = mkCl p.name (mkVP (mkVP estar) place.at) ;

      WherePlace place = mkQS (mkQCl where_IAdv (mkCl place.name estar) ) ;

      WherePerson person = mkQS (mkQCl where_IAdv (mkCl person.name estar) ) ;

oper

  estar = mkV (estar_2 "estar") ;

  CNPlace : Type = {name : CN ; at : Prep ; to : Prep }  ;

  mkCNPlace : CN -> Prep -> Prep -> CNPlace = \p,i,t -> {
    name = p ;
    at = i ;
    to = t ;
    } ;

  OrdSuperlative : Type = {ord: Ord ; isPre: Bool} ;

  placeNPSuperl : OrdSuperlative -> CNPlace -> NPPlace  = \sup,kind -> case sup.isPre of {
    True  => placeNPDet sup.ord kind ;
    False  => placeNPAdj sup.ord kind 
    } ;

  -- "el mejor aeropuerto"
  placeNPDet : Ord -> CNPlace -> NPPlace = \ord,kind ->
    let name : NP = mkNP (mkDet the_Art ord) kind.name in {
      name = name ;
      at = SyntaxSpa.mkAdv kind.at name ;
      to = SyntaxSpa.mkAdv kind.to name ;
   };

  -- "el aeropuerto más grande"
  placeNPAdj : Ord -> CNPlace -> NPPlace = \ord,kind ->
    let name : NP = mkNP the_Art (mkCN kind.name (mkAP ord)) in {
      name = name ;
      at = SyntaxSpa.mkAdv kind.at name ;
      to = SyntaxSpa.mkAdv kind.to name ;
    };
}
