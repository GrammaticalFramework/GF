abstract AbsToAPI = {

cat 
A; A2; A2V; AV; AP; AS; AdA; AdN; AdV; Adv; Ant; Art; CAdv; CN; Card; Cl; ClSlash; Comp; Conj; Det; Dig; Digit; Digits; IAdv; IComp; IDet; IP; IQuant; Imp; Interj; ListAP; ListAdv; ListCN; ListIAdv; ListNP; ListRS; ListS; N; N2; N3; NP; Num; Numeral; Ord; PConj; PN; Phr; Pol; Predet; Prep; Pron; QCl; QS; QVP; Quant; RCl; RP; RS; S; SC; SSlash; Subj; Temp; Tense; Text; Utt; V; V0; V2; V2A; V2Q; V2S; V2V; V3; VA; VP; VPSlash; VQ; VS; VV; Voc; Punct; String ; ImpForm ; QuantSg; QuantPl ;

fun
     
 mkText1 : Phr -> Punct -> Text -> Text ;  
 mkText2 : Phr -> Text -> Text ; 
 mkText3 : Phr -> Punct -> Text ;        
 mkText4 : Phr -> Text ;
 mkText5 : Utt ->  Text ;
 mkText6 : S   ->  Text ;  
 mkText7 : Cl  ->  Text ; 
 mkText8 : QS  ->  Text ;      
 mkText9 : Pol -> Imp ->  Text ; 
 mkText10 : Imp ->  Text ;
 emptyText : Text ;

 fullStopPunct  : Punct ;      
 questMarkPunct : Punct ;
 exclMarkPunct  : Punct  ;

 mkPhr1 : PConj -> Utt -> Voc -> Phr ;
 mkPhr2 : Utt -> Voc -> Phr ; 
 mkPhr3 : PConj -> Utt -> Phr ;
 mkPhr4 : Utt -> Phr ;
 mkPhr5 : S -> Phr ;  
 mkPhr6 : Cl -> Phr  ; 
 mkPhr7 : QS -> Phr ;  
 mkPhr8 : Imp -> Phr ; 

 mkPConj : Conj -> PConj ; 
 noPConj : PConj ;

 mkVoc : NP -> Voc ;
 noVoc : Voc ;

 mkUtt1 : S -> Utt ;
 mkUtt2 : Cl -> Utt ;  
 mkUtt3 : QS -> Utt ; 
 mkUtt4 : QCl -> Utt ;  
 mkUtt5 : ImpForm -> Pol -> Imp -> Utt ; 
 mkUtt6 : ImpForm -> Imp -> Utt ; 
 mkUtt7 : Pol -> Imp -> Utt ;
 mkUtt8 : Imp -> Utt ;
 mkUtt9 : IP   -> Utt ; 
 mkUtt10 : IAdv -> Utt ; 
 mkUtt11 : NP   -> Utt ;
 mkUtt12 : Adv  -> Utt ;     
 mkUtt13 : VP   -> Utt ; 
 mkUtt14 : CN   -> Utt ; 
 mkUtt15 : AP   -> Utt ;     
 mkUtt16 : Card -> Utt ;   

 lets_Utt : VP ->  Utt ; 

 positivePol : Pol ; 
 negativePol : Pol ;

 simultaneousAnt : Ant ; 
 anteriorAnt : Ant ;

 presentTense : Tense ;
 pastTense : Tense ;
 futureTense : Tense ; 
 conditionalTense : Tense ; 

 mkTemp : Tense -> Ant -> Temp ;

 singularImpForm : ImpForm ; 
 pluralImpForm : ImpForm ; 
 politeImpForm : ImpForm ;  

mkS1 : Cl  -> S ;    
 mkS2 : Tense -> Cl -> S ; 
 mkS3 : Ant -> Cl -> S ;  
 mkS4 : Pol -> Cl -> S ;    
 mkS5 : Tense -> Ant -> Cl -> S ;
 mkS6 : Tense -> Pol -> Cl -> S ;
 mkS7 : Ant -> Pol -> Cl -> S ;  
 mkS8 : Tense -> Ant -> Pol -> Cl  -> S ;
 mkS9 : Temp -> Pol -> Cl -> S ;
 mkS10 : Conj -> S -> S -> S ;
 mkS11 : Conj -> ListS  -> S ;
 mkS12 : Adv -> S -> S ;

 mkCl1 : NP -> V -> Cl ;   
 mkCl2 : NP -> V2 -> NP -> Cl ; 
 mkCl3 : NP -> V3 -> NP -> NP -> Cl ;   
 mkCl4 : NP  -> VV -> VP -> Cl ; 
 mkCl5 : NP  -> VS -> S  -> Cl ; 
 mkCl6 : NP  -> VQ -> QS -> Cl ;
 mkCl7 : NP  -> VA -> A -> Cl ; 
 mkCl8 : NP  -> VA -> AP -> Cl ; 
 mkCl9 : NP  -> V2A -> NP -> A -> Cl ; 
 mkCl10 : NP  -> V2A -> NP -> AP -> Cl ;
 mkCl11 : NP  -> V2S -> NP -> S -> Cl ; 
 mkCl12 : NP  -> V2Q -> NP -> QS -> Cl ; 
 mkCl13 : NP  -> V2V -> NP -> VP -> Cl ; 
 mkCl14 : NP -> A  -> Cl ;
 mkCl15 : NP -> A -> NP -> Cl ; 
 mkCl16 : NP -> A2 -> NP -> Cl ; 
 mkCl17 : NP -> AP -> Cl ; 
 mkCl18 : NP -> NP -> Cl ;  
 mkCl19 : NP -> N -> Cl ;
 mkCl20 : NP -> CN -> Cl ;   
 mkCl21 : NP -> Adv -> Cl ;
 mkCl22 : NP -> VP -> Cl ;
 mkCl23 : N -> Cl ;
 mkCl24 : CN -> Cl ; 
 mkCl25 : NP -> Cl ;
 mkCl26 : NP  -> RS -> Cl ; 
 mkCl27 : Adv -> S  -> Cl ;
 mkCl28 : V -> Cl ;
 mkCl29 : VP -> Cl ;
 mkCl30 : SC -> VP -> Cl ;

 genericCl : VP ->  Cl ;

 mkVP1 : V   -> VP ;
 mkVP2 : V2  -> NP -> VP ;
 mkVP3 : V3  -> NP -> NP -> VP ; 
 mkVP4 : VV  -> VP -> VP ;
 mkVP5 : VS  -> S  -> VP ; 
 mkVP6 : VQ  -> QS -> VP ;
 mkVP7 : VA  -> AP -> VP ; 
 mkVP8 : V2A -> NP -> AP -> VP ; 
 mkVP9 : V2S -> NP -> S  -> VP ; 
 mkVP10 : V2Q -> NP -> QS -> VP ; 
 mkVP11 : V2V -> NP -> VP -> VP ;
 mkVP12 : A -> VP ;
 mkVP13 : A -> NP -> VP ;
 mkVP14 : A2 -> NP -> VP ; 
 mkVP15 : AP -> VP ; 
 mkVP16 : N -> VP ; 
 mkVP17 : CN -> VP ; 
 mkVP18 : NP -> VP ; 
 mkVP19 : Adv -> VP ;
 mkVP20 : VP -> Adv -> VP ; 
 mkVP21 : AdV -> VP -> VP ;
 mkVP22 : VPSlash -> NP -> VP ;
 mkVP23 : VPSlash -> VP ;     
 mkVP24 : Comp -> VP ; 

 reflexiveVP1 : V2 -> VP ; 
 reflexiveVP2 : VPSlash -> VP ;

 passiveVP1 : V2 -> VP ; 
 passiveVP2 : V2 -> NP -> VP ;

 progressiveVP : VP -> VP ;

 mkComp1 : AP -> Comp ;
 mkComp2 : NP -> Comp ;
 mkComp3 : Adv -> Comp ;

 mkSC1 : S -> SC ;
 mkSC2 : QS -> SC ;
 mkSC3 : VP -> SC ;

 mkImp1 : VP -> Imp ;
 mkImp2 : V  -> Imp ;
 mkImp3 : V2 -> NP -> Imp ;

 mkNP1 : Quant -> N  -> NP ;
 mkNP2 : Quant -> CN -> NP ;  
 mkNP3 : Quant -> Num -> CN -> NP ;
 mkNP4 : Quant -> Num -> Ord -> CN -> NP ;
 mkNP5 : Quant -> Num -> N  -> NP ;  
 mkNP6 : Det -> CN -> NP ;    
 mkNP7 : Det -> N -> NP ;      
 mkNP8 : Numeral -> CN -> NP ;      
 mkNP9 : Numeral -> N -> NP ;      
 mkNP10 : Digits -> CN -> NP ;    
 mkNP11 : Digits -> N -> NP ;    
 mkNP12 : Digit -> CN -> NP ;   
 mkNP13 : Digit -> N -> NP ;    
 mkNP14 : Card -> CN -> NP ;   
 mkNP15 : Card -> N -> NP ;   
 mkNP16 : Pron -> CN -> NP ;
 mkNP17 : Pron -> N  -> NP ;
 mkNP18 : PN -> NP ;           
 mkNP19 : Pron -> NP ;        
 mkNP20 : Quant -> NP ;     
 mkNP21 : Quant -> Num -> NP ;  
 mkNP22 : Det -> NP ;            
 mkNP23 : CN -> NP ; 
 mkNP24 : N -> NP ;  
 mkNP25 : Predet -> NP -> NP ; 
 mkNP26 : NP -> V2  -> NP ;    
 mkNP27 : NP -> Adv -> NP ;   
 mkNP28 : NP -> RS -> NP ;     
 mkNP29 : Conj -> NP -> NP -> NP ;
 mkNP30 : Conj -> ListNP -> NP ;
 mkNP31 : QuantSg -> CN -> NP ;
 mkNP32 : QuantPl -> CN -> NP ;

 i_NP : NP ;         
 you_NP : NP ;     
 youPol_NP : NP ; 
 he_NP : NP ;      
 she_NP : NP ;     
 it_NP : NP ;      
 we_NP : NP ;       
 youPl_NP : NP ; 
 they_NP : NP ; 
 this_NP : NP ; 
 that_NP : NP ; 
 these_NP : NP ; 
those_NP : NP ;

 mkDet1 : Quant ->  Det ;      
 mkDet2 : Quant -> Card -> Det ;   
 mkDet3 : Quant ->  Ord -> Det ;    
 mkDet4 : Quant -> Num -> Ord -> Det ;  
 mkDet5 : Quant -> Num -> Det ; 
 mkDet6 : Card ->  Det ;    
 mkDet7 : Digits -> Det ;    
 mkDet8 : Numeral -> Det ;   
 mkDet9 : Pron -> Det ;     
 mkDet10 : Pron -> Num -> Det ; 

 the_Det   : Det ;
 a_Det     : Det ;
 theSg_Det : Det ; 
 thePl_Det : Det ; 
 aSg_Det   : Det ;
 aPl_Det   : Det ;
 this_Det : Det ;
 that_Det : Det ;
 these_Det : Det ; 
 those_Det : Det ; 

 mkQuant : Pron -> Quant ;  

 the_Quant : Quant ; 
 a_Quant   : Quant ;  

 --mkNum1 : Str -> Num ;  
 mkNum2 : Numeral -> Num ;  
 mkNum3 : Digits -> Num ;  
 mkNum4 : Digit -> Num ; 
 mkNum5 : Card -> Num ; 
 mkNum6 : AdN -> Card -> Num ; 

 singularNum : Num ;           
 pluralNum : Num ;               

 --mkCard1 : Str -> Card ;   
 mkCard2 : Numeral -> Card ;  
 mkCard3 : Digits -> Card ;    
 mkCard4 : AdN -> Card -> Card ; 

 mkOrd1 : Numeral -> Ord ;  
 mkOrd2 : Digits -> Ord ;    
 mkOrd3 : Digit -> Ord ;      
 mkOrd4 : A -> Ord ;          

 mkAdN : CAdv -> AdN ; 

 mkCN1 : N  -> CN ;         
 mkCN2 : N2 -> NP -> CN ; 
 mkCN3 : N3 -> NP -> NP -> CN ;   
 mkCN4 : N2 -> CN ;          
 mkCN5 : N3 -> CN ;          
 mkCN6 :  A ->  N  -> CN ;
 mkCN7 :  A -> CN  -> CN ; 
 mkCN8 : AP ->  N  -> CN ; 
 mkCN9 : AP -> CN  -> CN ; 
 mkCN10 : CN -> AP  -> CN ; 
 mkCN11 :  N -> AP  -> CN ;  
 mkCN12 :  N -> RS  -> CN ;   
 mkCN13 : CN -> RS  -> CN ;  
 mkCN14 :  N -> Adv -> CN ;
 mkCN15 : CN -> Adv -> CN ; 
 mkCN16 : CN -> S   -> CN ;  
 mkCN17 : CN -> QS  -> CN ; 
 mkCN18 : CN -> VP  -> CN ; 
 mkCN19 : CN -> SC  -> CN ; 
 mkCN20 :  N -> NP  -> CN ;  
 mkCN21 : CN -> NP  -> CN ; 

 mkAP1 : A -> AP ;         
 mkAP2 : A -> NP -> AP ;
 mkAP3 : A2 -> NP -> AP ;
 mkAP4 : A2 -> AP ;       
 mkAP5 : AP -> S -> AP ; 
 mkAP6 : AP -> QS -> AP ; 
 mkAP7 : AP -> VP -> AP ; 
 mkAP8 : AP -> SC -> AP ;
 mkAP9 : AdA -> A -> AP ;
 mkAP10 : AdA -> AP -> AP ; 
 mkAP11 : Conj -> AP -> AP -> AP ; 
 mkAP12 : Conj -> ListAP -> AP ;  
 mkAP13 : Ord   -> AP ;            
 mkAP14 : CAdv -> AP -> NP -> AP ;  

 reflAP   : A2 -> AP ;           
 comparAP : A -> AP ;         

 mkAdv1 : A -> Adv ;          
 mkAdv2 : Prep -> NP -> Adv ;
 mkAdv3 : Subj -> S -> Adv ;  
 mkAdv4 : CAdv -> A -> NP -> Adv ;  
 mkAdv5 : CAdv -> A -> S -> Adv ;    
 mkAdv6 : AdA -> Adv -> Adv ;       
 mkAdv7 : Conj -> Adv -> Adv -> Adv ; 
 mkAdv8 : Conj -> ListAdv -> Adv ;   

 mkQS1 : QCl  -> QS ; 
 mkQS2 : Tense -> QCl -> QS ;  
 mkQS3 : Ant -> QCl -> QS ; 
 mkQS4 : Pol -> QCl -> QS ; 
 mkQS5 : Tense -> Ant -> QCl -> QS ;
 mkQS6 : Tense -> Pol -> QCl -> QS ; 
 mkQS7 : Ant -> Pol -> QCl -> QS ; 
 mkQS8 : Tense -> Ant -> Pol -> QCl -> QS ; 
 mkQS9 : Cl -> QS ;                   

 mkQCl1 : Cl -> QCl ;  
 mkQCl2 : IP -> VP -> QCl ;  
 mkQCl3 : IP -> V -> QCl ;    
 mkQCl4 : IP -> V2 -> NP -> QCl ;   
 mkQCl5 : IP -> V3 -> NP -> NP -> QCl ;   
 mkQCl6 : IP  -> VV -> VP -> QCl ;       
 mkQCl7 : IP  -> VS -> S  -> QCl ;      
 mkQCl8 : IP  -> VQ -> QS -> QCl ;   
 mkQCl9 : IP  -> VA -> A -> QCl ;   
 mkQCl10 : IP  -> VA -> AP -> QCl ; 
 mkQCl11 : IP  -> V2A -> NP -> A -> QCl ; 
 mkQCl12 : IP  -> V2A -> NP -> AP -> QCl ;
 mkQCl13 : IP  -> V2S -> NP -> S -> QCl ;  
 mkQCl14 : IP  -> V2Q -> NP -> QS -> QCl ; 
 mkQCl15 : IP  -> V2V -> NP -> VP -> QCl ;
 mkQCl16 : IP -> A  -> QCl ;    
 mkQCl17 : IP -> A -> NP -> QCl ; 
 mkQCl18 : IP -> A2 -> NP -> QCl ;
 mkQCl19 : IP -> AP -> QCl ;   
 mkQCl20 : IP -> NP -> QCl ;   
 mkQCl21 : IP -> N -> QCl ;   
 mkQCl22 : IP -> CN -> QCl ;   
 mkQCl23 : IP -> Adv -> QCl ;  
 mkQCl24 : IP -> NP -> V2 -> QCl ;   
 mkQCl25 : IP -> ClSlash -> QCl ; 
 mkQCl26 : IAdv -> Cl -> QCl ; 
 mkQCl27 : Prep -> IP -> Cl -> QCl ;  
 mkQCl28 : IAdv -> NP -> QCl ;  
 mkQCl29 : IComp -> NP -> QCl ; 
 mkQCl30 : IP -> QCl ;       

 mkIComp1 : IAdv -> IComp ; 
 mkIComp2 : IP -> IComp ;  

 mkIP1 : IDet -> CN -> IP ;  
 mkIP2 : IDet -> N -> IP ;    
 mkIP3 : IDet -> IP ;   
 mkIP4 : IQuant -> CN -> IP ;  
 mkIP5 : IQuant -> Num -> CN -> IP ; 
 mkIP6 : IQuant -> N -> IP ;     
 mkIP7 : IP -> Adv -> IP ;       

 what_IP : IP ; 
 who_IP : IP ; 

 mkIAdv1 : Prep -> IP -> IAdv ; 
 mkIAdv2 : IAdv -> Adv -> IAdv ; 

 mkIDet1 : IQuant -> Num -> IDet ; 
 mkIDet2 : IQuant -> IDet ;      

 which_IDet : IDet ;
 whichSg_IDet : IDet ;  
 whichPl_IDet : IDet ;

 mkRS1 : RCl  -> RS ;
 mkRS2 : Tense -> RCl -> RS ; 
 mkRS3 : Ant -> RCl -> RS ; 
 mkRS4 : Pol -> RCl -> RS ; 
 mkRS5 : Tense -> Ant -> RCl -> RS ; 
 mkRS6 : Tense -> Pol -> RCl -> RS ;
 mkRS7 : Ant -> Pol -> RCl -> RS ;
 mkRS8 : Tense -> Ant -> Pol -> RCl -> RS ; 
 mkRS9 : Temp -> Pol -> RCl -> RS ;
 mkRS10 : Conj -> RS -> RS -> RS ; 
 mkRS11 : Conj -> ListRS -> RS ;

 mkRCl1 : RP -> VP -> RCl ;      
 mkRCl2 : RP -> V -> RCl  ;        
 mkRCl3 : RP -> V2 -> NP -> RCl ;   
 mkRCl4 : RP -> V3 -> NP -> NP -> RCl ;   
 mkRCl5 : RP  -> VV -> VP -> RCl ;       
 mkRCl6 : RP  -> VS -> S  -> RCl ;       
 mkRCl7 : RP  -> VQ -> QS -> RCl ;    
 mkRCl8 : RP  -> VA -> A -> RCl ;    
 mkRCl9 : RP  -> VA -> AP -> RCl ;  
 mkRCl10 : RP  -> V2A -> NP -> A -> RCl ; 
 mkRCl11 : RP  -> V2A -> NP -> AP -> RCl ; 
 mkRCl12 : RP  -> V2S -> NP -> S -> RCl ; 
 mkRCl13 : RP  -> V2Q -> NP -> QS -> RCl ; 
 mkRCl14 : RP  -> V2V -> NP -> VP -> RCl ; 
 mkRCl15 : RP -> A  -> RCl ;    
 mkRCl16 : RP -> A -> NP -> RCl ;
 mkRCl17 : RP -> A2 -> NP -> RCl ;
 mkRCl18 : RP -> AP -> RCl ;    
 mkRCl19 : RP -> NP -> RCl ;   
 mkRCl20 : RP -> N -> RCl ;   
 mkRCl21 : RP -> CN -> RCl ;    
 mkRCl22 : RP -> Adv -> RCl ;  
 mkRCl23 : RP -> NP -> V2 -> RCl ;     
 mkRCl24 : RP -> ClSlash -> RCl ;        
 mkRCl25 : Cl -> RCl ;            

 which_RP : RP ;                  

 mkRP : Prep -> NP -> RP -> RP ;  

 mkSSlash : Temp -> Pol -> ClSlash -> SSlash ;  

 mkClSlash1 : NP -> VPSlash -> ClSlash ;       
 mkClSlash2 : NP -> V2 -> ClSlash ;       
 mkClSlash3 : NP -> VV -> V2 -> ClSlash ;  
 mkClSlash4 : Cl -> Prep -> ClSlash ;     
 mkClSlash5 : ClSlash -> Adv -> ClSlash ;  
 mkClSlash6 : NP -> VS -> SSlash -> ClSlash ; 

 mkVPSlash1 : V2  -> VPSlash ;       
 mkVPSlash2 : V3  -> NP -> VPSlash ;  
 mkVPSlash3 : V2A -> AP -> VPSlash ; 
 mkVPSlash4 : V2Q -> QS -> VPSlash ;
 mkVPSlash5 : V2S -> S  -> VPSlash ;  
 mkVPSlash6 : V2V -> VP -> VPSlash ; 
 mkVPSlash7 : VV  -> VPSlash -> VPSlash ; 
  mkVPSlash8 : V2V -> NP -> VPSlash -> VPSlash ; 

 mkListS1 : S -> S -> ListS ;
 mkListS2 : S -> ListS -> ListS ;  

 mkListAdv1 : Adv -> Adv -> ListAdv ; 
 mkListAdv2 : Adv -> ListAdv -> ListAdv ; 

 mkListAP1 : AP -> AP -> ListAP ;
 mkListAP2 : AP -> ListAP -> ListAP ;  

 mkListNP1 : NP -> NP -> ListNP ; 
 mkListNP2 : NP -> ListNP -> ListNP ; 

 mkListRS1 : RS -> RS -> ListRS ; 
 mkListRS2 : RS -> ListRS -> ListRS ; 
 

 the_Art : Art ;      
 a_Art   : Art ;  
 sgNum : Num ;  
 plNum : Num ;  

{-
  DetSg : Quant -> Ord -> Det = \q -> DetQuantOrd q NumSg ; 
  DetPl : Quant -> Num -> Ord -> Det = DetQuantOrd ; 
  ComplV2 : V2 -> NP -> VP = \v,np -> ComplSlash (SlashV2a v) np ;
  ComplV2A : V2A -> NP -> AP -> VP = \v,np,ap -> ComplSlash (SlashV2A v ap) np ; 
  ComplV3 : V3 -> NP -> NP -> VP = \v,o,d -> ComplSlash (Slash3V3 v d) o ; 
-}

-----------------------------

testNoun_1 : N ;
testNoun_2 : N ;
testNoun_3 : N ;
testNoun_4 : N ;
testNoun_5 : N ;
testA_1 : A ;
testA_2 : A ;
testA_3 : A ;
testA_4 : A ;
testA_5 : A ;
testV_1 : V ;
testV_2 : V ;
testV_3 : V ;
testV_4 : V ;
testV_5 : V ;
testV2_1 : V2 ;
testV2_2 : V2 ;
testV2_3 : V2 ;
testV2_4 : V2 ;
testV2_5 : V2 ;
testAdv_1 : Adv ;
testAdv_2 : Adv ;
testAdv_3 : Adv ;
testAdv_4 : Adv ;
testAdv_5 : Adv ;




}
