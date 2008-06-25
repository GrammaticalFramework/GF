--include test.Abs.gf;
  include ../test.Abs.gf;

cat Text ;

fun 
  onePhraseText : Phr -> Text ;
  combine: Text -> Text -> Text ;
  ex1, ex2, ex3, ex4, ex5, ex6, ex7, ex8, ex9, ex10, ex11, 
    ex12, ex13, ex14, ex15, ex16, ex17, ex18, ex19: Text ;
  russian : Adj1 ;
  parkedNear : Adj2 ;

def 
  ex1 = onePhraseText (IndicPhrase (PredVP HeNP (PosVS Say (PredVP ThouNP (AdvVP (PosV Run ) Well))))) ;

  ex2 = onePhraseText (IndicPhrase (PredVP SheNP (NegTV Send (DefOneNP (ModAdj (ConjAP OrConj (ConsAP
          (TwoAP (PositAdjP Big ) (PositAdjP Small ) ) (ConjDAP EitherOr
          (TwoAP (PositAdjP Old ) (PositAdjP Young ) ) ) ) ) (UseN Car)))))) ;

  ex3 = onePhraseText (IndicPhrase (SubjS IfSubj (PredVP (UsePN John ) (AdvVP (NegV Walk ) Always ))                              (PredVP
          WeNP (AdvVP (PosTV SwitchOn (IndefOneNP (UseN Light ) ))
          (LocNP (DetNP EveryDet (ModAdj (PositAdjP Old ) (UseN House ))))))));

  ex4 = onePhraseText (IndicPhrase (ConjDS EitherOr (TwoS (PredVP TheyNP (PosA (ComparAdjP Young YeNP ))) 
          (PredVP INP (PosCN (AppFun Mother (SuperlNP Big (UseN Man ))))))));

  ex5 = onePhraseText (IndicPhrase (PredVP (ModGenMany YeNP (AdvCN (UseFun
          Mother ) Always ) ) (PosVS Prove (PredVP YeNP (PosA (PositAdjP
          Small) ) ) ) ) );

  ex6 = onePhraseText (IndicPhrase (PredVP (IndefManyNP (ModRC (UseN Man ) ( RelSuch ( PredVP (ModGenMany
          TheyNP(UseFun Uncle ) ) (PosTV Love(ConjDNP NeitherNor (TwoNP
          (DefManyNP (UseN Car )) (DefManyNP (UseN House ) ) ))) ) ) ) )
          (NegA (PositAdjP Old )))) ;

  ex7 =  onePhraseText (QuestPhrase (SubjQu WhenSubj (PredVP (IndefOneNP
           (ModRC (UseN Man ) (RelVP IdRP (NegV Run ))))(PosV Walk ))
           (IntVP WhoOne (PosV Run ) ) ) ) ;

  ex8 =  onePhraseText (IndicPhrase (ConjS AndConj (ConsS (TwoS
           (PredVP (DefOneNP (UseN Car)) (NegA (PositAdjP Big )))
           (PredVP (DefOneNP (UseN House)) (PosA (PositAdjP Small ))))
           (PredVP SheNP (PosA (PositAdjP Old)) )))) ; 
  
  ex9 = onePhraseText (ImperMany (SubjImper WhenSubj (PredVP YeNP
          (PosA (PositAdjP Young ) ) ) (ImperVP (PosV Walk) ) ) ); 

  ex10 = onePhraseText (QuestPhrase (IntSlash (FunIP Uncle (NounIPMany
           (UseN Woman ) ) ) (PosSlashTV INP Wait ) ) ) ;

  ex11 = onePhraseText (QuestPhrase (QuestAdv WhyIAdv TheyNP (PosTV
           Love (UsePN Mary ) ) ) ) ;

  ex12 = onePhraseText (QuestPhrase (QuestVP WeNP (PosCN (UseN Man ) ) ) );

  ex13 = combine (combine (onePhraseText PhrYes ) (onePhraseText
           (PhrNP (DetNP MostDet (UseN Car ) ) ) ) ) (combine
           (onePhraseText (PhrManyCN (ModAdj (PositAdjP Old ) (UseN House 
           ) ) ) ) (onePhraseText (PhrIAdv HowIAdv ) ) ) ;

  ex14 = onePhraseText (IndicPhrase (PredVP SheNP (PosNP (IndefOneNP (ModRC
         (UseN Woman) (RelSlash(FunRP Mother IdRP)(PosSlashTV HeNP Wait)))))));

  ex15 = onePhraseText (IndicPhrase (PredVP (ConjNP OrConj (ConsNP (TwoNP
           (UsePN Mary ) (UsePN John ) ) (ConjDNP EitherOr (TwoNP YouNP INP
           ) ) ) ) (PosA (PositAdjP Young ) ) ) );

  ex16 = onePhraseText (IndicPhrase (PredVP INP (PosTV Love (ConjNP AndConj
           (TwoNP (IndefManyNP (ModAdj (PositAdjP Old ) (UseN House )))
           (IndefManyNP (ModAdj (PositAdjP Young) (UseN Woman ) ))))))) ;

  ex18 = combine ex1 (combine ex2 (combine ex3 (combine ex4 (combine ex5 
           (combine ex6 (combine ex7 (combine ex8 (combine ex9 (combine ex10 
           (combine ex11 (combine ex12  (combine ex14 (combine ex15 
           ( combine ex16 ex13)))))))))))))) ;

  ex17 = onePhraseText (PhrManyCN (ModAdj (ComplAdj parkedNear (DefOneNP
           (ModAdj (AdjP1 russian ) (UseN House ) ) ) )(UseN  Car ) ) ) ;

  ex19 = combine ex1 (combine ex2 (combine ex3 (combine ex4 (combine ex5 
           (combine ex6 (combine ex7 (combine ex8 (combine ex9 (combine ex10 
           (combine ex11 (combine ex12  (combine ex14 (combine ex15 
           ( combine ex16 (combine ex17 ex13))))))))))))))) ;


