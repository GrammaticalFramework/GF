--# -path=.:alltenses:prelude

incomplete concrete FraCaSBankI of FraCaSBank = open FraCaS, Prelude in {

lincat FraCaSPhrase = SS;

lin s_001_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (italian_N))) (ComplSlash (SlashV2a (become_V2)) (DetCN (DetQuantOrd (GenNP (DetCN (DetQuant (DefArt) (NumSg)) (UseN (world_N)))) (NumSg) (OrdSuperl (great_A))) (UseN (tenor_N)))))));
lin s_001_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (ExistNP (DetCN (DetQuant (IndefArt) (NumSg)) (RelCN (UseN (italian_N)) (UseRCl (Past) (PPos) (RelVP (IdRP) (ComplSlash (SlashV2a (become_V2)) (DetCN (DetQuantOrd (GenNP (DetCN (DetQuant (DefArt) (NumSg)) (UseN (world_N)))) (NumSg) (OrdSuperl (great_A))) (UseN (tenor_N))))))))))));
lin s_001_3_h = (Sentence (UseCl (Past) (PPos) (ExistNP (DetCN (DetQuant (IndefArt) (NumSg)) (RelCN (UseN (italian_N)) (UseRCl (Past) (PPos) (RelVP (IdRP) (ComplSlash (SlashV2a (become_V2)) (DetCN (DetQuantOrd (GenNP (DetCN (DetQuant (DefArt) (NumSg)) (UseN (world_N)))) (NumSg) (OrdSuperl (great_A))) (UseN (tenor_N)))))))))));

lin s_002_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (every_Det) (AdjCN (PositA (italian_A)) (UseN (man_N)))) (ComplVV (want_VV) (UseComp (CompCN (AdjCN (PositA (great_A)) (UseN (tenor_N)))))))));
lin s_002_2_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (somePl_Det) (AdjCN (PositA (italian_A)) (UseN (man_N)))) (UseComp (CompCN (AdjCN (PositA (great_A)) (UseN (tenor_N))))))));
lin s_002_3_q = (Question (UseQCl (Present) (PPos) (QuestCl (ExistNP (DetCN (DetQuant (IndefArt) (NumPl)) (RelCN (AdjCN (PositA (italian_A)) (UseN (man_N))) (UseRCl (Present) (PPos) (RelVP (IdRP) (ComplVV (want_VV) (UseComp (CompNP (DetCN (DetQuant (IndefArt) (NumSg)) (AdjCN (PositA (great_A)) (UseN (tenor_N)))))))))))))));
lin s_002_4_h = (Sentence (UseCl (Present) (PPos) (ExistNP (DetCN (DetQuant (IndefArt) (NumPl)) (RelCN (AdjCN (PositA (italian_A)) (UseN (man_N))) (UseRCl (Present) (PPos) (RelVP (IdRP) (ComplVV (want_VV) (UseComp (CompNP (DetCN (DetQuant (IndefArt) (NumSg)) (AdjCN (PositA (great_A)) (UseN (tenor_N))))))))))))));

lin s_003_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (PredetNP (all_Predet) (DetCN (DetQuant (IndefArt) (NumPl)) (AdjCN (PositA (italian_A)) (UseN (man_N))))) (ComplVV (want_VV) (UseComp (CompNP (DetCN (DetQuant (IndefArt) (NumSg)) (AdjCN (PositA (great_A)) (UseN (tenor_N))))))))));
lin s_003_2_p = s_002_2_p;
lin s_003_3_q = s_002_3_q;
lin s_003_4_h = s_002_4_h;

lin s_004_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (each_Det) (AdjCN (PositA (italian_A)) (UseN (tenor_N)))) (ComplVV (want_VV) (UseComp (CompAP (PositA (great_A))))))));
lin s_004_2_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (somePl_Det) (AdjCN (PositA (italian_A)) (UseN (tenor_N)))) (UseComp (CompAP (PositA (great_A)))))));
lin s_004_3_q = (Question (UseQCl (Present) (PPos) (QuestCl (ExistNP (DetCN (DetQuant (IndefArt) (NumPl)) (RelCN (AdjCN (PositA (italian_A)) (UseN (tenor_N))) (UseRCl (Present) (PPos) (RelVP (IdRP) (ComplVV (want_VV) (UseComp (CompAP (PositA (great_A)))))))))))));
lin s_004_4_h = (Sentence (UseCl (Present) (PPos) (ExistNP (DetCN (DetQuant (IndefArt) (NumPl)) (RelCN (AdjCN (PositA (italian_A)) (UseN (tenor_N))) (UseRCl (Present) (PPos) (RelVP (IdRP) (ComplVV (want_VV) (UseComp (CompAP (PositA (great_A))))))))))));

lin s_005_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (DetQuant (DefArt) (NumPl)) (AdjCN (AdAP (really_AdA) (PositA (ambitious_A))) (UseN (tenor_N)))) (UseComp (CompAP (PositA (italian_A)))))));
lin s_005_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (ExistNP (DetCN (DetQuant (IndefArt) (NumPl)) (RelCN (AdjCN (AdAP (really_AdA) (PositA (ambitious_A))) (UseN (tenor_N))) (UseRCl (Present) (PPos) (RelVP (IdRP) (UseComp (CompAP (PositA (italian_A))))))))))));
lin s_005_3_h = (Sentence (UseCl (Present) (PPos) (ExistNP (DetCN (DetQuant (IndefArt) (NumPl)) (RelCN (AdjCN (AdAP (really_AdA) (PositA (ambitious_A))) (UseN (tenor_N))) (UseRCl (Present) (PPos) (RelVP (IdRP) (UseComp (CompAP (PositA (italian_A)))))))))));

lin s_006_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (DetQuant (no_Quant) (NumPl)) (AdjCN (AdAP (really_AdA) (PositA (great_A))) (UseN (tenor_N)))) (UseComp (CompAP (PositA (modest_A)))))));
lin s_006_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (ExistNP (DetCN (DetQuant (IndefArt) (NumPl)) (RelCN (AdjCN (AdAP (really_AdA) (PositA (great_A))) (UseN (tenor_N))) (UseRCl (Present) (PPos) (RelVP (IdRP) (UseComp (CompAP (PositA (modest_A))))))))))));
lin s_006_3_h = (Sentence (UseCl (Present) (PPos) (ExistNP (DetCN (DetQuant (IndefArt) (NumPl)) (RelCN (AdjCN (AdAP (really_AdA) (PositA (great_A))) (UseN (tenor_N))) (UseRCl (Present) (PPos) (RelVP (IdRP) (UseComp (CompAP (PositA (modest_A)))))))))));

lin s_007_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (somePl_Det) (AdjCN (PositA (great_A)) (UseN (tenor_N)))) (UseComp (CompAP (PositA (swedish_A)))))));
lin s_007_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (ExistNP (DetCN (DetQuant (IndefArt) (NumPl)) (RelCN (AdjCN (PositA (great_A)) (UseN (tenor_N))) (UseRCl (Present) (PPos) (RelVP (IdRP) (UseComp (CompAP (PositA (swedish_A))))))))))));
lin s_007_3_h = (Sentence (UseCl (Present) (PPos) (ExistNP (DetCN (DetQuant (IndefArt) (NumPl)) (RelCN (AdjCN (PositA (great_A)) (UseN (tenor_N))) (UseRCl (Present) (PPos) (RelVP (IdRP) (UseComp (CompAP (PositA (swedish_A)))))))))));

lin s_008_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (many_Det) (AdjCN (PositA (great_A)) (UseN (tenor_N)))) (UseComp (CompAP (PositA (german_A)))))));
lin s_008_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (ExistNP (DetCN (DetQuant (IndefArt) (NumPl)) (RelCN (AdjCN (PositA (great_A)) (UseN (tenor_N))) (UseRCl (Present) (PPos) (RelVP (IdRP) (UseComp (CompAP (PositA (german_A))))))))))));
lin s_008_3_h = (Sentence (UseCl (Present) (PPos) (ExistNP (DetCN (DetQuant (IndefArt) (NumPl)) (RelCN (AdjCN (PositA (great_A)) (UseN (tenor_N))) (UseRCl (Present) (PPos) (RelVP (IdRP) (UseComp (CompAP (PositA (german_A)))))))))));

lin s_009_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (several_Det) (AdjCN (PositA (great_A)) (UseN (tenor_N)))) (UseComp (CompAP (PositA (british_A)))))));
lin s_009_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (ExistNP (DetCN (DetQuant (IndefArt) (NumPl)) (RelCN (AdjCN (PositA (great_A)) (UseN (tenor_N))) (UseRCl (Present) (PPos) (RelVP (IdRP) (UseComp (CompAP (PositA (british_A))))))))))));
lin s_009_3_h = (Sentence (UseCl (Present) (PPos) (ExistNP (DetCN (DetQuant (IndefArt) (NumPl)) (RelCN (AdjCN (PositA (great_A)) (UseN (tenor_N))) (UseRCl (Present) (PPos) (RelVP (IdRP) (UseComp (CompAP (PositA (british_A)))))))))));

lin s_010_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (PredetNP (most_Predet) (DetCN (DetQuant (IndefArt) (NumPl)) (AdjCN (PositA (great_A)) (UseN (tenor_N))))) (UseComp (CompAP (PositA (italian_A)))))));
lin s_010_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (ExistNP (DetCN (DetQuant (IndefArt) (NumPl)) (RelCN (AdjCN (PositA (great_A)) (UseN (tenor_N))) (UseRCl (Present) (PPos) (RelVP (IdRP) (UseComp (CompAP (PositA (italian_A))))))))))));
lin s_010_3_h = (Sentence (UseCl (Present) (PPos) (ExistNP (DetCN (DetQuant (IndefArt) (NumPl)) (RelCN (AdjCN (PositA (great_A)) (UseN (tenor_N))) (UseRCl (Present) (PPos) (RelVP (IdRP) (UseComp (CompAP (PositA (italian_A)))))))))));

lin s_011_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (a_few_Det) (AdjCN (PositA (great_A)) (UseN (tenor_N)))) (ComplSlash (SlashV2a (sing_V2)) (MassNP (UseN (popular_music_N)))))));
lin s_011_2_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (somePl_Det) (AdjCN (PositA (great_A)) (UseN (tenor_N)))) (ComplSlash (SlashV2a (like_V2)) (MassNP (UseN (popular_music_N)))))));
lin s_011_3_q = (Question (UseQCl (Present) (PPos) (QuestCl (ExistNP (DetCN (DetQuant (IndefArt) (NumPl)) (RelCN (AdjCN (PositA (great_A)) (UseN (tenor_N))) (UseRCl (Present) (PPos) (RelVP (IdRP) (ComplSlash (SlashV2a (sing_V2)) (MassNP (UseN (popular_music_N))))))))))));
lin s_011_4_h = (Sentence (UseCl (Present) (PPos) (ExistNP (DetCN (DetQuant (IndefArt) (NumPl)) (RelCN (AdjCN (PositA (great_A)) (UseN (tenor_N))) (UseRCl (Present) (PPos) (RelVP (IdRP) (ComplSlash (SlashV2a (sing_V2)) (MassNP (UseN (popular_music_N)))))))))));

lin s_012_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (few_Det) (AdjCN (PositA (great_A)) (UseN (tenor_N)))) (UseComp (CompAP (PositA (poor8penniless_A)))))));
lin s_012_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (ExistNP (DetCN (DetQuant (IndefArt) (NumPl)) (RelCN (AdjCN (PositA (great_A)) (UseN (tenor_N))) (UseRCl (Present) (PPos) (RelVP (IdRP) (UseComp (CompAP (PositA (poor8penniless_A))))))))))));
lin s_012_3_h = (Sentence (UseCl (Present) (PPos) (ExistNP (DetCN (DetQuant (IndefArt) (NumPl)) (RelCN (AdjCN (PositA (great_A)) (UseN (tenor_N))) (UseRCl (Present) (PPos) (RelVP (IdRP) (UseComp (CompAP (PositA (poor8penniless_A)))))))))));

lin s_013_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (both_Det) (AdjCN (PositA (leading_A)) (UseN (tenor_N)))) (UseComp (CompAP (PositA (excellent_A)))))));
lin s_013_2_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (DetQuant (IndefArt) (NumPl)) (RelCN (AdjCN (PositA (leading_A)) (UseN (tenor_N))) (UseRCl (Present) (PPos) (RelVP (IdRP) (UseComp (CompAP (PositA (excellent_A)))))))) (UseComp (CompAP (PositA (indispensable_A)))))));
lin s_013_3_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (DetCN (both_Det) (AdjCN (PositA (leading_A)) (UseN (tenor_N)))) (UseComp (CompAP (PositA (indispensable_A))))))));
lin s_013_4_h = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (both_Det) (AdjCN (PositA (leading_A)) (UseN (tenor_N)))) (UseComp (CompAP (PositA (indispensable_A)))))));

lin s_014_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (neither_Det) (AdjCN (PositA (leading_A)) (UseN (tenor_N)))) (come_cheap_VP))));
lin s_014_2_p = (Sentence (UseCl (Present) (PPos) (PredVP (AdvNP (DetNP (DetQuant (IndefArt) (NumSg))) (PrepNP (part_Prep) (DetCN (DetQuant (DefArt) (NumPl)) (AdjCN (PositA (leading_A)) (UseN (tenor_N)))))) (UseComp (CompNP (UsePN (pavarotti_PN)))))));
lin s_014_3_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (UsePN (pavarotti_PN)) (UseComp (CompCN (RelCN (AdjCN (PositA (leading_A)) (UseN (tenor_N))) (UseRCl (Present) (PPos) (RelVP (IdRP) (come_cheap_VP))))))))));
lin s_014_4_h = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (pavarotti_PN)) (UseComp (CompCN (RelCN (AdjCN (PositA (leading_A)) (UseN (tenor_N))) (UseRCl (Present) (PPos) (RelVP (IdRP) (come_cheap_VP)))))))));

lin s_015_1_p = (Sentence (UseCl (Future) (PPos) (PredVP (PredetNP (at_least_Predet) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_three)))) (UseN (tenor_N)))) (ComplSlash (SlashV2a (take_part_in_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (concert_N)))))));
lin s_015_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (ExistNP (DetCN (DetQuant (IndefArt) (NumPl)) (RelCN (UseN (tenor_N)) (UseRCl (Future) (PPos) (RelVP (IdRP) (ComplSlash (SlashV2a (take_part_in_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (concert_N))))))))))));
lin s_015_3_h = (Sentence (UseCl (Present) (PPos) (ExistNP (DetCN (DetQuant (IndefArt) (NumPl)) (RelCN (UseN (tenor_N)) (UseRCl (Future) (PPos) (RelVP (IdRP) (ComplSlash (SlashV2a (take_part_in_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (concert_N)))))))))));

lin s_016_1_p = (Sentence (UseCl (Future) (PPos) (PredVP (PredetNP (at_most_Predet) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_two)))) (UseN (tenor_N)))) (ComplSlash (Slash3V3 (contribute_to_V3) (MassNP (UseN (charity_N)))) (DetCN (DetQuant (PossPron (theyRefl_Pron)) (NumPl)) (UseN (fee_N)))))));
lin s_016_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (ExistNP (DetCN (DetQuant (IndefArt) (NumPl)) (RelCN (UseN (tenor_N)) (UseRCl (Future) (PPos) (RelVP (IdRP) (ComplSlash (Slash3V3 (contribute_to_V3) (MassNP (UseN (charity_N)))) (DetCN (DetQuant (PossPron (theyRefl_Pron)) (NumPl)) (UseN (fee_N))))))))))));
lin s_016_3_h = (Sentence (UseCl (Present) (PPos) (ExistNP (DetCN (DetQuant (IndefArt) (NumPl)) (RelCN (UseN (tenor_N)) (UseRCl (Future) (PPos) (RelVP (IdRP) (ComplSlash (Slash3V3 (contribute_to_V3) (MassNP (UseN (charity_N)))) (DetCN (DetQuant (PossPron (theyRefl_Pron)) (NumPl)) (UseN (fee_N)))))))))));

lin s_017_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (irishman_N))) (ComplSlash (SlashV2a (win_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (ComplN2 (nobel_prize_N2) (MassNP (UseN (literature_N)))))))));
lin s_017_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (irishman_N))) (ComplSlash (SlashV2a (win_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (nobel_prize_N))))))));
lin s_017_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (irishman_N))) (ComplSlash (SlashV2a (win_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (nobel_prize_N)))))));

lin s_018_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (every_Det) (UseN (european_N))) (ComplSlash (SlashV2a (have_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (SentCN (UseN (right_N)) (EmbedVP (AdvVP (UseV (live_V)) (PrepNP (in_Prep) (UsePN (europe_PN)))))))))));
lin s_018_2_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (every_Det) (UseN (european_N))) (UseComp (CompCN (UseN (person_N)))))));
lin s_018_3_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (every_Det) (RelCN (UseN (person_N)) (UseRCl (Present) (PPos) (RelVP (IdRP) (ComplSlash (SlashV2a (have_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (SentCN (UseN (right_N)) (EmbedVP (AdvVP (UseV (live_V)) (PrepNP (in_Prep) (UsePN (europe_PN)))))))))))) (ComplVV (can_VV) (AdvVP (AdvVP (UseV (travel_V)) (PositAdvAdj (free_A))) (PrepNP (within_Prep) (UsePN (europe_PN))))))));
lin s_018_4_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (DetCN (every_Det) (UseN (european_N))) (ComplVV (can_VV) (AdvVP (AdvVP (UseV (travel_V)) (PositAdvAdj (free_A))) (PrepNP (within_Prep) (UsePN (europe_PN)))))))));
lin s_018_5_h = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (every_Det) (UseN (european_N))) (ComplVV (can_VV) (AdvVP (AdvVP (UseV (travel_V)) (PositAdvAdj (free_A))) (PrepNP (within_Prep) (UsePN (europe_PN))))))));

lin s_019_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (PredetNP (all_Predet) (DetCN (DetQuant (IndefArt) (NumPl)) (UseN (european_N)))) (ComplSlash (SlashV2a (have_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (SentCN (UseN (right_N)) (EmbedVP (AdvVP (UseV (live_V)) (PrepNP (in_Prep) (UsePN (europe_PN)))))))))));
lin s_019_2_p = s_018_2_p;
lin s_019_3_p = s_018_3_p;
lin s_019_4_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (PredetNP (all_Predet) (DetCN (DetQuant (IndefArt) (NumPl)) (UseN (european_N)))) (ComplVV (can_VV) (AdvVP (AdvVP (UseV (travel_V)) (PositAdvAdj (free_A))) (PrepNP (within_Prep) (UsePN (europe_PN)))))))));
lin s_019_5_h = (Sentence (UseCl (Present) (PPos) (PredVP (PredetNP (all_Predet) (DetCN (DetQuant (IndefArt) (NumPl)) (UseN (european_N)))) (ComplVV (can_VV) (AdvVP (AdvVP (UseV (travel_V)) (PositAdvAdj (free_A))) (PrepNP (within_Prep) (UsePN (europe_PN))))))));

lin s_020_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (each_Det) (UseN (european_N))) (ComplSlash (SlashV2a (have_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (SentCN (UseN (right_N)) (EmbedVP (AdvVP (UseV (live_V)) (PrepNP (in_Prep) (UsePN (europe_PN)))))))))));
lin s_020_2_p = s_018_2_p;
lin s_020_3_p = s_018_3_p;
lin s_020_4_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (DetCN (each_Det) (UseN (european_N))) (ComplVV (can_VV) (AdvVP (AdvVP (UseV (travel_V)) (PositAdvAdj (free_A))) (PrepNP (within_Prep) (UsePN (europe_PN)))))))));
lin s_020_5_h = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (each_Det) (UseN (european_N))) (ComplVV (can_VV) (AdvVP (AdvVP (UseV (travel_V)) (PositAdvAdj (free_A))) (PrepNP (within_Prep) (UsePN (europe_PN))))))));

lin s_021_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (DetQuant (DefArt) (NumPl)) (ComplN2 (resident_in_N2) (DetCN (DetQuant (IndefArt) (NumPl)) (UseN (member_state_N))))) (ComplSlash (SlashV2a (have_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (SentCN (UseN (right_N)) (EmbedVP (AdvVP (UseV (live_V)) (PrepNP (in_Prep) (UsePN (europe_PN)))))))))));
lin s_021_2_p = (Sentence (UseCl (Present) (PPos) (PredVP (PredetNP (all_Predet) (DetCN (DetQuant (IndefArt) (NumPl)) (ComplN2 (resident_in_N2) (DetCN (DetQuant (IndefArt) (NumPl)) (UseN (member_state_N)))))) (UseComp (CompCN (UseN (individual_N)))))));
lin s_021_3_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (every_Det) (RelCN (UseN (individual_N)) (UseRCl (Present) (PPos) (RelVP (IdRP) (ComplSlash (SlashV2a (have_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (SentCN (UseN (right_N)) (EmbedVP (AdvVP (UseV (live_V)) (PrepNP (in_Prep) (UsePN (europe_PN)))))))))))) (ComplVV (can_VV) (AdvVP (AdvVP (UseV (travel_V)) (PositAdvAdj (free_A))) (PrepNP (within_Prep) (UsePN (europe_PN))))))));
lin s_021_4_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (DetCN (DetQuant (DefArt) (NumPl)) (ComplN2 (resident_in_N2) (DetCN (DetQuant (IndefArt) (NumPl)) (UseN (member_state_N))))) (ComplVV (can_VV) (AdvVP (AdvVP (UseV (travel_V)) (PositAdvAdj (free_A))) (PrepNP (within_Prep) (UsePN (europe_PN)))))))));
lin s_021_5_h = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (DetQuant (DefArt) (NumPl)) (ComplN2 (resident_in_N2) (DetCN (DetQuant (IndefArt) (NumPl)) (UseN (member_state_N))))) (ComplVV (can_VV) (AdvVP (AdvVP (UseV (travel_V)) (PositAdvAdj (free_A))) (PrepNP (within_Prep) (UsePN (europe_PN))))))));

lin s_022_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (DetQuant (no_Quant) (NumSg)) (UseN (delegate_N))) (AdvVP (ComplSlash (SlashV2a (finish_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (report_N)))) (on_time_Adv)))));
lin s_022_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (DetCN (DetQuant (no_Quant) (NumSg)) (UseN (delegate_N))) (ComplSlash (SlashV2a (finish_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (report_N))))))));
lin s_022_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (DetQuant (no_Quant) (NumSg)) (UseN (delegate_N))) (ComplSlash (SlashV2a (finish_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (report_N)))))));

lin s_023_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (somePl_Det) (UseN (delegate_N))) (AdvVP (ComplSlash (SlashV2a (finish_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (survey_N)))) (on_time_Adv)))));
lin s_023_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (DetCN (somePl_Det) (UseN (delegate_N))) (ComplSlash (SlashV2a (finish_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (survey_N))))))));
lin s_023_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (somePl_Det) (UseN (delegate_N))) (ComplSlash (SlashV2a (finish_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (survey_N)))))));

lin s_024_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (many_Det) (UseN (delegate_N))) (ComplSlash (Slash3V3 (obtain_from_V3) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (survey_N)))) (DetCN (DetQuant (IndefArt) (NumPl)) (AdjCN (PositA (interesting_A)) (UseN (result_N))))))));
lin s_024_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (DetCN (many_Det) (UseN (delegate_N))) (ComplSlash (Slash3V3 (obtain_from_V3) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (survey_N)))) (DetCN (DetQuant (IndefArt) (NumPl)) (UseN (result_N))))))));
lin s_024_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (many_Det) (UseN (delegate_N))) (ComplSlash (Slash3V3 (obtain_from_V3) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (survey_N)))) (DetCN (DetQuant (IndefArt) (NumPl)) (UseN (result_N)))))));

lin s_025_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (several_Det) (UseN (delegate_N))) (AdvVP (ComplSlash (SlashV2a (get_V2)) (PPartNP (DetCN (DetQuant (DefArt) (NumPl)) (UseN (result_N))) (publish_V2))) (PrepNP (in_Prep) (DetCN (DetQuant (IndefArt) (NumPl)) (AdjCN (PositA (major_A)) (AdjCN (PositA (national_A)) (UseN (newspaper_N))))))))));
lin s_025_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (DetCN (several_Det) (UseN (delegate_N))) (ComplSlash (SlashV2a (get_V2)) (PPartNP (DetCN (DetQuant (DefArt) (NumPl)) (UseN (result_N))) (publish_V2)))))));
lin s_025_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (several_Det) (UseN (delegate_N))) (ComplSlash (SlashV2a (get_V2)) (PPartNP (DetCN (DetQuant (DefArt) (NumPl)) (UseN (result_N))) (publish_V2))))));

lin s_026_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (PredetNP (most_Predet) (DetCN (DetQuant (IndefArt) (NumPl)) (UseN (european_N)))) (UseComp (CompAP (AdvAP (PositA (resident_A)) (PrepNP (in_Prep) (UsePN (europe_PN)))))))));
lin s_026_2_p = (Sentence (UseCl (Present) (PPos) (PredVP (PredetNP (all_Predet) (DetCN (DetQuant (IndefArt) (NumPl)) (UseN (european_N)))) (UseComp (CompCN (UseN (person_N)))))));
lin s_026_3_p = (Sentence (UseCl (Present) (PPos) (PredVP (PredetNP (all_Predet) (DetCN (DetQuant (IndefArt) (NumPl)) (RelCN (UseN (person_N)) (UseRCl (Present) (PPos) (RelVP (IdRP) (UseComp (CompAP (AdvAP (PositA (resident_A)) (PrepNP (in_Prep) (UsePN (europe_PN))))))))))) (ComplVV (can_VV) (AdvVP (AdvVP (UseV (travel_V)) (PositAdvAdj (free_A))) (PrepNP (within_Prep) (UsePN (europe_PN))))))));
lin s_026_4_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (PredetNP (most_Predet) (DetCN (DetQuant (IndefArt) (NumPl)) (UseN (european_N)))) (ComplVV (can_VV) (AdvVP (AdvVP (UseV (travel_V)) (PositAdvAdj (free_A))) (PrepNP (within_Prep) (UsePN (europe_PN)))))))));
lin s_026_5_h = (Sentence (UseCl (Present) (PPos) (PredVP (PredetNP (most_Predet) (DetCN (DetQuant (IndefArt) (NumPl)) (UseN (european_N)))) (ComplVV (can_VV) (AdvVP (AdvVP (UseV (travel_V)) (PositAdvAdj (free_A))) (PrepNP (within_Prep) (UsePN (europe_PN))))))));

lin s_027_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (a_few_Det) (UseN (committee_member_N))) (UseComp (CompAdv (PrepNP (from_Prep) (UsePN (sweden_PN))))))));
lin s_027_2_p = (Sentence (UseCl (Present) (PPos) (PredVP (PredetNP (all_Predet) (DetCN (DetQuant (IndefArt) (NumPl)) (UseN (committee_member_N)))) (UseComp (CompCN (UseN (person_N)))))));
lin s_027_3_p = (Sentence (UseCl (Present) (PPos) (PredVP (PredetNP (all_Predet) (DetCN (DetQuant (IndefArt) (NumPl)) (RelCN (UseN (person_N)) (UseRCl (Present) (PPos) (RelVP (IdRP) (UseComp (CompAdv (PrepNP (from_Prep) (UsePN (sweden_PN)))))))))) (UseComp (CompAdv (PrepNP (from_Prep) (UsePN (scandinavia_PN))))))));
lin s_027_4_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (PredetNP (at_least_Predet) (DetCN (a_few_Det) (UseN (committee_member_N)))) (UseComp (CompAdv (PrepNP (from_Prep) (UsePN (scandinavia_PN)))))))));
lin s_027_5_h = (Sentence (UseCl (Present) (PPos) (PredVP (PredetNP (at_least_Predet) (DetCN (a_few_Det) (UseN (committee_member_N)))) (UseComp (CompAdv (PrepNP (from_Prep) (UsePN (scandinavia_PN))))))));

lin s_028_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (few_Det) (UseN (committee_member_N))) (UseComp (CompAdv (PrepNP (from_Prep) (UsePN (portugal_PN))))))));
lin s_028_2_p = s_027_2_p;
lin s_028_3_p = (Sentence (UseCl (Present) (PPos) (PredVP (PredetNP (all_Predet) (DetCN (DetQuant (IndefArt) (NumPl)) (RelCN (UseN (person_N)) (UseRCl (Present) (PPos) (RelVP (IdRP) (UseComp (CompAdv (PrepNP (from_Prep) (UsePN (portugal_PN)))))))))) (UseComp (CompAdv (PrepNP (from_Prep) (UsePN (southern_europe_PN))))))));
lin s_028_4_q = (Question (UseQCl (Present) (PPos) (QuestCl (ExistNP (DetCN (few_Det) (AdvCN (UseN (committee_member_N)) (PrepNP (from_Prep) (UsePN (southern_europe_PN)))))))));
lin s_028_5_h = (Sentence (UseCl (Present) (PPos) (ExistNP (DetCN (few_Det) (AdvCN (UseN (committee_member_N)) (PrepNP (from_Prep) (UsePN (southern_europe_PN))))))));

