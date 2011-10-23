concrete AbsToAPIapi of AbsToAPI = {

lincat 
A, A2, A2V, AV, AS, AP, AdA, AdN, AdV, Adv, Ant, Art, CAdv, CN, Card, Cl, ClSlash, Comp, Conj, Det, Dig, Digit, Digits, IAdv, IComp, IDet, IP, IQuant, Imp, Interj, ListAP, ListAdv, ListCN, ListIAdv, ListNP, ListRS, ListS, N, N2, N3, NP, Num, Numeral, Ord, PConj, PN, Phr, Pol, Predet, Prep, Pron, QCl, QS, QVP, Quant, RCl, RP, RS, S, SC, SSlash, Subj, Temp, Tense, Text, Utt, V, V0, V2, V2A, V2Q, V2S, V2V, V3, VA, VP, VPSlash, VQ, VS, VV, Voc, Punct, String , QuantSg , QuantPl , ImpForm = {ind : Str; attr : Str} ;

lin
     
 mkText1 = mkTernaryCat "mkText" ;  
 mkText2 = mkBinaryCat "mkText" ; 
 mkText3 = mkBinaryCat "mkText" ;        
 mkText4 = mkUnaryCat "mkText" ;
 mkText5 = mkUnaryCat "mkText" ;
 mkText6 = mkUnaryCat "mkText" ;  
 mkText7 = mkUnaryCat "mkText" ; 
 mkText8 = mkUnaryCat "mkText" ;      
 mkText9 = mkBinaryCat "mkText" ; 
 mkText10 = mkUnaryCat "mkText" ;

 emptyText = mkSimpCat "emptyText";


 fullStopPunct = mkSimpCat "fullStopPunct" ;      
 questMarkPunct = mkSimpCat "questMarkPunct" ;
 exclMarkPunct = mkSimpCat "exclMarkPunct" ;

 mkPhr1 = mkTernaryCat "mkPhr" ;
 mkPhr2 = mkBinaryCat "mkPhr" ; 
 mkPhr3 = mkBinaryCat "mkPhr" ;
 mkPhr4 = mkUnaryCat "mkPhr" ;
 mkPhr5 = mkUnaryCat "mkPhr" ;  
 mkPhr6 = mkUnaryCat "mkPhr" ; 
 mkPhr7 = mkUnaryCat "mkPhr" ;  
 mkPhr8 = mkUnaryCat "mkPhr" ; 

 mkPConj = mkUnaryCat "mkPConj" ; 
 noPConj = mkSimpCat "noPConj" ;

 mkVoc = mkUnaryCat "mkVoc" ;
 noVoc = mkSimpCat "noVoc" ;

 mkUtt1 = mkUnaryCat "mkUtt" ;
 mkUtt2 = mkUnaryCat "mkUtt" ;  
 mkUtt3 = mkUnaryCat "mkUtt" ; 
 mkUtt4 = mkUnaryCat "mkUtt" ;  
 mkUtt5 = mkTernaryCat "mkUtt" ; 
 mkUtt6 = mkBinaryCat "mkUtt" ; 
 mkUtt7 = mkBinaryCat "mkUtt" ;
 mkUtt8 = mkUnaryCat "mkUtt" ;
 mkUtt9 = mkUnaryCat "mkUtt" ; 
 mkUtt10 = mkUnaryCat "mkUtt" ; 
 mkUtt11 = mkUnaryCat "mkUtt" ;
 mkUtt12 = mkUnaryCat "mkUtt" ;     
 mkUtt13 = mkUnaryCat "mkUtt" ; 
 mkUtt14 = mkUnaryCat "mkUtt" ; 
 mkUtt15 = mkUnaryCat "mkUtt" ;     
 mkUtt16 = mkUnaryCat "mkUtt" ;   

 lets_Utt = mkUnaryCat "lets_Utt" ; 

 positivePol = mkSimpCat "positivePol" ; 
 negativePol = mkSimpCat "negativePol" ;

 simultaneousAnt = mkSimpCat "simultaneousAnt" ; 
 anteriorAnt = mkSimpCat "anteriorAnt" ;

 presentTense = mkSimpCat "presentTense" ;
 pastTense = mkSimpCat "pastTense" ;
 futureTense = mkSimpCat "futureTense" ; 
 conditionalTense = mkSimpCat "conditionalTense" ; 

 mkTemp = mkBinaryCat "mkTemp" ;

 singularImpForm = mkSimpCat "singularImpForm" ; 
 pluralImpForm = mkSimpCat "pluralImpForm" ; 
 politeImpForm = mkSimpCat "politeImpForm" ;  

 mkS1 = mkUnaryCat "mkS" ;    
 mkS2 = mkBinaryCat "mkS" ; 
 mkS3 = mkBinaryCat "mkS" ;  
 mkS4 = mkBinaryCat "mkS" ;    
 mkS5 = mkTernaryCat "mkS" ;
 mkS6 = mkTernaryCat "mkS" ;
 mkS7 = mkTernaryCat "mkS" ;  
 mkS8 = mkQuaternaryCat "mkS" ;
 mkS9 = mkTernaryCat "mkS" ;
 mkS10 = mkTernaryCat "mkS" ;
 mkS11 = mkBinaryCat "mkS" ;
 mkS12 = mkBinaryCat "mkS" ;

 mkCl1 = mkBinaryCat "mkCl" ;   
 mkCl2 = mkTernaryCat "mkCl" ; 
 mkCl3 = mkQuaternaryCat "mkCl" ;   
 mkCl4 = mkTernaryCat "mkCl" ; 
 mkCl5 = mkTernaryCat "mkCl" ; 
 mkCl6 = mkTernaryCat "mkCl" ;
 mkCl7 = mkTernaryCat "mkCl" ; 
 mkCl8 = mkTernaryCat "mkCl" ; 
 mkCl9 = mkQuaternaryCat "mkCl" ; 
 mkCl10 = mkQuaternaryCat "mkCl" ;
 mkCl11 = mkQuaternaryCat "mkCl" ; 
 mkCl12 = mkQuaternaryCat "mkCl" ; 
 mkCl13 = mkQuaternaryCat "mkCl" ; 
 mkCl14 = mkBinaryCat "mkCl" ;
 mkCl15 = mkTernaryCat "mkCl" ; 
 mkCl16 = mkTernaryCat "mkCl" ; 
 mkCl17 = mkBinaryCat "mkCl" ; 
 mkCl18 = mkBinaryCat "mkCl" ;  
 mkCl19 = mkBinaryCat "mkCl" ;
 mkCl20 = mkBinaryCat "mkCl" ;   
 mkCl21 = mkBinaryCat "mkCl" ;
 mkCl22 = mkBinaryCat "mkCl" ;
 mkCl23 = mkUnaryCat "mkCl" ;
 mkCl24 = mkUnaryCat "mkCl" ; 
 mkCl25 = mkUnaryCat "mkCl" ;
 mkCl26 = mkBinaryCat "mkCl" ; 
 mkCl27 = mkBinaryCat "mkCl" ;
 mkCl28 = mkUnaryCat "mkCl" ;
 mkCl29 = mkUnaryCat "mkCl" ;
 mkCl30 = mkBinaryCat "mkCl" ;

 genericCl = mkUnaryCat "genericCl" ;

 mkVP1 = mkUnaryCat "mkVP" ;
 mkVP2 = mkBinaryCat "mkVP" ;
 mkVP3 = mkTernaryCat "mkVP" ; 
 mkVP4 = mkBinaryCat "mkVP" ;
 mkVP5 = mkBinaryCat "mkVP" ; 
 mkVP6 = mkBinaryCat "mkVP" ;
 mkVP7 = mkBinaryCat "mkVP" ; 
 mkVP8 = mkTernaryCat "mkVP" ; 
 mkVP9 = mkTernaryCat "mkVP" ; 
 mkVP10 = mkTernaryCat "mkVP" ; 
 mkVP11 = mkTernaryCat "mkVP" ;
 mkVP12 = mkUnaryCat "mkVP" ;
 mkVP13 = mkBinaryCat "mkVP" ;
 mkVP14 = mkBinaryCat "mkVP" ; 
 mkVP15 = mkUnaryCat "mkVP" ; 
 mkVP16 = mkUnaryCat "mkVP" ; 
 mkVP17 = mkUnaryCat "mkVP" ; 
 mkVP18 = mkUnaryCat "mkVP" ; 
 mkVP19 = mkUnaryCat "mkVP" ;
 mkVP20 = mkBinaryCat "mkVP" ; 
 mkVP21 = mkBinaryCat "mkVP" ;
 mkVP22 = mkBinaryCat "mkVP" ;
 mkVP23 = mkUnaryCat "mkVP" ;     
 mkVP24 = mkUnaryCat "mkVP" ; 

 reflexiveVP1 = mkUnaryCat "reflexiveVP" ; 
 reflexiveVP2 = mkUnaryCat "reflexiveVP" ;

 passiveVP1 = mkUnaryCat "passiveVP" ; 
 passiveVP2 = mkBinaryCat "passiveVP" ;

 progressiveVP = mkUnaryCat "progressiveVP" ;

 mkComp1 = mkUnaryCat "mkComp" ;
 mkComp2 = mkUnaryCat "mkComp" ;
 mkComp3 = mkUnaryCat "mkComp" ;

 mkSC1 = mkUnaryCat "mkSC" ;
 mkSC2 = mkUnaryCat "mkSC" ;
 mkSC3 = mkUnaryCat "mkSC" ;

 mkImp1 = mkUnaryCat "mkImp" ;
 mkImp2 = mkUnaryCat "mkImp" ;
 mkImp3 = mkBinaryCat "mkImp" ;

 mkNP1 = mkBinaryCat "mkNP" ;
 mkNP2 = mkBinaryCat "mkNP" ;  
 mkNP3 = mkTernaryCat "mkNP" ;
 mkNP4 = mkQuaternaryCat "mkNP" ;
 mkNP5 = mkTernaryCat "mkNP" ;  
 mkNP6 = mkBinaryCat "mkNP" ;    
 mkNP7 = mkBinaryCat "mkNP" ;      
 mkNP8 = mkBinaryCat "mkNP" ;      
 mkNP9 = mkBinaryCat "mkNP" ;      
 mkNP10 = mkBinaryCat "mkNP" ;    
 mkNP11 = mkBinaryCat "mkNP" ;    
 mkNP12 = mkBinaryCat "mkNP" ;   
 mkNP13 = mkBinaryCat "mkNP" ;    
 mkNP14 = mkBinaryCat "mkNP" ;   
 mkNP15 = mkBinaryCat "mkNP" ;   
 mkNP16 = mkBinaryCat "mkNP" ;
 mkNP17 = mkBinaryCat "mkNP" ;
 mkNP18 = mkUnaryCat "mkNP" ;           
 mkNP19 = mkUnaryCat "mkNP" ;        
 mkNP20 = mkUnaryCat "mkNP" ;     
 mkNP21 = mkBinaryCat "mkNP" ;  
 mkNP22 = mkUnaryCat "mkNP" ;            
 mkNP23 = mkUnaryCat "mkNP" ; 
 mkNP24 = mkUnaryCat "mkNP" ;  
 mkNP25 = mkBinaryCat "mkNP" ; 
 mkNP26 = mkBinaryCat "mkNP" ;    
 mkNP27 = mkBinaryCat "mkNP" ;   
 mkNP28 = mkBinaryCat "mkNP" ;     
 mkNP29 = mkTernaryCat "mkNP" ;
 mkNP30 = mkBinaryCat "mkNP" ;
 mkNP31 = mkBinaryCat "mkNP" ;
 mkNP32 = mkBinaryCat "mkNP" ;

 i_NP = mkSimpCat "i_NP" ;         
 you_NP = mkSimpCat "you_NP" ;     
 youPol_NP = mkSimpCat "youPol_NP" ; 
 he_NP = mkSimpCat "he_NP" ;      
 she_NP = mkSimpCat "she_NP" ;     
 it_NP = mkSimpCat "it_NP" ;      
 we_NP = mkSimpCat "we_NP" ;       
 youPl_NP = mkSimpCat "youPl_NP" ; 
 they_NP = mkSimpCat "they_NP" ; 
 this_NP = mkSimpCat "this_NP" ; 
 that_NP = mkSimpCat "that_NP" ; 
 these_NP = mkSimpCat "these_NP" ; 
 those_NP = mkSimpCat "those_NP" ;

 mkDet1 = mkUnaryCat "mkDet" ;      
 mkDet2 = mkBinaryCat "mkDet" ;   
 mkDet3 = mkBinaryCat "mkDet" ;    
 mkDet4 = mkTernaryCat "mkDet" ;  
 mkDet5 = mkBinaryCat "mkDet" ; 
 mkDet6 = mkUnaryCat "mkDet" ;    
 mkDet7 = mkUnaryCat "mkDet" ;    
 mkDet8 = mkUnaryCat "mkDet" ;   
 mkDet9 = mkUnaryCat "mkDet" ;     
 mkDet10 = mkBinaryCat "mkDet" ; 

 the_Det = mkSimpCat "the_Det" ;
 a_Det = mkSimpCat "a_Det" ;
 theSg_Det = mkSimpCat "theSg_Det" ; 
 thePl_Det = mkSimpCat "thePl_Det" ; 
 aSg_Det = mkSimpCat "aSg_Det" ;
 aPl_Det = mkSimpCat "aPl_Det" ;
 this_Det = mkSimpCat "this_Det" ;
 that_Det = mkSimpCat "that_Det" ;
 these_Det = mkSimpCat "these_Det" ; 
 those_Det = mkSimpCat "those_Det" ; 

 mkQuant = mkUnaryCat "mkQuant" ;  

 the_Quant = mkSimpCat "the_Quant" ; 
 a_Quant = mkSimpCat "a_Quant" ;  

 --mkNum1 = mkUnaryCat "mkNum" ;  
 mkNum2 = mkUnaryCat "mkNum" ;  
 mkNum3 = mkUnaryCat "mkNum" ;  
 mkNum4 = mkUnaryCat "mkNum" ; 
 mkNum5 = mkUnaryCat "mkNum" ; 
 mkNum6 = mkBinaryCat "mkNum" ; 

 singularNum = mkSimpCat "singularNum" ;           
 pluralNum = mkSimpCat "pluralNum" ;               

 --mkCard1 = mkUnaryCat "mkCard" ;   
 mkCard2 = mkUnaryCat "mkCard" ;  
 mkCard3 = mkUnaryCat "mkCard" ;    
 mkCard4 = mkBinaryCat "mkCard" ; 

 mkOrd1 = mkUnaryCat "mkOrd" ;  
 mkOrd2 = mkUnaryCat "mkOrd" ;    
 mkOrd3 = mkUnaryCat "mkOrd" ;      
 mkOrd4 = mkUnaryCat "mkOrd" ;          

 mkAdN = mkUnaryCat "mkAdN" ; 

 mkCN1 = mkUnaryCat "mkCN" ;         
 mkCN2 = mkBinaryCat "mkCN" ; 
 mkCN3 = mkTernaryCat "mkCN" ;   
 mkCN4 = mkUnaryCat "mkCN" ;          
 mkCN5 = mkUnaryCat "mkCN" ;          
 mkCN6 = mkBinaryCat "mkCN" ;
 mkCN7 = mkBinaryCat "mkCN" ; 
 mkCN8 = mkBinaryCat "mkCN" ; 
 mkCN9 = mkBinaryCat "mkCN" ; 
 mkCN10 = mkBinaryCat "mkCN" ; 
 mkCN11 = mkBinaryCat "mkCN" ;  
 mkCN12 = mkBinaryCat "mkCN" ;   
 mkCN13 = mkBinaryCat "mkCN" ;  
 mkCN14 = mkBinaryCat "mkCN" ;
 mkCN15 = mkBinaryCat "mkCN" ; 
 mkCN16 = mkBinaryCat "mkCN" ;  
 mkCN17 = mkBinaryCat "mkCN" ; 
 mkCN18 = mkBinaryCat "mkCN" ; 
 mkCN19 = mkBinaryCat "mkCN" ; 
 mkCN20 = mkBinaryCat "mkCN" ;  
 mkCN21 = mkBinaryCat "mkCN" ; 

 mkAP1 = mkUnaryCat "mkAP" ;         
 mkAP2 = mkBinaryCat "mkAP" ;
 mkAP3 = mkBinaryCat "mkAP" ;
 mkAP4 = mkUnaryCat "mkAP" ;       
 mkAP5 = mkBinaryCat "mkAP" ; 
 mkAP6 = mkBinaryCat "mkAP" ; 
 mkAP7 = mkBinaryCat "mkAP" ; 
 mkAP8 = mkBinaryCat "mkAP" ;
 mkAP9 = mkBinaryCat "mkAP" ;
 mkAP10 = mkBinaryCat "mkAP" ; 
 mkAP11 = mkTernaryCat "mkAP" ; 
 mkAP12 = mkBinaryCat "mkAP" ;  
 mkAP13 = mkUnaryCat "mkAP" ;            
 mkAP14 = mkTernaryCat "mkAP" ;  

 reflAP = mkUnaryCat "reflAP" ;           
 comparAP = mkUnaryCat "comparAP" ;         

 mkAdv1 = mkUnaryCat "mkAdv" ;          
 mkAdv2 = mkBinaryCat "mkAdv" ;
 mkAdv3 = mkBinaryCat "mkAdv" ;  
 mkAdv4 = mkTernaryCat "mkAdv" ;  
 mkAdv5 = mkTernaryCat "mkAdv" ;    
 mkAdv6 = mkBinaryCat "mkAdv" ;       
 mkAdv7 = mkTernaryCat "mkAdv" ; 
 mkAdv8 = mkBinaryCat "mkAdv" ;   

 mkQS1 = mkUnaryCat "mkQS" ; 
 mkQS2 = mkBinaryCat "mkQS" ;  
 mkQS3 = mkBinaryCat "mkQS" ; 
 mkQS4 = mkBinaryCat "mkQS" ; 
 mkQS5 = mkTernaryCat "mkQS" ;
 mkQS6 = mkTernaryCat "mkQS" ; 
 mkQS7 = mkTernaryCat "mkQS" ; 
 mkQS8 = mkQuaternaryCat "mkQS" ; 
 mkQS9 = mkUnaryCat "mkQS" ;                   

 mkQCl1 = mkUnaryCat "mkQCl" ;  
 mkQCl2 = mkBinaryCat "mkQCl" ;  
 mkQCl3 = mkBinaryCat "mkQCl" ;    
 mkQCl4 = mkTernaryCat "mkQCl" ;   
 mkQCl5 = mkQuaternaryCat "mkQCl" ;   
 mkQCl6 = mkTernaryCat "mkQCl" ;       
 mkQCl7 = mkTernaryCat "mkQCl" ;      
 mkQCl8 = mkTernaryCat "mkQCl" ;   
 mkQCl9 = mkTernaryCat "mkQCl" ;   
 mkQCl10 = mkTernaryCat "mkQCl" ; 
 mkQCl11 = mkQuaternaryCat "mkQCl" ; 
 mkQCl12 = mkQuaternaryCat "mkQCl" ;
 mkQCl13 = mkQuaternaryCat "mkQCl" ;  
 mkQCl14 = mkQuaternaryCat "mkQCl" ; 
 mkQCl15 = mkQuaternaryCat "mkQCl" ;
 mkQCl16 = mkBinaryCat "mkQCl" ;    
 mkQCl17 = mkTernaryCat "mkQCl" ; 
 mkQCl18 = mkTernaryCat "mkQCl" ;
 mkQCl19 = mkBinaryCat "mkQCl" ;   
 mkQCl20 = mkBinaryCat "mkQCl" ;   
 mkQCl21 = mkBinaryCat "mkQCl" ;   
 mkQCl22 = mkBinaryCat "mkQCl" ;   
 mkQCl23 = mkBinaryCat "mkQCl" ;  
 mkQCl24 = mkTernaryCat "mkQCl" ;   
 mkQCl25 = mkBinaryCat "mkQCl" ; 
 mkQCl26 = mkBinaryCat "mkQCl" ; 
 mkQCl27 = mkTernaryCat "mkQCl" ;  
 mkQCl28 = mkBinaryCat "mkQCl" ;  
 mkQCl29 = mkBinaryCat "mkQCl" ; 
 mkQCl30 = mkUnaryCat "mkQCl" ;       

 mkIComp1 = mkUnaryCat "mkIComp" ; 
 mkIComp2 = mkUnaryCat "mkIComp" ;  

 mkIP1 = mkBinaryCat "mkIP" ;  
 mkIP2 = mkBinaryCat "mkIP" ;    
 mkIP3 = mkUnaryCat "mkIP" ;   
 mkIP4 = mkBinaryCat "mkIP" ;  
 mkIP5 = mkTernaryCat "mkIP" ; 
 mkIP6 = mkBinaryCat "mkIP" ;     
 mkIP7 = mkBinaryCat "mkIP" ;       

 what_IP = mkSimpCat "what_IP" ; 
 who_IP = mkSimpCat "who_IP" ; 

 mkIAdv1 = mkBinaryCat "mkIAdv" ; 
 mkIAdv2 = mkBinaryCat "mkIAdv" ; 

 mkIDet1 = mkBinaryCat "mkIDet" ; 
 mkIDet2 = mkUnaryCat "mkIDet" ;      

 which_IDet = mkSimpCat "which_IDet" ;
 whichSg_IDet = mkSimpCat "whichSg_IDet" ;  
 whichPl_IDet = mkSimpCat "whichPl_IDet" ;

 mkRS1 = mkUnaryCat "mkRS" ;
 mkRS2 = mkBinaryCat "mkRS" ; 
 mkRS3 = mkBinaryCat "mkRS" ; 
 mkRS4 = mkBinaryCat "mkRS" ; 
 mkRS5 = mkTernaryCat "mkRS" ; 
 mkRS6 = mkTernaryCat "mkRS" ;
 mkRS7 = mkTernaryCat "mkRS" ;
 mkRS8 = mkQuaternaryCat "mkRS" ; 
 mkRS9 = mkTernaryCat "mkRS" ;
 mkRS10 = mkTernaryCat "mkRS" ; 
 mkRS11 = mkBinaryCat "mkRS" ;

 mkRCl1 = mkBinaryCat "mkRCl" ;      
 mkRCl2 = mkBinaryCat "mkRCl" ;        
 mkRCl3 = mkTernaryCat "mkRCl" ;   
 mkRCl4 = mkQuaternaryCat "mkRCl" ;   
 mkRCl5 = mkTernaryCat "mkRCl" ;       
 mkRCl6 = mkTernaryCat "mkRCl" ;       
 mkRCl7 = mkTernaryCat "mkRCl" ;    
 mkRCl8 = mkTernaryCat "mkRCl" ;    
 mkRCl9 = mkTernaryCat "mkRCl" ;  
 mkRCl10 = mkQuaternaryCat "mkRCl" ; 
 mkRCl11 = mkQuaternaryCat "mkRCl" ; 
 mkRCl12 = mkQuaternaryCat "mkRCl" ; 
 mkRCl13 = mkQuaternaryCat "mkRCl" ; 
 mkRCl14 = mkQuaternaryCat "mkRCl" ; 
 mkRCl15 = mkBinaryCat "mkRCl" ;    
 mkRCl16 = mkTernaryCat "mkRCl" ;
 mkRCl17 = mkTernaryCat "mkRCl" ;
 mkRCl18 = mkBinaryCat "mkRCl" ;    
 mkRCl19 = mkBinaryCat "mkRCl" ;   
 mkRCl20 = mkBinaryCat "mkRCl" ;   
 mkRCl21 = mkBinaryCat "mkRCl" ;    
 mkRCl22 = mkBinaryCat "mkRCl" ;  
 mkRCl23 = mkTernaryCat "mkRCl" ;     
 mkRCl24 = mkBinaryCat "mkRCl" ;        
 mkRCl25 = mkUnaryCat "mkRCl" ;            

 which_RP = mkSimpCat "which_RP" ;                  

 mkRP = mkTernaryCat "mkRP" ;  

 mkSSlash = mkTernaryCat "mkSSlash" ;  

 mkClSlash1 = mkBinaryCat "mkClSlash" ;       
 mkClSlash2 = mkBinaryCat "mkClSlash" ;       
 mkClSlash3 = mkTernaryCat "mkClSlash" ;  
 mkClSlash4 = mkBinaryCat "mkClSlash" ;     
 mkClSlash5 = mkBinaryCat "mkClSlash" ;  
 mkClSlash6 = mkTernaryCat "mkClSlash" ; 

 mkVPSlash1 = mkUnaryCat "mkClSlash" ;       
 mkVPSlash2 = mkBinaryCat "mkClSlash" ;  
 mkVPSlash3 = mkBinaryCat "mkClSlash" ; 
 mkVPSlash4 = mkBinaryCat "mkClSlash" ;
 mkVPSlash5 = mkBinaryCat "mkClSlash" ;  
 mkVPSlash6 = mkBinaryCat "mkClSlash" ; 
 mkVPSlash7 = mkBinaryCat "mkClSlash" ; 
 mkVPSlash8 = mkTernaryCat "mkVPSlash" ; 

 mkListS1 = mkBinaryCat "mkListS" ;
 mkListS2 = mkBinaryCat "mkListS" ;  

 mkListAdv1 = mkBinaryCat "mkListAdv" ; 
 mkListAdv2 = mkBinaryCat "mkListAdv" ; 

 mkListAP1 = mkBinaryCat "mkListAP" ;
 mkListAP2 = mkBinaryCat "mkListAP" ;  

 mkListNP1 = mkBinaryCat "mkListNP" ; 
 mkListNP2 = mkBinaryCat "mkListNP" ; 

 mkListRS1 = mkBinaryCat "mkListRS" ; 
 mkListRS2 = mkBinaryCat "mkListRS" ; 
 

 the_Art = mkSimpCat "the_Art" ;      
 a_Art = mkSimpCat "a_Art" ;  
 sgNum = mkSimpCat "sgNum" ;  
 plNum = mkSimpCat "plNum" ;  




{-
  DetSg : Quant -> Ord -> Det = \q -> DetQuantOrd q NumSg ; 
  DetPl : Quant -> Num -> Ord -> Det = DetQuantOrd ; 
  ComplV2 : V2 -> NP -> VP = \v,np -> ComplSlash (SlashV2a v) np ;
  ComplV2A : V2A -> NP -> AP -> VP = \v,np,ap -> ComplSlash (SlashV2A v ap) np ; 
  ComplV3 : V3 -> NP -> NP -> VP = \v,o,d -> ComplSlash (Slash3V3 v d) o ; 
-}


oper mkSimpCat : Str-> {ind : Str ; attr : Str} = \s -> {ind = s; attr = s};

oper mkUnaryCat : Str -> {ind : Str ; attr : Str} -> {ind : Str ; attr : Str} = \s, o1 -> 
                                                                                                      {ind = s ++ o1.attr ; 
                                                                                                       attr = "(" ++ s ++ o1.attr ++ ")"};

oper mkBinaryCat : Str -> {ind : Str; attr : Str} -> {ind : Str; attr : Str} -> {ind : Str ; attr : Str} = \s, o1, o2 -> 
                                                                                                      {ind = s ++ o1.attr ++ o2.attr; 
                                                                                                       attr = "(" ++ s ++ o1.attr ++ o2.attr ++ ")"};

oper mkTernaryCat : Str -> {ind : Str; attr : Str} -> {ind : Str; attr : Str} -> {ind : Str; attr: Str} -> {ind : Str ; attr : Str} = \s, o1, o2, o3 -> 
                                                                                                     {ind = s ++ o1.attr ++ o2.attr ++ o3.attr;
                                                                                                      attr = "(" ++ s ++ o1.attr ++ o2.attr ++ o3.attr ++")"};


oper mkQuaternaryCat : Str -> {ind : Str; attr : Str} -> {ind : Str; attr : Str} -> {ind : Str; attr : Str} -> {ind : Str; attr: Str} -> {ind : Str ; attr : Str} = \s, o1, o2, o3, o4 -> 
                                                                                                     {ind = s ++ o1.attr ++ o2.attr ++ o3.attr ++ o4.attr;
                                                                                                      attr = "(" ++ s ++ o1.attr ++ o2.attr ++ o3.attr ++o4.attr++ ")"};

-----------------------------
lin 

testNoun_1 = mkSimpCat "noun_1" ;
testNoun_2 = mkSimpCat "noun_2" ;
testNoun_3 = mkSimpCat "noun_3" ;
testNoun_4 = mkSimpCat "noun_4" ;
testNoun_5 = mkSimpCat "noun_5" ;
testA_1 = mkSimpCat "adj_1" ;
testA_2 = mkSimpCat "adj_2" ;
testA_3 = mkSimpCat "adj_3" ;
testA_4 = mkSimpCat "adj_4" ;
testA_5 = mkSimpCat "adj_5" ;
testV_1 = mkSimpCat "verb_1" ;
testV_2 = mkSimpCat "verb_2" ;
testV_3 = mkSimpCat "verb_3" ;
testV_4 = mkSimpCat "verb_4" ;
testV_5 = mkSimpCat "verb_5" ;
testV2_1 = mkSimpCat "verb2_1" ;
testV2_2 = mkSimpCat "verb2_2" ;
testV2_3 = mkSimpCat "verb2_3" ;
testV2_4 = mkSimpCat "verb2_4" ;
testV2_5 = mkSimpCat "verb2_5" ;
testAdv_1 = mkSimpCat "adv_1" ;
testAdv_2 = mkSimpCat "adv_2" ;
testAdv_3 = mkSimpCat "adv_3" ;
testAdv_4 = mkSimpCat "adv_4" ;
testAdv_5 = mkSimpCat "adv_5" ;


}
