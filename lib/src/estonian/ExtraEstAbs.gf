--# -coding=latin1
abstract ExtraEstAbs = Extra [
  GenNP,
  VPI,ListVPI,BaseVPI,ConsVPI,MkVPI,ComplVPIVV,ConjVPI,
  VPS,ListVPS,BaseVPS,ConsVPS,ConjVPS,MkVPS,PredVPS,ConjVPS,Tense,Temp,Pol,S,
  VV,VP,Conj,NP,Quant,IAdv,IComp,ICompAP,IAdvAdv,Adv,AP, Pron, ProDrop] ** {

  fun
    GenCN : NP -> CN -> CN ;              -- auton merkki

    AdvExistNP : Adv -> NP -> Cl ;        -- kuvassa olemme me
    AdvPredNP  : Adv -> V  -> NP -> Cl ;  -- kuvassa hymyilee Veikko

    ICompExistNP : IComp -> NP -> QCl ;     -- missä/kuka on Veikko
    IAdvPredNP : IAdv -> V -> NP -> QCl ;   -- mistä alkaa Ruotsi

    RelExistNP : Prep -> RP -> NP -> RCl ; -- jossa on jazzia

--    i_implicPron : Pron ;                 -- (minä), minut, ...
    whatPart_IP : IP ;

    PartCN : CN -> NP ;                   -- olutta

    vai_Conj : Conj ;                     -- minä vai sinä? ("or" in question)

    --Short forms of the pronouns
    ma_Pron : Pron ;
    sa_Pron : Pron ;
    ta_Pron : Pron ;
    me_Pron : Pron ;
    te_Pron : Pron ;
    nad_Pron : Pron ;
    
    OmaPoss : Quant ;                     -- Reflexive possessive "oma"
    ProDropPoss : Pron -> Quant ;         -- vaimoni --TODO Is this relevant in Estonian? Is the agreement of pronoun ever needed, or is it the same as oma?

  cat
    ClPlus ;      -- clause with more variation
    ClPlusObj ;   -- which has a focusable object
    ClPlusAdv ;   -- which has a focusable adverb
    Part ;        -- discourse particle

  fun
    S_SVO  : Part -> Temp -> Pol -> ClPlus     -> S ;  -- mepäs juomme maitoa nyt
    S_OSV  : Part -> Temp -> Pol -> ClPlusObj  -> S ;  -- maitoapas me juomme nyt
    S_VSO  : Part -> Temp -> Pol -> ClPlus     -> S ;  -- juommepas me maitoa nyt
    S_ASV  : Part -> Temp -> Pol -> ClPlusAdv  -> S ;  -- nytpäs me juomme maitoa

--    S_SOV  : Part -> Temp -> Pol -> ClPlus  -> S ;  -- mepäs maitoa juomme
    S_OVS  : Part -> Temp -> Pol -> ClPlus  -> S ;  -- maitoapas juomme me
--    S_VOS  : Part -> Temp -> Pol -> ClPlus  -> S ;  -- juommepas maitoa me


    PredClPlus        : NP -> VP            -> ClPlus ;      -- me nukumme
    PredClPlusFocSubj : NP -> VP            -> ClPlus ;      -- mekin nukumme
    PredClPlusFocVerb : NP -> VP            -> ClPlus ;      -- me nukummekin
    PredClPlusObj     : NP -> VPSlash -> NP -> ClPlusObj ;   -- maitoa me juomme
    PredClPlusFocObj  : NP -> VPSlash -> NP -> ClPlusObj ;   -- maitoakin me juomme
    PredClPlusAdv     : NP -> VP -> Adv     -> ClPlusAdv ;   -- nyt me nukumme
    PredClPlusFocAdv  : NP -> VP -> Adv     -> ClPlusAdv ;   -- nytkin me nukumme

    ClPlusWithObj : ClPlusObj -> ClPlus ;   -- to make non-fronted obj focusable
    ClPlusWithAdv : ClPlusAdv -> ClPlus ;   -- to make non-fronted adv focusable

    noPart, han_Part, pa_Part, pas_Part, ko_Part, kos_Part, 
      kohan_Part, pahan_Part : Part ; 

}