lin s_029_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (both_Det) (UseN (commissioner_N))) (ComplVV (use_VV) (UseComp (CompCN (AdjCN (PositA (leading_A)) (UseN (businessman_N)))))))));
lin s_029_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (DetCN (both_Det) (UseN (commissioner_N))) (ComplVV (use_VV) (UseComp (CompCN (UseN (businessman_N)))))))));
lin s_029_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (both_Det) (UseN (commissioner_N))) (ComplVV (use_VV) (UseComp (CompCN (UseN (businessman_N))))))));

lin s_030_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (neither_Det) (UseN (commissioner_N))) (AdvVP (ComplSlash (SlashV2a (spend_V2)) (DetCN (a_lot_of_Det) (UseN (time_N)))) (at_home_Adv)))));
lin s_030_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (DetCN (neither_Det) (UseN (commissioner_N))) (AdvVP (ComplSlash (SlashV2a (spend_V2)) (MassNP (UseN (time_N)))) (at_home_Adv))))));
lin s_030_3_h = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (neither_Det) (UseN (commissioner_N))) (AdvVP (ComplSlash (SlashV2a (spend_V2)) (MassNP (UseN (time_N)))) (at_home_Adv)))));

lin s_031_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (PredetNP (at_least_Predet) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_three)))) (UseN (commissioner_N)))) (AdvVP (ComplSlash (SlashV2a (spend_V2)) (DetCN (a_lot_of_Det) (UseN (time_N)))) (at_home_Adv)))));
lin s_031_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (PredetNP (at_least_Predet) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_three)))) (UseN (commissioner_N)))) (AdvVP (ComplSlash (SlashV2a (spend_V2)) (MassNP (UseN (time_N)))) (at_home_Adv))))));
lin s_031_3_h = (Sentence (UseCl (Present) (PPos) (PredVP (PredetNP (at_least_Predet) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_three)))) (UseN (commissioner_N)))) (AdvVP (ComplSlash (SlashV2a (spend_V2)) (MassNP (UseN (time_N)))) (at_home_Adv)))));

lin s_032_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (PredetNP (at_most_Predet) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_ten)))) (UseN (commissioner_N)))) (AdvVP (ComplSlash (SlashV2a (spend_V2)) (DetCN (a_lot_of_Det) (UseN (time_N)))) (at_home_Adv)))));
lin s_032_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (PredetNP (at_most_Predet) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_ten)))) (UseN (commissioner_N)))) (AdvVP (ComplSlash (SlashV2a (spend_V2)) (MassNP (UseN (time_N)))) (at_home_Adv))))));
lin s_032_3_h = (Sentence (UseCl (Present) (PPos) (PredVP (PredetNP (at_most_Predet) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_ten)))) (UseN (commissioner_N)))) (AdvVP (ComplSlash (SlashV2a (spend_V2)) (MassNP (UseN (time_N)))) (at_home_Adv)))));

lin s_033_1_p = s_017_3_h;
lin s_033_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (irishman_N))) (ComplSlash (SlashV2a (win_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (ComplN2 (nobel_prize_N2) (MassNP (UseN (literature_N))))))))));
lin s_033_3_h = s_017_1_p;

lin s_034_1_p = s_018_5_h;
lin s_034_2_p = s_018_2_p;
lin s_034_3_p = s_018_3_p;
lin s_034_4_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (DetCN (every_Det) (UseN (european_N))) (ComplSlash (SlashV2a (have_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (SentCN (UseN (right_N)) (EmbedVP (AdvVP (UseV (live_V)) (PrepNP (in_Prep) (UsePN (europe_PN))))))))))));
lin s_034_5_h = s_018_1_p;

lin s_035_1_p = s_019_5_h;
lin s_035_2_p = s_018_2_p;
lin s_035_3_p = s_018_3_p;
lin s_035_4_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (PredetNP (all_Predet) (DetCN (DetQuant (IndefArt) (NumPl)) (UseN (european_N)))) (ComplSlash (SlashV2a (have_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (SentCN (UseN (right_N)) (EmbedVP (AdvVP (UseV (live_V)) (PrepNP (in_Prep) (UsePN (europe_PN))))))))))));
lin s_035_5_h = s_019_1_p;

lin s_036_1_p = s_020_5_h;
lin s_036_2_p = s_018_2_p;
lin s_036_3_p = s_018_3_p;
lin s_036_4_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (DetCN (each_Det) (UseN (european_N))) (ComplSlash (SlashV2a (have_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (SentCN (UseN (right_N)) (EmbedVP (AdvVP (UseV (live_V)) (PrepNP (in_Prep) (UsePN (europe_PN))))))))))));
lin s_036_5_h = s_020_1_p;

lin s_037_1_p = s_021_5_h;
lin s_037_2_p = s_021_2_p;
lin s_037_3_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (every_Det) (RelCN (UseN (individual_N)) (UseRCl (Present) (PPos) (RelVP (IdRP) (ComplSlash (SlashV2a (have_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (SentCN (UseN (right_N)) (EmbedVP (AdvVP (AdvVP (UseV (live_V)) (anywhere_Adv)) (PrepNP (in_Prep) (UsePN (europe_PN)))))))))))) (ComplVV (can_VV) (AdvVP (AdvVP (UseV (travel_V)) (PositAdvAdj (free_A))) (PrepNP (within_Prep) (UsePN (europe_PN))))))));
lin s_037_4_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (DetCN (DetQuant (DefArt) (NumPl)) (ComplN2 (resident_in_N2) (DetCN (DetQuant (IndefArt) (NumPl)) (UseN (member_state_N))))) (ComplSlash (SlashV2a (have_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (SentCN (UseN (right_N)) (EmbedVP (AdvVP (AdvVP (UseV (live_V)) (anywhere_Adv)) (PrepNP (in_Prep) (UsePN (europe_PN))))))))))));
lin s_037_5_h = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (DetQuant (DefArt) (NumPl)) (ComplN2 (resident_in_N2) (DetCN (DetQuant (IndefArt) (NumPl)) (UseN (member_state_N))))) (ComplSlash (SlashV2a (have_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (SentCN (UseN (right_N)) (EmbedVP (AdvVP (AdvVP (UseV (live_V)) (anywhere_Adv)) (PrepNP (in_Prep) (UsePN (europe_PN)))))))))));

lin s_038_1_p = s_022_3_h;
lin s_038_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (DetCN (anySg_Det) (UseN (delegate_N))) (AdvVP (ComplSlash (SlashV2a (finish_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (report_N)))) (on_time_Adv))))));
lin s_038_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (someSg_Det) (UseN (delegate_N))) (AdvVP (ComplSlash (SlashV2a (finish_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (report_N)))) (on_time_Adv)))));

lin s_039_1_p = s_023_3_h;
lin s_039_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (DetCN (somePl_Det) (UseN (delegate_N))) (AdvVP (ComplSlash (SlashV2a (finish_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (survey_N)))) (on_time_Adv))))));
lin s_039_3_h = s_023_1_p;

lin s_040_1_p = s_024_3_h;
lin s_040_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (DetCN (many_Det) (UseN (delegate_N))) (ComplSlash (Slash3V3 (obtain_from_V3) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (survey_N)))) (DetCN (DetQuant (IndefArt) (NumPl)) (AdjCN (PositA (interesting_A)) (UseN (result_N)))))))));
lin s_040_3_h = s_024_1_p;

lin s_041_1_p = s_025_3_h;
lin s_041_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (DetCN (several_Det) (UseN (delegate_N))) (AdvVP (ComplSlash (SlashV2a (get_V2)) (PPartNP (DetCN (DetQuant (DefArt) (NumPl)) (UseN (result_N))) (publish_V2))) (PrepNP (in_Prep) (DetCN (DetQuant (IndefArt) (NumPl)) (AdjCN (PositA (major_A)) (AdjCN (PositA (national_A)) (UseN (newspaper_N)))))))))));
lin s_041_3_h = s_025_1_p;

lin s_042_1_p = s_026_5_h;
lin s_042_2_p = s_026_2_p;
lin s_042_3_p = s_026_3_p;
lin s_042_4_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (PredetNP (most_Predet) (DetCN (DetQuant (IndefArt) (NumPl)) (UseN (european_N)))) (UseComp (CompAP (AdvAP (PositA (resident_A)) (PrepNP (in_Prep) (UsePN (europe_PN))))))))));
lin s_042_5_h = s_026_1_p;

lin s_043_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (a_few_Det) (UseN (committee_member_N))) (UseComp (CompAdv (PrepNP (from_Prep) (UsePN (scandinavia_PN))))))));
lin s_043_2_p = s_027_2_p;
lin s_043_3_p = s_027_3_p;
lin s_043_4_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (PredetNP (at_least_Predet) (DetCN (a_few_Det) (UseN (committee_member_N)))) (UseComp (CompAdv (PrepNP (from_Prep) (UsePN (sweden_PN)))))))));
lin s_043_5_h = (Sentence (UseCl (Present) (PPos) (PredVP (PredetNP (at_least_Predet) (DetCN (a_few_Det) (UseN (committee_member_N)))) (UseComp (CompAdv (PrepNP (from_Prep) (UsePN (sweden_PN))))))));

lin s_044_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (few_Det) (UseN (committee_member_N))) (UseComp (CompAdv (PrepNP (from_Prep) (UsePN (southern_europe_PN))))))));
lin s_044_2_p = s_027_2_p;
lin s_044_3_p = s_028_3_p;
lin s_044_4_q = (Question (UseQCl (Present) (PPos) (QuestCl (ExistNP (DetCN (few_Det) (AdvCN (UseN (committee_member_N)) (PrepNP (from_Prep) (UsePN (portugal_PN)))))))));
lin s_044_5_h = (Sentence (UseCl (Present) (PPos) (ExistNP (DetCN (few_Det) (AdvCN (UseN (committee_member_N)) (PrepNP (from_Prep) (UsePN (portugal_PN))))))));

lin s_045_1_p = s_029_3_h;
lin s_045_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (DetCN (both_Det) (UseN (commissioner_N))) (ComplVV (use_VV) (UseComp (CompCN (AdjCN (PositA (leading_A)) (UseN (businessman_N))))))))));
lin s_045_3_h = s_029_1_p;

lin s_046_1_p = s_030_3_h;
lin s_046_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (DetCN (either_Det) (UseN (commissioner_N))) (AdvVP (ComplSlash (SlashV2a (spend_V2)) (DetCN (a_lot_of_Det) (UseN (time_N)))) (at_home_Adv))))));
lin s_046_3_h = (Sentence (UseCl (Present) (PPos) (PredVP (AdvNP (DetNP (DetQuant (IndefArt) (NumSg))) (PrepNP (part_Prep) (DetCN (DetQuant (DefArt) (NumPl)) (UseN (commissioner_N))))) (AdvVP (ComplSlash (SlashV2a (spend_V2)) (DetCN (a_lot_of_Det) (UseN (time_N)))) (at_home_Adv)))));

lin s_047_1_p = s_031_3_h;
lin s_047_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (PredetNP (at_least_Predet) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_three)))) (UseN (commissioner_N)))) (AdvVP (ComplSlash (SlashV2a (spend_V2)) (DetCN (a_lot_of_Det) (UseN (time_N)))) (at_home_Adv))))));
lin s_047_3_h = s_031_1_p;

lin s_048_1_p = s_032_3_h;
lin s_048_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (PredetNP (at_most_Predet) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_ten)))) (UseN (commissioner_N)))) (AdvVP (ComplSlash (SlashV2a (spend_V2)) (DetCN (a_lot_of_Det) (UseN (time_N)))) (at_home_Adv))))));
lin s_048_3_h = s_032_1_p;

lin s_049_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (swede_N))) (ComplSlash (SlashV2a (win_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (nobel_prize_N)))))));
lin s_049_2_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (every_Det) (UseN (swede_N))) (UseComp (CompCN (UseN (scandinavian_N)))))));
lin s_049_3_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (scandinavian_N))) (ComplSlash (SlashV2a (win_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (nobel_prize_N))))))));
lin s_049_4_h = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (scandinavian_N))) (ComplSlash (SlashV2a (win_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (nobel_prize_N)))))));

lin s_050_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (every_Det) (AdjCN (PositA (canadian_A)) (UseN (resident_N)))) (ComplVV (can_VV) (AdvVP (AdvVP (UseV (travel_V)) (PositAdvAdj (free_A))) (PrepNP (within_Prep) (UsePN (europe_PN))))))));
lin s_050_2_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (every_Det) (AdjCN (PositA (canadian_A)) (UseN (resident_N)))) (UseComp (CompCN (ComplN2 (resident_on_N2) (DetCN (DetQuant (DefArt) (NumSg)) (AdjCN (PositA (north_american_A)) (UseN (continent_N))))))))));
lin s_050_3_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (DetCN (every_Det) (ComplN2 (resident_on_N2) (DetCN (DetQuant (DefArt) (NumSg)) (AdjCN (PositA (north_american_A)) (UseN (continent_N)))))) (ComplVV (can_VV) (AdvVP (AdvVP (UseV (travel_V)) (PositAdvAdj (free_A))) (PrepNP (within_Prep) (UsePN (europe_PN)))))))));
lin s_050_4_h = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (every_Det) (ComplN2 (resident_on_N2) (DetCN (DetQuant (DefArt) (NumSg)) (AdjCN (PositA (north_american_A)) (UseN (continent_N)))))) (ComplVV (can_VV) (AdvVP (AdvVP (UseV (travel_V)) (PositAdvAdj (free_A))) (PrepNP (within_Prep) (UsePN (europe_PN))))))));

lin s_051_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (PredetNP (all_Predet) (DetCN (DetQuant (IndefArt) (NumPl)) (AdjCN (PositA (canadian_A)) (UseN (resident_N))))) (ComplVV (can_VV) (AdvVP (AdvVP (UseV (travel_V)) (PositAdvAdj (free_A))) (PrepNP (within_Prep) (UsePN (europe_PN))))))));
lin s_051_2_p = s_050_2_p;
lin s_051_3_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (PredetNP (all_Predet) (DetCN (DetQuant (IndefArt) (NumPl)) (ComplN2 (resident_on_N2) (DetCN (DetQuant (DefArt) (NumSg)) (AdjCN (PositA (north_american_A)) (UseN (continent_N))))))) (ComplVV (can_VV) (AdvVP (AdvVP (UseV (travel_V)) (PositAdvAdj (free_A))) (PrepNP (within_Prep) (UsePN (europe_PN)))))))));
lin s_051_4_h = (Sentence (UseCl (Present) (PPos) (PredVP (PredetNP (all_Predet) (DetCN (DetQuant (IndefArt) (NumPl)) (ComplN2 (resident_on_N2) (DetCN (DetQuant (DefArt) (NumSg)) (AdjCN (PositA (north_american_A)) (UseN (continent_N))))))) (ComplVV (can_VV) (AdvVP (AdvVP (UseV (travel_V)) (PositAdvAdj (free_A))) (PrepNP (within_Prep) (UsePN (europe_PN))))))));

lin s_052_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (each_Det) (AdjCN (PositA (canadian_A)) (UseN (resident_N)))) (ComplVV (can_VV) (AdvVP (AdvVP (UseV (travel_V)) (PositAdvAdj (free_A))) (PrepNP (within_Prep) (UsePN (europe_PN))))))));
lin s_052_2_p = s_050_2_p;
lin s_052_3_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (DetCN (each_Det) (ComplN2 (resident_on_N2) (DetCN (DetQuant (DefArt) (NumSg)) (AdjCN (PositA (north_american_A)) (UseN (continent_N)))))) (ComplVV (can_VV) (AdvVP (AdvVP (UseV (travel_V)) (PositAdvAdj (free_A))) (PrepNP (within_Prep) (UsePN (europe_PN)))))))));
lin s_052_4_h = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (each_Det) (ComplN2 (resident_on_N2) (DetCN (DetQuant (DefArt) (NumSg)) (AdjCN (PositA (north_american_A)) (UseN (continent_N)))))) (ComplVV (can_VV) (AdvVP (AdvVP (UseV (travel_V)) (PositAdvAdj (free_A))) (PrepNP (within_Prep) (UsePN (europe_PN))))))));

lin s_053_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (DetQuant (DefArt) (NumPl)) (ComplN2 (resident_in_N2) (DetCN (DetQuant (IndefArt) (NumPl)) (AdjCN (PositA (major_A)) (AdjCN (PositA (western_A)) (UseN (country_N))))))) (ComplVV (can_VV) (AdvVP (AdvVP (UseV (travel_V)) (PositAdvAdj (free_A))) (PrepNP (within_Prep) (UsePN (europe_PN))))))));
lin s_053_2_p = (Sentence (UseCl (Present) (PPos) (PredVP (PredetNP (all_Predet) (DetCN (DetQuant (IndefArt) (NumPl)) (ComplN2 (resident_in_N2) (DetCN (DetQuant (IndefArt) (NumPl)) (AdjCN (PositA (major_A)) (AdjCN (PositA (western_A)) (UseN (country_N)))))))) (UseComp (CompCN (ComplN2 (resident_in_N2) (DetCN (DetQuant (IndefArt) (NumPl)) (AdjCN (PositA (western_A)) (UseN (country_N))))))))));
lin s_053_3_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (DetCN (DetQuant (DefArt) (NumPl)) (ComplN2 (resident_in_N2) (DetCN (DetQuant (IndefArt) (NumPl)) (AdjCN (PositA (western_A)) (UseN (country_N)))))) (ComplSlash (SlashV2a (have_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (SentCN (UseN (right_N)) (EmbedVP (AdvVP (UseV (live_V)) (PrepNP (in_Prep) (UsePN (europe_PN))))))))))));
lin s_053_4_h = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (DetQuant (DefArt) (NumPl)) (ComplN2 (resident_in_N2) (DetCN (DetQuant (IndefArt) (NumPl)) (AdjCN (PositA (western_A)) (UseN (country_N)))))) (ComplSlash (SlashV2a (have_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (SentCN (UseN (right_N)) (EmbedVP (AdvVP (UseV (live_V)) (PrepNP (in_Prep) (UsePN (europe_PN)))))))))));

lin s_054_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (DetQuant (no_Quant) (NumSg)) (AdjCN (PositA (scandinavian_A)) (UseN (delegate_N)))) (AdvVP (ComplSlash (SlashV2a (finish_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (report_N)))) (on_time_Adv)))));
lin s_054_2_q = s_038_2_q;
lin s_054_3_h = s_038_3_h;

lin s_055_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (somePl_Det) (AdjCN (PositA (irish_A)) (UseN (delegate_N)))) (AdvVP (ComplSlash (SlashV2a (finish_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (survey_N)))) (on_time_Adv)))));
lin s_055_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (DetCN (anyPl_Det) (UseN (delegate_N))) (AdvVP (ComplSlash (SlashV2a (finish_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (survey_N)))) (on_time_Adv))))));
lin s_055_3_h = s_023_1_p;

lin s_056_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (many_Det) (AdjCN (PositA (british_A)) (UseN (delegate_N)))) (ComplSlash (Slash3V3 (obtain_from_V3) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (survey_N)))) (DetCN (DetQuant (IndefArt) (NumPl)) (AdjCN (PositA (interesting_A)) (UseN (result_N))))))));
lin s_056_2_q = s_040_2_q;
lin s_056_3_h = s_024_1_p;

lin s_057_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (several_Det) (AdjCN (PositA (portuguese_A)) (UseN (delegate_N)))) (AdvVP (ComplSlash (SlashV2a (get_V2)) (PPartNP (DetCN (DetQuant (DefArt) (NumPl)) (UseN (result_N))) (publish_V2))) (PrepNP (in_Prep) (DetCN (DetQuant (IndefArt) (NumPl)) (AdjCN (PositA (major_A)) (AdjCN (PositA (national_A)) (UseN (newspaper_N))))))))));
lin s_057_2_q = s_041_2_q;
lin s_057_3_h = s_025_1_p;

lin s_058_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (PredetNP (most_Predet) (DetCN (DetQuant (IndefArt) (NumPl)) (RelCN (UseN (european_N)) (UseRCl (Present) (PPos) (RelVP (IdRP) (AdvVP (UseComp (CompAP (PositA (resident_A)))) (PrepNP (in_Prep) (UsePN (europe_PN))))))))) (ComplVV (can_VV) (AdvVP (AdvVP (UseV (travel_V)) (PositAdvAdj (free_A))) (PrepNP (within_Prep) (UsePN (europe_PN))))))));
lin s_058_2_q = s_026_4_q;
lin s_058_3_h = s_026_5_h;

lin s_059_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (a_few_Det) (AdjCN (PositA (female_A)) (UseN (committee_member_N)))) (UseComp (CompAdv (PrepNP (from_Prep) (UsePN (scandinavia_PN))))))));
lin s_059_2_q = s_027_4_q;
lin s_059_3_h = s_027_5_h;

lin s_060_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (few_Det) (AdjCN (PositA (female_A)) (UseN (committee_member_N)))) (UseComp (CompAdv (PrepNP (from_Prep) (UsePN (southern_europe_PN))))))));
lin s_060_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (DetCN (few_Det) (UseN (committee_member_N))) (UseComp (CompAdv (PrepNP (from_Prep) (UsePN (southern_europe_PN)))))))));
lin s_060_3_h = s_044_1_p;

lin s_061_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (both_Det) (AdjCN (PositA (female_A)) (UseN (commissioner_N)))) (ComplVV (use_VV) (UseComp (CompAdv (PrepNP (in_Prep) (MassNP (UseN (business_N))))))))));
lin s_061_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (DetCN (both_Det) (UseN (commissioner_N))) (ComplVV (use_VV) (UseComp (CompAdv (PrepNP (in_Prep) (MassNP (UseN (business_N)))))))))));
lin s_061_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (both_Det) (UseN (commissioner_N))) (ComplVV (use_VV) (UseComp (CompAdv (PrepNP (in_Prep) (MassNP (UseN (business_N))))))))));

lin s_062_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (neither_Det) (AdjCN (PositA (female_A)) (UseN (commissioner_N)))) (AdvVP (ComplSlash (SlashV2a (spend_V2)) (DetCN (a_lot_of_Det) (UseN (time_N)))) (at_home_Adv)))));
lin s_062_2_q = s_046_2_q;
lin s_062_3_h = s_046_3_h;

lin s_063_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (PredetNP (at_least_Predet) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_three)))) (AdjCN (PositA (female_A)) (UseN (commissioner_N))))) (AdvVP (ComplSlash (SlashV2a (spend_V2)) (MassNP (UseN (time_N)))) (at_home_Adv)))));
lin s_063_2_q = s_031_2_q;
lin s_063_3_h = s_031_3_h;

lin s_064_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (PredetNP (at_most_Predet) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_ten)))) (AdjCN (PositA (female_A)) (UseN (commissioner_N))))) (AdvVP (ComplSlash (SlashV2a (spend_V2)) (MassNP (UseN (time_N)))) (at_home_Adv)))));
lin s_064_2_q = s_032_2_q;
lin s_064_3_h = s_032_3_h;

lin s_065_1_p = s_049_4_h;
lin s_065_2_p = s_049_2_p;
lin s_065_3_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (swede_N))) (ComplSlash (SlashV2a (win_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (nobel_prize_N))))))));
lin s_065_4_h = s_049_1_p;

lin s_066_1_p = s_050_4_h;
lin s_066_2_p = s_050_2_p;
lin s_066_3_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (DetCN (every_Det) (AdjCN (PositA (canadian_A)) (UseN (resident_N)))) (ComplVV (can_VV) (AdvVP (AdvVP (UseV (travel_V)) (PositAdvAdj (free_A))) (PrepNP (within_Prep) (UsePN (europe_PN)))))))));
lin s_066_4_h = s_050_1_p;

lin s_067_1_p = s_051_4_h;
lin s_067_2_p = s_050_2_p;
lin s_067_3_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (PredetNP (all_Predet) (DetCN (DetQuant (IndefArt) (NumPl)) (AdjCN (PositA (canadian_A)) (UseN (resident_N))))) (ComplVV (can_VV) (AdvVP (AdvVP (UseV (travel_V)) (PositAdvAdj (free_A))) (PrepNP (within_Prep) (UsePN (europe_PN)))))))));
lin s_067_4_h = s_051_1_p;

lin s_068_1_p = s_052_4_h;
lin s_068_2_p = s_050_2_p;
lin s_068_3_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (DetCN (each_Det) (AdjCN (PositA (canadian_A)) (UseN (resident_N)))) (ComplVV (can_VV) (AdvVP (AdvVP (UseV (travel_V)) (PositAdvAdj (free_A))) (PrepNP (within_Prep) (UsePN (europe_PN)))))))));
lin s_068_4_h = s_052_1_p;

lin s_069_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (DetQuant (DefArt) (NumPl)) (ComplN2 (resident_in_N2) (DetCN (DetQuant (IndefArt) (NumPl)) (AdjCN (PositA (western_A)) (UseN (country_N)))))) (ComplVV (can_VV) (AdvVP (AdvVP (UseV (travel_V)) (PositAdvAdj (free_A))) (PrepNP (within_Prep) (UsePN (europe_PN))))))));
lin s_069_2_p = s_053_2_p;
lin s_069_3_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (DetCN (DetQuant (DefArt) (NumPl)) (ComplN2 (resident_in_N2) (DetCN (DetQuant (IndefArt) (NumPl)) (AdjCN (PositA (major_A)) (AdjCN (PositA (western_A)) (UseN (country_N))))))) (ComplSlash (SlashV2a (have_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (SentCN (UseN (right_N)) (EmbedVP (AdvVP (UseV (live_V)) (PrepNP (in_Prep) (UsePN (europe_PN))))))))))));
lin s_069_4_h = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (DetQuant (DefArt) (NumPl)) (ComplN2 (resident_in_N2) (DetCN (DetQuant (IndefArt) (NumPl)) (AdjCN (PositA (major_A)) (AdjCN (PositA (western_A)) (UseN (country_N))))))) (ComplSlash (SlashV2a (have_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (SentCN (UseN (right_N)) (EmbedVP (AdvVP (UseV (live_V)) (PrepNP (in_Prep) (UsePN (europe_PN)))))))))));

lin s_070_1_p = s_022_1_p;
lin s_070_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (DetCN (anySg_Det) (AdjCN (PositA (scandinavian_A)) (UseN (delegate_N)))) (AdvVP (ComplSlash (SlashV2a (finish_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (report_N)))) (on_time_Adv))))));
lin s_070_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (someSg_Det) (AdjCN (PositA (scandinavian_A)) (UseN (delegate_N)))) (AdvVP (ComplSlash (SlashV2a (finish_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (report_N)))) (on_time_Adv)))));

lin s_071_1_p = s_023_1_p;
lin s_071_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (DetCN (anyPl_Det) (AdjCN (PositA (irish_A)) (UseN (delegate_N)))) (AdvVP (ComplSlash (SlashV2a (finish_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (survey_N)))) (on_time_Adv))))));
lin s_071_3_h = s_055_1_p;

lin s_072_1_p = s_024_1_p;
lin s_072_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (DetCN (many_Det) (AdjCN (PositA (british_A)) (UseN (delegate_N)))) (ComplSlash (Slash3V3 (obtain_from_V3) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (survey_N)))) (DetCN (DetQuant (IndefArt) (NumPl)) (AdjCN (PositA (interesting_A)) (UseN (result_N)))))))));
lin s_072_3_h = s_056_1_p;

lin s_073_1_p = s_025_1_p;
lin s_073_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (DetCN (several_Det) (AdjCN (PositA (portuguese_A)) (UseN (delegate_N)))) (AdvVP (ComplSlash (SlashV2a (get_V2)) (PPartNP (DetCN (DetQuant (DefArt) (NumPl)) (UseN (result_N))) (publish_V2))) (PrepNP (in_Prep) (DetCN (DetQuant (IndefArt) (NumPl)) (AdjCN (PositA (major_A)) (AdjCN (PositA (national_A)) (UseN (newspaper_N)))))))))));
lin s_073_3_h = s_057_1_p;

lin s_074_1_p = s_026_5_h;
lin s_074_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (PredetNP (most_Predet) (DetCN (DetQuant (IndefArt) (NumPl)) (RelCN (UseN (european_N)) (UseRCl (Present) (PPos) (RelVP (IdRP) (UseComp (CompAP (AdvAP (PositA (resident_A)) (PrepNP (outside_Prep) (UsePN (europe_PN))))))))))) (ComplVV (can_VV) (AdvVP (AdvVP (UseV (travel_V)) (PositAdvAdj (free_A))) (PrepNP (within_Prep) (UsePN (europe_PN)))))))));
lin s_074_3_h = (Sentence (UseCl (Present) (PPos) (PredVP (PredetNP (most_Predet) (DetCN (DetQuant (IndefArt) (NumPl)) (RelCN (UseN (european_N)) (UseRCl (Present) (PPos) (RelVP (IdRP) (UseComp (CompAP (AdvAP (PositA (resident_A)) (PrepNP (outside_Prep) (UsePN (europe_PN))))))))))) (ComplVV (can_VV) (AdvVP (AdvVP (UseV (travel_V)) (PositAdvAdj (free_A))) (PrepNP (within_Prep) (UsePN (europe_PN))))))));

