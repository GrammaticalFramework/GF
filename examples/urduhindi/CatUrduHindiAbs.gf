abstract CatUrduHindiAbs = {

--cat and fun rules for morphology (FM generated)

cat 
    N;
    PN;
    Adj;
    Adj1;
    AdjD;
    Adv;
    Num;
    Verb_Aux;
    Verb;
    Verb1;
    Verb2;
    Verb3;
    RelPron3;
    RelPron2;
    RelPron1;
    RelPron;
    IndefPron2;
    IndefPron1;
    IndefPron;
    InterPron3;
    InterPron2;
    InterPron1;
    InterPron;
    RefPron;
    PersPron;
    PossPron;
    DemPron;
    Neg;
    Quest;
    Conj;
    Intjunc;
    PossPostPos;
    PostP;
    Part;

-- Categories for Syntax 
    CN; 
    NP;
    VP;
    S;

    

--functions for Syntax

fun 
   UseN : N -> CN ; --ktab
   
   UseNPSg : NP -> CN -> NP;
   UseNPPl : NP -> CN -> NP;

   -- myry ktab(my Book), tyry ktab(your book)
   DetN_Pers1		: PossPron -> CN -> CN ;
   DetN_Pers2Casual	: PossPron -> CN -> CN ;
   DetN_Pers2Familiar	: PossPron -> CN -> CN ;
   DetN_Pers2Respect	: PossPron -> CN -> CN ;
   DetN_Pers3Near	: PossPron -> CN -> CN ;
   DetN_Pers3Distant	: PossPron -> CN -> CN ;

   DetCN 		: Num -> CN -> NP ; --ayk ktab(one book), dw ktabyN(two books)
   
   -- wh ktab(that book), yh ktab(this book), a(i)s ktab, a(o)s ktab
   DetCN1Sg 		: DemPron -> CN -> NP ; 
   
   -- wh ktabyN(those books), yh ktabyN(these books), a(i)n ktabwN, a(o)n ktabwN
   DetCN1Pl 		: DemPron -> CN -> NP ; 
   -- wh ayk ktab(that one book), yh ayk ktab(this one book)
   DetCN2		: DemPron -> Num -> CN -> NP ; 
   DetCN3Sg 		: CN -> NP;
   DetCN3Pl 		: CN -> NP;
   UsePN   		: PN -> NP ;     -- Pakstan
   -- wh pakstan(that Pakistan), yh pakstan(this Pakistan)
   UsePN1		: DemPron -> PN -> NP ; 

--Personal Pronouns
   UsePronSgP1M	: PersPron -> NP ; -- myN, mjh   
   UsePronSgP1F	: PersPron -> NP ; -- myN, mjh 
   UsePronPlP1M : PersPron -> NP ; -- hm,   
   UsePronPlP1F : PersPron -> NP ;
   UsePronSgP2CM: PersPron -> NP ; 
   UsePronSgP2CF: PersPron -> NP ;
   UsePronPlP2CM: PersPron -> NP ;
   UsePronPlP2CF: PersPron -> NP ;
   UsePronSgP2FM: PersPron -> NP ; 
   UsePronSgP2FF: PersPron -> NP ; 
   UsePronPlP2FM: PersPron -> NP ; 
   UsePronPlP2FF: PersPron -> NP ; 
   UsePronSgP2RM: PersPron -> NP ; 
   UsePronSgP2RF: PersPron -> NP ; 
   UsePronPlP2RM: PersPron -> NP ; 
   UsePronPlP2RF: PersPron -> NP ; 
   UsePronSgP3NM: PersPron -> NP ; 
   UsePronSgP3NF: PersPron -> NP ; 
   UsePronPlP3NM: PersPron -> NP ; 
   UsePronPlP3NF: PersPron -> NP ; 
   UsePronSgP3DM: PersPron -> NP ; 
   UsePronSgP3DF: PersPron -> NP ; 
   UsePronPlP3DM: PersPron -> NP ; 
   UsePronPlP3DF: PersPron -> NP ; 


   UseV : Verb_Aux -> VP;
   UseVVAux : Verb -> Verb_Aux -> VP;
   

   UsePastS: NP -> VP -> S ; 
   UsePresS: NP -> VP -> S ; 
   UseFutS: NP -> VP -> S ; 
   
   UsePronVVAuxPast: NP -> VP -> S; -- a(i)s kw lyna tha
   UsePronVVAuxPres: NP -> VP -> S; --a(i)s kw kyna hE

   --fixme for hwN gE forms 
   UsePronVVAuxFut: NP -> VP -> S; --a(i)s kw kyna hwga

   UseSPast: NP -> VP -> S; 
   UseSPres: NP -> VP -> S; 
   UseSFut: NP -> VP -> S; 


   UseS : S -> Conj -> S -> S;
} ;
