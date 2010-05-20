concrete SentencesSpa of Sentences = NumeralSpa ** SentencesI - [
  IFemale, YouFamFemale, YouPolFemale, IMale, YouFamMale, YouPolMale,
  WherePlace, WherePerson, ABePlace,
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