lin s_075_1_p = s_043_1_p;
lin s_075_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (PredetNP (at_least_Predet) (DetCN (a_few_Det) (AdjCN (PositA (female_A)) (UseN (committee_member_N))))) (UseComp (CompAdv (PrepNP (from_Prep) (UsePN (scandinavia_PN)))))))));
lin s_075_3_h = (Sentence (UseCl (Present) (PPos) (PredVP (PredetNP (at_least_Predet) (DetCN (a_few_Det) (AdjCN (PositA (female_A)) (UseN (committee_member_N))))) (UseComp (CompAdv (PrepNP (from_Prep) (UsePN (scandinavia_PN))))))));

lin s_076_1_p = s_044_1_p;
lin s_076_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (DetCN (few_Det) (AdjCN (PositA (female_A)) (UseN (committee_member_N)))) (UseComp (CompAdv (PrepNP (from_Prep) (UsePN (southern_europe_PN)))))))));
lin s_076_3_h = s_060_1_p;

lin s_077_1_p = s_061_3_h;
lin s_077_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (DetCN (both_Det) (AdjCN (PositA (female_A)) (UseN (commissioner_N)))) (ComplVV (use_VV) (UseComp (CompAdv (PrepNP (in_Prep) (MassNP (UseN (business_N)))))))))));
lin s_077_3_h = s_061_1_p;

lin s_078_1_p = s_030_1_p;
lin s_078_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (DetCN (either_Det) (AdjCN (PositA (female_A)) (UseN (commissioner_N)))) (AdvVP (ComplSlash (SlashV2a (spend_V2)) (DetCN (a_lot_of_Det) (UseN (time_N)))) (at_home_Adv))))));
lin s_078_3_h = (Sentence (UseCl (Present) (PPos) (PredVP (AdvNP (DetNP (DetQuant (IndefArt) (NumSg))) (PrepNP (part_Prep) (DetCN (DetQuant (DefArt) (NumPl)) (AdjCN (PositA (female_A)) (UseN (commissioner_N)))))) (AdvVP (ComplSlash (SlashV2a (spend_V2)) (DetCN (a_lot_of_Det) (UseN (time_N)))) (at_home_Adv)))));

lin s_079_1_p = s_031_3_h;
lin s_079_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (PredetNP (at_least_Predet) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_three)))) (AdjCN (PositA (male_A)) (UseN (commissioner_N))))) (AdvVP (ComplSlash (SlashV2a (spend_V2)) (MassNP (UseN (time_N)))) (at_home_Adv))))));
lin s_079_3_h = (Sentence (UseCl (Present) (PPos) (PredVP (PredetNP (at_least_Predet) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_three)))) (AdjCN (PositA (male_A)) (UseN (commissioner_N))))) (AdvVP (ComplSlash (SlashV2a (spend_V2)) (MassNP (UseN (time_N)))) (at_home_Adv)))));

lin s_080_1_p = s_032_3_h;
lin s_080_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (PredetNP (at_most_Predet) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_ten)))) (AdjCN (PositA (female_A)) (UseN (commissioner_N))))) (AdvVP (ComplSlash (SlashV2a (spend_V2)) (MassNP (UseN (time_N)))) (at_home_Adv))))));
lin s_080_3_h = s_064_1_p;

lin s_081_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (ConjNP3 (and_Conj) (UsePN (smith_PN)) (UsePN (jones_PN)) (UsePN (anderson_PN))) (ComplSlash (SlashV2a (sign_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (contract_N)))))));
lin s_081_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (jones_PN)) (ComplSlash (SlashV2a (sign_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (contract_N))))))));
lin s_081_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (ComplSlash (SlashV2a (sign_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (contract_N)))))));

lin s_082_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (ConjNP3 (and_Conj) (UsePN (smith_PN)) (UsePN (jones_PN)) (DetCN (several_Det) (UseN (lawyer_N)))) (ComplSlash (SlashV2a (sign_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (contract_N)))))));
lin s_082_2_q = s_081_2_q;
lin s_082_3_h = s_081_3_h;

lin s_083_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (ConjNP3 (either7or_DConj) (UsePN (smith_PN)) (UsePN (jones_PN)) (UsePN (anderson_PN))) (ComplSlash (SlashV2a (sign_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (contract_N)))))));
lin s_083_2_q = s_081_2_q;
lin s_083_3_h = s_081_3_h;

lin s_084_1_p = s_083_1_p;
lin s_084_2_q = (Question (ExtAdvQS (SubjS (if_Subj) (UseCl (Past) (UncNeg) (PredVP (ConjNP2 (and_Conj) (UsePN (smith_PN)) (UsePN (anderson_PN))) (ComplSlash (SlashV2a (sign_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (contract_N))))))) (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (jones_PN)) (ComplSlash (SlashV2a (sign_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (contract_N)))))))));
lin s_084_3_h = (Sentence (ExtAdvS (SubjS (if_Subj) (UseCl (Past) (UncNeg) (PredVP (ConjNP2 (and_Conj) (UsePN (smith_PN)) (UsePN (anderson_PN))) (ComplSlash (SlashV2a (sign_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (contract_N))))))) (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (ComplSlash (SlashV2a (sign_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (contract_N))))))));

lin s_085_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (ConjNP2 (and_Conj) (PredetNP (exactly_Predet) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_two)))) (UseN (lawyer_N)))) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_three)))) (UseN (accountant_N)))) (ComplSlash (SlashV2a (sign_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (contract_N)))))));
lin s_085_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_six)))) (UseN (lawyer_N))) (ComplSlash (SlashV2a (sign_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (contract_N))))))));
lin s_085_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_six)))) (UseN (lawyer_N))) (ComplSlash (SlashV2a (sign_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (contract_N)))))));

lin s_086_1_p = s_085_1_p;
lin s_086_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_six)))) (UseN (accountant_N))) (ComplSlash (SlashV2a (sign_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (contract_N))))))));
lin s_086_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_six)))) (UseN (accountant_N))) (ComplSlash (SlashV2a (sign_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (contract_N)))))));

lin s_087_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (every_Det) (ConjCN2 (and_Conj) (UseN (representative_N)) (UseN (client_N)))) (UseComp (CompAdv (PrepNP (at_Prep) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (meeting_N)))))))));
lin s_087_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (DetCN (every_Det) (UseN (representative_N))) (UseComp (CompAdv (PrepNP (at_Prep) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (meeting_N))))))))));
lin s_087_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (every_Det) (UseN (representative_N))) (UseComp (CompAdv (PrepNP (at_Prep) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (meeting_N)))))))));

lin s_088_1_p = s_087_1_p;
lin s_088_2_q = s_087_2_q;
lin s_088_3_h = s_087_3_h;

lin s_089_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (every_Det) (ConjCN2 (or_Conj) (UseN (representative_N)) (UseN (client_N)))) (UseComp (CompAdv (PrepNP (at_Prep) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (meeting_N)))))))));
lin s_089_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (ConjNP2 (andSg_Conj) (DetCN (every_Det) (UseN (representative_N))) (DetCN (every_Det) (UseN (client_N)))) (UseComp (CompAdv (PrepNP (at_Prep) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (meeting_N))))))))));
lin s_089_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (ConjNP2 (andSg_Conj) (DetCN (every_Det) (UseN (representative_N))) (DetCN (every_Det) (UseN (client_N)))) (UseComp (CompAdv (PrepNP (at_Prep) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (meeting_N)))))))));

lin s_090_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (DetQuant (DefArt) (NumSg)) (UseN (chairman_N))) (ComplSlash (SlashV2a (read_out_V2)) (DetCN (DetQuant (DefArt) (NumPl)) (AdvCN (UseN (item_N)) (PrepNP (on_Prep) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (agenda_N))))))))));
lin s_090_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (DetCN (DetQuant (DefArt) (NumSg)) (UseN (chairman_N))) (ComplSlash (SlashV2a (read_out_V2)) (DetCN (every_Det) (AdvCN (UseN (item_N)) (PrepNP (on_Prep) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (agenda_N)))))))))));
lin s_090_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (DetQuant (DefArt) (NumSg)) (UseN (chairman_N))) (ComplSlash (SlashV2a (read_out_V2)) (DetCN (every_Det) (AdvCN (UseN (item_N)) (PrepNP (on_Prep) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (agenda_N))))))))));

lin s_091_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (DetQuant (DefArt) (NumPl)) (RelCN (UseN (person_N)) (UseRCl (Past) (PPos) (RelVP (IdRP) (UseComp (CompAdv (PrepNP (at_Prep) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (meeting_N)))))))))) (ComplSlash (SlashV2a (vote_for_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdjCN (PositA (new_A)) (UseN (chairman_N))))))));
lin s_091_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (AdvNP (UsePron (everyone_Pron)) (PrepNP (at_Prep) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (meeting_N))))) (ComplSlash (SlashV2a (vote_for_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdjCN (PositA (new_A)) (UseN (chairman_N)))))))));
lin s_091_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (AdvNP (UsePron (everyone_Pron)) (PrepNP (at_Prep) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (meeting_N))))) (ComplSlash (SlashV2a (vote_for_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdjCN (PositA (new_A)) (UseN (chairman_N))))))));

lin s_092_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (PredetNP (all_Predet) (DetCN (DetQuant (DefArt) (NumPl)) (RelCN (UseN (person_N)) (UseRCl (Past) (PPos) (RelVP (IdRP) (UseComp (CompAdv (PrepNP (at_Prep) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (meeting_N))))))))))) (ComplSlash (SlashV2a (vote_for_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdjCN (PositA (new_A)) (UseN (chairman_N))))))));
lin s_092_2_q = s_091_2_q;
lin s_092_3_h = s_091_3_h;

lin s_093_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (DetQuant (DefArt) (NumPl)) (RelCN (UseN (person_N)) (UseRCl (Past) (PPos) (RelVP (IdRP) (UseComp (CompAdv (PrepNP (at_Prep) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (meeting_N)))))))))) (AdVVP (all_AdV) (ComplSlash (SlashV2a (vote_for_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdjCN (PositA (new_A)) (UseN (chairman_N)))))))));
lin s_093_2_q = s_091_2_q;
lin s_093_3_h = s_091_3_h;

lin s_094_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (DetQuant (DefArt) (NumPl)) (ComplN2 (inhabitant_N2) (UsePN (cambridge_PN)))) (ComplSlash (SlashV2a (vote_for_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (labour_mp_N)))))));
lin s_094_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (DetCN (every_Det) (ComplN2 (inhabitant_N2) (UsePN (cambridge_PN)))) (ComplSlash (SlashV2a (vote_for_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (labour_mp_N))))))));
lin s_094_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (every_Det) (ComplN2 (inhabitant_N2) (UsePN (cambridge_PN)))) (ComplSlash (SlashV2a (vote_for_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (labour_mp_N)))))));

lin s_095_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (DetQuant (DefArt) (NumPl)) (AdjCN (PositA (ancient_A)) (UseN (greek_N)))) (UseComp (CompCN (AdjCN (PositA (noted_A)) (UseN (philosopher_N))))))));
lin s_095_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (DetCN (every_Det) (AdjCN (PositA (ancient_A)) (UseN (greek_N)))) (UseComp (CompCN (AdjCN (PositA (noted_A)) (UseN (philosopher_N)))))))));
lin s_095_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (every_Det) (AdjCN (PositA (ancient_A)) (UseN (greek_N)))) (UseComp (CompCN (AdjCN (PositA (noted_A)) (UseN (philosopher_N))))))));

lin s_096_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (DetQuant (DefArt) (NumPl)) (AdjCN (PositA (ancient_A)) (UseN (greek_N)))) (AdVVP (all_AdV) (UseComp (CompCN (AdjCN (PositA (noted_A)) (UseN (philosopher_N)))))))));
lin s_096_2_q = s_095_2_q;
lin s_096_3_h = s_095_3_h;

lin s_097_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (DetQuant (IndefArt) (NumPl)) (UseN (software_fault_N))) (AdvVP (PassV2s (blame1_V2)) (PrepNP (for_Prep) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (system_failure_N))))))));
lin s_097_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (DetCN (DetQuant (DefArt) (NumSg)) (UseN (system_failure_N))) (AdvVP (PassV2s (blame2_V2)) (PrepNP (on_Prep) (DetCN (one_or_more_Det) (UseN (software_fault_N)))))))));
lin s_097_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (DetQuant (DefArt) (NumSg)) (UseN (system_failure_N))) (AdvVP (PassV2s (blame2_V2)) (PrepNP (on_Prep) (DetCN (one_or_more_Det) (UseN (software_fault_N))))))));

lin s_098_1_p = s_097_1_p;
lin s_098_2_p = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (bug_32985_PN)) (UseComp (CompCN (AdjCN (PositA (known_A)) (UseN (software_fault_N))))))));
lin s_098_3_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (bug_32985_PN)) (AdvVP (PassV2s (blame1_V2)) (PrepNP (for_Prep) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (system_failure_N)))))))));
lin s_098_4_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (bug_32985_PN)) (AdvVP (PassV2s (blame1_V2)) (PrepNP (for_Prep) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (system_failure_N))))))));

lin s_099_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (DetQuant (IndefArt) (NumPl)) (AdvCN (UseN (client_N)) (PrepNP (at_Prep) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (demonstration_N)))))) (AdVVP (all_AdV) (UseComp (CompAP (ComplA2 (impressed_by_A2) (DetCN (DetQuant (GenNP (DetCN (DetQuant (DefArt) (NumSg)) (UseN (system_N)))) (NumSg)) (UseN (performance_N))))))))));
lin s_099_2_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (UseComp (CompCN (AdvCN (UseN (client_N)) (PrepNP (at_Prep) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (demonstration_N))))))))));
lin s_099_3_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (UseComp (CompAP (ComplA2 (impressed_by_A2) (DetCN (DetQuant (GenNP (DetCN (DetQuant (DefArt) (NumSg)) (UseN (system_N)))) (NumSg)) (UseN (performance_N))))))))));
lin s_099_4_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (UseComp (CompAP (ComplA2 (impressed_by_A2) (DetCN (DetQuant (GenNP (DetCN (DetQuant (DefArt) (NumSg)) (UseN (system_N)))) (NumSg)) (UseN (performance_N)))))))));

lin s_100_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (DetQuant (IndefArt) (NumPl)) (AdvCN (UseN (client_N)) (PrepNP (at_Prep) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (demonstration_N)))))) (UseComp (CompAP (ComplA2 (impressed_by_A2) (DetCN (DetQuant (GenNP (DetCN (DetQuant (DefArt) (NumSg)) (UseN (system_N)))) (NumSg)) (UseN (performance_N)))))))));
lin s_100_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (PredetNP (most_Predet) (DetCN (DetQuant (IndefArt) (NumPl)) (AdvCN (UseN (client_N)) (PrepNP (at_Prep) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (demonstration_N))))))) (UseComp (CompAP (ComplA2 (impressed_by_A2) (DetCN (DetQuant (GenNP (DetCN (DetQuant (DefArt) (NumSg)) (UseN (system_N)))) (NumSg)) (UseN (performance_N))))))))));
lin s_100_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (PredetNP (most_Predet) (DetCN (DetQuant (IndefArt) (NumPl)) (AdvCN (UseN (client_N)) (PrepNP (at_Prep) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (demonstration_N))))))) (UseComp (CompAP (ComplA2 (impressed_by_A2) (DetCN (DetQuant (GenNP (DetCN (DetQuant (DefArt) (NumSg)) (UseN (system_N)))) (NumSg)) (UseN (performance_N)))))))));

lin s_101_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (DetQuant (IndefArt) (NumPl)) (UseN (university_graduate_N))) (ComplSlash (SlashV2a (make8become_V2)) (DetCN (DetQuant (IndefArt) (NumPl)) (AdjCN (PositA (poor8bad_A)) (UseN (stockmarket_trader_N))))))));
lin s_101_2_p = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (smith_PN)) (UseComp (CompCN (UseN (university_graduate_N)))))));
lin s_101_3_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (UseComp (CompAP (SentAP (PositA (likely_A)) (EmbedVP (ComplSlash (SlashV2a (make8become_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdjCN (PositA (poor8bad_A)) (UseN (stock_market_trader_N)))))))))))));
lin s_101_4_h = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (smith_PN)) (UseComp (CompAP (SentAP (PositA (likely_A)) (EmbedVP (ComplSlash (SlashV2a (make8become_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdjCN (PositA (poor8bad_A)) (UseN (stock_market_trader_N))))))))))));

lin s_102_1_p = s_101_1_p;
lin s_102_2_p = s_101_2_p;
lin s_102_3_q = (Question (UseQCl (Future) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a (make8become_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdjCN (PositA (poor8bad_A)) (UseN (stock_market_trader_N)))))))));
lin s_102_4_h = (Sentence (UseCl (Future) (PPos) (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a (make8become_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdjCN (PositA (poor8bad_A)) (UseN (stock_market_trader_N))))))));

lin s_103_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (PredetNP (all_Predet) (DetCN (DetQuant (IndefArt) (NumPl)) (UseN (apcom_manager_N)))) (ComplSlash (SlashV2a (have_V2)) (DetCN (DetQuant (IndefArt) (NumPl)) (UseN (company_car_N)))))));
lin s_103_2_p = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (jones_PN)) (UseComp (CompCN (UseN (apcom_manager_N)))))));
lin s_103_3_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (UsePN (jones_PN)) (ComplSlash (SlashV2a (have_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (company_car_N))))))));
lin s_103_4_h = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (jones_PN)) (ComplSlash (SlashV2a (have_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (company_car_N)))))));

lin s_104_1_p = s_103_1_p;
lin s_104_2_p = s_103_2_p;
lin s_104_3_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (UsePN (jones_PN)) (ComplSlash (SlashV2a (have_V2)) (DetCN (DetQuant (IndefArt) (NumCard (AdNum (more_than_AdN) (NumNumeral (N_one))))) (UseN (company_car_N))))))));
lin s_104_4_h = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (jones_PN)) (ComplSlash (SlashV2a (have_V2)) (DetCN (DetQuant (IndefArt) (NumCard (AdNum (more_than_AdN) (NumNumeral (N_one))))) (UseN (company_car_N)))))));

lin s_105_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (PredetNP (just_Predet) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_one)))) (UseN (accountant_N)))) (ComplSlash (SlashV2a (attend_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (meeting_N)))))));
lin s_105_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (DetCN (DetQuant (no_Quant) (NumPl)) (UseN (accountant_N))) (ComplSlash (SlashV2a (attend_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (meeting_N))))))));
lin s_105_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (DetQuant (no_Quant) (NumPl)) (UseN (accountant_N))) (ComplSlash (SlashV2a (attend_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (meeting_N)))))));

lin s_106_1_p = s_105_1_p;
lin s_106_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (DetCN (DetQuant (no_Quant) (NumSg)) (UseN (accountant_N))) (ComplSlash (SlashV2a (attend_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (meeting_N))))))));
lin s_106_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (DetQuant (no_Quant) (NumSg)) (UseN (accountant_N))) (ComplSlash (SlashV2a (attend_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (meeting_N)))))));

lin s_107_1_p = s_105_1_p;
lin s_107_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (DetCN (anyPl_Det) (UseN (accountant_N))) (ComplSlash (SlashV2a (attend_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (meeting_N))))))));
lin s_107_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (somePl_Det) (UseN (accountant_N))) (ComplSlash (SlashV2a (attend_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (meeting_N)))))));

lin s_108_1_p = s_105_1_p;
lin s_108_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (DetCN (anySg_Det) (UseN (accountant_N))) (ComplSlash (SlashV2a (attend_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (meeting_N))))))));
lin s_108_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (someSg_Det) (UseN (accountant_N))) (ComplSlash (SlashV2a (attend_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (meeting_N)))))));

lin s_109_1_p = s_105_1_p;
lin s_109_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (DetCN (somePl_Det) (UseN (accountant_N))) (ComplSlash (SlashV2a (attend_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (meeting_N))))))));
lin s_109_3_h = s_107_3_h;

lin s_110_1_p = s_105_1_p;
lin s_110_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (DetCN (someSg_Det) (UseN (accountant_N))) (ComplSlash (SlashV2a (attend_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (meeting_N))))))));
lin s_110_3_h = s_108_3_h;

lin s_111_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a (sign_V2)) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_one)))) (UseN (contract_N)))))));
lin s_111_2_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (ComplSlash (SlashV2a (sign_V2)) (DetCN (another_Det) (UseN (contract_N)))))));
lin s_111_3_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (ConjNP2 (and_Conj) (UsePN (smith_PN)) (UsePN (jones_PN))) (ComplSlash (SlashV2a (sign_V2)) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_two)))) (UseN (contract_N))))))));
lin s_111_4_h = (Sentence (UseCl (Past) (PPos) (PredVP (ConjNP2 (and_Conj) (UsePN (smith_PN)) (UsePN (jones_PN))) (ComplSlash (SlashV2a (sign_V2)) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_two)))) (UseN (contract_N)))))));

lin s_112_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a (sign_V2)) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_two)))) (UseN (contract_N)))))));
lin s_112_2_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (ComplSlash (SlashV2a (sign_V2)) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_two)))) (UseN (contract_N)))))));
lin s_112_3_q = s_111_3_q;
lin s_112_4_h = s_111_4_h;

lin s_113_1_p = s_112_1_p;
lin s_113_2_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (AdVVP (also_AdV) (ComplSlash (SlashV2a (sign_V2)) (UsePron (they_Pron)))))));
lin s_113_3_q = s_111_3_q;
lin s_113_4_h = s_111_4_h;

lin s_114_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (mary_PN)) (ComplSlash (SlashV2a (use_V2)) (DetCN (DetQuant (PossPron (sheRefl_Pron)) (NumSg)) (UseN (workstation_N)))))));
lin s_114_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (DetCN (DetQuant (GenNP (UsePN (mary_PN))) (NumSg)) (UseN (workstation_N))) (PassV2s (use_V2))))));
lin s_114_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (DetQuant (GenNP (UsePN (mary_PN))) (NumSg)) (UseN (workstation_N))) (PassV2s (use_V2)))));

lin s_115_1_p = s_114_1_p;
lin s_115_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (UsePN (mary_PN)) (ComplSlash (SlashV2a (have_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (workstation_N))))))));
lin s_115_3_h = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (mary_PN)) (ComplSlash (SlashV2a (have_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (workstation_N)))))));

lin s_116_1_p = s_114_1_p;
lin s_116_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (UsePN (mary_PN)) (UseComp (CompAP (PositA (female_A))))))));
lin s_116_3_h = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (mary_PN)) (UseComp (CompAP (PositA (female_A)))))));

lin s_117_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (every_Det) (UseN (student_N))) (ComplSlash (SlashV2a (use_V2)) (DetCN (DetQuant (PossPron (sheRefl_Pron)) (NumSg)) (UseN (workstation_N)))))));
lin s_117_2_p = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (mary_PN)) (UseComp (CompCN (UseN (student_N)))))));
lin s_117_3_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (mary_PN)) (ComplSlash (SlashV2a (use_V2)) (DetCN (DetQuant (PossPron (sheRefl_Pron)) (NumSg)) (UseN (workstation_N))))))));
lin s_117_4_h = s_114_1_p;

lin s_118_1_p = s_117_1_p;
lin s_118_2_p = s_117_2_p;
lin s_118_3_q = s_115_2_q;
lin s_118_4_h = s_115_3_h;

lin s_119_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (DetQuant (no_Quant) (NumSg)) (UseN (student_N))) (ComplSlash (SlashV2a (use_V2)) (DetCN (DetQuant (PossPron (sheRefl_Pron)) (NumSg)) (UseN (workstation_N)))))));
lin s_119_2_p = s_117_2_p;
lin s_119_3_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (mary_PN)) (ComplSlash (SlashV2a (use_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (workstation_N))))))));
lin s_119_4_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (mary_PN)) (ComplSlash (SlashV2a (use_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (workstation_N)))))));

lin s_120_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a (attend_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (meeting_N)))))));
lin s_120_2_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePron (she_Pron)) (ComplSlash (SlashV2a (chair_V2)) (UsePron (it_Pron))))));
lin s_120_3_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a (chair_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (meeting_N))))))));
lin s_120_4_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a (chair_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (meeting_N)))))));

lin s_121_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a (deliver_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (report_N)))) (PrepNP (to_Prep) (UsePN (itel_PN)))))));
lin s_121_2_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePron (she_Pron)) (AdVVP (also_AdV) (ComplSlash (Slash2V3 (deliver_V3) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (invoice_N)))) (UsePron (they_Pron)))))));
lin s_121_3_p = (PSentence (and_PConj) (UseCl (Past) (PPos) (PredVP (UsePron (she_Pron)) (ComplSlash (Slash2V3 (deliver_V3) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (project_proposal_N)))) (UsePron (they_Pron))))));
lin s_121_4_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a (deliver_V2)) (ConjNP3 (and_Conj) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (report_N))) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (invoice_N))) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (project_proposal_N))))) (PrepNP (to_Prep) (UsePN (itel_PN))))))));
lin s_121_5_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a (deliver_V2)) (ConjNP3 (and_Conj) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (report_N))) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (invoice_N))) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (project_proposal_N))))) (PrepNP (to_Prep) (UsePN (itel_PN)))))));

lin s_122_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (every_Det) (UseN (committee_N))) (ComplSlash (SlashV2a (have_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (chairman_N)))))));
lin s_122_2_p = (Sentence (UseCl (Present) (PPos) (PredVP (UsePron (he_Pron)) (AdvVP (PassV2s (appoint_V2)) (PrepNP (by8agent_Prep) (DetCN (DetQuant (PossPron (it_Pron)) (NumPl)) (UseN (member_N))))))));
lin s_122_3_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (DetCN (every_Det) (UseN (committee_N))) (ComplSlash (SlashV2a (have_V2)) (AdvNP (PPartNP (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (chairman_N))) (appoint_V2)) (PrepNP (by8agent_Prep) (DetCN (DetQuant (IndefArt) (NumPl)) (AdvCN (UseN (member_N)) (PrepNP (possess_Prep) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (committee_N)))))))))))));
lin s_122_4_h = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (every_Det) (UseN (committee_N))) (ComplSlash (SlashV2a (have_V2)) (AdvNP (PPartNP (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (chairman_N))) (appoint_V2)) (PrepNP (by8agent_Prep) (DetCN (DetQuant (IndefArt) (NumPl)) (AdvCN (UseN (member_N)) (PrepNP (possess_Prep) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (committee_N))))))))))));

lin s_123_1_p = (Sentence (UseCl (PresentPerfect) (PPos) (PredVP (UsePN (itel_PN)) (ComplSlash (SlashV2a (send_V2)) (PredetNP (most_of_Predet) (DetCN (DetQuant (DefArt) (NumPl)) (RelCN (UseN (report_N)) (UseRCl (Present) (PPos) (EmptyRelSlash (SlashVP (UsePN (smith_PN)) (SlashV2a (need_V2))))))))))));
lin s_123_2_p = (Sentence (UseCl (Present) (PPos) (PredVP (UsePron (they_Pron)) (UseComp (CompAdv (PrepNP (on_Prep) (DetCN (DetQuant (PossPron (she_Pron)) (NumSg)) (UseN (desk_N)))))))));
lin s_123_3_q = (Question (UseQCl (Present) (PPos) (QuestCl (ExistNP (AdvNP (DetCN (somePl_Det) (AdvCN (UseN (report_N)) (PrepNP (from_Prep) (UsePN (itel_PN))))) (PrepNP (on_Prep) (DetCN (DetQuant (GenNP (UsePN (smith_PN))) (NumSg)) (UseN (desk_N)))))))));
lin s_123_4_h = (Sentence (UseCl (Present) (PPos) (ExistNP (AdvNP (DetCN (somePl_Det) (AdvCN (UseN (report_N)) (PrepNP (from_Prep) (UsePN (itel_PN))))) (PrepNP (on_Prep) (DetCN (DetQuant (GenNP (UsePN (smith_PN))) (NumSg)) (UseN (desk_N))))))));

lin s_124_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (AdvNP (DetNP (DetQuant (IndefArt) (NumCard (NumNumeral (N_two))))) (PrepNP (out_of_Prep) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_ten)))) (UseN (machine_N))))) (UseComp (CompAP (PositA (missing_A)))))));
lin s_124_2_p = (Sentence (UseCl (PresentPerfect) (PPos) (PredVP (UsePron (they_Pron)) (PassV2s (remove_V2)))));
lin s_124_3_q = (Question (UseQCl (PresentPerfect) (PPos) (QuestCl (PredVP (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_two)))) (UseN (machine_N))) (PassV2s (remove_V2))))));
lin s_124_4_h = (Sentence (UseCl (PresentPerfect) (PPos) (PredVP (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_two)))) (UseN (machine_N))) (PassV2s (remove_V2)))));

