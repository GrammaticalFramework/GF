--# -path=./gf:.:swedish:prelude:alltenses:abstract:scandinavian:common
-- Structures special for Swedish. These are not implemented in other
-- Scandinavian languages.

abstract ExtraSweAbs = ExtraScandAbs -[FocAP] ** {

cat ReflNP ; 
    PronAD ; -- relational pronouns which can act like adjectives and
             -- determiners. 'fler'
    PronAQ ; -- relational pronouns which can act like adjectives and
             -- quantifiers. 'sådan'
  

    AdvFoc ; -- foucsing adverbs 'bara'. acts as predeterminers, normal
             -- adverbs or before finite verb
    
    RelVSCl ; 

fun
 
  RelVS : S -> RelVSCl -> S ; -- hon sover, vilket vi vet
  RelSlashVS : Temp -> Pol -> VS -> NP -> RelVSCl ;  -- vilket vi vet

  FocAP : Comp -> NP -> Foc ; 

  DetNP_utr : Det -> NP ; -- den här

  AdvFocVP : AdvFoc -> VP -> VP ; -- (han) bara log
  PredetAdvF : AdvFoc -> Predet ; -- bara (barn), inte ens (katten)


  DetPronAD : PronAD -> Det ;
  QuantPronAQ : PronAQ -> Quant ;
  CompPronAQ : PronAQ -> Comp ;
  CompPronAD : PronAD -> Comp ; 
  ComplVAPronAQ : VA -> PronAQ -> VP ; -- de blev sådana
  ComplVAPronAD : VA -> PronAD -> VP ; -- de blev fler


  CompoundNomN : N -> N -> N ;  -- fot+boll
  CompoundGenN : N -> N -> N ;  -- yrkes+musiker
  CompoundAdjN : A -> N -> N ;  -- vit+vin
 
  it8utr_Pron   : Pron ;
  this8denna_Quant : Quant ;
  
  ReflCN : Num -> CN -> ReflNP ;
  ReflSlash : VPSlash -> ReflNP -> VP ;
  
  
  SupCl  : NP -> VP -> Pol -> S ; -- när jag sovit
  
  
 
  PassV2   : V2 -> VP ;  -- äts 
  PassV2Be : V2 -> VP ;  -- bli äten
  
 
  PPartAP : V2 -> AP ; -- (han är) äten
   

  AdvComp : Comp -> Adv -> Comp ; -- jag är redan här

  dethaer_NP : NP ;
  detdaer_NP : NP ;
  dedaer8utr_NP : NP ;
  dedaer8neut_NP : NP ;
  denhaer_NP : NP ;
  dendaer_NP : NP ;

----------------- Predeterminers,Quantifiers,Determiners

   bara_AdvFoc : AdvFoc ;

  sadana_PronAQ : PronAQ ;
  fler_PronAD : PronAD ;
  -- overgenerating: alla hela katter. should not be ok.
  -- predets should be able to decide definites?
  hela_Predet : Predet ;  --hela horder/hela katten  -- both
  sjaelva_Quant : Quant ; -- själva kungen/själva öronen -- def
  samma_Predet : Predet ; -- samma katter/samma öra 
  varenda_Det : Det ;
  vardera_Det : Det ;
  ena_Det : Det ;
  baegge_Det : Det ;
  baada_Det : Det ;
  varannan_Det : Det ;
  somliga_Det : Det ;
  dylika_Det : Det ;
  oovriga_Det : Det ;
  aatskilliga_Det : Det ;
  samtliga_Det : Det ;

  noll_Det : Det ;


}
