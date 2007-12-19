incomplete concrete ExamplesI of Examples = open Syntax,Lang in {

lincat Ex = Text ;

lin
  ex1 = mkText (UttS (UseCl TPres ASimul PPos (PredVP (UsePron he_Pron) 
          (AdvVP (UseV sing_V) (AdAdv almost_AdA (PositAdvAdj correct_A))))));

  ex2 = mkText (UttAdv (SubjS when_Subj (ConjS and_Conj (BaseS (UseCl TPast ASimul PPos
          (PredVP everybody_NP (UseComp (CompAP (ConjAP and_Conj (BaseAP
          (PositA young_A) (PositA beautiful_A))))))) (UseCl TPast ASimul PPos
          (PredVP everything_NP (ComplVA become_VA (PositA probable_AS)))))))) ;

  ex3 = mkText (UseCl TPres ASimul PPos (CleftNP (PredetNP only_Predet 
          (DetCN (DetPl ( IndefArt) (NumDigits n2_Digits) NoOrd) (UseN woman_N)))
          (UseRCl TCond ASimul PPos (RelSlash IdRP
          (AdvSlash (SlashPrep (PredVP (UsePron i_Pron) (ComplVV want_VV
          (PassV2 see_V2))) with_Prep) (PrepNP in_Prep (DetCN (DetSg 
          (DefArt) NoOrd) (UseN rain_N)))))))) ;

  ex4 = mkText (UttNP (DetCN someSg_Det (RelCN (UseN day_N) (UseRCl TFut ASimul PPos
          (RelCl (ExistNP (AdvNP (DetCN (DetSg ( IndefArt) NoOrd)
          (UseN peace_N)) (PrepNP on_Prep (DetCN (DetSg ( IndefArt)
           NoOrd) (UseN earth_N)))))))))) ;

  ex5 = mkText (UseCl TPres ASimul PPos (PredVP (UsePron they_Pron) (AdvVP
          (ProgrVP (UseV play_V)) (ComparAdvAdjS less_CAdv clever_A
          (UseCl TPres ASimul PPos (GenericCl (UseV think_V))))))) ;
       
  ex6 = mkText (UseCl TPres ASimul PPos (CleftAdv (AdvSC (EmbedVP (AdVVP always_AdV
          (UseV stop_V)))) (UseCl TPres ASimul PPos (PredVP (UsePron we_Pron)
          (ComplV2 beg_V2V (UsePron youPl_Pron)))))) ;

  ex7 = mkText (UseCl TCond ASimul PNeg (PredVP (UsePron i_Pron) (ComplV3 give_V3 
          (DetCN (DetPl ( IndefArt) (AdNum (AdnCAdv more_CAdv) 
          (NumNumeral (num (pot2as3 (pot1as2 (pot0as1 (pot0 n3))))))) NoOrd)
          (UseN star_N)) (DetCN (DetSg ( this_Quant) NoOrd)
          (UseN restaurant_N))))) ;

  ex8 = mkText (UttImpSg PPos (ImpVP (ComplV2A paint_V2A (DetCN (DetSg ( DefArt)
          NoOrd) (UseN earth_N)) (DConjAP both7and_DConj (BaseAP (ComparA
          small_A (DetCN (DetSg ( DefArt) NoOrd) (UseN sun_N)))
          (ComparA big_A (DetCN (DetSg ( DefArt) NoOrd) (UseN moon_N
           ))))))) ) ;

  ex9 = mkText (UseCl TPres ASimul PPos (PredVP everybody_NP (ComplVQ wonder_VQ
          (UseQCl TPres ASimul PPos (QuestSlash whatSg_IP (SlashV2 (UsePron
           youSg_Pron)love_V2)))))) ;

  ex10 = mkText (UseCl TPres ASimul PPos (PredSCVP (EmbedS (UseCl TPres ASimul PNeg
           (PredVP (UsePron i_Pron) (UseComp (CompAP (ReflA2 married_A2))))))
           (ComplV2 kill_V2 (UsePron i_Pron)))) ;

  ex11 = (TQuestMark (PhrUtt (PConjConj and_Conj) (UttQS (UseQCl TPres ASimul
            PNeg (QuestIAdv why_IAdv (PredVP (DetCN (DetSg MassDet NoOrd)
           (UseN art_N)) (UseComp (CompAP (ComparA (UseA2 easy_A2V)
           (DetCN (DetSg MassDet NoOrd) (UseN science_N))))))))) NoVoc) TEmpty) ;

  ex12 = mkText (UseCl TPres ASimul PPos (CleftNP (DetCN (DetSg ( IndefArt)
            NoOrd) (UseN dog_N)) (UseRCl TPres ASimul PPos (RelSlash (FunRP
            with_Prep (DetCN (DetSg ( IndefArt) NoOrd) (UseN friend_N))
            IdRP) (SlashVVV2 (DetCN (DetSg ( (PossPron i_Pron)) NoOrd)
            (UseN2 brother_N2)) can_VV play_V2))))) ;

  ex13 = mkText (ImpPl1 (ComplVS hope_VS (DConjS either7or_DConj (BaseS (UseCl
           TPres ASimul PPos (PredVP (DetCN (DetSg ( DefArt) NoOrd)
           (ComplN2 father_N2 (DetCN (DetSg ( DefArt) NoOrd) 
           (UseN baby_N)))) (UseV run_V))) (UseCl TPres ASimul PPos (PredVP
           (DetCN (DetSg ( DefArt) NoOrd)(UseN3 distance_N3))
           (UseComp (CompAP (PositA small_A))))))))) ;

  ex14 = mkText (UseCl TPres ASimul PNeg (PredVP (UsePron i_Pron) (AdvVP (ReflV2
           (UseVS fear_VS)) now_Adv))) ;

  ex15 = mkText (UseCl TPres ASimul PPos (PredVP (UsePron i_Pron) (ComplV2 (UseVQ
           wonder_VQ) (ConjNP or_Conj (BaseNP somebody_NP something_NP))))) ;

  ex16 = mkText (UseCl TPres ASimul PPos (PredVP (DetCN every_Det (UseN baby_N))
          (UseComp (CompNP (DConjNP either7or_DConj (BaseNP (DetCN (DetSg
          ( IndefArt) NoOrd) (UseN boy_N)) (DetCN (DetSg (
           IndefArt) NoOrd) (UseN girl_N)))))))) ;

  ex17 = (TQuestMark (PhrUtt NoPConj (UttQS (UseQCl TPres ASimul PPos (QuestVP
        (IDetCN whichSg_IDet NoNum NoOrd (ApposCN (ComplN2 (ComplN3 distance_N3
           (DetCN (DetSg ( DefArt) NoOrd) (UseN house_N))) (DetCN (DetSg
           ( DefArt) NoOrd) (UseN bank_N))) (DetCN (DetSg (
            DefArt) (OrdSuperl short_A)) (UseN road_N)))) (PassV2 find_V2)))) 
            NoVoc) TEmpty) ;

  ex18 = (TQuestMark (PhrUtt NoPConj ( UttQS (UseQCl TPres ASimul PPos
           (QuestIComp (CompIAdv where_IAdv) (DetCN (DetSg ( DefArt)
            NoOrd) (RelCN (UseN teacher_N) (UseRCl TPres ASimul PPos
           (RelVP IdRP (ComplV3 sell_V3 (PPartNP (DetCN (DetPl ( DefArt)
           NoNum NoOrd) (UseN book_N)) read_V2) (DetCN (DetPl ( IndefArt)
           NoNum NoOrd) (UseN student_N)))))))))) NoVoc) TEmpty) ;

  ex19 = mkText (UttIAdv (PrepIP with_Prep (AdvIP whoSg_IP (ConjAdv and_Conj (BaseAdv
           (PositAdvAdj cold_A) (PositAdvAdj warm_A)))))) ;

  ex20 = mkText (UttAdv (DConjAdv either7or_DConj (ConsAdv here7from_Adv (BaseAdv
           there_Adv everywhere_Adv)))) ;

  ex21 = (TExclMark (PhrUtt NoPConj (UttImpPl PNeg (ImpVP (UseV die_V)))
           please_Voc) TEmpty) ;

  ex22 = (TQuestMark (PhrUtt NoPConj (UttIP (IDetCN how8many_IDet NoNum NoOrd
           (UseN year_N))) (VocNP (DetCN (DetSg ( (PossPron i_Pron))
            NoOrd) (UseN friend_N)))) TEmpty) ;

  ex23 = mkText (UttVP (PassV2 know_V2)) ;

  ex24 = mkText (UseCl TPres ASimul PPos (PredVP (DetCN (DetSg MassDet NoOrd) (SentCN
           (UseN song_N) (EmbedVP (UseV sing_V)))) (UseComp (CompAP 
           (PositA (UseA2 easy_A2V)))))) ;

  ex25 = mkText (UseCl TPast ASimul PNeg (PredVP (UsePron she_Pron) (ComplV2 know_V2
           (DetCN (DetSg MassDet NoOrd) (AdvCN (UseN industry_N) (PrepNP
        before_Prep (DetCN (DetSg ( DefArt) NoOrd) (UseN university_N)))))))) ;

 ex26 = mkText (UseCl TPres ASimul PPos (PredVP (UsePron she_Pron) (UseComp (CompAP
          (AdAP almost_AdA (SentAP (ComplA2 married_A2 (DetCN (DetSg (
          (PossPron she_Pron)) NoOrd) (UseN cousin_N))) (EmbedQS (UseQCl 
           TPast ASimul PPos (QuestCl (PredVP (UsePron youPol_Pron)
          (ComplV2 watch_V2 (DetCN (DetSg ( DefArt) NoOrd) 
          (UseN television_N))))))))))))) ;

  ex27 = mkText (UseCl TPres ASimul PPos (ImpersCl (ComplVV can8know_VV (UseComp 
           (CompAdv (PositAdvAdj important_A)))))) ;
}