lin s_125_1_p = s_124_1_p;
lin s_125_2_p = s_124_2_p;
lin s_125_3_q = (Question (UseQCl (PresentPerfect) (PPos) (QuestCl (PredVP (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_eight)))) (UseN (machine_N))) (PassV2s (remove_V2))))));
lin s_125_4_h = (Sentence (UseCl (PresentPerfect) (PPos) (PredVP (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_eight)))) (UseN (machine_N))) (PassV2s (remove_V2)))));

lin s_126_1_p = s_124_1_p;
lin s_126_2_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePron (they_Pron)) (AdvVP (AdVVP (all_AdV) (UseComp (CompAdv (here_Adv)))) (yesterday_Adv)))));
lin s_126_3_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_ten)))) (UseN (machine_N))) (AdvVP (UseComp (CompAdv (here_Adv))) (yesterday_Adv))))));
lin s_126_4_h = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_ten)))) (UseN (machine_N))) (AdvVP (UseComp (CompAdv (here_Adv))) (yesterday_Adv)))));

lin s_127_1_p = (Sentence (ConjS2 (comma_and_Conj) (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a (take_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (machine_N)))) (on_tuesday_Adv)))) (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (AdvVP (ComplSlash (SlashV2a (take_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (machine_N)))) (on_wednesday_Adv))))));
lin s_127_2_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePron (they_Pron)) (ComplSlash (Slash3V3 (put_in_V3) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (lobby_N)))) (UsePron (they_Pron))))));
lin s_127_3_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (ConjNP2 (and_Conj) (UsePN (smith_PN)) (UsePN (jones_PN))) (ComplSlash (Slash3V3 (put_in_V3) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (lobby_N)))) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_two)))) (UseN (machine_N))))))));
lin s_127_4_h = (Sentence (UseCl (Past) (PPos) (PredVP (ConjNP2 (and_Conj) (UsePN (smith_PN)) (UsePN (jones_PN))) (ComplSlash (Slash3V3 (put_in_V3) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (lobby_N)))) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_two)))) (UseN (machine_N)))))));

lin s_128_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (ConjNP2 (and_Conj) (UsePN (john_PN)) (DetCN (DetQuant (PossPron (he_Pron)) (NumPl)) (UseN (colleague_N)))) (AdvVP (UseV (go8walk_V)) (PrepNP (to_Prep) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (meeting_N))))))));
lin s_128_2_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePron (they_Pron)) (ComplSlash (SlashV2a (hate_V2)) (UsePron (it_Pron))))));
lin s_128_3_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (DetCN (DetQuant (GenNP (UsePN (john_PN))) (NumPl)) (UseN (colleague_N))) (ComplSlash (SlashV2a (hate_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (meeting_N))))))));
lin s_128_4_h = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (DetQuant (GenNP (UsePN (john_PN))) (NumPl)) (UseN (colleague_N))) (ComplSlash (SlashV2a (hate_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (meeting_N)))))));

lin s_129_1_p = s_128_1_p;
lin s_129_2_p = s_128_2_p;
lin s_129_3_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (john_PN)) (ComplSlash (SlashV2a (hate_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (meeting_N))))))));
lin s_129_4_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (john_PN)) (ComplSlash (SlashV2a (hate_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (meeting_N)))))));

lin s_130_1_p = s_128_1_p;
lin s_130_2_p = s_128_2_p;
lin s_130_3_q = s_129_3_q;
lin s_130_4_h = s_129_4_h;

lin s_131_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (each_Det) (UseN (department_N))) (ComplSlash (SlashV2a (have_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdjCN (PositA (dedicated_A)) (UseN (line_N))))))));
lin s_131_2_p = (Sentence (UseCl (Present) (PPos) (PredVP (UsePron (they_Pron)) (ComplSlash (Slash3V3 (rent_from_V3) (UsePN (bt_PN))) (UsePron (they_Pron))))));
lin s_131_3_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (DetCN (every_Det) (UseN (department_N))) (ComplSlash (Slash3V3 (rent_from_V3) (UsePN (bt_PN))) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (line_N))))))));
lin s_131_4_h = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (every_Det) (UseN (department_N))) (ComplSlash (Slash3V3 (rent_from_V3) (UsePN (bt_PN))) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (line_N)))))));

lin s_132_1_p = s_131_1_p;
lin s_132_2_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (DetQuant (DefArt) (NumSg)) (UseN (sales_department_N))) (ComplSlash (Slash3V3 (rent_from_V3) (UsePN (bt_PN))) (UsePron (it_Pron))))));
lin s_132_3_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (DetCN (DetQuant (DefArt) (NumSg)) (UseN (sales_department_N))) (ComplSlash (Slash3V3 (rent_from_V3) (UsePN (bt_PN))) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (line_N))))))));
lin s_132_4_h = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (DetQuant (DefArt) (NumSg)) (UseN (sales_department_N))) (ComplSlash (Slash3V3 (rent_from_V3) (UsePN (bt_PN))) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (line_N)))))));

lin s_133_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (gfi_PN)) (ComplSlash (SlashV2a (own_V2)) (DetCN (several_Det) (UseN (computer_N)))))));
lin s_133_2_p = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (itel_PN)) (ComplSlash (SlashV2a (maintain_V2)) (UsePron (they_Pron))))));
lin s_133_3_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (UsePN (itel_PN)) (ComplSlash (SlashV2a (maintain_V2)) (PredetNP (all_Predet) (DetCN (DetQuant (DefArt) (NumPl)) (RelCN (UseN (computer_N)) (UseRCl (Present) (PPos) (RelSlash (that_RP) (SlashVP (UsePN (gfi_PN)) (SlashV2a (own_V2)))))))))))));
lin s_133_4_h = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (itel_PN)) (ComplSlash (SlashV2a (maintain_V2)) (PredetNP (all_Predet) (DetCN (DetQuant (DefArt) (NumPl)) (RelCN (UseN (computer_N)) (UseRCl (Present) (PPos) (RelSlash (that_RP) (SlashVP (UsePN (gfi_PN)) (SlashV2a (own_V2))))))))))));

lin s_134_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (every_Det) (RelCN (UseN (customer_N)) (UseRCl (Present) (PPos) (RelVP (IdRP) (ComplSlash (SlashV2a (own_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (computer_N)))))))) (AdvVP (ComplSlash (SlashV2a (have_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (service_contract_N)))) (PrepNP (for_Prep) (UsePron (it_Pron)))))));
lin s_134_2_p = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (mfi_PN)) (UseComp (CompCN (RelCN (UseN (customer_N)) (UseRCl (Present) (PPos) (RelVP (that_RP) (ComplSlash (SlashV2a (own_V2)) (PredetNP (exactly_Predet) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_one)))) (UseN (computer_N)))))))))))));
lin s_134_3_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (UsePN (mfi_PN)) (AdvVP (ComplSlash (SlashV2a (have_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (service_contract_N)))) (PrepNP (for_Prep) (PredetNP (all_Predet) (DetCN (DetQuant (PossPron (itRefl_Pron)) (NumPl)) (UseN (computer_N))))))))));
lin s_134_4_h = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (mfi_PN)) (AdvVP (ComplSlash (SlashV2a (have_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (service_contract_N)))) (PrepNP (for_Prep) (PredetNP (all_Predet) (DetCN (DetQuant (PossPron (itRefl_Pron)) (NumPl)) (UseN (computer_N)))))))));

lin s_135_1_p = s_134_1_p;
lin s_135_2_p = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (mfi_PN)) (UseComp (CompCN (RelCN (UseN (customer_N)) (UseRCl (Present) (PPos) (RelVP (that_RP) (ComplSlash (SlashV2a (own_V2)) (DetCN (several_Det) (UseN (computer_N))))))))))));
lin s_135_3_q = s_134_3_q;
lin s_135_4_h = s_134_4_h;

lin s_136_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (every_Det) (RelCN (UseN (executive_N)) (UseRCl (Past) (PPos) (RelVP (IdRP) (ComplSlash (SlashV2a (have_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (laptop_computer_N)))))))) (ComplSlash (SlashV2V (bring_V2V) (AdvVP (ComplSlash (SlashV2a (take_V2)) (DetCN (DetQuant (IndefArt) (NumPl)) (UseN (note_N)))) (PrepNP (at_Prep) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (meeting_N)))))) (UsePron (it_Pron))))));
lin s_136_2_p = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (smith_PN)) (UseComp (CompCN (RelCN (UseN (executive_N)) (UseRCl (Present) (PPos) (RelVP (IdRP) (ComplSlash (SlashV2a (own_V2)) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_five)))) (AdjCN (PositA (different_A)) (UseN (laptop_computer_N)))))))))))));
lin s_136_3_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a (take_V2)) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_five)))) (UseN (laptop_computer_N)))) (PrepNP (to_Prep) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (meeting_N)))))))));
lin s_136_4_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a (take_V2)) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_five)))) (UseN (laptop_computer_N)))) (PrepNP (to_Prep) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (meeting_N))))))));

lin s_137_1_p = (Sentence (UseCl (Present) (PPos) (ExistNP (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_100)))) (UseN (company_N))))));
lin s_137_2_p = (Sentence (PredVPS (UsePN (icm_PN)) (ConjVPS2 (and_Conj) (Present) (PPos) (UseComp (CompNP (AdvNP (DetNP (DetQuant (IndefArt) (NumCard (NumNumeral (N_one))))) (PrepNP (part_Prep) (DetCN (DetQuant (DefArt) (NumPl)) (UseN (company_N))))))) (Present) (PPos) (ComplSlash (SlashV2a (own_V2)) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_150)))) (UseN (computer_N)))))));
lin s_137_3_p = (Sentence (UseCl (Present) (UncNeg) (PredVP (UsePron (it_Pron)) (AdvVP (ComplSlash (SlashV2a (have_V2)) (DetCN (DetQuant (IndefArt) (NumPl)) (UseN (service_contract_N)))) (PrepNP (for_Prep) (AdvNP (DetNP (anySg_Det)) (PrepNP (part_Prep) (DetCN (DetQuant (PossPron (itRefl_Pron)) (NumPl)) (UseN (computer_N))))))))));
lin s_137_4_p = (Sentence (UseCl (Present) (PPos) (PredVP (AdvNP (DetNP (each_Det)) (PrepNP (part_Prep) (DetCN (DetQuant (the_other_Q) (NumCard (NumNumeral (N_99)))) (UseN (company_N))))) (ComplSlash (SlashV2a (own_V2)) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_one)))) (UseN (computer_N)))))));
lin s_137_5_p = (Sentence (UseCl (Present) (PPos) (PredVP (UsePron (they_Pron)) (AdvVP (ComplSlash (SlashV2a (have_V2)) (DetCN (DetQuant (IndefArt) (NumPl)) (UseN (service_contract_N)))) (PrepNP (for_Prep) (UsePron (they_Pron)))))));
lin s_137_6_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (PredetNP (most_Predet) (DetCN (DetQuant (IndefArt) (NumPl)) (RelCN (UseN (company_N)) (UseRCl (Present) (PPos) (RelVP (that_RP) (ComplSlash (SlashV2a (own_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (computer_N))))))))) (AdvVP (ComplSlash (SlashV2a (have_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (service_contract_N)))) (PrepNP (for_Prep) (UsePron (it_Pron))))))));
lin s_137_7_h = (Sentence (UseCl (Present) (PPos) (PredVP (PredetNP (most_Predet) (DetCN (DetQuant (IndefArt) (NumPl)) (RelCN (UseN (company_N)) (UseRCl (Present) (PPos) (RelVP (that_RP) (ComplSlash (SlashV2a (own_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (computer_N))))))))) (AdvVP (ComplSlash (SlashV2a (have_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (service_contract_N)))) (PrepNP (for_Prep) (UsePron (it_Pron)))))));

lin s_138_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (every_Det) (UseN (report_N))) (ComplSlash (SlashV2a (have_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (cover_page_N)))))));
lin s_138_2_p = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (r95103_PN)) (UseComp (CompCN (UseN (report_N)))))));
lin s_138_3_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a (sign_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (cover_page_N)))))));
lin s_138_4_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a (sign_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (AdvCN (UseN (cover_page_N)) (PrepNP (possess_Prep) (UsePN (r95103_PN))))))))));
lin s_138_5_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a (sign_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (AdvCN (UseN (cover_page_N)) (PrepNP (possess_Prep) (UsePN (r95103_PN)))))))));

lin s_139_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (company_director_N))) (ReflVP (Slash3V3 (award_V3) (DetCN (DetQuant (IndefArt) (NumSg)) (AdjCN (PositA (large_A)) (UseN (payrise_N)))))))));
lin s_139_2_q = (Question (UseQCl (PresentPerfect) (PPos) (QuestCl (PredVP (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (company_director_N))) (ComplSlash (SlashV2a (award_and_be_awarded_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (payrise_N))))))));
lin s_139_3_h = (Sentence (UseCl (PresentPerfect) (PPos) (PredVP (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (company_director_N))) (ComplSlash (SlashV2a (award_and_be_awarded_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (payrise_N)))))));

lin s_140_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (john_PN)) (ComplVSa (say_VS) (UseCl (PastPerfect) (PPos) (PredVP (UsePN (bill_PN)) (ReflVP (SlashV2a (hurt_V2)))))))));
lin s_140_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (john_PN)) (ComplVSa (say_VS) (UseCl (PastPerfect) (PPos) (PredVP (UsePN (bill_PN)) (PassV2s (hurt_V2)))))))));
lin s_140_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (john_PN)) (ComplVSa (say_VS) (UseCl (PastPerfect) (PPos) (PredVP (UsePN (bill_PN)) (PassV2s (hurt_V2))))))));

lin s_141_1_p = s_140_1_p;
lin s_141_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePron (anyone_Pron)) (ComplVSa (say_VS) (UseCl (PastPerfect) (PPos) (PredVP (UsePN (john_PN)) (PassV2s (hurt_V2)))))))));
lin s_141_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePron (someone_Pron)) (ComplVSa (say_VS) (UseCl (PastPerfect) (PPos) (PredVP (UsePN (john_PN)) (PassV2s (hurt_V2))))))));

lin s_142_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (john_PN)) (ComplSlash (SlashV2a (speak_to_V2)) (UsePN (mary_PN))))));
lin s_142_2_p = (Sentence (UseCl (Past) (PPos) (SoDoI (UsePN (bill_PN)))));
lin s_142_3_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (bill_PN)) (ComplSlash (SlashV2a (speak_to_V2)) (UsePN (mary_PN)))))));
lin s_142_4_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (bill_PN)) (ComplSlash (SlashV2a (speak_to_V2)) (UsePN (mary_PN))))));

lin s_143_1_p = s_142_1_p;
lin s_143_2_p = s_142_2_p;
lin s_143_3_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (john_PN)) (AdvVP (ComplSlash (SlashV2a (speak_to_V2)) (UsePN (mary_PN))) (at_four_oclock_Adv)))));
lin s_143_4_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (bill_PN)) (AdvVP (ComplSlash (SlashV2a (speak_to_V2)) (UsePN (mary_PN))) (at_four_oclock_Adv))))));
lin s_143_5_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (bill_PN)) (AdvVP (ComplSlash (SlashV2a (speak_to_V2)) (UsePN (mary_PN))) (at_four_oclock_Adv)))));

lin s_144_1_p = s_143_3_p;
lin s_144_2_p = s_142_2_p;
lin s_144_3_q = s_143_4_q;
lin s_144_4_h = s_143_5_h;

lin s_145_1_p = s_143_3_p;
lin s_145_2_p = (PSentence (and_PConj) (UseCl (Past) (PPos) (PredVP (UsePN (bill_PN)) (AdvVP (ComplVV (do_VV) (elliptic_VP)) (at_five_oclock_Adv)))));
lin s_145_3_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (bill_PN)) (AdvVP (ComplSlash (SlashV2a (speak_to_V2)) (UsePN (mary_PN))) (at_five_oclock_Adv))))));
lin s_145_4_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (bill_PN)) (AdvVP (ComplSlash (SlashV2a (speak_to_V2)) (UsePN (mary_PN))) (at_five_oclock_Adv)))));

lin s_146_1_p = (Sentence (UseCl (PresentPerfect) (PPos) (PredVP (UsePN (john_PN)) (ComplSlash (SlashV2a (speak_to_V2)) (UsePN (mary_PN))))));
lin s_146_2_p = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (bill_PN)) (ProgrVPa (ComplVV (going_to_VV) (elliptic_VP))))));
lin s_146_3_q = (Question (UseQCl (Future) (PPos) (QuestCl (PredVP (UsePN (bill_PN)) (ComplSlash (SlashV2a (speak_to_V2)) (UsePN (mary_PN)))))));
lin s_146_4_h = (Sentence (UseCl (Future) (PPos) (PredVP (UsePN (bill_PN)) (ComplSlash (SlashV2a (speak_to_V2)) (UsePN (mary_PN))))));

lin s_147_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (john_PN)) (AdvVP (ComplSlash (SlashV2a (speak_to_V2)) (UsePN (mary_PN))) (on_monday_Adv)))));
lin s_147_2_p = (Sentence (UseCl (Past) (PNeg) (PredVP (UsePN (bill_PN)) (elliptic_VP))));
lin s_147_3_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (bill_PN)) (AdvVP (ComplSlash (SlashV2a (speak_to_V2)) (UsePN (mary_PN))) (on_monday_Adv))))));
lin s_147_4_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (bill_PN)) (AdvVP (ComplSlash (SlashV2a (speak_to_V2)) (UsePN (mary_PN))) (on_monday_Adv)))));

lin s_148_1_p = (Question (UseQCl (PresentPerfect) (PPos) (QuestCl (PredVP (UsePN (john_PN)) (ComplSlash (SlashV2a (speak_to_V2)) (UsePN (mary_PN)))))));
lin s_148_2_p = (Sentence (UseCl (PresentPerfect) (PPos) (PredVP (UsePN (bill_PN)) (elliptic_VP))));
lin s_148_3_q = (Question (UseQCl (PresentPerfect) (PPos) (QuestCl (PredVP (UsePN (bill_PN)) (ComplSlash (SlashV2a (speak_to_V2)) (UsePN (mary_PN)))))));
lin s_148_4_h = (Sentence (UseCl (PresentPerfect) (PPos) (PredVP (UsePN (bill_PN)) (ComplSlash (SlashV2a (speak_to_V2)) (UsePN (mary_PN))))));

lin s_149_1_p = s_146_1_p;
lin s_149_2_p = (Sentence (UseCl (PresentPerfect) (PPos) (PredVP (DetCN (DetQuant (DefArt) (NumPl)) (UseN (student_N))) (AdvVP (elliptic_VP) (too_Adv)))));
lin s_149_3_q = (Question (UseQCl (PresentPerfect) (PPos) (QuestCl (PredVP (DetCN (DetQuant (DefArt) (NumPl)) (UseN (student_N))) (ComplSlash (SlashV2a (speak_to_V2)) (UsePN (mary_PN)))))));
lin s_149_4_h = (Sentence (UseCl (PresentPerfect) (PPos) (PredVP (DetCN (DetQuant (DefArt) (NumPl)) (UseN (student_N))) (ComplSlash (SlashV2a (speak_to_V2)) (UsePN (mary_PN))))));

lin s_150_1_p = (Sentence (ConjS2 (comma_and_Conj) (UseCl (Past) (PPos) (PredVP (UsePN (john_PN)) (AdvVP (AdvVP (UseV (go8travel_V)) (PrepNP (to_Prep) (UsePN (paris_PN)))) (PrepNP (by8means_Prep) (MassNP (UseN (car_N))))))) (UseCl (Past) (PPos) (PredVP (UsePN (bill_PN)) (AdvVP (elliptic_VP) (PrepNP (by8means_Prep) (MassNP (UseN (train_N)))))))));
lin s_150_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (bill_PN)) (AdvVP (AdvVP (UseV (go8travel_V)) (PrepNP (to_Prep) (UsePN (paris_PN)))) (PrepNP (by8means_Prep) (MassNP (UseN (train_N)))))))));
lin s_150_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (bill_PN)) (AdvVP (AdvVP (UseV (go8travel_V)) (PrepNP (to_Prep) (UsePN (paris_PN)))) (PrepNP (by8means_Prep) (MassNP (UseN (train_N))))))));

lin s_151_1_p = (Sentence (ConjS2 (comma_and_Conj) (UseCl (Past) (PPos) (PredVP (UsePN (john_PN)) (AdvVP (AdvVP (UseV (go8travel_V)) (PrepNP (to_Prep) (UsePN (paris_PN)))) (PrepNP (by8means_Prep) (MassNP (UseN (car_N))))))) (UseCl (Past) (PPos) (PredVP (UsePN (bill_PN)) (AdvVP (AdvVP (elliptic_VP) (PrepNP (by8means_Prep) (MassNP (UseN (train_N))))) (PrepNP (to_Prep) (UsePN (berlin_PN))))))));
lin s_151_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (bill_PN)) (AdvVP (AdvVP (UseV (go8travel_V)) (PrepNP (to_Prep) (UsePN (berlin_PN)))) (PrepNP (by8means_Prep) (MassNP (UseN (train_N)))))))));
lin s_151_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (bill_PN)) (AdvVP (AdvVP (UseV (go8travel_V)) (PrepNP (to_Prep) (UsePN (berlin_PN)))) (PrepNP (by8means_Prep) (MassNP (UseN (train_N))))))));

lin s_152_1_p = (Sentence (ConjS2 (comma_and_Conj) (UseCl (Past) (PPos) (PredVP (UsePN (john_PN)) (AdvVP (AdvVP (UseV (go8travel_V)) (PrepNP (to_Prep) (UsePN (paris_PN)))) (PrepNP (by8means_Prep) (MassNP (UseN (car_N))))))) (UseCl (Past) (PPos) (PredVP (UsePN (bill_PN)) (AdvVP (elliptic_VP) (PrepNP (to_Prep) (UsePN (berlin_PN))))))));
lin s_152_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (bill_PN)) (AdvVP (AdvVP (UseV (go8travel_V)) (PrepNP (to_Prep) (UsePN (berlin_PN)))) (PrepNP (by8means_Prep) (MassNP (UseN (car_N)))))))));
lin s_152_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (bill_PN)) (AdvVP (AdvVP (UseV (go8travel_V)) (PrepNP (to_Prep) (UsePN (berlin_PN)))) (PrepNP (by8means_Prep) (MassNP (UseN (car_N))))))));

lin s_153_1_p = (Sentence (ConjS2 (comma_and_Conj) (UseCl (Present) (PPos) (PredVP (UsePN (john_PN)) (AdvVP (AdvVP (ProgrVPa (UseV (go8travel_V))) (PrepNP (to_Prep) (UsePN (paris_PN)))) (PrepNP (by8means_Prep) (MassNP (UseN (car_N))))))) (UseCl (Present) (PPos) (PredVP (DetCN (DetQuant (DefArt) (NumPl)) (UseN (student_N))) (AdvVP (elliptic_VP) (PrepNP (by8means_Prep) (MassNP (UseN (train_N)))))))));
lin s_153_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (DetCN (DetQuant (DefArt) (NumPl)) (UseN (student_N))) (AdvVP (AdvVP (ProgrVPa (UseV (go8travel_V))) (PrepNP (to_Prep) (UsePN (paris_PN)))) (PrepNP (by8means_Prep) (MassNP (UseN (train_N)))))))));
lin s_153_3_h = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (DetQuant (DefArt) (NumPl)) (UseN (student_N))) (AdvVP (AdvVP (ProgrVPa (UseV (go8travel_V))) (PrepNP (to_Prep) (UsePN (paris_PN)))) (PrepNP (by8means_Prep) (MassNP (UseN (train_N))))))));

lin s_154_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (john_PN)) (AdvVP (AdvVP (UseV (go8travel_V)) (PrepNP (to_Prep) (UsePN (paris_PN)))) (PrepNP (by8means_Prep) (MassNP (UseN (car_N))))))));
lin s_154_2_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (bill_PN)) (AdvVP (elliptic_VP) (PrepNP (by8means_Prep) (MassNP (UseN (train_N))))))));
lin s_154_3_q = s_150_2_q;
lin s_154_4_h = s_150_3_h;

lin s_155_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (john_PN)) (ComplSlash (SlashV2a (own_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (car_N)))))));
lin s_155_2_p = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (bill_PN)) (AdvVP (ComplSlash (SlashV2a (own_V2)) (DetNP (DetQuant (IndefArt) (NumSg)))) (too_Adv)))));
lin s_155_3_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (UsePN (bill_PN)) (ComplSlash (SlashV2a (own_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (car_N))))))));
lin s_155_4_h = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (bill_PN)) (ComplSlash (SlashV2a (own_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (car_N)))))));

lin s_156_1_p = s_155_1_p;
lin s_156_2_p = s_155_2_p;
lin s_156_3_q = (Question (UseQCl (Present) (PPos) (QuestCl (ExistNP (DetCN (DetQuant (IndefArt) (NumSg)) (RelCN (UseN (car_N)) (UseRCl (Present) (PPos) (RelSlash (that_RP) (SlashVP (ConjNP2 (and_Conj) (UsePN (john_PN)) (UsePN (bill_PN))) (SlashV2a (own_V2)))))))))));
lin s_156_4_h = (Sentence (UseCl (Present) (PPos) (ExistNP (DetCN (DetQuant (IndefArt) (NumSg)) (RelCN (UseN (car_N)) (UseRCl (Present) (PPos) (RelSlash (that_RP) (SlashVP (ConjNP2 (and_Conj) (UsePN (john_PN)) (UsePN (bill_PN))) (SlashV2a (own_V2))))))))));

lin s_157_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (john_PN)) (ComplSlash (SlashV2a (own_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdjCN (PositA (red_A)) (UseN (car_N))))))));
lin s_157_2_p = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (bill_PN)) (ComplSlash (SlashV2a (own_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdjCN (PositA (blue_A)) (UseN (one_N))))))));
lin s_157_3_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (UsePN (bill_PN)) (ComplSlash (SlashV2a (own_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdjCN (PositA (blue_A)) (UseN (car_N)))))))));
lin s_157_4_h = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (bill_PN)) (ComplSlash (SlashV2a (own_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdjCN (PositA (blue_A)) (UseN (car_N))))))));

lin s_158_1_p = s_157_1_p;
lin s_158_2_p = s_157_2_p;
lin s_158_3_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (UsePN (bill_PN)) (ComplSlash (SlashV2a (own_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdjCN (PositA (red_A)) (UseN (car_N)))))))));
lin s_158_4_h = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (bill_PN)) (ComplSlash (SlashV2a (own_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdjCN (PositA (red_A)) (UseN (car_N))))))));

lin s_159_1_p = s_157_1_p;
lin s_159_2_p = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (bill_PN)) (ComplSlash (SlashV2a (own_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdjCN (PositA (fast_A)) (UseN (one_N))))))));
lin s_159_3_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (UsePN (bill_PN)) (ComplSlash (SlashV2a (own_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdjCN (PositA (fast_A)) (UseN (car_N)))))))));
lin s_159_4_h = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (bill_PN)) (ComplSlash (SlashV2a (own_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdjCN (PositA (fast_A)) (UseN (car_N))))))));

lin s_160_1_p = s_157_1_p;
lin s_160_2_p = s_159_2_p;
lin s_160_3_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (UsePN (bill_PN)) (ComplSlash (SlashV2a (own_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdjCN (PositA (fast_A)) (AdjCN (PositA (red_A)) (UseN (car_N))))))))));
lin s_160_4_h = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (bill_PN)) (ComplSlash (SlashV2a (own_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdjCN (PositA (fast_A)) (AdjCN (PositA (red_A)) (UseN (car_N)))))))));

lin s_161_1_p = s_157_1_p;
lin s_161_2_p = s_159_2_p;
lin s_161_3_q = s_160_3_q;
lin s_161_4_h = s_160_4_h;

lin s_162_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (john_PN)) (ComplSlash (SlashV2a (own_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdjCN (PositA (fast_A)) (AdjCN (PositA (red_A)) (UseN (car_N)))))))));
lin s_162_2_p = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (bill_PN)) (ComplSlash (SlashV2a (own_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdjCN (PositA (slow_A)) (UseN (one_N))))))));
lin s_162_3_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (UsePN (bill_PN)) (ComplSlash (SlashV2a (own_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdjCN (PositA (slow_A)) (AdjCN (PositA (red_A)) (UseN (car_N))))))))));
lin s_162_4_h = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (bill_PN)) (ComplSlash (SlashV2a (own_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdjCN (PositA (slow_A)) (AdjCN (PositA (red_A)) (UseN (car_N)))))))));

