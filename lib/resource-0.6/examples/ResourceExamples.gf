--# -path=.:../abstract:../../prelude

abstract ResourceExamples = TestResource ** {

-- sentence examples to test resource grammar with

fun
 ex1,ex2,ex3,ex4,ex5,ex6,ex7,ex8,ex9,ex10,ex11:Text;
 ex12,ex13,ex14,ex15,ex16,ex17,ex18,ex19,ex20,ex21,ex22: Text;

def
 ex1 = OnePhr (IndicPhrase (PredVP (ModGenNum NoNum (YeNumNP NoNum) 
        (AdvCN (UseFun
        Mother) Always)) (PosVG (PredVS Prove (PredVP (YeNumNP NoNum) (PosVG
        (PredAP (PositAdjP Small))))))));
 ex2 = OnePhr (ImperMany (SubjImper WhenSubj (PredVP (YeNumNP 
       NoNum)(PosVG (PredAP
       (PositAdjP Young)))) (ImperVP (PosVG (PredV Walk)))));

 ex3 = OnePhr (QuestPhrase (QuestAdv WhyIAdv TheyNP (NegVG (PredTV Love 
       (UsePN Mary)))));
 ex4 = OnePhr (QuestPhrase (QuestVP (WeNumNP NoNum) (PosVG (PredNP (IndefNumNP
              NoNum (UseN Man))))));
 ex5 = OnePhr (IndicPhrase (PredVP INP (PosVG (PredTV Love (ConjNP AndConj
           (TwoNP (IndefNumNP NoNum (ModAdj (PositAdjP Old) (UseN House)))
           (IndefNumNP NoNum (ModAdj (PositAdjP Young) (UseN Woman)))))))));
 ex6 = OnePhr (ImperOne (ImperVP (PosVG (PredNP (IndefOneNP (UseN Man))))));
 ex7 = ConsPhr PhrYes (ConsPhr (PhrOneCN (ModAdj (AdjP1 American) (ModRC
                  (UseN Wine) (RelSlash IdRP (PosSlashTV INP Wait)))))
                  (ConsPhr (PhrNP (DefNumNP (UseInt 2) (UseN Bottle)))
                  (ConsPhr (PhrIAdv WhereIAdv) (ConsPhr (PhrIAdv HowIAdv)
                  (OnePhr (PhrIP WhenIAdv))))));
 ex8 = OnePhr (IndicPhrase (OneVP (PosVG (PredV3 Prefer (IndefOneNP (AppFun (AppFun2 Connection
                (DefOneNP (UseN House))) (IndefOneNP (UseN Bar))))(ModGenNum
                (UseInt 2) (MassNP (UseN Wine)) (UseN Bottle))))));
 ex9 = OnePhr (QuestPhrase (IntVP WhoOne (AdvVP (SubjVP (PosVG (PredAP (AdvAP
              VeryAdv (PositAdjP Happy)))) WhenSubj (ThereNP (DetNP
              ManyDet (UseN Light)))) Always)));

 ex10 = OnePhr (IndicPhrase (PredVP (ModGenOne INP (UseFun Mother)) (NegVG 
        (PredAP (ComplAdj Married (ModGenOne (UsePN John) (UseFun Uncle)))))));

 ex11 = OnePhr (QuestPhrase (IsThereNP (SuperlNP Happy (UseN Man))));

 ex12 = OnePhr (PhrOneCN (CNthatS (UseN Woman) (PredVP SheNP (PosVG (PredCN
               (ModRC (UseN Woman) (RelVP IdRP (PosVG (PredVV WantVV
               (PredAdV (AdjAdv (ComparAdjP Big EverythingNP))))))))))));

 ex13 = OnePhr (IndicPhrase (SubjS IfSubj (PredVP SomebodyNP (PosVG
                  (PredTV Send (MassNP (UseN Wine))))) (PredVP
                EverybodyNP (PosVG (PredV (VTrans Drink))))));
 ex14 = OnePhr (IndicPhrase (SubjS IfSubj (PredVP SomebodyNP (PosVG
                  (PredTV Send (MassNP (UseN Wine))))) (PredVP
                EverybodyNP (PosVG (PredV (VTrans Drink))))));
 ex15 = OnePhr (AdvS ThereforeAdv (PredVP ThisNP (PosVG (PredNP (IndefOneNP (ModRC
                (UseN House)(RelSuch (PredVP TheyNP (NegVG (PredVV CanKnowVV
                (PredAdV (PrepNP WithPrep YouNP))))))))))));
 ex16 = OnePhr (IndicPhrase (PredVP ThatNP (PosVG (PredCN (ModRC (UseN Woman)
        (RelVP (FunRP Uncle IdRP) (PosVG (PredVS Say (PredVP (UsePN John)
                    (PosVG (PredTV Love (UsePN Mary))))))))))));    
 ex17 = OnePhr (QuestPhrase (IntVP (FunIP Mother (NounIPOne (UseN Woman)))
              (PosVG (PredV Run))));
 ex18 = OnePhr (IndicPhrase (ConjS AndConj (ConsS (TwoS (OneVP (PosVG
               (PredV Run))) (OneVP (PosVG (PredV Walk)))) (OneVP (PosVG
               (PredV (VTrans Wait)))))));
 ex19 = OnePhr (IndicPhrase (ConjDS EitherOr (TwoS (PredVP (UsePN John) (PosVG (PredV Walk))) (PredVP
              (UsePN Mary ) (PosVG (PredV Run))))));

 ex20 = OnePhr (QuestPhrase (QuestVP SomebodyNP (PosVG (PredVV CanKnowVV (PredAP (ConjAP
            OrConj (ConsAP (TwoAP (PositAdjP Young) (PositAdjP Big))
            (PositAdjP Happy))))))));
 ex21 = OnePhr (IndicPhrase (PredVP (IndefOneNP (UseN House))(PosVG (PredVV
       CanVV (PredAP (ConjDAP BothAnd (TwoAP (PositAdjP Big) (PositAdjP
       Small))))))));
 ex22 = OnePhr (IndicPhrase ( PredVP HeNP (NegVG (PredV3 Give (ConjDNP NeitherNor (ConsNP (TwoNP (IndefNumNP
       NoNum (UseN Woman)) (IndefOneNP (UseN Wine))) (IndefOneNP (UseN Car))))
       NobodyNP))));

} ;


