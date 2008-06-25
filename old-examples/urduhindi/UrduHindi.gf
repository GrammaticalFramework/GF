--# -path=.:../abstract:../common:../../prelude
concrete UrduHindi of UrduHindiAbs = open ResUrdHin, Prelude in { 
	flags coding=utf8 ; optimize=all; 

lincat
    N = {s : NounForm => Str; h1: Gender} ;
    PN = {s : ProperNounForm => Str; h1: Gender} ;
    Adj = {s : AdjForm => Str} ;
    Adj1 = {s : AdjForm1 => Str} ;
    AdjD = {s : AdjDegForm => Str} ;
    Verb_Aux = {s : Verb_AuxForm => Str} ;
    Verb = {s : VerbForm => Str} ;
    Verb1 = {s : VerbForm1 => Str} ;
    Verb2 = {s : VerbForm2 => Str} ;
    Verb3 = {s : VerbForm3 => Str} ;
    RelPron3 = {s : RelPronForm3 => Str} ;
    RelPron2 = {s : RelPronForm2 => Str} ;
    RelPron1 = {s : RelPronForm1 => Str} ;
    RelPron = {s : RelPronForm => Str} ;
    IndefPron2 = {s : IndefPronForm2 => Str} ;
    IndefPron1 = {s : IndefPronForm1 => Str} ;
    IndefPron = {s : IndefPronForm => Str} ;
    InterPron3 = {s : InterrPronForm3 => Str} ;
    InterPron2 = {s : InterrPronForm2 => Str} ;
    InterPron1 = {s : InterrPronForm1 => Str} ;
    InterPron = {s : InterrPronForm => Str} ;
    RefPron = {s : RefPronForm => Str} ;
    PersPron = {s : PersPronForm => Str} ;
    PossPron = {s : PossPronForm => Str} ;
    DemPron = {s : DemPronForm => Str; h1 : Person} ;
    PossPostPos = {s : PossivePostPForm => Str} ;
    Num = { s : NumeralForm => Str ; h1 : Number };
    Adv, Conj, Neg, Quest, Intjunc, PostP, Part = SS ; 

    NP = {s : Case => Str ; n : Number ; p : Person ; g : Gender } ;
    CN = {s : Number => Case  => Str ; g : Gender} ;
    VP = {s : Tense_Aux => Person => Number => Gender=> Str} ;
    S = {s: Str};

lin 
    --VP
    --UseV : Verb_Aux -> VP;
    UseV va = { s = \\t,p,n,g => va.s ! VA t p n g  };
    

    --UseVVAux : Verb -> Verb_Aux -> VP;
    UseVVAux v va = 
      { s = \\t,p,n,g => v.s ! Inf ++ va.s ! VA t p n g
      };


    --UseN x = x;
    UseN x =
        { s = \\n,c => x.s ! NF n c ; 
          g = x.h1 
       } ;

    DetN_Pers1 pron cn =
        { s = \\n,c => pron.s ! PossF n Pers1 cn.g ++ cn.s ! n ! c ; 
          g = cn.g 
       } ;
    DetN_Pers2Casual pron cn =
        { s = \\n,c => pron.s ! PossF n Pers2_Casual cn.g ++ cn.s ! n ! c ; 
          g = cn.g 
       } ;
    DetN_Pers2Familiar pron cn =
        { s = \\n,c => pron.s ! PossF n Pers2_Familiar cn.g ++ cn.s ! n ! c ; 
          g = cn.g 
       } ;
    DetN_Pers2Respect pron cn =
        { s = \\n,c => pron.s ! PossF n Pers2_Respect cn.g ++ cn.s ! n ! c ; 
          g = cn.g 
       } ;
    DetN_Pers3Near pron cn =
        { s = \\n,c => pron.s ! PossF n Pers3_Near cn.g ++ cn.s ! n ! c ; 
          g = cn.g 
       } ;
    DetN_Pers3Distant pron cn =
        { s = \\n,c => pron.s ! PossF n Pers3_Distant cn.g ++ cn.s ! n ! c ; 
          g = cn.g 
       } ;


    --DetCN3 		: CN -> NP;
    DetCN3Sg cn = 
	{ s = \\c => case c of {  
               Nom => cn.s ! Sg ! Nom ;
               Obl => cn.s ! Sg ! Obl ;
               Voc => []
             };
	  n = Sg;
	  p = Pers3_Near ; --does not mean any thing
          g = cn.g 
	} ;
    DetCN3Pl cn = 
	{ s = \\c => case c of {  
               Nom => cn.s ! Pl ! Nom ;
               Obl => cn.s ! Pl ! Obl ;
               Voc => []
             };
	  n = Pl ;
	  p = Pers3_Near ; --does not mean any thing
          g = cn.g 
	} ;

    DetCN num cn = 
	{ s = \\c => case c of {  
               Nom => num.s ! NumeralF ++ cn.s ! num.h1 ! Nom ;
               Obl => num.s ! NumeralF ++ cn.s ! num.h1 ! Obl ;
               Voc => []
             };
	  n = num.h1;
	  p = Pers3_Near ;
          g = cn.g 
	} ;

    DetCN1Sg wo cn = 
        { s = \\c => case c of {
               Nom => wo.s ! DPF Sg Nom ++ cn.s ! Sg ! Nom ;
               Obl => [] ; 
               Voc => []
                  
             };
	  n = Sg;
	  p = wo.h1 ;
          g = cn.g 
	} ;

    DetCN1Pl wo cn = 
        { s = \\c => case c of {
               Nom => wo.s ! DPF Pl Nom ++ cn.s ! Pl ! Nom ;
               Obl => [] ; 
               Voc => []
             };
	  n = Pl;
	  p = wo.h1 ;
          g = cn.g 
	} ;
    -- wh ayk ktab
    DetCN2 wo num cn = 
         { s = \\c => case c of {  
               Nom => wo.s ! DPF num.h1 Nom ++ num.s ! NumeralF ++ cn.s ! num.h1 ! Nom ;
               Obl => wo.s ! DPF num.h1 Obl ++ num.s ! NumeralF ++ cn.s ! num.h1 ! Obl ;
               Voc => []
             };
	  n = num.h1;
	  p = wo.h1 ;
          g = cn.g 
	} ;
    
    UsePN pn = 
          { s = \\c => pn.s ! PNF c ;
            n = Sg ;
            p = Pers3_Near ; --could be Pers3_distant, does not really matter
            g = pn.h1
          } ; 
    UsePN1 wo pn = 
          { s = \\c => wo.s ! DPF Sg Nom ++ pn.s ! PNF c ;
            n = Sg ;
            p = wo.h1 ; 
            g = pn.h1
          } ;    


--UsePron : PersPron -> NP
    UsePronSgP1M pp =
       { s = \\c => pp.s ! PPF Sg Pers1 c ; n = Sg ; p = Pers1 ; g = Masc };
    UsePronSgP1F pp = 
       { s = \\c => pp.s ! PPF Sg Pers1 c ; n = Sg ; p = Pers1 ; g = Fem };
    UsePronPlP1M pp = 
       { s = \\c => pp.s ! PPF Pl Pers1 c ; n = Pl ; p = Pers1 ; g = Masc };
    UsePronPlP1F pp = 
       { s = \\c => pp.s ! PPF Pl Pers1 c ; n = Pl ; p = Pers1 ; g = Fem };
    UsePronSgP2CM pp = 
       { s = \\c => pp.s ! PPF Sg Pers2_Casual c ; n = Sg ; p = Pers2_Casual ; g = Masc };
    UsePronSgP2CF pp = 
       { s = \\c => pp.s ! PPF Sg Pers2_Casual c ; n = Sg ; p = Pers2_Casual ; g = Fem };
    UsePronPlP2CM pp = 
       { s = \\c => pp.s ! PPF Pl Pers2_Casual c ; n = Pl ; p = Pers2_Casual ; g = Masc };
    UsePronPlP2CF pp = 
       { s = \\c => pp.s ! PPF Pl Pers2_Casual c ; n = Pl ; p = Pers2_Casual ; g = Fem };
    UsePronSgP2FM pp = 
       { s = \\c => pp.s ! PPF Sg Pers2_Familiar c ; n = Sg ; p = Pers2_Familiar ; g = Masc };
    UsePronSgP2FF pp = 
       { s = \\c => pp.s ! PPF Sg Pers2_Familiar c ; n = Sg ; p = Pers2_Familiar ; g = Fem };
    UsePronPlP2FM pp = 
       { s = \\c => pp.s ! PPF Pl Pers2_Familiar c ; n = Pl ; p = Pers2_Familiar ; g = Masc };
    UsePronPlP2FF pp = 
       { s = \\c => pp.s ! PPF Pl Pers2_Familiar c ; n = Pl ; p = Pers2_Familiar ; g = Fem };
    UsePronSgP2RM pp = 
       { s = \\c => pp.s ! PPF Sg Pers2_Respect c ; n = Sg ; p = Pers2_Respect ; g = Masc };
    UsePronSgP2RF pp = 
       { s = \\c => pp.s ! PPF Sg Pers2_Respect c ; n = Sg ; p = Pers2_Respect ; g = Fem };
    UsePronPlP2RM pp = 
       { s = \\c => pp.s ! PPF Pl Pers2_Respect c ; n = Pl ; p = Pers2_Respect ; g = Masc };
    UsePronPlP2RF pp = 
       { s = \\c => pp.s ! PPF Pl Pers2_Respect c ; n = Pl ; p = Pers2_Respect ; g = Fem };
    UsePronSgP3NM pp = 
       { s = \\c => pp.s ! PPF Sg Pers3_Near c ; n = Sg ; p = Pers3_Near ; g = Masc };
    UsePronSgP3NF pp = 
       { s = \\c => pp.s ! PPF Sg Pers3_Near c ; n = Sg ; p = Pers3_Near ; g = Fem };
    UsePronPlP3NM pp = 
       { s = \\c => pp.s ! PPF Pl Pers3_Near c ; n = Pl ; p = Pers3_Near ; g = Masc };
    UsePronPlP3NF pp = 
       { s = \\c => pp.s ! PPF Pl Pers3_Near c ; n = Pl ; p = Pers3_Near ; g = Fem };
    UsePronSgP3DM pp = 
       { s = \\c => pp.s ! PPF Sg Pers3_Distant c ; n = Sg ; p = Pers3_Distant ; g = Masc };
    UsePronSgP3DF pp = 
       { s = \\c => pp.s ! PPF Sg Pers3_Distant c ; n = Sg ; p = Pers3_Distant ; g = Fem };
    UsePronPlP3DM pp = 
       { s = \\c => pp.s ! PPF Pl Pers3_Distant c ; n = Pl ; p = Pers3_Distant ; g = Masc };
    UsePronPlP3DF pp = 
       { s = \\c => pp.s ! PPF Pl Pers3_Distant c ; n = Pl ; p = Pers3_Distant ; g = Fem };


    UsePastS np va = { s = np.s ! Nom ++ va.s ! Past ! np.p ! np.n ! np.g } ;   
    UsePresS np va = { s = np.s ! Nom ++ va.s ! Present ! np.p ! np.n ! np.g } ;   
    UseFutS np va = { s = np.s ! Nom ++ va.s ! Future ! np.p ! np.n ! np.g } ;   

    UseNPSg np cn  = {
        s = \\c => np.s ! Obl ++ "کو" ++ cn.s ! Sg ! c ;
        n = Sg;
        p = Pers3_Near ;
        g = cn.g
       };    
    
    UseNPPl np cn = {
        s = \\c => np.s ! Obl ++ "کو" ++ cn.s ! Pl ! c ;
        n = Pl;
        p = Pers3_Near ;
        g = cn.g
       };

    UsePronVVAuxPast np vp = { 
       s = np.s ! Obl ++ "کو" ++ vp.s ! Past ! np.p ! np.n ! np.g
      };
    UsePronVVAuxPres np vp = { 
       s = np.s ! Obl ++ "کو" ++ vp.s ! Present ! np.p ! np.n ! np.g
      };
    UsePronVVAuxFut np vp = { 
       s = np.s ! Obl ++ "کو" ++ vp.s ! Future ! np.p ! np.n ! np.g
      };
    
    UseSPast np vp = { 
       s = np.s ! Nom ++ vp.s ! Past ! np.p ! np.n ! np.g
      };
    
   --Present
    UseSPres np vp = { 
       s = np.s ! Nom ++ vp.s ! Present ! np.p ! np.n ! np.g
      };
    
    --Future
    UseSFut np vp = { 
       s = np.s ! Nom ++ vp.s ! Future ! np.p ! np.n ! np.g
      };
   
   UseS s1 conj s2 = {s = s1.s ++ conj.s ++  s2.s};
}