lin s_163_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (john_PN)) (ComplSlash (SlashV2a (have_V2)) (PPartNP (DetCN (DetQuant (PossPron (heRefl_Pron)) (NumSg)) (UseN (paper_N))) (accept_V2))))));
lin s_163_2_p = (Sentence (UseCl (Present) (PNeg) (PredVP (UsePN (bill_PN)) (ComplVQ (know_VQ) (UseQCl (Past) (PPos) (QuestIAdv (why_IAdv) (elliptic_Cl)))))));
lin s_163_3_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (UsePN (bill_PN)) (ComplVQ (know_VQ) (UseQCl (Past) (PPos) (QuestIAdv (why_IAdv) (PredVP (UsePN (john_PN)) (ComplSlash (SlashV2a (have_V2)) (PPartNP (DetCN (DetQuant (PossPron (heRefl_Pron)) (NumSg)) (UseN (paper_N))) (accept_V2)))))))))));
lin s_163_4_h = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (bill_PN)) (ComplVQ (know_VQ) (UseQCl (Past) (PPos) (QuestIAdv (why_IAdv) (PredVP (UsePN (john_PN)) (ComplSlash (SlashV2a (have_V2)) (PPartNP (DetCN (DetQuant (PossPron (heRefl_Pron)) (NumSg)) (UseN (paper_N))) (accept_V2))))))))));

lin s_164_1_p = s_142_1_p;
lin s_164_2_p = (PAdverbial (and_PConj) (PrepNP (to_Prep) (UsePN (sue_PN))));
lin s_164_3_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (john_PN)) (ComplSlash (SlashV2a (speak_to_V2)) (UsePN (sue_PN)))))));
lin s_164_4_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (john_PN)) (ComplSlash (SlashV2a (speak_to_V2)) (UsePN (sue_PN))))));

lin s_165_1_p = s_142_1_p;
lin s_165_2_p = (Adverbial (on_friday_Adv));
lin s_165_3_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (john_PN)) (AdvVP (ComplSlash (SlashV2a (speak_to_V2)) (UsePN (mary_PN))) (on_friday_Adv))))));
lin s_165_4_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (john_PN)) (AdvVP (ComplSlash (SlashV2a (speak_to_V2)) (UsePN (mary_PN))) (on_friday_Adv)))));

lin s_166_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (john_PN)) (AdvVP (ComplSlash (SlashV2a (speak_to_V2)) (UsePN (mary_PN))) (on_thursday_Adv)))));
lin s_166_2_p = (PAdverbial (and_PConj) (on_friday_Adv));
lin s_166_3_q = s_165_3_q;
lin s_166_4_h = s_165_4_h;

lin s_167_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_twenty)))) (UseN (man_N))) (ComplSlash (SlashV2a (work_in_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (sales_department_N)))))));
lin s_167_2_p = (PNounphrase (but_PConj) (PredetNP (only_Predet) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_one)))) (UseN (woman_N)))));
lin s_167_3_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_two)))) (UseN (woman_N))) (ComplSlash (SlashV2a (work_in_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (sales_department_N))))))));
lin s_167_4_h = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_two)))) (UseN (woman_N))) (ComplSlash (SlashV2a (work_in_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (sales_department_N)))))));

lin s_168_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_five)))) (UseN (man_N))) (AdvVP (UseV (work_V)) (part_time_Adv)))));
lin s_168_2_p = (PNounphrase (and_PConj) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_fortyfive)))) (UseN (woman_N))));
lin s_168_3_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_fortyfive)))) (UseN (woman_N))) (AdvVP (UseV (work_V)) (part_time_Adv))))));
lin s_168_4_h = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_fortyfive)))) (UseN (woman_N))) (AdvVP (UseV (work_V)) (part_time_Adv)))));

lin s_169_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (john_PN)) (AdvVP (ComplSlash (SlashV2a (find_V2)) (UsePN (mary_PN))) (PrepNP (before_Prep) (UsePN (bill_PN)))))));
lin s_169_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (john_PN)) (AdvVP (ComplSlash (SlashV2a (find_V2)) (UsePN (mary_PN))) (SubjS (before_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (bill_PN)) (ComplSlash (SlashV2a (find_V2)) (UsePN (mary_PN)))))))))));
lin s_169_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (john_PN)) (AdvVP (ComplSlash (SlashV2a (find_V2)) (UsePN (mary_PN))) (SubjS (before_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (bill_PN)) (ComplSlash (SlashV2a (find_V2)) (UsePN (mary_PN))))))))));

lin s_170_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (john_PN)) (ComplSlash (SlashV2a (find_V2)) (AdvNP (UsePN (mary_PN)) (PrepNP (before_Prep) (UsePN (bill_PN))))))));
lin s_170_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (john_PN)) (AdvVP (ComplSlash (SlashV2a (find_V2)) (UsePN (mary_PN))) (SubjS (before_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (john_PN)) (ComplSlash (SlashV2a (find_V2)) (UsePN (bill_PN)))))))))));
lin s_170_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (john_PN)) (AdvVP (ComplSlash (SlashV2a (find_V2)) (UsePN (mary_PN))) (SubjS (before_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (john_PN)) (ComplSlash (SlashV2a (find_V2)) (UsePN (bill_PN))))))))));

lin s_171_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (john_PN)) (ComplVV (want_VV) (ComplVQ (know_VQ) (UseQCl (Present) (PPos) (QuestVP (IdetCN (how8many_IDet) (UseN (man_N))) (AdvVP (UseV (work_V)) (part_time_Adv)))))))));
lin s_171_2_p = (PNounphrase (and_PConj) (DetCN (DetQuant (IndefArt) (NumPl)) (UseN (woman_N))));
lin s_171_3_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (UsePN (john_PN)) (ComplVV (want_VV) (ComplVQ (know_VQ) (UseQCl (Present) (PPos) (QuestVP (IdetCN (how8many_IDet) (UseN (woman_N))) (AdvVP (UseV (work_V)) (part_time_Adv))))))))));
lin s_171_4_h = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (john_PN)) (ComplVV (want_VV) (ComplVQ (know_VQ) (UseQCl (Present) (PPos) (QuestVP (IdetCN (how8many_IDet) (UseN (woman_N))) (AdvVP (UseV (work_V)) (part_time_Adv)))))))));

lin s_172_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (john_PN)) (ComplVV (want_VV) (ComplVQ (know_VQ) (ConjQS2 (comma_and_Conj) (UseQCl (Present) (PPos) (QuestVP (IdetCN (how8many_IDet) (UseN (man_N))) (AdvVP (UseV (work_V)) (part_time_Adv)))) (UseQCl (Present) (PPos) (QuestVP (IdetCN (IdetQuant (which_IQuant) (NumPl)) (elliptic_CN)) (elliptic_VP)))))))));
lin s_172_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (UsePN (john_PN)) (ComplVV (want_VV) (ComplVQ (know_VQ) (UseQCl (Present) (PPos) (QuestVP (IdetCN (IdetQuant (which_IQuant) (NumPl)) (UseN (man_N))) (AdvVP (UseV (work_V)) (part_time_Adv))))))))));
lin s_172_3_h = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (john_PN)) (ComplVV (want_VV) (ComplVQ (know_VQ) (UseQCl (Present) (PPos) (QuestVP (IdetCN (IdetQuant (which_IQuant) (NumPl)) (UseN (man_N))) (AdvVP (UseV (work_V)) (part_time_Adv)))))))));

lin s_173_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (bill_PN)) (ComplSlash (SlashV2a (speak_to_V2)) (RelNPa (UsePron (everyone_Pron)) (UseRCl (Past) (PPos) (StrandRelSlash (that_RP) (SlashVP (UsePN (john_PN)) (SlashVV (do_VV) (elliptic_VPSlash))))))))));
lin s_173_2_p = s_142_1_p;
lin s_173_3_q = s_142_3_q;
lin s_173_4_h = s_142_4_h;

lin s_174_1_p = s_173_1_p;
lin s_174_2_p = s_142_4_h;
lin s_174_3_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (john_PN)) (ComplSlash (SlashV2a (speak_to_V2)) (UsePN (mary_PN)))))));
lin s_174_4_h = s_142_1_p;

lin s_175_1_p = (Sentence (ConjS2 (comma_and_Conj) (UseCl (Past) (PPos) (PredVP (UsePN (john_PN)) (ComplVSa (say_VS) (UseCl (Past) (PPos) (PredVP (UsePN (mary_PN)) (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (report_N))))))))) (UseCl (Past) (PPos) (PredVP (UsePN (bill_PN)) (AdvVP (ComplVV (do_VV) (elliptic_VP)) (too_Adv))))));
lin s_175_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (bill_PN)) (ComplVSa (say_VS) (UseCl (Past) (PPos) (PredVP (UsePN (mary_PN)) (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (report_N)))))))))));
lin s_175_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (bill_PN)) (ComplVSa (say_VS) (UseCl (Past) (PPos) (PredVP (UsePN (mary_PN)) (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (report_N))))))))));

lin s_176_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (john_PN)) (ComplVSa (say_VS) (ConjS2 (comma_and_Conj) (UseCl (Past) (PPos) (PredVP (UsePN (mary_PN)) (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (report_N)))))) (UseCl (Past) (PPos) (PredVP (UsePN (bill_PN)) (AdvVP (ComplVV (do_VV) (elliptic_VP)) (too_Adv)))))))));
lin s_176_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (john_PN)) (ComplVSa (say_VS) (UseCl (Past) (PPos) (PredVP (UsePN (bill_PN)) (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (report_N)))))))))));
lin s_176_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (john_PN)) (ComplVSa (say_VS) (UseCl (Past) (PPos) (PredVP (UsePN (bill_PN)) (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (report_N))))))))));

lin s_177_1_p = variants{};
lin s_177_1_p_NEW = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (john_PN)) (ComplVS (say_VS) (PredVPS (UsePN (mary_PN)) (ConjVPS2 (comma_and_Conj) (Past) (PPos) (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (report_N)))) (Past) (PPos) (ComplVS (say_VS) (UseCl (Past) (PPos) (PredVP (UsePN (bill_PN)) (AdvVP (ComplVV (do_VV) (elliptic_VP)) (too_Adv)))))))))));
lin s_177_2_q = s_175_2_q;
lin s_177_3_h = s_175_3_h;

lin s_178_1_p = (Sentence (ConjS2 (comma_and_Conj) (UseCl (Past) (PPos) (PredVP (UsePN (john_PN)) (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (report_N)))))) (UseCl (Past) (PPos) (PredVP (UsePN (bill_PN)) (AdvVP (ComplVSa (say_VS) (UseCl (Past) (PPos) (PredVP (UsePN (peter_PN)) (ComplVV (do_VV) (elliptic_VP))))) (too_Adv))))));
lin s_178_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (bill_PN)) (ComplVSa (say_VS) (UseCl (Past) (PPos) (PredVP (UsePN (peter_PN)) (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (report_N)))))))))));
lin s_178_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (bill_PN)) (ComplVSa (say_VS) (UseCl (Past) (PPos) (PredVP (UsePN (peter_PN)) (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (report_N))))))))));

lin s_179_1_p = (Sentence (ConjS2 (if_comma_then_Conj) (UseCl (Past) (PPos) (PredVP (UsePN (john_PN)) (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (report_N)))))) (UseCl (Past) (PPos) (PredVP (UsePN (bill_PN)) (AdvVP (ComplVV (do_VV) (elliptic_VP)) (too_Adv))))));
lin s_179_2_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (john_PN)) (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (report_N)))))));
lin s_179_3_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (bill_PN)) (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (report_N))))))));
lin s_179_4_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (bill_PN)) (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (report_N)))))));

lin s_180_1_p = (Sentence (ConjS2 (comma_and_Conj) (UseCl (Past) (PPos) (PredVP (UsePN (john_PN)) (ComplVV (want_VV) (ComplSlash (SlashV2a (buy_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (car_N))))))) (UseCl (Past) (PPos) (PredVP (UsePron (he_Pron)) (ComplVV (do_VV) (elliptic_VP))))));
lin s_180_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (john_PN)) (ComplSlash (SlashV2a (buy_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (car_N))))))));
lin s_180_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (john_PN)) (ComplSlash (SlashV2a (buy_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (car_N)))))));

lin s_181_1_p = (Sentence (ConjS2 (comma_and_Conj) (UseCl (Past) (PPos) (PredVP (UsePN (john_PN)) (ComplVV (need_VV) (ComplSlash (SlashV2a (buy_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (car_N))))))) (UseCl (Past) (PPos) (PredVP (UsePN (bill_PN)) (ComplVV (do_VV) (elliptic_VP))))));
lin s_181_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (bill_PN)) (ComplSlash (SlashV2a (buy_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (car_N))))))));
lin s_181_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (bill_PN)) (ComplSlash (SlashV2a (buy_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (car_N)))))));

lin s_182_1_p = (Sentence (ConjS2 (and_Conj) (UseCl (Present) (PPos) (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a (represent_V2)) (DetCN (DetQuant (PossPron (heRefl_Pron)) (NumSg)) (UseN (company_N)))))) (UseCl (Present) (PPos) (SoDoI (UsePN (jones_PN))))));
lin s_182_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (UsePN (jones_PN)) (ComplSlash (SlashV2a (represent_V2)) (DetCN (DetQuant (GenNP (UsePN (jones_PN))) (NumSg)) (UseN (company_N))))))));
lin s_182_3_h = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (jones_PN)) (ComplSlash (SlashV2a (represent_V2)) (DetCN (DetQuant (GenNP (UsePN (jones_PN))) (NumSg)) (UseN (company_N)))))));

lin s_183_1_p = s_182_1_p;
lin s_183_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (UsePN (jones_PN)) (ComplSlash (SlashV2a (represent_V2)) (DetCN (DetQuant (GenNP (UsePN (smith_PN))) (NumSg)) (UseN (company_N))))))));
lin s_183_3_h = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (jones_PN)) (ComplSlash (SlashV2a (represent_V2)) (DetCN (DetQuant (GenNP (UsePN (smith_PN))) (NumSg)) (UseN (company_N)))))));

lin s_184_1_p = s_182_1_p;
lin s_184_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a (represent_V2)) (DetCN (DetQuant (GenNP (UsePN (jones_PN))) (NumSg)) (UseN (company_N))))))));
lin s_184_3_h = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a (represent_V2)) (DetCN (DetQuant (GenNP (UsePN (jones_PN))) (NumSg)) (UseN (company_N)))))));

lin s_185_1_p = (Sentence (ConjS2 (and_Conj) (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (ComplVSa (claim_VS) (UseCl (PastPerfect) (PPos) (PredVP (UsePron (he_Pron)) (ComplSlash (SlashV2a (cost_V2)) (DetCN (DetQuant (PossPron (heRefl_Pron)) (NumSg)) (UseN (proposal_N))))))))) (UseCl (Past) (PPos) (SoDoI (UsePN (jones_PN))))));
lin s_185_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (jones_PN)) (ComplVSa (claim_VS) (UseCl (PastPerfect) (PPos) (PredVP (UsePron (he_Pron)) (ComplSlash (SlashV2a (cost_V2)) (DetCN (DetQuant (PossPron (heRefl_Pron)) (NumSg)) (AdjCN (PositA (own_A)) (UseN (proposal_N))))))))))));
lin s_185_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (ComplVSa (claim_VS) (UseCl (PastPerfect) (PPos) (PredVP (UsePron (he_Pron)) (ComplSlash (SlashV2a (cost_V2)) (DetCN (DetQuant (PossPron (heRefl_Pron)) (NumSg)) (AdjCN (PositA (own_A)) (UseN (proposal_N)))))))))));

lin s_186_1_p = s_185_1_p;
lin s_186_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (jones_PN)) (ComplVSa (claim_VS) (UseCl (PastPerfect) (PPos) (PredVP (UsePron (he_Pron)) (ComplSlash (SlashV2a (cost_V2)) (DetCN (DetQuant (GenNP (UsePN (smith_PN))) (NumSg)) (UseN (proposal_N)))))))))));
lin s_186_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (ComplVSa (claim_VS) (UseCl (PastPerfect) (PPos) (PredVP (UsePron (he_Pron)) (ComplSlash (SlashV2a (cost_V2)) (DetCN (DetQuant (GenNP (UsePN (smith_PN))) (NumSg)) (UseN (proposal_N))))))))));

lin s_187_1_p = s_185_1_p;
lin s_187_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (jones_PN)) (ComplVSa (claim_VS) (UseCl (PastPerfect) (PPos) (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a (cost_V2)) (DetCN (DetQuant (GenNP (UsePN (smith_PN))) (NumSg)) (UseN (proposal_N)))))))))));
lin s_187_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (ComplVSa (claim_VS) (UseCl (PastPerfect) (PPos) (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a (cost_V2)) (DetCN (DetQuant (GenNP (UsePN (smith_PN))) (NumSg)) (UseN (proposal_N))))))))));

lin s_188_1_p = s_185_1_p;
lin s_188_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (jones_PN)) (ComplVSa (claim_VS) (UseCl (PastPerfect) (PPos) (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a (cost_V2)) (DetCN (DetQuant (GenNP (UsePN (jones_PN))) (NumSg)) (UseN (proposal_N)))))))))));
lin s_188_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (ComplVSa (claim_VS) (UseCl (PastPerfect) (PPos) (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a (cost_V2)) (DetCN (DetQuant (GenNP (UsePN (jones_PN))) (NumSg)) (UseN (proposal_N))))))))));

lin s_189_1_p = (Sentence (ConjS2 (and_Conj) (UseCl (Present) (PPos) (PredVP (UsePN (john_PN)) (UseComp (CompCN (UseN (man_N)))))) (UseCl (Present) (PPos) (PredVP (UsePN (mary_PN)) (UseComp (CompCN (UseN (woman_N))))))));
lin s_189_2_p = (Sentence (ConjS2 (and_Conj) (UseCl (Present) (PPos) (PredVP (UsePN (john_PN)) (ComplSlash (SlashV2a (represent_V2)) (DetCN (DetQuant (PossPron (heRefl_Pron)) (NumSg)) (UseN (company_N)))))) (UseCl (Present) (PPos) (SoDoI (UsePN (mary_PN))))));
lin s_189_3_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (UsePN (mary_PN)) (ComplSlash (SlashV2a (represent_V2)) (DetCN (DetQuant (PossPron (sheRefl_Pron)) (NumSg)) (AdjCN (PositA (own_A)) (UseN (company_N)))))))));
lin s_189_4_h = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (mary_PN)) (ComplSlash (SlashV2a (represent_V2)) (DetCN (DetQuant (PossPron (sheRefl_Pron)) (NumSg)) (AdjCN (PositA (own_A)) (UseN (company_N))))))));

lin s_190_1_p = s_189_1_p;
lin s_190_2_p = s_189_2_p;
lin s_190_3_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (UsePN (mary_PN)) (ComplSlash (SlashV2a (represent_V2)) (DetCN (DetQuant (GenNP (UsePN (john_PN))) (NumSg)) (UseN (company_N))))))));
lin s_190_4_h = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (mary_PN)) (ComplSlash (SlashV2a (represent_V2)) (DetCN (DetQuant (GenNP (UsePN (john_PN))) (NumSg)) (UseN (company_N)))))));

lin s_191_1_p = (Sentence (ConjS2 (comma_and_Conj) (UseCl (Past) (PPos) (PredVP (UsePN (bill_PN)) (ComplSlash (SlashV2S (suggest_to_V2S) (UseCl (Past) (PPos) (PredVP (UsePron (they_Pron)) (ComplVV (shall_VV) (AdvVP (AdvVP (UseV (go8walk_V)) (PrepNP (to_Prep) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (meeting_N))))) (together_Adv)))))) (DetCN (DetQuant (GenNP (UsePN (frank_PN))) (NumSg)) (UseN (boss_N)))))) (UseCl (Past) (PPos) (PredVP (UsePN (carl_PN)) (AdvVP (elliptic_VP) (PrepNP (to_Prep) (DetCN (DetQuant (GenNP (UsePN (alan_PN))) (NumSg)) (UseN (wife_N)))))))));
lin s_191_2_q = (Question (ExtAdvQS (SubjS (if_Subj) (UseCl (Past) (PPos) (ImpersCl (PassVPSlash (SlashV2S (suggest_to_V2S) (UseCl (Past) (PPos) (PredVP (ConjNP2 (and_Conj) (UsePN (bill_PN)) (UsePN (frank_PN))) (ComplVV (shall_VV) (AdvVP (UseV (go8walk_V)) (together_Adv)))))))))) (UseQCl (Past) (PPos) (QuestCl (ImpersCl (PassVPSlash (SlashV2S (suggest_to_V2S) (UseCl (Past) (PPos) (PredVP (ConjNP2 (and_Conj) (UsePN (carl_PN)) (UsePN (alan_PN))) (ComplVV (shall_VV) (AdvVP (UseV (go8walk_V)) (together_Adv))))))))))));
lin s_191_3_h = (Sentence (ExtAdvS (SubjS (if_Subj) (UseCl (Past) (PPos) (ImpersCl (PassVPSlash (SlashV2S (suggest_to_V2S) (UseCl (Past) (PPos) (PredVP (ConjNP2 (and_Conj) (UsePN (bill_PN)) (UsePN (frank_PN))) (ComplVV (shall_VV) (AdvVP (UseV (go8walk_V)) (together_Adv)))))))))) (UseCl (Past) (PPos) (ImpersCl (PassVPSlash (SlashV2S (suggest_to_V2S) (UseCl (Past) (PPos) (PredVP (ConjNP2 (and_Conj) (UsePN (carl_PN)) (UsePN (alan_PN))) (ComplVV (shall_VV) (AdvVP (UseV (go8walk_V)) (together_Adv)))))))))));

lin s_192_1_p = s_191_1_p;
lin s_192_2_q = (Question (ExtAdvQS (SubjS (if_Subj) (UseCl (Past) (PPos) (ImpersCl (PassVPSlash (SlashV2S (suggest_to_V2S) (UseCl (Past) (PPos) (PredVP (ConjNP2 (and_Conj) (UsePN (bill_PN)) (UsePN (frank_PN))) (ComplVV (shall_VV) (AdvVP (UseV (go8walk_V)) (together_Adv)))))))))) (UseQCl (Past) (PPos) (QuestCl (ImpersCl (PassVPSlash (SlashV2S (suggest_to_V2S) (UseCl (Past) (PPos) (PredVP (ConjNP2 (and_Conj) (UsePN (carl_PN)) (DetCN (DetQuant (GenNP (UsePN (alan_PN))) (NumSg)) (UseN (wife_N)))) (ComplVV (shall_VV) (AdvVP (UseV (go8walk_V)) (together_Adv))))))))))));
lin s_192_3_h = (Sentence (ExtAdvS (SubjS (if_Subj) (UseCl (Past) (PPos) (ImpersCl (PassVPSlash (SlashV2S (suggest_to_V2S) (UseCl (Past) (PPos) (PredVP (ConjNP2 (and_Conj) (UsePN (bill_PN)) (UsePN (frank_PN))) (ComplVV (shall_VV) (AdvVP (UseV (go8walk_V)) (together_Adv)))))))))) (UseCl (Past) (PPos) (ImpersCl (PassVPSlash (SlashV2S (suggest_to_V2S) (UseCl (Past) (PPos) (PredVP (ConjNP2 (and_Conj) (UsePN (carl_PN)) (DetCN (DetQuant (GenNP (UsePN (alan_PN))) (NumSg)) (UseN (wife_N)))) (ComplVV (shall_VV) (AdvVP (UseV (go8walk_V)) (together_Adv)))))))))));

lin s_193_1_p = s_191_1_p;
lin s_193_2_q = (Question (ExtAdvQS (SubjS (if_Subj) (UseCl (Past) (PPos) (ImpersCl (PassVPSlash (SlashV2S (suggest_to_V2S) (UseCl (Past) (PPos) (PredVP (ConjNP2 (and_Conj) (UsePN (bill_PN)) (DetCN (DetQuant (GenNP (UsePN (frank_PN))) (NumSg)) (UseN (boss_N)))) (ComplVV (shall_VV) (AdvVP (UseV (go8walk_V)) (together_Adv)))))))))) (UseQCl (Past) (PPos) (QuestCl (ImpersCl (PassVPSlash (SlashV2S (suggest_to_V2S) (UseCl (Past) (PPos) (PredVP (ConjNP2 (and_Conj) (UsePN (carl_PN)) (DetCN (DetQuant (GenNP (UsePN (alan_PN))) (NumSg)) (UseN (wife_N)))) (ComplVV (shall_VV) (AdvVP (UseV (go8walk_V)) (together_Adv))))))))))));
lin s_193_3_h = (Sentence (ExtAdvS (SubjS (if_Subj) (UseCl (Past) (PPos) (ImpersCl (PassVPSlash (SlashV2S (suggest_to_V2S) (UseCl (Past) (PPos) (PredVP (ConjNP2 (and_Conj) (UsePN (bill_PN)) (DetCN (DetQuant (GenNP (UsePN (frank_PN))) (NumSg)) (UseN (boss_N)))) (ComplVV (shall_VV) (AdvVP (UseV (go8walk_V)) (together_Adv)))))))))) (UseCl (Past) (PPos) (ImpersCl (PassVPSlash (SlashV2S (suggest_to_V2S) (UseCl (Past) (PPos) (PredVP (ConjNP2 (and_Conj) (UsePN (carl_PN)) (DetCN (DetQuant (GenNP (UsePN (alan_PN))) (NumSg)) (UseN (wife_N)))) (ComplVV (shall_VV) (AdvVP (UseV (go8walk_V)) (together_Adv)))))))))));

lin s_194_1_p = s_191_1_p;
lin s_194_2_q = (Question (ExtAdvQS (SubjS (if_Subj) (UseCl (Past) (PPos) (ImpersCl (PassVPSlash (SlashV2S (suggest_to_V2S) (UseCl (Past) (PPos) (PredVP (ConjNP2 (and_Conj) (UsePN (bill_PN)) (DetCN (DetQuant (GenNP (UsePN (frank_PN))) (NumSg)) (UseN (boss_N)))) (ComplVV (shall_VV) (AdvVP (UseV (go8walk_V)) (together_Adv)))))))))) (UseQCl (Past) (PPos) (QuestCl (ImpersCl (PassVPSlash (SlashV2S (suggest_to_V2S) (UseCl (Past) (PPos) (PredVP (ConjNP2 (and_Conj) (UsePN (carl_PN)) (UsePN (alan_PN))) (ComplVV (shall_VV) (AdvVP (UseV (go8walk_V)) (together_Adv))))))))))));
lin s_194_3_h = (Sentence (ExtAdvS (SubjS (if_Subj) (UseCl (Past) (PPos) (ImpersCl (PassVPSlash (SlashV2S (suggest_to_V2S) (UseCl (Past) (PPos) (PredVP (ConjNP2 (and_Conj) (UsePN (bill_PN)) (DetCN (DetQuant (GenNP (UsePN (frank_PN))) (NumSg)) (UseN (boss_N)))) (ComplVV (shall_VV) (AdvVP (UseV (go8walk_V)) (together_Adv)))))))))) (UseCl (Past) (PPos) (ImpersCl (PassVPSlash (SlashV2S (suggest_to_V2S) (UseCl (Past) (PPos) (PredVP (ConjNP2 (and_Conj) (UsePN (carl_PN)) (UsePN (alan_PN))) (ComplVV (shall_VV) (AdvVP (UseV (go8walk_V)) (together_Adv)))))))))));

lin s_195_1_p = s_191_1_p;
lin s_195_2_q = (Question (ExtAdvQS (SubjS (if_Subj) (UseCl (Past) (PPos) (ImpersCl (PassVPSlash (SlashV2S (suggest_to_V2S) (UseCl (Past) (PPos) (PredVP (ConjNP3 (and_Conj) (UsePN (bill_PN)) (UsePN (frank_PN)) (DetCN (DetQuant (GenNP (UsePN (frank_PN))) (NumSg)) (UseN (boss_N)))) (ComplVV (shall_VV) (AdvVP (UseV (go8walk_V)) (together_Adv)))))))))) (UseQCl (Past) (PPos) (QuestCl (ImpersCl (PassVPSlash (SlashV2S (suggest_to_V2S) (UseCl (Past) (PPos) (PredVP (ConjNP3 (and_Conj) (UsePN (carl_PN)) (UsePN (alan_PN)) (DetCN (DetQuant (GenNP (UsePN (alan_PN))) (NumSg)) (UseN (wife_N)))) (ComplVV (shall_VV) (AdvVP (UseV (go8walk_V)) (together_Adv))))))))))));
lin s_195_3_h = (Sentence (ExtAdvS (SubjS (if_Subj) (UseCl (Past) (PPos) (ImpersCl (PassVPSlash (SlashV2S (suggest_to_V2S) (UseCl (Past) (PPos) (PredVP (ConjNP3 (and_Conj) (UsePN (bill_PN)) (UsePN (frank_PN)) (DetCN (DetQuant (GenNP (UsePN (frank_PN))) (NumSg)) (UseN (boss_N)))) (ComplVV (shall_VV) (AdvVP (UseV (go8walk_V)) (together_Adv)))))))))) (UseCl (Past) (PPos) (ImpersCl (PassVPSlash (SlashV2S (suggest_to_V2S) (UseCl (Past) (PPos) (PredVP (ConjNP3 (and_Conj) (UsePN (carl_PN)) (UsePN (alan_PN)) (DetCN (DetQuant (GenNP (UsePN (alan_PN))) (NumSg)) (UseN (wife_N)))) (ComplVV (shall_VV) (AdvVP (UseV (go8walk_V)) (together_Adv)))))))))));

