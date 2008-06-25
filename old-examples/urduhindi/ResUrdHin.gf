--# -path=.:../abstract:../common:../../prelude 
resource ResUrdHin = open Prelude, UrduHindiAbs in { 
		flags coding=utf8 ; optimize=all; 

-- param and oper definitions in this file for Morphology

  param Number = Sg | Pl ;
  param Case = Nom | Obl | Voc ;
  param Gender = Masc | Fem ;
  param Person = Pers1 | Pers2_Casual | Pers2_Familiar |
                 Pers2_Respect | Pers3_Near | Pers3_Distant ;
  param Degree = Posit | Comp | Super ;
  param ProperNounForm = PNF Case ;
  param NounForm = NF Number Case ;
  param DemPronForm = 	DPF Number Case ;
  param PersPronForm = PPF Number Person Case ;
  param RefPronForm = RefPF ;
  param InterrPronForm = IntPF Number Case ;
  param InterrPronForm1 = IntPF1 ;
  param InterrPronForm2 = IntPF2 Number Case Gender ;
  param InterrPronForm3 = IntPF3 Number Gender ;
  param IndefPronForm = IPF Case Gender ;
  param IndefPronForm1 = IPF1 Case ;
  param IndefPronForm2 = IPF2 ;
  param RelPronForm = RPF Number Case ;
  param RelPronForm1 = RPF1 Number Gender ;
  param RelPronForm2 = RPF2 Case ;
  param RelPronForm3 = RPF3 ;
  param NumeralForm = NumeralF;
  param AdjForm = AdjF Number Case Gender ;
  param AdjForm1 = AdjF1 ;
  param AdjDegForm = AdjDegF Degree ;
  param PossivePostPForm = PossPostPF Number Gender ;
  param Tense = Subj | Perf | Imperf ;
  param Tense_Aux = Past | Present | Future | Subjunctive | Perfective | Imperfective;		
  param Verb_AuxForm = VA Tense_Aux Person Number Gender |
                       VA_Root | VA_Inf | VA_Inf_Fem | VA_Inf_Obl;
  param VerbForm = VF Tense Person Number Gender | Inf | Root | Inf_Obl | Inf_Fem ;
  param VerbForm1 = VF1 Tense Person Number Gender | Caus1 Tense Person Number Gender |
                    Caus2 Tense Person Number Gender | Inf1 | Caus1_Inf | Caus2_Inf |
                    Inf_Fem1 | Inf_Obl1 | Caus1_Inf_Obl | Caus2_Inf_Obl	| Root1 | 
                    Caus1_Root | Caus2_Root ;
  param VerbForm2 = VF2 Tense Person Number Gender | VCaus1 Tense Person Number Gender |
                    Inf2 | VCaus1_Inf | Inf_Obl2 | Inf_Fem2 | VCaus1_Inf_Obl |
                    Root2 | VCaus1_Root  ;
  param VerbForm3 = VF3 Tense Person Number Gender | VCaus2 Tense Person Number Gender |
                    Inf3 | Inf_Fem3 | VCaus2_Inf | Inf_Obl3 | VCaus2_Inf_Obl | Root3 | 
                    VCaus2_Root ;
  param PossPronForm = PossF Number Person Gender ;

{-
  oper mkPron2NP : PersPron -> NP = 
      \pp ->
        { s = \\c => pp.s ! PPF Sg Pers1 c ; n = Sg ; p = Pers1 ; g = Masc }; 
-}
       


} ;
