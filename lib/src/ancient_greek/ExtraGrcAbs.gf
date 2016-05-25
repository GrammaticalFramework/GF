--# -path=.:../abstract:../common:../prelude

abstract ExtraGrcAbs = Extra, Numeral[Sub1000000] ** {

  cat
    DemPron ;

    CNRefl ; -- CN with reflexive attribute or object
    NPRefl ; -- NP depending on another NPs agreement: reflexive object, reflexive possessive
                -- herself ; her own CN ; many CN of her own CN
                -- o emayths adelfos = her own brother
                -- o tautys adelfos     = her brother
    APRefl ;  -- AP depending on Agr
    PartP ;  -- Participle phrase, AP depending on VTmp (or aspect), Polarity, Agr
  
--  fun 
--    UsePart : VTmp -> Pol -> PartP -> APRefl ;
--    PartTmpVP : VP -> PartP ;
--    PartAPRefl : VP -> APRefl ;

  fun 
    NumDl : Num ;

    DetCNpost : Det -> CN -> NP ;  -- o anvropos o agavos + RelS

    -- Construct NPs depending on another NPs agreement features:
    DetCNRefl : Det -> CNRefl -> NPRefl ;
    AdvNPRefl : NPRefl -> Adv -> NPRefl ;
    RelNPRefl : NPRefl -> RS -> NPRefl ;
    ComplN2Refl : N2 -> NP -> CNRefl ;
    PossNPRefl : CNRefl -> NPRefl -> CNRefl ;
    PossCNRefl : Pron -> CNRefl -> CNRefl ;    -- (o) emos filos
    ComplSlashRefl : VPSlash -> NPRefl -> VP ;  -- to V2 (one's own CN)

    -- Participles exist in the main tenses only, leaving the temporal relation to the matrix
    -- verb undetermined. Roughly, the aspect of the main tense determines the relation (BR 220):
    -- PartPres = TSimul, PartAor = TAnter, PartPerf = TSimul, PartFut = inverse TAnter

    -- PartVP = PartPresVP : VP -> AP  of Extra.gf is implemented here using a default Agr (bad)
    PartPresVP : Pol -> VP -> AP ;  -- for adjectival usage
    PartAorVP : Pol -> VP -> AP ;
    PartPerfVP : Pol -> VP -> AP ;
    PartFutVP : Pol -> VP -> AP ;

    -- NP + active participle in main tense (adverbial usage with NP as implicit subject)
    PartPresNP : NP -> Pol -> VP -> NP ;  
    PartAorNP : NP -> Pol -> VP -> NP ;
    PartPerfNP : NP -> Pol -> VP -> NP ;
    PartFutNP : NP -> Pol -> VP -> NP ;
    -- TODO: NP + medium or passive participle

    SlashV2VNPRefl : V2V -> NPRefl -> VPSlash -> VPSlash ;

    -- Additional pronouns are needed since ReflPron agrees with the subject in gender.
    iFem_Pron, youSgFem_Pron, weFem_Pron, youPlFem_Pron, theyFem_Pron, theyNeutr_Pron : Pron ;

    -- Additional NP-constructions:

--    UsePronEmph : Pron -> NP ;     -- emphasized personal pronoun
--    UsePronUnEmph : Pron -> NP ;   -- unemphasized personal pronoun

    -- DefArtAPNP : AP -> NP ;

    InfPres : VP -> NP ;
    InfAor  : VP -> NP ;
    InfPerf : VP -> NP ;

    ApposPN : PN -> CN -> NP ;     -- Pyvagoras o filosofos 
    ApposPron : Pron -> CN -> NP ; -- hmeis oi strathgoi

    PossCN : Pron -> CN -> CN ;    -- (o) emos filos
    ReflCN : CN -> CNRefl ;            -- (ton) emautoy filon,  one's own CN

    PartCN : PartP -> CN -> CN ;   -- BR 241 (but dont: DefArt + PartP + CN)

    DemNumPre:  DemPron -> Num -> CN -> NP ;  -- BR 68 5  oytos o anvrwpos
    DemNumPost: DemPron -> Num -> CN -> NP ;  -- BR 68 5  o anvrwpos ekeinos
 
    ACP : V2 -> NP -> Pol -> VP -> VP ;  -- accusative cum participle
   -- For AcI, NcI, Agr = Ag Gender Number Person also needs Case, BR 257
      
    -- Additional VP-constructions:
    ReciVP : VPSlash -> VP ;
    MedVP : V2 -> VP ;
    MedV2 : V2 -> V2 ;

    -- Additional AP-constructions:
    so8big_AP : AP ;                      -- positive forms { s : AForm => Str } only
    such_AP : AP ;
  
    -- Additional Pronouns:
    this_Pron, that_Pron, yonder_Pron : DemPron ;
    tosoytos_Pron, toioytos_Pron : DemPron ;   -- BR 68 6 better toioytos_A : A

    -- Additional adverbs:

    immediately_Adv : Adv ;
    near_Adv : Adv ;
    hardly_Adv : Adv ;
    enough_Adv : Adv ;
    for8free_Adv : Adv ;
    in8vain_Adv : Adv ;
    too8much_Adv : Adv ;

    nowhere_Adv : Adv ;
    together_Adv : Adv ;

    elsewhere_Adv : Adv ;
    elsewhere_to_Adv : Adv ;
    elsewhere_from_Adv : Adv ; 
    same_there_Adv : Adv ;
    same_there_to_Adv : Adv ;
    same_there_from_Adv : Adv ;
    samePlace_Adv : Adv ;
    samePlace_from_Adv : Adv ;
    samePlace_to_Adv : Adv ;
    home_Adv : Adv ;
    home_from_Adv : Adv ;
    home_to_Adv : Adv ;
    outside_Adv : Adv ;
    outside_from_Adv : Adv ;
    outside_to_Adv : Adv ;
    ground_at_Adv : Adv ;
    ground_from_Adv : Adv ;
    ground_to_Adv : Adv ;

    how8often_IAdv : IAdv ;
    one8times_Adv : Adv ;
    two8times_Adv : Adv ;
    three8times_Adv : Adv ;
    four8times_Adv : Adv ;
    five8times_Adv : Adv ;
    six8times_Adv : Adv ;
    seven8times_Adv : Adv ;
    eight8times_Adv : Adv ;
    nine8times_Adv : Adv ;
    ten8times_Adv : Adv ;

    initially_Adv : Adv ;
    somehow_Adv : Adv ;

-- Numerals: 

    -- BR 73.4: numeral adjectives  a(ploy~s, diploy~s  one-fold, two-fold, ...
    -- numeral nouns: h( mona's, deka's, chilia's, myria's  
    unit_N2 : N2 ;
    ten_N2 : N2 ;
    hundred_N2 : N2 ; 
    thousand_N2 : N2 ;
    tenthousand_N2 : N2 ;

  cat
    Sub10000 ;     -- 1..9999

  data
    pot4 : Sub10000 -> Sub1000000 ;                 -- m * 10000
    pot4plus : Sub10000 -> Sub10000 -> Sub1000000 ; -- m * 10000 + n

-- Conjunctions: 

  in_order_to_Subj : Subj ;
}