lin s_196_1_p = (Sentence (ConjS2 (comma_and_Conj) (UseCl (Past) (PPos) (PredVP (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (lawyer_N))) (ComplSlash (SlashV2a (sign_V2)) (DetCN (every_Det) (UseN (report_N)))))) (UseCl (Past) (PPos) (SoDoI (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (auditor_N)))))));
lin s_196_2_p = (PSentence (that_is_PConj) (UseCl (Past) (PPos) (ExistNP (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_one)))) (RelCN (UseN (lawyer_N)) (UseRCl (Past) (PPos) (RelVP (IdRP) (ComplSlash (SlashV2a (sign_V2)) (PredetNP (all_Predet) (DetCN (DetQuant (DefArt) (NumPl)) (UseN (report_N))))))))))));
lin s_196_3_q = (Question (UseQCl (Past) (PPos) (QuestCl (ExistNP (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_one)))) (RelCN (UseN (auditor_N)) (UseRCl (Past) (PPos) (RelVP (IdRP) (ComplSlash (SlashV2a (sign_V2)) (PredetNP (all_Predet) (DetCN (DetQuant (DefArt) (NumPl)) (UseN (report_N)))))))))))));
lin s_196_4_h = (Sentence (UseCl (Past) (PPos) (ExistNP (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_one)))) (RelCN (UseN (auditor_N)) (UseRCl (Past) (PPos) (RelVP (IdRP) (ComplSlash (SlashV2a (sign_V2)) (PredetNP (all_Predet) (DetCN (DetQuant (DefArt) (NumPl)) (UseN (report_N))))))))))));

lin s_197_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (john_PN)) (ComplSlash (SlashV2a (have_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdjCN (PositA (genuine_A)) (UseN (diamond_N))))))));
lin s_197_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (UsePN (john_PN)) (ComplSlash (SlashV2a (have_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (diamond_N))))))));
lin s_197_3_h = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (john_PN)) (ComplSlash (SlashV2a (have_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (diamond_N)))))));

lin s_198_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (john_PN)) (UseComp (CompCN (AdjCN (PositA (former_A)) (UseN (university_student_N))))))));
lin s_198_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (UsePN (john_PN)) (UseComp (CompCN (UseN (university_student_N))))))));
lin s_198_3_h = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (john_PN)) (UseComp (CompCN (UseN (university_student_N)))))));

lin s_199_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (john_PN)) (UseComp (CompCN (AdjCN (PositA (successful_A)) (AdjCN (PositA (former_A)) (UseN (university_student_N)))))))));
lin s_199_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (UsePN (john_PN)) (UseComp (CompAP (PositA (successful_A))))))));
lin s_199_3_h = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (john_PN)) (UseComp (CompAP (PositA (successful_A)))))));

lin s_200_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (john_PN)) (UseComp (CompCN (AdjCN (PositA (former_A)) (AdjCN (PositA (successful_A)) (UseN (university_student_N)))))))));
lin s_200_2_q = s_199_2_q;
lin s_200_3_h = s_199_3_h;

lin s_201_1_p = s_200_1_p;
lin s_201_2_q = s_198_2_q;
lin s_201_3_h = s_198_3_h;

lin s_202_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (every_Det) (UseN (mammal_N))) (UseComp (CompCN (UseN (animal_N)))))));
lin s_202_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (DetCN (every_Det) (AdjCN (PositA (fourlegged_A)) (UseN (mammal_N)))) (UseComp (CompCN (AdjCN (PositA (fourlegged_A)) (UseN (animal_N)))))))));
lin s_202_3_h = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (every_Det) (AdjCN (PositA (fourlegged_A)) (UseN (mammal_N)))) (UseComp (CompCN (AdjCN (PositA (fourlegged_A)) (UseN (animal_N))))))));

lin s_203_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (dumbo_PN)) (UseComp (CompCN (AdjCN (PositA (fourlegged_A)) (UseN (animal_N))))))));
lin s_203_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (UsePN (dumbo_PN)) (UseComp (CompAP (PositA (fourlegged_A))))))));
lin s_203_3_h = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (dumbo_PN)) (UseComp (CompAP (PositA (fourlegged_A)))))));

lin s_204_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (mickey_PN)) (UseComp (CompCN (AdjCN (PositA (small_A)) (UseN (animal_N))))))));
lin s_204_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (UsePN (mickey_PN)) (UseComp (CompCN (AdjCN (PositA (large_A)) (UseN (animal_N)))))))));
lin s_204_3_h = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (mickey_PN)) (UseComp (CompCN (AdjCN (PositA (large_A)) (UseN (animal_N))))))));

lin s_205_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (dumbo_PN)) (UseComp (CompCN (AdjCN (PositA (large_A)) (UseN (animal_N))))))));
lin s_205_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (UsePN (dumbo_PN)) (UseComp (CompCN (AdjCN (PositA (small_A)) (UseN (animal_N)))))))));
lin s_205_3_h = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (dumbo_PN)) (UseComp (CompCN (AdjCN (PositA (small_A)) (UseN (animal_N))))))));

lin s_206_1_p = (Sentence (UseCl (Present) (UncNeg) (PredVP (UsePN (fido_PN)) (UseComp (CompCN (AdjCN (PositA (small_A)) (UseN (animal_N))))))));
lin s_206_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (UsePN (fido_PN)) (UseComp (CompCN (AdjCN (PositA (large_A)) (UseN (animal_N)))))))));
lin s_206_3_h = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (fido_PN)) (UseComp (CompCN (AdjCN (PositA (large_A)) (UseN (animal_N))))))));

lin s_207_1_p = (Sentence (UseCl (Present) (UncNeg) (PredVP (UsePN (fido_PN)) (UseComp (CompCN (AdjCN (PositA (large_A)) (UseN (animal_N))))))));
lin s_207_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (UsePN (fido_PN)) (UseComp (CompCN (AdjCN (PositA (small_A)) (UseN (animal_N)))))))));
lin s_207_3_h = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (fido_PN)) (UseComp (CompCN (AdjCN (PositA (small_A)) (UseN (animal_N))))))));

lin s_208_1_p = s_204_1_p;
lin s_208_2_p = s_205_1_p;
lin s_208_3_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (UsePN (mickey_PN)) (UseComp (CompAP (ComparA (small_A) (UsePN (dumbo_PN)))))))));
lin s_208_4_h = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (mickey_PN)) (UseComp (CompAP (ComparA (small_A) (UsePN (dumbo_PN))))))));

lin s_209_1_p = s_204_1_p;
lin s_209_2_p = s_205_1_p;
lin s_209_3_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (UsePN (mickey_PN)) (UseComp (CompAP (ComparA (large_A) (UsePN (dumbo_PN)))))))));
lin s_209_4_h = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (mickey_PN)) (UseComp (CompAP (ComparA (large_A) (UsePN (dumbo_PN))))))));

lin s_210_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (PredetNP (all_Predet) (DetCN (DetQuant (IndefArt) (NumPl)) (UseN (mouse_N)))) (UseComp (CompCN (AdjCN (PositA (small_A)) (UseN (animal_N))))))));
lin s_210_2_p = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (mickey_PN)) (UseComp (CompCN (AdjCN (PositA (large_A)) (UseN (mouse_N))))))));
lin s_210_3_q = s_204_2_q;
lin s_210_4_h = s_204_3_h;

lin s_211_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (PredetNP (all_Predet) (DetCN (DetQuant (IndefArt) (NumPl)) (UseN (elephant_N)))) (UseComp (CompCN (AdjCN (PositA (large_A)) (UseN (animal_N))))))));
lin s_211_2_p = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (dumbo_PN)) (UseComp (CompCN (AdjCN (PositA (small_A)) (UseN (elephant_N))))))));
lin s_211_3_q = s_205_2_q;
lin s_211_4_h = s_205_3_h;

lin s_212_1_p = s_210_1_p;
lin s_212_2_p = s_211_1_p;
lin s_212_3_p = s_210_2_p;
lin s_212_4_p = s_211_2_p;
lin s_212_5_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (UsePN (dumbo_PN)) (UseComp (CompAP (ComparA (large_A) (UsePN (mickey_PN)))))))));
lin s_212_6_h = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (dumbo_PN)) (UseComp (CompAP (ComparA (large_A) (UsePN (mickey_PN))))))));

lin s_213_1_p = s_210_1_p;
lin s_213_2_p = s_210_2_p;
lin s_213_3_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (UsePN (mickey_PN)) (UseComp (CompAP (PositA (small_A))))))));
lin s_213_4_h = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (mickey_PN)) (UseComp (CompAP (PositA (small_A)))))));

lin s_214_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (PredetNP (all_Predet) (DetCN (DetQuant (IndefArt) (NumPl)) (AdjCN (PositA (legal_A)) (UseN (authority_N))))) (UseComp (CompCN (UseN (law_lecturer_N)))))));
lin s_214_2_p = (Sentence (UseCl (Present) (PPos) (PredVP (PredetNP (all_Predet) (DetCN (DetQuant (IndefArt) (NumPl)) (UseN (law_lecturer_N)))) (UseComp (CompCN (AdjCN (PositA (legal_A)) (UseN (authority_N))))))));
lin s_214_3_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (PredetNP (all_Predet) (DetCN (DetQuant (IndefArt) (NumPl)) (AdjCN (PositA (fat_A)) (AdjCN (PositA (legal_A)) (UseN (authority_N)))))) (UseComp (CompCN (AdjCN (PositA (fat_A)) (UseN (law_lecturer_N)))))))));
lin s_214_4_h = (Sentence (UseCl (Present) (PPos) (PredVP (PredetNP (all_Predet) (DetCN (DetQuant (IndefArt) (NumPl)) (AdjCN (PositA (fat_A)) (AdjCN (PositA (legal_A)) (UseN (authority_N)))))) (UseComp (CompCN (AdjCN (PositA (fat_A)) (UseN (law_lecturer_N))))))));

lin s_215_1_p = s_214_1_p;
lin s_215_2_p = s_214_2_p;
lin s_215_3_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (PredetNP (all_Predet) (DetCN (DetQuant (IndefArt) (NumPl)) (AdjCN (PositA (competent_A)) (AdjCN (PositA (legal_A)) (UseN (authority_N)))))) (UseComp (CompCN (AdjCN (PositA (competent_A)) (UseN (law_lecturer_N)))))))));
lin s_215_4_h = (Sentence (UseCl (Present) (PPos) (PredVP (PredetNP (all_Predet) (DetCN (DetQuant (IndefArt) (NumPl)) (AdjCN (PositA (competent_A)) (AdjCN (PositA (legal_A)) (UseN (authority_N)))))) (UseComp (CompCN (AdjCN (PositA (competent_A)) (UseN (law_lecturer_N))))))));

lin s_216_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (john_PN)) (UseComp (CompCN (AdvCN (AdjCN (UseComparA_prefix (fat_A)) (UseN (politician_N))) (PrepNP (than_Prep) (UsePN (bill_PN)))))))));
lin s_216_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (UsePN (john_PN)) (UseComp (CompAP (ComparA (fat_A) (UsePN (bill_PN)))))))));
lin s_216_3_h = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (john_PN)) (UseComp (CompAP (ComparA (fat_A) (UsePN (bill_PN))))))));

lin s_217_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (john_PN)) (UseComp (CompCN (AdvCN (AdjCN (UseComparA_prefix (clever_A)) (UseN (politician_N))) (PrepNP (than_Prep) (UsePN (bill_PN)))))))));
lin s_217_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (UsePN (john_PN)) (UseComp (CompAP (ComparA (clever_A) (UsePN (bill_PN)))))))));
lin s_217_3_h = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (john_PN)) (UseComp (CompAP (ComparA (clever_A) (UsePN (bill_PN))))))));

lin s_218_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (kim_PN)) (UseComp (CompCN (AdjCN (PositA (clever_A)) (UseN (person_N))))))));
lin s_218_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (UsePN (kim_PN)) (UseComp (CompAP (PositA (clever_A))))))));
lin s_218_3_h = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (kim_PN)) (UseComp (CompAP (PositA (clever_A)))))));

lin s_219_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (kim_PN)) (UseComp (CompCN (AdjCN (PositA (clever_A)) (UseN (politician_N))))))));
lin s_219_2_q = s_218_2_q;
lin s_219_3_h = s_218_3_h;

lin s_220_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (DetQuant (DefArt) (NumSg)) (UseN (pc6082_N))) (UseComp (CompAP (ComparA (fast_A) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (itelxz_N)))))))));
lin s_220_2_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (DetQuant (DefArt) (NumSg)) (UseN (itelxz_N))) (UseComp (CompAP (PositA (fast_A)))))));
lin s_220_3_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (DetCN (DetQuant (DefArt) (NumSg)) (UseN (pc6082_N))) (UseComp (CompAP (PositA (fast_A))))))));
lin s_220_4_h = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (DetQuant (DefArt) (NumSg)) (UseN (pc6082_N))) (UseComp (CompAP (PositA (fast_A)))))));

lin s_221_1_p = s_220_1_p;
lin s_221_2_q = s_220_3_q;
lin s_221_3_h = s_220_4_h;

lin s_222_1_p = s_220_1_p;
lin s_222_2_p = s_220_4_h;
lin s_222_3_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (DetCN (DetQuant (DefArt) (NumSg)) (UseN (itelxz_N))) (UseComp (CompAP (PositA (fast_A))))))));
lin s_222_4_h = s_220_2_p;

lin s_223_1_p = s_220_1_p;
lin s_223_2_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (DetQuant (DefArt) (NumSg)) (UseN (pc6082_N))) (UseComp (CompAP (PositA (slow_A)))))));
lin s_223_3_q = s_222_3_q;
lin s_223_4_h = s_220_2_p;

lin s_224_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (DetQuant (DefArt) (NumSg)) (UseN (pc6082_N))) (UseComp (CompAP (ComparAsAs (fast_A) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (itelxz_N)))))))));
lin s_224_2_p = s_220_2_p;
lin s_224_3_q = s_220_3_q;
lin s_224_4_h = s_220_4_h;

lin s_225_1_p = s_224_1_p;
lin s_225_2_q = s_220_3_q;
lin s_225_3_h = s_220_4_h;

lin s_226_1_p = s_224_1_p;
lin s_226_2_p = s_220_4_h;
lin s_226_3_q = s_222_3_q;
lin s_226_4_h = s_220_2_p;

lin s_227_1_p = s_224_1_p;
lin s_227_2_p = s_223_2_p;
lin s_227_3_q = s_222_3_q;
lin s_227_4_h = s_220_2_p;

lin s_228_1_p = s_224_1_p;
lin s_228_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (DetCN (DetQuant (DefArt) (NumSg)) (UseN (pc6082_N))) (UseComp (CompAP (ComparA (fast_A) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (itelxz_N))))))))));
lin s_228_3_h = s_220_1_p;

lin s_229_1_p = s_224_1_p;
lin s_229_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (DetCN (DetQuant (DefArt) (NumSg)) (UseN (pc6082_N))) (UseComp (CompAP (ComparA (slow_A) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (itelxz_N))))))))));
lin s_229_3_h = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (DetQuant (DefArt) (NumSg)) (UseN (pc6082_N))) (UseComp (CompAP (ComparA (slow_A) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (itelxz_N)))))))));

lin s_230_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (itel_PN)) (ComplSlash (SlashV2a (win_V2)) (DetCN (DetQuant (IndefArt) (NumPl)) (AdvCN (AdjCN (UseComparA_prefix (many_A)) (UseN (order_N))) (SubjS (than_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (apcom_PN)) (ComplVV (do_VV) (elliptic_VP)))))))))));
lin s_230_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (itel_PN)) (ComplSlash (SlashV2a (win_V2)) (DetCN (somePl_Det) (UseN (order_N))))))));
lin s_230_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (itel_PN)) (ComplSlash (SlashV2a (win_V2)) (DetCN (somePl_Det) (UseN (order_N)))))));

lin s_231_1_p = s_230_1_p;
lin s_231_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (apcom_PN)) (ComplSlash (SlashV2a (win_V2)) (DetCN (somePl_Det) (UseN (order_N))))))));
lin s_231_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (apcom_PN)) (ComplSlash (SlashV2a (win_V2)) (DetCN (somePl_Det) (UseN (order_N)))))));

lin s_232_1_p = s_230_1_p;
lin s_232_2_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (apcom_PN)) (ComplSlash (SlashV2a (win_V2)) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_ten)))) (UseN (order_N)))))));
lin s_232_3_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (itel_PN)) (ComplSlash (SlashV2a (win_V2)) (PredetNP (at_least_Predet) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_eleven)))) (UseN (order_N)))))))));
lin s_232_4_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (itel_PN)) (ComplSlash (SlashV2a (win_V2)) (PredetNP (at_least_Predet) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_eleven)))) (UseN (order_N))))))));

lin s_233_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (itel_PN)) (ComplSlash (SlashV2a (win_V2)) (DetCN (DetQuant (IndefArt) (NumPl)) (AdvCN (AdjCN (UseComparA_prefix (many_A)) (UseN (order_N))) (PrepNP (than_Prep) (UsePN (apcom_PN)))))))));
lin s_233_2_q = s_230_2_q;
lin s_233_3_h = s_230_3_h;

lin s_234_1_p = s_233_1_p;
lin s_234_2_q = s_231_2_q;
lin s_234_3_h = s_231_3_h;

lin s_235_1_p = s_233_1_p;
lin s_235_2_p = s_232_2_p;
lin s_235_3_q = s_232_3_q;
lin s_235_4_h = s_232_4_h;

lin s_236_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (itel_PN)) (ComplSlash (SlashV2a (win_V2)) (DetCN (DetQuant (IndefArt) (NumPl)) (AdvCN (AdjCN (UseComparA_prefix (many_A)) (UseN (order_N))) (PrepNP (than_Prep) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (apcom_contract_N))))))))));
lin s_236_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (itel_PN)) (ComplSlash (SlashV2a (win_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (apcom_contract_N))))))));
lin s_236_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (itel_PN)) (ComplSlash (SlashV2a (win_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (apcom_contract_N)))))));

lin s_237_1_p = s_236_1_p;
lin s_237_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (itel_PN)) (ComplSlash (SlashV2a (win_V2)) (DetCN (DetQuant (IndefArt) (NumCard (AdNum (more_than_AdN) (NumNumeral (N_one))))) (UseN (order_N))))))));
lin s_237_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (itel_PN)) (ComplSlash (SlashV2a (win_V2)) (DetCN (DetQuant (IndefArt) (NumCard (AdNum (more_than_AdN) (NumNumeral (N_one))))) (UseN (order_N)))))));

lin s_238_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (itel_PN)) (ComplSlash (SlashV2a (win_V2)) (DetCN (twice_as_many_Det) (AdvCN (UseN (order_N)) (PrepNP (than_Prep) (UsePN (apcom_PN)))))))));
lin s_238_2_p = s_232_2_p;
lin s_238_3_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (itel_PN)) (ComplSlash (SlashV2a (win_V2)) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_twenty)))) (UseN (order_N))))))));
lin s_238_4_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (itel_PN)) (ComplSlash (SlashV2a (win_V2)) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_twenty)))) (UseN (order_N)))))));

lin s_239_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (itel_PN)) (ComplSlash (SlashV2a (win_V2)) (DetCN (DetQuant (IndefArt) (NumPl)) (AdvCN (AdjCN (UseComparA_prefix (many_A)) (UseN (order_N))) (SubjS (than_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (apcom_PN)) (ComplSlash (SlashV2a (lose_V2)) (elliptic_NP_Pl)))))))))));
lin s_239_2_q = s_230_2_q;
lin s_239_3_h = s_230_3_h;

lin s_240_1_p = s_239_1_p;
lin s_240_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (apcom_PN)) (ComplSlash (SlashV2a (lose_V2)) (DetCN (somePl_Det) (UseN (order_N))))))));
lin s_240_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (apcom_PN)) (ComplSlash (SlashV2a (lose_V2)) (DetCN (somePl_Det) (UseN (order_N)))))));

lin s_241_1_p = s_239_1_p;
lin s_241_2_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (apcom_PN)) (ComplSlash (SlashV2a (lose_V2)) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_ten)))) (UseN (order_N)))))));
lin s_241_3_q = s_232_3_q;
lin s_241_4_h = s_232_4_h;

lin s_242_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (DetQuant (DefArt) (NumSg)) (UseN (pc6082_N))) (UseComp (CompAP (ComparA (fast_A) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_500)))) (UseN (mips_N)))))))));
lin s_242_2_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (DetQuant (DefArt) (NumSg)) (UseN (itelzx_N))) (UseComp (CompAP (ComparA (slow_A) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_500)))) (UseN (mips_N)))))))));
lin s_242_3_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (DetCN (DetQuant (DefArt) (NumSg)) (UseN (pc6082_N))) (UseComp (CompAP (ComparA (fast_A) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (itelzx_N))))))))));
lin s_242_4_h = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (DetQuant (DefArt) (NumSg)) (UseN (pc6082_N))) (UseComp (CompAP (ComparA (fast_A) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (itelzx_N)))))))));

lin s_243_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (itel_PN)) (ComplSlash (SlashV2a (sell_V2)) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_3000)))) (AdvCN (AdjCN (UseComparA_prefix (many_A)) (UseN (computer_N))) (PrepNP (than_Prep) (UsePN (apcom_PN)))))))));
lin s_243_2_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (apcom_PN)) (ComplSlash (SlashV2a (sell_V2)) (PredetNP (exactly_Predet) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_2500)))) (UseN (computer_N))))))));
lin s_243_3_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (itel_PN)) (ComplSlash (SlashV2a (sell_V2)) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_5500)))) (UseN (computer_N))))))));
lin s_243_4_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (itel_PN)) (ComplSlash (SlashV2a (sell_V2)) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_5500)))) (UseN (computer_N)))))));

lin s_244_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (apcom_PN)) (ComplSlash (SlashV2a (have_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdvCN (AdjCN (UseComparA_prefix (important_A)) (UseN (customer_N))) (PrepNP (than_Prep) (UsePN (itel_PN)))))))));
lin s_244_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (UsePN (apcom_PN)) (ComplSlash (SlashV2a (have_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdvCN (AdjCN (UseComparA_prefix (important_A)) (UseN (customer_N))) (SubjS (than_Subj) (UseCl (Present) (PPos) (PredVP (UsePN (itel_PN)) (UseComp (CompNP (elliptic_NP_Sg)))))))))))));
lin s_244_3_h = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (apcom_PN)) (ComplSlash (SlashV2a (have_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdvCN (AdjCN (UseComparA_prefix (important_A)) (UseN (customer_N))) (SubjS (than_Subj) (UseCl (Present) (PPos) (PredVP (UsePN (itel_PN)) (UseComp (CompNP (elliptic_NP_Sg))))))))))));

lin s_245_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (apcom_PN)) (AdvVP (ComplSlash (SlashV2a (have_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdjCN (UseComparA_prefix (important_A)) (UseN (customer_N))))) (PrepNP (than_Prep) (UsePN (itel_PN)))))));
lin s_245_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (UsePN (apcom_PN)) (AdvVP (ComplSlash (SlashV2a (have_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdjCN (UseComparA_prefix (important_A)) (UseN (customer_N))))) (SubjS (than_Subj) (UseCl (PresentPerfect) (PPos) (PredVP (UsePN (itel_PN)) (elliptic_VP)))))))));
lin s_245_3_h = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (apcom_PN)) (AdvVP (ComplSlash (SlashV2a (have_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdjCN (UseComparA_prefix (important_A)) (UseN (customer_N))))) (SubjS (than_Subj) (UseCl (PresentPerfect) (PPos) (PredVP (UsePN (itel_PN)) (elliptic_VP))))))));

lin s_246_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (DetQuant (DefArt) (NumSg)) (UseN (pc6082_N))) (UseComp (CompAP (ComparA (fast_A) (DetCN (every_Det) (UseN (itel_computer_N)))))))));
lin s_246_2_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (DetQuant (DefArt) (NumSg)) (UseN (itelzx_N))) (UseComp (CompCN (UseN (itel_computer_N)))))));
lin s_246_3_q = s_242_3_q;
lin s_246_4_h = s_242_4_h;

lin s_247_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (DetQuant (DefArt) (NumSg)) (UseN (pc6082_N))) (UseComp (CompAP (ComparA (fast_A) (DetCN (someSg_Det) (UseN (itel_computer_N)))))))));
lin s_247_2_p = s_246_2_p;
lin s_247_3_q = s_242_3_q;
lin s_247_4_h = s_242_4_h;

lin s_248_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (DetQuant (DefArt) (NumSg)) (UseN (pc6082_N))) (UseComp (CompAP (ComparA (fast_A) (DetCN (anySg_Det) (UseN (itel_computer_N)))))))));
lin s_248_2_p = s_246_2_p;
lin s_248_3_q = s_242_3_q;
lin s_248_4_h = s_242_4_h;

lin s_249_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (DetQuant (DefArt) (NumSg)) (UseN (pc6082_N))) (UseComp (CompAP (ComparA (fast_A) (ConjNP2 (and_Conj) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (itelzx_N))) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (itelzy_N))))))))));
lin s_249_2_q = s_242_3_q;
lin s_249_3_h = s_242_4_h;

lin s_250_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (DetQuant (DefArt) (NumSg)) (UseN (pc6082_N))) (UseComp (CompAP (ComparA (fast_A) (ConjNP2 (or_Conj) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (itelzx_N))) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (itelzy_N))))))))));
lin s_250_2_q = s_242_3_q;
lin s_250_3_h = s_242_4_h;

lin s_251_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (itel_PN)) (AdvVP (ComplSlash (SlashV2a (have_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (factory_N)))) (PrepNP (in_Prep) (UsePN (birmingham_PN)))))));
lin s_251_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (UsePN (itel_PN)) (AdVVP (currently_AdV) (AdvVP (ComplSlash (SlashV2a (have_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (factory_N)))) (PrepNP (in_Prep) (UsePN (birmingham_PN)))))))));
lin s_251_3_h = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (itel_PN)) (AdVVP (currently_AdV) (AdvVP (ComplSlash (SlashV2a (have_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (factory_N)))) (PrepNP (in_Prep) (UsePN (birmingham_PN))))))));

lin s_252_1_p = (Sentence (AdvS (since_1992_Adv) (UseCl (PresentPerfect) (PPos) (PredVP (UsePN (itel_PN)) (UseComp (CompAdv (PrepNP (in_Prep) (UsePN (birmingham_PN)))))))));
lin s_252_2_p = (Sentence (UseCl (Present) (PPos) (ImpersCl (AdVVP (now_AdV) (UseComp (CompAdv (year_1996_Adv)))))));
lin s_252_3_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (itel_PN)) (AdvVP (UseComp (CompAdv (PrepNP (in_Prep) (UsePN (birmingham_PN))))) (in_1993_Adv))))));
lin s_252_4_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (itel_PN)) (AdvVP (UseComp (CompAdv (PrepNP (in_Prep) (UsePN (birmingham_PN))))) (in_1993_Adv)))));

lin s_253_1_p = (Sentence (UseCl (PresentPerfect) (PPos) (PredVP (UsePN (itel_PN)) (AdvVP (ComplSlash (SlashV2a (develop_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdjCN (PositA (new_A)) (UseN (editor_N))))) (since_1992_Adv)))));
lin s_253_2_p = s_252_2_p;
lin s_253_3_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (itel_PN)) (AdvVP (ComplSlash (SlashV2a (develop_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdjCN (PositA (new_A)) (UseN (editor_N))))) (in_1993_Adv))))));
lin s_253_4_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (itel_PN)) (AdvVP (ComplSlash (SlashV2a (develop_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdjCN (PositA (new_A)) (UseN (editor_N))))) (in_1993_Adv)))));

lin s_254_1_p = (Sentence (UseCl (PresentPerfect) (PPos) (PredVP (UsePN (itel_PN)) (AdvVP (UseV (expand_V)) (since_1992_Adv)))));
lin s_254_2_p = s_252_2_p;
lin s_254_3_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (itel_PN)) (AdvVP (UseV (expand_V)) (in_1993_Adv))))));
lin s_254_4_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (itel_PN)) (AdvVP (UseV (expand_V)) (in_1993_Adv)))));

