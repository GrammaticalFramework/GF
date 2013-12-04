-- AR 4/12/2013 from http://spraakbanken.gu.se/swe/resurs/konstruktikon/utvecklingsversion

abstract Konstruktikon = Lang ** {


fun
  reflexiv_resultativVP        : V -> AP -> VP ;      -- jag dricker mig smal
  indirekt_kausativ_bortVP     : V -> NP -> VP ;      -- jag äter bort min huvudverk 
  verba_pa_fortsVP             : V -> VP ;            -- jag jobbar på
  adjektiv_som_nom_abstraktNP  : A -> NP ;            -- det materiella       --- should be AP but case is not available in AFormPos
  adjektiv_som_nom_anaforiskNP : NPAgr -> A -> NP ;   -- den blåa ; det röda  ---- should be AP
  adjektiv_som_nom_folkNP      : A -> NP ;            -- den gamla            ---- should be AP
--  samordningXP               : Conj -> [XP] -> XP ; -- mjölk, havregryn och gröt  -- exists as ConjXP for XP = NP, AP, VP, S, Adv, CN
--  disj_sam_korrXP            : [XP] -> XP ;         -- varken gas, vätska eller fast material  -- special case of Conj

--  ellips_samordningXP  ---- TODO     : 
  -- en klänning med skärp och en 0 utan 0
  -- en röd 0 och en grön stol
  -- Alf sitter i soffan och Barbro 0 i stolen
  -- humrarna var beställda och borden 0 dukade
  -- hon började gilla Simon och han 0 henne                                 
  
-- ellips_komplementXP ---- TODO
  -- det är förbjudet att både köpa 0 och sälja droger

-- ellips_fragmentXP ---- TODO
  -- han somnade om, men bara en halvtimma

-- snarare_hellre_an_samordnXO ---- TODO
  -- förvara plånboken i framfickan hellre än bakfickan

--  exocentrisk_adj_smnN : N -> A ; -- tjockbottnad  ---- should perhaps be an oper

-- jämförelseAP 
   -- lika bra som  -- CAdvAP
   -- bättre än     -- ComparA

-- jämförelse_likhet
   -- inte ... så bra som
   -- lika mycket som

-- jämförelse_olikhet
   -- högre än


  saa_gradAP  : AP  -> S -> AP ;   -- så allvarligt skadad att han inte kan höras av polis
  saa_gradAdv : Adv -> S -> Adv ;  -- så mycket att jag till slut sa upp skiten

-- grad_mod_attribut
-- superlativ

  unikhetQuant : Quant ;  -- den enda (varelse)









-- auxiliaries
cat
  NPAgr ;   -- needed in adjektiv_som_nom.anaforiskNP
  NPGender ; 
fun
  UtrNPGender, NeutrNPGender : NPGender ;
  MkNPAgr : NPGender -> Num -> NPAgr ;

  DetNPGender : NPGender -> Det -> NP ; -- a generalization of DetNP



}
