
concrete SentencesRon of Sentences = NumeralRon ** SentencesI - [
  IFemale, YouFamFemale, YouPolFemale, IMale, YouFamMale, YouPolMale,
  ThePlace, Nationality, CitiNat, Citizenship, ACitizen, PCitizenship, PropCit
] 
  with 
    (Syntax = SyntaxRon), 
    (Symbolic = SymbolicRon), 
    (Lexicon = LexiconRon) ** 
  open SyntaxRon, ExtraRon in {

oper 
  NPNationalityRon : Type = {lang : NP ; country : NP ; propObj : A; propPers : A};
  CitizenshipRon : Type = {pers : A; prop : A};


  mkNPNationalityRon : NP -> NP -> A -> A -> NPNationalityRon = \la,co,pro, prp ->
        {lang = la ; 
         country = co ;
         propObj = pro ;
         propPers = prp
        } ;
 
   mkCitizenshipRon : A -> A -> CitizenshipRon = \aobj, apers -> {pers = apers; prop = aobj};


lincat 
   Nationality = NPNationalityRon ;
   Citizenship = CitizenshipRon ;   

lin 
 IFemale = {name = mkNP i8fem_Pron ; isPron = True ; poss = mkQuant i_Pron} ; 
 YouFamFemale = {name = mkNP youSg8fem_Pron ; isPron = True ; poss = mkQuant youSg_Pron} ; 
 YouPolFemale = {name = mkNP youPol8fem_Pron ; isPron = True ; poss = mkQuant youPol_Pron};
 IMale = {name = mkNP i_Pron ; isPron = True ; poss = mkQuant i_Pron} ; 
 YouFamMale = {name = mkNP youSg_Pron ; isPron = True ; poss = mkQuant youSg_Pron} ; 
 YouPolMale = {name = mkNP youPol_Pron ; isPron = True ; poss = mkQuant youPol_Pron} ;
 ThePlace kind = let name : NP = mkNP the_Quant kind.name in {
         name = name ;
         at = if_then_else Adv kind.at.needIndef (mkAdv kind.at name) (mkAdv kind.at (mkNP kind.name));
         to = if_then_else Adv kind.at.needIndef (mkAdv kind.to name) (mkAdv kind.at (mkNP kind.name))
       } ;
CitiNat n = {pers = n.propPers; prop = n.propObj} ;
ACitizen p n = mkCl p.name n.pers ;
PCitizenship x =  mkPhrase (mkUtt (mkAP x.prop)) ;
PropCit p = p.prop ;
}