lin s_255_1_p = (Sentence (AdvS (since_1992_Adv) (UseCl (PresentPerfect) (PPos) (PredVP (UsePN (itel_PN)) (ComplSlash (SlashV2a (make8do_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (loss_N))))))));
lin s_255_2_p = s_252_2_p;
lin s_255_3_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (itel_PN)) (AdvVP (ComplSlash (SlashV2a (make8do_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (loss_N)))) (in_1993_Adv))))));
lin s_255_4_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (itel_PN)) (AdvVP (ComplSlash (SlashV2a (make8do_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (loss_N)))) (in_1993_Adv)))));

lin s_256_1_p = (Sentence (UseCl (PresentPerfect) (PPos) (PredVP (UsePN (itel_PN)) (AdvVP (ComplSlash (SlashV2a (make8do_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (loss_N)))) (since_1992_Adv)))));
lin s_256_2_p = s_252_2_p;
lin s_256_3_q = s_255_3_q;
lin s_256_4_h = s_255_4_h;

lin s_257_1_p = s_256_1_p;
lin s_257_2_p = s_252_2_p;
lin s_257_3_q = s_255_3_q;
lin s_257_4_h = s_255_4_h;

lin s_258_1_p = (Sentence (AdvS (in_march_1993_Adv) (UseCl (Past) (PPos) (PredVP (UsePN (apcom_PN)) (ComplSlash (SlashV2a (found_V2)) (UsePN (itel_PN)))))));
lin s_258_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (itel_PN)) (AdvVP (UseV (exist_V)) (in_1992_Adv))))));
lin s_258_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (itel_PN)) (AdvVP (UseV (exist_V)) (in_1992_Adv)))));

lin s_259_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (DetQuant (DefArt) (NumSg)) (UseN (conference_N))) (AdvVP (UseV (start_V)) (on_july_4th_1994_Adv)))));
lin s_259_2_p = (Sentence (UseCl (Past) (PPos) (ImpersCl (ComplSlash (SlashV2a (last_V2)) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_2)))) (UseN (day_N)))))));
lin s_259_3_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (DetCN (DetQuant (DefArt) (NumSg)) (UseN (conference_N))) (AdvVP (UseComp (CompAdv (over_Adv))) (on_july_8th_1994_Adv))))));
lin s_259_4_h = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (DetQuant (DefArt) (NumSg)) (UseN (conference_N))) (AdvVP (UseComp (CompAdv (over_Adv))) (on_july_8th_1994_Adv)))));

lin s_260_1_p = (Sentence (AdvS (yesterday_Adv) (UseCl (Past) (PPos) (PredVP (UsePN (apcom_PN)) (ComplSlash (SlashV2a (sign_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (contract_N))))))));
lin s_260_2_p = (Sentence (UseCl (Present) (PPos) (PredVP (MassNP (UseN (today_N))) (UseComp (CompAdv (saturday_july_14th_Adv))))));
lin s_260_3_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (apcom_PN)) (AdvVP (ComplSlash (SlashV2a (sign_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (contract_N)))) (friday_13th_Adv))))));
lin s_260_4_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (apcom_PN)) (AdvVP (ComplSlash (SlashV2a (sign_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (contract_N)))) (friday_13th_Adv)))));

lin s_261_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (UseV (leave_V)) (SubjS (before_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (UseV (leave_V)))))))));
lin s_261_2_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (AdvVP (UseV (leave_V)) (SubjS (before_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (anderson_PN)) (UseV (leave_V)))))))));
lin s_261_3_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (AdvVP (UseV (leave_V)) (SubjS (before_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (anderson_PN)) (UseV (leave_V))))))))));
lin s_261_4_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (UseV (leave_V)) (SubjS (before_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (anderson_PN)) (UseV (leave_V)))))))));

lin s_262_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (UseV (leave_V)) (SubjS (after_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (UseV (leave_V)))))))));
lin s_262_2_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (AdvVP (UseV (leave_V)) (SubjS (after_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (anderson_PN)) (UseV (leave_V)))))))));
lin s_262_3_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (AdvVP (UseV (leave_V)) (SubjS (after_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (anderson_PN)) (UseV (leave_V))))))))));
lin s_262_4_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (UseV (leave_V)) (SubjS (after_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (anderson_PN)) (UseV (leave_V)))))))));

lin s_263_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (UseComp (CompAP (PositA (present8attending_A)))) (SubjS (after_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (UseV (leave_V)))))))));
lin s_263_2_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (AdvVP (UseV (leave_V)) (SubjS (after_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (anderson_PN)) (UseComp (CompAP (PositA (present8attending_A)))))))))));
lin s_263_3_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (AdvVP (UseComp (CompAP (PositA (present8attending_A)))) (SubjS (after_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (anderson_PN)) (UseComp (CompAP (PositA (present8attending_A))))))))))));
lin s_263_4_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (UseComp (CompAP (PositA (present8attending_A)))) (SubjS (after_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (anderson_PN)) (UseComp (CompAP (PositA (present8attending_A)))))))))));

lin s_264_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (UseV (leave_V)))));
lin s_264_2_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (UseV (leave_V)))));
lin s_264_3_p = s_261_1_p;
lin s_264_4_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (jones_PN)) (AdvVP (UseV (leave_V)) (SubjS (after_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (UseV (leave_V))))))))));
lin s_264_5_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (AdvVP (UseV (leave_V)) (SubjS (after_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (UseV (leave_V)))))))));

lin s_265_1_p = s_264_1_p;
lin s_265_2_p = s_264_2_p;
lin s_265_3_p = s_262_1_p;
lin s_265_4_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (jones_PN)) (AdvVP (UseV (leave_V)) (SubjS (before_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (UseV (leave_V))))))))));
lin s_265_5_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (AdvVP (UseV (leave_V)) (SubjS (before_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (UseV (leave_V)))))))));

lin s_266_1_p = s_264_1_p;
lin s_266_2_p = s_264_2_p;
lin s_266_3_p = s_265_5_h;
lin s_266_4_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (AdvVP (UseV (leave_V)) (SubjS (after_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (UseV (leave_V))))))))));
lin s_266_5_h = s_262_1_p;

lin s_267_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (ComplSlash (SlashV2a (revise_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (contract_N)))))));
lin s_267_2_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a (revise_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (contract_N)))))));
lin s_267_3_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (AdvVP (ComplSlash (SlashV2a (revise_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (contract_N)))) (SubjS (before_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (ComplVV (do_VV) (elliptic_VP)))))))));
lin s_267_4_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a (revise_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (contract_N)))) (SubjS (after_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (ComplVV (do_VV) (elliptic_VP))))))))));
lin s_267_5_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a (revise_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (contract_N)))) (SubjS (after_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (ComplVV (do_VV) (elliptic_VP)))))))));

lin s_268_1_p = s_267_1_p;
lin s_268_2_p = s_267_2_p;
lin s_268_3_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (AdvVP (ComplSlash (SlashV2a (revise_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (contract_N)))) (SubjS (after_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (ComplVV (do_VV) (elliptic_VP)))))))));
lin s_268_4_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a (revise_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (contract_N)))) (SubjS (before_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (ComplVV (do_VV) (elliptic_VP))))))))));
lin s_268_5_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a (revise_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (contract_N)))) (SubjS (before_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (ComplVV (do_VV) (elliptic_VP)))))))));

lin s_269_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (UseV (swim_V)))));
lin s_269_2_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (UseV (swim_V)))));
lin s_269_3_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (UseV (swim_V)) (SubjS (before_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (UseV (swim_V)))))))));
lin s_269_4_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (jones_PN)) (AdvVP (UseV (swim_V)) (SubjS (after_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (UseV (swim_V))))))))));
lin s_269_5_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (AdvVP (UseV (swim_V)) (SubjS (after_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (UseV (swim_V)))))))));

lin s_270_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (UseV (swim_V)) (PrepNP (to_Prep) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (shore_N))))))));
lin s_270_2_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (AdvVP (UseV (swim_V)) (PrepNP (to_Prep) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (shore_N))))))));
lin s_270_3_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (AdvVP (UseV (swim_V)) (PrepNP (to_Prep) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (shore_N))))) (SubjS (before_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (AdvVP (UseV (swim_V)) (PrepNP (to_Prep) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (shore_N))))))))))));
lin s_270_4_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (jones_PN)) (AdvVP (AdvVP (UseV (swim_V)) (PrepNP (to_Prep) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (shore_N))))) (SubjS (after_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (UseV (swim_V)) (PrepNP (to_Prep) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (shore_N)))))))))))));
lin s_270_5_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (AdvVP (AdvVP (UseV (swim_V)) (PrepNP (to_Prep) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (shore_N))))) (SubjS (after_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (UseV (swim_V)) (PrepNP (to_Prep) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (shore_N))))))))))));

lin s_271_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (UseComp (CompAP (PositA (present8attending_A)))))));
lin s_271_2_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (UseComp (CompAP (PositA (present8attending_A)))))));
lin s_271_3_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (UseComp (CompAP (PositA (present8attending_A)))) (SubjS (after_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (UseComp (CompAP (PositA (present8attending_A)))))))))));
lin s_271_4_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (jones_PN)) (AdvVP (UseComp (CompAP (PositA (present8attending_A)))) (SubjS (before_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (UseComp (CompAP (PositA (present8attending_A))))))))))));
lin s_271_5_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (AdvVP (UseComp (CompAP (PositA (present8attending_A)))) (SubjS (before_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (UseComp (CompAP (PositA (present8attending_A)))))))))));

lin s_272_1_p = s_271_1_p;
lin s_272_2_p = s_271_2_p;
lin s_272_3_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (UseComp (CompAP (PositA (present8attending_A)))) (SubjS (before_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (UseComp (CompAP (PositA (present8attending_A)))))))))));
lin s_272_4_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (jones_PN)) (AdvVP (UseComp (CompAP (PositA (present8attending_A)))) (SubjS (after_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (UseComp (CompAP (PositA (present8attending_A))))))))))));
lin s_272_5_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (AdvVP (UseComp (CompAP (PositA (present8attending_A)))) (SubjS (after_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (UseComp (CompAP (PositA (present8attending_A)))))))))));

lin s_273_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (ProgrVPa (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (report_N))))))));
lin s_273_2_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (ProgrVPa (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (report_N))))))));
lin s_273_3_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (ProgrVPa (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (report_N))))) (SubjS (before_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (ProgrVPa (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (report_N))))))))))));
lin s_273_4_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (jones_PN)) (AdvVP (ProgrVPa (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (report_N))))) (SubjS (after_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (ProgrVPa (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (report_N)))))))))))));
lin s_273_5_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (AdvVP (ProgrVPa (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (report_N))))) (SubjS (after_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (ProgrVPa (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (report_N))))))))))));

lin s_274_1_p = s_273_1_p;
lin s_274_2_p = s_273_2_p;
lin s_274_3_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (ProgrVPa (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (report_N))))) (SubjS (after_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (ProgrVPa (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (report_N))))))))))));
lin s_274_4_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (jones_PN)) (AdvVP (ProgrVPa (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (report_N))))) (SubjS (before_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (ProgrVPa (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (report_N)))))))))))));
lin s_274_5_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (AdvVP (ProgrVPa (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (report_N))))) (SubjS (before_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (ProgrVPa (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (report_N))))))))))));

lin s_275_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a (leave_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (meeting_N)))) (SubjS (before_Subj) (UseCl (Past) (PPos) (PredVP (UsePron (he_Pron)) (ComplSlash (SlashV2a (lose_V2)) (DetCN (DetQuant (PossPron (heRefl_Pron)) (NumSg)) (UseN (temper_N)))))))))));
lin s_275_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a (lose_V2)) (DetCN (DetQuant (PossPron (heRefl_Pron)) (NumSg)) (UseN (temper_N))))))));
lin s_275_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a (lose_V2)) (DetCN (DetQuant (PossPron (heRefl_Pron)) (NumSg)) (UseN (temper_N)))))));

lin s_276_1_p = (Sentence (ExtAdvS (SubjS (when_Subj) (UseCl (Past) (PPos) (PredVP (UsePron (they_Pron)) (ComplSlash (SlashV2a (open_V2)) (UsePN (the_m25_PN)))))) (UseCl (Past) (PPos) (PredVP (MassNP (UseN (traffic_N))) (UseV (increase_V))))));

lin s_277_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (AdvVP (UseV (live_V)) (PrepNP (in_Prep) (UsePN (birmingham_PN)))) (in_1991_Adv)))));
lin s_277_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (AdvVP (AdvVP (UseV (live_V)) (PrepNP (in_Prep) (UsePN (birmingham_PN)))) (in_1992_Adv))))));
lin s_277_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (AdvVP (UseV (live_V)) (PrepNP (in_Prep) (UsePN (birmingham_PN)))) (in_1992_Adv)))));

lin s_278_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuantOrd (PossPron (heRefl_Pron)) (NumSg) (OrdNumeral (N_one))) (UseN (novel_N)))) (in_1991_Adv)))));
lin s_278_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuantOrd (PossPron (heRefl_Pron)) (NumSg) (OrdNumeral (N_one))) (UseN (novel_N)))) (in_1992_Adv))))));
lin s_278_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuantOrd (PossPron (heRefl_Pron)) (NumSg) (OrdNumeral (N_one))) (UseN (novel_N)))) (in_1992_Adv)))));

lin s_279_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (novel_N)))) (in_1991_Adv)))));
lin s_279_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a (write_V2)) (UsePron (it_Pron))) (in_1992_Adv))))));
lin s_279_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a (write_V2)) (UsePron (it_Pron))) (in_1992_Adv)))));

lin s_280_1_p = s_279_1_p;
lin s_280_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (novel_N)))) (in_1992_Adv))))));
lin s_280_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (novel_N)))) (in_1992_Adv)))));

lin s_281_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (ProgrVPa (ComplSlash (SlashV2a (run_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (business_N))))) (in_1991_Adv)))));
lin s_281_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (AdvVP (ProgrVPa (ComplSlash (SlashV2a (run_V2)) (UsePron (it_Pron)))) (in_1992_Adv))))));
lin s_281_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (ProgrVPa (ComplSlash (SlashV2a (run_V2)) (UsePron (it_Pron)))) (in_1992_Adv)))));

lin s_282_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a (discover_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdjCN (PositA (new_A)) (UseN (species_N))))) (in_1991_Adv)))));
lin s_282_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a (discover_V2)) (UsePron (it_Pron))) (in_1992_Adv))))));
lin s_282_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a (discover_V2)) (UsePron (it_Pron))) (in_1992_Adv)))));

lin s_283_1_p = s_282_1_p;
lin s_283_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a (discover_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdjCN (PositA (new_A)) (UseN (species_N))))) (in_1992_Adv))))));
lin s_283_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a (discover_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdjCN (PositA (new_A)) (UseN (species_N))))) (in_1992_Adv)))));

lin s_284_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (report_N)))) (in_two_hours_Adv)))));
lin s_284_2_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (ComplVV (start_VV) (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (report_N))))) (at_8_am_Adv)))));
lin s_284_3_q = (Question (UseQCl (PastPerfect) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (AdvVP (ComplVV (finish_VV) (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (report_N))))) (by_11_am_Adv))))));
lin s_284_4_h = (Sentence (UseCl (PastPerfect) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (ComplVV (finish_VV) (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (report_N))))) (by_11_am_Adv)))));

lin s_285_1_p = s_284_1_p;
lin s_285_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a (spend_V2)) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_two)))) (AdjCN (PartVP (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (report_N))))) (UseN (hour_N)))))))));
lin s_285_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a (spend_V2)) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_two)))) (AdjCN (PartVP (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (report_N))))) (UseN (hour_N))))))));

lin s_286_1_p = s_284_1_p;
lin s_286_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a (spend_V2)) (DetCN (DetQuant (IndefArt) (NumCard (AdNum (more_than_AdN) (NumNumeral (N_two))))) (AdjCN (PartVP (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (report_N))))) (UseN (hour_N)))))))));
lin s_286_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a (spend_V2)) (DetCN (DetQuant (IndefArt) (NumCard (AdNum (more_than_AdN) (NumNumeral (N_two))))) (AdjCN (PartVP (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (report_N))))) (UseN (hour_N))))))));

lin s_287_1_p = s_284_1_p;
lin s_287_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (report_N)))) (in_one_hour_Adv))))));
lin s_287_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (report_N)))) (in_one_hour_Adv)))));

lin s_288_1_p = s_284_1_p;
lin s_288_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (report_N))))))));
lin s_288_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (report_N)))))));

lin s_289_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a (discover_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdjCN (PositA (new_A)) (UseN (species_N))))) (in_two_hours_Adv)))));
lin s_289_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a (spend_V2)) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_two)))) (SentCN (UseN (hour_N)) (EmbedPresPart (ComplSlash (SlashV2a (discover_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (AdjCN (PositA (new_A)) (UseN (species_N)))))))))))));
lin s_289_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a (spend_V2)) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_two)))) (SentCN (UseN (hour_N)) (EmbedPresPart (ComplSlash (SlashV2a (discover_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (AdjCN (PositA (new_A)) (UseN (species_N))))))))))));

lin s_290_1_p = s_289_1_p;
lin s_290_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a (discover_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdjCN (PositA (new_A)) (UseN (species_N)))))))));
lin s_290_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a (discover_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdjCN (PositA (new_A)) (UseN (species_N))))))));

lin s_291_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a (discover_V2)) (DetCN (many_Det) (AdjCN (PositA (new_A)) (UseN (species_N))))) (in_two_hours_Adv)))));
lin s_291_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a (spend_V2)) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_two)))) (SentCN (UseN (hour_N)) (EmbedPresPart (ComplSlash (SlashV2a (discover_V2)) (MassNP (AdjCN (PositA (new_A)) (UseN (species_N)))))))))))));
lin s_291_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a (spend_V2)) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_two)))) (SentCN (UseN (hour_N)) (EmbedPresPart (ComplSlash (SlashV2a (discover_V2)) (MassNP (AdjCN (PositA (new_A)) (UseN (species_N))))))))))));

lin s_292_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (ProgrVPa (ComplSlash (SlashV2a (run_V2)) (DetCN (DetQuant (PossPron (heRefl_Pron)) (NumSg)) (AdjCN (PositA (own_A)) (UseN (business_N)))))) (PrepNP (in_Prep) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_two)))) (UseN (year_N))))))));
lin s_292_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a (spend_V2)) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_two)))) (SentCN (UseN (year_N)) (EmbedPresPart (ComplSlash (SlashV2a (run_V2)) (DetCN (DetQuant (PossPron (heRefl_Pron)) (NumSg)) (AdjCN (PositA (own_A)) (UseN (business_N)))))))))))));
lin s_292_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a (spend_V2)) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_two)))) (SentCN (UseN (year_N)) (EmbedPresPart (ComplSlash (SlashV2a (run_V2)) (DetCN (DetQuant (PossPron (heRefl_Pron)) (NumSg)) (AdjCN (PositA (own_A)) (UseN (business_N))))))))))));

lin s_293_1_p = s_292_1_p;
lin s_293_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a (spend_V2)) (DetCN (DetQuant (IndefArt) (NumCard (AdNum (more_than_AdN) (NumNumeral (N_two))))) (SentCN (UseN (year_N)) (EmbedPresPart (ComplSlash (SlashV2a (run_V2)) (DetCN (DetQuant (PossPron (heRefl_Pron)) (NumSg)) (AdjCN (PositA (own_A)) (UseN (business_N)))))))))))));
lin s_293_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a (spend_V2)) (DetCN (DetQuant (IndefArt) (NumCard (AdNum (more_than_AdN) (NumNumeral (N_two))))) (SentCN (UseN (year_N)) (EmbedPresPart (ComplSlash (SlashV2a (run_V2)) (DetCN (DetQuant (PossPron (heRefl_Pron)) (NumSg)) (AdjCN (PositA (own_A)) (UseN (business_N))))))))))));

lin s_294_1_p = s_292_1_p;
lin s_294_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a (run_V2)) (DetCN (DetQuant (PossPron (heRefl_Pron)) (NumSg)) (AdjCN (PositA (own_A)) (UseN (business_N)))))))));
lin s_294_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a (run_V2)) (DetCN (DetQuant (PossPron (heRefl_Pron)) (NumSg)) (AdjCN (PositA (own_A)) (UseN (business_N))))))));

lin s_295_1_p = (Sentence (AdvS (PrepNP (in_Prep) (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_two)))) (UseN (year_N)))) (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a (own_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdvCN (UseN (chain_N)) (PrepNP (part_Prep) (DetCN (DetQuant (IndefArt) (NumPl)) (UseN (business_N)))))))))));
lin s_295_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a (own_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdvCN (UseN (chain_N)) (PrepNP (part_Prep) (MassNP (UseN (business_N))))))) (for_two_years_Adv))))));
lin s_295_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a (own_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdvCN (UseN (chain_N)) (PrepNP (part_Prep) (MassNP (UseN (business_N))))))) (for_two_years_Adv)))));

lin s_296_1_p = s_295_1_p;
lin s_296_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a (own_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdvCN (UseN (chain_N)) (PrepNP (part_Prep) (MassNP (UseN (business_N))))))) (for_more_than_two_years_Adv))))));
lin s_296_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a (own_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdvCN (UseN (chain_N)) (PrepNP (part_Prep) (MassNP (UseN (business_N))))))) (for_more_than_two_years_Adv)))));

lin s_297_1_p = s_295_1_p;
lin s_297_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a (own_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdvCN (UseN (chain_N)) (PrepNP (part_Prep) (MassNP (UseN (business_N)))))))))));
lin s_297_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a (own_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdvCN (UseN (chain_N)) (PrepNP (part_Prep) (MassNP (UseN (business_N))))))))));

lin s_298_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (AdvVP (UseV (live_V)) (PrepNP (in_Prep) (UsePN (birmingham_PN)))) (for_two_years_Adv)))));
lin s_298_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (AdvVP (AdvVP (UseV (live_V)) (PrepNP (in_Prep) (UsePN (birmingham_PN)))) (for_a_year_Adv))))));
lin s_298_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (AdvVP (UseV (live_V)) (PrepNP (in_Prep) (UsePN (birmingham_PN)))) (for_a_year_Adv)))));

lin s_299_1_p = s_298_1_p;
lin s_299_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (AdvVP (AdvVP (UseV (live_V)) (PrepNP (in_Prep) (UsePN (birmingham_PN)))) (for_exactly_a_year_Adv))))));
lin s_299_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (AdvVP (UseV (live_V)) (PrepNP (in_Prep) (UsePN (birmingham_PN)))) (for_exactly_a_year_Adv)))));

lin s_300_1_p = s_298_1_p;
lin s_300_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (AdvVP (UseV (live_V)) (PrepNP (in_Prep) (UsePN (birmingham_PN))))))));
lin s_300_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (UseV (live_V)) (PrepNP (in_Prep) (UsePN (birmingham_PN)))))));

lin s_301_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a (run_V2)) (DetCN (DetQuant (PossPron (heRefl_Pron)) (NumSg)) (AdjCN (PositA (own_A)) (UseN (business_N))))) (for_two_years_Adv)))));
lin s_301_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a (run_V2)) (DetCN (DetQuant (PossPron (heRefl_Pron)) (NumSg)) (AdjCN (PositA (own_A)) (UseN (business_N))))) (for_a_year_Adv))))));
lin s_301_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a (run_V2)) (DetCN (DetQuant (PossPron (heRefl_Pron)) (NumSg)) (AdjCN (PositA (own_A)) (UseN (business_N))))) (for_a_year_Adv)))));

lin s_302_1_p = s_301_1_p;
lin s_302_2_q = s_294_2_q;
lin s_302_3_h = s_294_3_h;

lin s_303_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (report_N)))) (for_two_hours_Adv)))));
lin s_303_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (report_N)))) (for_an_hour_Adv))))));
lin s_303_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (report_N)))) (for_an_hour_Adv)))));

lin s_304_1_p = s_303_1_p;
lin s_304_2_q = s_288_2_q;
lin s_304_3_h = s_288_3_h;

lin s_305_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a (discover_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdjCN (PositA (new_A)) (UseN (species_N))))) (for_an_hour_Adv)))));

lin s_306_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a (discover_V2)) (DetCN (DetQuant (IndefArt) (NumPl)) (AdjCN (PositA (new_A)) (UseN (species_N))))) (for_two_years_Adv)))));
lin s_306_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a (discover_V2)) (DetCN (DetQuant (IndefArt) (NumPl)) (AdjCN (PositA (new_A)) (UseN (species_N)))))))));
lin s_306_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a (discover_V2)) (DetCN (DetQuant (IndefArt) (NumPl)) (AdjCN (PositA (new_A)) (UseN (species_N))))))));

lin s_307_1_p = (Sentence (AdvS (in_1994_Adv) (UseCl (Past) (PPos) (PredVP (UsePN (itel_PN)) (AdvVP (ComplSlash (SlashV2a (send_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (progress_report_N)))) (every_month_Adv))))));
lin s_307_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (itel_PN)) (AdvVP (ComplSlash (SlashV2a (send_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (progress_report_N)))) (in_july_1994_Adv))))));
lin s_307_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (itel_PN)) (AdvVP (ComplSlash (SlashV2a (send_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (progress_report_N)))) (in_july_1994_Adv)))));

lin s_308_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a (write_to_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (representative_N)))) (every_week_Adv)))));
lin s_308_2_q = (Question (UseQCl (Present) (PPos) (QuestCl (ExistNP (DetCN (DetQuant (IndefArt) (NumSg)) (AdvCN (RelCN (UseN (representative_N)) (UseRCl (Past) (PPos) (StrandRelSlash (that_RP) (SlashVP (UsePN (smith_PN)) (SlashV2a (write_to_V2)))))) (every_week_Adv)))))));
lin s_308_3_h = (Sentence (UseCl (Present) (PPos) (ExistNP (DetCN (DetQuant (IndefArt) (NumSg)) (AdvCN (RelCN (UseN (representative_N)) (UseRCl (Past) (PPos) (StrandRelSlash (that_RP) (SlashVP (UsePN (smith_PN)) (SlashV2a (write_to_V2)))))) (every_week_Adv))))));

lin s_309_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a (leave_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (house_N)))) (at_a_quarter_past_five_Adv)))));
lin s_309_2_p = (Sentence (PredVPS (UsePron (she_Pron)) (ConjVPS2 (and_Conj) (Past) (PPos) (ComplSlash (SlashV2a (take_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdvCN (UseN (taxi_N)) (PrepNP (to_Prep) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (station_N))))))) (Past) (PPos) (ComplSlash (SlashV2a (catch_V2)) (DetCN (DetQuantOrd (DefArt) (NumSg) (OrdNumeral (N_one))) (AdvCN (UseN (train_N)) (PrepNP (to_Prep) (UsePN (luxembourg_PN)))))))));

lin s_310_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a (lose_V2)) (DetCN (somePl_Det) (UseN (file_N)))))));
lin s_310_2_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePron (they_Pron)) (AdvVP (PassV2s (destroy_V2)) (SubjS (when_Subj) (UseCl (Past) (PPos) (PredVP (DetCN (DetQuant (PossPron (she_Pron)) (NumSg)) (UseN (hard_disk_N))) (UseV (crash_V)))))))));

lin s_311_1_p = (Sentence (UseCl (PastPerfect) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a (leave_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (house_N)))) (at_a_quarter_past_five_Adv)))));
lin s_311_2_p = (PSentence (then_PConj) (UseCl (Past) (PPos) (PredVP (UsePron (she_Pron)) (ComplSlash (SlashV2a (take_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (AdvCN (UseN (taxi_N)) (PrepNP (to_Prep) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (station_N))))))))));
lin s_311_3_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a (leave_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (house_N)))) (SubjS (before_Subj) (UseCl (Past) (PPos) (PredVP (UsePron (she_Pron)) (AdvVP (ComplSlash (SlashV2a (take_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (taxi_N)))) (PrepNP (to_Prep) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (station_N)))))))))))));
lin s_311_4_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a (leave_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (house_N)))) (SubjS (before_Subj) (UseCl (Past) (PPos) (PredVP (UsePron (she_Pron)) (AdvVP (ComplSlash (SlashV2a (take_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (taxi_N)))) (PrepNP (to_Prep) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (station_N))))))))))));

lin s_312_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (itel_PN)) (AdVVP (always_AdV) (AdvVP (ComplSlash (SlashV2a (deliver_V2)) (DetCN (DetQuant (IndefArt) (NumPl)) (UseN (report_N)))) (late_Adv))))));
lin s_312_2_p = (Sentence (AdvS (in_1993_Adv) (UseCl (Past) (PPos) (PredVP (UsePN (itel_PN)) (ComplSlash (SlashV2a (deliver_V2)) (DetCN (DetQuant (IndefArt) (NumPl)) (UseN (report_N))))))));
lin s_312_3_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (itel_PN)) (AdvVP (AdvVP (ComplSlash (SlashV2a (deliver_V2)) (DetCN (DetQuant (IndefArt) (NumPl)) (UseN (report_N)))) (late_Adv)) (in_1993_Adv))))));
lin s_312_4_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (itel_PN)) (AdvVP (AdvVP (ComplSlash (SlashV2a (deliver_V2)) (DetCN (DetQuant (IndefArt) (NumPl)) (UseN (report_N)))) (late_Adv)) (in_1993_Adv)))));

lin s_313_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (itel_PN)) (AdVVP (never_AdV) (AdvVP (ComplSlash (SlashV2a (deliver_V2)) (DetCN (DetQuant (IndefArt) (NumPl)) (UseN (report_N)))) (late_Adv))))));
lin s_313_2_p = s_312_2_p;
lin s_313_3_q = s_312_3_q;
lin s_313_4_h = s_312_4_h;

lin s_314_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (ComplSlash (SlashV2a arrive_in_V2) (UsePN (paris_PN))) (on_the_5th_of_may_1995_Adv)))));
lin s_314_2_p = (Sentence (UseCl (Present) (PPos) (PredVP (MassNP (UseN (today_N))) (UseComp (CompAdv (the_15th_of_may_1995_Adv))))));
lin s_314_3_p = (Sentence (UseCl (Present) (PPos) (PredVP (UsePron (she_Pron)) (AdVVP (still_AdV) (UseComp (CompAdv (PrepNP (in_Prep) (UsePN (paris_PN)))))))));
lin s_314_4_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (AdvVP (UseComp (CompAdv (PrepNP (in_Prep) (UsePN (paris_PN))))) (on_the_7th_of_may_1995_Adv))))));
lin s_314_5_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (UseComp (CompAdv (PrepNP (in_Prep) (UsePN (paris_PN))))) (on_the_7th_of_may_1995_Adv)))));

lin s_315_1_p = (Sentence (AdvS (SubjS (when_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a arrive_in_V2) (UsePN (katmandu_PN)))))) (UseCl (PastPerfect) (PPos) (PredVP (UsePron (she_Pron)) (AdvVP (ProgrVPa (UseV (travel_V))) (for_three_days_Adv))))));
lin s_315_2_q = variants{};
lin s_315_3_h = variants{};
lin s_315_3_h_NEW = (Sentence (UseCl (PastPerfect) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (ProgrVPa (UseV (travel_V))) (PrepNP (on_Prep) (DetCN (DetQuant (DefArt) (NumSg)) (AdvCN (UseN (day_N)) (SubjS (before_Subj) (UseCl (Past) (PPos) (PredVP (UsePron (she_Pron)) (ComplSlash (SlashV2a arrive_in_V2) (UsePN (katmandu_PN)))))))))))));

lin s_316_1_p = (Sentence (PredVPS (UsePN (jones_PN)) (ConjVPS2 (and_Conj) (Past) (PPos) (AdvVP (UseV (graduate_V)) (in_march_Adv)) (PresentPerfect) (PPos) (AdvVP (UseComp (CompAP (PositA (employed_A)))) (ever_since_Adv)))));
lin s_316_2_p = (Sentence (UseCl (PresentPerfect) (PPos) (PredVP (UsePN (jones_PN)) (AdvVP (UseComp (CompAP (PositA (unemployed_A)))) (in_the_past_Adv)))));
lin s_316_3_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (jones_PN)) (AdvVP (AdvVP (UseComp (CompAP (PositA (unemployed_A)))) (at_some_time_Adv)) (SubjS (before_Subj) (UseCl (Past) (PPos) (PredVP (UsePron (he_Pron)) (UseV (graduate_V))))))))));
lin s_316_4_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (AdvVP (AdvVP (UseComp (CompAP (PositA (unemployed_A)))) (at_some_time_Adv)) (SubjS (before_Subj) (UseCl (Past) (PPos) (PredVP (UsePron (he_Pron)) (UseV (graduate_V)))))))));

lin s_317_1_p = (Sentence (UseCl (PresentPerfect) (PPos) (PredVP (DetCN (every_Det) (UseN (representative_N))) (ComplSlash (SlashV2a (read_V2)) (DetCN (DetQuant (this_Quant) (NumSg)) (UseN (report_N)))))));
lin s_317_2_p = (Sentence (UseCl (PresentPerfect) (PPos) (PredVP (DetCN (DetQuant (no_Quant) (NumCard (NumNumeral (N_two)))) (UseN (representative_N))) (AdvVP (ComplSlash (SlashV2a (read_V2)) (UsePron (it_Pron))) (at_the_same_time_Adv)))));
lin s_317_3_p = (Sentence (UseCl (Past) (PPos) (PredVP (DetCN (DetQuant (no_Quant) (NumSg)) (UseN (representative_N))) (ComplSlash (SlashV2V (take_V2V) (ComplSlash (SlashV2a (read_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (report_N))))) (DetCN (DetQuant (IndefArt) (NumCard (AdNum (less_than_AdN) (half_a_Card)))) (UseN (day_N)))))));
lin s_317_4_p = (Sentence (UseCl (Present) (PPos) (ExistNP (DetCN (DetQuant (IndefArt) (NumCard (NumNumeral (N_sixteen)))) (UseN (representative_N))))));
lin s_317_5_q = (Question (UseQCl (Past) (PPos) (QuestCl (ImpersCl (ComplSlash (SlashV2V (take_V2V) (ComplSlash (SlashV2a (read_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (report_N))))) (DetCN (DetQuant (DefArt) (NumPl)) (AdjCN (ComparA (many_A) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (week_N)))) (UseN (representative_N)))))))));
lin s_317_6_h = (Sentence (UseCl (Past) (PPos) (ImpersCl (ComplSlash (SlashV2V (take_V2V) (ComplSlash (SlashV2a (read_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (report_N))))) (DetCN (DetQuant (DefArt) (NumPl)) (AdjCN (ComparA (many_A) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (week_N)))) (UseN (representative_N))))))));

lin s_318_1_p = (Sentence (ExtAdvS (SubjS (while_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (ProgrVPa (ComplSlash (SlashV2a (update_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (program_N)))))))) (PredVPS (UsePN (mary_PN)) (ConjVPS2 (and_Conj) (Past) (PPos) (UseV (come_in_V)) (Past) (PPos) (ComplSlash (Slash3V3 (tell_about_V3) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (board_meeting_N)))) (UsePron (he_Pron)))))));
lin s_318_2_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePron (she_Pron)) (AdvVP (ComplVV (finish_VV) (elliptic_VP)) (SubjS (before_Subj) (UseCl (Past) (PPos) (PredVP (UsePron (he_Pron)) (ComplVV (do_VV) (elliptic_VP)))))))));
lin s_318_3_q = variants{};
lin s_318_4_h = variants{};

lin s_319_1_p = (Sentence (ExtAdvS (SubjS (before_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (apcom_PN)) (ComplSlash (SlashV2a (buy_V2)) (DetCN (DetQuant (PossPron (itRefl_Pron)) (NumSg)) (AdjCN (PositA (present8current_A)) (UseN (office_building_N)))))))) (UseCl (PastPerfect) (PPos) (ImpersCl (AdvVP (AdvVP (ProgrVPa (ComplSlash (SlashV2a (pay_V2)) (MassNP (UseN (mortgage_interest_N))))) (PrepNP (on_Prep) (DetCN (DetQuant (DefArt) (NumSg)) (AdjCN (PositA (previous_A)) (UseN (one_N)))))) (for_8_years_Adv))))));
lin s_319_2_p = (Sentence (AdvS (SubjS (since_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (apcom_PN)) (ComplSlash (SlashV2a (buy_V2)) (DetCN (DetQuant (PossPron (itRefl_Pron)) (NumSg)) (AdjCN (PositA (present8current_A)) (UseN (office_building_N)))))))) (UseCl (PresentPerfect) (PPos) (ImpersCl (AdvVP (AdvVP (ProgrVPa (ComplSlash (SlashV2a (pay_V2)) (MassNP (UseN (mortgage_interest_N))))) (PrepNP (on_Prep) (UsePron (it_Pron)))) (for_more_than_10_years_Adv))))));
lin s_319_3_q = (Question (UseQCl (PresentPerfect) (PPos) (QuestCl (PredVP (UsePN (apcom_PN)) (AdvVP (ProgrVPa (ComplSlash (SlashV2a (pay_V2)) (MassNP (UseN (mortgage_interest_N))))) (for_a_total_of_15_years_or_more_Adv))))));
lin s_319_4_h = (Sentence (UseCl (PresentPerfect) (PPos) (PredVP (UsePN (apcom_PN)) (AdvVP (ProgrVPa (ComplSlash (SlashV2a (pay_V2)) (MassNP (UseN (mortgage_interest_N))))) (for_a_total_of_15_years_or_more_Adv)))));

lin s_320_1_p = (Sentence (ExtAdvS (SubjS (when_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (ComplSlash (SlashV2a (get_V2)) (DetCN (DetQuant (PossPron (heRefl_Pron)) (NumSg)) (AdvCN (UseN (job_N)) (PrepNP (at_Prep) (UsePN (the_cia_PN))))))))) (UseCl (Past) (PPos) (PredVP (UsePron (he_Pron)) (ComplVS (know_VS) (UseCl (Conditional) (PPos) (PredVP (UsePron (he_Pron)) (AdVVP (never_AdV) (PassVPSlash (SlashV2V (allow_V2V) (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (PossPron (heRefl_Pron)) (NumPl)) (UseN (memoir_N))))))))))))));
lin s_320_2_q = variants{};
lin s_320_3_h = variants{};
lin s_320_3_h_NEW = (Sentence (UseCl (Present) (PPos) (ImpersCl (AdvVP (UseComp (CompNP (DetCN (DetQuant (DefArt) (NumSg)) (UseN (case_N))))) (SubjS (that_Subj) (PredVPS (UsePN (jones_PN)) (ConjVPS2 (and_Conj) (Present) (UncNeg) (PassVPSlash (elliptic_VPSlash)) (Future) (PPos) (AdVVP (never_AdV) (PassVPSlash (SlashV2V (allow_V2V) (ComplSlash (SlashV2a (write_V2)) (DetCN (DetQuant (PossPron (heRefl_Pron)) (NumPl)) (UseN (memoir_N))))))))))))));

lin s_321_1_p = (Sentence (UseCl (PresentPerfect) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (AdvVP (UseComp (CompAdv (PrepNP (to_Prep) (UsePN (florence_PN))))) (twice_Adv)) (in_the_past_Adv)))));
lin s_321_2_p = (Sentence (UseCl (Future) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (AdvVP (AdvVP (UseV (go8travel_V)) (PrepNP (to_Prep) (UsePN (florence_PN)))) (twice_Adv)) (in_the_coming_year_Adv)))));
lin s_321_3_q = variants{};
lin s_321_4_h = (Sentence (AdvS (two_years_from_now_Adv) (UseCl (FuturePerfect) (PPos) (PredVP (UsePN (smith_PN)) (AdvVP (UseComp (CompAdv (PrepNP (to_Prep) (UsePN (florence_PN))))) (at_least_four_times))))));

lin s_322_1_p = variants{};
lin s_322_1_p_NEW = (Sentence (AdvS (last_week_Adv) (UseCl (Past) (PPos) (PredVP (UsePron (i_Pron)) (AdVVP (already_AdV) (ComplVS (know_VS) (ExtAdvS (SubjS (when_Subj) (ExtAdvS (in_a_months_time_Adv) (UseCl (Conditional) (PPos) (PredVP (UsePN (smith_PN)) (ComplVS (discover_VS) (UseCl (PastPerfect) (PPos) (PredVP (UsePron (she_Pron)) (PassV2 (dupe_V2))))))))) (UseCl (Conditional) (PPos) (PredVP (UsePron (she_Pron)) (UseComp (CompAP (PositA (furious_A)))))))))))));
lin s_322_2_q = variants{};
lin s_322_3_h = (Sentence (UseCl (Future) (PPos) (ImpersCl (AdvVP (UseComp (CompNP (DetCN (DetQuant (DefArt) (NumSg)) (UseN (case_N))))) (SubjS (that_Subj) (ConjS2 (semicolon_and_Conj) (AdvS (in_a_few_weeks_Adv) (UseCl (Future) (PPos) (PredVP (UsePN (smith_PN)) (ComplVS (discover_VS) (UseCl (PresentPerfect) (PPos) (PredVP (UsePron (she_Pron)) (PassV2 (dupe_V2)))))))) (UseCl (Future) (PPos) (PredVP (UsePron (she_Pron)) (UseComp (CompAP (PositA (furious_A))))))))))));

lin s_323_1_p = variants{};
lin s_323_1_p_NEW = (Sentence (UseCl (Present) (PPos) (PredVP (RelNPa (UsePron (no_one_Pron)) (UseRCl (Present) (PPos) (RelVP (IdRP) (AdvVP (ProgrVPa (UseV (gamble_V))) (PositAdvAdj (serious_A)))))) (AdvVP (UseV (stop_V)) (SubjS (until_Subj) (UseCl (Present) (PPos) (PredVP (UsePron (he_Pron)) (UseComp (CompAP (PositA (broke_A)))))))))));
lin s_323_2_p = (Sentence (UseCl (Present) (PPos) (PredVP (UsePron (no_one_Pron)) (ComplVV (can_VV) (AdvVP (UseV (gamble_V)) (SubjS (when_Subj) (UseCl (Present) (PPos) (PredVP (UsePron (he_Pron)) (UseComp (CompAP (PositA (broke_A))))))))))));
lin s_323_3_q = variants{};
lin s_323_4_h = variants{};
lin s_323_4_h_NEW = (Sentence (UseCl (Present) (PPos) (PredVP (RelNPa (UsePron (everyone_Pron)) (UseRCl (Present) (PPos) (RelVP (IdRP) (ComplVV (start_VV) (AdvVP (UseV (gamble_V)) (PositAdvAdj (serious_A))))))) (AdvVP (UseV (stop_V)) (PrepNP (at_Prep) (DetCN (DetQuant (DefArt) (NumSg)) (AdvCN (UseN (moment_N)) (SubjS (when_Subj) (UseCl (Present) (PPos) (PredVP (UsePron (he_Pron)) (UseComp (CompAP (PositA (broke_A))))))))))))));

lin s_324_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (RelNPa (UsePron (no_one_Pron)) (UseRCl (Present) (PPos) (RelVP (IdRP) (ComplVV (start_VV) (AdvVP (UseV (gamble_V)) (PositAdvAdj (serious_A))))))) (AdvVP (UseV (stop_V)) (SubjS (until_Subj) (UseCl (Present) (PPos) (PredVP (UsePron (he_Pron)) (UseComp (CompAP (PositA (broke_A)))))))))));
lin s_324_2_q = variants{};
lin s_324_3_h = (Sentence (UseCl (Present) (PPos) (PredVP (RelNPa (UsePron (everyone_Pron)) (UseRCl (Present) (PPos) (RelVP (IdRP) (ComplVV (start_VV) (AdvVP (UseV (gamble_V)) (PositAdvAdj (serious_A))))))) (AdvVP (UseV (continue_V)) (SubjS (until_Subj) (UseCl (Present) (PPos) (PredVP (UsePron (he_Pron)) (UseComp (CompAP (PositA (broke_A)))))))))));

lin s_325_1_p = (Sentence (UseCl (Present) (PPos) (PredVP (RelNPa (UsePron (nobody_Pron)) (UseRCl (Present) (PPos) (RelVP (IdRP) (UseComp (CompAP (PositA (asleep_A))))))) (AdVVP (ever_AdV) (ComplVS (know_VS) (UseCl (Present) (PPos) (PredVP (UsePron (he_Pron)) (UseComp (CompAP (PositA (asleep_A)))))))))));
lin s_325_2_p = (PSentence (but_PConj) (UseCl (Present) (PPos) (PredVP (DetCN (somePl_Det) (UseN (person_N))) (AdvVP (ComplVS (know_VS) (UseCl (PresentPerfect) (PPos) (PredVP (UsePron (they_Pron)) (UseComp (CompAP (PositA (asleep_A))))))) (SubjS (after_Subj) (UseCl (PresentPerfect) (PPos) (PredVP (UsePron (they_Pron)) (UseComp (CompAP (PositA (asleep_A)))))))))));
lin s_325_3_q = (Question (UseQCl (Present) (PPos) (QuestCl (PredVP (DetCN (somePl_Det) (UseN (person_N))) (ComplVS (discover_VS) (UseCl (PresentPerfect) (PPos) (PredVP (UsePron (they_Pron)) (UseComp (CompAP (PositA (asleep_A)))))))))));
lin s_325_4_h = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (somePl_Det) (UseN (person_N))) (ComplVS (discover_VS) (UseCl (PresentPerfect) (PPos) (PredVP (UsePron (they_Pron)) (UseComp (CompAP (PositA (asleep_A))))))))));

lin s_326_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (itel_PN)) (AdvVP (ComplSlash (SlashV2a (build_V2)) (UsePN (mtalk_PN))) (in_1993_Adv)))));
lin s_326_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (itel_PN)) (AdvVP (ComplSlash (SlashV2a (finish_V2)) (UsePN (mtalk_PN))) (in_1993_Adv))))));
lin s_326_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (itel_PN)) (AdvVP (ComplSlash (SlashV2a (finish_V2)) (UsePN (mtalk_PN))) (in_1993_Adv)))));

lin s_327_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (itel_PN)) (AdvVP (ProgrVPa (ComplSlash (SlashV2a (build_V2)) (UsePN (mtalk_PN)))) (in_1993_Adv)))));
lin s_327_2_q = s_326_2_q;
lin s_327_3_h = s_326_3_h;

lin s_328_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (itel_PN)) (AdvVP (AdvVP (ComplSlash (SlashV2a (win_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (contract_N)))) (PrepNP (from_Prep) (UsePN (apcom_PN)))) (in_1993_Adv)))));
lin s_328_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (itel_PN)) (AdvVP (ComplSlash (SlashV2a (win_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (contract_N)))) (in_1993_Adv))))));
lin s_328_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (itel_PN)) (AdvVP (ComplSlash (SlashV2a (win_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (contract_N)))) (in_1993_Adv)))));

lin s_329_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (itel_PN)) (AdvVP (AdvVP (ProgrVPa (ComplSlash (SlashV2a (win_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (contract_N))))) (PrepNP (from_Prep) (UsePN (apcom_PN)))) (in_1993_Adv)))));
lin s_329_2_q = s_328_2_q;
lin s_329_3_h = s_328_3_h;

lin s_330_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (itel_PN)) (AdvVP (ComplSlash (SlashV2a (own_V2)) (UsePN (apcom_PN))) (from_1988_to_1992_Adv)))));
lin s_330_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (itel_PN)) (AdvVP (ComplSlash (SlashV2a (own_V2)) (UsePN (apcom_PN))) (in_1990_Adv))))));
lin s_330_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (itel_PN)) (AdvVP (ComplSlash (SlashV2a (own_V2)) (UsePN (apcom_PN))) (in_1990_Adv)))));

lin s_331_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (ConjNP2 (and_Conj) (UsePN (smith_PN)) (UsePN (jones_PN))) (ComplSlash (SlashV2a (leave_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (meeting_N)))))));
lin s_331_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a (leave_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (meeting_N))))))));
lin s_331_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2a (leave_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (meeting_N)))))));

lin s_332_1_p = s_331_1_p;
lin s_332_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (jones_PN)) (ComplSlash (SlashV2a (leave_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (meeting_N))))))));
lin s_332_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (ComplSlash (SlashV2a (leave_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (meeting_N)))))));

lin s_333_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (ConjNP3 (and_Conj) (UsePN (smith_PN)) (UsePN (anderson_PN)) (UsePN (jones_PN))) (UseV (meet_V)))));
lin s_333_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (ExistNP (DetCN (DetQuant (IndefArt) (NumSg)) (RelCN (ComplN2 group_N2 (DetCN (DetQuant (IndefArt) (NumPl)) (UseN (person_N)))) (UseRCl (Past) (PPos) (RelVP (that_RP) (UseV (meet_V))))))))));
lin s_333_3_h = (Sentence (UseCl (Past) (PPos) (ExistNP (DetCN (DetQuant (IndefArt) (NumSg)) (RelCN (ComplN2 group_N2 (DetCN (DetQuant (IndefArt) (NumPl)) (UseN (person_N)))) (UseRCl (Past) (PPos) (RelVP (that_RP) (UseV (meet_V)))))))));

lin s_334_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (ComplVS (know_VS) (UseCl (PastPerfect) (PPos) (PredVP (UsePN (itel_PN)) (AdvVP (ComplSlash (SlashV2a (win_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (contract_N)))) (in_1992_Adv))))))));
lin s_334_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (itel_PN)) (AdvVP (ComplSlash (SlashV2a (win_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (contract_N)))) (in_1992_Adv))))));
lin s_334_3_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (itel_PN)) (AdvVP (ComplSlash (SlashV2a (win_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (contract_N)))) (in_1992_Adv)))));

lin s_335_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (ComplVS (believe_VS) (UseCl (PastPerfect) (PPos) (PredVP (UsePN (itel_PN)) (AdvVP (ComplSlash (SlashV2a (win_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (contract_N)))) (in_1992_Adv))))))));
lin s_335_2_q = s_334_2_q;
lin s_335_3_h = s_334_3_h;

lin s_336_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (itel_PN)) (AdvVP (ComplVV (manage_VV) (ComplSlash (SlashV2a (win_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (contract_N))))) (in_1992_Adv)))));
lin s_336_2_q = s_334_2_q;
lin s_336_3_h = s_334_3_h;

lin s_337_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (itel_PN)) (AdvVP (ComplVV (try_VV) (ComplSlash (SlashV2a (win_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (contract_N))))) (in_1992_Adv)))));
lin s_337_2_q = s_334_2_q;
lin s_337_3_h = s_334_3_h;

lin s_338_1_p = (Sentence (UseCl (Present) (PPos) (ImpersCl (UseComp (CompAP (SentAP (PositA (true_A)) (EmbedS (UseCl (Past) (PPos) (PredVP (UsePN (itel_PN)) (AdvVP (ComplSlash (SlashV2a (win_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (contract_N)))) (in_1992_Adv)))))))))));
lin s_338_2_q = s_334_2_q;
lin s_338_3_h = s_334_3_h;

lin s_339_1_p = (Sentence (UseCl (Present) (PPos) (ImpersCl (UseComp (CompAP (SentAP (PositA (false_A)) (EmbedS (UseCl (Past) (PPos) (PredVP (UsePN (itel_PN)) (AdvVP (ComplSlash (SlashV2a (win_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (contract_N)))) (in_1992_Adv)))))))))));
lin s_339_2_q = s_334_2_q;
lin s_339_3_h = s_334_3_h;

lin s_340_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2V (see_V2V) (ComplSlash (SlashV2a (sign_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (contract_N))))) (UsePN (jones_PN))))));
lin s_340_2_p = (Sentence (ExtAdvS (SubjS (if_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (ComplSlash (SlashV2a (sign_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (contract_N))))))) (UseCl (Past) (PPos) (PredVP (DetCN (DetQuant (PossPron (he_Pron)) (NumSg)) (UseN (heart_N))) (ProgrVPa (UseV (beat_V)))))));
lin s_340_3_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2V (see_V2V) (UseV (beat_V))) (DetCN (DetQuant (GenNP (UsePN (jones_PN))) (NumSg)) (UseN (heart_N))))))));
lin s_340_4_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2V (see_V2V) (UseV (beat_V))) (DetCN (DetQuant (GenNP (UsePN (jones_PN))) (NumSg)) (UseN (heart_N)))))));

lin s_341_1_p = s_340_1_p;
lin s_341_2_p = (Sentence (ExtAdvS (SubjS (when_Subj) (UseCl (Past) (PPos) (PredVP (UsePN (jones_PN)) (ComplSlash (SlashV2a (sign_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (contract_N))))))) (UseCl (Past) (PPos) (PredVP (DetCN (DetQuant (PossPron (he_Pron)) (NumSg)) (UseN (heart_N))) (ProgrVPa (UseV (beat_V)))))));
lin s_341_3_q = s_340_3_q;
lin s_341_4_h = s_340_4_h;

lin s_342_1_p = s_341_1_p;
lin s_342_2_q = s_081_2_q;
lin s_342_3_h = s_081_3_h;

lin s_343_1_p = s_341_1_p;
lin s_343_2_p = (Sentence (UseCl (Present) (PPos) (PredVP (UsePN (jones_PN)) (UseComp (CompNP (DetCN (DetQuant (DefArt) (NumSg)) (ComplN2 (chairman_N2) (UsePN (itel_PN)))))))));
lin s_343_3_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2V (see_V2V) (ComplSlash (SlashV2a (sign_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (contract_N))))) (DetCN (DetQuant (DefArt) (NumSg)) (ComplN2 (chairman_N2) (UsePN (itel_PN)))))))));
lin s_343_4_h = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2V (see_V2V) (ComplSlash (SlashV2a (sign_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (contract_N))))) (DetCN (DetQuant (DefArt) (NumSg)) (ComplN2 (chairman_N2) (UsePN (itel_PN))))))));

lin s_344_1_p = (Sentence (UseCl (Past) (PPos) (PredVP (UsePN (helen_PN)) (ComplSlash (SlashV2V (see_V2V) (ComplSlash (SlashV2a (answer_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (phone_N))))) (DetCN (DetQuant (DefArt) (NumSg)) (ComplN2 (chairman_N2) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (department_N)))))))));
lin s_344_2_p = (Sentence (UseCl (Present) (PPos) (PredVP (DetCN (DetQuant (DefArt) (NumSg)) (ComplN2 (chairman_N2) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (department_N))))) (UseComp (CompCN (UseN (person_N)))))));
lin s_344_3_q = (Question (UseQCl (Present) (PPos) (QuestCl (ExistNP (RelNPa (UsePron (anyone_Pron)) (UseRCl (Past) (PPos) (StrandRelSlash (IdRP) (SlashVP (UsePN (helen_PN)) (SlashV2V (see_V2V) (ComplSlash (SlashV2a (answer_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (phone_N)))))))))))));
lin s_344_4_h = (Sentence (UseCl (Present) (PPos) (ExistNP (RelNPa (UsePron (someone_Pron)) (UseRCl (Past) (PPos) (StrandRelSlash (IdRP) (SlashVP (UsePN (helen_PN)) (SlashV2V (see_V2V) (ComplSlash (SlashV2a (answer_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (phone_N))))))))))));

lin s_345_1_p = (Sentence (PredVPS (UsePN (smith_PN)) (ConjVPS2 (and_Conj) (Past) (PPos) (ComplSlash (SlashV2V (see_V2V) (ComplSlash (SlashV2a (sign_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (contract_N))))) (UsePN (jones_PN))) (Past) (PPos) (ComplSlash (SlashV2V (elliptic_V2V) (ComplSlash (SlashV2a (make8do_V2)) (DetCN (DetQuant (IndefArt) (NumSg)) (UseN (copy_N))))) (DetCN (DetQuant (PossPron (heRefl_Pron)) (NumSg)) (UseN (secretary_N)))))));
lin s_345_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (ComplSlash (SlashV2V (see_V2V) (ComplSlash (SlashV2a (sign_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (contract_N))))) (UsePN (jones_PN)))))));
lin s_345_3_h = s_340_1_p;

lin s_346_1_p = (Sentence (PredVPS (UsePN (smith_PN)) (ConjVPS2 (or_Conj) (Past) (PPos) (ComplSlash (SlashV2V (see_V2V) (ComplSlash (SlashV2a (sign_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (contract_N))))) (UsePN (jones_PN))) (Past) (PPos) (ComplSlash (SlashV2V (elliptic_V2V) (ComplSlash (SlashV2a (cross_out_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (AdjCN (PositA (crucial_A)) (UseN (clause_N)))))) (elliptic_NP_Sg)))));
lin s_346_2_q = (Question (UseQCl (Past) (PPos) (QuestCl (PredVP (UsePN (smith_PN)) (ComplVPIVV (do_VV) (ConjVPI2 (either7or_DConj) (ComplSlash (SlashV2V (see_V2V) (ComplSlash (SlashV2a (sign_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (contract_N))))) (UsePN (jones_PN))) (ComplSlash (SlashV2V (see_V2V) (ComplSlash (SlashV2a (cross_out_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (AdjCN (PositA (crucial_A)) (UseN (clause_N)))))) (UsePN (jones_PN)))))))));
lin s_346_3_h = (Sentence (PredVPS (UsePN (smith_PN)) (ConjVPS2 (either7or_DConj) (Past) (PPos) (ComplSlash (SlashV2V (see_V2V) (ComplSlash (SlashV2a (sign_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (UseN (contract_N))))) (UsePN (jones_PN))) (Past) (PPos) (ComplSlash (SlashV2V (see_V2V) (ComplSlash (SlashV2a (cross_out_V2)) (DetCN (DetQuant (DefArt) (NumSg)) (AdjCN (PositA (crucial_A)) (UseN (clause_N)))))) (UsePN (jones_PN))))));

}
