:- discontiguous tree/2, sent/3.
%% tree(?SentenceID, ?Tree)
%% sent(?SentenceID, ?Language, ?Sentence)
tree(s_001_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(italian_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(become_V2, [])]), t('DetCN', [t('DetQuantOrd', [t('GenNP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(world_N, [])])])]), t('NumSg', []), t('OrdSuperl', [t(great_A, [])])]), t('UseN', [t(tenor_N, [])])])])])])])).
sent(s_001_1_p, eng, 'an Italian became the world\'s greatest tenor').
sent(s_001_1_p, original, 'an Italian became the world\'s greatest tenor').
sent(s_001_1_p, swe, 'en italienare blev världens mest framstående tenor').

tree(s_001_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('ExistNP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('RelCN', [t('UseN', [t(italian_N, [])]), t('UseRCl', [t('Past', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('ComplSlash', [t('SlashV2a', [t(become_V2, [])]), t('DetCN', [t('DetQuantOrd', [t('GenNP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(world_N, [])])])]), t('NumSg', []), t('OrdSuperl', [t(great_A, [])])]), t('UseN', [t(tenor_N, [])])])])])])])])])])])])).
sent(s_001_2_q, eng, 'was there an Italian who became the world\'s greatest tenor').
sent(s_001_2_q, original, 'was there an Italian who became the world\'s greatest tenor').
sent(s_001_2_q, swe, 'fanns det en italienare som blev världens mest framstående tenor').

tree(s_001_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('ExistNP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('RelCN', [t('UseN', [t(italian_N, [])]), t('UseRCl', [t('Past', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('ComplSlash', [t('SlashV2a', [t(become_V2, [])]), t('DetCN', [t('DetQuantOrd', [t('GenNP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(world_N, [])])])]), t('NumSg', []), t('OrdSuperl', [t(great_A, [])])]), t('UseN', [t(tenor_N, [])])])])])])])])])])])).
sent(s_001_3_h, eng, 'there was an Italian who became the world\'s greatest tenor').
sent(s_001_3_h, original, 'there was an Italian who became the world\'s greatest tenor').
sent(s_001_3_h, swe, 'det fanns en italienare som blev världens mest framstående tenor').

tree(s_002_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t(every_Det, []), t('AdjCN', [t('PositA', [t(italian_A, [])]), t('UseN', [t(man_N, [])])])]), t('ComplVV', [t(want_VV, []), t('UseComp', [t('CompCN', [t('AdjCN', [t('PositA', [t(great_A, [])]), t('UseN', [t(tenor_N, [])])])])])])])])])).
sent(s_002_1_p, eng, 'every Italian man wants to be a great tenor').
sent(s_002_1_p, original, 'every Italian man wants to be a great tenor').
sent(s_002_1_p, swe, 'varje italiensk man vill vara en framstående tenor').

tree(s_002_2_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t(somePl_Det, []), t('AdjCN', [t('PositA', [t(italian_A, [])]), t('UseN', [t(man_N, [])])])]), t('UseComp', [t('CompCN', [t('AdjCN', [t('PositA', [t(great_A, [])]), t('UseN', [t(tenor_N, [])])])])])])])])).
sent(s_002_2_p, eng, 'some Italian men are great tenors').
sent(s_002_2_p, original, 'some Italian men are great tenors').
sent(s_002_2_p, swe, 'några italienska män är framstående tenorer').

tree(s_002_3_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('ExistNP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('RelCN', [t('AdjCN', [t('PositA', [t(italian_A, [])]), t('UseN', [t(man_N, [])])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('ComplVV', [t(want_VV, []), t('UseComp', [t('CompNP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(great_A, [])]), t('UseN', [t(tenor_N, [])])])])])])])])])])])])])])])).
sent(s_002_3_q, eng, 'are there Italian men who want to be a great tenor').
sent(s_002_3_q, original, 'are there Italian men who want to be a great tenor').
sent(s_002_3_q, swe, 'finns det italienska män som vill vara en framstående tenor').

tree(s_002_4_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('ExistNP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('RelCN', [t('AdjCN', [t('PositA', [t(italian_A, [])]), t('UseN', [t(man_N, [])])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('ComplVV', [t(want_VV, []), t('UseComp', [t('CompNP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(great_A, [])]), t('UseN', [t(tenor_N, [])])])])])])])])])])])])])])).
sent(s_002_4_h, eng, 'there are Italian men who want to be a great tenor').
sent(s_002_4_h, original, 'there are Italian men who want to be a great tenor').
sent(s_002_4_h, swe, 'det finns italienska män som vill vara en framstående tenor').

tree(s_003_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('PredetNP', [t(all_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('AdjCN', [t('PositA', [t(italian_A, [])]), t('UseN', [t(man_N, [])])])])]), t('ComplVV', [t(want_VV, []), t('UseComp', [t('CompNP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(great_A, [])]), t('UseN', [t(tenor_N, [])])])])])])])])])])).
sent(s_003_1_p, eng, 'all Italian men want to be a great tenor').
sent(s_003_1_p, original, 'all Italian men want to be a great tenor').
sent(s_003_1_p, swe, 'alla italienska män vill vara en framstående tenor').

tree(s_003_2_p, s_002_2_p).
sent(s_003_2_p, eng, 'some Italian men are great tenors').
sent(s_003_2_p, original, 'some Italian men are great tenors').
sent(s_003_2_p, swe, 'några italienska män är framstående tenorer').

tree(s_003_3_q, s_002_3_q).
sent(s_003_3_q, eng, 'are there Italian men who want to be a great tenor').
sent(s_003_3_q, original, 'are there Italian men who want to be a great tenor').
sent(s_003_3_q, swe, 'finns det italienska män som vill vara en framstående tenor').

tree(s_003_4_h, s_002_4_h).
sent(s_003_4_h, eng, 'there are Italian men who want to be a great tenor').
sent(s_003_4_h, original, 'there are Italian men who want to be a great tenor').
sent(s_003_4_h, swe, 'det finns italienska män som vill vara en framstående tenor').

tree(s_004_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t(each_Det, []), t('AdjCN', [t('PositA', [t(italian_A, [])]), t('UseN', [t(tenor_N, [])])])]), t('ComplVV', [t(want_VV, []), t('UseComp', [t('CompAP', [t('PositA', [t(great_A, [])])])])])])])])).
sent(s_004_1_p, eng, 'each Italian tenor wants to be great').
sent(s_004_1_p, original, 'each Italian tenor wants to be great').
sent(s_004_1_p, swe, 'varje italiensk tenor vill vara framstående').

tree(s_004_2_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t(somePl_Det, []), t('AdjCN', [t('PositA', [t(italian_A, [])]), t('UseN', [t(tenor_N, [])])])]), t('UseComp', [t('CompAP', [t('PositA', [t(great_A, [])])])])])])])).
sent(s_004_2_p, eng, 'some Italian tenors are great').
sent(s_004_2_p, original, 'some Italian tenors are great').
sent(s_004_2_p, swe, 'några italienska tenorer är framstående').

tree(s_004_3_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('ExistNP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('RelCN', [t('AdjCN', [t('PositA', [t(italian_A, [])]), t('UseN', [t(tenor_N, [])])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('ComplVV', [t(want_VV, []), t('UseComp', [t('CompAP', [t('PositA', [t(great_A, [])])])])])])])])])])])])])).
sent(s_004_3_q, eng, 'are there Italian tenors who want to be great').
sent(s_004_3_q, original, 'are there Italian tenors who want to be great').
sent(s_004_3_q, swe, 'finns det italienska tenorer som vill vara framstående').

tree(s_004_4_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('ExistNP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('RelCN', [t('AdjCN', [t('PositA', [t(italian_A, [])]), t('UseN', [t(tenor_N, [])])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('ComplVV', [t(want_VV, []), t('UseComp', [t('CompAP', [t('PositA', [t(great_A, [])])])])])])])])])])])])).
sent(s_004_4_h, eng, 'there are Italian tenors who want to be great').
sent(s_004_4_h, original, 'there are Italian tenors who want to be great').
sent(s_004_4_h, swe, 'det finns italienska tenorer som vill vara framstående').

tree(s_005_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumPl', [])]), t('AdjCN', [t('AdAP', [t(really_AdA, []), t('PositA', [t(ambitious_A, [])])]), t('UseN', [t(tenor_N, [])])])]), t('UseComp', [t('CompAP', [t('PositA', [t(italian_A, [])])])])])])])).
sent(s_005_1_p, eng, 'the really ambitious tenors are Italian').
sent(s_005_1_p, original, 'the really ambitious tenors are Italian').
sent(s_005_1_p, swe, 'de verkligt ärelystna tenorerna är italienska').

tree(s_005_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('ExistNP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('RelCN', [t('AdjCN', [t('AdAP', [t(really_AdA, []), t('PositA', [t(ambitious_A, [])])]), t('UseN', [t(tenor_N, [])])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('UseComp', [t('CompAP', [t('PositA', [t(italian_A, [])])])])])])])])])])])])).
sent(s_005_2_q, eng, 'are there really ambitious tenors who are Italian').
sent(s_005_2_q, original, 'are there really ambitious tenors who are Italian').
sent(s_005_2_q, swe, 'finns det verkligt ärelystna tenorer som är italienska').

tree(s_005_3_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('ExistNP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('RelCN', [t('AdjCN', [t('AdAP', [t(really_AdA, []), t('PositA', [t(ambitious_A, [])])]), t('UseN', [t(tenor_N, [])])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('UseComp', [t('CompAP', [t('PositA', [t(italian_A, [])])])])])])])])])])])).
sent(s_005_3_h, eng, 'there are really ambitious tenors who are Italian').
sent(s_005_3_h, original, 'there are really ambitious tenors who are Italian').
sent(s_005_3_h, swe, 'det finns verkligt ärelystna tenorer som är italienska').

tree(s_006_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t(no_Quant, []), t('NumPl', [])]), t('AdjCN', [t('AdAP', [t(really_AdA, []), t('PositA', [t(great_A, [])])]), t('UseN', [t(tenor_N, [])])])]), t('UseComp', [t('CompAP', [t('PositA', [t(modest_A, [])])])])])])])).
sent(s_006_1_p, eng, 'no really great tenors are modest').
sent(s_006_1_p, original, 'no really great tenors are modest').
sent(s_006_1_p, swe, 'inga verkligt framstående tenorer är blygsamma').

tree(s_006_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('ExistNP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('RelCN', [t('AdjCN', [t('AdAP', [t(really_AdA, []), t('PositA', [t(great_A, [])])]), t('UseN', [t(tenor_N, [])])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('UseComp', [t('CompAP', [t('PositA', [t(modest_A, [])])])])])])])])])])])])).
sent(s_006_2_q, eng, 'are there really great tenors who are modest').
sent(s_006_2_q, original, 'are there really great tenors who are modest').
sent(s_006_2_q, swe, 'finns det verkligt framstående tenorer som är blygsamma').

tree(s_006_3_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('ExistNP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('RelCN', [t('AdjCN', [t('AdAP', [t(really_AdA, []), t('PositA', [t(great_A, [])])]), t('UseN', [t(tenor_N, [])])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('UseComp', [t('CompAP', [t('PositA', [t(modest_A, [])])])])])])])])])])])).
sent(s_006_3_h, eng, 'there are really great tenors who are modest').
sent(s_006_3_h, original, 'there are really great tenors who are modest').
sent(s_006_3_h, swe, 'det finns verkligt framstående tenorer som är blygsamma').

tree(s_007_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t(somePl_Det, []), t('AdjCN', [t('PositA', [t(great_A, [])]), t('UseN', [t(tenor_N, [])])])]), t('UseComp', [t('CompAP', [t('PositA', [t(swedish_A, [])])])])])])])).
sent(s_007_1_p, eng, 'some great tenors are Swedish').
sent(s_007_1_p, original, 'some great tenors are Swedish').
sent(s_007_1_p, swe, 'några framstående tenorer är svenska').

tree(s_007_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('ExistNP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('RelCN', [t('AdjCN', [t('PositA', [t(great_A, [])]), t('UseN', [t(tenor_N, [])])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('UseComp', [t('CompAP', [t('PositA', [t(swedish_A, [])])])])])])])])])])])])).
sent(s_007_2_q, eng, 'are there great tenors who are Swedish').
sent(s_007_2_q, original, 'are there great tenors who are Swedish').
sent(s_007_2_q, swe, 'finns det framstående tenorer som är svenska').

tree(s_007_3_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('ExistNP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('RelCN', [t('AdjCN', [t('PositA', [t(great_A, [])]), t('UseN', [t(tenor_N, [])])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('UseComp', [t('CompAP', [t('PositA', [t(swedish_A, [])])])])])])])])])])])).
sent(s_007_3_h, eng, 'there are great tenors who are Swedish').
sent(s_007_3_h, original, 'there are great tenors who are Swedish').
sent(s_007_3_h, swe, 'det finns framstående tenorer som är svenska').

tree(s_008_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t(many_Det, []), t('AdjCN', [t('PositA', [t(great_A, [])]), t('UseN', [t(tenor_N, [])])])]), t('UseComp', [t('CompAP', [t('PositA', [t(german_A, [])])])])])])])).
sent(s_008_1_p, eng, 'many great tenors are German').
sent(s_008_1_p, original, 'many great tenors are German').
sent(s_008_1_p, swe, 'många framstående tenorer är tyska').

tree(s_008_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('ExistNP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('RelCN', [t('AdjCN', [t('PositA', [t(great_A, [])]), t('UseN', [t(tenor_N, [])])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('UseComp', [t('CompAP', [t('PositA', [t(german_A, [])])])])])])])])])])])])).
sent(s_008_2_q, eng, 'are there great tenors who are German').
sent(s_008_2_q, original, 'are there great tenors who are German').
sent(s_008_2_q, swe, 'finns det framstående tenorer som är tyska').

tree(s_008_3_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('ExistNP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('RelCN', [t('AdjCN', [t('PositA', [t(great_A, [])]), t('UseN', [t(tenor_N, [])])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('UseComp', [t('CompAP', [t('PositA', [t(german_A, [])])])])])])])])])])])).
sent(s_008_3_h, eng, 'there are great tenors who are German').
sent(s_008_3_h, original, 'there are great tenors who are German').
sent(s_008_3_h, swe, 'det finns framstående tenorer som är tyska').

tree(s_009_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t(several_Det, []), t('AdjCN', [t('PositA', [t(great_A, [])]), t('UseN', [t(tenor_N, [])])])]), t('UseComp', [t('CompAP', [t('PositA', [t(british_A, [])])])])])])])).
sent(s_009_1_p, eng, 'several great tenors are British').
sent(s_009_1_p, original, 'several great tenors are British').
sent(s_009_1_p, swe, 'flera framstående tenorer är brittiska').

tree(s_009_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('ExistNP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('RelCN', [t('AdjCN', [t('PositA', [t(great_A, [])]), t('UseN', [t(tenor_N, [])])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('UseComp', [t('CompAP', [t('PositA', [t(british_A, [])])])])])])])])])])])])).
sent(s_009_2_q, eng, 'are there great tenors who are British').
sent(s_009_2_q, original, 'are there great tenors who are British').
sent(s_009_2_q, swe, 'finns det framstående tenorer som är brittiska').

tree(s_009_3_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('ExistNP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('RelCN', [t('AdjCN', [t('PositA', [t(great_A, [])]), t('UseN', [t(tenor_N, [])])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('UseComp', [t('CompAP', [t('PositA', [t(british_A, [])])])])])])])])])])])).
sent(s_009_3_h, eng, 'there are great tenors who are British').
sent(s_009_3_h, original, 'there are great tenors who are British').
sent(s_009_3_h, swe, 'det finns framstående tenorer som är brittiska').

tree(s_010_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('PredetNP', [t(most_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('AdjCN', [t('PositA', [t(great_A, [])]), t('UseN', [t(tenor_N, [])])])])]), t('UseComp', [t('CompAP', [t('PositA', [t(italian_A, [])])])])])])])).
sent(s_010_1_p, eng, 'most great tenors are Italian').
sent(s_010_1_p, original, 'most great tenors are Italian').
sent(s_010_1_p, swe, 'de flesta framstående tenorer är italienska').

tree(s_010_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('ExistNP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('RelCN', [t('AdjCN', [t('PositA', [t(great_A, [])]), t('UseN', [t(tenor_N, [])])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('UseComp', [t('CompAP', [t('PositA', [t(italian_A, [])])])])])])])])])])])])).
sent(s_010_2_q, eng, 'are there great tenors who are Italian').
sent(s_010_2_q, original, 'are there great tenors who are Italian').
sent(s_010_2_q, swe, 'finns det framstående tenorer som är italienska').

tree(s_010_3_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('ExistNP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('RelCN', [t('AdjCN', [t('PositA', [t(great_A, [])]), t('UseN', [t(tenor_N, [])])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('UseComp', [t('CompAP', [t('PositA', [t(italian_A, [])])])])])])])])])])])).
sent(s_010_3_h, eng, 'there are great tenors who are Italian').
sent(s_010_3_h, original, 'there are great tenors who are Italian').
sent(s_010_3_h, swe, 'det finns framstående tenorer som är italienska').

tree(s_011_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t(a_few_Det, []), t('AdjCN', [t('PositA', [t(great_A, [])]), t('UseN', [t(tenor_N, [])])])]), t('ComplSlash', [t('SlashV2a', [t(sing_V2, [])]), t('MassNP', [t('UseN', [t(popular_music_N, [])])])])])])])).
sent(s_011_1_p, eng, 'a few great tenors sing popular music').
sent(s_011_1_p, original, 'a few great tenors sing popular music').
sent(s_011_1_p, swe, 'ett fåtal framstående tenorer sjunger populärmusik').

tree(s_011_2_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t(somePl_Det, []), t('AdjCN', [t('PositA', [t(great_A, [])]), t('UseN', [t(tenor_N, [])])])]), t('ComplSlash', [t('SlashV2a', [t(like_V2, [])]), t('MassNP', [t('UseN', [t(popular_music_N, [])])])])])])])).
sent(s_011_2_p, eng, 'some great tenors like popular music').
sent(s_011_2_p, original, 'some great tenors like popular music').
sent(s_011_2_p, swe, 'några framstående tenorer gillar populärmusik').

tree(s_011_3_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('ExistNP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('RelCN', [t('AdjCN', [t('PositA', [t(great_A, [])]), t('UseN', [t(tenor_N, [])])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('ComplSlash', [t('SlashV2a', [t(sing_V2, [])]), t('MassNP', [t('UseN', [t(popular_music_N, [])])])])])])])])])])])])).
sent(s_011_3_q, eng, 'are there great tenors who sing popular music').
sent(s_011_3_q, original, 'are there great tenors who sing popular music').
sent(s_011_3_q, swe, 'finns det framstående tenorer som sjunger populärmusik').

tree(s_011_4_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('ExistNP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('RelCN', [t('AdjCN', [t('PositA', [t(great_A, [])]), t('UseN', [t(tenor_N, [])])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('ComplSlash', [t('SlashV2a', [t(sing_V2, [])]), t('MassNP', [t('UseN', [t(popular_music_N, [])])])])])])])])])])])).
sent(s_011_4_h, eng, 'there are great tenors who sing popular music').
sent(s_011_4_h, original, 'there are great tenors who sing popular music').
sent(s_011_4_h, swe, 'det finns framstående tenorer som sjunger populärmusik').

tree(s_012_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t(few_Det, []), t('AdjCN', [t('PositA', [t(great_A, [])]), t('UseN', [t(tenor_N, [])])])]), t('UseComp', [t('CompAP', [t('PositA', [t(poor8penniless_A, [])])])])])])])).
sent(s_012_1_p, eng, 'few great tenors are poor').
sent(s_012_1_p, original, 'few great tenors are poor').
sent(s_012_1_p, swe, 'få framstående tenorer är fattiga').

tree(s_012_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('ExistNP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('RelCN', [t('AdjCN', [t('PositA', [t(great_A, [])]), t('UseN', [t(tenor_N, [])])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('UseComp', [t('CompAP', [t('PositA', [t(poor8penniless_A, [])])])])])])])])])])])])).
sent(s_012_2_q, eng, 'are there great tenors who are poor').
sent(s_012_2_q, original, 'are there great tenors who are poor').
sent(s_012_2_q, swe, 'finns det framstående tenorer som är fattiga').

tree(s_012_3_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('ExistNP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('RelCN', [t('AdjCN', [t('PositA', [t(great_A, [])]), t('UseN', [t(tenor_N, [])])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('UseComp', [t('CompAP', [t('PositA', [t(poor8penniless_A, [])])])])])])])])])])])).
sent(s_012_3_h, eng, 'there are great tenors who are poor').
sent(s_012_3_h, original, 'there are great tenors who are poor').
sent(s_012_3_h, swe, 'det finns framstående tenorer som är fattiga').

tree(s_013_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t(both_Det, []), t('AdjCN', [t('PositA', [t(leading_A, [])]), t('UseN', [t(tenor_N, [])])])]), t('UseComp', [t('CompAP', [t('PositA', [t(excellent_A, [])])])])])])])).
sent(s_013_1_p, eng, 'both leading tenors are excellent').
sent(s_013_1_p, original, 'both leading tenors are excellent').
sent(s_013_1_p, swe, 'båda de ledande tenorerna är förträffliga').

tree(s_013_2_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('RelCN', [t('AdjCN', [t('PositA', [t(leading_A, [])]), t('UseN', [t(tenor_N, [])])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('UseComp', [t('CompAP', [t('PositA', [t(excellent_A, [])])])])])])])]), t('UseComp', [t('CompAP', [t('PositA', [t(indispensable_A, [])])])])])])])).
sent(s_013_2_p, eng, 'leading tenors who are excellent are indispensable').
sent(s_013_2_p, original, 'leading tenors who are excellent are indispensable').
sent(s_013_2_p, swe, 'ledande tenorer som är förträffliga är oumbärliga').

tree(s_013_3_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t(both_Det, []), t('AdjCN', [t('PositA', [t(leading_A, [])]), t('UseN', [t(tenor_N, [])])])]), t('UseComp', [t('CompAP', [t('PositA', [t(indispensable_A, [])])])])])])])])).
sent(s_013_3_q, eng, 'are both leading tenors indispensable').
sent(s_013_3_q, original, 'are both leading tenors indispensable').
sent(s_013_3_q, swe, 'är båda de ledande tenorerna oumbärliga').

tree(s_013_4_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t(both_Det, []), t('AdjCN', [t('PositA', [t(leading_A, [])]), t('UseN', [t(tenor_N, [])])])]), t('UseComp', [t('CompAP', [t('PositA', [t(indispensable_A, [])])])])])])])).
sent(s_013_4_h, eng, 'both leading tenors are indispensable').
sent(s_013_4_h, original, 'both leading tenors are indispensable').
sent(s_013_4_h, swe, 'båda de ledande tenorerna är oumbärliga').

tree(s_014_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t(neither_Det, []), t('AdjCN', [t('PositA', [t(leading_A, [])]), t('UseN', [t(tenor_N, [])])])]), t(come_cheap_VP, [])])])])).
sent(s_014_1_p, eng, 'neither leading tenor comes cheap').
sent(s_014_1_p, original, 'neither leading tenor comes cheap').
sent(s_014_1_p, swe, 'ingen av de ledande tenorerna är billiga').

tree(s_014_2_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('AdvNP', [t('DetNP', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])])]), t('PrepNP', [t(part_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumPl', [])]), t('AdjCN', [t('PositA', [t(leading_A, [])]), t('UseN', [t(tenor_N, [])])])])])]), t('UseComp', [t('CompNP', [t('UsePN', [t(pavarotti_PN, [])])])])])])])).
sent(s_014_2_p, eng, 'one of the leading tenors is Pavarotti').
sent(s_014_2_p, original, 'one of the leading tenors is Pavarotti').
sent(s_014_2_p, swe, 'ett av de ledande tenorerna är Pavarotti').

tree(s_014_3_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(pavarotti_PN, [])]), t('UseComp', [t('CompCN', [t('RelCN', [t('AdjCN', [t('PositA', [t(leading_A, [])]), t('UseN', [t(tenor_N, [])])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelVP', [t('IdRP', []), t(come_cheap_VP, [])])])])])])])])])])).
sent(s_014_3_q, eng, 'is Pavarotti a leading tenor who comes cheap').
sent(s_014_3_q, original, 'is Pavarotti a leading tenor who comes cheap').
sent(s_014_3_q, swe, 'är Pavarotti en ledande tenor som är billig').

tree(s_014_4_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(pavarotti_PN, [])]), t('UseComp', [t('CompCN', [t('RelCN', [t('AdjCN', [t('PositA', [t(leading_A, [])]), t('UseN', [t(tenor_N, [])])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelVP', [t('IdRP', []), t(come_cheap_VP, [])])])])])])])])])).
sent(s_014_4_h, eng, 'Pavarotti is a leading tenor who comes cheap').
sent(s_014_4_h, original, 'Pavarotti is a leading tenor who comes cheap').
sent(s_014_4_h, swe, 'Pavarotti är en ledande tenor som är billig').

tree(s_015_1_p, t('Sentence', [t('UseCl', [t('Future', []), t('PPos', []), t('PredVP', [t('PredetNP', [t(at_least_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_three', [])])])]), t('UseN', [t(tenor_N, [])])])]), t('ComplSlash', [t('SlashV2a', [t(take_part_in_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(concert_N, [])])])])])])])).
sent(s_015_1_p, eng, 'at least three tenors will take part in the concert').
sent(s_015_1_p, original, 'at least three tenors will take part in the concert').
sent(s_015_1_p, swe, 'minst tre tenorer ska delta i konserten').

tree(s_015_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('ExistNP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('RelCN', [t('UseN', [t(tenor_N, [])]), t('UseRCl', [t('Future', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('ComplSlash', [t('SlashV2a', [t(take_part_in_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(concert_N, [])])])])])])])])])])])])).
sent(s_015_2_q, eng, 'are there tenors who will take part in the concert').
sent(s_015_2_q, original, 'are there tenors who will take part in the concert').
sent(s_015_2_q, swe, 'finns det tenorer som ska delta i konserten').

tree(s_015_3_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('ExistNP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('RelCN', [t('UseN', [t(tenor_N, [])]), t('UseRCl', [t('Future', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('ComplSlash', [t('SlashV2a', [t(take_part_in_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(concert_N, [])])])])])])])])])])])).
sent(s_015_3_h, eng, 'there are tenors who will take part in the concert').
sent(s_015_3_h, original, 'there are tenors who will take part in the concert').
sent(s_015_3_h, swe, 'det finns tenorer som ska delta i konserten').

tree(s_016_1_p, t('Sentence', [t('UseCl', [t('Future', []), t('PPos', []), t('PredVP', [t('PredetNP', [t(at_most_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_two', [])])])]), t('UseN', [t(tenor_N, [])])])]), t('ComplSlash', [t('Slash3V3', [t(contribute_to_V3, []), t('MassNP', [t('UseN', [t(charity_N, [])])])]), t('DetCN', [t('DetQuant', [t('PossPron', [t(theyRefl_Pron, [])]), t('NumPl', [])]), t('UseN', [t(fee_N, [])])])])])])])).
sent(s_016_1_p, eng, 'at most two tenors will contribute their fees to charity').
sent(s_016_1_p, original, 'at most two tenors will contribute their fees to charity').
sent(s_016_1_p, swe, 'högst två tenorer ska ge sina arvoden till välgörenhet').

tree(s_016_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('ExistNP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('RelCN', [t('UseN', [t(tenor_N, [])]), t('UseRCl', [t('Future', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('ComplSlash', [t('Slash3V3', [t(contribute_to_V3, []), t('MassNP', [t('UseN', [t(charity_N, [])])])]), t('DetCN', [t('DetQuant', [t('PossPron', [t(theyRefl_Pron, [])]), t('NumPl', [])]), t('UseN', [t(fee_N, [])])])])])])])])])])])])).
sent(s_016_2_q, eng, 'are there tenors who will contribute their fees to charity').
sent(s_016_2_q, original, 'are there tenors who will contribute their fees to charity').
sent(s_016_2_q, swe, 'finns det tenorer som ska ge sina arvoden till välgörenhet').

tree(s_016_3_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('ExistNP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('RelCN', [t('UseN', [t(tenor_N, [])]), t('UseRCl', [t('Future', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('ComplSlash', [t('Slash3V3', [t(contribute_to_V3, []), t('MassNP', [t('UseN', [t(charity_N, [])])])]), t('DetCN', [t('DetQuant', [t('PossPron', [t(theyRefl_Pron, [])]), t('NumPl', [])]), t('UseN', [t(fee_N, [])])])])])])])])])])])).
sent(s_016_3_h, eng, 'there are tenors who will contribute their fees to charity').
sent(s_016_3_h, original, 'there are tenors who will contribute their fees to charity').
sent(s_016_3_h, swe, 'det finns tenorer som ska ge sina arvoden till välgörenhet').

tree(s_017_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(irishman_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(win_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('ComplN2', [t(nobel_prize_N2, []), t('MassNP', [t('UseN', [t(literature_N, [])])])])])])])])])).
sent(s_017_1_p, eng, 'an Irishman won the Nobel prize for literature').
sent(s_017_1_p, original, 'an Irishman won the Nobel prize for literature').
sent(s_017_1_p, swe, 'en irländare vann nobelpriset i litteratur').

tree(s_017_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(irishman_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(win_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(nobel_prize_N, [])])])])])])])])).
sent(s_017_2_q, eng, 'did an Irishman win a Nobel prize').
sent(s_017_2_q, original, 'did an Irishman win a Nobel prize').
sent(s_017_2_q, swe, 'vann en irländare ett nobelpris').

tree(s_017_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(irishman_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(win_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(nobel_prize_N, [])])])])])])])).
sent(s_017_3_h, eng, 'an Irishman won a Nobel prize').
sent(s_017_3_h, original, 'an Irishman won a Nobel prize').
sent(s_017_3_h, swe, 'en irländare vann ett nobelpris').

tree(s_018_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t(every_Det, []), t('UseN', [t(european_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('SentCN', [t('UseN', [t(right_N, [])]), t('EmbedVP', [t('AdvVP', [t('UseV', [t(live_V, [])]), t('PrepNP', [t(in_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])])])])).
sent(s_018_1_p, eng, 'every European has the right to live in Europe').
sent(s_018_1_p, original, 'every European has the right to live in Europe').
sent(s_018_1_p, swe, 'varje europé har rätten att bo i Europa').

tree(s_018_2_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t(every_Det, []), t('UseN', [t(european_N, [])])]), t('UseComp', [t('CompCN', [t('UseN', [t(person_N, [])])])])])])])).
sent(s_018_2_p, eng, 'every European is a person').
sent(s_018_2_p, original, 'every European is a person').
sent(s_018_2_p, swe, 'varje europé är en människa').

tree(s_018_3_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t(every_Det, []), t('RelCN', [t('UseN', [t(person_N, [])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('SentCN', [t('UseN', [t(right_N, [])]), t('EmbedVP', [t('AdvVP', [t('UseV', [t(live_V, [])]), t('PrepNP', [t(in_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])])])])]), t('ComplVV', [t(can_VV, []), t('AdvVP', [t('AdvVP', [t('UseV', [t(travel_V, [])]), t('PositAdvAdj', [t(free_A, [])])]), t('PrepNP', [t(within_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])).
sent(s_018_3_p, eng, 'every person who has the right to live in Europe can travel freely within Europe').
sent(s_018_3_p, original, 'every person who has the right to live in Europe can travel freely within Europe').
sent(s_018_3_p, swe, 'varje människa som har rätten att bo i Europa kan resa fritt inom Europa').

tree(s_018_4_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t(every_Det, []), t('UseN', [t(european_N, [])])]), t('ComplVV', [t(can_VV, []), t('AdvVP', [t('AdvVP', [t('UseV', [t(travel_V, [])]), t('PositAdvAdj', [t(free_A, [])])]), t('PrepNP', [t(within_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])])).
sent(s_018_4_q, eng, 'can every European travel freely within Europe').
sent(s_018_4_q, original, 'can every European travel freely within Europe').
sent(s_018_4_q, swe, 'kan varje europé resa fritt inom Europa').

tree(s_018_5_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t(every_Det, []), t('UseN', [t(european_N, [])])]), t('ComplVV', [t(can_VV, []), t('AdvVP', [t('AdvVP', [t('UseV', [t(travel_V, [])]), t('PositAdvAdj', [t(free_A, [])])]), t('PrepNP', [t(within_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])).
sent(s_018_5_h, eng, 'every European can travel freely within Europe').
sent(s_018_5_h, original, 'every European can travel freely within Europe').
sent(s_018_5_h, swe, 'varje europé kan resa fritt inom Europa').

tree(s_019_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('PredetNP', [t(all_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('UseN', [t(european_N, [])])])]), t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('SentCN', [t('UseN', [t(right_N, [])]), t('EmbedVP', [t('AdvVP', [t('UseV', [t(live_V, [])]), t('PrepNP', [t(in_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])])])])).
sent(s_019_1_p, eng, 'all Europeans have the right to live in Europe').
sent(s_019_1_p, original, 'all Europeans have the right to live in Europe').
sent(s_019_1_p, swe, 'alla européer har rätten att bo i Europa').

tree(s_019_2_p, s_018_2_p).
sent(s_019_2_p, eng, 'every European is a person').
sent(s_019_2_p, original, 'every European is a person').
sent(s_019_2_p, swe, 'varje europé är en människa').

tree(s_019_3_p, s_018_3_p).
sent(s_019_3_p, eng, 'every person who has the right to live in Europe can travel freely within Europe').
sent(s_019_3_p, original, 'every person who has the right to live in Europe can travel freely within Europe').
sent(s_019_3_p, swe, 'varje människa som har rätten att bo i Europa kan resa fritt inom Europa').

tree(s_019_4_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('PredetNP', [t(all_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('UseN', [t(european_N, [])])])]), t('ComplVV', [t(can_VV, []), t('AdvVP', [t('AdvVP', [t('UseV', [t(travel_V, [])]), t('PositAdvAdj', [t(free_A, [])])]), t('PrepNP', [t(within_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])])).
sent(s_019_4_q, eng, 'can all Europeans travel freely within Europe').
sent(s_019_4_q, original, 'can all Europeans travel freely within Europe').
sent(s_019_4_q, swe, 'kan alla européer resa fritt inom Europa').

tree(s_019_5_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('PredetNP', [t(all_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('UseN', [t(european_N, [])])])]), t('ComplVV', [t(can_VV, []), t('AdvVP', [t('AdvVP', [t('UseV', [t(travel_V, [])]), t('PositAdvAdj', [t(free_A, [])])]), t('PrepNP', [t(within_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])).
sent(s_019_5_h, eng, 'all Europeans can travel freely within Europe').
sent(s_019_5_h, original, 'all Europeans can travel freely within Europe').
sent(s_019_5_h, swe, 'alla européer kan resa fritt inom Europa').

tree(s_020_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t(each_Det, []), t('UseN', [t(european_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('SentCN', [t('UseN', [t(right_N, [])]), t('EmbedVP', [t('AdvVP', [t('UseV', [t(live_V, [])]), t('PrepNP', [t(in_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])])])])).
sent(s_020_1_p, eng, 'each European has the right to live in Europe').
sent(s_020_1_p, original, 'each European has the right to live in Europe').
sent(s_020_1_p, swe, 'varje europé har rätten att bo i Europa').

tree(s_020_2_p, s_018_2_p).
sent(s_020_2_p, eng, 'every European is a person').
sent(s_020_2_p, original, 'every European is a person').
sent(s_020_2_p, swe, 'varje europé är en människa').

tree(s_020_3_p, s_018_3_p).
sent(s_020_3_p, eng, 'every person who has the right to live in Europe can travel freely within Europe').
sent(s_020_3_p, original, 'every person who has the right to live in Europe can travel freely within Europe').
sent(s_020_3_p, swe, 'varje människa som har rätten att bo i Europa kan resa fritt inom Europa').

tree(s_020_4_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t(each_Det, []), t('UseN', [t(european_N, [])])]), t('ComplVV', [t(can_VV, []), t('AdvVP', [t('AdvVP', [t('UseV', [t(travel_V, [])]), t('PositAdvAdj', [t(free_A, [])])]), t('PrepNP', [t(within_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])])).
sent(s_020_4_q, eng, 'can each European travel freely within Europe').
sent(s_020_4_q, original, 'can each European travel freely within Europe').
sent(s_020_4_q, swe, 'kan varje europé resa fritt inom Europa').

tree(s_020_5_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t(each_Det, []), t('UseN', [t(european_N, [])])]), t('ComplVV', [t(can_VV, []), t('AdvVP', [t('AdvVP', [t('UseV', [t(travel_V, [])]), t('PositAdvAdj', [t(free_A, [])])]), t('PrepNP', [t(within_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])).
sent(s_020_5_h, eng, 'each European can travel freely within Europe').
sent(s_020_5_h, original, 'each European can travel freely within Europe').
sent(s_020_5_h, swe, 'varje europé kan resa fritt inom Europa').

tree(s_021_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumPl', [])]), t('ComplN2', [t(resident_in_N2, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('UseN', [t(member_state_N, [])])])])]), t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('SentCN', [t('UseN', [t(right_N, [])]), t('EmbedVP', [t('AdvVP', [t('UseV', [t(live_V, [])]), t('PrepNP', [t(in_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])])])])).
sent(s_021_1_p, eng, 'the residents of member states have the right to live in Europe').
sent(s_021_1_p, original, 'the residents of member states have the right to live in Europe').
sent(s_021_1_p, swe, 'invånarna i medlemsstater har rätten att bo i Europa').

tree(s_021_2_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('PredetNP', [t(all_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('ComplN2', [t(resident_in_N2, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('UseN', [t(member_state_N, [])])])])])]), t('UseComp', [t('CompCN', [t('UseN', [t(individual_N, [])])])])])])])).
sent(s_021_2_p, eng, 'all residents of member states are individuals').
sent(s_021_2_p, original, 'all residents of member states are individuals').
sent(s_021_2_p, swe, 'alla invånare i medlemsstater är individer').

tree(s_021_3_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t(every_Det, []), t('RelCN', [t('UseN', [t(individual_N, [])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('SentCN', [t('UseN', [t(right_N, [])]), t('EmbedVP', [t('AdvVP', [t('UseV', [t(live_V, [])]), t('PrepNP', [t(in_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])])])])]), t('ComplVV', [t(can_VV, []), t('AdvVP', [t('AdvVP', [t('UseV', [t(travel_V, [])]), t('PositAdvAdj', [t(free_A, [])])]), t('PrepNP', [t(within_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])).
sent(s_021_3_p, eng, 'every individual who has the right to live in Europe can travel freely within Europe').
sent(s_021_3_p, original, 'every individual who has the right to live in Europe can travel freely within Europe').
sent(s_021_3_p, swe, 'varje individ som har rätten att bo i Europa kan resa fritt inom Europa').

tree(s_021_4_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumPl', [])]), t('ComplN2', [t(resident_in_N2, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('UseN', [t(member_state_N, [])])])])]), t('ComplVV', [t(can_VV, []), t('AdvVP', [t('AdvVP', [t('UseV', [t(travel_V, [])]), t('PositAdvAdj', [t(free_A, [])])]), t('PrepNP', [t(within_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])])).
sent(s_021_4_q, eng, 'can the residents of member states travel freely within Europe').
sent(s_021_4_q, original, 'can the residents of member states travel freely within Europe').
sent(s_021_4_q, swe, 'kan invånarna i medlemsstater resa fritt inom Europa').

tree(s_021_5_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumPl', [])]), t('ComplN2', [t(resident_in_N2, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('UseN', [t(member_state_N, [])])])])]), t('ComplVV', [t(can_VV, []), t('AdvVP', [t('AdvVP', [t('UseV', [t(travel_V, [])]), t('PositAdvAdj', [t(free_A, [])])]), t('PrepNP', [t(within_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])).
sent(s_021_5_h, eng, 'the residents of member states can travel freely within Europe').
sent(s_021_5_h, original, 'the residents of member states can travel freely within Europe').
sent(s_021_5_h, swe, 'invånarna i medlemsstater kan resa fritt inom Europa').

tree(s_022_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t(no_Quant, []), t('NumSg', [])]), t('UseN', [t(delegate_N, [])])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(finish_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])]), t(on_time_Adv, [])])])])])).
sent(s_022_1_p, eng, 'no delegate finished the report on time').
sent(s_022_1_p, original, 'no delegate finished the report on time').
sent(s_022_1_p, swe, 'ingen delegat slutförde rapporten i tid').

tree(s_022_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t('DetQuant', [t(no_Quant, []), t('NumSg', [])]), t('UseN', [t(delegate_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(finish_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])])])])])])).
sent(s_022_2_q, eng, 'did no delegate finish the report').
sent(s_022_2_q, original, 'did no delegate finish the report').
sent(s_022_2_q, swe, 'slutförde ingen delegat rapporten').

tree(s_022_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t(no_Quant, []), t('NumSg', [])]), t('UseN', [t(delegate_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(finish_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])])])])])).
sent(s_022_3_h, eng, 'no delegate finished the report').
sent(s_022_3_h, original, 'no delegate finished the report').
sent(s_022_3_h, swe, 'ingen delegat slutförde rapporten').

tree(s_023_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t(somePl_Det, []), t('UseN', [t(delegate_N, [])])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(finish_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(survey_N, [])])])]), t(on_time_Adv, [])])])])])).
sent(s_023_1_p, eng, 'some delegates finished the survey on time').
sent(s_023_1_p, original, 'some delegates finished the survey on time').
sent(s_023_1_p, swe, 'några delegater slutförde undersökningen i tid').

tree(s_023_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t(somePl_Det, []), t('UseN', [t(delegate_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(finish_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(survey_N, [])])])])])])])])).
sent(s_023_2_q, eng, 'did some delegates finish the survey').
sent(s_023_2_q, original, 'did some delegates finish the survey').
sent(s_023_2_q, swe, 'slutförde några delegater undersökningen').

tree(s_023_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t(somePl_Det, []), t('UseN', [t(delegate_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(finish_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(survey_N, [])])])])])])])).
sent(s_023_3_h, eng, 'some delegates finished the survey').
sent(s_023_3_h, original, 'some delegates finished the survey').
sent(s_023_3_h, swe, 'några delegater slutförde undersökningen').

tree(s_024_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t(many_Det, []), t('UseN', [t(delegate_N, [])])]), t('ComplSlash', [t('Slash3V3', [t(obtain_from_V3, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(survey_N, [])])])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('AdjCN', [t('PositA', [t(interesting_A, [])]), t('UseN', [t(result_N, [])])])])])])])])).
sent(s_024_1_p, eng, 'many delegates obtained interesting results from the survey').
sent(s_024_1_p, original, 'many delegates obtained interesting results from the survey').
sent(s_024_1_p, swe, 'många delegater erhöll intressanta resultat från undersökningen').

tree(s_024_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t(many_Det, []), t('UseN', [t(delegate_N, [])])]), t('ComplSlash', [t('Slash3V3', [t(obtain_from_V3, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(survey_N, [])])])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('UseN', [t(result_N, [])])])])])])])])).
sent(s_024_2_q, eng, 'did many delegates obtain results from the survey').
sent(s_024_2_q, original, 'did many delegates obtain results from the survey').
sent(s_024_2_q, swe, 'erhöll många delegater resultat från undersökningen').

tree(s_024_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t(many_Det, []), t('UseN', [t(delegate_N, [])])]), t('ComplSlash', [t('Slash3V3', [t(obtain_from_V3, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(survey_N, [])])])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('UseN', [t(result_N, [])])])])])])])).
sent(s_024_3_h, eng, 'many delegates obtained results from the survey').
sent(s_024_3_h, original, 'many delegates obtained results from the survey').
sent(s_024_3_h, swe, 'många delegater erhöll resultat från undersökningen').

tree(s_025_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t(several_Det, []), t('UseN', [t(delegate_N, [])])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(get_V2, [])]), t('PPartNP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumPl', [])]), t('UseN', [t(result_N, [])])]), t(publish_V2, [])])]), t('PrepNP', [t(in_Prep, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('AdjCN', [t('PositA', [t(major_A, [])]), t('AdjCN', [t('PositA', [t(national_A, [])]), t('UseN', [t(newspaper_N, [])])])])])])])])])])).
sent(s_025_1_p, eng, 'several delegates got the results published in major national newspapers').
sent(s_025_1_p, original, 'several delegates got the results published in major national newspapers').
sent(s_025_1_p, swe, 'flera delegater fick resultaten publicerade i större nationella tidningar').

tree(s_025_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t(several_Det, []), t('UseN', [t(delegate_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(get_V2, [])]), t('PPartNP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumPl', [])]), t('UseN', [t(result_N, [])])]), t(publish_V2, [])])])])])])])).
sent(s_025_2_q, eng, 'did several delegates get the results published').
sent(s_025_2_q, original, 'did several delegates get the results published').
sent(s_025_2_q, swe, 'fick flera delegater resultaten publicerade').

tree(s_025_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t(several_Det, []), t('UseN', [t(delegate_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(get_V2, [])]), t('PPartNP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumPl', [])]), t('UseN', [t(result_N, [])])]), t(publish_V2, [])])])])])])).
sent(s_025_3_h, eng, 'several delegates got the results published').
sent(s_025_3_h, original, 'several delegates got the results published').
sent(s_025_3_h, swe, 'flera delegater fick resultaten publicerade').

tree(s_026_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('PredetNP', [t(most_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('UseN', [t(european_N, [])])])]), t('UseComp', [t('CompAP', [t('AdvAP', [t('PositA', [t(resident_A, [])]), t('PrepNP', [t(in_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])])).
sent(s_026_1_p, eng, 'most Europeans are resident in Europe').
sent(s_026_1_p, original, 'most Europeans are resident in Europe').
sent(s_026_1_p, swe, 'de flesta européer är bosatta i Europa').

tree(s_026_2_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('PredetNP', [t(all_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('UseN', [t(european_N, [])])])]), t('UseComp', [t('CompCN', [t('UseN', [t(person_N, [])])])])])])])).
sent(s_026_2_p, eng, 'all Europeans are people').
sent(s_026_2_p, original, 'all Europeans are people').
sent(s_026_2_p, swe, 'alla européer är människor').

tree(s_026_3_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('PredetNP', [t(all_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('RelCN', [t('UseN', [t(person_N, [])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('UseComp', [t('CompAP', [t('AdvAP', [t('PositA', [t(resident_A, [])]), t('PrepNP', [t(in_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])])])]), t('ComplVV', [t(can_VV, []), t('AdvVP', [t('AdvVP', [t('UseV', [t(travel_V, [])]), t('PositAdvAdj', [t(free_A, [])])]), t('PrepNP', [t(within_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])).
sent(s_026_3_p, eng, 'all people who are resident in Europe can travel freely within Europe').
sent(s_026_3_p, original, 'all people who are resident in Europe can travel freely within Europe').
sent(s_026_3_p, swe, 'alla människor som är bosatta i Europa kan resa fritt inom Europa').

tree(s_026_4_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('PredetNP', [t(most_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('UseN', [t(european_N, [])])])]), t('ComplVV', [t(can_VV, []), t('AdvVP', [t('AdvVP', [t('UseV', [t(travel_V, [])]), t('PositAdvAdj', [t(free_A, [])])]), t('PrepNP', [t(within_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])])).
sent(s_026_4_q, eng, 'can most Europeans travel freely within Europe').
sent(s_026_4_q, original, 'can most Europeans travel freely within Europe').
sent(s_026_4_q, swe, 'kan de flesta européer resa fritt inom Europa').

tree(s_026_5_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('PredetNP', [t(most_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('UseN', [t(european_N, [])])])]), t('ComplVV', [t(can_VV, []), t('AdvVP', [t('AdvVP', [t('UseV', [t(travel_V, [])]), t('PositAdvAdj', [t(free_A, [])])]), t('PrepNP', [t(within_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])).
sent(s_026_5_h, eng, 'most Europeans can travel freely within Europe').
sent(s_026_5_h, original, 'most Europeans can travel freely within Europe').
sent(s_026_5_h, swe, 'de flesta européer kan resa fritt inom Europa').

tree(s_027_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t(a_few_Det, []), t('UseN', [t(committee_member_N, [])])]), t('UseComp', [t('CompAdv', [t('PrepNP', [t(from_Prep, []), t('UsePN', [t(sweden_PN, [])])])])])])])])).
sent(s_027_1_p, eng, 'a few committee members are from Sweden').
sent(s_027_1_p, original, 'a few committee members are from Sweden').
sent(s_027_1_p, swe, 'ett fåtal kommittémedlemmar är från Sverige').

tree(s_027_2_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('PredetNP', [t(all_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('UseN', [t(committee_member_N, [])])])]), t('UseComp', [t('CompCN', [t('UseN', [t(person_N, [])])])])])])])).
sent(s_027_2_p, eng, 'all committee members are people').
sent(s_027_2_p, original, 'all committee members are people').
sent(s_027_2_p, swe, 'alla kommittémedlemmar är människor').

tree(s_027_3_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('PredetNP', [t(all_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('RelCN', [t('UseN', [t(person_N, [])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('UseComp', [t('CompAdv', [t('PrepNP', [t(from_Prep, []), t('UsePN', [t(sweden_PN, [])])])])])])])])])]), t('UseComp', [t('CompAdv', [t('PrepNP', [t(from_Prep, []), t('UsePN', [t(scandinavia_PN, [])])])])])])])])).
sent(s_027_3_p, eng, 'all people who are from Sweden are from Scandinavia').
sent(s_027_3_p, original, 'all people who are from Sweden are from Scandinavia').
sent(s_027_3_p, swe, 'alla människor som är från Sverige är från Skandinavien').

tree(s_027_4_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('PredetNP', [t(at_least_Predet, []), t('DetCN', [t(a_few_Det, []), t('UseN', [t(committee_member_N, [])])])]), t('UseComp', [t('CompAdv', [t('PrepNP', [t(from_Prep, []), t('UsePN', [t(scandinavia_PN, [])])])])])])])])])).
sent(s_027_4_q, eng, 'are at least a few committee members from Scandinavia').
sent(s_027_4_q, original, 'are at least a few committee members from Scandinavia').
sent(s_027_4_q, swe, 'är minst ett fåtal kommittémedlemmar från Skandinavien').

tree(s_027_5_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('PredetNP', [t(at_least_Predet, []), t('DetCN', [t(a_few_Det, []), t('UseN', [t(committee_member_N, [])])])]), t('UseComp', [t('CompAdv', [t('PrepNP', [t(from_Prep, []), t('UsePN', [t(scandinavia_PN, [])])])])])])])])).
sent(s_027_5_h, eng, 'at least a few committee members are from Scandinavia').
sent(s_027_5_h, original, 'at least a few committee members are from Scandinavia').
sent(s_027_5_h, swe, 'minst ett fåtal kommittémedlemmar är från Skandinavien').

tree(s_028_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t(few_Det, []), t('UseN', [t(committee_member_N, [])])]), t('UseComp', [t('CompAdv', [t('PrepNP', [t(from_Prep, []), t('UsePN', [t(portugal_PN, [])])])])])])])])).
sent(s_028_1_p, eng, 'few committee members are from Portugal').
sent(s_028_1_p, original, 'few committee members are from Portugal').
sent(s_028_1_p, swe, 'få kommittémedlemmar är från Portugal').

tree(s_028_2_p, s_027_2_p).
sent(s_028_2_p, eng, 'all committee members are people').
sent(s_028_2_p, original, 'all committee members are people').
sent(s_028_2_p, swe, 'alla kommittémedlemmar är människor').

tree(s_028_3_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('PredetNP', [t(all_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('RelCN', [t('UseN', [t(person_N, [])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('UseComp', [t('CompAdv', [t('PrepNP', [t(from_Prep, []), t('UsePN', [t(portugal_PN, [])])])])])])])])])]), t('UseComp', [t('CompAdv', [t('PrepNP', [t(from_Prep, []), t('UsePN', [t(southern_europe_PN, [])])])])])])])])).
sent(s_028_3_p, eng, 'all people who are from Portugal are from southern Europe').
sent(s_028_3_p, original, 'all people who are from Portugal are from southern Europe').
sent(s_028_3_p, swe, 'alla människor som är från Portugal är från södra Europa').

tree(s_028_4_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('ExistNP', [t('DetCN', [t(few_Det, []), t('AdvCN', [t('UseN', [t(committee_member_N, [])]), t('PrepNP', [t(from_Prep, []), t('UsePN', [t(southern_europe_PN, [])])])])])])])])])).
sent(s_028_4_q, eng, 'are there few committee members from southern Europe').
sent(s_028_4_q, original, 'are there few committee members from southern Europe').
sent(s_028_4_q, swe, 'finns det få kommittémedlemmar från södra Europa').

tree(s_028_5_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('ExistNP', [t('DetCN', [t(few_Det, []), t('AdvCN', [t('UseN', [t(committee_member_N, [])]), t('PrepNP', [t(from_Prep, []), t('UsePN', [t(southern_europe_PN, [])])])])])])])])).
sent(s_028_5_h, eng, 'there are few committee members from southern Europe').
sent(s_028_5_h, original, 'there are few committee members from southern Europe').
sent(s_028_5_h, swe, 'det finns få kommittémedlemmar från södra Europa').

tree(s_029_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t(both_Det, []), t('UseN', [t(commissioner_N, [])])]), t('ComplVV', [t(use_VV, []), t('UseComp', [t('CompCN', [t('AdjCN', [t('PositA', [t(leading_A, [])]), t('UseN', [t(businessman_N, [])])])])])])])])])).
sent(s_029_1_p, eng, 'both commissioners used to be leading businessmen').
sent(s_029_1_p, original, 'both commissioners used to be leading businessmen').
sent(s_029_1_p, swe, 'båda ombuden brukade vara ledande affärsmän').

tree(s_029_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t(both_Det, []), t('UseN', [t(commissioner_N, [])])]), t('ComplVV', [t(use_VV, []), t('UseComp', [t('CompCN', [t('UseN', [t(businessman_N, [])])])])])])])])])).
sent(s_029_2_q, eng, 'did both commissioners used to be businessmen').
sent(s_029_2_q, original, 'did both commissioners used to be businessmen').
sent(s_029_2_q, swe, 'brukade båda ombuden vara affärsmän').

tree(s_029_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t(both_Det, []), t('UseN', [t(commissioner_N, [])])]), t('ComplVV', [t(use_VV, []), t('UseComp', [t('CompCN', [t('UseN', [t(businessman_N, [])])])])])])])])).
sent(s_029_3_h, eng, 'both commissioners used to be businessmen').
sent(s_029_3_h, original, 'both commissioners used to be businessmen').
sent(s_029_3_h, swe, 'båda ombuden brukade vara affärsmän').

tree(s_030_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t(neither_Det, []), t('UseN', [t(commissioner_N, [])])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(spend_V2, [])]), t('DetCN', [t(a_lot_of_Det, []), t('UseN', [t(time_N, [])])])]), t(at_home_Adv, [])])])])])).
sent(s_030_1_p, eng, 'neither commissioner spends a lot of time at home').
sent(s_030_1_p, original, 'neither commissioner spends a lot of time at home').
sent(s_030_1_p, swe, 'inget av ombuden tillbringar mycket tid hemma').

tree(s_030_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t(neither_Det, []), t('UseN', [t(commissioner_N, [])])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(spend_V2, [])]), t('MassNP', [t('UseN', [t(time_N, [])])])]), t(at_home_Adv, [])])])])])])).
sent(s_030_2_q, eng, 'does neither commissioner spend time at home').
sent(s_030_2_q, original, 'does neither commissioner spend time at home').
sent(s_030_2_q, swe, 'tillbringar inget av ombuden tid hemma').

tree(s_030_3_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t(neither_Det, []), t('UseN', [t(commissioner_N, [])])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(spend_V2, [])]), t('MassNP', [t('UseN', [t(time_N, [])])])]), t(at_home_Adv, [])])])])])).
sent(s_030_3_h, eng, 'neither commissioner spends time at home').
sent(s_030_3_h, original, 'neither commissioner spends time at home').
sent(s_030_3_h, swe, 'inget av ombuden tillbringar tid hemma').

tree(s_031_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('PredetNP', [t(at_least_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_three', [])])])]), t('UseN', [t(commissioner_N, [])])])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(spend_V2, [])]), t('DetCN', [t(a_lot_of_Det, []), t('UseN', [t(time_N, [])])])]), t(at_home_Adv, [])])])])])).
sent(s_031_1_p, eng, 'at least three commissioners spend a lot of time at home').
sent(s_031_1_p, original, 'at least three commissioners spend a lot of time at home').
sent(s_031_1_p, swe, 'minst tre ombud tillbringar mycket tid hemma').

tree(s_031_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('PredetNP', [t(at_least_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_three', [])])])]), t('UseN', [t(commissioner_N, [])])])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(spend_V2, [])]), t('MassNP', [t('UseN', [t(time_N, [])])])]), t(at_home_Adv, [])])])])])])).
sent(s_031_2_q, eng, 'do at least three commissioners spend time at home').
sent(s_031_2_q, original, 'do at least three commissioners spend time at home').
sent(s_031_2_q, swe, 'tillbringar minst tre ombud tid hemma').

tree(s_031_3_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('PredetNP', [t(at_least_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_three', [])])])]), t('UseN', [t(commissioner_N, [])])])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(spend_V2, [])]), t('MassNP', [t('UseN', [t(time_N, [])])])]), t(at_home_Adv, [])])])])])).
sent(s_031_3_h, eng, 'at least three commissioners spend time at home').
sent(s_031_3_h, original, 'at least three commissioners spend time at home').
sent(s_031_3_h, swe, 'minst tre ombud tillbringar tid hemma').

tree(s_032_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('PredetNP', [t(at_most_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_ten', [])])])]), t('UseN', [t(commissioner_N, [])])])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(spend_V2, [])]), t('DetCN', [t(a_lot_of_Det, []), t('UseN', [t(time_N, [])])])]), t(at_home_Adv, [])])])])])).
sent(s_032_1_p, eng, 'at most ten commissioners spend a lot of time at home').
sent(s_032_1_p, original, 'at most ten commissioners spend a lot of time at home').
sent(s_032_1_p, swe, 'högst tio ombud tillbringar mycket tid hemma').

tree(s_032_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('PredetNP', [t(at_most_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_ten', [])])])]), t('UseN', [t(commissioner_N, [])])])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(spend_V2, [])]), t('MassNP', [t('UseN', [t(time_N, [])])])]), t(at_home_Adv, [])])])])])])).
sent(s_032_2_q, eng, 'do at most ten commissioners spend time at home').
sent(s_032_2_q, original, 'do at most ten commissioners spend time at home').
sent(s_032_2_q, swe, 'tillbringar högst tio ombud tid hemma').

tree(s_032_3_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('PredetNP', [t(at_most_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_ten', [])])])]), t('UseN', [t(commissioner_N, [])])])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(spend_V2, [])]), t('MassNP', [t('UseN', [t(time_N, [])])])]), t(at_home_Adv, [])])])])])).
sent(s_032_3_h, eng, 'at most ten commissioners spend time at home').
sent(s_032_3_h, original, 'at most ten commissioners spend time at home').
sent(s_032_3_h, swe, 'högst tio ombud tillbringar tid hemma').

tree(s_033_1_p, s_017_3_h).
sent(s_033_1_p, eng, 'an Irishman won a Nobel prize').
sent(s_033_1_p, original, 'an Irishman won a Nobel prize').
sent(s_033_1_p, swe, 'en irländare vann ett nobelpris').

tree(s_033_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(irishman_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(win_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('ComplN2', [t(nobel_prize_N2, []), t('MassNP', [t('UseN', [t(literature_N, [])])])])])])])])])])).
sent(s_033_2_q, eng, 'did an Irishman win the Nobel prize for literature').
sent(s_033_2_q, original, 'did an Irishman win the Nobel prize for literature').
sent(s_033_2_q, swe, 'vann en irländare nobelpriset i litteratur').

tree(s_033_3_h, s_017_1_p).
sent(s_033_3_h, eng, 'an Irishman won the Nobel prize for literature').
sent(s_033_3_h, original, 'an Irishman won the Nobel prize for literature').
sent(s_033_3_h, swe, 'en irländare vann nobelpriset i litteratur').

tree(s_034_1_p, s_018_5_h).
sent(s_034_1_p, eng, 'every European can travel freely within Europe').
sent(s_034_1_p, original, 'every European can travel freely within Europe').
sent(s_034_1_p, swe, 'varje europé kan resa fritt inom Europa').

tree(s_034_2_p, s_018_2_p).
sent(s_034_2_p, eng, 'every European is a person').
sent(s_034_2_p, original, 'every European is a person').
sent(s_034_2_p, swe, 'varje europé är en människa').

tree(s_034_3_p, s_018_3_p).
sent(s_034_3_p, eng, 'every person who has the right to live in Europe can travel freely within Europe').
sent(s_034_3_p, original, 'every person who has the right to live in Europe can travel freely within Europe').
sent(s_034_3_p, swe, 'varje människa som har rätten att bo i Europa kan resa fritt inom Europa').

tree(s_034_4_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t(every_Det, []), t('UseN', [t(european_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('SentCN', [t('UseN', [t(right_N, [])]), t('EmbedVP', [t('AdvVP', [t('UseV', [t(live_V, [])]), t('PrepNP', [t(in_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])])])])])).
sent(s_034_4_q, eng, 'does every European have the right to live in Europe').
sent(s_034_4_q, original, 'does every European have the right to live in Europe').
sent(s_034_4_q, swe, 'har varje europé rätten att bo i Europa').

tree(s_034_5_h, s_018_1_p).
sent(s_034_5_h, eng, 'every European has the right to live in Europe').
sent(s_034_5_h, original, 'every European has the right to live in Europe').
sent(s_034_5_h, swe, 'varje europé har rätten att bo i Europa').

tree(s_035_1_p, s_019_5_h).
sent(s_035_1_p, eng, 'all Europeans can travel freely within Europe').
sent(s_035_1_p, original, 'all Europeans can travel freely within Europe').
sent(s_035_1_p, swe, 'alla européer kan resa fritt inom Europa').

tree(s_035_2_p, s_018_2_p).
sent(s_035_2_p, eng, 'every European is a person').
sent(s_035_2_p, original, 'every European is a person').
sent(s_035_2_p, swe, 'varje europé är en människa').

tree(s_035_3_p, s_018_3_p).
sent(s_035_3_p, eng, 'every person who has the right to live in Europe can travel freely within Europe').
sent(s_035_3_p, original, 'every person who has the right to live in Europe can travel freely within Europe').
sent(s_035_3_p, swe, 'varje människa som har rätten att bo i Europa kan resa fritt inom Europa').

tree(s_035_4_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('PredetNP', [t(all_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('UseN', [t(european_N, [])])])]), t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('SentCN', [t('UseN', [t(right_N, [])]), t('EmbedVP', [t('AdvVP', [t('UseV', [t(live_V, [])]), t('PrepNP', [t(in_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])])])])])).
sent(s_035_4_q, eng, 'do all Europeans have the right to live in Europe').
sent(s_035_4_q, original, 'do all Europeans have the right to live in Europe').
sent(s_035_4_q, swe, 'har alla européer rätten att bo i Europa').

tree(s_035_5_h, s_019_1_p).
sent(s_035_5_h, eng, 'all Europeans have the right to live in Europe').
sent(s_035_5_h, original, 'all Europeans have the right to live in Europe').
sent(s_035_5_h, swe, 'alla européer har rätten att bo i Europa').

tree(s_036_1_p, s_020_5_h).
sent(s_036_1_p, eng, 'each European can travel freely within Europe').
sent(s_036_1_p, original, 'each European can travel freely within Europe').
sent(s_036_1_p, swe, 'varje europé kan resa fritt inom Europa').

tree(s_036_2_p, s_018_2_p).
sent(s_036_2_p, eng, 'every European is a person').
sent(s_036_2_p, original, 'every European is a person').
sent(s_036_2_p, swe, 'varje europé är en människa').

tree(s_036_3_p, s_018_3_p).
sent(s_036_3_p, eng, 'every person who has the right to live in Europe can travel freely within Europe').
sent(s_036_3_p, original, 'every person who has the right to live in Europe can travel freely within Europe').
sent(s_036_3_p, swe, 'varje människa som har rätten att bo i Europa kan resa fritt inom Europa').

tree(s_036_4_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t(each_Det, []), t('UseN', [t(european_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('SentCN', [t('UseN', [t(right_N, [])]), t('EmbedVP', [t('AdvVP', [t('UseV', [t(live_V, [])]), t('PrepNP', [t(in_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])])])])])).
sent(s_036_4_q, eng, 'does each European have the right to live in Europe').
sent(s_036_4_q, original, 'does each European have the right to live in Europe').
sent(s_036_4_q, swe, 'har varje europé rätten att bo i Europa').

tree(s_036_5_h, s_020_1_p).
sent(s_036_5_h, eng, 'each European has the right to live in Europe').
sent(s_036_5_h, original, 'each European has the right to live in Europe').
sent(s_036_5_h, swe, 'varje europé har rätten att bo i Europa').

tree(s_037_1_p, s_021_5_h).
sent(s_037_1_p, eng, 'the residents of member states can travel freely within Europe').
sent(s_037_1_p, original, 'the residents of member states can travel freely within Europe').
sent(s_037_1_p, swe, 'invånarna i medlemsstater kan resa fritt inom Europa').

tree(s_037_2_p, s_021_2_p).
sent(s_037_2_p, eng, 'all residents of member states are individuals').
sent(s_037_2_p, original, 'all residents of member states are individuals').
sent(s_037_2_p, swe, 'alla invånare i medlemsstater är individer').

tree(s_037_3_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t(every_Det, []), t('RelCN', [t('UseN', [t(individual_N, [])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('SentCN', [t('UseN', [t(right_N, [])]), t('EmbedVP', [t('AdvVP', [t('AdvVP', [t('UseV', [t(live_V, [])]), t(anywhere_Adv, [])]), t('PrepNP', [t(in_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])])])])]), t('ComplVV', [t(can_VV, []), t('AdvVP', [t('AdvVP', [t('UseV', [t(travel_V, [])]), t('PositAdvAdj', [t(free_A, [])])]), t('PrepNP', [t(within_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])).
sent(s_037_3_p, eng, 'every individual who has the right to live anywhere in Europe can travel freely within Europe').
sent(s_037_3_p, original, 'every individual who has the right to live anywhere in Europe can travel freely within Europe').
sent(s_037_3_p, swe, 'varje individ som har rätten att bo var som helst i Europa kan resa fritt inom Europa').

tree(s_037_4_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumPl', [])]), t('ComplN2', [t(resident_in_N2, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('UseN', [t(member_state_N, [])])])])]), t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('SentCN', [t('UseN', [t(right_N, [])]), t('EmbedVP', [t('AdvVP', [t('AdvVP', [t('UseV', [t(live_V, [])]), t(anywhere_Adv, [])]), t('PrepNP', [t(in_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])])])])])).
sent(s_037_4_q, eng, 'do the residents of member states have the right to live anywhere in Europe').
sent(s_037_4_q, original, 'do the residents of member states have the right to live anywhere in Europe').
sent(s_037_4_q, swe, 'har invånarna i medlemsstater rätten att bo var som helst i Europa').

tree(s_037_5_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumPl', [])]), t('ComplN2', [t(resident_in_N2, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('UseN', [t(member_state_N, [])])])])]), t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('SentCN', [t('UseN', [t(right_N, [])]), t('EmbedVP', [t('AdvVP', [t('AdvVP', [t('UseV', [t(live_V, [])]), t(anywhere_Adv, [])]), t('PrepNP', [t(in_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])])])])).
sent(s_037_5_h, eng, 'the residents of member states have the right to live anywhere in Europe').
sent(s_037_5_h, original, 'the residents of member states have the right to live anywhere in Europe').
sent(s_037_5_h, swe, 'invånarna i medlemsstater har rätten att bo var som helst i Europa').

tree(s_038_1_p, s_022_3_h).
sent(s_038_1_p, eng, 'no delegate finished the report').
sent(s_038_1_p, original, 'no delegate finished the report').
sent(s_038_1_p, swe, 'ingen delegat slutförde rapporten').

tree(s_038_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t(anySg_Det, []), t('UseN', [t(delegate_N, [])])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(finish_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])]), t(on_time_Adv, [])])])])])])).
sent(s_038_2_q, eng, 'did any delegate finish the report on time').
sent(s_038_2_q, original, 'did any delegate finish the report on time').
sent(s_038_2_q, swe, 'slutförde någon delegat rapporten i tid').

tree(s_038_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t(someSg_Det, []), t('UseN', [t(delegate_N, [])])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(finish_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])]), t(on_time_Adv, [])])])])])).
sent(s_038_3_h, eng, 'some delegate finished the report on time').
sent(s_038_3_h, original, 'some delegate finished the report on time').
sent(s_038_3_h, swe, 'någon delegat slutförde rapporten i tid').

tree(s_039_1_p, s_023_3_h).
sent(s_039_1_p, eng, 'some delegates finished the survey').
sent(s_039_1_p, original, 'some delegates finished the survey').
sent(s_039_1_p, swe, 'några delegater slutförde undersökningen').

tree(s_039_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t(somePl_Det, []), t('UseN', [t(delegate_N, [])])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(finish_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(survey_N, [])])])]), t(on_time_Adv, [])])])])])])).
sent(s_039_2_q, eng, 'did some delegates finish the survey on time').
sent(s_039_2_q, original, 'did some delegates finish the survey on time').
sent(s_039_2_q, swe, 'slutförde några delegater undersökningen i tid').

tree(s_039_3_h, s_023_1_p).
sent(s_039_3_h, eng, 'some delegates finished the survey on time').
sent(s_039_3_h, original, 'some delegates finished the survey on time').
sent(s_039_3_h, swe, 'några delegater slutförde undersökningen i tid').

tree(s_040_1_p, s_024_3_h).
sent(s_040_1_p, eng, 'many delegates obtained results from the survey').
sent(s_040_1_p, original, 'many delegates obtained results from the survey').
sent(s_040_1_p, swe, 'många delegater erhöll resultat från undersökningen').

tree(s_040_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t(many_Det, []), t('UseN', [t(delegate_N, [])])]), t('ComplSlash', [t('Slash3V3', [t(obtain_from_V3, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(survey_N, [])])])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('AdjCN', [t('PositA', [t(interesting_A, [])]), t('UseN', [t(result_N, [])])])])])])])])])).
sent(s_040_2_q, eng, 'did many delegates obtain interesting results from the survey').
sent(s_040_2_q, original, 'did many delegates obtain interesting results from the survey').
sent(s_040_2_q, swe, 'erhöll många delegater intressanta resultat från undersökningen').

tree(s_040_3_h, s_024_1_p).
sent(s_040_3_h, eng, 'many delegates obtained interesting results from the survey').
sent(s_040_3_h, original, 'many delegates obtained interesting results from the survey').
sent(s_040_3_h, swe, 'många delegater erhöll intressanta resultat från undersökningen').

tree(s_041_1_p, s_025_3_h).
sent(s_041_1_p, eng, 'several delegates got the results published').
sent(s_041_1_p, original, 'several delegates got the results published').
sent(s_041_1_p, swe, 'flera delegater fick resultaten publicerade').

tree(s_041_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t(several_Det, []), t('UseN', [t(delegate_N, [])])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(get_V2, [])]), t('PPartNP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumPl', [])]), t('UseN', [t(result_N, [])])]), t(publish_V2, [])])]), t('PrepNP', [t(in_Prep, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('AdjCN', [t('PositA', [t(major_A, [])]), t('AdjCN', [t('PositA', [t(national_A, [])]), t('UseN', [t(newspaper_N, [])])])])])])])])])])])).
sent(s_041_2_q, eng, 'did several delegates get the results published in major national newspapers').
sent(s_041_2_q, original, 'did several delegates get the results published in major national newspapers').
sent(s_041_2_q, swe, 'fick flera delegater resultaten publicerade i större nationella tidningar').

tree(s_041_3_h, s_025_1_p).
sent(s_041_3_h, eng, 'several delegates got the results published in major national newspapers').
sent(s_041_3_h, original, 'several delegates got the results published in major national newspapers').
sent(s_041_3_h, swe, 'flera delegater fick resultaten publicerade i större nationella tidningar').

tree(s_042_1_p, s_026_5_h).
sent(s_042_1_p, eng, 'most Europeans can travel freely within Europe').
sent(s_042_1_p, original, 'most Europeans can travel freely within Europe').
sent(s_042_1_p, swe, 'de flesta européer kan resa fritt inom Europa').

tree(s_042_2_p, s_026_2_p).
sent(s_042_2_p, eng, 'all Europeans are people').
sent(s_042_2_p, original, 'all Europeans are people').
sent(s_042_2_p, swe, 'alla européer är människor').

tree(s_042_3_p, s_026_3_p).
sent(s_042_3_p, eng, 'all people who are resident in Europe can travel freely within Europe').
sent(s_042_3_p, original, 'all people who are resident in Europe can travel freely within Europe').
sent(s_042_3_p, swe, 'alla människor som är bosatta i Europa kan resa fritt inom Europa').

tree(s_042_4_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('PredetNP', [t(most_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('UseN', [t(european_N, [])])])]), t('UseComp', [t('CompAP', [t('AdvAP', [t('PositA', [t(resident_A, [])]), t('PrepNP', [t(in_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])])])).
sent(s_042_4_q, eng, 'are most Europeans resident in Europe').
sent(s_042_4_q, original, 'are most Europeans resident in Europe').
sent(s_042_4_q, swe, 'är de flesta européer bosatta i Europa').

tree(s_042_5_h, s_026_1_p).
sent(s_042_5_h, eng, 'most Europeans are resident in Europe').
sent(s_042_5_h, original, 'most Europeans are resident in Europe').
sent(s_042_5_h, swe, 'de flesta européer är bosatta i Europa').

tree(s_043_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t(a_few_Det, []), t('UseN', [t(committee_member_N, [])])]), t('UseComp', [t('CompAdv', [t('PrepNP', [t(from_Prep, []), t('UsePN', [t(scandinavia_PN, [])])])])])])])])).
sent(s_043_1_p, eng, 'a few committee members are from Scandinavia').
sent(s_043_1_p, original, 'a few committee members are from Scandinavia').
sent(s_043_1_p, swe, 'ett fåtal kommittémedlemmar är från Skandinavien').

tree(s_043_2_p, s_027_2_p).
sent(s_043_2_p, eng, 'all committee members are people').
sent(s_043_2_p, original, 'all committee members are people').
sent(s_043_2_p, swe, 'alla kommittémedlemmar är människor').

tree(s_043_3_p, s_027_3_p).
sent(s_043_3_p, eng, 'all people who are from Sweden are from Scandinavia').
sent(s_043_3_p, original, 'all people who are from Sweden are from Scandinavia').
sent(s_043_3_p, swe, 'alla människor som är från Sverige är från Skandinavien').

tree(s_043_4_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('PredetNP', [t(at_least_Predet, []), t('DetCN', [t(a_few_Det, []), t('UseN', [t(committee_member_N, [])])])]), t('UseComp', [t('CompAdv', [t('PrepNP', [t(from_Prep, []), t('UsePN', [t(sweden_PN, [])])])])])])])])])).
sent(s_043_4_q, eng, 'are at least a few committee members from Sweden').
sent(s_043_4_q, original, 'are at least a few committee members from Sweden').
sent(s_043_4_q, swe, 'är minst ett fåtal kommittémedlemmar från Sverige').

tree(s_043_5_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('PredetNP', [t(at_least_Predet, []), t('DetCN', [t(a_few_Det, []), t('UseN', [t(committee_member_N, [])])])]), t('UseComp', [t('CompAdv', [t('PrepNP', [t(from_Prep, []), t('UsePN', [t(sweden_PN, [])])])])])])])])).
sent(s_043_5_h, eng, 'at least a few committee members are from Sweden').
sent(s_043_5_h, original, 'at least a few committee members are from Sweden').
sent(s_043_5_h, swe, 'minst ett fåtal kommittémedlemmar är från Sverige').

tree(s_044_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t(few_Det, []), t('UseN', [t(committee_member_N, [])])]), t('UseComp', [t('CompAdv', [t('PrepNP', [t(from_Prep, []), t('UsePN', [t(southern_europe_PN, [])])])])])])])])).
sent(s_044_1_p, eng, 'few committee members are from southern Europe').
sent(s_044_1_p, original, 'few committee members are from southern Europe').
sent(s_044_1_p, swe, 'få kommittémedlemmar är från södra Europa').

tree(s_044_2_p, s_027_2_p).
sent(s_044_2_p, eng, 'all committee members are people').
sent(s_044_2_p, original, 'all committee members are people').
sent(s_044_2_p, swe, 'alla kommittémedlemmar är människor').

tree(s_044_3_p, s_028_3_p).
sent(s_044_3_p, eng, 'all people who are from Portugal are from southern Europe').
sent(s_044_3_p, original, 'all people who are from Portugal are from southern Europe').
sent(s_044_3_p, swe, 'alla människor som är från Portugal är från södra Europa').

tree(s_044_4_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('ExistNP', [t('DetCN', [t(few_Det, []), t('AdvCN', [t('UseN', [t(committee_member_N, [])]), t('PrepNP', [t(from_Prep, []), t('UsePN', [t(portugal_PN, [])])])])])])])])])).
sent(s_044_4_q, eng, 'are there few committee members from Portugal').
sent(s_044_4_q, original, 'are there few committee members from Portugal').
sent(s_044_4_q, swe, 'finns det få kommittémedlemmar från Portugal').

tree(s_044_5_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('ExistNP', [t('DetCN', [t(few_Det, []), t('AdvCN', [t('UseN', [t(committee_member_N, [])]), t('PrepNP', [t(from_Prep, []), t('UsePN', [t(portugal_PN, [])])])])])])])])).
sent(s_044_5_h, eng, 'there are few committee members from Portugal').
sent(s_044_5_h, original, 'there are few committee members from Portugal').
sent(s_044_5_h, swe, 'det finns få kommittémedlemmar från Portugal').

tree(s_045_1_p, s_029_3_h).
sent(s_045_1_p, eng, 'both commissioners used to be businessmen').
sent(s_045_1_p, original, 'both commissioners used to be businessmen').
sent(s_045_1_p, swe, 'båda ombuden brukade vara affärsmän').

tree(s_045_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t(both_Det, []), t('UseN', [t(commissioner_N, [])])]), t('ComplVV', [t(use_VV, []), t('UseComp', [t('CompCN', [t('AdjCN', [t('PositA', [t(leading_A, [])]), t('UseN', [t(businessman_N, [])])])])])])])])])])).
sent(s_045_2_q, eng, 'did both commissioners used to be leading businessmen').
sent(s_045_2_q, original, 'did both commissioners used to be leading businessmen').
sent(s_045_2_q, swe, 'brukade båda ombuden vara ledande affärsmän').

tree(s_045_3_h, s_029_1_p).
sent(s_045_3_h, eng, 'both commissioners used to be leading businessmen').
sent(s_045_3_h, original, 'both commissioners used to be leading businessmen').
sent(s_045_3_h, swe, 'båda ombuden brukade vara ledande affärsmän').

tree(s_046_1_p, s_030_3_h).
sent(s_046_1_p, eng, 'neither commissioner spends time at home').
sent(s_046_1_p, original, 'neither commissioner spends time at home').
sent(s_046_1_p, swe, 'inget av ombuden tillbringar tid hemma').

tree(s_046_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t(either_Det, []), t('UseN', [t(commissioner_N, [])])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(spend_V2, [])]), t('DetCN', [t(a_lot_of_Det, []), t('UseN', [t(time_N, [])])])]), t(at_home_Adv, [])])])])])])).
sent(s_046_2_q, eng, 'does either commissioner spend a lot of time at home').
sent(s_046_2_q, original, 'does either commissioner spend a lot of time at home').
sent(s_046_2_q, swe, 'tillbringar något av ombuden mycket tid hemma').

tree(s_046_3_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('AdvNP', [t('DetNP', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])])]), t('PrepNP', [t(part_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumPl', [])]), t('UseN', [t(commissioner_N, [])])])])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(spend_V2, [])]), t('DetCN', [t(a_lot_of_Det, []), t('UseN', [t(time_N, [])])])]), t(at_home_Adv, [])])])])])).
sent(s_046_3_h, eng, 'one of the commissioners spends a lot of time at home').
sent(s_046_3_h, original, 'one of the commissioners spends a lot of time at home').
sent(s_046_3_h, swe, 'ett av ombuden tillbringar mycket tid hemma').

tree(s_047_1_p, s_031_3_h).
sent(s_047_1_p, eng, 'at least three commissioners spend time at home').
sent(s_047_1_p, original, 'at least three commissioners spend time at home').
sent(s_047_1_p, swe, 'minst tre ombud tillbringar tid hemma').

tree(s_047_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('PredetNP', [t(at_least_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_three', [])])])]), t('UseN', [t(commissioner_N, [])])])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(spend_V2, [])]), t('DetCN', [t(a_lot_of_Det, []), t('UseN', [t(time_N, [])])])]), t(at_home_Adv, [])])])])])])).
sent(s_047_2_q, eng, 'do at least three commissioners spend a lot of time at home').
sent(s_047_2_q, original, 'do at least three commissioners spend a lot of time at home').
sent(s_047_2_q, swe, 'tillbringar minst tre ombud mycket tid hemma').

tree(s_047_3_h, s_031_1_p).
sent(s_047_3_h, eng, 'at least three commissioners spend a lot of time at home').
sent(s_047_3_h, original, 'at least three commissioners spend a lot of time at home').
sent(s_047_3_h, swe, 'minst tre ombud tillbringar mycket tid hemma').

tree(s_048_1_p, s_032_3_h).
sent(s_048_1_p, eng, 'at most ten commissioners spend time at home').
sent(s_048_1_p, original, 'at most ten commissioners spend time at home').
sent(s_048_1_p, swe, 'högst tio ombud tillbringar tid hemma').

tree(s_048_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('PredetNP', [t(at_most_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_ten', [])])])]), t('UseN', [t(commissioner_N, [])])])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(spend_V2, [])]), t('DetCN', [t(a_lot_of_Det, []), t('UseN', [t(time_N, [])])])]), t(at_home_Adv, [])])])])])])).
sent(s_048_2_q, eng, 'do at most ten commissioners spend a lot of time at home').
sent(s_048_2_q, original, 'do at most ten commissioners spend a lot of time at home').
sent(s_048_2_q, swe, 'tillbringar högst tio ombud mycket tid hemma').

tree(s_048_3_h, s_032_1_p).
sent(s_048_3_h, eng, 'at most ten commissioners spend a lot of time at home').
sent(s_048_3_h, original, 'at most ten commissioners spend a lot of time at home').
sent(s_048_3_h, swe, 'högst tio ombud tillbringar mycket tid hemma').

tree(s_049_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(swede_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(win_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(nobel_prize_N, [])])])])])])])).
sent(s_049_1_p, eng, 'a Swede won a Nobel prize').
sent(s_049_1_p, original, 'a Swede won a Nobel prize').
sent(s_049_1_p, swe, 'en svensk vann ett nobelpris').

tree(s_049_2_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t(every_Det, []), t('UseN', [t(swede_N, [])])]), t('UseComp', [t('CompCN', [t('UseN', [t(scandinavian_N, [])])])])])])])).
sent(s_049_2_p, eng, 'every Swede is a Scandinavian').
sent(s_049_2_p, original, 'every Swede is a Scandinavian').
sent(s_049_2_p, swe, 'varje svensk är en skandinav').

tree(s_049_3_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(scandinavian_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(win_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(nobel_prize_N, [])])])])])])])])).
sent(s_049_3_q, eng, 'did a Scandinavian win a Nobel prize').
sent(s_049_3_q, original, 'did a Scandinavian win a Nobel prize').
sent(s_049_3_q, swe, 'vann en skandinav ett nobelpris').

tree(s_049_4_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(scandinavian_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(win_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(nobel_prize_N, [])])])])])])])).
sent(s_049_4_h, eng, 'a Scandinavian won a Nobel prize').
sent(s_049_4_h, original, 'a Scandinavian won a Nobel prize').
sent(s_049_4_h, swe, 'en skandinav vann ett nobelpris').

tree(s_050_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t(every_Det, []), t('AdjCN', [t('PositA', [t(canadian_A, [])]), t('UseN', [t(resident_N, [])])])]), t('ComplVV', [t(can_VV, []), t('AdvVP', [t('AdvVP', [t('UseV', [t(travel_V, [])]), t('PositAdvAdj', [t(free_A, [])])]), t('PrepNP', [t(within_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])).
sent(s_050_1_p, eng, 'every Canadian resident can travel freely within Europe').
sent(s_050_1_p, original, 'every Canadian resident can travel freely within Europe').
sent(s_050_1_p, swe, 'varje kanadensisk invånare kan resa fritt inom Europa').

tree(s_050_2_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t(every_Det, []), t('AdjCN', [t('PositA', [t(canadian_A, [])]), t('UseN', [t(resident_N, [])])])]), t('UseComp', [t('CompCN', [t('ComplN2', [t(resident_on_N2, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(north_american_A, [])]), t('UseN', [t(continent_N, [])])])])])])])])])])).
sent(s_050_2_p, eng, 'every Canadian resident is a resident of the North American continent').
sent(s_050_2_p, original, 'every Canadian resident is a resident of the North American continent').
sent(s_050_2_p, swe, 'varje kanadensisk invånare är en invånare på den nordamerikanska kontinenten').

tree(s_050_3_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t(every_Det, []), t('ComplN2', [t(resident_on_N2, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(north_american_A, [])]), t('UseN', [t(continent_N, [])])])])])]), t('ComplVV', [t(can_VV, []), t('AdvVP', [t('AdvVP', [t('UseV', [t(travel_V, [])]), t('PositAdvAdj', [t(free_A, [])])]), t('PrepNP', [t(within_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])])).
sent(s_050_3_q, eng, 'can every resident of the North American continent travel freely within Europe').
sent(s_050_3_q, original, 'can every resident of the North American continent travel freely within Europe').
sent(s_050_3_q, swe, 'kan varje invånare på den nordamerikanska kontinenten resa fritt inom Europa').

tree(s_050_4_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t(every_Det, []), t('ComplN2', [t(resident_on_N2, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(north_american_A, [])]), t('UseN', [t(continent_N, [])])])])])]), t('ComplVV', [t(can_VV, []), t('AdvVP', [t('AdvVP', [t('UseV', [t(travel_V, [])]), t('PositAdvAdj', [t(free_A, [])])]), t('PrepNP', [t(within_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])).
sent(s_050_4_h, eng, 'every resident of the North American continent can travel freely within Europe').
sent(s_050_4_h, original, 'every resident of the North American continent can travel freely within Europe').
sent(s_050_4_h, swe, 'varje invånare på den nordamerikanska kontinenten kan resa fritt inom Europa').

tree(s_051_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('PredetNP', [t(all_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('AdjCN', [t('PositA', [t(canadian_A, [])]), t('UseN', [t(resident_N, [])])])])]), t('ComplVV', [t(can_VV, []), t('AdvVP', [t('AdvVP', [t('UseV', [t(travel_V, [])]), t('PositAdvAdj', [t(free_A, [])])]), t('PrepNP', [t(within_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])).
sent(s_051_1_p, eng, 'all Canadian residents can travel freely within Europe').
sent(s_051_1_p, original, 'all Canadian residents can travel freely within Europe').
sent(s_051_1_p, swe, 'alla kanadensiska invånare kan resa fritt inom Europa').

tree(s_051_2_p, s_050_2_p).
sent(s_051_2_p, eng, 'every Canadian resident is a resident of the North American continent').
sent(s_051_2_p, original, 'every Canadian resident is a resident of the North American continent').
sent(s_051_2_p, swe, 'varje kanadensisk invånare är en invånare på den nordamerikanska kontinenten').

tree(s_051_3_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('PredetNP', [t(all_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('ComplN2', [t(resident_on_N2, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(north_american_A, [])]), t('UseN', [t(continent_N, [])])])])])])]), t('ComplVV', [t(can_VV, []), t('AdvVP', [t('AdvVP', [t('UseV', [t(travel_V, [])]), t('PositAdvAdj', [t(free_A, [])])]), t('PrepNP', [t(within_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])])).
sent(s_051_3_q, eng, 'can all residents of the North American continent travel freely within Europe').
sent(s_051_3_q, original, 'can all residents of the North American continent travel freely within Europe').
sent(s_051_3_q, swe, 'kan alla invånare på den nordamerikanska kontinenten resa fritt inom Europa').

tree(s_051_4_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('PredetNP', [t(all_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('ComplN2', [t(resident_on_N2, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(north_american_A, [])]), t('UseN', [t(continent_N, [])])])])])])]), t('ComplVV', [t(can_VV, []), t('AdvVP', [t('AdvVP', [t('UseV', [t(travel_V, [])]), t('PositAdvAdj', [t(free_A, [])])]), t('PrepNP', [t(within_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])).
sent(s_051_4_h, eng, 'all residents of the North American continent can travel freely within Europe').
sent(s_051_4_h, original, 'all residents of the North American continent can travel freely within Europe').
sent(s_051_4_h, swe, 'alla invånare på den nordamerikanska kontinenten kan resa fritt inom Europa').

tree(s_052_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t(each_Det, []), t('AdjCN', [t('PositA', [t(canadian_A, [])]), t('UseN', [t(resident_N, [])])])]), t('ComplVV', [t(can_VV, []), t('AdvVP', [t('AdvVP', [t('UseV', [t(travel_V, [])]), t('PositAdvAdj', [t(free_A, [])])]), t('PrepNP', [t(within_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])).
sent(s_052_1_p, eng, 'each Canadian resident can travel freely within Europe').
sent(s_052_1_p, original, 'each Canadian resident can travel freely within Europe').
sent(s_052_1_p, swe, 'varje kanadensisk invånare kan resa fritt inom Europa').

tree(s_052_2_p, s_050_2_p).
sent(s_052_2_p, eng, 'every Canadian resident is a resident of the North American continent').
sent(s_052_2_p, original, 'every Canadian resident is a resident of the North American continent').
sent(s_052_2_p, swe, 'varje kanadensisk invånare är en invånare på den nordamerikanska kontinenten').

tree(s_052_3_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t(each_Det, []), t('ComplN2', [t(resident_on_N2, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(north_american_A, [])]), t('UseN', [t(continent_N, [])])])])])]), t('ComplVV', [t(can_VV, []), t('AdvVP', [t('AdvVP', [t('UseV', [t(travel_V, [])]), t('PositAdvAdj', [t(free_A, [])])]), t('PrepNP', [t(within_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])])).
sent(s_052_3_q, eng, 'can each resident of the North American continent travel freely within Europe').
sent(s_052_3_q, original, 'can each resident of the North American continent travel freely within Europe').
sent(s_052_3_q, swe, 'kan varje invånare på den nordamerikanska kontinenten resa fritt inom Europa').

tree(s_052_4_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t(each_Det, []), t('ComplN2', [t(resident_on_N2, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(north_american_A, [])]), t('UseN', [t(continent_N, [])])])])])]), t('ComplVV', [t(can_VV, []), t('AdvVP', [t('AdvVP', [t('UseV', [t(travel_V, [])]), t('PositAdvAdj', [t(free_A, [])])]), t('PrepNP', [t(within_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])).
sent(s_052_4_h, eng, 'each resident of the North American continent can travel freely within Europe').
sent(s_052_4_h, original, 'each resident of the North American continent can travel freely within Europe').
sent(s_052_4_h, swe, 'varje invånare på den nordamerikanska kontinenten kan resa fritt inom Europa').

tree(s_053_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumPl', [])]), t('ComplN2', [t(resident_in_N2, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('AdjCN', [t('PositA', [t(major_A, [])]), t('AdjCN', [t('PositA', [t(western_A, [])]), t('UseN', [t(country_N, [])])])])])])]), t('ComplVV', [t(can_VV, []), t('AdvVP', [t('AdvVP', [t('UseV', [t(travel_V, [])]), t('PositAdvAdj', [t(free_A, [])])]), t('PrepNP', [t(within_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])).
sent(s_053_1_p, eng, 'the residents of major western countries can travel freely within Europe').
sent(s_053_1_p, original, 'the residents of major western countries can travel freely within Europe').
sent(s_053_1_p, swe, 'invånarna i större västerländska länder kan resa fritt inom Europa').

tree(s_053_2_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('PredetNP', [t(all_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('ComplN2', [t(resident_in_N2, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('AdjCN', [t('PositA', [t(major_A, [])]), t('AdjCN', [t('PositA', [t(western_A, [])]), t('UseN', [t(country_N, [])])])])])])])]), t('UseComp', [t('CompCN', [t('ComplN2', [t(resident_in_N2, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('AdjCN', [t('PositA', [t(western_A, [])]), t('UseN', [t(country_N, [])])])])])])])])])])).
sent(s_053_2_p, eng, 'all residents of major western countries are residents of western countries').
sent(s_053_2_p, original, 'all residents of major western countries are residents of western countries').
sent(s_053_2_p, swe, 'alla invånare i större västerländska länder är invånare i västerländska länder').

tree(s_053_3_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumPl', [])]), t('ComplN2', [t(resident_in_N2, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('AdjCN', [t('PositA', [t(western_A, [])]), t('UseN', [t(country_N, [])])])])])]), t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('SentCN', [t('UseN', [t(right_N, [])]), t('EmbedVP', [t('AdvVP', [t('UseV', [t(live_V, [])]), t('PrepNP', [t(in_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])])])])])).
sent(s_053_3_q, eng, 'do the residents of western countries have the right to live in Europe').
sent(s_053_3_q, original, 'do the residents of western countries have the right to live in Europe').
sent(s_053_3_q, swe, 'har invånarna i västerländska länder rätten att bo i Europa').

tree(s_053_4_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumPl', [])]), t('ComplN2', [t(resident_in_N2, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('AdjCN', [t('PositA', [t(western_A, [])]), t('UseN', [t(country_N, [])])])])])]), t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('SentCN', [t('UseN', [t(right_N, [])]), t('EmbedVP', [t('AdvVP', [t('UseV', [t(live_V, [])]), t('PrepNP', [t(in_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])])])])).
sent(s_053_4_h, eng, 'the residents of western countries have the right to live in Europe').
sent(s_053_4_h, original, 'the residents of western countries have the right to live in Europe').
sent(s_053_4_h, swe, 'invånarna i västerländska länder har rätten att bo i Europa').

tree(s_054_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t(no_Quant, []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(scandinavian_A, [])]), t('UseN', [t(delegate_N, [])])])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(finish_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])]), t(on_time_Adv, [])])])])])).
sent(s_054_1_p, eng, 'no Scandinavian delegate finished the report on time').
sent(s_054_1_p, original, 'no Scandinavian delegate finished the report on time').
sent(s_054_1_p, swe, 'ingen skandinavisk delegat slutförde rapporten i tid').

tree(s_054_2_q, s_038_2_q).
sent(s_054_2_q, eng, 'did any delegate finish the report on time').
sent(s_054_2_q, original, 'did any delegate finish the report on time').
sent(s_054_2_q, swe, 'slutförde någon delegat rapporten i tid').

tree(s_054_3_h, s_038_3_h).
sent(s_054_3_h, eng, 'some delegate finished the report on time').
sent(s_054_3_h, original, 'some delegate finished the report on time').
sent(s_054_3_h, swe, 'någon delegat slutförde rapporten i tid').

tree(s_055_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t(somePl_Det, []), t('AdjCN', [t('PositA', [t(irish_A, [])]), t('UseN', [t(delegate_N, [])])])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(finish_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(survey_N, [])])])]), t(on_time_Adv, [])])])])])).
sent(s_055_1_p, eng, 'some Irish delegates finished the survey on time').
sent(s_055_1_p, original, 'some Irish delegates finished the survey on time').
sent(s_055_1_p, swe, 'några irländska delegater slutförde undersökningen i tid').

tree(s_055_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t(anyPl_Det, []), t('UseN', [t(delegate_N, [])])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(finish_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(survey_N, [])])])]), t(on_time_Adv, [])])])])])])).
sent(s_055_2_q, eng, 'did any delegates finish the survey on time').
sent(s_055_2_q, original, 'did any delegates finish the survey on time').
sent(s_055_2_q, swe, 'slutförde några delegater undersökningen i tid').

tree(s_055_3_h, s_023_1_p).
sent(s_055_3_h, eng, 'some delegates finished the survey on time').
sent(s_055_3_h, original, 'some delegates finished the survey on time').
sent(s_055_3_h, swe, 'några delegater slutförde undersökningen i tid').

tree(s_056_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t(many_Det, []), t('AdjCN', [t('PositA', [t(british_A, [])]), t('UseN', [t(delegate_N, [])])])]), t('ComplSlash', [t('Slash3V3', [t(obtain_from_V3, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(survey_N, [])])])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('AdjCN', [t('PositA', [t(interesting_A, [])]), t('UseN', [t(result_N, [])])])])])])])])).
sent(s_056_1_p, eng, 'many British delegates obtained interesting results from the survey').
sent(s_056_1_p, original, 'many British delegates obtained interesting results from the survey').
sent(s_056_1_p, swe, 'många brittiska delegater erhöll intressanta resultat från undersökningen').

tree(s_056_2_q, s_040_2_q).
sent(s_056_2_q, eng, 'did many delegates obtain interesting results from the survey').
sent(s_056_2_q, original, 'did many delegates obtain interesting results from the survey').
sent(s_056_2_q, swe, 'erhöll många delegater intressanta resultat från undersökningen').

tree(s_056_3_h, s_024_1_p).
sent(s_056_3_h, eng, 'many delegates obtained interesting results from the survey').
sent(s_056_3_h, original, 'many delegates obtained interesting results from the survey').
sent(s_056_3_h, swe, 'många delegater erhöll intressanta resultat från undersökningen').

tree(s_057_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t(several_Det, []), t('AdjCN', [t('PositA', [t(portuguese_A, [])]), t('UseN', [t(delegate_N, [])])])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(get_V2, [])]), t('PPartNP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumPl', [])]), t('UseN', [t(result_N, [])])]), t(publish_V2, [])])]), t('PrepNP', [t(in_Prep, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('AdjCN', [t('PositA', [t(major_A, [])]), t('AdjCN', [t('PositA', [t(national_A, [])]), t('UseN', [t(newspaper_N, [])])])])])])])])])])).
sent(s_057_1_p, eng, 'several Portuguese delegates got the results published in major national newspapers').
sent(s_057_1_p, original, 'several Portuguese delegates got the results published in major national newspapers').
sent(s_057_1_p, swe, 'flera portugisiska delegater fick resultaten publicerade i större nationella tidningar').

tree(s_057_2_q, s_041_2_q).
sent(s_057_2_q, eng, 'did several delegates get the results published in major national newspapers').
sent(s_057_2_q, original, 'did several delegates get the results published in major national newspapers').
sent(s_057_2_q, swe, 'fick flera delegater resultaten publicerade i större nationella tidningar').

tree(s_057_3_h, s_025_1_p).
sent(s_057_3_h, eng, 'several delegates got the results published in major national newspapers').
sent(s_057_3_h, original, 'several delegates got the results published in major national newspapers').
sent(s_057_3_h, swe, 'flera delegater fick resultaten publicerade i större nationella tidningar').

tree(s_058_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('PredetNP', [t(most_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('RelCN', [t('UseN', [t(european_N, [])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('AdvVP', [t('UseComp', [t('CompAP', [t('PositA', [t(resident_A, [])])])]), t('PrepNP', [t(in_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])]), t('ComplVV', [t(can_VV, []), t('AdvVP', [t('AdvVP', [t('UseV', [t(travel_V, [])]), t('PositAdvAdj', [t(free_A, [])])]), t('PrepNP', [t(within_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])).
sent(s_058_1_p, eng, 'most Europeans who are resident in Europe can travel freely within Europe').
sent(s_058_1_p, original, 'most Europeans who are resident in Europe can travel freely within Europe').
sent(s_058_1_p, swe, 'de flesta européer som är bosatta i Europa kan resa fritt inom Europa').

tree(s_058_2_q, s_026_4_q).
sent(s_058_2_q, eng, 'can most Europeans travel freely within Europe').
sent(s_058_2_q, original, 'can most Europeans travel freely within Europe').
sent(s_058_2_q, swe, 'kan de flesta européer resa fritt inom Europa').

tree(s_058_3_h, s_026_5_h).
sent(s_058_3_h, eng, 'most Europeans can travel freely within Europe').
sent(s_058_3_h, original, 'most Europeans can travel freely within Europe').
sent(s_058_3_h, swe, 'de flesta européer kan resa fritt inom Europa').

tree(s_059_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t(a_few_Det, []), t('AdjCN', [t('PositA', [t(female_A, [])]), t('UseN', [t(committee_member_N, [])])])]), t('UseComp', [t('CompAdv', [t('PrepNP', [t(from_Prep, []), t('UsePN', [t(scandinavia_PN, [])])])])])])])])).
sent(s_059_1_p, eng, 'a few female committee members are from Scandinavia').
sent(s_059_1_p, original, 'a few female committee members are from Scandinavia').
sent(s_059_1_p, swe, 'ett fåtal kvinnliga kommittémedlemmar är från Skandinavien').

tree(s_059_2_q, s_027_4_q).
sent(s_059_2_q, eng, 'are at least a few committee members from Scandinavia').
sent(s_059_2_q, original, 'are at least a few committee members from Scandinavia').
sent(s_059_2_q, swe, 'är minst ett fåtal kommittémedlemmar från Skandinavien').

tree(s_059_3_h, s_027_5_h).
sent(s_059_3_h, eng, 'at least a few committee members are from Scandinavia').
sent(s_059_3_h, original, 'at least a few committee members are from Scandinavia').
sent(s_059_3_h, swe, 'minst ett fåtal kommittémedlemmar är från Skandinavien').

tree(s_060_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t(few_Det, []), t('AdjCN', [t('PositA', [t(female_A, [])]), t('UseN', [t(committee_member_N, [])])])]), t('UseComp', [t('CompAdv', [t('PrepNP', [t(from_Prep, []), t('UsePN', [t(southern_europe_PN, [])])])])])])])])).
sent(s_060_1_p, eng, 'few female committee members are from southern Europe').
sent(s_060_1_p, original, 'few female committee members are from southern Europe').
sent(s_060_1_p, swe, 'få kvinnliga kommittémedlemmar är från södra Europa').

tree(s_060_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t(few_Det, []), t('UseN', [t(committee_member_N, [])])]), t('UseComp', [t('CompAdv', [t('PrepNP', [t(from_Prep, []), t('UsePN', [t(southern_europe_PN, [])])])])])])])])])).
sent(s_060_2_q, eng, 'are few committee members from southern Europe').
sent(s_060_2_q, original, 'are few committee members from southern Europe').
sent(s_060_2_q, swe, 'är få kommittémedlemmar från södra Europa').

tree(s_060_3_h, s_044_1_p).
sent(s_060_3_h, eng, 'few committee members are from southern Europe').
sent(s_060_3_h, original, 'few committee members are from southern Europe').
sent(s_060_3_h, swe, 'få kommittémedlemmar är från södra Europa').

tree(s_061_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t(both_Det, []), t('AdjCN', [t('PositA', [t(female_A, [])]), t('UseN', [t(commissioner_N, [])])])]), t('ComplVV', [t(use_VV, []), t('UseComp', [t('CompAdv', [t('PrepNP', [t(in_Prep, []), t('MassNP', [t('UseN', [t(business_N, [])])])])])])])])])])).
sent(s_061_1_p, eng, 'both female commissioners used to be in business').
sent(s_061_1_p, original, 'both female commissioners used to be in business').
sent(s_061_1_p, swe, 'båda de kvinnliga ombuden brukade vara i affärsverksamhet').

tree(s_061_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t(both_Det, []), t('UseN', [t(commissioner_N, [])])]), t('ComplVV', [t(use_VV, []), t('UseComp', [t('CompAdv', [t('PrepNP', [t(in_Prep, []), t('MassNP', [t('UseN', [t(business_N, [])])])])])])])])])])])).
sent(s_061_2_q, eng, 'did both commissioners used to be in business').
sent(s_061_2_q, original, 'did both commissioners used to be in business').
sent(s_061_2_q, swe, 'brukade båda ombuden vara i affärsverksamhet').

tree(s_061_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t(both_Det, []), t('UseN', [t(commissioner_N, [])])]), t('ComplVV', [t(use_VV, []), t('UseComp', [t('CompAdv', [t('PrepNP', [t(in_Prep, []), t('MassNP', [t('UseN', [t(business_N, [])])])])])])])])])])).
sent(s_061_3_h, eng, 'both commissioners used to be in business').
sent(s_061_3_h, original, 'both commissioners used to be in business').
sent(s_061_3_h, swe, 'båda ombuden brukade vara i affärsverksamhet').

tree(s_062_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t(neither_Det, []), t('AdjCN', [t('PositA', [t(female_A, [])]), t('UseN', [t(commissioner_N, [])])])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(spend_V2, [])]), t('DetCN', [t(a_lot_of_Det, []), t('UseN', [t(time_N, [])])])]), t(at_home_Adv, [])])])])])).
sent(s_062_1_p, eng, 'neither female commissioner spends a lot of time at home').
sent(s_062_1_p, original, 'neither female commissioner spends a lot of time at home').
sent(s_062_1_p, swe, 'inget av de kvinnliga ombuden tillbringar mycket tid hemma').

tree(s_062_2_q, s_046_2_q).
sent(s_062_2_q, eng, 'does either commissioner spend a lot of time at home').
sent(s_062_2_q, original, 'does either commissioner spend a lot of time at home').
sent(s_062_2_q, swe, 'tillbringar något av ombuden mycket tid hemma').

tree(s_062_3_h, s_046_3_h).
sent(s_062_3_h, eng, 'one of the commissioners spends a lot of time at home').
sent(s_062_3_h, original, 'one of the commissioners spends a lot of time at home').
sent(s_062_3_h, swe, 'ett av ombuden tillbringar mycket tid hemma').

tree(s_063_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('PredetNP', [t(at_least_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_three', [])])])]), t('AdjCN', [t('PositA', [t(female_A, [])]), t('UseN', [t(commissioner_N, [])])])])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(spend_V2, [])]), t('MassNP', [t('UseN', [t(time_N, [])])])]), t(at_home_Adv, [])])])])])).
sent(s_063_1_p, eng, 'at least three female commissioners spend time at home').
sent(s_063_1_p, original, 'at least three female commissioners spend time at home').
sent(s_063_1_p, swe, 'minst tre kvinnliga ombud tillbringar tid hemma').

tree(s_063_2_q, s_031_2_q).
sent(s_063_2_q, eng, 'do at least three commissioners spend time at home').
sent(s_063_2_q, original, 'do at least three commissioners spend time at home').
sent(s_063_2_q, swe, 'tillbringar minst tre ombud tid hemma').

tree(s_063_3_h, s_031_3_h).
sent(s_063_3_h, eng, 'at least three commissioners spend time at home').
sent(s_063_3_h, original, 'at least three commissioners spend time at home').
sent(s_063_3_h, swe, 'minst tre ombud tillbringar tid hemma').

tree(s_064_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('PredetNP', [t(at_most_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_ten', [])])])]), t('AdjCN', [t('PositA', [t(female_A, [])]), t('UseN', [t(commissioner_N, [])])])])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(spend_V2, [])]), t('MassNP', [t('UseN', [t(time_N, [])])])]), t(at_home_Adv, [])])])])])).
sent(s_064_1_p, eng, 'at most ten female commissioners spend time at home').
sent(s_064_1_p, original, 'at most ten female commissioners spend time at home').
sent(s_064_1_p, swe, 'högst tio kvinnliga ombud tillbringar tid hemma').

tree(s_064_2_q, s_032_2_q).
sent(s_064_2_q, eng, 'do at most ten commissioners spend time at home').
sent(s_064_2_q, original, 'do at most ten commissioners spend time at home').
sent(s_064_2_q, swe, 'tillbringar högst tio ombud tid hemma').

tree(s_064_3_h, s_032_3_h).
sent(s_064_3_h, eng, 'at most ten commissioners spend time at home').
sent(s_064_3_h, original, 'at most ten commissioners spend time at home').
sent(s_064_3_h, swe, 'högst tio ombud tillbringar tid hemma').

tree(s_065_1_p, s_049_4_h).
sent(s_065_1_p, eng, 'a Scandinavian won a Nobel prize').
sent(s_065_1_p, original, 'a Scandinavian won a Nobel prize').
sent(s_065_1_p, swe, 'en skandinav vann ett nobelpris').

tree(s_065_2_p, s_049_2_p).
sent(s_065_2_p, eng, 'every Swede is a Scandinavian').
sent(s_065_2_p, original, 'every Swede is a Scandinavian').
sent(s_065_2_p, swe, 'varje svensk är en skandinav').

tree(s_065_3_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(swede_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(win_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(nobel_prize_N, [])])])])])])])])).
sent(s_065_3_q, eng, 'did a Swede win a Nobel prize').
sent(s_065_3_q, original, 'did a Swede win a Nobel prize').
sent(s_065_3_q, swe, 'vann en svensk ett nobelpris').

tree(s_065_4_h, s_049_1_p).
sent(s_065_4_h, eng, 'a Swede won a Nobel prize').
sent(s_065_4_h, original, 'a Swede won a Nobel prize').
sent(s_065_4_h, swe, 'en svensk vann ett nobelpris').

tree(s_066_1_p, s_050_4_h).
sent(s_066_1_p, eng, 'every resident of the North American continent can travel freely within Europe').
sent(s_066_1_p, original, 'every resident of the North American continent can travel freely within Europe').
sent(s_066_1_p, swe, 'varje invånare på den nordamerikanska kontinenten kan resa fritt inom Europa').

tree(s_066_2_p, s_050_2_p).
sent(s_066_2_p, eng, 'every Canadian resident is a resident of the North American continent').
sent(s_066_2_p, original, 'every Canadian resident is a resident of the North American continent').
sent(s_066_2_p, swe, 'varje kanadensisk invånare är en invånare på den nordamerikanska kontinenten').

tree(s_066_3_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t(every_Det, []), t('AdjCN', [t('PositA', [t(canadian_A, [])]), t('UseN', [t(resident_N, [])])])]), t('ComplVV', [t(can_VV, []), t('AdvVP', [t('AdvVP', [t('UseV', [t(travel_V, [])]), t('PositAdvAdj', [t(free_A, [])])]), t('PrepNP', [t(within_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])])).
sent(s_066_3_q, eng, 'can every Canadian resident travel freely within Europe').
sent(s_066_3_q, original, 'can every Canadian resident travel freely within Europe').
sent(s_066_3_q, swe, 'kan varje kanadensisk invånare resa fritt inom Europa').

tree(s_066_4_h, s_050_1_p).
sent(s_066_4_h, eng, 'every Canadian resident can travel freely within Europe').
sent(s_066_4_h, original, 'every Canadian resident can travel freely within Europe').
sent(s_066_4_h, swe, 'varje kanadensisk invånare kan resa fritt inom Europa').

tree(s_067_1_p, s_051_4_h).
sent(s_067_1_p, eng, 'all residents of the North American continent can travel freely within Europe').
sent(s_067_1_p, original, 'all residents of the North American continent can travel freely within Europe').
sent(s_067_1_p, swe, 'alla invånare på den nordamerikanska kontinenten kan resa fritt inom Europa').

tree(s_067_2_p, s_050_2_p).
sent(s_067_2_p, eng, 'every Canadian resident is a resident of the North American continent').
sent(s_067_2_p, original, 'every Canadian resident is a resident of the North American continent').
sent(s_067_2_p, swe, 'varje kanadensisk invånare är en invånare på den nordamerikanska kontinenten').

tree(s_067_3_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('PredetNP', [t(all_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('AdjCN', [t('PositA', [t(canadian_A, [])]), t('UseN', [t(resident_N, [])])])])]), t('ComplVV', [t(can_VV, []), t('AdvVP', [t('AdvVP', [t('UseV', [t(travel_V, [])]), t('PositAdvAdj', [t(free_A, [])])]), t('PrepNP', [t(within_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])])).
sent(s_067_3_q, eng, 'can all Canadian residents travel freely within Europe').
sent(s_067_3_q, original, 'can all Canadian residents travel freely within Europe').
sent(s_067_3_q, swe, 'kan alla kanadensiska invånare resa fritt inom Europa').

tree(s_067_4_h, s_051_1_p).
sent(s_067_4_h, eng, 'all Canadian residents can travel freely within Europe').
sent(s_067_4_h, original, 'all Canadian residents can travel freely within Europe').
sent(s_067_4_h, swe, 'alla kanadensiska invånare kan resa fritt inom Europa').

tree(s_068_1_p, s_052_4_h).
sent(s_068_1_p, eng, 'each resident of the North American continent can travel freely within Europe').
sent(s_068_1_p, original, 'each resident of the North American continent can travel freely within Europe').
sent(s_068_1_p, swe, 'varje invånare på den nordamerikanska kontinenten kan resa fritt inom Europa').

tree(s_068_2_p, s_050_2_p).
sent(s_068_2_p, eng, 'every Canadian resident is a resident of the North American continent').
sent(s_068_2_p, original, 'every Canadian resident is a resident of the North American continent').
sent(s_068_2_p, swe, 'varje kanadensisk invånare är en invånare på den nordamerikanska kontinenten').

tree(s_068_3_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t(each_Det, []), t('AdjCN', [t('PositA', [t(canadian_A, [])]), t('UseN', [t(resident_N, [])])])]), t('ComplVV', [t(can_VV, []), t('AdvVP', [t('AdvVP', [t('UseV', [t(travel_V, [])]), t('PositAdvAdj', [t(free_A, [])])]), t('PrepNP', [t(within_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])])).
sent(s_068_3_q, eng, 'can each Canadian resident travel freely within Europe').
sent(s_068_3_q, original, 'can each Canadian resident travel freely within Europe').
sent(s_068_3_q, swe, 'kan varje kanadensisk invånare resa fritt inom Europa').

tree(s_068_4_h, s_052_1_p).
sent(s_068_4_h, eng, 'each Canadian resident can travel freely within Europe').
sent(s_068_4_h, original, 'each Canadian resident can travel freely within Europe').
sent(s_068_4_h, swe, 'varje kanadensisk invånare kan resa fritt inom Europa').

tree(s_069_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumPl', [])]), t('ComplN2', [t(resident_in_N2, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('AdjCN', [t('PositA', [t(western_A, [])]), t('UseN', [t(country_N, [])])])])])]), t('ComplVV', [t(can_VV, []), t('AdvVP', [t('AdvVP', [t('UseV', [t(travel_V, [])]), t('PositAdvAdj', [t(free_A, [])])]), t('PrepNP', [t(within_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])).
sent(s_069_1_p, eng, 'the residents of western countries can travel freely within Europe').
sent(s_069_1_p, original, 'the residents of western countries can travel freely within Europe').
sent(s_069_1_p, swe, 'invånarna i västerländska länder kan resa fritt inom Europa').

tree(s_069_2_p, s_053_2_p).
sent(s_069_2_p, eng, 'all residents of major western countries are residents of western countries').
sent(s_069_2_p, original, 'all residents of major western countries are residents of western countries').
sent(s_069_2_p, swe, 'alla invånare i större västerländska länder är invånare i västerländska länder').

tree(s_069_3_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumPl', [])]), t('ComplN2', [t(resident_in_N2, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('AdjCN', [t('PositA', [t(major_A, [])]), t('AdjCN', [t('PositA', [t(western_A, [])]), t('UseN', [t(country_N, [])])])])])])]), t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('SentCN', [t('UseN', [t(right_N, [])]), t('EmbedVP', [t('AdvVP', [t('UseV', [t(live_V, [])]), t('PrepNP', [t(in_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])])])])])).
sent(s_069_3_q, eng, 'do the residents of major western countries have the right to live in Europe').
sent(s_069_3_q, original, 'do the residents of major western countries have the right to live in Europe').
sent(s_069_3_q, swe, 'har invånarna i större västerländska länder rätten att bo i Europa').

tree(s_069_4_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumPl', [])]), t('ComplN2', [t(resident_in_N2, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('AdjCN', [t('PositA', [t(major_A, [])]), t('AdjCN', [t('PositA', [t(western_A, [])]), t('UseN', [t(country_N, [])])])])])])]), t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('SentCN', [t('UseN', [t(right_N, [])]), t('EmbedVP', [t('AdvVP', [t('UseV', [t(live_V, [])]), t('PrepNP', [t(in_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])])])])).
sent(s_069_4_h, eng, 'the residents of major western countries have the right to live in Europe').
sent(s_069_4_h, original, 'the residents of major western countries have the right to live in Europe').
sent(s_069_4_h, swe, 'invånarna i större västerländska länder har rätten att bo i Europa').

tree(s_070_1_p, s_022_1_p).
sent(s_070_1_p, eng, 'no delegate finished the report on time').
sent(s_070_1_p, original, 'no delegate finished the report on time').
sent(s_070_1_p, swe, 'ingen delegat slutförde rapporten i tid').

tree(s_070_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t(anySg_Det, []), t('AdjCN', [t('PositA', [t(scandinavian_A, [])]), t('UseN', [t(delegate_N, [])])])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(finish_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])]), t(on_time_Adv, [])])])])])])).
sent(s_070_2_q, eng, 'did any Scandinavian delegate finish the report on time').
sent(s_070_2_q, original, 'did any Scandinavian delegate finish the report on time').
sent(s_070_2_q, swe, 'slutförde någon skandinavisk delegat rapporten i tid').

tree(s_070_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t(someSg_Det, []), t('AdjCN', [t('PositA', [t(scandinavian_A, [])]), t('UseN', [t(delegate_N, [])])])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(finish_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])]), t(on_time_Adv, [])])])])])).
sent(s_070_3_h, eng, 'some Scandinavian delegate finished the report on time').
sent(s_070_3_h, original, 'some Scandinavian delegate finished the report on time').
sent(s_070_3_h, swe, 'någon skandinavisk delegat slutförde rapporten i tid').

tree(s_071_1_p, s_023_1_p).
sent(s_071_1_p, eng, 'some delegates finished the survey on time').
sent(s_071_1_p, original, 'some delegates finished the survey on time').
sent(s_071_1_p, swe, 'några delegater slutförde undersökningen i tid').

tree(s_071_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t(anyPl_Det, []), t('AdjCN', [t('PositA', [t(irish_A, [])]), t('UseN', [t(delegate_N, [])])])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(finish_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(survey_N, [])])])]), t(on_time_Adv, [])])])])])])).
sent(s_071_2_q, eng, 'did any Irish delegates finish the survey on time').
sent(s_071_2_q, original, 'did any Irish delegates finish the survey on time').
sent(s_071_2_q, swe, 'slutförde några irländska delegater undersökningen i tid').

tree(s_071_3_h, s_055_1_p).
sent(s_071_3_h, eng, 'some Irish delegates finished the survey on time').
sent(s_071_3_h, original, 'some Irish delegates finished the survey on time').
sent(s_071_3_h, swe, 'några irländska delegater slutförde undersökningen i tid').

tree(s_072_1_p, s_024_1_p).
sent(s_072_1_p, eng, 'many delegates obtained interesting results from the survey').
sent(s_072_1_p, original, 'many delegates obtained interesting results from the survey').
sent(s_072_1_p, swe, 'många delegater erhöll intressanta resultat från undersökningen').

tree(s_072_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t(many_Det, []), t('AdjCN', [t('PositA', [t(british_A, [])]), t('UseN', [t(delegate_N, [])])])]), t('ComplSlash', [t('Slash3V3', [t(obtain_from_V3, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(survey_N, [])])])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('AdjCN', [t('PositA', [t(interesting_A, [])]), t('UseN', [t(result_N, [])])])])])])])])])).
sent(s_072_2_q, eng, 'did many British delegates obtain interesting results from the survey').
sent(s_072_2_q, original, 'did many British delegates obtain interesting results from the survey').
sent(s_072_2_q, swe, 'erhöll många brittiska delegater intressanta resultat från undersökningen').

tree(s_072_3_h, s_056_1_p).
sent(s_072_3_h, eng, 'many British delegates obtained interesting results from the survey').
sent(s_072_3_h, original, 'many British delegates obtained interesting results from the survey').
sent(s_072_3_h, swe, 'många brittiska delegater erhöll intressanta resultat från undersökningen').

tree(s_073_1_p, s_025_1_p).
sent(s_073_1_p, eng, 'several delegates got the results published in major national newspapers').
sent(s_073_1_p, original, 'several delegates got the results published in major national newspapers').
sent(s_073_1_p, swe, 'flera delegater fick resultaten publicerade i större nationella tidningar').

tree(s_073_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t(several_Det, []), t('AdjCN', [t('PositA', [t(portuguese_A, [])]), t('UseN', [t(delegate_N, [])])])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(get_V2, [])]), t('PPartNP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumPl', [])]), t('UseN', [t(result_N, [])])]), t(publish_V2, [])])]), t('PrepNP', [t(in_Prep, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('AdjCN', [t('PositA', [t(major_A, [])]), t('AdjCN', [t('PositA', [t(national_A, [])]), t('UseN', [t(newspaper_N, [])])])])])])])])])])])).
sent(s_073_2_q, eng, 'did several Portuguese delegates get the results published in major national newspapers').
sent(s_073_2_q, original, 'did several Portuguese delegates get the results published in major national newspapers').
sent(s_073_2_q, swe, 'fick flera portugisiska delegater resultaten publicerade i större nationella tidningar').

tree(s_073_3_h, s_057_1_p).
sent(s_073_3_h, eng, 'several Portuguese delegates got the results published in major national newspapers').
sent(s_073_3_h, original, 'several Portuguese delegates got the results published in major national newspapers').
sent(s_073_3_h, swe, 'flera portugisiska delegater fick resultaten publicerade i större nationella tidningar').

tree(s_074_1_p, s_026_5_h).
sent(s_074_1_p, eng, 'most Europeans can travel freely within Europe').
sent(s_074_1_p, original, 'most Europeans can travel freely within Europe').
sent(s_074_1_p, swe, 'de flesta européer kan resa fritt inom Europa').

tree(s_074_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('PredetNP', [t(most_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('RelCN', [t('UseN', [t(european_N, [])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('UseComp', [t('CompAP', [t('AdvAP', [t('PositA', [t(resident_A, [])]), t('PrepNP', [t(outside_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])])])]), t('ComplVV', [t(can_VV, []), t('AdvVP', [t('AdvVP', [t('UseV', [t(travel_V, [])]), t('PositAdvAdj', [t(free_A, [])])]), t('PrepNP', [t(within_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])])).
sent(s_074_2_q, eng, 'can most Europeans who are resident outside Europe travel freely within Europe').
sent(s_074_2_q, original, 'can most Europeans who are resident outside Europe travel freely within Europe').
sent(s_074_2_q, swe, 'kan de flesta européer som är bosatta utanför Europa resa fritt inom Europa').

tree(s_074_3_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('PredetNP', [t(most_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('RelCN', [t('UseN', [t(european_N, [])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('UseComp', [t('CompAP', [t('AdvAP', [t('PositA', [t(resident_A, [])]), t('PrepNP', [t(outside_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])])])]), t('ComplVV', [t(can_VV, []), t('AdvVP', [t('AdvVP', [t('UseV', [t(travel_V, [])]), t('PositAdvAdj', [t(free_A, [])])]), t('PrepNP', [t(within_Prep, []), t('UsePN', [t(europe_PN, [])])])])])])])])).
sent(s_074_3_h, eng, 'most Europeans who are resident outside Europe can travel freely within Europe').
sent(s_074_3_h, original, 'most Europeans who are resident outside Europe can travel freely within Europe').
sent(s_074_3_h, swe, 'de flesta européer som är bosatta utanför Europa kan resa fritt inom Europa').

tree(s_075_1_p, s_043_1_p).
sent(s_075_1_p, eng, 'a few committee members are from Scandinavia').
sent(s_075_1_p, original, 'a few committee members are from Scandinavia').
sent(s_075_1_p, swe, 'ett fåtal kommittémedlemmar är från Skandinavien').

tree(s_075_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('PredetNP', [t(at_least_Predet, []), t('DetCN', [t(a_few_Det, []), t('AdjCN', [t('PositA', [t(female_A, [])]), t('UseN', [t(committee_member_N, [])])])])]), t('UseComp', [t('CompAdv', [t('PrepNP', [t(from_Prep, []), t('UsePN', [t(scandinavia_PN, [])])])])])])])])])).
sent(s_075_2_q, eng, 'are at least a few female committee members from Scandinavia').
sent(s_075_2_q, original, 'are at least a few female committee members from Scandinavia').
sent(s_075_2_q, swe, 'är minst ett fåtal kvinnliga kommittémedlemmar från Skandinavien').

tree(s_075_3_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('PredetNP', [t(at_least_Predet, []), t('DetCN', [t(a_few_Det, []), t('AdjCN', [t('PositA', [t(female_A, [])]), t('UseN', [t(committee_member_N, [])])])])]), t('UseComp', [t('CompAdv', [t('PrepNP', [t(from_Prep, []), t('UsePN', [t(scandinavia_PN, [])])])])])])])])).
sent(s_075_3_h, eng, 'at least a few female committee members are from Scandinavia').
sent(s_075_3_h, original, 'at least a few female committee members are from Scandinavia').
sent(s_075_3_h, swe, 'minst ett fåtal kvinnliga kommittémedlemmar är från Skandinavien').

tree(s_076_1_p, s_044_1_p).
sent(s_076_1_p, eng, 'few committee members are from southern Europe').
sent(s_076_1_p, original, 'few committee members are from southern Europe').
sent(s_076_1_p, swe, 'få kommittémedlemmar är från södra Europa').

tree(s_076_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t(few_Det, []), t('AdjCN', [t('PositA', [t(female_A, [])]), t('UseN', [t(committee_member_N, [])])])]), t('UseComp', [t('CompAdv', [t('PrepNP', [t(from_Prep, []), t('UsePN', [t(southern_europe_PN, [])])])])])])])])])).
sent(s_076_2_q, eng, 'are few female committee members from southern Europe').
sent(s_076_2_q, original, 'are few female committee members from southern Europe').
sent(s_076_2_q, swe, 'är få kvinnliga kommittémedlemmar från södra Europa').

tree(s_076_3_h, s_060_1_p).
sent(s_076_3_h, eng, 'few female committee members are from southern Europe').
sent(s_076_3_h, original, 'few female committee members are from southern Europe').
sent(s_076_3_h, swe, 'få kvinnliga kommittémedlemmar är från södra Europa').

tree(s_077_1_p, s_061_3_h).
sent(s_077_1_p, eng, 'both commissioners used to be in business').
sent(s_077_1_p, original, 'both commissioners used to be in business').
sent(s_077_1_p, swe, 'båda ombuden brukade vara i affärsverksamhet').

tree(s_077_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t(both_Det, []), t('AdjCN', [t('PositA', [t(female_A, [])]), t('UseN', [t(commissioner_N, [])])])]), t('ComplVV', [t(use_VV, []), t('UseComp', [t('CompAdv', [t('PrepNP', [t(in_Prep, []), t('MassNP', [t('UseN', [t(business_N, [])])])])])])])])])])])).
sent(s_077_2_q, eng, 'did both female commissioners used to be in business').
sent(s_077_2_q, original, 'did both female commissioners used to be in business').
sent(s_077_2_q, swe, 'brukade båda de kvinnliga ombuden vara i affärsverksamhet').

tree(s_077_3_h, s_061_1_p).
sent(s_077_3_h, eng, 'both female commissioners used to be in business').
sent(s_077_3_h, original, 'both female commissioners used to be in business').
sent(s_077_3_h, swe, 'båda de kvinnliga ombuden brukade vara i affärsverksamhet').

tree(s_078_1_p, s_030_1_p).
sent(s_078_1_p, eng, 'neither commissioner spends a lot of time at home').
sent(s_078_1_p, original, 'neither commissioner spends a lot of time at home').
sent(s_078_1_p, swe, 'inget av ombuden tillbringar mycket tid hemma').

tree(s_078_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t(either_Det, []), t('AdjCN', [t('PositA', [t(female_A, [])]), t('UseN', [t(commissioner_N, [])])])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(spend_V2, [])]), t('DetCN', [t(a_lot_of_Det, []), t('UseN', [t(time_N, [])])])]), t(at_home_Adv, [])])])])])])).
sent(s_078_2_q, eng, 'does either female commissioner spend a lot of time at home').
sent(s_078_2_q, original, 'does either female commissioner spend a lot of time at home').
sent(s_078_2_q, swe, 'tillbringar något av de kvinnliga ombuden mycket tid hemma').

tree(s_078_3_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('AdvNP', [t('DetNP', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])])]), t('PrepNP', [t(part_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumPl', [])]), t('AdjCN', [t('PositA', [t(female_A, [])]), t('UseN', [t(commissioner_N, [])])])])])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(spend_V2, [])]), t('DetCN', [t(a_lot_of_Det, []), t('UseN', [t(time_N, [])])])]), t(at_home_Adv, [])])])])])).
sent(s_078_3_h, eng, 'one of the female commissioners spends a lot of time at home').
sent(s_078_3_h, original, 'one of the female commissioners spends a lot of time at home').
sent(s_078_3_h, swe, 'ett av de kvinnliga ombuden tillbringar mycket tid hemma').

tree(s_079_1_p, s_031_3_h).
sent(s_079_1_p, eng, 'at least three commissioners spend time at home').
sent(s_079_1_p, original, 'at least three commissioners spend time at home').
sent(s_079_1_p, swe, 'minst tre ombud tillbringar tid hemma').

tree(s_079_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('PredetNP', [t(at_least_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_three', [])])])]), t('AdjCN', [t('PositA', [t(male_A, [])]), t('UseN', [t(commissioner_N, [])])])])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(spend_V2, [])]), t('MassNP', [t('UseN', [t(time_N, [])])])]), t(at_home_Adv, [])])])])])])).
sent(s_079_2_q, eng, 'do at least three male commissioners spend time at home').
sent(s_079_2_q, original, 'do at least three male commissioners spend time at home').
sent(s_079_2_q, swe, 'tillbringar minst tre manliga ombud tid hemma').

tree(s_079_3_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('PredetNP', [t(at_least_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_three', [])])])]), t('AdjCN', [t('PositA', [t(male_A, [])]), t('UseN', [t(commissioner_N, [])])])])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(spend_V2, [])]), t('MassNP', [t('UseN', [t(time_N, [])])])]), t(at_home_Adv, [])])])])])).
sent(s_079_3_h, eng, 'at least three male commissioners spend time at home').
sent(s_079_3_h, original, 'at least three male commissioners spend time at home').
sent(s_079_3_h, swe, 'minst tre manliga ombud tillbringar tid hemma').

tree(s_080_1_p, s_032_3_h).
sent(s_080_1_p, eng, 'at most ten commissioners spend time at home').
sent(s_080_1_p, original, 'at most ten commissioners spend time at home').
sent(s_080_1_p, swe, 'högst tio ombud tillbringar tid hemma').

tree(s_080_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('PredetNP', [t(at_most_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_ten', [])])])]), t('AdjCN', [t('PositA', [t(female_A, [])]), t('UseN', [t(commissioner_N, [])])])])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(spend_V2, [])]), t('MassNP', [t('UseN', [t(time_N, [])])])]), t(at_home_Adv, [])])])])])])).
sent(s_080_2_q, eng, 'do at most ten female commissioners spend time at home').
sent(s_080_2_q, original, 'do at most ten female commissioners spend time at home').
sent(s_080_2_q, swe, 'tillbringar högst tio kvinnliga ombud tid hemma').

tree(s_080_3_h, s_064_1_p).
sent(s_080_3_h, eng, 'at most ten female commissioners spend time at home').
sent(s_080_3_h, original, 'at most ten female commissioners spend time at home').
sent(s_080_3_h, swe, 'högst tio kvinnliga ombud tillbringar tid hemma').

tree(s_081_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('ConjNP3', [t(and_Conj, []), t('UsePN', [t(smith_PN, [])]), t('UsePN', [t(jones_PN, [])]), t('UsePN', [t(anderson_PN, [])])]), t('ComplSlash', [t('SlashV2a', [t(sign_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])])])])])).
sent(s_081_1_p, eng, 'Smith , Jones and Anderson signed the contract').
sent(s_081_1_p, original, 'Smith , Jones and Anderson signed the contract').
sent(s_081_1_p, swe, 'Smith , Jones och Anderson undertecknade kontraktet').

tree(s_081_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(sign_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])])])])])])).
sent(s_081_2_q, eng, 'did Jones sign the contract').
sent(s_081_2_q, original, 'did Jones sign the contract').
sent(s_081_2_q, swe, 'undertecknade Jones kontraktet').

tree(s_081_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(sign_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])])])])])).
sent(s_081_3_h, eng, 'Jones signed the contract').
sent(s_081_3_h, original, 'Jones signed the contract').
sent(s_081_3_h, swe, 'Jones undertecknade kontraktet').

tree(s_082_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('ConjNP3', [t(and_Conj, []), t('UsePN', [t(smith_PN, [])]), t('UsePN', [t(jones_PN, [])]), t('DetCN', [t(several_Det, []), t('UseN', [t(lawyer_N, [])])])]), t('ComplSlash', [t('SlashV2a', [t(sign_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])])])])])).
sent(s_082_1_p, eng, 'Smith , Jones and several lawyers signed the contract').
sent(s_082_1_p, original, 'Smith , Jones and several lawyers signed the contract').
sent(s_082_1_p, swe, 'Smith , Jones och flera jurister undertecknade kontraktet').

tree(s_082_2_q, s_081_2_q).
sent(s_082_2_q, eng, 'did Jones sign the contract').
sent(s_082_2_q, original, 'did Jones sign the contract').
sent(s_082_2_q, swe, 'undertecknade Jones kontraktet').

tree(s_082_3_h, s_081_3_h).
sent(s_082_3_h, eng, 'Jones signed the contract').
sent(s_082_3_h, original, 'Jones signed the contract').
sent(s_082_3_h, swe, 'Jones undertecknade kontraktet').

tree(s_083_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('ConjNP3', [t(either7or_DConj, []), t('UsePN', [t(smith_PN, [])]), t('UsePN', [t(jones_PN, [])]), t('UsePN', [t(anderson_PN, [])])]), t('ComplSlash', [t('SlashV2a', [t(sign_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])])])])])).
sent(s_083_1_p, eng, 'either Smith , Jones or Anderson signed the contract').
sent(s_083_1_p, original, 'either Smith , Jones or Anderson signed the contract').
sent(s_083_1_p, swe, 'antingen Smith , Jones eller Anderson undertecknade kontraktet').

tree(s_083_2_q, s_081_2_q).
sent(s_083_2_q, eng, 'did Jones sign the contract').
sent(s_083_2_q, original, 'did Jones sign the contract').
sent(s_083_2_q, swe, 'undertecknade Jones kontraktet').

tree(s_083_3_h, s_081_3_h).
sent(s_083_3_h, eng, 'Jones signed the contract').
sent(s_083_3_h, original, 'Jones signed the contract').
sent(s_083_3_h, swe, 'Jones undertecknade kontraktet').

tree(s_084_1_p, s_083_1_p).
sent(s_084_1_p, eng, 'either Smith , Jones or Anderson signed the contract').
sent(s_084_1_p, original, 'either Smith , Jones or Anderson signed the contract').
sent(s_084_1_p, swe, 'antingen Smith , Jones eller Anderson undertecknade kontraktet').

tree(s_084_2_q, t('Question', [t('ExtAdvQS', [t('SubjS', [t(if_Subj, []), t('UseCl', [t('Past', []), t('UncNeg', []), t('PredVP', [t('ConjNP2', [t(and_Conj, []), t('UsePN', [t(smith_PN, [])]), t('UsePN', [t(anderson_PN, [])])]), t('ComplSlash', [t('SlashV2a', [t(sign_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])])])])]), t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(sign_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])])])])])])])).
sent(s_084_2_q, eng, 'if Smith and Anderson did not sign the contract , did Jones sign the contract').
sent(s_084_2_q, original, 'if Smith and Anderson did not sign the contract , did Jones sign the contract').
sent(s_084_2_q, swe, 'om Smith och Anderson inte undertecknade kontraktet , undertecknade Jones kontraktet').

tree(s_084_3_h, t('Sentence', [t('ExtAdvS', [t('SubjS', [t(if_Subj, []), t('UseCl', [t('Past', []), t('UncNeg', []), t('PredVP', [t('ConjNP2', [t(and_Conj, []), t('UsePN', [t(smith_PN, [])]), t('UsePN', [t(anderson_PN, [])])]), t('ComplSlash', [t('SlashV2a', [t(sign_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])])])])]), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(sign_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])])])])])])).
sent(s_084_3_h, eng, 'if Smith and Anderson did not sign the contract , Jones signed the contract').
sent(s_084_3_h, original, 'if Smith and Anderson did not sign the contract , Jones signed the contract').
sent(s_084_3_h, swe, 'om Smith och Anderson inte undertecknade kontraktet , undertecknade Jones kontraktet').

tree(s_085_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('ConjNP2', [t(and_Conj, []), t('PredetNP', [t(exactly_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_two', [])])])]), t('UseN', [t(lawyer_N, [])])])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_three', [])])])]), t('UseN', [t(accountant_N, [])])])]), t('ComplSlash', [t('SlashV2a', [t(sign_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])])])])])).
sent(s_085_1_p, eng, 'exactly two lawyers and three accountants signed the contract').
sent(s_085_1_p, original, 'exactly two lawyers and three accountants signed the contract').
sent(s_085_1_p, swe, 'exakt två jurister och tre bokförare undertecknade kontraktet').

tree(s_085_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_six', [])])])]), t('UseN', [t(lawyer_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(sign_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])])])])])])).
sent(s_085_2_q, eng, 'did six lawyers sign the contract').
sent(s_085_2_q, original, 'did six lawyers sign the contract').
sent(s_085_2_q, swe, 'undertecknade sex jurister kontraktet').

tree(s_085_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_six', [])])])]), t('UseN', [t(lawyer_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(sign_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])])])])])).
sent(s_085_3_h, eng, 'six lawyers signed the contract').
sent(s_085_3_h, original, 'six lawyers signed the contract').
sent(s_085_3_h, swe, 'sex jurister undertecknade kontraktet').

tree(s_086_1_p, s_085_1_p).
sent(s_086_1_p, eng, 'exactly two lawyers and three accountants signed the contract').
sent(s_086_1_p, original, 'exactly two lawyers and three accountants signed the contract').
sent(s_086_1_p, swe, 'exakt två jurister och tre bokförare undertecknade kontraktet').

tree(s_086_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_six', [])])])]), t('UseN', [t(accountant_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(sign_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])])])])])])).
sent(s_086_2_q, eng, 'did six accountants sign the contract').
sent(s_086_2_q, original, 'did six accountants sign the contract').
sent(s_086_2_q, swe, 'undertecknade sex bokförare kontraktet').

tree(s_086_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_six', [])])])]), t('UseN', [t(accountant_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(sign_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])])])])])).
sent(s_086_3_h, eng, 'six accountants signed the contract').
sent(s_086_3_h, original, 'six accountants signed the contract').
sent(s_086_3_h, swe, 'sex bokförare undertecknade kontraktet').

tree(s_087_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t(every_Det, []), t('ConjCN2', [t(and_Conj, []), t('UseN', [t(representative_N, [])]), t('UseN', [t(client_N, [])])])]), t('UseComp', [t('CompAdv', [t('PrepNP', [t(at_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(meeting_N, [])])])])])])])])])).
sent(s_087_1_p, eng, 'every representative and client was at the meeting').
sent(s_087_1_p, original, 'every representative and client was at the meeting').
sent(s_087_1_p, swe, 'varje representant och klient var på mötet').

tree(s_087_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t(every_Det, []), t('UseN', [t(representative_N, [])])]), t('UseComp', [t('CompAdv', [t('PrepNP', [t(at_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(meeting_N, [])])])])])])])])])])).
sent(s_087_2_q, eng, 'was every representative at the meeting').
sent(s_087_2_q, original, 'was every representative at the meeting').
sent(s_087_2_q, swe, 'var varje representant på mötet').

tree(s_087_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t(every_Det, []), t('UseN', [t(representative_N, [])])]), t('UseComp', [t('CompAdv', [t('PrepNP', [t(at_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(meeting_N, [])])])])])])])])])).
sent(s_087_3_h, eng, 'every representative was at the meeting').
sent(s_087_3_h, original, 'every representative was at the meeting').
sent(s_087_3_h, swe, 'varje representant var på mötet').

tree(s_088_1_p, s_087_1_p).
sent(s_088_1_p, eng, 'every representative and client was at the meeting').
sent(s_088_1_p, original, 'every representative and client was at the meeting').
sent(s_088_1_p, swe, 'varje representant och klient var på mötet').

tree(s_088_2_q, s_087_2_q).
sent(s_088_2_q, eng, 'was every representative at the meeting').
sent(s_088_2_q, original, 'was every representative at the meeting').
sent(s_088_2_q, swe, 'var varje representant på mötet').

tree(s_088_3_h, s_087_3_h).
sent(s_088_3_h, eng, 'every representative was at the meeting').
sent(s_088_3_h, original, 'every representative was at the meeting').
sent(s_088_3_h, swe, 'varje representant var på mötet').

tree(s_089_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t(every_Det, []), t('ConjCN2', [t(or_Conj, []), t('UseN', [t(representative_N, [])]), t('UseN', [t(client_N, [])])])]), t('UseComp', [t('CompAdv', [t('PrepNP', [t(at_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(meeting_N, [])])])])])])])])])).
sent(s_089_1_p, eng, 'every representative or client was at the meeting').
sent(s_089_1_p, original, 'every representative or client was at the meeting').
sent(s_089_1_p, swe, 'varje representant eller klient var på mötet').

tree(s_089_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('ConjNP2', [t(andSg_Conj, []), t('DetCN', [t(every_Det, []), t('UseN', [t(representative_N, [])])]), t('DetCN', [t(every_Det, []), t('UseN', [t(client_N, [])])])]), t('UseComp', [t('CompAdv', [t('PrepNP', [t(at_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(meeting_N, [])])])])])])])])])])).
sent(s_089_2_q, eng, 'was every representative and every client at the meeting').
sent(s_089_2_q, original, 'was every representative and every client at the meeting').
sent(s_089_2_q, swe, 'var varje representant och varje klient på mötet').

tree(s_089_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('ConjNP2', [t(andSg_Conj, []), t('DetCN', [t(every_Det, []), t('UseN', [t(representative_N, [])])]), t('DetCN', [t(every_Det, []), t('UseN', [t(client_N, [])])])]), t('UseComp', [t('CompAdv', [t('PrepNP', [t(at_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(meeting_N, [])])])])])])])])])).
sent(s_089_3_h, eng, 'every representative and every client was at the meeting').
sent(s_089_3_h, original, 'every representative and every client was at the meeting').
sent(s_089_3_h, swe, 'varje representant och varje klient var på mötet').

tree(s_090_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(chairman_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(read_out_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumPl', [])]), t('AdvCN', [t('UseN', [t(item_N, [])]), t('PrepNP', [t(on_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(agenda_N, [])])])])])])])])])])).
sent(s_090_1_p, eng, 'the chairman read out the items on the agenda').
sent(s_090_1_p, original, 'the chairman read out the items on the agenda').
sent(s_090_1_p, swe, 'ordföranden läste upp punkterna på dagordningen').

tree(s_090_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(chairman_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(read_out_V2, [])]), t('DetCN', [t(every_Det, []), t('AdvCN', [t('UseN', [t(item_N, [])]), t('PrepNP', [t(on_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(agenda_N, [])])])])])])])])])])])).
sent(s_090_2_q, eng, 'did the chairman read out every item on the agenda').
sent(s_090_2_q, original, 'did the chairman read out every item on the agenda').
sent(s_090_2_q, swe, 'läste ordföranden upp varje punkt på dagordningen').

tree(s_090_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(chairman_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(read_out_V2, [])]), t('DetCN', [t(every_Det, []), t('AdvCN', [t('UseN', [t(item_N, [])]), t('PrepNP', [t(on_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(agenda_N, [])])])])])])])])])])).
sent(s_090_3_h, eng, 'the chairman read out every item on the agenda').
sent(s_090_3_h, original, 'the chairman read out every item on the agenda').
sent(s_090_3_h, swe, 'ordföranden läste upp varje punkt på dagordningen').

tree(s_091_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumPl', [])]), t('RelCN', [t('UseN', [t(person_N, [])]), t('UseRCl', [t('Past', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('UseComp', [t('CompAdv', [t('PrepNP', [t(at_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(meeting_N, [])])])])])])])])])]), t('ComplSlash', [t('SlashV2a', [t(vote_for_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(new_A, [])]), t('UseN', [t(chairman_N, [])])])])])])])])).
sent(s_091_1_p, eng, 'the people who were at the meeting voted for a new chairman').
sent(s_091_1_p, original, 'the people who were at the meeting voted for a new chairman').
sent(s_091_1_p, swe, 'människorna som var på mötet röstade för en ny ordförande').

tree(s_091_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('AdvNP', [t('UsePron', [t(everyone_Pron, [])]), t('PrepNP', [t(at_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(meeting_N, [])])])])]), t('ComplSlash', [t('SlashV2a', [t(vote_for_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(new_A, [])]), t('UseN', [t(chairman_N, [])])])])])])])])])).
sent(s_091_2_q, eng, 'did everyone at the meeting vote for a new chairman').
sent(s_091_2_q, original, 'did everyone at the meeting vote for a new chairman').
sent(s_091_2_q, swe, 'röstade alla på mötet för en ny ordförande').

tree(s_091_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('AdvNP', [t('UsePron', [t(everyone_Pron, [])]), t('PrepNP', [t(at_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(meeting_N, [])])])])]), t('ComplSlash', [t('SlashV2a', [t(vote_for_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(new_A, [])]), t('UseN', [t(chairman_N, [])])])])])])])])).
sent(s_091_3_h, eng, 'everyone at the meeting voted for a new chairman').
sent(s_091_3_h, original, 'everyone at the meeting voted for a new chairman').
sent(s_091_3_h, swe, 'alla på mötet röstade för en ny ordförande').

tree(s_092_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('PredetNP', [t(all_Predet, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumPl', [])]), t('RelCN', [t('UseN', [t(person_N, [])]), t('UseRCl', [t('Past', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('UseComp', [t('CompAdv', [t('PrepNP', [t(at_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(meeting_N, [])])])])])])])])])])]), t('ComplSlash', [t('SlashV2a', [t(vote_for_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(new_A, [])]), t('UseN', [t(chairman_N, [])])])])])])])])).
sent(s_092_1_p, eng, 'all the people who were at the meeting voted for a new chairman').
sent(s_092_1_p, original, 'all the people who were at the meeting voted for a new chairman').
sent(s_092_1_p, swe, 'alla människorna som var på mötet röstade för en ny ordförande').

tree(s_092_2_q, s_091_2_q).
sent(s_092_2_q, eng, 'did everyone at the meeting vote for a new chairman').
sent(s_092_2_q, original, 'did everyone at the meeting vote for a new chairman').
sent(s_092_2_q, swe, 'röstade alla på mötet för en ny ordförande').

tree(s_092_3_h, s_091_3_h).
sent(s_092_3_h, eng, 'everyone at the meeting voted for a new chairman').
sent(s_092_3_h, original, 'everyone at the meeting voted for a new chairman').
sent(s_092_3_h, swe, 'alla på mötet röstade för en ny ordförande').

tree(s_093_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumPl', [])]), t('RelCN', [t('UseN', [t(person_N, [])]), t('UseRCl', [t('Past', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('UseComp', [t('CompAdv', [t('PrepNP', [t(at_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(meeting_N, [])])])])])])])])])]), t('AdVVP', [t(all_AdV, []), t('ComplSlash', [t('SlashV2a', [t(vote_for_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(new_A, [])]), t('UseN', [t(chairman_N, [])])])])])])])])])).
sent(s_093_1_p, eng, 'the people who were at the meeting all voted for a new chairman').
sent(s_093_1_p, original, 'the people who were at the meeting all voted for a new chairman').
sent(s_093_1_p, swe, 'människorna som var på mötet röstade alla för en ny ordförande').

tree(s_093_2_q, s_091_2_q).
sent(s_093_2_q, eng, 'did everyone at the meeting vote for a new chairman').
sent(s_093_2_q, original, 'did everyone at the meeting vote for a new chairman').
sent(s_093_2_q, swe, 'röstade alla på mötet för en ny ordförande').

tree(s_093_3_h, s_091_3_h).
sent(s_093_3_h, eng, 'everyone at the meeting voted for a new chairman').
sent(s_093_3_h, original, 'everyone at the meeting voted for a new chairman').
sent(s_093_3_h, swe, 'alla på mötet röstade för en ny ordförande').

tree(s_094_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumPl', [])]), t('ComplN2', [t(inhabitant_N2, []), t('UsePN', [t(cambridge_PN, [])])])]), t('ComplSlash', [t('SlashV2a', [t(vote_for_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(labour_mp_N, [])])])])])])])).
sent(s_094_1_p, eng, 'the inhabitants of Cambridge voted for a Labour MP').
sent(s_094_1_p, original, 'the inhabitants of Cambridge voted for a Labour MP').
sent(s_094_1_p, swe, 'invånarna i Cambridge röstade för en Labour-ledamot').

tree(s_094_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t(every_Det, []), t('ComplN2', [t(inhabitant_N2, []), t('UsePN', [t(cambridge_PN, [])])])]), t('ComplSlash', [t('SlashV2a', [t(vote_for_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(labour_mp_N, [])])])])])])])])).
sent(s_094_2_q, eng, 'did every inhabitant of Cambridge vote for a Labour MP').
sent(s_094_2_q, original, 'did every inhabitant of Cambridge vote for a Labour MP').
sent(s_094_2_q, swe, 'röstade varje invånare i Cambridge för en Labour-ledamot').

tree(s_094_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t(every_Det, []), t('ComplN2', [t(inhabitant_N2, []), t('UsePN', [t(cambridge_PN, [])])])]), t('ComplSlash', [t('SlashV2a', [t(vote_for_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(labour_mp_N, [])])])])])])])).
sent(s_094_3_h, eng, 'every inhabitant of Cambridge voted for a Labour MP').
sent(s_094_3_h, original, 'every inhabitant of Cambridge voted for a Labour MP').
sent(s_094_3_h, swe, 'varje invånare i Cambridge röstade för en Labour-ledamot').

tree(s_095_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumPl', [])]), t('AdjCN', [t('PositA', [t(ancient_A, [])]), t('UseN', [t(greek_N, [])])])]), t('UseComp', [t('CompCN', [t('AdjCN', [t('PositA', [t(noted_A, [])]), t('UseN', [t(philosopher_N, [])])])])])])])])).
sent(s_095_1_p, eng, 'the Ancient Greeks were noted philosophers').
sent(s_095_1_p, original, 'the Ancient Greeks were noted philosophers').
sent(s_095_1_p, swe, 'de antika grekerna var välkända filosofer').

tree(s_095_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t(every_Det, []), t('AdjCN', [t('PositA', [t(ancient_A, [])]), t('UseN', [t(greek_N, [])])])]), t('UseComp', [t('CompCN', [t('AdjCN', [t('PositA', [t(noted_A, [])]), t('UseN', [t(philosopher_N, [])])])])])])])])])).
sent(s_095_2_q, eng, 'was every Ancient Greek a noted philosopher').
sent(s_095_2_q, original, 'was every Ancient Greek a noted philosopher').
sent(s_095_2_q, swe, 'var varje antik grek en välkänd filosof').

tree(s_095_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t(every_Det, []), t('AdjCN', [t('PositA', [t(ancient_A, [])]), t('UseN', [t(greek_N, [])])])]), t('UseComp', [t('CompCN', [t('AdjCN', [t('PositA', [t(noted_A, [])]), t('UseN', [t(philosopher_N, [])])])])])])])])).
sent(s_095_3_h, eng, 'every Ancient Greek was a noted philosopher').
sent(s_095_3_h, original, 'every Ancient Greek was a noted philosopher').
sent(s_095_3_h, swe, 'varje antik grek var en välkänd filosof').

tree(s_096_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumPl', [])]), t('AdjCN', [t('PositA', [t(ancient_A, [])]), t('UseN', [t(greek_N, [])])])]), t('AdVVP', [t(all_AdV, []), t('UseComp', [t('CompCN', [t('AdjCN', [t('PositA', [t(noted_A, [])]), t('UseN', [t(philosopher_N, [])])])])])])])])])).
sent(s_096_1_p, eng, 'the Ancient Greeks were all noted philosophers').
sent(s_096_1_p, original, 'the Ancient Greeks were all noted philosophers').
sent(s_096_1_p, swe, 'de antika grekerna var alla välkända filosofer').

tree(s_096_2_q, s_095_2_q).
sent(s_096_2_q, eng, 'was every Ancient Greek a noted philosopher').
sent(s_096_2_q, original, 'was every Ancient Greek a noted philosopher').
sent(s_096_2_q, swe, 'var varje antik grek en välkänd filosof').

tree(s_096_3_h, s_095_3_h).
sent(s_096_3_h, eng, 'every Ancient Greek was a noted philosopher').
sent(s_096_3_h, original, 'every Ancient Greek was a noted philosopher').
sent(s_096_3_h, swe, 'varje antik grek var en välkänd filosof').

tree(s_097_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('UseN', [t(software_fault_N, [])])]), t('AdvVP', [t('PassV2s', [t(blame1_V2, [])]), t('PrepNP', [t(for_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(system_failure_N, [])])])])])])])])).
sent(s_097_1_p, eng, 'software faults were blamed for the system failure').
sent(s_097_1_p, original, 'software faults were blamed for the system failure').
sent(s_097_1_p, swe, 'programvarufel beskylldes för systemkraschen').

tree(s_097_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(system_failure_N, [])])]), t('AdvVP', [t('PassV2s', [t(blame2_V2, [])]), t('PrepNP', [t(on_Prep, []), t('DetCN', [t(one_or_more_Det, []), t('UseN', [t(software_fault_N, [])])])])])])])])])).
sent(s_097_2_q, eng, 'was the system failure blamed on one or more software faults').
sent(s_097_2_q, original, 'was the system failure blamed on one or more software faults').
sent(s_097_2_q, swe, 'skylldes systemkraschen på ett eller flera programvarufel').

tree(s_097_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(system_failure_N, [])])]), t('AdvVP', [t('PassV2s', [t(blame2_V2, [])]), t('PrepNP', [t(on_Prep, []), t('DetCN', [t(one_or_more_Det, []), t('UseN', [t(software_fault_N, [])])])])])])])])).
sent(s_097_3_h, eng, 'the system failure was blamed on one or more software faults').
sent(s_097_3_h, original, 'the system failure was blamed on one or more software faults').
sent(s_097_3_h, swe, 'systemkraschen skylldes på ett eller flera programvarufel').

tree(s_098_1_p, s_097_1_p).
sent(s_098_1_p, eng, 'software faults were blamed for the system failure').
sent(s_098_1_p, original, 'software faults were blamed for the system failure').
sent(s_098_1_p, swe, 'programvarufel beskylldes för systemkraschen').

tree(s_098_2_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bug_32985_PN, [])]), t('UseComp', [t('CompCN', [t('AdjCN', [t('PositA', [t(known_A, [])]), t('UseN', [t(software_fault_N, [])])])])])])])])).
sent(s_098_2_p, eng, 'Bug # 32-985 is a known software fault').
sent(s_098_2_p, original, 'Bug # 32-985 is a known software fault').
sent(s_098_2_p, swe, 'Bug # 32-985 är ett känt programvarufel').

tree(s_098_3_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(bug_32985_PN, [])]), t('AdvVP', [t('PassV2s', [t(blame1_V2, [])]), t('PrepNP', [t(for_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(system_failure_N, [])])])])])])])])])).
sent(s_098_3_q, eng, 'was Bug # 32-985 blamed for the system failure').
sent(s_098_3_q, original, 'was Bug # 32-985 blamed for the system failure').
sent(s_098_3_q, swe, 'beskylldes Bug # 32-985 för systemkraschen').

tree(s_098_4_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bug_32985_PN, [])]), t('AdvVP', [t('PassV2s', [t(blame1_V2, [])]), t('PrepNP', [t(for_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(system_failure_N, [])])])])])])])])).
sent(s_098_4_h, eng, 'Bug # 32-985 was blamed for the system failure').
sent(s_098_4_h, original, 'Bug # 32-985 was blamed for the system failure').
sent(s_098_4_h, swe, 'Bug # 32-985 beskylldes för systemkraschen').

tree(s_099_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('AdvCN', [t('UseN', [t(client_N, [])]), t('PrepNP', [t(at_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(demonstration_N, [])])])])])]), t('AdVVP', [t(all_AdV, []), t('UseComp', [t('CompAP', [t('ComplA2', [t(impressed_by_A2, []), t('DetCN', [t('DetQuant', [t('GenNP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(system_N, [])])])]), t('NumSg', [])]), t('UseN', [t(performance_N, [])])])])])])])])])])).
sent(s_099_1_p, eng, 'clients at the demonstration were all impressed by the system\'s performance').
sent(s_099_1_p, original, 'clients at the demonstration were all impressed by the system\'s performance').
sent(s_099_1_p, swe, 'klienter på presentationen var alla imponerade av systemets utförande').

tree(s_099_2_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('UseComp', [t('CompCN', [t('AdvCN', [t('UseN', [t(client_N, [])]), t('PrepNP', [t(at_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(demonstration_N, [])])])])])])])])])])).
sent(s_099_2_p, eng, 'Smith was a client at the demonstration').
sent(s_099_2_p, original, 'Smith was a client at the demonstration').
sent(s_099_2_p, swe, 'Smith var en klient på presentationen').

tree(s_099_3_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('UseComp', [t('CompAP', [t('ComplA2', [t(impressed_by_A2, []), t('DetCN', [t('DetQuant', [t('GenNP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(system_N, [])])])]), t('NumSg', [])]), t('UseN', [t(performance_N, [])])])])])])])])])])).
sent(s_099_3_q, eng, 'was Smith impressed by the system\'s performance').
sent(s_099_3_q, original, 'was Smith impressed by the system\'s performance').
sent(s_099_3_q, swe, 'var Smith imponerad av systemets utförande').

tree(s_099_4_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('UseComp', [t('CompAP', [t('ComplA2', [t(impressed_by_A2, []), t('DetCN', [t('DetQuant', [t('GenNP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(system_N, [])])])]), t('NumSg', [])]), t('UseN', [t(performance_N, [])])])])])])])])])).
sent(s_099_4_h, eng, 'Smith was impressed by the system\'s performance').
sent(s_099_4_h, original, 'Smith was impressed by the system\'s performance').
sent(s_099_4_h, swe, 'Smith var imponerad av systemets utförande').

tree(s_100_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('AdvCN', [t('UseN', [t(client_N, [])]), t('PrepNP', [t(at_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(demonstration_N, [])])])])])]), t('UseComp', [t('CompAP', [t('ComplA2', [t(impressed_by_A2, []), t('DetCN', [t('DetQuant', [t('GenNP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(system_N, [])])])]), t('NumSg', [])]), t('UseN', [t(performance_N, [])])])])])])])])])).
sent(s_100_1_p, eng, 'clients at the demonstration were impressed by the system\'s performance').
sent(s_100_1_p, original, 'clients at the demonstration were impressed by the system\'s performance').
sent(s_100_1_p, swe, 'klienter på presentationen var imponerade av systemets utförande').

tree(s_100_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('PredetNP', [t(most_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('AdvCN', [t('UseN', [t(client_N, [])]), t('PrepNP', [t(at_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(demonstration_N, [])])])])])])]), t('UseComp', [t('CompAP', [t('ComplA2', [t(impressed_by_A2, []), t('DetCN', [t('DetQuant', [t('GenNP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(system_N, [])])])]), t('NumSg', [])]), t('UseN', [t(performance_N, [])])])])])])])])])])).
sent(s_100_2_q, eng, 'were most clients at the demonstration impressed by the system\'s performance').
sent(s_100_2_q, original, 'were most clients at the demonstration impressed by the system\'s performance').
sent(s_100_2_q, swe, 'var de flesta klienter på presentationen imponerade av systemets utförande').

tree(s_100_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('PredetNP', [t(most_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('AdvCN', [t('UseN', [t(client_N, [])]), t('PrepNP', [t(at_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(demonstration_N, [])])])])])])]), t('UseComp', [t('CompAP', [t('ComplA2', [t(impressed_by_A2, []), t('DetCN', [t('DetQuant', [t('GenNP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(system_N, [])])])]), t('NumSg', [])]), t('UseN', [t(performance_N, [])])])])])])])])])).
sent(s_100_3_h, eng, 'most clients at the demonstration were impressed by the system\'s performance').
sent(s_100_3_h, original, 'most clients at the demonstration were impressed by the system\'s performance').
sent(s_100_3_h, swe, 'de flesta klienter på presentationen var imponerade av systemets utförande').

tree(s_101_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('UseN', [t(university_graduate_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(make8become_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('AdjCN', [t('PositA', [t(poor8bad_A, [])]), t('UseN', [t(stockmarket_trader_N, [])])])])])])])])).
sent(s_101_1_p, eng, 'university graduates make poor stock-market traders').
sent(s_101_1_p, original, 'university graduates make poor stock-market traders').
sent(s_101_1_p, swe, 'universitetsakademiker blir dåliga aktiehandlare').

tree(s_101_2_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('UseComp', [t('CompCN', [t('UseN', [t(university_graduate_N, [])])])])])])])).
sent(s_101_2_p, eng, 'Smith is a university graduate').
sent(s_101_2_p, original, 'Smith is a university graduate').
sent(s_101_2_p, swe, 'Smith är en universitetsakademiker').

tree(s_101_3_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('UseComp', [t('CompAP', [t('SentAP', [t('PositA', [t(likely_A, [])]), t('EmbedVP', [t('ComplSlash', [t('SlashV2a', [t(make8become_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(poor8bad_A, [])]), t('UseN', [t(stock_market_trader_N, [])])])])])])])])])])])])])).
sent(s_101_3_q, eng, 'is Smith likely to make a poor stock market trader').
sent(s_101_3_q, original, 'is Smith likely to make a poor stock market trader').
sent(s_101_3_q, swe, 'är Smith sannolik att bli en dålig aktiehandlare').

tree(s_101_4_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('UseComp', [t('CompAP', [t('SentAP', [t('PositA', [t(likely_A, [])]), t('EmbedVP', [t('ComplSlash', [t('SlashV2a', [t(make8become_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(poor8bad_A, [])]), t('UseN', [t(stock_market_trader_N, [])])])])])])])])])])])])).
sent(s_101_4_h, eng, 'Smith is likely to make a poor stock market trader').
sent(s_101_4_h, original, 'Smith is likely to make a poor stock market trader').
sent(s_101_4_h, swe, 'Smith är sannolik att bli en dålig aktiehandlare').

tree(s_102_1_p, s_101_1_p).
sent(s_102_1_p, eng, 'university graduates make poor stock-market traders').
sent(s_102_1_p, original, 'university graduates make poor stock-market traders').
sent(s_102_1_p, swe, 'universitetsakademiker blir dåliga aktiehandlare').

tree(s_102_2_p, s_101_2_p).
sent(s_102_2_p, eng, 'Smith is a university graduate').
sent(s_102_2_p, original, 'Smith is a university graduate').
sent(s_102_2_p, swe, 'Smith är en universitetsakademiker').

tree(s_102_3_q, t('Question', [t('UseQCl', [t('Future', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(make8become_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(poor8bad_A, [])]), t('UseN', [t(stock_market_trader_N, [])])])])])])])])])).
sent(s_102_3_q, eng, 'will Smith make a poor stock market trader').
sent(s_102_3_q, original, 'will Smith make a poor stock market trader').
sent(s_102_3_q, swe, 'ska Smith bli en dålig aktiehandlare').

tree(s_102_4_h, t('Sentence', [t('UseCl', [t('Future', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(make8become_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(poor8bad_A, [])]), t('UseN', [t(stock_market_trader_N, [])])])])])])])])).
sent(s_102_4_h, eng, 'Smith will make a poor stock market trader').
sent(s_102_4_h, original, 'Smith will make a poor stock market trader').
sent(s_102_4_h, swe, 'Smith ska bli en dålig aktiehandlare').

tree(s_103_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('PredetNP', [t(all_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('UseN', [t(apcom_manager_N, [])])])]), t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('UseN', [t(company_car_N, [])])])])])])])).
sent(s_103_1_p, eng, 'all APCOM managers have company cars').
sent(s_103_1_p, original, 'all APCOM managers have company cars').
sent(s_103_1_p, swe, 'alla APCOM-direktörer har tjänstebilar').

tree(s_103_2_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('UseComp', [t('CompCN', [t('UseN', [t(apcom_manager_N, [])])])])])])])).
sent(s_103_2_p, eng, 'Jones is an APCOM manager').
sent(s_103_2_p, original, 'Jones is an APCOM manager').
sent(s_103_2_p, swe, 'Jones är en APCOM-direktör').

tree(s_103_3_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(company_car_N, [])])])])])])])])).
sent(s_103_3_q, eng, 'does Jones have a company car').
sent(s_103_3_q, original, 'does Jones have a company car').
sent(s_103_3_q, swe, 'har Jones en tjänstebil').

tree(s_103_4_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(company_car_N, [])])])])])])])).
sent(s_103_4_h, eng, 'Jones has a company car').
sent(s_103_4_h, original, 'Jones has a company car').
sent(s_103_4_h, swe, 'Jones har en tjänstebil').

tree(s_104_1_p, s_103_1_p).
sent(s_104_1_p, eng, 'all APCOM managers have company cars').
sent(s_104_1_p, original, 'all APCOM managers have company cars').
sent(s_104_1_p, swe, 'alla APCOM-direktörer har tjänstebilar').

tree(s_104_2_p, s_103_2_p).
sent(s_104_2_p, eng, 'Jones is an APCOM manager').
sent(s_104_2_p, original, 'Jones is an APCOM manager').
sent(s_104_2_p, swe, 'Jones är en APCOM-direktör').

tree(s_104_3_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('AdNum', [t(more_than_AdN, []), t('NumNumeral', [t('N_one', [])])])])]), t('UseN', [t(company_car_N, [])])])])])])])])).
sent(s_104_3_q, eng, 'does Jones have more than one company car').
sent(s_104_3_q, original, 'does Jones have more than one company car').
sent(s_104_3_q, swe, 'har Jones mer än en tjänstebil').

tree(s_104_4_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('AdNum', [t(more_than_AdN, []), t('NumNumeral', [t('N_one', [])])])])]), t('UseN', [t(company_car_N, [])])])])])])])).
sent(s_104_4_h, eng, 'Jones has more than one company car').
sent(s_104_4_h, original, 'Jones has more than one company car').
sent(s_104_4_h, swe, 'Jones har mer än en tjänstebil').

tree(s_105_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('PredetNP', [t(just_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_one', [])])])]), t('UseN', [t(accountant_N, [])])])]), t('ComplSlash', [t('SlashV2a', [t(attend_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(meeting_N, [])])])])])])])).
sent(s_105_1_p, eng, 'just one accountant attended the meeting').
sent(s_105_1_p, original, 'just one accountant attended the meeting').
sent(s_105_1_p, swe, 'endast en bokförare närvarade vid mötet').

tree(s_105_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t('DetQuant', [t(no_Quant, []), t('NumPl', [])]), t('UseN', [t(accountant_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(attend_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(meeting_N, [])])])])])])])])).
sent(s_105_2_q, eng, 'did no accountants attend the meeting').
sent(s_105_2_q, original, 'did no accountants attend the meeting').
sent(s_105_2_q, swe, 'närvarade inga bokförare vid mötet').

tree(s_105_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t(no_Quant, []), t('NumPl', [])]), t('UseN', [t(accountant_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(attend_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(meeting_N, [])])])])])])])).
sent(s_105_3_h, eng, 'no accountants attended the meeting').
sent(s_105_3_h, original, 'no accountants attended the meeting').
sent(s_105_3_h, swe, 'inga bokförare närvarade vid mötet').

tree(s_106_1_p, s_105_1_p).
sent(s_106_1_p, eng, 'just one accountant attended the meeting').
sent(s_106_1_p, original, 'just one accountant attended the meeting').
sent(s_106_1_p, swe, 'endast en bokförare närvarade vid mötet').

tree(s_106_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t('DetQuant', [t(no_Quant, []), t('NumSg', [])]), t('UseN', [t(accountant_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(attend_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(meeting_N, [])])])])])])])])).
sent(s_106_2_q, eng, 'did no accountant attend the meeting').
sent(s_106_2_q, original, 'did no accountant attend the meeting').
sent(s_106_2_q, swe, 'närvarade ingen bokförare vid mötet').

tree(s_106_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t(no_Quant, []), t('NumSg', [])]), t('UseN', [t(accountant_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(attend_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(meeting_N, [])])])])])])])).
sent(s_106_3_h, eng, 'no accountant attended the meeting').
sent(s_106_3_h, original, 'no accountant attended the meeting').
sent(s_106_3_h, swe, 'ingen bokförare närvarade vid mötet').

tree(s_107_1_p, s_105_1_p).
sent(s_107_1_p, eng, 'just one accountant attended the meeting').
sent(s_107_1_p, original, 'just one accountant attended the meeting').
sent(s_107_1_p, swe, 'endast en bokförare närvarade vid mötet').

tree(s_107_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t(anyPl_Det, []), t('UseN', [t(accountant_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(attend_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(meeting_N, [])])])])])])])])).
sent(s_107_2_q, eng, 'did any accountants attend the meeting').
sent(s_107_2_q, original, 'did any accountants attend the meeting').
sent(s_107_2_q, swe, 'närvarade några bokförare vid mötet').

tree(s_107_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t(somePl_Det, []), t('UseN', [t(accountant_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(attend_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(meeting_N, [])])])])])])])).
sent(s_107_3_h, eng, 'some accountants attended the meeting').
sent(s_107_3_h, original, 'some accountants attended the meeting').
sent(s_107_3_h, swe, 'några bokförare närvarade vid mötet').

tree(s_108_1_p, s_105_1_p).
sent(s_108_1_p, eng, 'just one accountant attended the meeting').
sent(s_108_1_p, original, 'just one accountant attended the meeting').
sent(s_108_1_p, swe, 'endast en bokförare närvarade vid mötet').

tree(s_108_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t(anySg_Det, []), t('UseN', [t(accountant_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(attend_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(meeting_N, [])])])])])])])])).
sent(s_108_2_q, eng, 'did any accountant attend the meeting').
sent(s_108_2_q, original, 'did any accountant attend the meeting').
sent(s_108_2_q, swe, 'närvarade någon bokförare vid mötet').

tree(s_108_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t(someSg_Det, []), t('UseN', [t(accountant_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(attend_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(meeting_N, [])])])])])])])).
sent(s_108_3_h, eng, 'some accountant attended the meeting').
sent(s_108_3_h, original, 'some accountant attended the meeting').
sent(s_108_3_h, swe, 'någon bokförare närvarade vid mötet').

tree(s_109_1_p, s_105_1_p).
sent(s_109_1_p, eng, 'just one accountant attended the meeting').
sent(s_109_1_p, original, 'just one accountant attended the meeting').
sent(s_109_1_p, swe, 'endast en bokförare närvarade vid mötet').

tree(s_109_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t(somePl_Det, []), t('UseN', [t(accountant_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(attend_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(meeting_N, [])])])])])])])])).
sent(s_109_2_q, eng, 'did some accountants attend the meeting').
sent(s_109_2_q, original, 'did some accountants attend the meeting').
sent(s_109_2_q, swe, 'närvarade några bokförare vid mötet').

tree(s_109_3_h, s_107_3_h).
sent(s_109_3_h, eng, 'some accountants attended the meeting').
sent(s_109_3_h, original, 'some accountants attended the meeting').
sent(s_109_3_h, swe, 'några bokförare närvarade vid mötet').

tree(s_110_1_p, s_105_1_p).
sent(s_110_1_p, eng, 'just one accountant attended the meeting').
sent(s_110_1_p, original, 'just one accountant attended the meeting').
sent(s_110_1_p, swe, 'endast en bokförare närvarade vid mötet').

tree(s_110_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t(someSg_Det, []), t('UseN', [t(accountant_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(attend_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(meeting_N, [])])])])])])])])).
sent(s_110_2_q, eng, 'did some accountant attend the meeting').
sent(s_110_2_q, original, 'did some accountant attend the meeting').
sent(s_110_2_q, swe, 'närvarade någon bokförare vid mötet').

tree(s_110_3_h, s_108_3_h).
sent(s_110_3_h, eng, 'some accountant attended the meeting').
sent(s_110_3_h, original, 'some accountant attended the meeting').
sent(s_110_3_h, swe, 'någon bokförare närvarade vid mötet').

tree(s_111_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(sign_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_one', [])])])]), t('UseN', [t(contract_N, [])])])])])])])).
sent(s_111_1_p, eng, 'Smith signed one contract').
sent(s_111_1_p, original, 'Smith signed one contract').
sent(s_111_1_p, swe, 'Smith undertecknade ett kontrakt').

tree(s_111_2_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(sign_V2, [])]), t('DetCN', [t(another_Det, []), t('UseN', [t(contract_N, [])])])])])])])).
sent(s_111_2_p, eng, 'Jones signed another contract').
sent(s_111_2_p, original, 'Jones signed another contract').
sent(s_111_2_p, swe, 'Jones undertecknade ett annat kontrakt').

tree(s_111_3_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('ConjNP2', [t(and_Conj, []), t('UsePN', [t(smith_PN, [])]), t('UsePN', [t(jones_PN, [])])]), t('ComplSlash', [t('SlashV2a', [t(sign_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_two', [])])])]), t('UseN', [t(contract_N, [])])])])])])])])).
sent(s_111_3_q, eng, 'did Smith and Jones sign two contracts').
sent(s_111_3_q, original, 'did Smith and Jones sign two contracts').
sent(s_111_3_q, swe, 'undertecknade Smith och Jones två kontrakt').

tree(s_111_4_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('ConjNP2', [t(and_Conj, []), t('UsePN', [t(smith_PN, [])]), t('UsePN', [t(jones_PN, [])])]), t('ComplSlash', [t('SlashV2a', [t(sign_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_two', [])])])]), t('UseN', [t(contract_N, [])])])])])])])).
sent(s_111_4_h, eng, 'Smith and Jones signed two contracts').
sent(s_111_4_h, original, 'Smith and Jones signed two contracts').
sent(s_111_4_h, swe, 'Smith och Jones undertecknade två kontrakt').

tree(s_112_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(sign_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_two', [])])])]), t('UseN', [t(contract_N, [])])])])])])])).
sent(s_112_1_p, eng, 'Smith signed two contracts').
sent(s_112_1_p, original, 'Smith signed two contracts').
sent(s_112_1_p, swe, 'Smith undertecknade två kontrakt').

tree(s_112_2_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(sign_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_two', [])])])]), t('UseN', [t(contract_N, [])])])])])])])).
sent(s_112_2_p, eng, 'Jones signed two contracts').
sent(s_112_2_p, original, 'Jones signed two contracts').
sent(s_112_2_p, swe, 'Jones undertecknade två kontrakt').

tree(s_112_3_q, s_111_3_q).
sent(s_112_3_q, eng, 'did Smith and Jones sign two contracts').
sent(s_112_3_q, original, 'did Smith and Jones sign two contracts').
sent(s_112_3_q, swe, 'undertecknade Smith och Jones två kontrakt').

tree(s_112_4_h, s_111_4_h).
sent(s_112_4_h, eng, 'Smith and Jones signed two contracts').
sent(s_112_4_h, original, 'Smith and Jones signed two contracts').
sent(s_112_4_h, swe, 'Smith och Jones undertecknade två kontrakt').

tree(s_113_1_p, s_112_1_p).
sent(s_113_1_p, eng, 'Smith signed two contracts').
sent(s_113_1_p, original, 'Smith signed two contracts').
sent(s_113_1_p, swe, 'Smith undertecknade två kontrakt').

tree(s_113_2_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('AdVVP', [t(also_AdV, []), t('ComplSlash', [t('SlashV2a', [t(sign_V2, [])]), t('UsePron', [t(they_Pron, [])])])])])])])).
sent(s_113_2_p, eng, 'Jones also signed them').
sent(s_113_2_p, original, 'Jones also signed them').
sent(s_113_2_p, swe, 'Jones undertecknade även dem').

tree(s_113_3_q, s_111_3_q).
sent(s_113_3_q, eng, 'did Smith and Jones sign two contracts').
sent(s_113_3_q, original, 'did Smith and Jones sign two contracts').
sent(s_113_3_q, swe, 'undertecknade Smith och Jones två kontrakt').

tree(s_113_4_h, s_111_4_h).
sent(s_113_4_h, eng, 'Smith and Jones signed two contracts').
sent(s_113_4_h, original, 'Smith and Jones signed two contracts').
sent(s_113_4_h, swe, 'Smith och Jones undertecknade två kontrakt').

tree(s_114_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(mary_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(use_V2, [])]), t('DetCN', [t('DetQuant', [t('PossPron', [t(sheRefl_Pron, [])]), t('NumSg', [])]), t('UseN', [t(workstation_N, [])])])])])])])).
sent(s_114_1_p, eng, 'Mary used her workstation').
sent(s_114_1_p, original, 'Mary used her workstation').
sent(s_114_1_p, swe, 'Mary använde sin arbetsstation').

tree(s_114_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t('DetQuant', [t('GenNP', [t('UsePN', [t(mary_PN, [])])]), t('NumSg', [])]), t('UseN', [t(workstation_N, [])])]), t('PassV2s', [t(use_V2, [])])])])])])).
sent(s_114_2_q, eng, 'was Mary\'s workstation used').
sent(s_114_2_q, original, 'was Mary\'s workstation used').
sent(s_114_2_q, swe, 'användes Marys arbetsstation').

tree(s_114_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('GenNP', [t('UsePN', [t(mary_PN, [])])]), t('NumSg', [])]), t('UseN', [t(workstation_N, [])])]), t('PassV2s', [t(use_V2, [])])])])])).
sent(s_114_3_h, eng, 'Mary\'s workstation was used').
sent(s_114_3_h, original, 'Mary\'s workstation was used').
sent(s_114_3_h, swe, 'Marys arbetsstation användes').

tree(s_115_1_p, s_114_1_p).
sent(s_115_1_p, eng, 'Mary used her workstation').
sent(s_115_1_p, original, 'Mary used her workstation').
sent(s_115_1_p, swe, 'Mary använde sin arbetsstation').

tree(s_115_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(mary_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(workstation_N, [])])])])])])])])).
sent(s_115_2_q, eng, 'does Mary have a workstation').
sent(s_115_2_q, original, 'does Mary have a workstation').
sent(s_115_2_q, swe, 'har Mary en arbetsstation').

tree(s_115_3_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(mary_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(workstation_N, [])])])])])])])).
sent(s_115_3_h, eng, 'Mary has a workstation').
sent(s_115_3_h, original, 'Mary has a workstation').
sent(s_115_3_h, swe, 'Mary har en arbetsstation').

tree(s_116_1_p, s_114_1_p).
sent(s_116_1_p, eng, 'Mary used her workstation').
sent(s_116_1_p, original, 'Mary used her workstation').
sent(s_116_1_p, swe, 'Mary använde sin arbetsstation').

tree(s_116_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(mary_PN, [])]), t('UseComp', [t('CompAP', [t('PositA', [t(female_A, [])])])])])])])])).
sent(s_116_2_q, eng, 'is Mary female').
sent(s_116_2_q, original, 'is Mary female').
sent(s_116_2_q, swe, 'är Mary kvinnlig').

tree(s_116_3_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(mary_PN, [])]), t('UseComp', [t('CompAP', [t('PositA', [t(female_A, [])])])])])])])).
sent(s_116_3_h, eng, 'Mary is female').
sent(s_116_3_h, original, 'Mary is female').
sent(s_116_3_h, swe, 'Mary är kvinnlig').

tree(s_117_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t(every_Det, []), t('UseN', [t(student_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(use_V2, [])]), t('DetCN', [t('DetQuant', [t('PossPron', [t(sheRefl_Pron, [])]), t('NumSg', [])]), t('UseN', [t(workstation_N, [])])])])])])])).
sent(s_117_1_p, eng, 'every student used her workstation').
sent(s_117_1_p, original, 'every student used her workstation').
sent(s_117_1_p, swe, 'varje student använde sin arbetsstation').

tree(s_117_2_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(mary_PN, [])]), t('UseComp', [t('CompCN', [t('UseN', [t(student_N, [])])])])])])])).
sent(s_117_2_p, eng, 'Mary is a student').
sent(s_117_2_p, original, 'Mary is a student').
sent(s_117_2_p, swe, 'Mary är en student').

tree(s_117_3_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(mary_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(use_V2, [])]), t('DetCN', [t('DetQuant', [t('PossPron', [t(sheRefl_Pron, [])]), t('NumSg', [])]), t('UseN', [t(workstation_N, [])])])])])])])])).
sent(s_117_3_q, eng, 'did Mary use her workstation').
sent(s_117_3_q, original, 'did Mary use her workstation').
sent(s_117_3_q, swe, 'använde Mary sin arbetsstation').

tree(s_117_4_h, s_114_1_p).
sent(s_117_4_h, eng, 'Mary used her workstation').
sent(s_117_4_h, original, 'Mary used her workstation').
sent(s_117_4_h, swe, 'Mary använde sin arbetsstation').

tree(s_118_1_p, s_117_1_p).
sent(s_118_1_p, eng, 'every student used her workstation').
sent(s_118_1_p, original, 'every student used her workstation').
sent(s_118_1_p, swe, 'varje student använde sin arbetsstation').

tree(s_118_2_p, s_117_2_p).
sent(s_118_2_p, eng, 'Mary is a student').
sent(s_118_2_p, original, 'Mary is a student').
sent(s_118_2_p, swe, 'Mary är en student').

tree(s_118_3_q, s_115_2_q).
sent(s_118_3_q, eng, 'does Mary have a workstation').
sent(s_118_3_q, original, 'does Mary have a workstation').
sent(s_118_3_q, swe, 'har Mary en arbetsstation').

tree(s_118_4_h, s_115_3_h).
sent(s_118_4_h, eng, 'Mary has a workstation').
sent(s_118_4_h, original, 'Mary has a workstation').
sent(s_118_4_h, swe, 'Mary har en arbetsstation').

tree(s_119_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t(no_Quant, []), t('NumSg', [])]), t('UseN', [t(student_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(use_V2, [])]), t('DetCN', [t('DetQuant', [t('PossPron', [t(sheRefl_Pron, [])]), t('NumSg', [])]), t('UseN', [t(workstation_N, [])])])])])])])).
sent(s_119_1_p, eng, 'no student used her workstation').
sent(s_119_1_p, original, 'no student used her workstation').
sent(s_119_1_p, swe, 'ingen student använde sin arbetsstation').

tree(s_119_2_p, s_117_2_p).
sent(s_119_2_p, eng, 'Mary is a student').
sent(s_119_2_p, original, 'Mary is a student').
sent(s_119_2_p, swe, 'Mary är en student').

tree(s_119_3_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(mary_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(use_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(workstation_N, [])])])])])])])])).
sent(s_119_3_q, eng, 'did Mary use a workstation').
sent(s_119_3_q, original, 'did Mary use a workstation').
sent(s_119_3_q, swe, 'använde Mary en arbetsstation').

tree(s_119_4_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(mary_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(use_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(workstation_N, [])])])])])])])).
sent(s_119_4_h, eng, 'Mary used a workstation').
sent(s_119_4_h, original, 'Mary used a workstation').
sent(s_119_4_h, swe, 'Mary använde en arbetsstation').

tree(s_120_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(attend_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(meeting_N, [])])])])])])])).
sent(s_120_1_p, eng, 'Smith attended a meeting').
sent(s_120_1_p, original, 'Smith attended a meeting').
sent(s_120_1_p, swe, 'Smith närvarade vid ett möte').

tree(s_120_2_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePron', [t(she_Pron, [])]), t('ComplSlash', [t('SlashV2a', [t(chair_V2, [])]), t('UsePron', [t(it_Pron, [])])])])])])).
sent(s_120_2_p, eng, 'she chaired it').
sent(s_120_2_p, original, 'she chaired it').
sent(s_120_2_p, swe, 'hon ledde det').

tree(s_120_3_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(chair_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(meeting_N, [])])])])])])])])).
sent(s_120_3_q, eng, 'did Smith chair a meeting').
sent(s_120_3_q, original, 'did Smith chair a meeting').
sent(s_120_3_q, swe, 'ledde Smith ett möte').

tree(s_120_4_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(chair_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(meeting_N, [])])])])])])])).
sent(s_120_4_h, eng, 'Smith chaired a meeting').
sent(s_120_4_h, original, 'Smith chaired a meeting').
sent(s_120_4_h, swe, 'Smith ledde ett möte').

tree(s_121_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(deliver_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])]), t('PrepNP', [t(to_Prep, []), t('UsePN', [t(itel_PN, [])])])])])])])).
sent(s_121_1_p, eng, 'Smith delivered a report to ITEL').
sent(s_121_1_p, original, 'Smith delivered a report to ITEL').
sent(s_121_1_p, swe, 'Smith lämnade en rapport till ITEL').

tree(s_121_2_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePron', [t(she_Pron, [])]), t('AdVVP', [t(also_AdV, []), t('ComplSlash', [t('Slash2V3', [t(deliver_V3, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(invoice_N, [])])])]), t('UsePron', [t(they_Pron, [])])])])])])])).
sent(s_121_2_p, eng, 'she also delivered them an invoice').
sent(s_121_2_p, original, 'she also delivered them an invoice').
sent(s_121_2_p, swe, 'hon gav även dem en faktura').

tree(s_121_3_p, t('PSentence', [t(and_PConj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePron', [t(she_Pron, [])]), t('ComplSlash', [t('Slash2V3', [t(deliver_V3, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(project_proposal_N, [])])])]), t('UsePron', [t(they_Pron, [])])])])])])).
sent(s_121_3_p, eng, 'and she delivered them a project proposal').
sent(s_121_3_p, original, 'and she delivered them a project proposal').
sent(s_121_3_p, swe, 'och hon gav dem ett projektförslag').

tree(s_121_4_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(deliver_V2, [])]), t('ConjNP3', [t(and_Conj, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(invoice_N, [])])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(project_proposal_N, [])])])])]), t('PrepNP', [t(to_Prep, []), t('UsePN', [t(itel_PN, [])])])])])])])])).
sent(s_121_4_q, eng, 'did Smith deliver a report , an invoice and a project proposal to ITEL').
sent(s_121_4_q, original, 'did Smith deliver a report , an invoice and a project proposal to ITEL').
sent(s_121_4_q, swe, 'lämnade Smith en rapport , en faktura och ett projektförslag till ITEL').

tree(s_121_5_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(deliver_V2, [])]), t('ConjNP3', [t(and_Conj, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(invoice_N, [])])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(project_proposal_N, [])])])])]), t('PrepNP', [t(to_Prep, []), t('UsePN', [t(itel_PN, [])])])])])])])).
sent(s_121_5_h, eng, 'Smith delivered a report , an invoice and a project proposal to ITEL').
sent(s_121_5_h, original, 'Smith delivered a report , an invoice and a project proposal to ITEL').
sent(s_121_5_h, swe, 'Smith lämnade en rapport , en faktura och ett projektförslag till ITEL').

tree(s_122_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t(every_Det, []), t('UseN', [t(committee_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(chairman_N, [])])])])])])])).
sent(s_122_1_p, eng, 'every committee has a chairman').
sent(s_122_1_p, original, 'every committee has a chairman').
sent(s_122_1_p, swe, 'varje kommitté har en ordförande').

tree(s_122_2_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePron', [t(he_Pron, [])]), t('AdvVP', [t('PassV2s', [t(appoint_V2, [])]), t('PrepNP', [t(by8agent_Prep, []), t('DetCN', [t('DetQuant', [t('PossPron', [t(it_Pron, [])]), t('NumPl', [])]), t('UseN', [t(member_N, [])])])])])])])])).
sent(s_122_2_p, eng, 'he is appointed by its members').
sent(s_122_2_p, original, 'he is appointed by its members').
sent(s_122_2_p, swe, 'han utnämns av dess medlemmar').

tree(s_122_3_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t(every_Det, []), t('UseN', [t(committee_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('AdvNP', [t('PPartNP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(chairman_N, [])])]), t(appoint_V2, [])]), t('PrepNP', [t(by8agent_Prep, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('AdvCN', [t('UseN', [t(member_N, [])]), t('PrepNP', [t(possess_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(committee_N, [])])])])])])])])])])])])])).
sent(s_122_3_q, eng, 'does every committee have a chairman appointed by members of the committee').
sent(s_122_3_q, original, 'does every committee have a chairman appointed by members of the committee').
sent(s_122_3_q, swe, 'har varje kommitté en ordförande utnämnd av medlemmar av kommittén').

tree(s_122_4_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t(every_Det, []), t('UseN', [t(committee_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('AdvNP', [t('PPartNP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(chairman_N, [])])]), t(appoint_V2, [])]), t('PrepNP', [t(by8agent_Prep, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('AdvCN', [t('UseN', [t(member_N, [])]), t('PrepNP', [t(possess_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(committee_N, [])])])])])])])])])])])])).
sent(s_122_4_h, eng, 'every committee has a chairman appointed by members of the committee').
sent(s_122_4_h, original, 'every committee has a chairman appointed by members of the committee').
sent(s_122_4_h, swe, 'varje kommitté har en ordförande utnämnd av medlemmar av kommittén').

tree(s_123_1_p, t('Sentence', [t('UseCl', [t('PresentPerfect', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(send_V2, [])]), t('PredetNP', [t(most_of_Predet, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumPl', [])]), t('RelCN', [t('UseN', [t(report_N, [])]), t('UseRCl', [t('Present', []), t('PPos', []), t('EmptyRelSlash', [t('SlashVP', [t('UsePN', [t(smith_PN, [])]), t('SlashV2a', [t(need_V2, [])])])])])])])])])])])])).
sent(s_123_1_p, eng, 'ITEL has sent most of the reports Smith needs').
sent(s_123_1_p, original, 'ITEL has sent most of the reports Smith needs').
sent(s_123_1_p, swe, 'ITEL har skickat de flesta av rapporterna Smith behöver').

tree(s_123_2_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePron', [t(they_Pron, [])]), t('UseComp', [t('CompAdv', [t('PrepNP', [t(on_Prep, []), t('DetCN', [t('DetQuant', [t('PossPron', [t(she_Pron, [])]), t('NumSg', [])]), t('UseN', [t(desk_N, [])])])])])])])])])).
sent(s_123_2_p, eng, 'they are on her desk').
sent(s_123_2_p, original, 'they are on her desk').
sent(s_123_2_p, swe, 'de är på hennes skrivbord').

tree(s_123_3_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('ExistNP', [t('AdvNP', [t('DetCN', [t(somePl_Det, []), t('AdvCN', [t('UseN', [t(report_N, [])]), t('PrepNP', [t(from_Prep, []), t('UsePN', [t(itel_PN, [])])])])]), t('PrepNP', [t(on_Prep, []), t('DetCN', [t('DetQuant', [t('GenNP', [t('UsePN', [t(smith_PN, [])])]), t('NumSg', [])]), t('UseN', [t(desk_N, [])])])])])])])])])).
sent(s_123_3_q, eng, 'are there some reports from ITEL on Smith\'s desk').
sent(s_123_3_q, original, 'are there some reports from ITEL on Smith\'s desk').
sent(s_123_3_q, swe, 'finns det några rapporter från ITEL på Smiths skrivbord').

tree(s_123_4_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('ExistNP', [t('AdvNP', [t('DetCN', [t(somePl_Det, []), t('AdvCN', [t('UseN', [t(report_N, [])]), t('PrepNP', [t(from_Prep, []), t('UsePN', [t(itel_PN, [])])])])]), t('PrepNP', [t(on_Prep, []), t('DetCN', [t('DetQuant', [t('GenNP', [t('UsePN', [t(smith_PN, [])])]), t('NumSg', [])]), t('UseN', [t(desk_N, [])])])])])])])])).
sent(s_123_4_h, eng, 'there are some reports from ITEL on Smith\'s desk').
sent(s_123_4_h, original, 'there are some reports from ITEL on Smith\'s desk').
sent(s_123_4_h, swe, 'det finns några rapporter från ITEL på Smiths skrivbord').

tree(s_124_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('AdvNP', [t('DetNP', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_two', [])])])])]), t('PrepNP', [t(out_of_Prep, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_ten', [])])])]), t('UseN', [t(machine_N, [])])])])]), t('UseComp', [t('CompAP', [t('PositA', [t(missing_A, [])])])])])])])).
sent(s_124_1_p, eng, 'two out of ten machines are missing').
sent(s_124_1_p, original, 'two out of ten machines are missing').
sent(s_124_1_p, swe, 'två av tio maskiner är försvunna').

tree(s_124_2_p, t('Sentence', [t('UseCl', [t('PresentPerfect', []), t('PPos', []), t('PredVP', [t('UsePron', [t(they_Pron, [])]), t('PassV2s', [t(remove_V2, [])])])])])).
sent(s_124_2_p, eng, 'they have been removed').
sent(s_124_2_p, original, 'they have been removed').
sent(s_124_2_p, swe, 'de har avlägsnats').

tree(s_124_3_q, t('Question', [t('UseQCl', [t('PresentPerfect', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_two', [])])])]), t('UseN', [t(machine_N, [])])]), t('PassV2s', [t(remove_V2, [])])])])])])).
sent(s_124_3_q, eng, 'have two machines been removed').
sent(s_124_3_q, original, 'have two machines been removed').
sent(s_124_3_q, swe, 'har två maskiner avlägsnats').

tree(s_124_4_h, t('Sentence', [t('UseCl', [t('PresentPerfect', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_two', [])])])]), t('UseN', [t(machine_N, [])])]), t('PassV2s', [t(remove_V2, [])])])])])).
sent(s_124_4_h, eng, 'two machines have been removed').
sent(s_124_4_h, original, 'two machines have been removed').
sent(s_124_4_h, swe, 'två maskiner har avlägsnats').

tree(s_125_1_p, s_124_1_p).
sent(s_125_1_p, eng, 'two out of ten machines are missing').
sent(s_125_1_p, original, 'two out of ten machines are missing').
sent(s_125_1_p, swe, 'två av tio maskiner är försvunna').

tree(s_125_2_p, s_124_2_p).
sent(s_125_2_p, eng, 'they have been removed').
sent(s_125_2_p, original, 'they have been removed').
sent(s_125_2_p, swe, 'de har avlägsnats').

tree(s_125_3_q, t('Question', [t('UseQCl', [t('PresentPerfect', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_eight', [])])])]), t('UseN', [t(machine_N, [])])]), t('PassV2s', [t(remove_V2, [])])])])])])).
sent(s_125_3_q, eng, 'have eight machines been removed').
sent(s_125_3_q, original, 'have eight machines been removed').
sent(s_125_3_q, swe, 'har åtta maskiner avlägsnats').

tree(s_125_4_h, t('Sentence', [t('UseCl', [t('PresentPerfect', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_eight', [])])])]), t('UseN', [t(machine_N, [])])]), t('PassV2s', [t(remove_V2, [])])])])])).
sent(s_125_4_h, eng, 'eight machines have been removed').
sent(s_125_4_h, original, 'eight machines have been removed').
sent(s_125_4_h, swe, 'åtta maskiner har avlägsnats').

tree(s_126_1_p, s_124_1_p).
sent(s_126_1_p, eng, 'two out of ten machines are missing').
sent(s_126_1_p, original, 'two out of ten machines are missing').
sent(s_126_1_p, swe, 'två av tio maskiner är försvunna').

tree(s_126_2_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePron', [t(they_Pron, [])]), t('AdvVP', [t('AdVVP', [t(all_AdV, []), t('UseComp', [t('CompAdv', [t(here_Adv, [])])])]), t(yesterday_Adv, [])])])])])).
sent(s_126_2_p, eng, 'they were all here yesterday').
sent(s_126_2_p, original, 'they were all here yesterday').
sent(s_126_2_p, swe, 'de var alla här igår').

tree(s_126_3_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_ten', [])])])]), t('UseN', [t(machine_N, [])])]), t('AdvVP', [t('UseComp', [t('CompAdv', [t(here_Adv, [])])]), t(yesterday_Adv, [])])])])])])).
sent(s_126_3_q, eng, 'were ten machines here yesterday').
sent(s_126_3_q, original, 'were ten machines here yesterday').
sent(s_126_3_q, swe, 'var tio maskiner här igår').

tree(s_126_4_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_ten', [])])])]), t('UseN', [t(machine_N, [])])]), t('AdvVP', [t('UseComp', [t('CompAdv', [t(here_Adv, [])])]), t(yesterday_Adv, [])])])])])).
sent(s_126_4_h, eng, 'ten machines were here yesterday').
sent(s_126_4_h, original, 'ten machines were here yesterday').
sent(s_126_4_h, swe, 'tio maskiner var här igår').

tree(s_127_1_p, t('Sentence', [t('ConjS2', [t(comma_and_Conj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(take_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(machine_N, [])])])]), t(on_tuesday_Adv, [])])])]), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(take_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(machine_N, [])])])]), t(on_wednesday_Adv, [])])])])])])).
sent(s_127_1_p, eng, 'Smith took a machine on Tuesday , and Jones took a machine on Wednesday').
sent(s_127_1_p, original, 'Smith took a machine on Tuesday , and Jones took a machine on Wednesday').
sent(s_127_1_p, swe, 'Smith tog en maskin på tisdagen , och Jones tog en maskin på onsdagen').

tree(s_127_2_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePron', [t(they_Pron, [])]), t('ComplSlash', [t('Slash3V3', [t(put_in_V3, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(lobby_N, [])])])]), t('UsePron', [t(they_Pron, [])])])])])])).
sent(s_127_2_p, eng, 'they put them in the lobby').
sent(s_127_2_p, original, 'they put them in the lobby').
sent(s_127_2_p, swe, 'de ställde dem i vestibulen').

tree(s_127_3_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('ConjNP2', [t(and_Conj, []), t('UsePN', [t(smith_PN, [])]), t('UsePN', [t(jones_PN, [])])]), t('ComplSlash', [t('Slash3V3', [t(put_in_V3, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(lobby_N, [])])])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_two', [])])])]), t('UseN', [t(machine_N, [])])])])])])])])).
sent(s_127_3_q, eng, 'did Smith and Jones put two machines in the lobby').
sent(s_127_3_q, original, 'did Smith and Jones put two machines in the lobby').
sent(s_127_3_q, swe, 'ställde Smith och Jones två maskiner i vestibulen').

tree(s_127_4_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('ConjNP2', [t(and_Conj, []), t('UsePN', [t(smith_PN, [])]), t('UsePN', [t(jones_PN, [])])]), t('ComplSlash', [t('Slash3V3', [t(put_in_V3, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(lobby_N, [])])])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_two', [])])])]), t('UseN', [t(machine_N, [])])])])])])])).
sent(s_127_4_h, eng, 'Smith and Jones put two machines in the lobby').
sent(s_127_4_h, original, 'Smith and Jones put two machines in the lobby').
sent(s_127_4_h, swe, 'Smith och Jones ställde två maskiner i vestibulen').

tree(s_128_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('ConjNP2', [t(and_Conj, []), t('UsePN', [t(john_PN, [])]), t('DetCN', [t('DetQuant', [t('PossPron', [t(he_Pron, [])]), t('NumPl', [])]), t('UseN', [t(colleague_N, [])])])]), t('AdvVP', [t('UseV', [t(go8walk_V, [])]), t('PrepNP', [t(to_Prep, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(meeting_N, [])])])])])])])])).
sent(s_128_1_p, eng, 'John and his colleagues went to a meeting').
sent(s_128_1_p, original, 'John and his colleagues went to a meeting').
sent(s_128_1_p, swe, 'John och hans kollegor gick till ett möte').

tree(s_128_2_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePron', [t(they_Pron, [])]), t('ComplSlash', [t('SlashV2a', [t(hate_V2, [])]), t('UsePron', [t(it_Pron, [])])])])])])).
sent(s_128_2_p, eng, 'they hated it').
sent(s_128_2_p, original, 'they hated it').
sent(s_128_2_p, swe, 'de hatade det').

tree(s_128_3_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t('DetQuant', [t('GenNP', [t('UsePN', [t(john_PN, [])])]), t('NumPl', [])]), t('UseN', [t(colleague_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(hate_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(meeting_N, [])])])])])])])])).
sent(s_128_3_q, eng, 'did John\'s colleagues hate the meeting').
sent(s_128_3_q, original, 'did John\'s colleagues hate the meeting').
sent(s_128_3_q, swe, 'hatade Johns kollegor mötet').

tree(s_128_4_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('GenNP', [t('UsePN', [t(john_PN, [])])]), t('NumPl', [])]), t('UseN', [t(colleague_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(hate_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(meeting_N, [])])])])])])])).
sent(s_128_4_h, eng, 'John\'s colleagues hated the meeting').
sent(s_128_4_h, original, 'John\'s colleagues hated the meeting').
sent(s_128_4_h, swe, 'Johns kollegor hatade mötet').

tree(s_129_1_p, s_128_1_p).
sent(s_129_1_p, eng, 'John and his colleagues went to a meeting').
sent(s_129_1_p, original, 'John and his colleagues went to a meeting').
sent(s_129_1_p, swe, 'John och hans kollegor gick till ett möte').

tree(s_129_2_p, s_128_2_p).
sent(s_129_2_p, eng, 'they hated it').
sent(s_129_2_p, original, 'they hated it').
sent(s_129_2_p, swe, 'de hatade det').

tree(s_129_3_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(john_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(hate_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(meeting_N, [])])])])])])])])).
sent(s_129_3_q, eng, 'did John hate the meeting').
sent(s_129_3_q, original, 'did John hate the meeting').
sent(s_129_3_q, swe, 'hatade John mötet').

tree(s_129_4_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(hate_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(meeting_N, [])])])])])])])).
sent(s_129_4_h, eng, 'John hated the meeting').
sent(s_129_4_h, original, 'John hated the meeting').
sent(s_129_4_h, swe, 'John hatade mötet').

tree(s_130_1_p, s_128_1_p).
sent(s_130_1_p, eng, 'John and his colleagues went to a meeting').
sent(s_130_1_p, original, 'John and his colleagues went to a meeting').
sent(s_130_1_p, swe, 'John och hans kollegor gick till ett möte').

tree(s_130_2_p, s_128_2_p).
sent(s_130_2_p, eng, 'they hated it').
sent(s_130_2_p, original, 'they hated it').
sent(s_130_2_p, swe, 'de hatade det').

tree(s_130_3_q, s_129_3_q).
sent(s_130_3_q, eng, 'did John hate the meeting').
sent(s_130_3_q, original, 'did John hate the meeting').
sent(s_130_3_q, swe, 'hatade John mötet').

tree(s_130_4_h, s_129_4_h).
sent(s_130_4_h, eng, 'John hated the meeting').
sent(s_130_4_h, original, 'John hated the meeting').
sent(s_130_4_h, swe, 'John hatade mötet').

tree(s_131_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t(each_Det, []), t('UseN', [t(department_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(dedicated_A, [])]), t('UseN', [t(line_N, [])])])])])])])])).
sent(s_131_1_p, eng, 'each department has a dedicated line').
sent(s_131_1_p, original, 'each department has a dedicated line').
sent(s_131_1_p, swe, 'varje avdelning har en särskild linje').

tree(s_131_2_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePron', [t(they_Pron, [])]), t('ComplSlash', [t('Slash3V3', [t(rent_from_V3, []), t('UsePN', [t(bt_PN, [])])]), t('UsePron', [t(they_Pron, [])])])])])])).
sent(s_131_2_p, eng, 'they rent them from BT').
sent(s_131_2_p, original, 'they rent them from BT').
sent(s_131_2_p, swe, 'de hyr dem från BT').

tree(s_131_3_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t(every_Det, []), t('UseN', [t(department_N, [])])]), t('ComplSlash', [t('Slash3V3', [t(rent_from_V3, []), t('UsePN', [t(bt_PN, [])])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(line_N, [])])])])])])])])).
sent(s_131_3_q, eng, 'does every department rent a line from BT').
sent(s_131_3_q, original, 'does every department rent a line from BT').
sent(s_131_3_q, swe, 'hyr varje avdelning en linje från BT').

tree(s_131_4_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t(every_Det, []), t('UseN', [t(department_N, [])])]), t('ComplSlash', [t('Slash3V3', [t(rent_from_V3, []), t('UsePN', [t(bt_PN, [])])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(line_N, [])])])])])])])).
sent(s_131_4_h, eng, 'every department rents a line from BT').
sent(s_131_4_h, original, 'every department rents a line from BT').
sent(s_131_4_h, swe, 'varje avdelning hyr en linje från BT').

tree(s_132_1_p, s_131_1_p).
sent(s_132_1_p, eng, 'each department has a dedicated line').
sent(s_132_1_p, original, 'each department has a dedicated line').
sent(s_132_1_p, swe, 'varje avdelning har en särskild linje').

tree(s_132_2_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(sales_department_N, [])])]), t('ComplSlash', [t('Slash3V3', [t(rent_from_V3, []), t('UsePN', [t(bt_PN, [])])]), t('UsePron', [t(it_Pron, [])])])])])])).
sent(s_132_2_p, eng, 'the sales department rents it from BT').
sent(s_132_2_p, original, 'the sales department rents it from BT').
sent(s_132_2_p, swe, 'försäljningsavdelningen hyr det från BT').

tree(s_132_3_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(sales_department_N, [])])]), t('ComplSlash', [t('Slash3V3', [t(rent_from_V3, []), t('UsePN', [t(bt_PN, [])])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(line_N, [])])])])])])])])).
sent(s_132_3_q, eng, 'does the sales department rent a line from BT').
sent(s_132_3_q, original, 'does the sales department rent a line from BT').
sent(s_132_3_q, swe, 'hyr försäljningsavdelningen en linje från BT').

tree(s_132_4_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(sales_department_N, [])])]), t('ComplSlash', [t('Slash3V3', [t(rent_from_V3, []), t('UsePN', [t(bt_PN, [])])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(line_N, [])])])])])])])).
sent(s_132_4_h, eng, 'the sales department rents a line from BT').
sent(s_132_4_h, original, 'the sales department rents a line from BT').
sent(s_132_4_h, swe, 'försäljningsavdelningen hyr en linje från BT').

tree(s_133_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(gfi_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(own_V2, [])]), t('DetCN', [t(several_Det, []), t('UseN', [t(computer_N, [])])])])])])])).
sent(s_133_1_p, eng, 'GFI owns several computers').
sent(s_133_1_p, original, 'GFI owns several computers').
sent(s_133_1_p, swe, 'GFI äger flera datorer').

tree(s_133_2_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(maintain_V2, [])]), t('UsePron', [t(they_Pron, [])])])])])])).
sent(s_133_2_p, eng, 'ITEL maintains them').
sent(s_133_2_p, original, 'ITEL maintains them').
sent(s_133_2_p, swe, 'ITEL servar dem').

tree(s_133_3_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(maintain_V2, [])]), t('PredetNP', [t(all_Predet, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumPl', [])]), t('RelCN', [t('UseN', [t(computer_N, [])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelSlash', [t(that_RP, []), t('SlashVP', [t('UsePN', [t(gfi_PN, [])]), t('SlashV2a', [t(own_V2, [])])])])])])])])])])])])])).
sent(s_133_3_q, eng, 'does ITEL maintain all the computers that GFI owns').
sent(s_133_3_q, original, 'does ITEL maintain all the computers that GFI owns').
sent(s_133_3_q, swe, 'servar ITEL alla datorerna som GFI äger').

tree(s_133_4_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(maintain_V2, [])]), t('PredetNP', [t(all_Predet, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumPl', [])]), t('RelCN', [t('UseN', [t(computer_N, [])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelSlash', [t(that_RP, []), t('SlashVP', [t('UsePN', [t(gfi_PN, [])]), t('SlashV2a', [t(own_V2, [])])])])])])])])])])])])).
sent(s_133_4_h, eng, 'ITEL maintains all the computers that GFI owns').
sent(s_133_4_h, original, 'ITEL maintains all the computers that GFI owns').
sent(s_133_4_h, swe, 'ITEL servar alla datorerna som GFI äger').

tree(s_134_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t(every_Det, []), t('RelCN', [t('UseN', [t(customer_N, [])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('ComplSlash', [t('SlashV2a', [t(own_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(computer_N, [])])])])])])])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(service_contract_N, [])])])]), t('PrepNP', [t(for_Prep, []), t('UsePron', [t(it_Pron, [])])])])])])])).
sent(s_134_1_p, eng, 'every customer who owns a computer has a service contract for it').
sent(s_134_1_p, original, 'every customer who owns a computer has a service contract for it').
sent(s_134_1_p, swe, 'varje kund som äger en dator har ett servicekontrakt för det').

tree(s_134_2_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(mfi_PN, [])]), t('UseComp', [t('CompCN', [t('RelCN', [t('UseN', [t(customer_N, [])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelVP', [t(that_RP, []), t('ComplSlash', [t('SlashV2a', [t(own_V2, [])]), t('PredetNP', [t(exactly_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_one', [])])])]), t('UseN', [t(computer_N, [])])])])])])])])])])])])])).
sent(s_134_2_p, eng, 'MFI is a customer that owns exactly one computer').
sent(s_134_2_p, original, 'MFI is a customer that owns exactly one computer').
sent(s_134_2_p, swe, 'MFI är en kund som äger exakt en dator').

tree(s_134_3_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(mfi_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(service_contract_N, [])])])]), t('PrepNP', [t(for_Prep, []), t('PredetNP', [t(all_Predet, []), t('DetCN', [t('DetQuant', [t('PossPron', [t(itRefl_Pron, [])]), t('NumPl', [])]), t('UseN', [t(computer_N, [])])])])])])])])])])).
sent(s_134_3_q, eng, 'does MFI have a service contract for all its computers').
sent(s_134_3_q, original, 'does MFI have a service contract for all its computers').
sent(s_134_3_q, swe, 'har MFI ett servicekontrakt för alla sina datorer').

tree(s_134_4_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(mfi_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(service_contract_N, [])])])]), t('PrepNP', [t(for_Prep, []), t('PredetNP', [t(all_Predet, []), t('DetCN', [t('DetQuant', [t('PossPron', [t(itRefl_Pron, [])]), t('NumPl', [])]), t('UseN', [t(computer_N, [])])])])])])])])])).
sent(s_134_4_h, eng, 'MFI has a service contract for all its computers').
sent(s_134_4_h, original, 'MFI has a service contract for all its computers').
sent(s_134_4_h, swe, 'MFI har ett servicekontrakt för alla sina datorer').

tree(s_135_1_p, s_134_1_p).
sent(s_135_1_p, eng, 'every customer who owns a computer has a service contract for it').
sent(s_135_1_p, original, 'every customer who owns a computer has a service contract for it').
sent(s_135_1_p, swe, 'varje kund som äger en dator har ett servicekontrakt för det').

tree(s_135_2_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(mfi_PN, [])]), t('UseComp', [t('CompCN', [t('RelCN', [t('UseN', [t(customer_N, [])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelVP', [t(that_RP, []), t('ComplSlash', [t('SlashV2a', [t(own_V2, [])]), t('DetCN', [t(several_Det, []), t('UseN', [t(computer_N, [])])])])])])])])])])])])).
sent(s_135_2_p, eng, 'MFI is a customer that owns several computers').
sent(s_135_2_p, original, 'MFI is a customer that owns several computers').
sent(s_135_2_p, swe, 'MFI är en kund som äger flera datorer').

tree(s_135_3_q, s_134_3_q).
sent(s_135_3_q, eng, 'does MFI have a service contract for all its computers').
sent(s_135_3_q, original, 'does MFI have a service contract for all its computers').
sent(s_135_3_q, swe, 'har MFI ett servicekontrakt för alla sina datorer').

tree(s_135_4_h, s_134_4_h).
sent(s_135_4_h, eng, 'MFI has a service contract for all its computers').
sent(s_135_4_h, original, 'MFI has a service contract for all its computers').
sent(s_135_4_h, swe, 'MFI har ett servicekontrakt för alla sina datorer').

tree(s_136_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t(every_Det, []), t('RelCN', [t('UseN', [t(executive_N, [])]), t('UseRCl', [t('Past', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(laptop_computer_N, [])])])])])])])]), t('ComplSlash', [t('SlashV2V', [t(bring_V2V, []), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(take_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('UseN', [t(note_N, [])])])]), t('PrepNP', [t(at_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(meeting_N, [])])])])])]), t('UsePron', [t(it_Pron, [])])])])])])).
sent(s_136_1_p, eng, 'every executive who had a laptop computer brought it to take notes at the meeting').
sent(s_136_1_p, original, 'every executive who had a laptop computer brought it to take notes at the meeting').
sent(s_136_1_p, swe, 'varje företagsledare som hade en laptop tog med det att ta anteckningar på mötet').

tree(s_136_2_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('UseComp', [t('CompCN', [t('RelCN', [t('UseN', [t(executive_N, [])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('ComplSlash', [t('SlashV2a', [t(own_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_five', [])])])]), t('AdjCN', [t('PositA', [t(different_A, [])]), t('UseN', [t(laptop_computer_N, [])])])])])])])])])])])])])).
sent(s_136_2_p, eng, 'Smith is an executive who owns five different laptop computers').
sent(s_136_2_p, original, 'Smith is an executive who owns five different laptop computers').
sent(s_136_2_p, swe, 'Smith är en företagsledare som äger fem olika laptopar').

tree(s_136_3_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(take_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_five', [])])])]), t('UseN', [t(laptop_computer_N, [])])])]), t('PrepNP', [t(to_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(meeting_N, [])])])])])])])])])).
sent(s_136_3_q, eng, 'did Smith take five laptop computers to the meeting').
sent(s_136_3_q, original, 'did Smith take five laptop computers to the meeting').
sent(s_136_3_q, swe, 'tog Smith fem laptopar till mötet').

tree(s_136_4_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(take_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_five', [])])])]), t('UseN', [t(laptop_computer_N, [])])])]), t('PrepNP', [t(to_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(meeting_N, [])])])])])])])])).
sent(s_136_4_h, eng, 'Smith took five laptop computers to the meeting').
sent(s_136_4_h, original, 'Smith took five laptop computers to the meeting').
sent(s_136_4_h, swe, 'Smith tog fem laptopar till mötet').

tree(s_137_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('ExistNP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_100', [])])])]), t('UseN', [t(company_N, [])])])])])])).
sent(s_137_1_p, eng, 'there are 100 companies').
sent(s_137_1_p, original, 'there are 100 companies').
sent(s_137_1_p, swe, 'det finns 100 företag').

tree(s_137_2_p, t('Sentence', [t('PredVPS', [t('UsePN', [t(icm_PN, [])]), t('ConjVPS2', [t(and_Conj, []), t('Present', []), t('PPos', []), t('UseComp', [t('CompNP', [t('AdvNP', [t('DetNP', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_one', [])])])])]), t('PrepNP', [t(part_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumPl', [])]), t('UseN', [t(company_N, [])])])])])])]), t('Present', []), t('PPos', []), t('ComplSlash', [t('SlashV2a', [t(own_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_150', [])])])]), t('UseN', [t(computer_N, [])])])])])])])).
sent(s_137_2_p, eng, 'ICM is one of the companies and owns 150 computers').
sent(s_137_2_p, original, 'ICM is one of the companies and owns 150 computers').
sent(s_137_2_p, swe, 'ICM är ett av företagen och äger 150 datorer').

tree(s_137_3_p, t('Sentence', [t('UseCl', [t('Present', []), t('UncNeg', []), t('PredVP', [t('UsePron', [t(it_Pron, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('UseN', [t(service_contract_N, [])])])]), t('PrepNP', [t(for_Prep, []), t('AdvNP', [t('DetNP', [t(anySg_Det, [])]), t('PrepNP', [t(part_Prep, []), t('DetCN', [t('DetQuant', [t('PossPron', [t(itRefl_Pron, [])]), t('NumPl', [])]), t('UseN', [t(computer_N, [])])])])])])])])])])).
sent(s_137_3_p, eng, 'it does not have service contracts for any of its computers').
sent(s_137_3_p, original, 'it does not have service contracts for any of its computers').
sent(s_137_3_p, swe, 'det har inte servicekontrakt för något av sina datorer').

tree(s_137_4_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('AdvNP', [t('DetNP', [t(each_Det, [])]), t('PrepNP', [t(part_Prep, []), t('DetCN', [t('DetQuant', [t(the_other_Q, []), t('NumCard', [t('NumNumeral', [t('N_99', [])])])]), t('UseN', [t(company_N, [])])])])]), t('ComplSlash', [t('SlashV2a', [t(own_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_one', [])])])]), t('UseN', [t(computer_N, [])])])])])])])).
sent(s_137_4_p, eng, 'each of the other 99 companies owns one computer').
sent(s_137_4_p, original, 'each of the other 99 companies owns one computer').
sent(s_137_4_p, swe, 'vart och ett av de andra 99 företagen äger en dator').

tree(s_137_5_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePron', [t(they_Pron, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('UseN', [t(service_contract_N, [])])])]), t('PrepNP', [t(for_Prep, []), t('UsePron', [t(they_Pron, [])])])])])])])).
sent(s_137_5_p, eng, 'they have service contracts for them').
sent(s_137_5_p, original, 'they have service contracts for them').
sent(s_137_5_p, swe, 'de har servicekontrakt för dem').

tree(s_137_6_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('PredetNP', [t(most_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('RelCN', [t('UseN', [t(company_N, [])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelVP', [t(that_RP, []), t('ComplSlash', [t('SlashV2a', [t(own_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(computer_N, [])])])])])])])])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(service_contract_N, [])])])]), t('PrepNP', [t(for_Prep, []), t('UsePron', [t(it_Pron, [])])])])])])])])).
sent(s_137_6_q, eng, 'do most companies that own a computer have a service contract for it').
sent(s_137_6_q, original, 'do most companies that own a computer have a service contract for it').
sent(s_137_6_q, swe, 'har de flesta företag som äger en dator ett servicekontrakt för det').

tree(s_137_7_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('PredetNP', [t(most_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('RelCN', [t('UseN', [t(company_N, [])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelVP', [t(that_RP, []), t('ComplSlash', [t('SlashV2a', [t(own_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(computer_N, [])])])])])])])])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(service_contract_N, [])])])]), t('PrepNP', [t(for_Prep, []), t('UsePron', [t(it_Pron, [])])])])])])])).
sent(s_137_7_h, eng, 'most companies that own a computer have a service contract for it').
sent(s_137_7_h, original, 'most companies that own a computer have a service contract for it').
sent(s_137_7_h, swe, 'de flesta företag som äger en dator har ett servicekontrakt för det').

tree(s_138_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t(every_Det, []), t('UseN', [t(report_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(cover_page_N, [])])])])])])])).
sent(s_138_1_p, eng, 'every report has a cover page').
sent(s_138_1_p, original, 'every report has a cover page').
sent(s_138_1_p, swe, 'varje rapport har en förstasida').

tree(s_138_2_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(r95103_PN, [])]), t('UseComp', [t('CompCN', [t('UseN', [t(report_N, [])])])])])])])).
sent(s_138_2_p, eng, 'R-95-103 is a report').
sent(s_138_2_p, original, 'R-95-103 is a report').
sent(s_138_2_p, swe, 'R-95-103 är en rapport').

tree(s_138_3_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(sign_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(cover_page_N, [])])])])])])])).
sent(s_138_3_p, eng, 'Smith signed the cover page').
sent(s_138_3_p, original, 'Smith signed the cover page').
sent(s_138_3_p, swe, 'Smith undertecknade förstasidan').

tree(s_138_4_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(sign_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('AdvCN', [t('UseN', [t(cover_page_N, [])]), t('PrepNP', [t(possess_Prep, []), t('UsePN', [t(r95103_PN, [])])])])])])])])])])).
sent(s_138_4_q, eng, 'did Smith sign the cover page of R-95-103').
sent(s_138_4_q, original, 'did Smith sign the cover page of R-95-103').
sent(s_138_4_q, swe, 'undertecknade Smith förstasidan av R-95-103').

tree(s_138_5_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(sign_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('AdvCN', [t('UseN', [t(cover_page_N, [])]), t('PrepNP', [t(possess_Prep, []), t('UsePN', [t(r95103_PN, [])])])])])])])])])).
sent(s_138_5_h, eng, 'Smith signed the cover page of R-95-103').
sent(s_138_5_h, original, 'Smith signed the cover page of R-95-103').
sent(s_138_5_h, swe, 'Smith undertecknade förstasidan av R-95-103').

tree(s_139_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(company_director_N, [])])]), t('ReflVP', [t('Slash3V3', [t(award_V3, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(large_A, [])]), t('UseN', [t(payrise_N, [])])])])])])])])])).
sent(s_139_1_p, eng, 'a company director awarded himself a large payrise').
sent(s_139_1_p, original, 'a company director awarded himself a large payrise').
sent(s_139_1_p, swe, 'en företagsledare tilldelade sig en stor löneförhöjning').

tree(s_139_2_q, t('Question', [t('UseQCl', [t('PresentPerfect', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(company_director_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(award_and_be_awarded_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(payrise_N, [])])])])])])])])).
sent(s_139_2_q, eng, 'has a company director awarded and been awarded a payrise').
sent(s_139_2_q, original, 'has a company director awarded and been awarded a payrise').
sent(s_139_2_q, swe, 'har en företagsledare tilldelat och tilldelats en löneförhöjning').

tree(s_139_3_h, t('Sentence', [t('UseCl', [t('PresentPerfect', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(company_director_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(award_and_be_awarded_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(payrise_N, [])])])])])])])).
sent(s_139_3_h, eng, 'a company director has awarded and been awarded a payrise').
sent(s_139_3_h, original, 'a company director has awarded and been awarded a payrise').
sent(s_139_3_h, swe, 'en företagsledare har tilldelat och tilldelats en löneförhöjning').

tree(s_140_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('ComplVSa', [t(say_VS, []), t('UseCl', [t('PastPerfect', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('ReflVP', [t('SlashV2a', [t(hurt_V2, [])])])])])])])])])).
sent(s_140_1_p, eng, 'John said Bill had hurt himself').
sent(s_140_1_p, original, 'John said Bill had hurt himself').
sent(s_140_1_p, swe, 'John sade att Bill hade skadat sig').

tree(s_140_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(john_PN, [])]), t('ComplVSa', [t(say_VS, []), t('UseCl', [t('PastPerfect', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('PassV2s', [t(hurt_V2, [])])])])])])])])])).
sent(s_140_2_q, eng, 'did John say Bill had been hurt').
sent(s_140_2_q, original, 'did John say Bill had been hurt').
sent(s_140_2_q, swe, 'sade John att Bill hade skadats').

tree(s_140_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('ComplVSa', [t(say_VS, []), t('UseCl', [t('PastPerfect', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('PassV2s', [t(hurt_V2, [])])])])])])])])).
sent(s_140_3_h, eng, 'John said Bill had been hurt').
sent(s_140_3_h, original, 'John said Bill had been hurt').
sent(s_140_3_h, swe, 'John sade att Bill hade skadats').

tree(s_141_1_p, s_140_1_p).
sent(s_141_1_p, eng, 'John said Bill had hurt himself').
sent(s_141_1_p, original, 'John said Bill had hurt himself').
sent(s_141_1_p, swe, 'John sade att Bill hade skadat sig').

tree(s_141_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePron', [t(anyone_Pron, [])]), t('ComplVSa', [t(say_VS, []), t('UseCl', [t('PastPerfect', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('PassV2s', [t(hurt_V2, [])])])])])])])])])).
sent(s_141_2_q, eng, 'did anyone say John had been hurt').
sent(s_141_2_q, original, 'did anyone say John had been hurt').
sent(s_141_2_q, swe, 'sade någon att John hade skadats').

tree(s_141_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePron', [t(someone_Pron, [])]), t('ComplVSa', [t(say_VS, []), t('UseCl', [t('PastPerfect', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('PassV2s', [t(hurt_V2, [])])])])])])])])).
sent(s_141_3_h, eng, 'someone said John had been hurt').
sent(s_141_3_h, original, 'someone said John had been hurt').
sent(s_141_3_h, swe, 'någon sade att John hade skadats').

tree(s_142_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(speak_to_V2, [])]), t('UsePN', [t(mary_PN, [])])])])])])).
sent(s_142_1_p, eng, 'John spoke to Mary').
sent(s_142_1_p, original, 'John spoke to Mary').
sent(s_142_1_p, swe, 'John talade med Mary').

tree(s_142_2_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('SoDoI', [t('UsePN', [t(bill_PN, [])])])])])).
sent(s_142_2_p, eng, 'so did Bill').
sent(s_142_2_p, original, 'so did Bill').
sent(s_142_2_p, swe, 'det gjorde Bill också').

tree(s_142_3_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(speak_to_V2, [])]), t('UsePN', [t(mary_PN, [])])])])])])])).
sent(s_142_3_q, eng, 'did Bill speak to Mary').
sent(s_142_3_q, original, 'did Bill speak to Mary').
sent(s_142_3_q, swe, 'talade Bill med Mary').

tree(s_142_4_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(speak_to_V2, [])]), t('UsePN', [t(mary_PN, [])])])])])])).
sent(s_142_4_h, eng, 'Bill spoke to Mary').
sent(s_142_4_h, original, 'Bill spoke to Mary').
sent(s_142_4_h, swe, 'Bill talade med Mary').

tree(s_143_1_p, s_142_1_p).
sent(s_143_1_p, eng, 'John spoke to Mary').
sent(s_143_1_p, original, 'John spoke to Mary').
sent(s_143_1_p, swe, 'John talade med Mary').

tree(s_143_2_p, s_142_2_p).
sent(s_143_2_p, eng, 'so did Bill').
sent(s_143_2_p, original, 'so did Bill').
sent(s_143_2_p, swe, 'det gjorde Bill också').

tree(s_143_3_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(speak_to_V2, [])]), t('UsePN', [t(mary_PN, [])])]), t(at_four_oclock_Adv, [])])])])])).
sent(s_143_3_p, eng, 'John spoke to Mary at four o\'clock').
sent(s_143_3_p, original, 'John spoke to Mary at four o\'clock').
sent(s_143_3_p, swe, 'John talade med Mary klockan fyra').

tree(s_143_4_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(speak_to_V2, [])]), t('UsePN', [t(mary_PN, [])])]), t(at_four_oclock_Adv, [])])])])])])).
sent(s_143_4_q, eng, 'did Bill speak to Mary at four o\'clock').
sent(s_143_4_q, original, 'did Bill speak to Mary at four o\'clock').
sent(s_143_4_q, swe, 'talade Bill med Mary klockan fyra').

tree(s_143_5_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(speak_to_V2, [])]), t('UsePN', [t(mary_PN, [])])]), t(at_four_oclock_Adv, [])])])])])).
sent(s_143_5_h, eng, 'Bill spoke to Mary at four o\'clock').
sent(s_143_5_h, original, 'Bill spoke to Mary at four o\'clock').
sent(s_143_5_h, swe, 'Bill talade med Mary klockan fyra').

tree(s_144_1_p, s_143_3_p).
sent(s_144_1_p, eng, 'John spoke to Mary at four o\'clock').
sent(s_144_1_p, original, 'John spoke to Mary at four o\'clock').
sent(s_144_1_p, swe, 'John talade med Mary klockan fyra').

tree(s_144_2_p, s_142_2_p).
sent(s_144_2_p, eng, 'so did Bill').
sent(s_144_2_p, original, 'so did Bill').
sent(s_144_2_p, swe, 'det gjorde Bill också').

tree(s_144_3_q, s_143_4_q).
sent(s_144_3_q, eng, 'did Bill speak to Mary at four o\'clock').
sent(s_144_3_q, original, 'did Bill speak to Mary at four o\'clock').
sent(s_144_3_q, swe, 'talade Bill med Mary klockan fyra').

tree(s_144_4_h, s_143_5_h).
sent(s_144_4_h, eng, 'Bill spoke to Mary at four o\'clock').
sent(s_144_4_h, original, 'Bill spoke to Mary at four o\'clock').
sent(s_144_4_h, swe, 'Bill talade med Mary klockan fyra').

tree(s_145_1_p, s_143_3_p).
sent(s_145_1_p, eng, 'John spoke to Mary at four o\'clock').
sent(s_145_1_p, original, 'John spoke to Mary at four o\'clock').
sent(s_145_1_p, swe, 'John talade med Mary klockan fyra').

tree(s_145_2_p, t('PSentence', [t(and_PConj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('AdvVP', [t('ComplVV', [t(do_VV, []), t(elliptic_VP, [])]), t(at_five_oclock_Adv, [])])])])])).
sent(s_145_2_p, eng, 'and Bill did [..] at five o\'clock').
sent(s_145_2_p, original, 'and Bill did [..] at five o\'clock').
sent(s_145_2_p, swe, 'och Bill gjorde [..] klockan fem').

tree(s_145_3_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(speak_to_V2, [])]), t('UsePN', [t(mary_PN, [])])]), t(at_five_oclock_Adv, [])])])])])])).
sent(s_145_3_q, eng, 'did Bill speak to Mary at five o\'clock').
sent(s_145_3_q, original, 'did Bill speak to Mary at five o\'clock').
sent(s_145_3_q, swe, 'talade Bill med Mary klockan fem').

tree(s_145_4_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(speak_to_V2, [])]), t('UsePN', [t(mary_PN, [])])]), t(at_five_oclock_Adv, [])])])])])).
sent(s_145_4_h, eng, 'Bill spoke to Mary at five o\'clock').
sent(s_145_4_h, original, 'Bill spoke to Mary at five o\'clock').
sent(s_145_4_h, swe, 'Bill talade med Mary klockan fem').

tree(s_146_1_p, t('Sentence', [t('UseCl', [t('PresentPerfect', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(speak_to_V2, [])]), t('UsePN', [t(mary_PN, [])])])])])])).
sent(s_146_1_p, eng, 'John has spoken to Mary').
sent(s_146_1_p, original, 'John has spoken to Mary').
sent(s_146_1_p, swe, 'John har talat med Mary').

tree(s_146_2_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('ProgrVPa', [t('ComplVV', [t(going_to_VV, []), t(elliptic_VP, [])])])])])])).
sent(s_146_2_p, eng, 'Bill is going to [..]').
sent(s_146_2_p, original, 'Bill is going to [..]').
sent(s_146_2_p, swe, 'Bill kommer att [..]').

tree(s_146_3_q, t('Question', [t('UseQCl', [t('Future', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(speak_to_V2, [])]), t('UsePN', [t(mary_PN, [])])])])])])])).
sent(s_146_3_q, eng, 'will Bill speak to Mary').
sent(s_146_3_q, original, 'will Bill speak to Mary').
sent(s_146_3_q, swe, 'ska Bill tala med Mary').

tree(s_146_4_h, t('Sentence', [t('UseCl', [t('Future', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(speak_to_V2, [])]), t('UsePN', [t(mary_PN, [])])])])])])).
sent(s_146_4_h, eng, 'Bill will speak to Mary').
sent(s_146_4_h, original, 'Bill will speak to Mary').
sent(s_146_4_h, swe, 'Bill ska tala med Mary').

tree(s_147_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(speak_to_V2, [])]), t('UsePN', [t(mary_PN, [])])]), t(on_monday_Adv, [])])])])])).
sent(s_147_1_p, eng, 'John spoke to Mary on Monday').
sent(s_147_1_p, original, 'John spoke to Mary on Monday').
sent(s_147_1_p, swe, 'John talade med Mary på måndagen').

tree(s_147_2_p, t('Sentence', [t('UseCl', [t('Past', []), t('PNeg', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t(elliptic_VP, [])])])])).
sent(s_147_2_p, eng, 'Bill didn\'t [..]').
sent(s_147_2_p, original, 'Bill didn\'t [..]').
sent(s_147_2_p, swe, 'Bill [..] inte').

tree(s_147_3_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(speak_to_V2, [])]), t('UsePN', [t(mary_PN, [])])]), t(on_monday_Adv, [])])])])])])).
sent(s_147_3_q, eng, 'did Bill speak to Mary on Monday').
sent(s_147_3_q, original, 'did Bill speak to Mary on Monday').
sent(s_147_3_q, swe, 'talade Bill med Mary på måndagen').

tree(s_147_4_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(speak_to_V2, [])]), t('UsePN', [t(mary_PN, [])])]), t(on_monday_Adv, [])])])])])).
sent(s_147_4_h, eng, 'Bill spoke to Mary on Monday').
sent(s_147_4_h, original, 'Bill spoke to Mary on Monday').
sent(s_147_4_h, swe, 'Bill talade med Mary på måndagen').

tree(s_148_1_p, t('Question', [t('UseQCl', [t('PresentPerfect', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(john_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(speak_to_V2, [])]), t('UsePN', [t(mary_PN, [])])])])])])])).
sent(s_148_1_p, eng, 'has John spoken to Mary').
sent(s_148_1_p, original, 'has John spoken to Mary').
sent(s_148_1_p, swe, 'har John talat med Mary').

tree(s_148_2_p, t('Sentence', [t('UseCl', [t('PresentPerfect', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t(elliptic_VP, [])])])])).
sent(s_148_2_p, eng, 'Bill has [..]').
sent(s_148_2_p, original, 'Bill has [..]').
sent(s_148_2_p, swe, 'Bill har [..]').

tree(s_148_3_q, t('Question', [t('UseQCl', [t('PresentPerfect', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(speak_to_V2, [])]), t('UsePN', [t(mary_PN, [])])])])])])])).
sent(s_148_3_q, eng, 'has Bill spoken to Mary').
sent(s_148_3_q, original, 'has Bill spoken to Mary').
sent(s_148_3_q, swe, 'har Bill talat med Mary').

tree(s_148_4_h, t('Sentence', [t('UseCl', [t('PresentPerfect', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(speak_to_V2, [])]), t('UsePN', [t(mary_PN, [])])])])])])).
sent(s_148_4_h, eng, 'Bill has spoken to Mary').
sent(s_148_4_h, original, 'Bill has spoken to Mary').
sent(s_148_4_h, swe, 'Bill har talat med Mary').

tree(s_149_1_p, s_146_1_p).
sent(s_149_1_p, eng, 'John has spoken to Mary').
sent(s_149_1_p, original, 'John has spoken to Mary').
sent(s_149_1_p, swe, 'John har talat med Mary').

tree(s_149_2_p, t('Sentence', [t('UseCl', [t('PresentPerfect', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumPl', [])]), t('UseN', [t(student_N, [])])]), t('AdvVP', [t(elliptic_VP, []), t(too_Adv, [])])])])])).
sent(s_149_2_p, eng, 'the students have [..] too').
sent(s_149_2_p, original, 'the students have [..] too').
sent(s_149_2_p, swe, 'studenterna har [..] också').

tree(s_149_3_q, t('Question', [t('UseQCl', [t('PresentPerfect', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumPl', [])]), t('UseN', [t(student_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(speak_to_V2, [])]), t('UsePN', [t(mary_PN, [])])])])])])])).
sent(s_149_3_q, eng, 'have the students spoken to Mary').
sent(s_149_3_q, original, 'have the students spoken to Mary').
sent(s_149_3_q, swe, 'har studenterna talat med Mary').

tree(s_149_4_h, t('Sentence', [t('UseCl', [t('PresentPerfect', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumPl', [])]), t('UseN', [t(student_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(speak_to_V2, [])]), t('UsePN', [t(mary_PN, [])])])])])])).
sent(s_149_4_h, eng, 'the students have spoken to Mary').
sent(s_149_4_h, original, 'the students have spoken to Mary').
sent(s_149_4_h, swe, 'studenterna har talat med Mary').

tree(s_150_1_p, t('Sentence', [t('ConjS2', [t(comma_and_Conj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('AdvVP', [t('AdvVP', [t('UseV', [t(go8travel_V, [])]), t('PrepNP', [t(to_Prep, []), t('UsePN', [t(paris_PN, [])])])]), t('PrepNP', [t(by8means_Prep, []), t('MassNP', [t('UseN', [t(car_N, [])])])])])])]), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('AdvVP', [t(elliptic_VP, []), t('PrepNP', [t(by8means_Prep, []), t('MassNP', [t('UseN', [t(train_N, [])])])])])])])])])).
sent(s_150_1_p, eng, 'John went to Paris by car , and Bill [..] by train').
sent(s_150_1_p, original, 'John went to Paris by car , and Bill [..] by train').
sent(s_150_1_p, swe, 'John åkte till Paris med bil , och Bill [..] med tåg').

tree(s_150_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('AdvVP', [t('AdvVP', [t('UseV', [t(go8travel_V, [])]), t('PrepNP', [t(to_Prep, []), t('UsePN', [t(paris_PN, [])])])]), t('PrepNP', [t(by8means_Prep, []), t('MassNP', [t('UseN', [t(train_N, [])])])])])])])])])).
sent(s_150_2_q, eng, 'did Bill go to Paris by train').
sent(s_150_2_q, original, 'did Bill go to Paris by train').
sent(s_150_2_q, swe, 'åkte Bill till Paris med tåg').

tree(s_150_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('AdvVP', [t('AdvVP', [t('UseV', [t(go8travel_V, [])]), t('PrepNP', [t(to_Prep, []), t('UsePN', [t(paris_PN, [])])])]), t('PrepNP', [t(by8means_Prep, []), t('MassNP', [t('UseN', [t(train_N, [])])])])])])])])).
sent(s_150_3_h, eng, 'Bill went to Paris by train').
sent(s_150_3_h, original, 'Bill went to Paris by train').
sent(s_150_3_h, swe, 'Bill åkte till Paris med tåg').

tree(s_151_1_p, t('Sentence', [t('ConjS2', [t(comma_and_Conj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('AdvVP', [t('AdvVP', [t('UseV', [t(go8travel_V, [])]), t('PrepNP', [t(to_Prep, []), t('UsePN', [t(paris_PN, [])])])]), t('PrepNP', [t(by8means_Prep, []), t('MassNP', [t('UseN', [t(car_N, [])])])])])])]), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('AdvVP', [t('AdvVP', [t(elliptic_VP, []), t('PrepNP', [t(by8means_Prep, []), t('MassNP', [t('UseN', [t(train_N, [])])])])]), t('PrepNP', [t(to_Prep, []), t('UsePN', [t(berlin_PN, [])])])])])])])])).
sent(s_151_1_p, eng, 'John went to Paris by car , and Bill [..] by train to Berlin').
sent(s_151_1_p, original, 'John went to Paris by car , and Bill [..] by train to Berlin').
sent(s_151_1_p, swe, 'John åkte till Paris med bil , och Bill [..] med tåg till Berlin').

tree(s_151_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('AdvVP', [t('AdvVP', [t('UseV', [t(go8travel_V, [])]), t('PrepNP', [t(to_Prep, []), t('UsePN', [t(berlin_PN, [])])])]), t('PrepNP', [t(by8means_Prep, []), t('MassNP', [t('UseN', [t(train_N, [])])])])])])])])])).
sent(s_151_2_q, eng, 'did Bill go to Berlin by train').
sent(s_151_2_q, original, 'did Bill go to Berlin by train').
sent(s_151_2_q, swe, 'åkte Bill till Berlin med tåg').

tree(s_151_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('AdvVP', [t('AdvVP', [t('UseV', [t(go8travel_V, [])]), t('PrepNP', [t(to_Prep, []), t('UsePN', [t(berlin_PN, [])])])]), t('PrepNP', [t(by8means_Prep, []), t('MassNP', [t('UseN', [t(train_N, [])])])])])])])])).
sent(s_151_3_h, eng, 'Bill went to Berlin by train').
sent(s_151_3_h, original, 'Bill went to Berlin by train').
sent(s_151_3_h, swe, 'Bill åkte till Berlin med tåg').

tree(s_152_1_p, t('Sentence', [t('ConjS2', [t(comma_and_Conj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('AdvVP', [t('AdvVP', [t('UseV', [t(go8travel_V, [])]), t('PrepNP', [t(to_Prep, []), t('UsePN', [t(paris_PN, [])])])]), t('PrepNP', [t(by8means_Prep, []), t('MassNP', [t('UseN', [t(car_N, [])])])])])])]), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('AdvVP', [t(elliptic_VP, []), t('PrepNP', [t(to_Prep, []), t('UsePN', [t(berlin_PN, [])])])])])])])])).
sent(s_152_1_p, eng, 'John went to Paris by car , and Bill [..] to Berlin').
sent(s_152_1_p, original, 'John went to Paris by car , and Bill [..] to Berlin').
sent(s_152_1_p, swe, 'John åkte till Paris med bil , och Bill [..] till Berlin').

tree(s_152_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('AdvVP', [t('AdvVP', [t('UseV', [t(go8travel_V, [])]), t('PrepNP', [t(to_Prep, []), t('UsePN', [t(berlin_PN, [])])])]), t('PrepNP', [t(by8means_Prep, []), t('MassNP', [t('UseN', [t(car_N, [])])])])])])])])])).
sent(s_152_2_q, eng, 'did Bill go to Berlin by car').
sent(s_152_2_q, original, 'did Bill go to Berlin by car').
sent(s_152_2_q, swe, 'åkte Bill till Berlin med bil').

tree(s_152_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('AdvVP', [t('AdvVP', [t('UseV', [t(go8travel_V, [])]), t('PrepNP', [t(to_Prep, []), t('UsePN', [t(berlin_PN, [])])])]), t('PrepNP', [t(by8means_Prep, []), t('MassNP', [t('UseN', [t(car_N, [])])])])])])])])).
sent(s_152_3_h, eng, 'Bill went to Berlin by car').
sent(s_152_3_h, original, 'Bill went to Berlin by car').
sent(s_152_3_h, swe, 'Bill åkte till Berlin med bil').

tree(s_153_1_p, t('Sentence', [t('ConjS2', [t(comma_and_Conj, []), t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('AdvVP', [t('AdvVP', [t('ProgrVPa', [t('UseV', [t(go8travel_V, [])])]), t('PrepNP', [t(to_Prep, []), t('UsePN', [t(paris_PN, [])])])]), t('PrepNP', [t(by8means_Prep, []), t('MassNP', [t('UseN', [t(car_N, [])])])])])])]), t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumPl', [])]), t('UseN', [t(student_N, [])])]), t('AdvVP', [t(elliptic_VP, []), t('PrepNP', [t(by8means_Prep, []), t('MassNP', [t('UseN', [t(train_N, [])])])])])])])])])).
sent(s_153_1_p, eng, 'John is going to Paris by car , and the students [..] by train').
sent(s_153_1_p, original, 'John is going to Paris by car , and the students [..] by train').
sent(s_153_1_p, swe, 'John åker till Paris med bil , och studenterna [..] med tåg').

tree(s_153_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumPl', [])]), t('UseN', [t(student_N, [])])]), t('AdvVP', [t('AdvVP', [t('ProgrVPa', [t('UseV', [t(go8travel_V, [])])]), t('PrepNP', [t(to_Prep, []), t('UsePN', [t(paris_PN, [])])])]), t('PrepNP', [t(by8means_Prep, []), t('MassNP', [t('UseN', [t(train_N, [])])])])])])])])])).
sent(s_153_2_q, eng, 'are the students going to Paris by train').
sent(s_153_2_q, original, 'are the students going to Paris by train').
sent(s_153_2_q, swe, 'åker studenterna till Paris med tåg').

tree(s_153_3_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumPl', [])]), t('UseN', [t(student_N, [])])]), t('AdvVP', [t('AdvVP', [t('ProgrVPa', [t('UseV', [t(go8travel_V, [])])]), t('PrepNP', [t(to_Prep, []), t('UsePN', [t(paris_PN, [])])])]), t('PrepNP', [t(by8means_Prep, []), t('MassNP', [t('UseN', [t(train_N, [])])])])])])])])).
sent(s_153_3_h, eng, 'the students are going to Paris by train').
sent(s_153_3_h, original, 'the students are going to Paris by train').
sent(s_153_3_h, swe, 'studenterna åker till Paris med tåg').

tree(s_154_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('AdvVP', [t('AdvVP', [t('UseV', [t(go8travel_V, [])]), t('PrepNP', [t(to_Prep, []), t('UsePN', [t(paris_PN, [])])])]), t('PrepNP', [t(by8means_Prep, []), t('MassNP', [t('UseN', [t(car_N, [])])])])])])])])).
sent(s_154_1_p, eng, 'John went to Paris by car').
sent(s_154_1_p, original, 'John went to Paris by car').
sent(s_154_1_p, swe, 'John åkte till Paris med bil').

tree(s_154_2_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('AdvVP', [t(elliptic_VP, []), t('PrepNP', [t(by8means_Prep, []), t('MassNP', [t('UseN', [t(train_N, [])])])])])])])])).
sent(s_154_2_p, eng, 'Bill [..] by train').
sent(s_154_2_p, original, 'Bill [..] by train').
sent(s_154_2_p, swe, 'Bill [..] med tåg').

tree(s_154_3_q, s_150_2_q).
sent(s_154_3_q, eng, 'did Bill go to Paris by train').
sent(s_154_3_q, original, 'did Bill go to Paris by train').
sent(s_154_3_q, swe, 'åkte Bill till Paris med tåg').

tree(s_154_4_h, s_150_3_h).
sent(s_154_4_h, eng, 'Bill went to Paris by train').
sent(s_154_4_h, original, 'Bill went to Paris by train').
sent(s_154_4_h, swe, 'Bill åkte till Paris med tåg').

tree(s_155_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(own_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(car_N, [])])])])])])])).
sent(s_155_1_p, eng, 'John owns a car').
sent(s_155_1_p, original, 'John owns a car').
sent(s_155_1_p, swe, 'John äger en bil').

tree(s_155_2_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(own_V2, [])]), t('DetNP', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])])])]), t(too_Adv, [])])])])])).
sent(s_155_2_p, eng, 'Bill owns one too').
sent(s_155_2_p, original, 'Bill owns one too').
sent(s_155_2_p, swe, 'Bill äger ett också').

tree(s_155_3_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(own_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(car_N, [])])])])])])])])).
sent(s_155_3_q, eng, 'does Bill own a car').
sent(s_155_3_q, original, 'does Bill own a car').
sent(s_155_3_q, swe, 'äger Bill en bil').

tree(s_155_4_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(own_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(car_N, [])])])])])])])).
sent(s_155_4_h, eng, 'Bill owns a car').
sent(s_155_4_h, original, 'Bill owns a car').
sent(s_155_4_h, swe, 'Bill äger en bil').

tree(s_156_1_p, s_155_1_p).
sent(s_156_1_p, eng, 'John owns a car').
sent(s_156_1_p, original, 'John owns a car').
sent(s_156_1_p, swe, 'John äger en bil').

tree(s_156_2_p, s_155_2_p).
sent(s_156_2_p, eng, 'Bill owns one too').
sent(s_156_2_p, original, 'Bill owns one too').
sent(s_156_2_p, swe, 'Bill äger ett också').

tree(s_156_3_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('ExistNP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('RelCN', [t('UseN', [t(car_N, [])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelSlash', [t(that_RP, []), t('SlashVP', [t('ConjNP2', [t(and_Conj, []), t('UsePN', [t(john_PN, [])]), t('UsePN', [t(bill_PN, [])])]), t('SlashV2a', [t(own_V2, [])])])])])])])])])])])).
sent(s_156_3_q, eng, 'is there a car that John and Bill own').
sent(s_156_3_q, original, 'is there a car that John and Bill own').
sent(s_156_3_q, swe, 'finns det en bil som John och Bill äger').

tree(s_156_4_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('ExistNP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('RelCN', [t('UseN', [t(car_N, [])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelSlash', [t(that_RP, []), t('SlashVP', [t('ConjNP2', [t(and_Conj, []), t('UsePN', [t(john_PN, [])]), t('UsePN', [t(bill_PN, [])])]), t('SlashV2a', [t(own_V2, [])])])])])])])])])])).
sent(s_156_4_h, eng, 'there is a car that John and Bill own').
sent(s_156_4_h, original, 'there is a car that John and Bill own').
sent(s_156_4_h, swe, 'det finns en bil som John och Bill äger').

tree(s_157_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(own_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(red_A, [])]), t('UseN', [t(car_N, [])])])])])])])])).
sent(s_157_1_p, eng, 'John owns a red car').
sent(s_157_1_p, original, 'John owns a red car').
sent(s_157_1_p, swe, 'John äger en röd bil').

tree(s_157_2_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(own_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(blue_A, [])]), t('UseN', [t(one_N, [])])])])])])])])).
sent(s_157_2_p, eng, 'Bill owns a blue one').
sent(s_157_2_p, original, 'Bill owns a blue one').
sent(s_157_2_p, swe, 'Bill äger en blå en').

tree(s_157_3_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(own_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(blue_A, [])]), t('UseN', [t(car_N, [])])])])])])])])])).
sent(s_157_3_q, eng, 'does Bill own a blue car').
sent(s_157_3_q, original, 'does Bill own a blue car').
sent(s_157_3_q, swe, 'äger Bill en blå bil').

tree(s_157_4_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(own_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(blue_A, [])]), t('UseN', [t(car_N, [])])])])])])])])).
sent(s_157_4_h, eng, 'Bill owns a blue car').
sent(s_157_4_h, original, 'Bill owns a blue car').
sent(s_157_4_h, swe, 'Bill äger en blå bil').

tree(s_158_1_p, s_157_1_p).
sent(s_158_1_p, eng, 'John owns a red car').
sent(s_158_1_p, original, 'John owns a red car').
sent(s_158_1_p, swe, 'John äger en röd bil').

tree(s_158_2_p, s_157_2_p).
sent(s_158_2_p, eng, 'Bill owns a blue one').
sent(s_158_2_p, original, 'Bill owns a blue one').
sent(s_158_2_p, swe, 'Bill äger en blå en').

tree(s_158_3_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(own_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(red_A, [])]), t('UseN', [t(car_N, [])])])])])])])])])).
sent(s_158_3_q, eng, 'does Bill own a red car').
sent(s_158_3_q, original, 'does Bill own a red car').
sent(s_158_3_q, swe, 'äger Bill en röd bil').

tree(s_158_4_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(own_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(red_A, [])]), t('UseN', [t(car_N, [])])])])])])])])).
sent(s_158_4_h, eng, 'Bill owns a red car').
sent(s_158_4_h, original, 'Bill owns a red car').
sent(s_158_4_h, swe, 'Bill äger en röd bil').

tree(s_159_1_p, s_157_1_p).
sent(s_159_1_p, eng, 'John owns a red car').
sent(s_159_1_p, original, 'John owns a red car').
sent(s_159_1_p, swe, 'John äger en röd bil').

tree(s_159_2_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(own_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(fast_A, [])]), t('UseN', [t(one_N, [])])])])])])])])).
sent(s_159_2_p, eng, 'Bill owns a fast one').
sent(s_159_2_p, original, 'Bill owns a fast one').
sent(s_159_2_p, swe, 'Bill äger en snabb en').

tree(s_159_3_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(own_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(fast_A, [])]), t('UseN', [t(car_N, [])])])])])])])])])).
sent(s_159_3_q, eng, 'does Bill own a fast car').
sent(s_159_3_q, original, 'does Bill own a fast car').
sent(s_159_3_q, swe, 'äger Bill en snabb bil').

tree(s_159_4_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(own_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(fast_A, [])]), t('UseN', [t(car_N, [])])])])])])])])).
sent(s_159_4_h, eng, 'Bill owns a fast car').
sent(s_159_4_h, original, 'Bill owns a fast car').
sent(s_159_4_h, swe, 'Bill äger en snabb bil').

tree(s_160_1_p, s_157_1_p).
sent(s_160_1_p, eng, 'John owns a red car').
sent(s_160_1_p, original, 'John owns a red car').
sent(s_160_1_p, swe, 'John äger en röd bil').

tree(s_160_2_p, s_159_2_p).
sent(s_160_2_p, eng, 'Bill owns a fast one').
sent(s_160_2_p, original, 'Bill owns a fast one').
sent(s_160_2_p, swe, 'Bill äger en snabb en').

tree(s_160_3_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(own_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(fast_A, [])]), t('AdjCN', [t('PositA', [t(red_A, [])]), t('UseN', [t(car_N, [])])])])])])])])])])).
sent(s_160_3_q, eng, 'does Bill own a fast red car').
sent(s_160_3_q, original, 'does Bill own a fast red car').
sent(s_160_3_q, swe, 'äger Bill en snabb röd bil').

tree(s_160_4_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(own_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(fast_A, [])]), t('AdjCN', [t('PositA', [t(red_A, [])]), t('UseN', [t(car_N, [])])])])])])])])])).
sent(s_160_4_h, eng, 'Bill owns a fast red car').
sent(s_160_4_h, original, 'Bill owns a fast red car').
sent(s_160_4_h, swe, 'Bill äger en snabb röd bil').

tree(s_161_1_p, s_157_1_p).
sent(s_161_1_p, eng, 'John owns a red car').
sent(s_161_1_p, original, 'John owns a red car').
sent(s_161_1_p, swe, 'John äger en röd bil').

tree(s_161_2_p, s_159_2_p).
sent(s_161_2_p, eng, 'Bill owns a fast one').
sent(s_161_2_p, original, 'Bill owns a fast one').
sent(s_161_2_p, swe, 'Bill äger en snabb en').

tree(s_161_3_q, s_160_3_q).
sent(s_161_3_q, eng, 'does Bill own a fast red car').
sent(s_161_3_q, original, 'does Bill own a fast red car').
sent(s_161_3_q, swe, 'äger Bill en snabb röd bil').

tree(s_161_4_h, s_160_4_h).
sent(s_161_4_h, eng, 'Bill owns a fast red car').
sent(s_161_4_h, original, 'Bill owns a fast red car').
sent(s_161_4_h, swe, 'Bill äger en snabb röd bil').

tree(s_162_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(own_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(fast_A, [])]), t('AdjCN', [t('PositA', [t(red_A, [])]), t('UseN', [t(car_N, [])])])])])])])])])).
sent(s_162_1_p, eng, 'John owns a fast red car').
sent(s_162_1_p, original, 'John owns a fast red car').
sent(s_162_1_p, swe, 'John äger en snabb röd bil').

tree(s_162_2_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(own_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(slow_A, [])]), t('UseN', [t(one_N, [])])])])])])])])).
sent(s_162_2_p, eng, 'Bill owns a slow one').
sent(s_162_2_p, original, 'Bill owns a slow one').
sent(s_162_2_p, swe, 'Bill äger en långsam en').

tree(s_162_3_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(own_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(slow_A, [])]), t('AdjCN', [t('PositA', [t(red_A, [])]), t('UseN', [t(car_N, [])])])])])])])])])])).
sent(s_162_3_q, eng, 'does Bill own a slow red car').
sent(s_162_3_q, original, 'does Bill own a slow red car').
sent(s_162_3_q, swe, 'äger Bill en långsam röd bil').

tree(s_162_4_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(own_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(slow_A, [])]), t('AdjCN', [t('PositA', [t(red_A, [])]), t('UseN', [t(car_N, [])])])])])])])])])).
sent(s_162_4_h, eng, 'Bill owns a slow red car').
sent(s_162_4_h, original, 'Bill owns a slow red car').
sent(s_162_4_h, swe, 'Bill äger en långsam röd bil').

tree(s_163_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('PPartNP', [t('DetCN', [t('DetQuant', [t('PossPron', [t(heRefl_Pron, [])]), t('NumSg', [])]), t('UseN', [t(paper_N, [])])]), t(accept_V2, [])])])])])])).
sent(s_163_1_p, eng, 'John had his paper accepted').
sent(s_163_1_p, original, 'John had his paper accepted').
sent(s_163_1_p, swe, 'John hade sin uppsats godkänd').

tree(s_163_2_p, t('Sentence', [t('UseCl', [t('Present', []), t('PNeg', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('ComplVQ', [t(know_VQ, []), t('UseQCl', [t('Past', []), t('PPos', []), t('QuestIAdv', [t(why_IAdv, []), t(elliptic_Cl, [])])])])])])])).
sent(s_163_2_p, eng, 'Bill doesn\'t know why [..]').
sent(s_163_2_p, original, 'Bill doesn\'t know why [..]').
sent(s_163_2_p, swe, 'Bill vet inte varför [..]').

tree(s_163_3_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('ComplVQ', [t(know_VQ, []), t('UseQCl', [t('Past', []), t('PPos', []), t('QuestIAdv', [t(why_IAdv, []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('PPartNP', [t('DetCN', [t('DetQuant', [t('PossPron', [t(heRefl_Pron, [])]), t('NumSg', [])]), t('UseN', [t(paper_N, [])])]), t(accept_V2, [])])])])])])])])])])])).
sent(s_163_3_q, eng, 'does Bill know why John had his paper accepted').
sent(s_163_3_q, original, 'does Bill know why John had his paper accepted').
sent(s_163_3_q, swe, 'vet Bill varför John hade sin uppsats godkänd').

tree(s_163_4_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('ComplVQ', [t(know_VQ, []), t('UseQCl', [t('Past', []), t('PPos', []), t('QuestIAdv', [t(why_IAdv, []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('PPartNP', [t('DetCN', [t('DetQuant', [t('PossPron', [t(heRefl_Pron, [])]), t('NumSg', [])]), t('UseN', [t(paper_N, [])])]), t(accept_V2, [])])])])])])])])])])).
sent(s_163_4_h, eng, 'Bill knows why John had his paper accepted').
sent(s_163_4_h, original, 'Bill knows why John had his paper accepted').
sent(s_163_4_h, swe, 'Bill vet varför John hade sin uppsats godkänd').

tree(s_164_1_p, s_142_1_p).
sent(s_164_1_p, eng, 'John spoke to Mary').
sent(s_164_1_p, original, 'John spoke to Mary').
sent(s_164_1_p, swe, 'John talade med Mary').

tree(s_164_2_p, t('PAdverbial', [t(and_PConj, []), t('PrepNP', [t(to_Prep, []), t('UsePN', [t(sue_PN, [])])])])).
sent(s_164_2_p, eng, 'and to Sue').
sent(s_164_2_p, original, 'and to Sue').
sent(s_164_2_p, swe, 'och till Sue').

tree(s_164_3_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(john_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(speak_to_V2, [])]), t('UsePN', [t(sue_PN, [])])])])])])])).
sent(s_164_3_q, eng, 'did John speak to Sue').
sent(s_164_3_q, original, 'did John speak to Sue').
sent(s_164_3_q, swe, 'talade John med Sue').

tree(s_164_4_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(speak_to_V2, [])]), t('UsePN', [t(sue_PN, [])])])])])])).
sent(s_164_4_h, eng, 'John spoke to Sue').
sent(s_164_4_h, original, 'John spoke to Sue').
sent(s_164_4_h, swe, 'John talade med Sue').

tree(s_165_1_p, s_142_1_p).
sent(s_165_1_p, eng, 'John spoke to Mary').
sent(s_165_1_p, original, 'John spoke to Mary').
sent(s_165_1_p, swe, 'John talade med Mary').

tree(s_165_2_p, t('Adverbial', [t(on_friday_Adv, [])])).
sent(s_165_2_p, eng, 'on Friday').
sent(s_165_2_p, original, 'on Friday').
sent(s_165_2_p, swe, 'på fredagen').

tree(s_165_3_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(john_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(speak_to_V2, [])]), t('UsePN', [t(mary_PN, [])])]), t(on_friday_Adv, [])])])])])])).
sent(s_165_3_q, eng, 'did John speak to Mary on Friday').
sent(s_165_3_q, original, 'did John speak to Mary on Friday').
sent(s_165_3_q, swe, 'talade John med Mary på fredagen').

tree(s_165_4_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(speak_to_V2, [])]), t('UsePN', [t(mary_PN, [])])]), t(on_friday_Adv, [])])])])])).
sent(s_165_4_h, eng, 'John spoke to Mary on Friday').
sent(s_165_4_h, original, 'John spoke to Mary on Friday').
sent(s_165_4_h, swe, 'John talade med Mary på fredagen').

tree(s_166_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(speak_to_V2, [])]), t('UsePN', [t(mary_PN, [])])]), t(on_thursday_Adv, [])])])])])).
sent(s_166_1_p, eng, 'John spoke to Mary on Thursday').
sent(s_166_1_p, original, 'John spoke to Mary on Thursday').
sent(s_166_1_p, swe, 'John talade med Mary på torsdagen').

tree(s_166_2_p, t('PAdverbial', [t(and_PConj, []), t(on_friday_Adv, [])])).
sent(s_166_2_p, eng, 'and on Friday').
sent(s_166_2_p, original, 'and on Friday').
sent(s_166_2_p, swe, 'och på fredagen').

tree(s_166_3_q, s_165_3_q).
sent(s_166_3_q, eng, 'did John speak to Mary on Friday').
sent(s_166_3_q, original, 'did John speak to Mary on Friday').
sent(s_166_3_q, swe, 'talade John med Mary på fredagen').

tree(s_166_4_h, s_165_4_h).
sent(s_166_4_h, eng, 'John spoke to Mary on Friday').
sent(s_166_4_h, original, 'John spoke to Mary on Friday').
sent(s_166_4_h, swe, 'John talade med Mary på fredagen').

tree(s_167_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_twenty', [])])])]), t('UseN', [t(man_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(work_in_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(sales_department_N, [])])])])])])])).
sent(s_167_1_p, eng, 'twenty men work in the sales department').
sent(s_167_1_p, original, 'twenty men work in the sales department').
sent(s_167_1_p, swe, 'tjugo män arbetar på försäljningsavdelningen').

tree(s_167_2_p, t('PNounphrase', [t(but_PConj, []), t('PredetNP', [t(only_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_one', [])])])]), t('UseN', [t(woman_N, [])])])])])).
sent(s_167_2_p, eng, 'but only one woman').
sent(s_167_2_p, original, 'but only one woman').
sent(s_167_2_p, swe, 'men bara en kvinna').

tree(s_167_3_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_two', [])])])]), t('UseN', [t(woman_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(work_in_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(sales_department_N, [])])])])])])])])).
sent(s_167_3_q, eng, 'do two women work in the sales department').
sent(s_167_3_q, original, 'do two women work in the sales department').
sent(s_167_3_q, swe, 'arbetar två kvinnor på försäljningsavdelningen').

tree(s_167_4_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_two', [])])])]), t('UseN', [t(woman_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(work_in_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(sales_department_N, [])])])])])])])).
sent(s_167_4_h, eng, 'two women work in the sales department').
sent(s_167_4_h, original, 'two women work in the sales department').
sent(s_167_4_h, swe, 'två kvinnor arbetar på försäljningsavdelningen').

tree(s_168_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_five', [])])])]), t('UseN', [t(man_N, [])])]), t('AdvVP', [t('UseV', [t(work_V, [])]), t(part_time_Adv, [])])])])])).
sent(s_168_1_p, eng, 'five men work part time').
sent(s_168_1_p, original, 'five men work part time').
sent(s_168_1_p, swe, 'fem män arbetar deltid').

tree(s_168_2_p, t('PNounphrase', [t(and_PConj, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_fortyfive', [])])])]), t('UseN', [t(woman_N, [])])])])).
sent(s_168_2_p, eng, 'and forty five women').
sent(s_168_2_p, original, 'and forty five women').
sent(s_168_2_p, swe, 'och fyrtiofem kvinnor').

tree(s_168_3_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_fortyfive', [])])])]), t('UseN', [t(woman_N, [])])]), t('AdvVP', [t('UseV', [t(work_V, [])]), t(part_time_Adv, [])])])])])])).
sent(s_168_3_q, eng, 'do forty five women work part time').
sent(s_168_3_q, original, 'do forty five women work part time').
sent(s_168_3_q, swe, 'arbetar fyrtiofem kvinnor deltid').

tree(s_168_4_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_fortyfive', [])])])]), t('UseN', [t(woman_N, [])])]), t('AdvVP', [t('UseV', [t(work_V, [])]), t(part_time_Adv, [])])])])])).
sent(s_168_4_h, eng, 'forty five women work part time').
sent(s_168_4_h, original, 'forty five women work part time').
sent(s_168_4_h, swe, 'fyrtiofem kvinnor arbetar deltid').

tree(s_169_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(find_V2, [])]), t('UsePN', [t(mary_PN, [])])]), t('PrepNP', [t(before_Prep, []), t('UsePN', [t(bill_PN, [])])])])])])])).
sent(s_169_1_p, eng, 'John found Mary before Bill').
sent(s_169_1_p, original, 'John found Mary before Bill').
sent(s_169_1_p, swe, 'John hittade Mary före Bill').

tree(s_169_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(john_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(find_V2, [])]), t('UsePN', [t(mary_PN, [])])]), t('SubjS', [t(before_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(find_V2, [])]), t('UsePN', [t(mary_PN, [])])])])])])])])])])])).
sent(s_169_2_q, eng, 'did John find Mary before Bill found Mary').
sent(s_169_2_q, original, 'did John find Mary before Bill found Mary').
sent(s_169_2_q, swe, 'hittade John Mary innan Bill hittade Mary').

tree(s_169_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(find_V2, [])]), t('UsePN', [t(mary_PN, [])])]), t('SubjS', [t(before_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(find_V2, [])]), t('UsePN', [t(mary_PN, [])])])])])])])])])])).
sent(s_169_3_h, eng, 'John found Mary before Bill found Mary').
sent(s_169_3_h, original, 'John found Mary before Bill found Mary').
sent(s_169_3_h, swe, 'John hittade Mary innan Bill hittade Mary').

tree(s_170_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(find_V2, [])]), t('AdvNP', [t('UsePN', [t(mary_PN, [])]), t('PrepNP', [t(before_Prep, []), t('UsePN', [t(bill_PN, [])])])])])])])])).
sent(s_170_1_p, eng, 'John found Mary before Bill').
sent(s_170_1_p, original, 'John found Mary before Bill').
sent(s_170_1_p, swe, 'John hittade Mary före Bill').

tree(s_170_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(john_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(find_V2, [])]), t('UsePN', [t(mary_PN, [])])]), t('SubjS', [t(before_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(find_V2, [])]), t('UsePN', [t(bill_PN, [])])])])])])])])])])])).
sent(s_170_2_q, eng, 'did John find Mary before John found Bill').
sent(s_170_2_q, original, 'did John find Mary before John found Bill').
sent(s_170_2_q, swe, 'hittade John Mary innan John hittade Bill').

tree(s_170_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(find_V2, [])]), t('UsePN', [t(mary_PN, [])])]), t('SubjS', [t(before_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(find_V2, [])]), t('UsePN', [t(bill_PN, [])])])])])])])])])])).
sent(s_170_3_h, eng, 'John found Mary before John found Bill').
sent(s_170_3_h, original, 'John found Mary before John found Bill').
sent(s_170_3_h, swe, 'John hittade Mary innan John hittade Bill').

tree(s_171_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('ComplVV', [t(want_VV, []), t('ComplVQ', [t(know_VQ, []), t('UseQCl', [t('Present', []), t('PPos', []), t('QuestVP', [t('IdetCN', [t(how8many_IDet, []), t('UseN', [t(man_N, [])])]), t('AdvVP', [t('UseV', [t(work_V, [])]), t(part_time_Adv, [])])])])])])])])])).
sent(s_171_1_p, eng, 'John wants to know how many men work part time').
sent(s_171_1_p, original, 'John wants to know how many men work part time').
sent(s_171_1_p, swe, 'John vill veta hur många män som arbetar deltid').

tree(s_171_2_p, t('PNounphrase', [t(and_PConj, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('UseN', [t(woman_N, [])])])])).
sent(s_171_2_p, eng, 'and women').
sent(s_171_2_p, original, 'and women').
sent(s_171_2_p, swe, 'och kvinnor').

tree(s_171_3_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(john_PN, [])]), t('ComplVV', [t(want_VV, []), t('ComplVQ', [t(know_VQ, []), t('UseQCl', [t('Present', []), t('PPos', []), t('QuestVP', [t('IdetCN', [t(how8many_IDet, []), t('UseN', [t(woman_N, [])])]), t('AdvVP', [t('UseV', [t(work_V, [])]), t(part_time_Adv, [])])])])])])])])])])).
sent(s_171_3_q, eng, 'does John want to know how many women work part time').
sent(s_171_3_q, original, 'does John want to know how many women work part time').
sent(s_171_3_q, swe, 'vill John veta hur många kvinnor som arbetar deltid').

tree(s_171_4_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('ComplVV', [t(want_VV, []), t('ComplVQ', [t(know_VQ, []), t('UseQCl', [t('Present', []), t('PPos', []), t('QuestVP', [t('IdetCN', [t(how8many_IDet, []), t('UseN', [t(woman_N, [])])]), t('AdvVP', [t('UseV', [t(work_V, [])]), t(part_time_Adv, [])])])])])])])])])).
sent(s_171_4_h, eng, 'John wants to know how many women work part time').
sent(s_171_4_h, original, 'John wants to know how many women work part time').
sent(s_171_4_h, swe, 'John vill veta hur många kvinnor som arbetar deltid').

tree(s_172_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('ComplVV', [t(want_VV, []), t('ComplVQ', [t(know_VQ, []), t('ConjQS2', [t(comma_and_Conj, []), t('UseQCl', [t('Present', []), t('PPos', []), t('QuestVP', [t('IdetCN', [t(how8many_IDet, []), t('UseN', [t(man_N, [])])]), t('AdvVP', [t('UseV', [t(work_V, [])]), t(part_time_Adv, [])])])]), t('UseQCl', [t('Present', []), t('PPos', []), t('QuestVP', [t('IdetCN', [t('IdetQuant', [t(which_IQuant, []), t('NumPl', [])]), t(elliptic_CN, [])]), t(elliptic_VP, [])])])])])])])])])).
sent(s_172_1_p, eng, 'John wants to know which [..] [..] , and which [..] [..]').
sent(s_172_1_p, original, 'John wants to know how many men work part time , and which [..] [..]').
sent(s_172_1_p, swe, 'John vill veta vilka [..] som [..] , och vilka [..] som [..]').

tree(s_172_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(john_PN, [])]), t('ComplVV', [t(want_VV, []), t('ComplVQ', [t(know_VQ, []), t('UseQCl', [t('Present', []), t('PPos', []), t('QuestVP', [t('IdetCN', [t('IdetQuant', [t(which_IQuant, []), t('NumPl', [])]), t('UseN', [t(man_N, [])])]), t('AdvVP', [t('UseV', [t(work_V, [])]), t(part_time_Adv, [])])])])])])])])])])).
sent(s_172_2_q, eng, 'does John want to know which men work part time').
sent(s_172_2_q, original, 'does John want to know which men work part time').
sent(s_172_2_q, swe, 'vill John veta vilka män som arbetar deltid').

tree(s_172_3_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('ComplVV', [t(want_VV, []), t('ComplVQ', [t(know_VQ, []), t('UseQCl', [t('Present', []), t('PPos', []), t('QuestVP', [t('IdetCN', [t('IdetQuant', [t(which_IQuant, []), t('NumPl', [])]), t('UseN', [t(man_N, [])])]), t('AdvVP', [t('UseV', [t(work_V, [])]), t(part_time_Adv, [])])])])])])])])])).
sent(s_172_3_h, eng, 'John wants to know which men work part time').
sent(s_172_3_h, original, 'John wants to know which men work part time').
sent(s_172_3_h, swe, 'John vill veta vilka män som arbetar deltid').

tree(s_173_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(speak_to_V2, [])]), t('RelNPa', [t('UsePron', [t(everyone_Pron, [])]), t('UseRCl', [t('Past', []), t('PPos', []), t('StrandRelSlash', [t(that_RP, []), t('SlashVP', [t('UsePN', [t(john_PN, [])]), t('SlashVV', [t(do_VV, []), t(elliptic_VPSlash, [])])])])])])])])])])).
sent(s_173_1_p, eng, 'Bill spoke to everyone that John did [..]').
sent(s_173_1_p, original, 'Bill spoke to everyone that John did [..]').
sent(s_173_1_p, swe, 'Bill talade med alla som John gjorde [..] [..]').

tree(s_173_2_p, s_142_1_p).
sent(s_173_2_p, eng, 'John spoke to Mary').
sent(s_173_2_p, original, 'John spoke to Mary').
sent(s_173_2_p, swe, 'John talade med Mary').

tree(s_173_3_q, s_142_3_q).
sent(s_173_3_q, eng, 'did Bill speak to Mary').
sent(s_173_3_q, original, 'did Bill speak to Mary').
sent(s_173_3_q, swe, 'talade Bill med Mary').

tree(s_173_4_h, s_142_4_h).
sent(s_173_4_h, eng, 'Bill spoke to Mary').
sent(s_173_4_h, original, 'Bill spoke to Mary').
sent(s_173_4_h, swe, 'Bill talade med Mary').

tree(s_174_1_p, s_173_1_p).
sent(s_174_1_p, eng, 'Bill spoke to everyone that John did [..]').
sent(s_174_1_p, original, 'Bill spoke to everyone that John did [..]').
sent(s_174_1_p, swe, 'Bill talade med alla som John gjorde [..] [..]').

tree(s_174_2_p, s_142_4_h).
sent(s_174_2_p, eng, 'Bill spoke to Mary').
sent(s_174_2_p, original, 'Bill spoke to Mary').
sent(s_174_2_p, swe, 'Bill talade med Mary').

tree(s_174_3_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(john_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(speak_to_V2, [])]), t('UsePN', [t(mary_PN, [])])])])])])])).
sent(s_174_3_q, eng, 'did John speak to Mary').
sent(s_174_3_q, original, 'did John speak to Mary').
sent(s_174_3_q, swe, 'talade John med Mary').

tree(s_174_4_h, s_142_1_p).
sent(s_174_4_h, eng, 'John spoke to Mary').
sent(s_174_4_h, original, 'John spoke to Mary').
sent(s_174_4_h, swe, 'John talade med Mary').

tree(s_175_1_p, t('Sentence', [t('ConjS2', [t(comma_and_Conj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('ComplVSa', [t(say_VS, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(mary_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])])])])])])]), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('AdvVP', [t('ComplVV', [t(do_VV, []), t(elliptic_VP, [])]), t(too_Adv, [])])])])])])).
sent(s_175_1_p, eng, 'John said Mary wrote a report , and Bill did [..] too').
sent(s_175_1_p, original, 'John said Mary wrote a report , and Bill did [..] too').
sent(s_175_1_p, swe, 'John sade att Mary skrev en rapport , och Bill gjorde [..] också').

tree(s_175_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('ComplVSa', [t(say_VS, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(mary_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])])])])])])])])])).
sent(s_175_2_q, eng, 'did Bill say Mary wrote a report').
sent(s_175_2_q, original, 'did Bill say Mary wrote a report').
sent(s_175_2_q, swe, 'sade Bill att Mary skrev en rapport').

tree(s_175_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('ComplVSa', [t(say_VS, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(mary_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])])])])])])])])).
sent(s_175_3_h, eng, 'Bill said Mary wrote a report').
sent(s_175_3_h, original, 'Bill said Mary wrote a report').
sent(s_175_3_h, swe, 'Bill sade att Mary skrev en rapport').

tree(s_176_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('ComplVSa', [t(say_VS, []), t('ConjS2', [t(comma_and_Conj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(mary_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])])])]), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('AdvVP', [t('ComplVV', [t(do_VV, []), t(elliptic_VP, [])]), t(too_Adv, [])])])])])])])])])).
sent(s_176_1_p, eng, 'John said Mary wrote a report , and Bill did [..] too').
sent(s_176_1_p, original, 'John said Mary wrote a report , and Bill did [..] too').
sent(s_176_1_p, swe, 'John sade att Mary skrev en rapport , och Bill gjorde [..] också').

tree(s_176_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(john_PN, [])]), t('ComplVSa', [t(say_VS, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])])])])])])])])])).
sent(s_176_2_q, eng, 'did John say Bill wrote a report').
sent(s_176_2_q, original, 'did John say Bill wrote a report').
sent(s_176_2_q, swe, 'sade John att Bill skrev en rapport').

tree(s_176_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('ComplVSa', [t(say_VS, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])])])])])])])])).
sent(s_176_3_h, eng, 'John said Bill wrote a report').
sent(s_176_3_h, original, 'John said Bill wrote a report').
sent(s_176_3_h, swe, 'John sade att Bill skrev en rapport').

sent(s_177_1_p, original, 'John said that Mary wrote a report , and that Bill did [..] too').

tree(s_177_1_p_NEW, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('ComplVS', [t(say_VS, []), t('PredVPS', [t('UsePN', [t(mary_PN, [])]), t('ConjVPS2', [t(comma_and_Conj, []), t('Past', []), t('PPos', []), t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])]), t('Past', []), t('PPos', []), t('ComplVS', [t(say_VS, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('AdvVP', [t('ComplVV', [t(do_VV, []), t(elliptic_VP, [])]), t(too_Adv, [])])])])])])])])])])])).
sent(s_177_1_p_NEW, eng, 'John said that Mary wrote a report , and said that Bill did [..] too').
sent(s_177_1_p_NEW, original, 'John said that Mary wrote a report , and said that Bill did [..] too').
sent(s_177_1_p_NEW, swe, 'John sade att Mary skrev en rapport , och sade att Bill gjorde [..] också').

tree(s_177_2_q, s_175_2_q).
sent(s_177_2_q, eng, 'did Bill say Mary wrote a report').
sent(s_177_2_q, original, 'did Bill say Mary wrote a report').
sent(s_177_2_q, swe, 'sade Bill att Mary skrev en rapport').

tree(s_177_3_h, s_175_3_h).
sent(s_177_3_h, eng, 'Bill said Mary wrote a report').
sent(s_177_3_h, original, 'Bill said Mary wrote a report').
sent(s_177_3_h, swe, 'Bill sade att Mary skrev en rapport').

tree(s_178_1_p, t('Sentence', [t('ConjS2', [t(comma_and_Conj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])])])]), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('AdvVP', [t('ComplVSa', [t(say_VS, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(peter_PN, [])]), t('ComplVV', [t(do_VV, []), t(elliptic_VP, [])])])])]), t(too_Adv, [])])])])])])).
sent(s_178_1_p, eng, 'John wrote a report , and Bill said Peter did [..] too').
sent(s_178_1_p, original, 'John wrote a report , and Bill said Peter did [..] too').
sent(s_178_1_p, swe, 'John skrev en rapport , och Bill sade att Peter gjorde [..] också').

tree(s_178_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('ComplVSa', [t(say_VS, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(peter_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])])])])])])])])])).
sent(s_178_2_q, eng, 'did Bill say Peter wrote a report').
sent(s_178_2_q, original, 'did Bill say Peter wrote a report').
sent(s_178_2_q, swe, 'sade Bill att Peter skrev en rapport').

tree(s_178_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('ComplVSa', [t(say_VS, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(peter_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])])])])])])])])).
sent(s_178_3_h, eng, 'Bill said Peter wrote a report').
sent(s_178_3_h, original, 'Bill said Peter wrote a report').
sent(s_178_3_h, swe, 'Bill sade att Peter skrev en rapport').

tree(s_179_1_p, t('Sentence', [t('ConjS2', [t(if_comma_then_Conj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])])])]), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('AdvVP', [t('ComplVV', [t(do_VV, []), t(elliptic_VP, [])]), t(too_Adv, [])])])])])])).
sent(s_179_1_p, eng, 'if John wrote a report , then Bill did [..] too').
sent(s_179_1_p, original, 'if John wrote a report , then Bill did [..] too').
sent(s_179_1_p, swe, 'om John skrev en rapport så Bill gjorde [..] också').

tree(s_179_2_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])])])])])).
sent(s_179_2_p, eng, 'John wrote a report').
sent(s_179_2_p, original, 'John wrote a report').
sent(s_179_2_p, swe, 'John skrev en rapport').

tree(s_179_3_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])])])])])])).
sent(s_179_3_q, eng, 'did Bill write a report').
sent(s_179_3_q, original, 'did Bill write a report').
sent(s_179_3_q, swe, 'skrev Bill en rapport').

tree(s_179_4_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])])])])])).
sent(s_179_4_h, eng, 'Bill wrote a report').
sent(s_179_4_h, original, 'Bill wrote a report').
sent(s_179_4_h, swe, 'Bill skrev en rapport').

tree(s_180_1_p, t('Sentence', [t('ConjS2', [t(comma_and_Conj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('ComplVV', [t(want_VV, []), t('ComplSlash', [t('SlashV2a', [t(buy_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(car_N, [])])])])])])]), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePron', [t(he_Pron, [])]), t('ComplVV', [t(do_VV, []), t(elliptic_VP, [])])])])])])).
sent(s_180_1_p, eng, 'John wanted to buy a car , and he did [..]').
sent(s_180_1_p, original, 'John wanted to buy a car , and he did [..]').
sent(s_180_1_p, swe, 'John ville köpa en bil , och han gjorde [..]').

tree(s_180_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(john_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(buy_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(car_N, [])])])])])])])])).
sent(s_180_2_q, eng, 'did John buy a car').
sent(s_180_2_q, original, 'did John buy a car').
sent(s_180_2_q, swe, 'köpte John en bil').

tree(s_180_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(buy_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(car_N, [])])])])])])])).
sent(s_180_3_h, eng, 'John bought a car').
sent(s_180_3_h, original, 'John bought a car').
sent(s_180_3_h, swe, 'John köpte en bil').

tree(s_181_1_p, t('Sentence', [t('ConjS2', [t(comma_and_Conj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('ComplVV', [t(need_VV, []), t('ComplSlash', [t('SlashV2a', [t(buy_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(car_N, [])])])])])])]), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('ComplVV', [t(do_VV, []), t(elliptic_VP, [])])])])])])).
sent(s_181_1_p, eng, 'John needed to buy a car , and Bill did [..]').
sent(s_181_1_p, original, 'John needed to buy a car , and Bill did [..]').
sent(s_181_1_p, swe, 'John behövde köpa en bil , och Bill gjorde [..]').

tree(s_181_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(buy_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(car_N, [])])])])])])])])).
sent(s_181_2_q, eng, 'did Bill buy a car').
sent(s_181_2_q, original, 'did Bill buy a car').
sent(s_181_2_q, swe, 'köpte Bill en bil').

tree(s_181_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(buy_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(car_N, [])])])])])])])).
sent(s_181_3_h, eng, 'Bill bought a car').
sent(s_181_3_h, original, 'Bill bought a car').
sent(s_181_3_h, swe, 'Bill köpte en bil').

tree(s_182_1_p, t('Sentence', [t('ConjS2', [t(and_Conj, []), t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(represent_V2, [])]), t('DetCN', [t('DetQuant', [t('PossPron', [t(heRefl_Pron, [])]), t('NumSg', [])]), t('UseN', [t(company_N, [])])])])])]), t('UseCl', [t('Present', []), t('PPos', []), t('SoDoI', [t('UsePN', [t(jones_PN, [])])])])])])).
sent(s_182_1_p, eng, 'Smith represents his company and so does Jones').
sent(s_182_1_p, original, 'Smith represents his company and so does Jones').
sent(s_182_1_p, swe, 'Smith representerar sitt företag och det gör Jones också').

tree(s_182_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(represent_V2, [])]), t('DetCN', [t('DetQuant', [t('GenNP', [t('UsePN', [t(jones_PN, [])])]), t('NumSg', [])]), t('UseN', [t(company_N, [])])])])])])])])).
sent(s_182_2_q, eng, 'does Jones represent Jones\' company').
sent(s_182_2_q, original, 'does Jones represent Jones\' company').
sent(s_182_2_q, swe, 'representerar Jones Jones företag').

tree(s_182_3_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(represent_V2, [])]), t('DetCN', [t('DetQuant', [t('GenNP', [t('UsePN', [t(jones_PN, [])])]), t('NumSg', [])]), t('UseN', [t(company_N, [])])])])])])])).
sent(s_182_3_h, eng, 'Jones represents Jones\' company').
sent(s_182_3_h, original, 'Jones represents Jones\' company').
sent(s_182_3_h, swe, 'Jones representerar Jones företag').

tree(s_183_1_p, s_182_1_p).
sent(s_183_1_p, eng, 'Smith represents his company and so does Jones').
sent(s_183_1_p, original, 'Smith represents his company and so does Jones').
sent(s_183_1_p, swe, 'Smith representerar sitt företag och det gör Jones också').

tree(s_183_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(represent_V2, [])]), t('DetCN', [t('DetQuant', [t('GenNP', [t('UsePN', [t(smith_PN, [])])]), t('NumSg', [])]), t('UseN', [t(company_N, [])])])])])])])])).
sent(s_183_2_q, eng, 'does Jones represent Smith\'s company').
sent(s_183_2_q, original, 'does Jones represent Smith\'s company').
sent(s_183_2_q, swe, 'representerar Jones Smiths företag').

tree(s_183_3_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(represent_V2, [])]), t('DetCN', [t('DetQuant', [t('GenNP', [t('UsePN', [t(smith_PN, [])])]), t('NumSg', [])]), t('UseN', [t(company_N, [])])])])])])])).
sent(s_183_3_h, eng, 'Jones represents Smith\'s company').
sent(s_183_3_h, original, 'Jones represents Smith\'s company').
sent(s_183_3_h, swe, 'Jones representerar Smiths företag').

tree(s_184_1_p, s_182_1_p).
sent(s_184_1_p, eng, 'Smith represents his company and so does Jones').
sent(s_184_1_p, original, 'Smith represents his company and so does Jones').
sent(s_184_1_p, swe, 'Smith representerar sitt företag och det gör Jones också').

tree(s_184_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(represent_V2, [])]), t('DetCN', [t('DetQuant', [t('GenNP', [t('UsePN', [t(jones_PN, [])])]), t('NumSg', [])]), t('UseN', [t(company_N, [])])])])])])])])).
sent(s_184_2_q, eng, 'does Smith represent Jones\' company').
sent(s_184_2_q, original, 'does Smith represent Jones\' company').
sent(s_184_2_q, swe, 'representerar Smith Jones företag').

tree(s_184_3_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(represent_V2, [])]), t('DetCN', [t('DetQuant', [t('GenNP', [t('UsePN', [t(jones_PN, [])])]), t('NumSg', [])]), t('UseN', [t(company_N, [])])])])])])])).
sent(s_184_3_h, eng, 'Smith represents Jones\' company').
sent(s_184_3_h, original, 'Smith represents Jones\' company').
sent(s_184_3_h, swe, 'Smith representerar Jones företag').

tree(s_185_1_p, t('Sentence', [t('ConjS2', [t(and_Conj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplVSa', [t(claim_VS, []), t('UseCl', [t('PastPerfect', []), t('PPos', []), t('PredVP', [t('UsePron', [t(he_Pron, [])]), t('ComplSlash', [t('SlashV2a', [t(cost_V2, [])]), t('DetCN', [t('DetQuant', [t('PossPron', [t(heRefl_Pron, [])]), t('NumSg', [])]), t('UseN', [t(proposal_N, [])])])])])])])])]), t('UseCl', [t('Past', []), t('PPos', []), t('SoDoI', [t('UsePN', [t(jones_PN, [])])])])])])).
sent(s_185_1_p, eng, 'Smith claimed he had costed his proposal and so did Jones').
sent(s_185_1_p, original, 'Smith claimed he had costed his proposal and so did Jones').
sent(s_185_1_p, swe, 'Smith påstod att han hade kostnadsberäknat sitt förslag och det gjorde Jones också').

tree(s_185_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('ComplVSa', [t(claim_VS, []), t('UseCl', [t('PastPerfect', []), t('PPos', []), t('PredVP', [t('UsePron', [t(he_Pron, [])]), t('ComplSlash', [t('SlashV2a', [t(cost_V2, [])]), t('DetCN', [t('DetQuant', [t('PossPron', [t(heRefl_Pron, [])]), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(own_A, [])]), t('UseN', [t(proposal_N, [])])])])])])])])])])])])).
sent(s_185_2_q, eng, 'did Jones claim he had costed his own proposal').
sent(s_185_2_q, original, 'did Jones claim he had costed his own proposal').
sent(s_185_2_q, swe, 'påstod Jones att han hade kostnadsberäknat sitt egna förslag').

tree(s_185_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('ComplVSa', [t(claim_VS, []), t('UseCl', [t('PastPerfect', []), t('PPos', []), t('PredVP', [t('UsePron', [t(he_Pron, [])]), t('ComplSlash', [t('SlashV2a', [t(cost_V2, [])]), t('DetCN', [t('DetQuant', [t('PossPron', [t(heRefl_Pron, [])]), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(own_A, [])]), t('UseN', [t(proposal_N, [])])])])])])])])])])])).
sent(s_185_3_h, eng, 'Jones claimed he had costed his own proposal').
sent(s_185_3_h, original, 'Jones claimed he had costed his own proposal').
sent(s_185_3_h, swe, 'Jones påstod att han hade kostnadsberäknat sitt egna förslag').

tree(s_186_1_p, s_185_1_p).
sent(s_186_1_p, eng, 'Smith claimed he had costed his proposal and so did Jones').
sent(s_186_1_p, original, 'Smith claimed he had costed his proposal and so did Jones').
sent(s_186_1_p, swe, 'Smith påstod att han hade kostnadsberäknat sitt förslag och det gjorde Jones också').

tree(s_186_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('ComplVSa', [t(claim_VS, []), t('UseCl', [t('PastPerfect', []), t('PPos', []), t('PredVP', [t('UsePron', [t(he_Pron, [])]), t('ComplSlash', [t('SlashV2a', [t(cost_V2, [])]), t('DetCN', [t('DetQuant', [t('GenNP', [t('UsePN', [t(smith_PN, [])])]), t('NumSg', [])]), t('UseN', [t(proposal_N, [])])])])])])])])])])])).
sent(s_186_2_q, eng, 'did Jones claim he had costed Smith\'s proposal').
sent(s_186_2_q, original, 'did Jones claim he had costed Smith\'s proposal').
sent(s_186_2_q, swe, 'påstod Jones att han hade kostnadsberäknat Smiths förslag').

tree(s_186_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('ComplVSa', [t(claim_VS, []), t('UseCl', [t('PastPerfect', []), t('PPos', []), t('PredVP', [t('UsePron', [t(he_Pron, [])]), t('ComplSlash', [t('SlashV2a', [t(cost_V2, [])]), t('DetCN', [t('DetQuant', [t('GenNP', [t('UsePN', [t(smith_PN, [])])]), t('NumSg', [])]), t('UseN', [t(proposal_N, [])])])])])])])])])])).
sent(s_186_3_h, eng, 'Jones claimed he had costed Smith\'s proposal').
sent(s_186_3_h, original, 'Jones claimed he had costed Smith\'s proposal').
sent(s_186_3_h, swe, 'Jones påstod att han hade kostnadsberäknat Smiths förslag').

tree(s_187_1_p, s_185_1_p).
sent(s_187_1_p, eng, 'Smith claimed he had costed his proposal and so did Jones').
sent(s_187_1_p, original, 'Smith claimed he had costed his proposal and so did Jones').
sent(s_187_1_p, swe, 'Smith påstod att han hade kostnadsberäknat sitt förslag och det gjorde Jones också').

tree(s_187_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('ComplVSa', [t(claim_VS, []), t('UseCl', [t('PastPerfect', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(cost_V2, [])]), t('DetCN', [t('DetQuant', [t('GenNP', [t('UsePN', [t(smith_PN, [])])]), t('NumSg', [])]), t('UseN', [t(proposal_N, [])])])])])])])])])])])).
sent(s_187_2_q, eng, 'did Jones claim Smith had costed Smith\'s proposal').
sent(s_187_2_q, original, 'did Jones claim Smith had costed Smith\'s proposal').
sent(s_187_2_q, swe, 'påstod Jones att Smith hade kostnadsberäknat Smiths förslag').

tree(s_187_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('ComplVSa', [t(claim_VS, []), t('UseCl', [t('PastPerfect', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(cost_V2, [])]), t('DetCN', [t('DetQuant', [t('GenNP', [t('UsePN', [t(smith_PN, [])])]), t('NumSg', [])]), t('UseN', [t(proposal_N, [])])])])])])])])])])).
sent(s_187_3_h, eng, 'Jones claimed Smith had costed Smith\'s proposal').
sent(s_187_3_h, original, 'Jones claimed Smith had costed Smith\'s proposal').
sent(s_187_3_h, swe, 'Jones påstod att Smith hade kostnadsberäknat Smiths förslag').

tree(s_188_1_p, s_185_1_p).
sent(s_188_1_p, eng, 'Smith claimed he had costed his proposal and so did Jones').
sent(s_188_1_p, original, 'Smith claimed he had costed his proposal and so did Jones').
sent(s_188_1_p, swe, 'Smith påstod att han hade kostnadsberäknat sitt förslag och det gjorde Jones också').

tree(s_188_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('ComplVSa', [t(claim_VS, []), t('UseCl', [t('PastPerfect', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(cost_V2, [])]), t('DetCN', [t('DetQuant', [t('GenNP', [t('UsePN', [t(jones_PN, [])])]), t('NumSg', [])]), t('UseN', [t(proposal_N, [])])])])])])])])])])])).
sent(s_188_2_q, eng, 'did Jones claim Smith had costed Jones\' proposal').
sent(s_188_2_q, original, 'did Jones claim Smith had costed Jones\' proposal').
sent(s_188_2_q, swe, 'påstod Jones att Smith hade kostnadsberäknat Jones förslag').

tree(s_188_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('ComplVSa', [t(claim_VS, []), t('UseCl', [t('PastPerfect', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(cost_V2, [])]), t('DetCN', [t('DetQuant', [t('GenNP', [t('UsePN', [t(jones_PN, [])])]), t('NumSg', [])]), t('UseN', [t(proposal_N, [])])])])])])])])])])).
sent(s_188_3_h, eng, 'Jones claimed Smith had costed Jones\' proposal').
sent(s_188_3_h, original, 'Jones claimed Smith had costed Jones\' proposal').
sent(s_188_3_h, swe, 'Jones påstod att Smith hade kostnadsberäknat Jones förslag').

tree(s_189_1_p, t('Sentence', [t('ConjS2', [t(and_Conj, []), t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('UseComp', [t('CompCN', [t('UseN', [t(man_N, [])])])])])]), t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(mary_PN, [])]), t('UseComp', [t('CompCN', [t('UseN', [t(woman_N, [])])])])])])])])).
sent(s_189_1_p, eng, 'John is a man and Mary is a woman').
sent(s_189_1_p, original, 'John is a man and Mary is a woman').
sent(s_189_1_p, swe, 'John är en man och Mary är en kvinna').

tree(s_189_2_p, t('Sentence', [t('ConjS2', [t(and_Conj, []), t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(represent_V2, [])]), t('DetCN', [t('DetQuant', [t('PossPron', [t(heRefl_Pron, [])]), t('NumSg', [])]), t('UseN', [t(company_N, [])])])])])]), t('UseCl', [t('Present', []), t('PPos', []), t('SoDoI', [t('UsePN', [t(mary_PN, [])])])])])])).
sent(s_189_2_p, eng, 'John represents his company and so does Mary').
sent(s_189_2_p, original, 'John represents his company and so does Mary').
sent(s_189_2_p, swe, 'John representerar sitt företag och det gör Mary också').

tree(s_189_3_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(mary_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(represent_V2, [])]), t('DetCN', [t('DetQuant', [t('PossPron', [t(sheRefl_Pron, [])]), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(own_A, [])]), t('UseN', [t(company_N, [])])])])])])])])])).
sent(s_189_3_q, eng, 'does Mary represent her own company').
sent(s_189_3_q, original, 'does Mary represent her own company').
sent(s_189_3_q, swe, 'representerar Mary sitt egna företag').

tree(s_189_4_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(mary_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(represent_V2, [])]), t('DetCN', [t('DetQuant', [t('PossPron', [t(sheRefl_Pron, [])]), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(own_A, [])]), t('UseN', [t(company_N, [])])])])])])])])).
sent(s_189_4_h, eng, 'Mary represents her own company').
sent(s_189_4_h, original, 'Mary represents her own company').
sent(s_189_4_h, swe, 'Mary representerar sitt egna företag').

tree(s_190_1_p, s_189_1_p).
sent(s_190_1_p, eng, 'John is a man and Mary is a woman').
sent(s_190_1_p, original, 'John is a man and Mary is a woman').
sent(s_190_1_p, swe, 'John är en man och Mary är en kvinna').

tree(s_190_2_p, s_189_2_p).
sent(s_190_2_p, eng, 'John represents his company and so does Mary').
sent(s_190_2_p, original, 'John represents his company and so does Mary').
sent(s_190_2_p, swe, 'John representerar sitt företag och det gör Mary också').

tree(s_190_3_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(mary_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(represent_V2, [])]), t('DetCN', [t('DetQuant', [t('GenNP', [t('UsePN', [t(john_PN, [])])]), t('NumSg', [])]), t('UseN', [t(company_N, [])])])])])])])])).
sent(s_190_3_q, eng, 'does Mary represent John\'s company').
sent(s_190_3_q, original, 'does Mary represent John\'s company').
sent(s_190_3_q, swe, 'representerar Mary Johns företag').

tree(s_190_4_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(mary_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(represent_V2, [])]), t('DetCN', [t('DetQuant', [t('GenNP', [t('UsePN', [t(john_PN, [])])]), t('NumSg', [])]), t('UseN', [t(company_N, [])])])])])])])).
sent(s_190_4_h, eng, 'Mary represents John\'s company').
sent(s_190_4_h, original, 'Mary represents John\'s company').
sent(s_190_4_h, swe, 'Mary representerar Johns företag').

tree(s_191_1_p, t('Sentence', [t('ConjS2', [t(comma_and_Conj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(bill_PN, [])]), t('ComplSlash', [t('SlashV2S', [t(suggest_to_V2S, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePron', [t(they_Pron, [])]), t('ComplVV', [t(shall_VV, []), t('AdvVP', [t('AdvVP', [t('UseV', [t(go8walk_V, [])]), t('PrepNP', [t(to_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(meeting_N, [])])])])]), t(together_Adv, [])])])])])]), t('DetCN', [t('DetQuant', [t('GenNP', [t('UsePN', [t(frank_PN, [])])]), t('NumSg', [])]), t('UseN', [t(boss_N, [])])])])])]), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(carl_PN, [])]), t('AdvVP', [t(elliptic_VP, []), t('PrepNP', [t(to_Prep, []), t('DetCN', [t('DetQuant', [t('GenNP', [t('UsePN', [t(alan_PN, [])])]), t('NumSg', [])]), t('UseN', [t(wife_N, [])])])])])])])])])).
sent(s_191_1_p, eng, 'Bill suggested to Frank\'s boss that they should go to the meeting together , and Carl [..] to Alan\'s wife').
sent(s_191_1_p, original, 'Bill suggested to Frank\'s boss that they should go to the meeting together , and Carl [..] to Alan\'s wife').
sent(s_191_1_p, swe, 'Bill föreslog för Franks chef att de borde gå till mötet tillsammans , och Carl [..] till Alans fru').

tree(s_191_2_q, t('Question', [t('ExtAdvQS', [t('SubjS', [t(if_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('ImpersCl', [t('PassVPSlash', [t('SlashV2S', [t(suggest_to_V2S, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('ConjNP2', [t(and_Conj, []), t('UsePN', [t(bill_PN, [])]), t('UsePN', [t(frank_PN, [])])]), t('ComplVV', [t(shall_VV, []), t('AdvVP', [t('UseV', [t(go8walk_V, [])]), t(together_Adv, [])])])])])])])])])]), t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('ImpersCl', [t('PassVPSlash', [t('SlashV2S', [t(suggest_to_V2S, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('ConjNP2', [t(and_Conj, []), t('UsePN', [t(carl_PN, [])]), t('UsePN', [t(alan_PN, [])])]), t('ComplVV', [t(shall_VV, []), t('AdvVP', [t('UseV', [t(go8walk_V, [])]), t(together_Adv, [])])])])])])])])])])])])).
sent(s_191_2_q, eng, 'if it was suggested that Bill and Frank should go together , was it suggested that Carl and Alan should go together').
sent(s_191_2_q, original, 'if it was suggested that Bill and Frank should go together , was it suggested that Carl and Alan should go together').

tree(s_191_3_h, t('Sentence', [t('ExtAdvS', [t('SubjS', [t(if_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('ImpersCl', [t('PassVPSlash', [t('SlashV2S', [t(suggest_to_V2S, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('ConjNP2', [t(and_Conj, []), t('UsePN', [t(bill_PN, [])]), t('UsePN', [t(frank_PN, [])])]), t('ComplVV', [t(shall_VV, []), t('AdvVP', [t('UseV', [t(go8walk_V, [])]), t(together_Adv, [])])])])])])])])])]), t('UseCl', [t('Past', []), t('PPos', []), t('ImpersCl', [t('PassVPSlash', [t('SlashV2S', [t(suggest_to_V2S, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('ConjNP2', [t(and_Conj, []), t('UsePN', [t(carl_PN, [])]), t('UsePN', [t(alan_PN, [])])]), t('ComplVV', [t(shall_VV, []), t('AdvVP', [t('UseV', [t(go8walk_V, [])]), t(together_Adv, [])])])])])])])])])])])).
sent(s_191_3_h, eng, 'if it was suggested that Bill and Frank should go together , it was suggested that Carl and Alan should go together').
sent(s_191_3_h, original, 'if it was suggested that Bill and Frank should go together , it was suggested that Carl and Alan should go together').

tree(s_192_1_p, s_191_1_p).
sent(s_192_1_p, eng, 'Bill suggested to Frank\'s boss that they should go to the meeting together , and Carl [..] to Alan\'s wife').
sent(s_192_1_p, original, 'Bill suggested to Frank\'s boss that they should go to the meeting together , and Carl [..] to Alan\'s wife').
sent(s_192_1_p, swe, 'Bill föreslog för Franks chef att de borde gå till mötet tillsammans , och Carl [..] till Alans fru').

tree(s_192_2_q, t('Question', [t('ExtAdvQS', [t('SubjS', [t(if_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('ImpersCl', [t('PassVPSlash', [t('SlashV2S', [t(suggest_to_V2S, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('ConjNP2', [t(and_Conj, []), t('UsePN', [t(bill_PN, [])]), t('UsePN', [t(frank_PN, [])])]), t('ComplVV', [t(shall_VV, []), t('AdvVP', [t('UseV', [t(go8walk_V, [])]), t(together_Adv, [])])])])])])])])])]), t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('ImpersCl', [t('PassVPSlash', [t('SlashV2S', [t(suggest_to_V2S, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('ConjNP2', [t(and_Conj, []), t('UsePN', [t(carl_PN, [])]), t('DetCN', [t('DetQuant', [t('GenNP', [t('UsePN', [t(alan_PN, [])])]), t('NumSg', [])]), t('UseN', [t(wife_N, [])])])]), t('ComplVV', [t(shall_VV, []), t('AdvVP', [t('UseV', [t(go8walk_V, [])]), t(together_Adv, [])])])])])])])])])])])])).
sent(s_192_2_q, eng, 'if it was suggested that Bill and Frank should go together , was it suggested that Carl and Alan\'s wife should go together').
sent(s_192_2_q, original, 'if it was suggested that Bill and Frank should go together , was it suggested that Carl and Alan\'s wife should go together').

tree(s_192_3_h, t('Sentence', [t('ExtAdvS', [t('SubjS', [t(if_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('ImpersCl', [t('PassVPSlash', [t('SlashV2S', [t(suggest_to_V2S, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('ConjNP2', [t(and_Conj, []), t('UsePN', [t(bill_PN, [])]), t('UsePN', [t(frank_PN, [])])]), t('ComplVV', [t(shall_VV, []), t('AdvVP', [t('UseV', [t(go8walk_V, [])]), t(together_Adv, [])])])])])])])])])]), t('UseCl', [t('Past', []), t('PPos', []), t('ImpersCl', [t('PassVPSlash', [t('SlashV2S', [t(suggest_to_V2S, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('ConjNP2', [t(and_Conj, []), t('UsePN', [t(carl_PN, [])]), t('DetCN', [t('DetQuant', [t('GenNP', [t('UsePN', [t(alan_PN, [])])]), t('NumSg', [])]), t('UseN', [t(wife_N, [])])])]), t('ComplVV', [t(shall_VV, []), t('AdvVP', [t('UseV', [t(go8walk_V, [])]), t(together_Adv, [])])])])])])])])])])])).
sent(s_192_3_h, eng, 'if it was suggested that Bill and Frank should go together , it was suggested that Carl and Alan\'s wife should go together').
sent(s_192_3_h, original, 'if it was suggested that Bill and Frank should go together , it was suggested that Carl and Alan\'s wife should go together').

tree(s_193_1_p, s_191_1_p).
sent(s_193_1_p, eng, 'Bill suggested to Frank\'s boss that they should go to the meeting together , and Carl [..] to Alan\'s wife').
sent(s_193_1_p, original, 'Bill suggested to Frank\'s boss that they should go to the meeting together , and Carl [..] to Alan\'s wife').
sent(s_193_1_p, swe, 'Bill föreslog för Franks chef att de borde gå till mötet tillsammans , och Carl [..] till Alans fru').

tree(s_193_2_q, t('Question', [t('ExtAdvQS', [t('SubjS', [t(if_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('ImpersCl', [t('PassVPSlash', [t('SlashV2S', [t(suggest_to_V2S, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('ConjNP2', [t(and_Conj, []), t('UsePN', [t(bill_PN, [])]), t('DetCN', [t('DetQuant', [t('GenNP', [t('UsePN', [t(frank_PN, [])])]), t('NumSg', [])]), t('UseN', [t(boss_N, [])])])]), t('ComplVV', [t(shall_VV, []), t('AdvVP', [t('UseV', [t(go8walk_V, [])]), t(together_Adv, [])])])])])])])])])]), t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('ImpersCl', [t('PassVPSlash', [t('SlashV2S', [t(suggest_to_V2S, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('ConjNP2', [t(and_Conj, []), t('UsePN', [t(carl_PN, [])]), t('DetCN', [t('DetQuant', [t('GenNP', [t('UsePN', [t(alan_PN, [])])]), t('NumSg', [])]), t('UseN', [t(wife_N, [])])])]), t('ComplVV', [t(shall_VV, []), t('AdvVP', [t('UseV', [t(go8walk_V, [])]), t(together_Adv, [])])])])])])])])])])])])).
sent(s_193_2_q, eng, 'if it was suggested that Bill and Frank\'s boss should go together , was it suggested that Carl and Alan\'s wife should go together').
sent(s_193_2_q, original, 'if it was suggested that Bill and Frank\'s boss should go together , was it suggested that Carl and Alan\'s wife should go together').

tree(s_193_3_h, t('Sentence', [t('ExtAdvS', [t('SubjS', [t(if_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('ImpersCl', [t('PassVPSlash', [t('SlashV2S', [t(suggest_to_V2S, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('ConjNP2', [t(and_Conj, []), t('UsePN', [t(bill_PN, [])]), t('DetCN', [t('DetQuant', [t('GenNP', [t('UsePN', [t(frank_PN, [])])]), t('NumSg', [])]), t('UseN', [t(boss_N, [])])])]), t('ComplVV', [t(shall_VV, []), t('AdvVP', [t('UseV', [t(go8walk_V, [])]), t(together_Adv, [])])])])])])])])])]), t('UseCl', [t('Past', []), t('PPos', []), t('ImpersCl', [t('PassVPSlash', [t('SlashV2S', [t(suggest_to_V2S, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('ConjNP2', [t(and_Conj, []), t('UsePN', [t(carl_PN, [])]), t('DetCN', [t('DetQuant', [t('GenNP', [t('UsePN', [t(alan_PN, [])])]), t('NumSg', [])]), t('UseN', [t(wife_N, [])])])]), t('ComplVV', [t(shall_VV, []), t('AdvVP', [t('UseV', [t(go8walk_V, [])]), t(together_Adv, [])])])])])])])])])])])).
sent(s_193_3_h, eng, 'if it was suggested that Bill and Frank\'s boss should go together , it was suggested that Carl and Alan\'s wife should go together').
sent(s_193_3_h, original, 'if it was suggested that Bill and Frank\'s boss should go together , it was suggested that Carl and Alan\'s wife should go together').

tree(s_194_1_p, s_191_1_p).
sent(s_194_1_p, eng, 'Bill suggested to Frank\'s boss that they should go to the meeting together , and Carl [..] to Alan\'s wife').
sent(s_194_1_p, original, 'Bill suggested to Frank\'s boss that they should go to the meeting together , and Carl [..] to Alan\'s wife').
sent(s_194_1_p, swe, 'Bill föreslog för Franks chef att de borde gå till mötet tillsammans , och Carl [..] till Alans fru').

tree(s_194_2_q, t('Question', [t('ExtAdvQS', [t('SubjS', [t(if_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('ImpersCl', [t('PassVPSlash', [t('SlashV2S', [t(suggest_to_V2S, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('ConjNP2', [t(and_Conj, []), t('UsePN', [t(bill_PN, [])]), t('DetCN', [t('DetQuant', [t('GenNP', [t('UsePN', [t(frank_PN, [])])]), t('NumSg', [])]), t('UseN', [t(boss_N, [])])])]), t('ComplVV', [t(shall_VV, []), t('AdvVP', [t('UseV', [t(go8walk_V, [])]), t(together_Adv, [])])])])])])])])])]), t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('ImpersCl', [t('PassVPSlash', [t('SlashV2S', [t(suggest_to_V2S, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('ConjNP2', [t(and_Conj, []), t('UsePN', [t(carl_PN, [])]), t('UsePN', [t(alan_PN, [])])]), t('ComplVV', [t(shall_VV, []), t('AdvVP', [t('UseV', [t(go8walk_V, [])]), t(together_Adv, [])])])])])])])])])])])])).
sent(s_194_2_q, eng, 'if it was suggested that Bill and Frank\'s boss should go together , was it suggested that Carl and Alan should go together').
sent(s_194_2_q, original, 'if it was suggested that Bill and Frank\'s boss should go together , was it suggested that Carl and Alan should go together').

tree(s_194_3_h, t('Sentence', [t('ExtAdvS', [t('SubjS', [t(if_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('ImpersCl', [t('PassVPSlash', [t('SlashV2S', [t(suggest_to_V2S, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('ConjNP2', [t(and_Conj, []), t('UsePN', [t(bill_PN, [])]), t('DetCN', [t('DetQuant', [t('GenNP', [t('UsePN', [t(frank_PN, [])])]), t('NumSg', [])]), t('UseN', [t(boss_N, [])])])]), t('ComplVV', [t(shall_VV, []), t('AdvVP', [t('UseV', [t(go8walk_V, [])]), t(together_Adv, [])])])])])])])])])]), t('UseCl', [t('Past', []), t('PPos', []), t('ImpersCl', [t('PassVPSlash', [t('SlashV2S', [t(suggest_to_V2S, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('ConjNP2', [t(and_Conj, []), t('UsePN', [t(carl_PN, [])]), t('UsePN', [t(alan_PN, [])])]), t('ComplVV', [t(shall_VV, []), t('AdvVP', [t('UseV', [t(go8walk_V, [])]), t(together_Adv, [])])])])])])])])])])])).
sent(s_194_3_h, eng, 'if it was suggested that Bill and Frank\'s boss should go together , it was suggested that Carl and Alan should go together').
sent(s_194_3_h, original, 'if it was suggested that Bill and Frank\'s boss should go together , it was suggested that Carl and Alan should go together').

tree(s_195_1_p, s_191_1_p).
sent(s_195_1_p, eng, 'Bill suggested to Frank\'s boss that they should go to the meeting together , and Carl [..] to Alan\'s wife').
sent(s_195_1_p, original, 'Bill suggested to Frank\'s boss that they should go to the meeting together , and Carl [..] to Alan\'s wife').
sent(s_195_1_p, swe, 'Bill föreslog för Franks chef att de borde gå till mötet tillsammans , och Carl [..] till Alans fru').

tree(s_195_2_q, t('Question', [t('ExtAdvQS', [t('SubjS', [t(if_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('ImpersCl', [t('PassVPSlash', [t('SlashV2S', [t(suggest_to_V2S, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('ConjNP3', [t(and_Conj, []), t('UsePN', [t(bill_PN, [])]), t('UsePN', [t(frank_PN, [])]), t('DetCN', [t('DetQuant', [t('GenNP', [t('UsePN', [t(frank_PN, [])])]), t('NumSg', [])]), t('UseN', [t(boss_N, [])])])]), t('ComplVV', [t(shall_VV, []), t('AdvVP', [t('UseV', [t(go8walk_V, [])]), t(together_Adv, [])])])])])])])])])]), t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('ImpersCl', [t('PassVPSlash', [t('SlashV2S', [t(suggest_to_V2S, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('ConjNP3', [t(and_Conj, []), t('UsePN', [t(carl_PN, [])]), t('UsePN', [t(alan_PN, [])]), t('DetCN', [t('DetQuant', [t('GenNP', [t('UsePN', [t(alan_PN, [])])]), t('NumSg', [])]), t('UseN', [t(wife_N, [])])])]), t('ComplVV', [t(shall_VV, []), t('AdvVP', [t('UseV', [t(go8walk_V, [])]), t(together_Adv, [])])])])])])])])])])])])).
sent(s_195_2_q, eng, 'if it was suggested that Bill , Frank and Frank\'s boss should go together , was it suggested that Carl , Alan and Alan\'s wife should go together').
sent(s_195_2_q, original, 'if it was suggested that Bill , Frank and Frank\'s boss should go together , was it suggested that Carl , Alan and Alan\'s wife should go together').

tree(s_195_3_h, t('Sentence', [t('ExtAdvS', [t('SubjS', [t(if_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('ImpersCl', [t('PassVPSlash', [t('SlashV2S', [t(suggest_to_V2S, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('ConjNP3', [t(and_Conj, []), t('UsePN', [t(bill_PN, [])]), t('UsePN', [t(frank_PN, [])]), t('DetCN', [t('DetQuant', [t('GenNP', [t('UsePN', [t(frank_PN, [])])]), t('NumSg', [])]), t('UseN', [t(boss_N, [])])])]), t('ComplVV', [t(shall_VV, []), t('AdvVP', [t('UseV', [t(go8walk_V, [])]), t(together_Adv, [])])])])])])])])])]), t('UseCl', [t('Past', []), t('PPos', []), t('ImpersCl', [t('PassVPSlash', [t('SlashV2S', [t(suggest_to_V2S, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('ConjNP3', [t(and_Conj, []), t('UsePN', [t(carl_PN, [])]), t('UsePN', [t(alan_PN, [])]), t('DetCN', [t('DetQuant', [t('GenNP', [t('UsePN', [t(alan_PN, [])])]), t('NumSg', [])]), t('UseN', [t(wife_N, [])])])]), t('ComplVV', [t(shall_VV, []), t('AdvVP', [t('UseV', [t(go8walk_V, [])]), t(together_Adv, [])])])])])])])])])])])).
sent(s_195_3_h, eng, 'if it was suggested that Bill , Frank and Frank\'s boss should go together , it was suggested that Carl , Alan and Alan\'s wife should go together').
sent(s_195_3_h, original, 'if it was suggested that Bill , Frank and Frank\'s boss should go together , it was suggested that Carl , Alan and Alan\'s wife should go together').

tree(s_196_1_p, t('Sentence', [t('ConjS2', [t(comma_and_Conj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(lawyer_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(sign_V2, [])]), t('DetCN', [t(every_Det, []), t('UseN', [t(report_N, [])])])])])]), t('UseCl', [t('Past', []), t('PPos', []), t('SoDoI', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(auditor_N, [])])])])])])])).
sent(s_196_1_p, eng, 'a lawyer signed every report , and so did an auditor').
sent(s_196_1_p, original, 'a lawyer signed every report , and so did an auditor').
sent(s_196_1_p, swe, 'en jurist undertecknade varje rapport , och det gjorde en revisor också').

tree(s_196_2_p, t('PSentence', [t(that_is_PConj, []), t('UseCl', [t('Past', []), t('PPos', []), t('ExistNP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_one', [])])])]), t('RelCN', [t('UseN', [t(lawyer_N, [])]), t('UseRCl', [t('Past', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('ComplSlash', [t('SlashV2a', [t(sign_V2, [])]), t('PredetNP', [t(all_Predet, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumPl', [])]), t('UseN', [t(report_N, [])])])])])])])])])])])])).
sent(s_196_2_p, eng, 'that is , there was one lawyer who signed all the reports').
sent(s_196_2_p, original, 'that is , there was one lawyer who signed all the reports').
sent(s_196_2_p, swe, 'det vill säga , det fanns en jurist som undertecknade alla rapporterna').

tree(s_196_3_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('ExistNP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_one', [])])])]), t('RelCN', [t('UseN', [t(auditor_N, [])]), t('UseRCl', [t('Past', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('ComplSlash', [t('SlashV2a', [t(sign_V2, [])]), t('PredetNP', [t(all_Predet, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumPl', [])]), t('UseN', [t(report_N, [])])])])])])])])])])])])])).
sent(s_196_3_q, eng, 'was there one auditor who signed all the reports').
sent(s_196_3_q, original, 'was there one auditor who signed all the reports').
sent(s_196_3_q, swe, 'fanns det en revisor som undertecknade alla rapporterna').

tree(s_196_4_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('ExistNP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_one', [])])])]), t('RelCN', [t('UseN', [t(auditor_N, [])]), t('UseRCl', [t('Past', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('ComplSlash', [t('SlashV2a', [t(sign_V2, [])]), t('PredetNP', [t(all_Predet, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumPl', [])]), t('UseN', [t(report_N, [])])])])])])])])])])])])).
sent(s_196_4_h, eng, 'there was one auditor who signed all the reports').
sent(s_196_4_h, original, 'there was one auditor who signed all the reports').
sent(s_196_4_h, swe, 'det fanns en revisor som undertecknade alla rapporterna').

tree(s_197_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(genuine_A, [])]), t('UseN', [t(diamond_N, [])])])])])])])])).
sent(s_197_1_p, eng, 'John has a genuine diamond').
sent(s_197_1_p, original, 'John has a genuine diamond').
sent(s_197_1_p, swe, 'John har en äkta diamant').

tree(s_197_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(john_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(diamond_N, [])])])])])])])])).
sent(s_197_2_q, eng, 'does John have a diamond').
sent(s_197_2_q, original, 'does John have a diamond').
sent(s_197_2_q, swe, 'har John en diamant').

tree(s_197_3_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(diamond_N, [])])])])])])])).
sent(s_197_3_h, eng, 'John has a diamond').
sent(s_197_3_h, original, 'John has a diamond').
sent(s_197_3_h, swe, 'John har en diamant').

tree(s_198_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('UseComp', [t('CompCN', [t('AdjCN', [t('PositA', [t(former_A, [])]), t('UseN', [t(university_student_N, [])])])])])])])])).
sent(s_198_1_p, eng, 'John is a former university student').
sent(s_198_1_p, original, 'John is a former university student').
sent(s_198_1_p, swe, 'John är en före detta universitetsstudent').

tree(s_198_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(john_PN, [])]), t('UseComp', [t('CompCN', [t('UseN', [t(university_student_N, [])])])])])])])])).
sent(s_198_2_q, eng, 'is John a university student').
sent(s_198_2_q, original, 'is John a university student').
sent(s_198_2_q, swe, 'är John en universitetsstudent').

tree(s_198_3_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('UseComp', [t('CompCN', [t('UseN', [t(university_student_N, [])])])])])])])).
sent(s_198_3_h, eng, 'John is a university student').
sent(s_198_3_h, original, 'John is a university student').
sent(s_198_3_h, swe, 'John är en universitetsstudent').

tree(s_199_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('UseComp', [t('CompCN', [t('AdjCN', [t('PositA', [t(successful_A, [])]), t('AdjCN', [t('PositA', [t(former_A, [])]), t('UseN', [t(university_student_N, [])])])])])])])])])).
sent(s_199_1_p, eng, 'John is a successful former university student').
sent(s_199_1_p, original, 'John is a successful former university student').
sent(s_199_1_p, swe, 'John är en framgångsrik före detta universitetsstudent').

tree(s_199_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(john_PN, [])]), t('UseComp', [t('CompAP', [t('PositA', [t(successful_A, [])])])])])])])])).
sent(s_199_2_q, eng, 'is John successful').
sent(s_199_2_q, original, 'is John successful').
sent(s_199_2_q, swe, 'är John framgångsrik').

tree(s_199_3_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('UseComp', [t('CompAP', [t('PositA', [t(successful_A, [])])])])])])])).
sent(s_199_3_h, eng, 'John is successful').
sent(s_199_3_h, original, 'John is successful').
sent(s_199_3_h, swe, 'John är framgångsrik').

tree(s_200_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('UseComp', [t('CompCN', [t('AdjCN', [t('PositA', [t(former_A, [])]), t('AdjCN', [t('PositA', [t(successful_A, [])]), t('UseN', [t(university_student_N, [])])])])])])])])])).
sent(s_200_1_p, eng, 'John is a former successful university student').
sent(s_200_1_p, original, 'John is a former successful university student').
sent(s_200_1_p, swe, 'John är en före detta framgångsrik universitetsstudent').

tree(s_200_2_q, s_199_2_q).
sent(s_200_2_q, eng, 'is John successful').
sent(s_200_2_q, original, 'is John successful').
sent(s_200_2_q, swe, 'är John framgångsrik').

tree(s_200_3_h, s_199_3_h).
sent(s_200_3_h, eng, 'John is successful').
sent(s_200_3_h, original, 'John is successful').
sent(s_200_3_h, swe, 'John är framgångsrik').

tree(s_201_1_p, s_200_1_p).
sent(s_201_1_p, eng, 'John is a former successful university student').
sent(s_201_1_p, original, 'John is a former successful university student').
sent(s_201_1_p, swe, 'John är en före detta framgångsrik universitetsstudent').

tree(s_201_2_q, s_198_2_q).
sent(s_201_2_q, eng, 'is John a university student').
sent(s_201_2_q, original, 'is John a university student').
sent(s_201_2_q, swe, 'är John en universitetsstudent').

tree(s_201_3_h, s_198_3_h).
sent(s_201_3_h, eng, 'John is a university student').
sent(s_201_3_h, original, 'John is a university student').
sent(s_201_3_h, swe, 'John är en universitetsstudent').

tree(s_202_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t(every_Det, []), t('UseN', [t(mammal_N, [])])]), t('UseComp', [t('CompCN', [t('UseN', [t(animal_N, [])])])])])])])).
sent(s_202_1_p, eng, 'every mammal is an animal').
sent(s_202_1_p, original, 'every mammal is an animal').
sent(s_202_1_p, swe, 'varje däggdjur är ett djur').

tree(s_202_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t(every_Det, []), t('AdjCN', [t('PositA', [t(fourlegged_A, [])]), t('UseN', [t(mammal_N, [])])])]), t('UseComp', [t('CompCN', [t('AdjCN', [t('PositA', [t(fourlegged_A, [])]), t('UseN', [t(animal_N, [])])])])])])])])])).
sent(s_202_2_q, eng, 'is every four-legged mammal a four-legged animal').
sent(s_202_2_q, original, 'is every four-legged mammal a four-legged animal').
sent(s_202_2_q, swe, 'är varje fyrbent däggdjur ett fyrbent djur').

tree(s_202_3_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t(every_Det, []), t('AdjCN', [t('PositA', [t(fourlegged_A, [])]), t('UseN', [t(mammal_N, [])])])]), t('UseComp', [t('CompCN', [t('AdjCN', [t('PositA', [t(fourlegged_A, [])]), t('UseN', [t(animal_N, [])])])])])])])])).
sent(s_202_3_h, eng, 'every four-legged mammal is a four-legged animal').
sent(s_202_3_h, original, 'every four-legged mammal is a four-legged animal').
sent(s_202_3_h, swe, 'varje fyrbent däggdjur är ett fyrbent djur').

tree(s_203_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(dumbo_PN, [])]), t('UseComp', [t('CompCN', [t('AdjCN', [t('PositA', [t(fourlegged_A, [])]), t('UseN', [t(animal_N, [])])])])])])])])).
sent(s_203_1_p, eng, 'Dumbo is a four-legged animal').
sent(s_203_1_p, original, 'Dumbo is a four-legged animal').
sent(s_203_1_p, swe, 'Dumbo är ett fyrbent djur').

tree(s_203_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(dumbo_PN, [])]), t('UseComp', [t('CompAP', [t('PositA', [t(fourlegged_A, [])])])])])])])])).
sent(s_203_2_q, eng, 'is Dumbo four-legged').
sent(s_203_2_q, original, 'is Dumbo four-legged').
sent(s_203_2_q, swe, 'är Dumbo fyrbent').

tree(s_203_3_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(dumbo_PN, [])]), t('UseComp', [t('CompAP', [t('PositA', [t(fourlegged_A, [])])])])])])])).
sent(s_203_3_h, eng, 'Dumbo is four-legged').
sent(s_203_3_h, original, 'Dumbo is four-legged').
sent(s_203_3_h, swe, 'Dumbo är fyrbent').

tree(s_204_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(mickey_PN, [])]), t('UseComp', [t('CompCN', [t('AdjCN', [t('PositA', [t(small_A, [])]), t('UseN', [t(animal_N, [])])])])])])])])).
sent(s_204_1_p, eng, 'Mickey is a small animal').
sent(s_204_1_p, original, 'Mickey is a small animal').
sent(s_204_1_p, swe, 'Mickey är ett litet djur').

tree(s_204_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(mickey_PN, [])]), t('UseComp', [t('CompCN', [t('AdjCN', [t('PositA', [t(large_A, [])]), t('UseN', [t(animal_N, [])])])])])])])])])).
sent(s_204_2_q, eng, 'is Mickey a large animal').
sent(s_204_2_q, original, 'is Mickey a large animal').
sent(s_204_2_q, swe, 'är Mickey ett stort djur').

tree(s_204_3_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(mickey_PN, [])]), t('UseComp', [t('CompCN', [t('AdjCN', [t('PositA', [t(large_A, [])]), t('UseN', [t(animal_N, [])])])])])])])])).
sent(s_204_3_h, eng, 'Mickey is a large animal').
sent(s_204_3_h, original, 'Mickey is a large animal').
sent(s_204_3_h, swe, 'Mickey är ett stort djur').

tree(s_205_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(dumbo_PN, [])]), t('UseComp', [t('CompCN', [t('AdjCN', [t('PositA', [t(large_A, [])]), t('UseN', [t(animal_N, [])])])])])])])])).
sent(s_205_1_p, eng, 'Dumbo is a large animal').
sent(s_205_1_p, original, 'Dumbo is a large animal').
sent(s_205_1_p, swe, 'Dumbo är ett stort djur').

tree(s_205_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(dumbo_PN, [])]), t('UseComp', [t('CompCN', [t('AdjCN', [t('PositA', [t(small_A, [])]), t('UseN', [t(animal_N, [])])])])])])])])])).
sent(s_205_2_q, eng, 'is Dumbo a small animal').
sent(s_205_2_q, original, 'is Dumbo a small animal').
sent(s_205_2_q, swe, 'är Dumbo ett litet djur').

tree(s_205_3_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(dumbo_PN, [])]), t('UseComp', [t('CompCN', [t('AdjCN', [t('PositA', [t(small_A, [])]), t('UseN', [t(animal_N, [])])])])])])])])).
sent(s_205_3_h, eng, 'Dumbo is a small animal').
sent(s_205_3_h, original, 'Dumbo is a small animal').
sent(s_205_3_h, swe, 'Dumbo är ett litet djur').

tree(s_206_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('UncNeg', []), t('PredVP', [t('UsePN', [t(fido_PN, [])]), t('UseComp', [t('CompCN', [t('AdjCN', [t('PositA', [t(small_A, [])]), t('UseN', [t(animal_N, [])])])])])])])])).
sent(s_206_1_p, eng, 'Fido is not a small animal').
sent(s_206_1_p, original, 'Fido is not a small animal').
sent(s_206_1_p, swe, 'Fido är inte ett litet djur').

tree(s_206_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(fido_PN, [])]), t('UseComp', [t('CompCN', [t('AdjCN', [t('PositA', [t(large_A, [])]), t('UseN', [t(animal_N, [])])])])])])])])])).
sent(s_206_2_q, eng, 'is Fido a large animal').
sent(s_206_2_q, original, 'is Fido a large animal').
sent(s_206_2_q, swe, 'är Fido ett stort djur').

tree(s_206_3_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(fido_PN, [])]), t('UseComp', [t('CompCN', [t('AdjCN', [t('PositA', [t(large_A, [])]), t('UseN', [t(animal_N, [])])])])])])])])).
sent(s_206_3_h, eng, 'Fido is a large animal').
sent(s_206_3_h, original, 'Fido is a large animal').
sent(s_206_3_h, swe, 'Fido är ett stort djur').

tree(s_207_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('UncNeg', []), t('PredVP', [t('UsePN', [t(fido_PN, [])]), t('UseComp', [t('CompCN', [t('AdjCN', [t('PositA', [t(large_A, [])]), t('UseN', [t(animal_N, [])])])])])])])])).
sent(s_207_1_p, eng, 'Fido is not a large animal').
sent(s_207_1_p, original, 'Fido is not a large animal').
sent(s_207_1_p, swe, 'Fido är inte ett stort djur').

tree(s_207_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(fido_PN, [])]), t('UseComp', [t('CompCN', [t('AdjCN', [t('PositA', [t(small_A, [])]), t('UseN', [t(animal_N, [])])])])])])])])])).
sent(s_207_2_q, eng, 'is Fido a small animal').
sent(s_207_2_q, original, 'is Fido a small animal').
sent(s_207_2_q, swe, 'är Fido ett litet djur').

tree(s_207_3_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(fido_PN, [])]), t('UseComp', [t('CompCN', [t('AdjCN', [t('PositA', [t(small_A, [])]), t('UseN', [t(animal_N, [])])])])])])])])).
sent(s_207_3_h, eng, 'Fido is a small animal').
sent(s_207_3_h, original, 'Fido is a small animal').
sent(s_207_3_h, swe, 'Fido är ett litet djur').

tree(s_208_1_p, s_204_1_p).
sent(s_208_1_p, eng, 'Mickey is a small animal').
sent(s_208_1_p, original, 'Mickey is a small animal').
sent(s_208_1_p, swe, 'Mickey är ett litet djur').

tree(s_208_2_p, s_205_1_p).
sent(s_208_2_p, eng, 'Dumbo is a large animal').
sent(s_208_2_p, original, 'Dumbo is a large animal').
sent(s_208_2_p, swe, 'Dumbo är ett stort djur').

tree(s_208_3_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(mickey_PN, [])]), t('UseComp', [t('CompAP', [t('ComparA', [t(small_A, []), t('UsePN', [t(dumbo_PN, [])])])])])])])])])).
sent(s_208_3_q, eng, 'is Mickey smaller than Dumbo').
sent(s_208_3_q, original, 'is Mickey smaller than Dumbo').
sent(s_208_3_q, swe, 'är Mickey mindre än Dumbo').

tree(s_208_4_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(mickey_PN, [])]), t('UseComp', [t('CompAP', [t('ComparA', [t(small_A, []), t('UsePN', [t(dumbo_PN, [])])])])])])])])).
sent(s_208_4_h, eng, 'Mickey is smaller than Dumbo').
sent(s_208_4_h, original, 'Mickey is smaller than Dumbo').
sent(s_208_4_h, swe, 'Mickey är mindre än Dumbo').

tree(s_209_1_p, s_204_1_p).
sent(s_209_1_p, eng, 'Mickey is a small animal').
sent(s_209_1_p, original, 'Mickey is a small animal').
sent(s_209_1_p, swe, 'Mickey är ett litet djur').

tree(s_209_2_p, s_205_1_p).
sent(s_209_2_p, eng, 'Dumbo is a large animal').
sent(s_209_2_p, original, 'Dumbo is a large animal').
sent(s_209_2_p, swe, 'Dumbo är ett stort djur').

tree(s_209_3_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(mickey_PN, [])]), t('UseComp', [t('CompAP', [t('ComparA', [t(large_A, []), t('UsePN', [t(dumbo_PN, [])])])])])])])])])).
sent(s_209_3_q, eng, 'is Mickey larger than Dumbo').
sent(s_209_3_q, original, 'is Mickey larger than Dumbo').
sent(s_209_3_q, swe, 'är Mickey större än Dumbo').

tree(s_209_4_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(mickey_PN, [])]), t('UseComp', [t('CompAP', [t('ComparA', [t(large_A, []), t('UsePN', [t(dumbo_PN, [])])])])])])])])).
sent(s_209_4_h, eng, 'Mickey is larger than Dumbo').
sent(s_209_4_h, original, 'Mickey is larger than Dumbo').
sent(s_209_4_h, swe, 'Mickey är större än Dumbo').

tree(s_210_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('PredetNP', [t(all_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('UseN', [t(mouse_N, [])])])]), t('UseComp', [t('CompCN', [t('AdjCN', [t('PositA', [t(small_A, [])]), t('UseN', [t(animal_N, [])])])])])])])])).
sent(s_210_1_p, eng, 'all mice are small animals').
sent(s_210_1_p, original, 'all mice are small animals').
sent(s_210_1_p, swe, 'alla möss är små djur').

tree(s_210_2_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(mickey_PN, [])]), t('UseComp', [t('CompCN', [t('AdjCN', [t('PositA', [t(large_A, [])]), t('UseN', [t(mouse_N, [])])])])])])])])).
sent(s_210_2_p, eng, 'Mickey is a large mouse').
sent(s_210_2_p, original, 'Mickey is a large mouse').
sent(s_210_2_p, swe, 'Mickey är en stor mus').

tree(s_210_3_q, s_204_2_q).
sent(s_210_3_q, eng, 'is Mickey a large animal').
sent(s_210_3_q, original, 'is Mickey a large animal').
sent(s_210_3_q, swe, 'är Mickey ett stort djur').

tree(s_210_4_h, s_204_3_h).
sent(s_210_4_h, eng, 'Mickey is a large animal').
sent(s_210_4_h, original, 'Mickey is a large animal').
sent(s_210_4_h, swe, 'Mickey är ett stort djur').

tree(s_211_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('PredetNP', [t(all_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('UseN', [t(elephant_N, [])])])]), t('UseComp', [t('CompCN', [t('AdjCN', [t('PositA', [t(large_A, [])]), t('UseN', [t(animal_N, [])])])])])])])])).
sent(s_211_1_p, eng, 'all elephants are large animals').
sent(s_211_1_p, original, 'all elephants are large animals').
sent(s_211_1_p, swe, 'alla elefanter är stora djur').

tree(s_211_2_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(dumbo_PN, [])]), t('UseComp', [t('CompCN', [t('AdjCN', [t('PositA', [t(small_A, [])]), t('UseN', [t(elephant_N, [])])])])])])])])).
sent(s_211_2_p, eng, 'Dumbo is a small elephant').
sent(s_211_2_p, original, 'Dumbo is a small elephant').
sent(s_211_2_p, swe, 'Dumbo är en liten elefant').

tree(s_211_3_q, s_205_2_q).
sent(s_211_3_q, eng, 'is Dumbo a small animal').
sent(s_211_3_q, original, 'is Dumbo a small animal').
sent(s_211_3_q, swe, 'är Dumbo ett litet djur').

tree(s_211_4_h, s_205_3_h).
sent(s_211_4_h, eng, 'Dumbo is a small animal').
sent(s_211_4_h, original, 'Dumbo is a small animal').
sent(s_211_4_h, swe, 'Dumbo är ett litet djur').

tree(s_212_1_p, s_210_1_p).
sent(s_212_1_p, eng, 'all mice are small animals').
sent(s_212_1_p, original, 'all mice are small animals').
sent(s_212_1_p, swe, 'alla möss är små djur').

tree(s_212_2_p, s_211_1_p).
sent(s_212_2_p, eng, 'all elephants are large animals').
sent(s_212_2_p, original, 'all elephants are large animals').
sent(s_212_2_p, swe, 'alla elefanter är stora djur').

tree(s_212_3_p, s_210_2_p).
sent(s_212_3_p, eng, 'Mickey is a large mouse').
sent(s_212_3_p, original, 'Mickey is a large mouse').
sent(s_212_3_p, swe, 'Mickey är en stor mus').

tree(s_212_4_p, s_211_2_p).
sent(s_212_4_p, eng, 'Dumbo is a small elephant').
sent(s_212_4_p, original, 'Dumbo is a small elephant').
sent(s_212_4_p, swe, 'Dumbo är en liten elefant').

tree(s_212_5_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(dumbo_PN, [])]), t('UseComp', [t('CompAP', [t('ComparA', [t(large_A, []), t('UsePN', [t(mickey_PN, [])])])])])])])])])).
sent(s_212_5_q, eng, 'is Dumbo larger than Mickey').
sent(s_212_5_q, original, 'is Dumbo larger than Mickey').
sent(s_212_5_q, swe, 'är Dumbo större än Mickey').

tree(s_212_6_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(dumbo_PN, [])]), t('UseComp', [t('CompAP', [t('ComparA', [t(large_A, []), t('UsePN', [t(mickey_PN, [])])])])])])])])).
sent(s_212_6_h, eng, 'Dumbo is larger than Mickey').
sent(s_212_6_h, original, 'Dumbo is larger than Mickey').
sent(s_212_6_h, swe, 'Dumbo är större än Mickey').

tree(s_213_1_p, s_210_1_p).
sent(s_213_1_p, eng, 'all mice are small animals').
sent(s_213_1_p, original, 'all mice are small animals').
sent(s_213_1_p, swe, 'alla möss är små djur').

tree(s_213_2_p, s_210_2_p).
sent(s_213_2_p, eng, 'Mickey is a large mouse').
sent(s_213_2_p, original, 'Mickey is a large mouse').
sent(s_213_2_p, swe, 'Mickey är en stor mus').

tree(s_213_3_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(mickey_PN, [])]), t('UseComp', [t('CompAP', [t('PositA', [t(small_A, [])])])])])])])])).
sent(s_213_3_q, eng, 'is Mickey small').
sent(s_213_3_q, original, 'is Mickey small').
sent(s_213_3_q, swe, 'är Mickey liten').

tree(s_213_4_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(mickey_PN, [])]), t('UseComp', [t('CompAP', [t('PositA', [t(small_A, [])])])])])])])).
sent(s_213_4_h, eng, 'Mickey is small').
sent(s_213_4_h, original, 'Mickey is small').
sent(s_213_4_h, swe, 'Mickey är liten').

tree(s_214_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('PredetNP', [t(all_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('AdjCN', [t('PositA', [t(legal_A, [])]), t('UseN', [t(authority_N, [])])])])]), t('UseComp', [t('CompCN', [t('UseN', [t(law_lecturer_N, [])])])])])])])).
sent(s_214_1_p, eng, 'all legal authorities are law lecturers').
sent(s_214_1_p, original, 'all legal authorities are law lecturers').
sent(s_214_1_p, swe, 'alla juridiska fackmän är juridiklärare').

tree(s_214_2_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('PredetNP', [t(all_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('UseN', [t(law_lecturer_N, [])])])]), t('UseComp', [t('CompCN', [t('AdjCN', [t('PositA', [t(legal_A, [])]), t('UseN', [t(authority_N, [])])])])])])])])).
sent(s_214_2_p, eng, 'all law lecturers are legal authorities').
sent(s_214_2_p, original, 'all law lecturers are legal authorities').
sent(s_214_2_p, swe, 'alla juridiklärare är juridiska fackmän').

tree(s_214_3_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('PredetNP', [t(all_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('AdjCN', [t('PositA', [t(fat_A, [])]), t('AdjCN', [t('PositA', [t(legal_A, [])]), t('UseN', [t(authority_N, [])])])])])]), t('UseComp', [t('CompCN', [t('AdjCN', [t('PositA', [t(fat_A, [])]), t('UseN', [t(law_lecturer_N, [])])])])])])])])])).
sent(s_214_3_q, eng, 'are all fat legal authorities fat law lecturers').
sent(s_214_3_q, original, 'are all fat legal authorities fat law lecturers').
sent(s_214_3_q, swe, 'är alla feta juridiska fackmän feta juridiklärare').

tree(s_214_4_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('PredetNP', [t(all_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('AdjCN', [t('PositA', [t(fat_A, [])]), t('AdjCN', [t('PositA', [t(legal_A, [])]), t('UseN', [t(authority_N, [])])])])])]), t('UseComp', [t('CompCN', [t('AdjCN', [t('PositA', [t(fat_A, [])]), t('UseN', [t(law_lecturer_N, [])])])])])])])])).
sent(s_214_4_h, eng, 'all fat legal authorities are fat law lecturers').
sent(s_214_4_h, original, 'all fat legal authorities are fat law lecturers').
sent(s_214_4_h, swe, 'alla feta juridiska fackmän är feta juridiklärare').

tree(s_215_1_p, s_214_1_p).
sent(s_215_1_p, eng, 'all legal authorities are law lecturers').
sent(s_215_1_p, original, 'all legal authorities are law lecturers').
sent(s_215_1_p, swe, 'alla juridiska fackmän är juridiklärare').

tree(s_215_2_p, s_214_2_p).
sent(s_215_2_p, eng, 'all law lecturers are legal authorities').
sent(s_215_2_p, original, 'all law lecturers are legal authorities').
sent(s_215_2_p, swe, 'alla juridiklärare är juridiska fackmän').

tree(s_215_3_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('PredetNP', [t(all_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('AdjCN', [t('PositA', [t(competent_A, [])]), t('AdjCN', [t('PositA', [t(legal_A, [])]), t('UseN', [t(authority_N, [])])])])])]), t('UseComp', [t('CompCN', [t('AdjCN', [t('PositA', [t(competent_A, [])]), t('UseN', [t(law_lecturer_N, [])])])])])])])])])).
sent(s_215_3_q, eng, 'are all competent legal authorities competent law lecturers').
sent(s_215_3_q, original, 'are all competent legal authorities competent law lecturers').
sent(s_215_3_q, swe, 'är alla kompetenta juridiska fackmän kompetenta juridiklärare').

tree(s_215_4_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('PredetNP', [t(all_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('AdjCN', [t('PositA', [t(competent_A, [])]), t('AdjCN', [t('PositA', [t(legal_A, [])]), t('UseN', [t(authority_N, [])])])])])]), t('UseComp', [t('CompCN', [t('AdjCN', [t('PositA', [t(competent_A, [])]), t('UseN', [t(law_lecturer_N, [])])])])])])])])).
sent(s_215_4_h, eng, 'all competent legal authorities are competent law lecturers').
sent(s_215_4_h, original, 'all competent legal authorities are competent law lecturers').
sent(s_215_4_h, swe, 'alla kompetenta juridiska fackmän är kompetenta juridiklärare').

tree(s_216_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('UseComp', [t('CompCN', [t('AdvCN', [t('AdjCN', [t('UseComparA_prefix', [t(fat_A, [])]), t('UseN', [t(politician_N, [])])]), t('PrepNP', [t(than_Prep, []), t('UsePN', [t(bill_PN, [])])])])])])])])])).
sent(s_216_1_p, eng, 'John is a fatter politician than Bill').
sent(s_216_1_p, original, 'John is a fatter politician than Bill').
sent(s_216_1_p, swe, 'John är en fetare politiker än Bill').

tree(s_216_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(john_PN, [])]), t('UseComp', [t('CompAP', [t('ComparA', [t(fat_A, []), t('UsePN', [t(bill_PN, [])])])])])])])])])).
sent(s_216_2_q, eng, 'is John fatter than Bill').
sent(s_216_2_q, original, 'is John fatter than Bill').
sent(s_216_2_q, swe, 'är John fetare än Bill').

tree(s_216_3_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('UseComp', [t('CompAP', [t('ComparA', [t(fat_A, []), t('UsePN', [t(bill_PN, [])])])])])])])])).
sent(s_216_3_h, eng, 'John is fatter than Bill').
sent(s_216_3_h, original, 'John is fatter than Bill').
sent(s_216_3_h, swe, 'John är fetare än Bill').

tree(s_217_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('UseComp', [t('CompCN', [t('AdvCN', [t('AdjCN', [t('UseComparA_prefix', [t(clever_A, [])]), t('UseN', [t(politician_N, [])])]), t('PrepNP', [t(than_Prep, []), t('UsePN', [t(bill_PN, [])])])])])])])])])).
sent(s_217_1_p, eng, 'John is a cleverer politician than Bill').
sent(s_217_1_p, original, 'John is a cleverer politician than Bill').
sent(s_217_1_p, swe, 'John är en smartare politiker än Bill').

tree(s_217_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(john_PN, [])]), t('UseComp', [t('CompAP', [t('ComparA', [t(clever_A, []), t('UsePN', [t(bill_PN, [])])])])])])])])])).
sent(s_217_2_q, eng, 'is John cleverer than Bill').
sent(s_217_2_q, original, 'is John cleverer than Bill').
sent(s_217_2_q, swe, 'är John smartare än Bill').

tree(s_217_3_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(john_PN, [])]), t('UseComp', [t('CompAP', [t('ComparA', [t(clever_A, []), t('UsePN', [t(bill_PN, [])])])])])])])])).
sent(s_217_3_h, eng, 'John is cleverer than Bill').
sent(s_217_3_h, original, 'John is cleverer than Bill').
sent(s_217_3_h, swe, 'John är smartare än Bill').

tree(s_218_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(kim_PN, [])]), t('UseComp', [t('CompCN', [t('AdjCN', [t('PositA', [t(clever_A, [])]), t('UseN', [t(person_N, [])])])])])])])])).
sent(s_218_1_p, eng, 'Kim is a clever person').
sent(s_218_1_p, original, 'Kim is a clever person').
sent(s_218_1_p, swe, 'Kim är en smart människa').

tree(s_218_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(kim_PN, [])]), t('UseComp', [t('CompAP', [t('PositA', [t(clever_A, [])])])])])])])])).
sent(s_218_2_q, eng, 'is Kim clever').
sent(s_218_2_q, original, 'is Kim clever').
sent(s_218_2_q, swe, 'är Kim smart').

tree(s_218_3_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(kim_PN, [])]), t('UseComp', [t('CompAP', [t('PositA', [t(clever_A, [])])])])])])])).
sent(s_218_3_h, eng, 'Kim is clever').
sent(s_218_3_h, original, 'Kim is clever').
sent(s_218_3_h, swe, 'Kim är smart').

tree(s_219_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(kim_PN, [])]), t('UseComp', [t('CompCN', [t('AdjCN', [t('PositA', [t(clever_A, [])]), t('UseN', [t(politician_N, [])])])])])])])])).
sent(s_219_1_p, eng, 'Kim is a clever politician').
sent(s_219_1_p, original, 'Kim is a clever politician').
sent(s_219_1_p, swe, 'Kim är en smart politiker').

tree(s_219_2_q, s_218_2_q).
sent(s_219_2_q, eng, 'is Kim clever').
sent(s_219_2_q, original, 'is Kim clever').
sent(s_219_2_q, swe, 'är Kim smart').

tree(s_219_3_h, s_218_3_h).
sent(s_219_3_h, eng, 'Kim is clever').
sent(s_219_3_h, original, 'Kim is clever').
sent(s_219_3_h, swe, 'Kim är smart').

tree(s_220_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(pc6082_N, [])])]), t('UseComp', [t('CompAP', [t('ComparA', [t(fast_A, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(itelxz_N, [])])])])])])])])])).
sent(s_220_1_p, eng, 'the PC-6082 is faster than the ITEL-XZ').
sent(s_220_1_p, original, 'the PC-6082 is faster than the ITEL-XZ').
sent(s_220_1_p, swe, 'PC-6082:an är snabbare än ITEL-XZ:an').

tree(s_220_2_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(itelxz_N, [])])]), t('UseComp', [t('CompAP', [t('PositA', [t(fast_A, [])])])])])])])).
sent(s_220_2_p, eng, 'the ITEL-XZ is fast').
sent(s_220_2_p, original, 'the ITEL-XZ is fast').
sent(s_220_2_p, swe, 'ITEL-XZ:an är snabb').

tree(s_220_3_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(pc6082_N, [])])]), t('UseComp', [t('CompAP', [t('PositA', [t(fast_A, [])])])])])])])])).
sent(s_220_3_q, eng, 'is the PC-6082 fast').
sent(s_220_3_q, original, 'is the PC-6082 fast').
sent(s_220_3_q, swe, 'är PC-6082:an snabb').

tree(s_220_4_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(pc6082_N, [])])]), t('UseComp', [t('CompAP', [t('PositA', [t(fast_A, [])])])])])])])).
sent(s_220_4_h, eng, 'the PC-6082 is fast').
sent(s_220_4_h, original, 'the PC-6082 is fast').
sent(s_220_4_h, swe, 'PC-6082:an är snabb').

tree(s_221_1_p, s_220_1_p).
sent(s_221_1_p, eng, 'the PC-6082 is faster than the ITEL-XZ').
sent(s_221_1_p, original, 'the PC-6082 is faster than the ITEL-XZ').
sent(s_221_1_p, swe, 'PC-6082:an är snabbare än ITEL-XZ:an').

tree(s_221_2_q, s_220_3_q).
sent(s_221_2_q, eng, 'is the PC-6082 fast').
sent(s_221_2_q, original, 'is the PC-6082 fast').
sent(s_221_2_q, swe, 'är PC-6082:an snabb').

tree(s_221_3_h, s_220_4_h).
sent(s_221_3_h, eng, 'the PC-6082 is fast').
sent(s_221_3_h, original, 'the PC-6082 is fast').
sent(s_221_3_h, swe, 'PC-6082:an är snabb').

tree(s_222_1_p, s_220_1_p).
sent(s_222_1_p, eng, 'the PC-6082 is faster than the ITEL-XZ').
sent(s_222_1_p, original, 'the PC-6082 is faster than the ITEL-XZ').
sent(s_222_1_p, swe, 'PC-6082:an är snabbare än ITEL-XZ:an').

tree(s_222_2_p, s_220_4_h).
sent(s_222_2_p, eng, 'the PC-6082 is fast').
sent(s_222_2_p, original, 'the PC-6082 is fast').
sent(s_222_2_p, swe, 'PC-6082:an är snabb').

tree(s_222_3_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(itelxz_N, [])])]), t('UseComp', [t('CompAP', [t('PositA', [t(fast_A, [])])])])])])])])).
sent(s_222_3_q, eng, 'is the ITEL-XZ fast').
sent(s_222_3_q, original, 'is the ITEL-XZ fast').
sent(s_222_3_q, swe, 'är ITEL-XZ:an snabb').

tree(s_222_4_h, s_220_2_p).
sent(s_222_4_h, eng, 'the ITEL-XZ is fast').
sent(s_222_4_h, original, 'the ITEL-XZ is fast').
sent(s_222_4_h, swe, 'ITEL-XZ:an är snabb').

tree(s_223_1_p, s_220_1_p).
sent(s_223_1_p, eng, 'the PC-6082 is faster than the ITEL-XZ').
sent(s_223_1_p, original, 'the PC-6082 is faster than the ITEL-XZ').
sent(s_223_1_p, swe, 'PC-6082:an är snabbare än ITEL-XZ:an').

tree(s_223_2_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(pc6082_N, [])])]), t('UseComp', [t('CompAP', [t('PositA', [t(slow_A, [])])])])])])])).
sent(s_223_2_p, eng, 'the PC-6082 is slow').
sent(s_223_2_p, original, 'the PC-6082 is slow').
sent(s_223_2_p, swe, 'PC-6082:an är långsam').

tree(s_223_3_q, s_222_3_q).
sent(s_223_3_q, eng, 'is the ITEL-XZ fast').
sent(s_223_3_q, original, 'is the ITEL-XZ fast').
sent(s_223_3_q, swe, 'är ITEL-XZ:an snabb').

tree(s_223_4_h, s_220_2_p).
sent(s_223_4_h, eng, 'the ITEL-XZ is fast').
sent(s_223_4_h, original, 'the ITEL-XZ is fast').
sent(s_223_4_h, swe, 'ITEL-XZ:an är snabb').

tree(s_224_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(pc6082_N, [])])]), t('UseComp', [t('CompAP', [t('ComparAsAs', [t(fast_A, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(itelxz_N, [])])])])])])])])])).
sent(s_224_1_p, eng, 'the PC-6082 is as fast as the ITEL-XZ').
sent(s_224_1_p, original, 'the PC-6082 is as fast as the ITEL-XZ').
sent(s_224_1_p, swe, 'PC-6082:an är lika snabb som ITEL-XZ:an').

tree(s_224_2_p, s_220_2_p).
sent(s_224_2_p, eng, 'the ITEL-XZ is fast').
sent(s_224_2_p, original, 'the ITEL-XZ is fast').
sent(s_224_2_p, swe, 'ITEL-XZ:an är snabb').

tree(s_224_3_q, s_220_3_q).
sent(s_224_3_q, eng, 'is the PC-6082 fast').
sent(s_224_3_q, original, 'is the PC-6082 fast').
sent(s_224_3_q, swe, 'är PC-6082:an snabb').

tree(s_224_4_h, s_220_4_h).
sent(s_224_4_h, eng, 'the PC-6082 is fast').
sent(s_224_4_h, original, 'the PC-6082 is fast').
sent(s_224_4_h, swe, 'PC-6082:an är snabb').

tree(s_225_1_p, s_224_1_p).
sent(s_225_1_p, eng, 'the PC-6082 is as fast as the ITEL-XZ').
sent(s_225_1_p, original, 'the PC-6082 is as fast as the ITEL-XZ').
sent(s_225_1_p, swe, 'PC-6082:an är lika snabb som ITEL-XZ:an').

tree(s_225_2_q, s_220_3_q).
sent(s_225_2_q, eng, 'is the PC-6082 fast').
sent(s_225_2_q, original, 'is the PC-6082 fast').
sent(s_225_2_q, swe, 'är PC-6082:an snabb').

tree(s_225_3_h, s_220_4_h).
sent(s_225_3_h, eng, 'the PC-6082 is fast').
sent(s_225_3_h, original, 'the PC-6082 is fast').
sent(s_225_3_h, swe, 'PC-6082:an är snabb').

tree(s_226_1_p, s_224_1_p).
sent(s_226_1_p, eng, 'the PC-6082 is as fast as the ITEL-XZ').
sent(s_226_1_p, original, 'the PC-6082 is as fast as the ITEL-XZ').
sent(s_226_1_p, swe, 'PC-6082:an är lika snabb som ITEL-XZ:an').

tree(s_226_2_p, s_220_4_h).
sent(s_226_2_p, eng, 'the PC-6082 is fast').
sent(s_226_2_p, original, 'the PC-6082 is fast').
sent(s_226_2_p, swe, 'PC-6082:an är snabb').

tree(s_226_3_q, s_222_3_q).
sent(s_226_3_q, eng, 'is the ITEL-XZ fast').
sent(s_226_3_q, original, 'is the ITEL-XZ fast').
sent(s_226_3_q, swe, 'är ITEL-XZ:an snabb').

tree(s_226_4_h, s_220_2_p).
sent(s_226_4_h, eng, 'the ITEL-XZ is fast').
sent(s_226_4_h, original, 'the ITEL-XZ is fast').
sent(s_226_4_h, swe, 'ITEL-XZ:an är snabb').

tree(s_227_1_p, s_224_1_p).
sent(s_227_1_p, eng, 'the PC-6082 is as fast as the ITEL-XZ').
sent(s_227_1_p, original, 'the PC-6082 is as fast as the ITEL-XZ').
sent(s_227_1_p, swe, 'PC-6082:an är lika snabb som ITEL-XZ:an').

tree(s_227_2_p, s_223_2_p).
sent(s_227_2_p, eng, 'the PC-6082 is slow').
sent(s_227_2_p, original, 'the PC-6082 is slow').
sent(s_227_2_p, swe, 'PC-6082:an är långsam').

tree(s_227_3_q, s_222_3_q).
sent(s_227_3_q, eng, 'is the ITEL-XZ fast').
sent(s_227_3_q, original, 'is the ITEL-XZ fast').
sent(s_227_3_q, swe, 'är ITEL-XZ:an snabb').

tree(s_227_4_h, s_220_2_p).
sent(s_227_4_h, eng, 'the ITEL-XZ is fast').
sent(s_227_4_h, original, 'the ITEL-XZ is fast').
sent(s_227_4_h, swe, 'ITEL-XZ:an är snabb').

tree(s_228_1_p, s_224_1_p).
sent(s_228_1_p, eng, 'the PC-6082 is as fast as the ITEL-XZ').
sent(s_228_1_p, original, 'the PC-6082 is as fast as the ITEL-XZ').
sent(s_228_1_p, swe, 'PC-6082:an är lika snabb som ITEL-XZ:an').

tree(s_228_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(pc6082_N, [])])]), t('UseComp', [t('CompAP', [t('ComparA', [t(fast_A, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(itelxz_N, [])])])])])])])])])])).
sent(s_228_2_q, eng, 'is the PC-6082 faster than the ITEL-XZ').
sent(s_228_2_q, original, 'is the PC-6082 faster than the ITEL-XZ').
sent(s_228_2_q, swe, 'är PC-6082:an snabbare än ITEL-XZ:an').

tree(s_228_3_h, s_220_1_p).
sent(s_228_3_h, eng, 'the PC-6082 is faster than the ITEL-XZ').
sent(s_228_3_h, original, 'the PC-6082 is faster than the ITEL-XZ').
sent(s_228_3_h, swe, 'PC-6082:an är snabbare än ITEL-XZ:an').

tree(s_229_1_p, s_224_1_p).
sent(s_229_1_p, eng, 'the PC-6082 is as fast as the ITEL-XZ').
sent(s_229_1_p, original, 'the PC-6082 is as fast as the ITEL-XZ').
sent(s_229_1_p, swe, 'PC-6082:an är lika snabb som ITEL-XZ:an').

tree(s_229_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(pc6082_N, [])])]), t('UseComp', [t('CompAP', [t('ComparA', [t(slow_A, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(itelxz_N, [])])])])])])])])])])).
sent(s_229_2_q, eng, 'is the PC-6082 slower than the ITEL-XZ').
sent(s_229_2_q, original, 'is the PC-6082 slower than the ITEL-XZ').
sent(s_229_2_q, swe, 'är PC-6082:an långsammare än ITEL-XZ:an').

tree(s_229_3_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(pc6082_N, [])])]), t('UseComp', [t('CompAP', [t('ComparA', [t(slow_A, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(itelxz_N, [])])])])])])])])])).
sent(s_229_3_h, eng, 'the PC-6082 is slower than the ITEL-XZ').
sent(s_229_3_h, original, 'the PC-6082 is slower than the ITEL-XZ').
sent(s_229_3_h, swe, 'PC-6082:an är långsammare än ITEL-XZ:an').

tree(s_230_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(win_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('AdvCN', [t('AdjCN', [t('UseComparA_prefix', [t(many_A, [])]), t('UseN', [t(order_N, [])])]), t('SubjS', [t(than_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(apcom_PN, [])]), t('ComplVV', [t(do_VV, []), t(elliptic_VP, [])])])])])])])])])])])).
sent(s_230_1_p, eng, 'ITEL won more orders than APCOM did [..]').
sent(s_230_1_p, original, 'ITEL won more orders than APCOM did [..]').
sent(s_230_1_p, swe, 'ITEL vann mer order än APCOM gjorde [..]').

tree(s_230_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(win_V2, [])]), t('DetCN', [t(somePl_Det, []), t('UseN', [t(order_N, [])])])])])])])])).
sent(s_230_2_q, eng, 'did ITEL win some orders').
sent(s_230_2_q, original, 'did ITEL win some orders').
sent(s_230_2_q, swe, 'vann ITEL några order').

tree(s_230_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(win_V2, [])]), t('DetCN', [t(somePl_Det, []), t('UseN', [t(order_N, [])])])])])])])).
sent(s_230_3_h, eng, 'ITEL won some orders').
sent(s_230_3_h, original, 'ITEL won some orders').
sent(s_230_3_h, swe, 'ITEL vann några order').

tree(s_231_1_p, s_230_1_p).
sent(s_231_1_p, eng, 'ITEL won more orders than APCOM did [..]').
sent(s_231_1_p, original, 'ITEL won more orders than APCOM did [..]').
sent(s_231_1_p, swe, 'ITEL vann mer order än APCOM gjorde [..]').

tree(s_231_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(apcom_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(win_V2, [])]), t('DetCN', [t(somePl_Det, []), t('UseN', [t(order_N, [])])])])])])])])).
sent(s_231_2_q, eng, 'did APCOM win some orders').
sent(s_231_2_q, original, 'did APCOM win some orders').
sent(s_231_2_q, swe, 'vann APCOM några order').

tree(s_231_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(apcom_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(win_V2, [])]), t('DetCN', [t(somePl_Det, []), t('UseN', [t(order_N, [])])])])])])])).
sent(s_231_3_h, eng, 'APCOM won some orders').
sent(s_231_3_h, original, 'APCOM won some orders').
sent(s_231_3_h, swe, 'APCOM vann några order').

tree(s_232_1_p, s_230_1_p).
sent(s_232_1_p, eng, 'ITEL won more orders than APCOM did [..]').
sent(s_232_1_p, original, 'ITEL won more orders than APCOM did [..]').
sent(s_232_1_p, swe, 'ITEL vann mer order än APCOM gjorde [..]').

tree(s_232_2_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(apcom_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(win_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_ten', [])])])]), t('UseN', [t(order_N, [])])])])])])])).
sent(s_232_2_p, eng, 'APCOM won ten orders').
sent(s_232_2_p, original, 'APCOM won ten orders').
sent(s_232_2_p, swe, 'APCOM vann tio order').

tree(s_232_3_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(win_V2, [])]), t('PredetNP', [t(at_least_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_eleven', [])])])]), t('UseN', [t(order_N, [])])])])])])])])])).
sent(s_232_3_q, eng, 'did ITEL win at least eleven orders').
sent(s_232_3_q, original, 'did ITEL win at least eleven orders').
sent(s_232_3_q, swe, 'vann ITEL minst elva order').

tree(s_232_4_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(win_V2, [])]), t('PredetNP', [t(at_least_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_eleven', [])])])]), t('UseN', [t(order_N, [])])])])])])])])).
sent(s_232_4_h, eng, 'ITEL won at least eleven orders').
sent(s_232_4_h, original, 'ITEL won at least eleven orders').
sent(s_232_4_h, swe, 'ITEL vann minst elva order').

tree(s_233_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(win_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('AdvCN', [t('AdjCN', [t('UseComparA_prefix', [t(many_A, [])]), t('UseN', [t(order_N, [])])]), t('PrepNP', [t(than_Prep, []), t('UsePN', [t(apcom_PN, [])])])])])])])])])).
sent(s_233_1_p, eng, 'ITEL won more orders than APCOM').
sent(s_233_1_p, original, 'ITEL won more orders than APCOM').
sent(s_233_1_p, swe, 'ITEL vann mer order än APCOM').

tree(s_233_2_q, s_230_2_q).
sent(s_233_2_q, eng, 'did ITEL win some orders').
sent(s_233_2_q, original, 'did ITEL win some orders').
sent(s_233_2_q, swe, 'vann ITEL några order').

tree(s_233_3_h, s_230_3_h).
sent(s_233_3_h, eng, 'ITEL won some orders').
sent(s_233_3_h, original, 'ITEL won some orders').
sent(s_233_3_h, swe, 'ITEL vann några order').

tree(s_234_1_p, s_233_1_p).
sent(s_234_1_p, eng, 'ITEL won more orders than APCOM').
sent(s_234_1_p, original, 'ITEL won more orders than APCOM').
sent(s_234_1_p, swe, 'ITEL vann mer order än APCOM').

tree(s_234_2_q, s_231_2_q).
sent(s_234_2_q, eng, 'did APCOM win some orders').
sent(s_234_2_q, original, 'did APCOM win some orders').
sent(s_234_2_q, swe, 'vann APCOM några order').

tree(s_234_3_h, s_231_3_h).
sent(s_234_3_h, eng, 'APCOM won some orders').
sent(s_234_3_h, original, 'APCOM won some orders').
sent(s_234_3_h, swe, 'APCOM vann några order').

tree(s_235_1_p, s_233_1_p).
sent(s_235_1_p, eng, 'ITEL won more orders than APCOM').
sent(s_235_1_p, original, 'ITEL won more orders than APCOM').
sent(s_235_1_p, swe, 'ITEL vann mer order än APCOM').

tree(s_235_2_p, s_232_2_p).
sent(s_235_2_p, eng, 'APCOM won ten orders').
sent(s_235_2_p, original, 'APCOM won ten orders').
sent(s_235_2_p, swe, 'APCOM vann tio order').

tree(s_235_3_q, s_232_3_q).
sent(s_235_3_q, eng, 'did ITEL win at least eleven orders').
sent(s_235_3_q, original, 'did ITEL win at least eleven orders').
sent(s_235_3_q, swe, 'vann ITEL minst elva order').

tree(s_235_4_h, s_232_4_h).
sent(s_235_4_h, eng, 'ITEL won at least eleven orders').
sent(s_235_4_h, original, 'ITEL won at least eleven orders').
sent(s_235_4_h, swe, 'ITEL vann minst elva order').

tree(s_236_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(win_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('AdvCN', [t('AdjCN', [t('UseComparA_prefix', [t(many_A, [])]), t('UseN', [t(order_N, [])])]), t('PrepNP', [t(than_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(apcom_contract_N, [])])])])])])])])])])).
sent(s_236_1_p, eng, 'ITEL won more orders than the APCOM contract').
sent(s_236_1_p, original, 'ITEL won more orders than the APCOM contract').
sent(s_236_1_p, swe, 'ITEL vann mer order än APCOM-kontraktet').

tree(s_236_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(win_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(apcom_contract_N, [])])])])])])])])).
sent(s_236_2_q, eng, 'did ITEL win the APCOM contract').
sent(s_236_2_q, original, 'did ITEL win the APCOM contract').
sent(s_236_2_q, swe, 'vann ITEL APCOM-kontraktet').

tree(s_236_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(win_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(apcom_contract_N, [])])])])])])])).
sent(s_236_3_h, eng, 'ITEL won the APCOM contract').
sent(s_236_3_h, original, 'ITEL won the APCOM contract').
sent(s_236_3_h, swe, 'ITEL vann APCOM-kontraktet').

tree(s_237_1_p, s_236_1_p).
sent(s_237_1_p, eng, 'ITEL won more orders than the APCOM contract').
sent(s_237_1_p, original, 'ITEL won more orders than the APCOM contract').
sent(s_237_1_p, swe, 'ITEL vann mer order än APCOM-kontraktet').

tree(s_237_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(win_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('AdNum', [t(more_than_AdN, []), t('NumNumeral', [t('N_one', [])])])])]), t('UseN', [t(order_N, [])])])])])])])])).
sent(s_237_2_q, eng, 'did ITEL win more than one order').
sent(s_237_2_q, original, 'did ITEL win more than one order').
sent(s_237_2_q, swe, 'vann ITEL mer än en order').

tree(s_237_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(win_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('AdNum', [t(more_than_AdN, []), t('NumNumeral', [t('N_one', [])])])])]), t('UseN', [t(order_N, [])])])])])])])).
sent(s_237_3_h, eng, 'ITEL won more than one order').
sent(s_237_3_h, original, 'ITEL won more than one order').
sent(s_237_3_h, swe, 'ITEL vann mer än en order').

tree(s_238_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(win_V2, [])]), t('DetCN', [t(twice_as_many_Det, []), t('AdvCN', [t('UseN', [t(order_N, [])]), t('PrepNP', [t(than_Prep, []), t('UsePN', [t(apcom_PN, [])])])])])])])])])).
sent(s_238_1_p, eng, 'ITEL won twice as many orders than APCOM').
sent(s_238_1_p, original, 'ITEL won twice as many orders than APCOM').
sent(s_238_1_p, swe, 'ITEL vann dubbelt så många order än APCOM').

tree(s_238_2_p, s_232_2_p).
sent(s_238_2_p, eng, 'APCOM won ten orders').
sent(s_238_2_p, original, 'APCOM won ten orders').
sent(s_238_2_p, swe, 'APCOM vann tio order').

tree(s_238_3_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(win_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_twenty', [])])])]), t('UseN', [t(order_N, [])])])])])])])])).
sent(s_238_3_q, eng, 'did ITEL win twenty orders').
sent(s_238_3_q, original, 'did ITEL win twenty orders').
sent(s_238_3_q, swe, 'vann ITEL tjugo order').

tree(s_238_4_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(win_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_twenty', [])])])]), t('UseN', [t(order_N, [])])])])])])])).
sent(s_238_4_h, eng, 'ITEL won twenty orders').
sent(s_238_4_h, original, 'ITEL won twenty orders').
sent(s_238_4_h, swe, 'ITEL vann tjugo order').

tree(s_239_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(win_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('AdvCN', [t('AdjCN', [t('UseComparA_prefix', [t(many_A, [])]), t('UseN', [t(order_N, [])])]), t('SubjS', [t(than_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(apcom_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(lose_V2, [])]), t(elliptic_NP_Pl, [])])])])])])])])])])])).
sent(s_239_1_p, eng, 'ITEL won more orders than APCOM lost [..]').
sent(s_239_1_p, original, 'ITEL won more orders than APCOM lost [..]').
sent(s_239_1_p, swe, 'ITEL vann mer order än APCOM förlorade [..]').

tree(s_239_2_q, s_230_2_q).
sent(s_239_2_q, eng, 'did ITEL win some orders').
sent(s_239_2_q, original, 'did ITEL win some orders').
sent(s_239_2_q, swe, 'vann ITEL några order').

tree(s_239_3_h, s_230_3_h).
sent(s_239_3_h, eng, 'ITEL won some orders').
sent(s_239_3_h, original, 'ITEL won some orders').
sent(s_239_3_h, swe, 'ITEL vann några order').

tree(s_240_1_p, s_239_1_p).
sent(s_240_1_p, eng, 'ITEL won more orders than APCOM lost [..]').
sent(s_240_1_p, original, 'ITEL won more orders than APCOM lost [..]').
sent(s_240_1_p, swe, 'ITEL vann mer order än APCOM förlorade [..]').

tree(s_240_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(apcom_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(lose_V2, [])]), t('DetCN', [t(somePl_Det, []), t('UseN', [t(order_N, [])])])])])])])])).
sent(s_240_2_q, eng, 'did APCOM lose some orders').
sent(s_240_2_q, original, 'did APCOM lose some orders').
sent(s_240_2_q, swe, 'förlorade APCOM några order').

tree(s_240_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(apcom_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(lose_V2, [])]), t('DetCN', [t(somePl_Det, []), t('UseN', [t(order_N, [])])])])])])])).
sent(s_240_3_h, eng, 'APCOM lost some orders').
sent(s_240_3_h, original, 'APCOM lost some orders').
sent(s_240_3_h, swe, 'APCOM förlorade några order').

tree(s_241_1_p, s_239_1_p).
sent(s_241_1_p, eng, 'ITEL won more orders than APCOM lost [..]').
sent(s_241_1_p, original, 'ITEL won more orders than APCOM lost [..]').
sent(s_241_1_p, swe, 'ITEL vann mer order än APCOM förlorade [..]').

tree(s_241_2_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(apcom_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(lose_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_ten', [])])])]), t('UseN', [t(order_N, [])])])])])])])).
sent(s_241_2_p, eng, 'APCOM lost ten orders').
sent(s_241_2_p, original, 'APCOM lost ten orders').
sent(s_241_2_p, swe, 'APCOM förlorade tio order').

tree(s_241_3_q, s_232_3_q).
sent(s_241_3_q, eng, 'did ITEL win at least eleven orders').
sent(s_241_3_q, original, 'did ITEL win at least eleven orders').
sent(s_241_3_q, swe, 'vann ITEL minst elva order').

tree(s_241_4_h, s_232_4_h).
sent(s_241_4_h, eng, 'ITEL won at least eleven orders').
sent(s_241_4_h, original, 'ITEL won at least eleven orders').
sent(s_241_4_h, swe, 'ITEL vann minst elva order').

tree(s_242_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(pc6082_N, [])])]), t('UseComp', [t('CompAP', [t('ComparA', [t(fast_A, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_500', [])])])]), t('UseN', [t(mips_N, [])])])])])])])])])).
sent(s_242_1_p, eng, 'the PC-6082 is faster than 500 MIPS').
sent(s_242_1_p, original, 'the PC-6082 is faster than 500 MIPS').
sent(s_242_1_p, swe, 'PC-6082:an är snabbare än 500 MIPS').

tree(s_242_2_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(itelzx_N, [])])]), t('UseComp', [t('CompAP', [t('ComparA', [t(slow_A, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_500', [])])])]), t('UseN', [t(mips_N, [])])])])])])])])])).
sent(s_242_2_p, eng, 'the ITEL-ZX is slower than 500 MIPS').
sent(s_242_2_p, original, 'the ITEL-ZX is slower than 500 MIPS').
sent(s_242_2_p, swe, 'ITEL-ZX:an är långsammare än 500 MIPS').

tree(s_242_3_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(pc6082_N, [])])]), t('UseComp', [t('CompAP', [t('ComparA', [t(fast_A, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(itelzx_N, [])])])])])])])])])])).
sent(s_242_3_q, eng, 'is the PC-6082 faster than the ITEL-ZX').
sent(s_242_3_q, original, 'is the PC-6082 faster than the ITEL-ZX').
sent(s_242_3_q, swe, 'är PC-6082:an snabbare än ITEL-ZX:an').

tree(s_242_4_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(pc6082_N, [])])]), t('UseComp', [t('CompAP', [t('ComparA', [t(fast_A, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(itelzx_N, [])])])])])])])])])).
sent(s_242_4_h, eng, 'the PC-6082 is faster than the ITEL-ZX').
sent(s_242_4_h, original, 'the PC-6082 is faster than the ITEL-ZX').
sent(s_242_4_h, swe, 'PC-6082:an är snabbare än ITEL-ZX:an').

tree(s_243_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(sell_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_3000', [])])])]), t('AdvCN', [t('AdjCN', [t('UseComparA_prefix', [t(many_A, [])]), t('UseN', [t(computer_N, [])])]), t('PrepNP', [t(than_Prep, []), t('UsePN', [t(apcom_PN, [])])])])])])])])])).
sent(s_243_1_p, eng, 'ITEL sold 3000 more computers than APCOM').
sent(s_243_1_p, original, 'ITEL sold 3000 more computers than APCOM').
sent(s_243_1_p, swe, 'ITEL sålde 3000 mer datorer än APCOM').

tree(s_243_2_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(apcom_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(sell_V2, [])]), t('PredetNP', [t(exactly_Predet, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_2500', [])])])]), t('UseN', [t(computer_N, [])])])])])])])])).
sent(s_243_2_p, eng, 'APCOM sold exactly 2500 computers').
sent(s_243_2_p, original, 'APCOM sold exactly 2500 computers').
sent(s_243_2_p, swe, 'APCOM sålde exakt 2500 datorer').

tree(s_243_3_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(sell_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_5500', [])])])]), t('UseN', [t(computer_N, [])])])])])])])])).
sent(s_243_3_q, eng, 'did ITEL sell 5500 computers').
sent(s_243_3_q, original, 'did ITEL sell 5500 computers').
sent(s_243_3_q, swe, 'sålde ITEL 5500 datorer').

tree(s_243_4_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(sell_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_5500', [])])])]), t('UseN', [t(computer_N, [])])])])])])])).
sent(s_243_4_h, eng, 'ITEL sold 5500 computers').
sent(s_243_4_h, original, 'ITEL sold 5500 computers').
sent(s_243_4_h, swe, 'ITEL sålde 5500 datorer').

tree(s_244_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(apcom_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdvCN', [t('AdjCN', [t('UseComparA_prefix', [t(important_A, [])]), t('UseN', [t(customer_N, [])])]), t('PrepNP', [t(than_Prep, []), t('UsePN', [t(itel_PN, [])])])])])])])])])).
sent(s_244_1_p, eng, 'APCOM has a more important customer than ITEL').
sent(s_244_1_p, original, 'APCOM has a more important customer than ITEL').
sent(s_244_1_p, swe, 'APCOM har en viktigare kund än ITEL').

tree(s_244_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(apcom_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdvCN', [t('AdjCN', [t('UseComparA_prefix', [t(important_A, [])]), t('UseN', [t(customer_N, [])])]), t('SubjS', [t(than_Subj, []), t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('UseComp', [t('CompNP', [t(elliptic_NP_Sg, [])])])])])])])])])])])])])).
sent(s_244_2_q, eng, 'does APCOM have a more important customer than ITEL is [..]').
sent(s_244_2_q, original, 'does APCOM have a more important customer than ITEL is [..]').
sent(s_244_2_q, swe, 'har APCOM en viktigare kund än ITEL är [..]').

tree(s_244_3_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(apcom_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdvCN', [t('AdjCN', [t('UseComparA_prefix', [t(important_A, [])]), t('UseN', [t(customer_N, [])])]), t('SubjS', [t(than_Subj, []), t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('UseComp', [t('CompNP', [t(elliptic_NP_Sg, [])])])])])])])])])])])])).
sent(s_244_3_h, eng, 'APCOM has a more important customer than ITEL is [..]').
sent(s_244_3_h, original, 'APCOM has a more important customer than ITEL is [..]').
sent(s_244_3_h, swe, 'APCOM har en viktigare kund än ITEL är [..]').

tree(s_245_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(apcom_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdjCN', [t('UseComparA_prefix', [t(important_A, [])]), t('UseN', [t(customer_N, [])])])])]), t('PrepNP', [t(than_Prep, []), t('UsePN', [t(itel_PN, [])])])])])])])).
sent(s_245_1_p, eng, 'APCOM has a more important customer than ITEL').
sent(s_245_1_p, original, 'APCOM has a more important customer than ITEL').
sent(s_245_1_p, swe, 'APCOM har en viktigare kund än ITEL').

tree(s_245_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(apcom_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdjCN', [t('UseComparA_prefix', [t(important_A, [])]), t('UseN', [t(customer_N, [])])])])]), t('SubjS', [t(than_Subj, []), t('UseCl', [t('PresentPerfect', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t(elliptic_VP, [])])])])])])])])])).
sent(s_245_2_q, eng, 'does APCOM have a more important customer than ITEL has [..]').
sent(s_245_2_q, original, 'does APCOM have a more important customer than ITEL has [..]').
sent(s_245_2_q, swe, 'har APCOM en viktigare kund än ITEL har [..]').

tree(s_245_3_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(apcom_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdjCN', [t('UseComparA_prefix', [t(important_A, [])]), t('UseN', [t(customer_N, [])])])])]), t('SubjS', [t(than_Subj, []), t('UseCl', [t('PresentPerfect', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t(elliptic_VP, [])])])])])])])])).
sent(s_245_3_h, eng, 'APCOM has a more important customer than ITEL has [..]').
sent(s_245_3_h, original, 'APCOM has a more important customer than ITEL has [..]').
sent(s_245_3_h, swe, 'APCOM har en viktigare kund än ITEL har [..]').

tree(s_246_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(pc6082_N, [])])]), t('UseComp', [t('CompAP', [t('ComparA', [t(fast_A, []), t('DetCN', [t(every_Det, []), t('UseN', [t(itel_computer_N, [])])])])])])])])])).
sent(s_246_1_p, eng, 'the PC-6082 is faster than every ITEL computer').
sent(s_246_1_p, original, 'the PC-6082 is faster than every ITEL computer').
sent(s_246_1_p, swe, 'PC-6082:an är snabbare än varje ITEL-dator').

tree(s_246_2_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(itelzx_N, [])])]), t('UseComp', [t('CompCN', [t('UseN', [t(itel_computer_N, [])])])])])])])).
sent(s_246_2_p, eng, 'the ITEL-ZX is an ITEL computer').
sent(s_246_2_p, original, 'the ITEL-ZX is an ITEL computer').
sent(s_246_2_p, swe, 'ITEL-ZX:an är en ITEL-dator').

tree(s_246_3_q, s_242_3_q).
sent(s_246_3_q, eng, 'is the PC-6082 faster than the ITEL-ZX').
sent(s_246_3_q, original, 'is the PC-6082 faster than the ITEL-ZX').
sent(s_246_3_q, swe, 'är PC-6082:an snabbare än ITEL-ZX:an').

tree(s_246_4_h, s_242_4_h).
sent(s_246_4_h, eng, 'the PC-6082 is faster than the ITEL-ZX').
sent(s_246_4_h, original, 'the PC-6082 is faster than the ITEL-ZX').
sent(s_246_4_h, swe, 'PC-6082:an är snabbare än ITEL-ZX:an').

tree(s_247_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(pc6082_N, [])])]), t('UseComp', [t('CompAP', [t('ComparA', [t(fast_A, []), t('DetCN', [t(someSg_Det, []), t('UseN', [t(itel_computer_N, [])])])])])])])])])).
sent(s_247_1_p, eng, 'the PC-6082 is faster than some ITEL computer').
sent(s_247_1_p, original, 'the PC-6082 is faster than some ITEL computer').
sent(s_247_1_p, swe, 'PC-6082:an är snabbare än någon ITEL-dator').

tree(s_247_2_p, s_246_2_p).
sent(s_247_2_p, eng, 'the ITEL-ZX is an ITEL computer').
sent(s_247_2_p, original, 'the ITEL-ZX is an ITEL computer').
sent(s_247_2_p, swe, 'ITEL-ZX:an är en ITEL-dator').

tree(s_247_3_q, s_242_3_q).
sent(s_247_3_q, eng, 'is the PC-6082 faster than the ITEL-ZX').
sent(s_247_3_q, original, 'is the PC-6082 faster than the ITEL-ZX').
sent(s_247_3_q, swe, 'är PC-6082:an snabbare än ITEL-ZX:an').

tree(s_247_4_h, s_242_4_h).
sent(s_247_4_h, eng, 'the PC-6082 is faster than the ITEL-ZX').
sent(s_247_4_h, original, 'the PC-6082 is faster than the ITEL-ZX').
sent(s_247_4_h, swe, 'PC-6082:an är snabbare än ITEL-ZX:an').

tree(s_248_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(pc6082_N, [])])]), t('UseComp', [t('CompAP', [t('ComparA', [t(fast_A, []), t('DetCN', [t(anySg_Det, []), t('UseN', [t(itel_computer_N, [])])])])])])])])])).
sent(s_248_1_p, eng, 'the PC-6082 is faster than any ITEL computer').
sent(s_248_1_p, original, 'the PC-6082 is faster than any ITEL computer').
sent(s_248_1_p, swe, 'PC-6082:an är snabbare än någon ITEL-dator').

tree(s_248_2_p, s_246_2_p).
sent(s_248_2_p, eng, 'the ITEL-ZX is an ITEL computer').
sent(s_248_2_p, original, 'the ITEL-ZX is an ITEL computer').
sent(s_248_2_p, swe, 'ITEL-ZX:an är en ITEL-dator').

tree(s_248_3_q, s_242_3_q).
sent(s_248_3_q, eng, 'is the PC-6082 faster than the ITEL-ZX').
sent(s_248_3_q, original, 'is the PC-6082 faster than the ITEL-ZX').
sent(s_248_3_q, swe, 'är PC-6082:an snabbare än ITEL-ZX:an').

tree(s_248_4_h, s_242_4_h).
sent(s_248_4_h, eng, 'the PC-6082 is faster than the ITEL-ZX').
sent(s_248_4_h, original, 'the PC-6082 is faster than the ITEL-ZX').
sent(s_248_4_h, swe, 'PC-6082:an är snabbare än ITEL-ZX:an').

tree(s_249_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(pc6082_N, [])])]), t('UseComp', [t('CompAP', [t('ComparA', [t(fast_A, []), t('ConjNP2', [t(and_Conj, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(itelzx_N, [])])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(itelzy_N, [])])])])])])])])])])).
sent(s_249_1_p, eng, 'the PC-6082 is faster than the ITEL-ZX and the ITEL-ZY').
sent(s_249_1_p, original, 'the PC-6082 is faster than the ITEL-ZX and the ITEL-ZY').
sent(s_249_1_p, swe, 'PC-6082:an är snabbare än ITEL-ZX:an och ITEL-ZY:an').

tree(s_249_2_q, s_242_3_q).
sent(s_249_2_q, eng, 'is the PC-6082 faster than the ITEL-ZX').
sent(s_249_2_q, original, 'is the PC-6082 faster than the ITEL-ZX').
sent(s_249_2_q, swe, 'är PC-6082:an snabbare än ITEL-ZX:an').

tree(s_249_3_h, s_242_4_h).
sent(s_249_3_h, eng, 'the PC-6082 is faster than the ITEL-ZX').
sent(s_249_3_h, original, 'the PC-6082 is faster than the ITEL-ZX').
sent(s_249_3_h, swe, 'PC-6082:an är snabbare än ITEL-ZX:an').

tree(s_250_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(pc6082_N, [])])]), t('UseComp', [t('CompAP', [t('ComparA', [t(fast_A, []), t('ConjNP2', [t(or_Conj, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(itelzx_N, [])])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(itelzy_N, [])])])])])])])])])])).
sent(s_250_1_p, eng, 'the PC-6082 is faster than the ITEL-ZX or the ITEL-ZY').
sent(s_250_1_p, original, 'the PC-6082 is faster than the ITEL-ZX or the ITEL-ZY').
sent(s_250_1_p, swe, 'PC-6082:an är snabbare än ITEL-ZX:an eller ITEL-ZY:an').

tree(s_250_2_q, s_242_3_q).
sent(s_250_2_q, eng, 'is the PC-6082 faster than the ITEL-ZX').
sent(s_250_2_q, original, 'is the PC-6082 faster than the ITEL-ZX').
sent(s_250_2_q, swe, 'är PC-6082:an snabbare än ITEL-ZX:an').

tree(s_250_3_h, s_242_4_h).
sent(s_250_3_h, eng, 'the PC-6082 is faster than the ITEL-ZX').
sent(s_250_3_h, original, 'the PC-6082 is faster than the ITEL-ZX').
sent(s_250_3_h, swe, 'PC-6082:an är snabbare än ITEL-ZX:an').

tree(s_251_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(factory_N, [])])])]), t('PrepNP', [t(in_Prep, []), t('UsePN', [t(birmingham_PN, [])])])])])])])).
sent(s_251_1_p, eng, 'ITEL has a factory in Birmingham').
sent(s_251_1_p, original, 'ITEL has a factory in Birmingham').
sent(s_251_1_p, swe, 'ITEL har en fabrik i Birmingham').

tree(s_251_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('AdVVP', [t(currently_AdV, []), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(factory_N, [])])])]), t('PrepNP', [t(in_Prep, []), t('UsePN', [t(birmingham_PN, [])])])])])])])])])).
sent(s_251_2_q, eng, 'does ITEL currently have a factory in Birmingham').
sent(s_251_2_q, original, 'does ITEL currently have a factory in Birmingham').
sent(s_251_2_q, swe, 'har ITEL för närvarande en fabrik i Birmingham').

tree(s_251_3_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('AdVVP', [t(currently_AdV, []), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(have_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(factory_N, [])])])]), t('PrepNP', [t(in_Prep, []), t('UsePN', [t(birmingham_PN, [])])])])])])])])).
sent(s_251_3_h, eng, 'ITEL currently has a factory in Birmingham').
sent(s_251_3_h, original, 'ITEL currently has a factory in Birmingham').
sent(s_251_3_h, swe, 'ITEL har för närvarande en fabrik i Birmingham').

tree(s_252_1_p, t('Sentence', [t('AdvS', [t(since_1992_Adv, []), t('UseCl', [t('PresentPerfect', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('UseComp', [t('CompAdv', [t('PrepNP', [t(in_Prep, []), t('UsePN', [t(birmingham_PN, [])])])])])])])])])).
sent(s_252_1_p, eng, 'since 1992 ITEL has been in Birmingham').
sent(s_252_1_p, original, 'since 1992 ITEL has been in Birmingham').
sent(s_252_1_p, swe, 'sedan 1992 har ITEL varit i Birmingham').

tree(s_252_2_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('ImpersCl', [t('AdVVP', [t(now_AdV, []), t('UseComp', [t('CompAdv', [t(year_1996_Adv, [])])])])])])])).
sent(s_252_2_p, eng, 'it is now 1996').
sent(s_252_2_p, original, 'it is now 1996').
sent(s_252_2_p, swe, 'det är nu 1996').

tree(s_252_3_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('AdvVP', [t('UseComp', [t('CompAdv', [t('PrepNP', [t(in_Prep, []), t('UsePN', [t(birmingham_PN, [])])])])]), t(in_1993_Adv, [])])])])])])).
sent(s_252_3_q, eng, 'was ITEL in Birmingham in 1993').
sent(s_252_3_q, original, 'was ITEL in Birmingham in 1993').
sent(s_252_3_q, swe, 'var ITEL i Birmingham 1993').

tree(s_252_4_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('AdvVP', [t('UseComp', [t('CompAdv', [t('PrepNP', [t(in_Prep, []), t('UsePN', [t(birmingham_PN, [])])])])]), t(in_1993_Adv, [])])])])])).
sent(s_252_4_h, eng, 'ITEL was in Birmingham in 1993').
sent(s_252_4_h, original, 'ITEL was in Birmingham in 1993').
sent(s_252_4_h, swe, 'ITEL var i Birmingham 1993').

tree(s_253_1_p, t('Sentence', [t('UseCl', [t('PresentPerfect', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(develop_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(new_A, [])]), t('UseN', [t(editor_N, [])])])])]), t(since_1992_Adv, [])])])])])).
sent(s_253_1_p, eng, 'ITEL has developed a new editor since 1992').
sent(s_253_1_p, original, 'ITEL has developed a new editor since 1992').
sent(s_253_1_p, swe, 'ITEL har utvecklat en ny redigerare sedan 1992').

tree(s_253_2_p, s_252_2_p).
sent(s_253_2_p, eng, 'it is now 1996').
sent(s_253_2_p, original, 'it is now 1996').
sent(s_253_2_p, swe, 'det är nu 1996').

tree(s_253_3_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(develop_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(new_A, [])]), t('UseN', [t(editor_N, [])])])])]), t(in_1993_Adv, [])])])])])])).
sent(s_253_3_q, eng, 'did ITEL develop a new editor in 1993').
sent(s_253_3_q, original, 'did ITEL develop a new editor in 1993').
sent(s_253_3_q, swe, 'utvecklade ITEL en ny redigerare 1993').

tree(s_253_4_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(develop_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(new_A, [])]), t('UseN', [t(editor_N, [])])])])]), t(in_1993_Adv, [])])])])])).
sent(s_253_4_h, eng, 'ITEL developed a new editor in 1993').
sent(s_253_4_h, original, 'ITEL developed a new editor in 1993').
sent(s_253_4_h, swe, 'ITEL utvecklade en ny redigerare 1993').

tree(s_254_1_p, t('Sentence', [t('UseCl', [t('PresentPerfect', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('AdvVP', [t('UseV', [t(expand_V, [])]), t(since_1992_Adv, [])])])])])).
sent(s_254_1_p, eng, 'ITEL has expanded since 1992').
sent(s_254_1_p, original, 'ITEL has expanded since 1992').
sent(s_254_1_p, swe, 'ITEL har expanderat sedan 1992').

tree(s_254_2_p, s_252_2_p).
sent(s_254_2_p, eng, 'it is now 1996').
sent(s_254_2_p, original, 'it is now 1996').
sent(s_254_2_p, swe, 'det är nu 1996').

tree(s_254_3_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('AdvVP', [t('UseV', [t(expand_V, [])]), t(in_1993_Adv, [])])])])])])).
sent(s_254_3_q, eng, 'did ITEL expand in 1993').
sent(s_254_3_q, original, 'did ITEL expand in 1993').
sent(s_254_3_q, swe, 'expanderade ITEL 1993').

tree(s_254_4_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('AdvVP', [t('UseV', [t(expand_V, [])]), t(in_1993_Adv, [])])])])])).
sent(s_254_4_h, eng, 'ITEL expanded in 1993').
sent(s_254_4_h, original, 'ITEL expanded in 1993').
sent(s_254_4_h, swe, 'ITEL expanderade 1993').

tree(s_255_1_p, t('Sentence', [t('AdvS', [t(since_1992_Adv, []), t('UseCl', [t('PresentPerfect', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(make8do_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(loss_N, [])])])])])])])])).
sent(s_255_1_p, eng, 'since 1992 ITEL has made a loss').
sent(s_255_1_p, original, 'since 1992 ITEL has made a loss').
sent(s_255_1_p, swe, 'sedan 1992 har ITEL gjort en förlust').

tree(s_255_2_p, s_252_2_p).
sent(s_255_2_p, eng, 'it is now 1996').
sent(s_255_2_p, original, 'it is now 1996').
sent(s_255_2_p, swe, 'det är nu 1996').

tree(s_255_3_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(make8do_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(loss_N, [])])])]), t(in_1993_Adv, [])])])])])])).
sent(s_255_3_q, eng, 'did ITEL make a loss in 1993').
sent(s_255_3_q, original, 'did ITEL make a loss in 1993').
sent(s_255_3_q, swe, 'gjorde ITEL en förlust 1993').

tree(s_255_4_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(make8do_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(loss_N, [])])])]), t(in_1993_Adv, [])])])])])).
sent(s_255_4_h, eng, 'ITEL made a loss in 1993').
sent(s_255_4_h, original, 'ITEL made a loss in 1993').
sent(s_255_4_h, swe, 'ITEL gjorde en förlust 1993').

tree(s_256_1_p, t('Sentence', [t('UseCl', [t('PresentPerfect', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(make8do_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(loss_N, [])])])]), t(since_1992_Adv, [])])])])])).
sent(s_256_1_p, eng, 'ITEL has made a loss since 1992').
sent(s_256_1_p, original, 'ITEL has made a loss since 1992').
sent(s_256_1_p, swe, 'ITEL har gjort en förlust sedan 1992').

tree(s_256_2_p, s_252_2_p).
sent(s_256_2_p, eng, 'it is now 1996').
sent(s_256_2_p, original, 'it is now 1996').
sent(s_256_2_p, swe, 'det är nu 1996').

tree(s_256_3_q, s_255_3_q).
sent(s_256_3_q, eng, 'did ITEL make a loss in 1993').
sent(s_256_3_q, original, 'did ITEL make a loss in 1993').
sent(s_256_3_q, swe, 'gjorde ITEL en förlust 1993').

tree(s_256_4_h, s_255_4_h).
sent(s_256_4_h, eng, 'ITEL made a loss in 1993').
sent(s_256_4_h, original, 'ITEL made a loss in 1993').
sent(s_256_4_h, swe, 'ITEL gjorde en förlust 1993').

tree(s_257_1_p, s_256_1_p).
sent(s_257_1_p, eng, 'ITEL has made a loss since 1992').
sent(s_257_1_p, original, 'ITEL has made a loss since 1992').
sent(s_257_1_p, swe, 'ITEL har gjort en förlust sedan 1992').

tree(s_257_2_p, s_252_2_p).
sent(s_257_2_p, eng, 'it is now 1996').
sent(s_257_2_p, original, 'it is now 1996').
sent(s_257_2_p, swe, 'det är nu 1996').

tree(s_257_3_q, s_255_3_q).
sent(s_257_3_q, eng, 'did ITEL make a loss in 1993').
sent(s_257_3_q, original, 'did ITEL make a loss in 1993').
sent(s_257_3_q, swe, 'gjorde ITEL en förlust 1993').

tree(s_257_4_h, s_255_4_h).
sent(s_257_4_h, eng, 'ITEL made a loss in 1993').
sent(s_257_4_h, original, 'ITEL made a loss in 1993').
sent(s_257_4_h, swe, 'ITEL gjorde en förlust 1993').

tree(s_258_1_p, t('Sentence', [t('AdvS', [t(in_march_1993_Adv, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(apcom_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(found_V2, [])]), t('UsePN', [t(itel_PN, [])])])])])])])).
sent(s_258_1_p, eng, 'in March 1993 APCOM founded ITEL').
sent(s_258_1_p, original, 'in March 1993 APCOM founded ITEL').
sent(s_258_1_p, swe, 'i mars 1993 grundade APCOM ITEL').

tree(s_258_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('AdvVP', [t('UseV', [t(exist_V, [])]), t(in_1992_Adv, [])])])])])])).
sent(s_258_2_q, eng, 'did ITEL exist in 1992').
sent(s_258_2_q, original, 'did ITEL exist in 1992').
sent(s_258_2_q, swe, 'fanns ITEL 1992').

tree(s_258_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('AdvVP', [t('UseV', [t(exist_V, [])]), t(in_1992_Adv, [])])])])])).
sent(s_258_3_h, eng, 'ITEL existed in 1992').
sent(s_258_3_h, original, 'ITEL existed in 1992').
sent(s_258_3_h, swe, 'ITEL fanns 1992').

tree(s_259_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(conference_N, [])])]), t('AdvVP', [t('UseV', [t(start_V, [])]), t(on_july_4th_1994_Adv, [])])])])])).
sent(s_259_1_p, eng, 'the conference started on July 4th , 1994').
sent(s_259_1_p, original, 'the conference started on July 4th , 1994').
sent(s_259_1_p, swe, 'konferensen började 4:e juli 1994').

tree(s_259_2_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('ImpersCl', [t('ComplSlash', [t('SlashV2a', [t(last_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_2', [])])])]), t('UseN', [t(day_N, [])])])])])])])).
sent(s_259_2_p, eng, 'it lasted 2 days').
sent(s_259_2_p, original, 'it lasted 2 days').
sent(s_259_2_p, swe, 'det varade 2 dagar').

tree(s_259_3_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(conference_N, [])])]), t('AdvVP', [t('UseComp', [t('CompAdv', [t(over_Adv, [])])]), t(on_july_8th_1994_Adv, [])])])])])])).
sent(s_259_3_q, eng, 'was the conference over on July 8th , 1994').
sent(s_259_3_q, original, 'was the conference over on July 8th , 1994').
sent(s_259_3_q, swe, 'var konferensen slut 8:e juli 1994').

tree(s_259_4_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(conference_N, [])])]), t('AdvVP', [t('UseComp', [t('CompAdv', [t(over_Adv, [])])]), t(on_july_8th_1994_Adv, [])])])])])).
sent(s_259_4_h, eng, 'the conference was over on July 8th , 1994').
sent(s_259_4_h, original, 'the conference was over on July 8th , 1994').
sent(s_259_4_h, swe, 'konferensen var slut 8:e juli 1994').

tree(s_260_1_p, t('Sentence', [t('AdvS', [t(yesterday_Adv, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(apcom_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(sign_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])])])])])])).
sent(s_260_1_p, eng, 'yesterday APCOM signed the contract').
sent(s_260_1_p, original, 'yesterday APCOM signed the contract').
sent(s_260_1_p, swe, 'igår undertecknade APCOM kontraktet').

tree(s_260_2_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('MassNP', [t('UseN', [t(today_N, [])])]), t('UseComp', [t('CompAdv', [t(saturday_july_14th_Adv, [])])])])])])).
sent(s_260_2_p, eng, 'today is Saturday , July 14th').
sent(s_260_2_p, original, 'today is Saturday , July 14th').
sent(s_260_2_p, swe, 'idag är lördagen den 14 juli').

tree(s_260_3_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(apcom_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(sign_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])]), t(friday_13th_Adv, [])])])])])])).
sent(s_260_3_q, eng, 'did APCOM sign the contract Friday , 13th').
sent(s_260_3_q, original, 'did APCOM sign the contract Friday , 13th').
sent(s_260_3_q, swe, 'undertecknade APCOM kontraktet fredagen den 13:e').

tree(s_260_4_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(apcom_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(sign_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])]), t(friday_13th_Adv, [])])])])])).
sent(s_260_4_h, eng, 'APCOM signed the contract Friday , 13th').
sent(s_260_4_h, original, 'APCOM signed the contract Friday , 13th').
sent(s_260_4_h, swe, 'APCOM undertecknade kontraktet fredagen den 13:e').

tree(s_261_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('UseV', [t(leave_V, [])]), t('SubjS', [t(before_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('UseV', [t(leave_V, [])])])])])])])])])).
sent(s_261_1_p, eng, 'Smith left before Jones left').
sent(s_261_1_p, original, 'Smith left before Jones left').
sent(s_261_1_p, swe, 'Smith gick innan Jones gick').

tree(s_261_2_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('AdvVP', [t('UseV', [t(leave_V, [])]), t('SubjS', [t(before_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(anderson_PN, [])]), t('UseV', [t(leave_V, [])])])])])])])])])).
sent(s_261_2_p, eng, 'Jones left before Anderson left').
sent(s_261_2_p, original, 'Jones left before Anderson left').
sent(s_261_2_p, swe, 'Jones gick innan Anderson gick').

tree(s_261_3_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('UseV', [t(leave_V, [])]), t('SubjS', [t(before_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(anderson_PN, [])]), t('UseV', [t(leave_V, [])])])])])])])])])])).
sent(s_261_3_q, eng, 'did Smith leave before Anderson left').
sent(s_261_3_q, original, 'did Smith leave before Anderson left').
sent(s_261_3_q, swe, 'gick Smith innan Anderson gick').

tree(s_261_4_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('UseV', [t(leave_V, [])]), t('SubjS', [t(before_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(anderson_PN, [])]), t('UseV', [t(leave_V, [])])])])])])])])])).
sent(s_261_4_h, eng, 'Smith left before Anderson left').
sent(s_261_4_h, original, 'Smith left before Anderson left').
sent(s_261_4_h, swe, 'Smith gick innan Anderson gick').

tree(s_262_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('UseV', [t(leave_V, [])]), t('SubjS', [t(after_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('UseV', [t(leave_V, [])])])])])])])])])).
sent(s_262_1_p, eng, 'Smith left after Jones left').
sent(s_262_1_p, original, 'Smith left after Jones left').
sent(s_262_1_p, swe, 'Smith gick efter det att Jones gick').

tree(s_262_2_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('AdvVP', [t('UseV', [t(leave_V, [])]), t('SubjS', [t(after_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(anderson_PN, [])]), t('UseV', [t(leave_V, [])])])])])])])])])).
sent(s_262_2_p, eng, 'Jones left after Anderson left').
sent(s_262_2_p, original, 'Jones left after Anderson left').
sent(s_262_2_p, swe, 'Jones gick efter det att Anderson gick').

tree(s_262_3_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('UseV', [t(leave_V, [])]), t('SubjS', [t(after_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(anderson_PN, [])]), t('UseV', [t(leave_V, [])])])])])])])])])])).
sent(s_262_3_q, eng, 'did Smith leave after Anderson left').
sent(s_262_3_q, original, 'did Smith leave after Anderson left').
sent(s_262_3_q, swe, 'gick Smith efter det att Anderson gick').

tree(s_262_4_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('UseV', [t(leave_V, [])]), t('SubjS', [t(after_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(anderson_PN, [])]), t('UseV', [t(leave_V, [])])])])])])])])])).
sent(s_262_4_h, eng, 'Smith left after Anderson left').
sent(s_262_4_h, original, 'Smith left after Anderson left').
sent(s_262_4_h, swe, 'Smith gick efter det att Anderson gick').

tree(s_263_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('UseComp', [t('CompAP', [t('PositA', [t(present8attending_A, [])])])]), t('SubjS', [t(after_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('UseV', [t(leave_V, [])])])])])])])])])).
sent(s_263_1_p, eng, 'Smith was present after Jones left').
sent(s_263_1_p, original, 'Smith was present after Jones left').
sent(s_263_1_p, swe, 'Smith var närvarande efter det att Jones gick').

tree(s_263_2_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('AdvVP', [t('UseV', [t(leave_V, [])]), t('SubjS', [t(after_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(anderson_PN, [])]), t('UseComp', [t('CompAP', [t('PositA', [t(present8attending_A, [])])])])])])])])])])])).
sent(s_263_2_p, eng, 'Jones left after Anderson was present').
sent(s_263_2_p, original, 'Jones left after Anderson was present').
sent(s_263_2_p, swe, 'Jones gick efter det att Anderson var närvarande').

tree(s_263_3_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('UseComp', [t('CompAP', [t('PositA', [t(present8attending_A, [])])])]), t('SubjS', [t(after_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(anderson_PN, [])]), t('UseComp', [t('CompAP', [t('PositA', [t(present8attending_A, [])])])])])])])])])])])])).
sent(s_263_3_q, eng, 'was Smith present after Anderson was present').
sent(s_263_3_q, original, 'was Smith present after Anderson was present').
sent(s_263_3_q, swe, 'var Smith närvarande efter det att Anderson var närvarande').

tree(s_263_4_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('UseComp', [t('CompAP', [t('PositA', [t(present8attending_A, [])])])]), t('SubjS', [t(after_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(anderson_PN, [])]), t('UseComp', [t('CompAP', [t('PositA', [t(present8attending_A, [])])])])])])])])])])])).
sent(s_263_4_h, eng, 'Smith was present after Anderson was present').
sent(s_263_4_h, original, 'Smith was present after Anderson was present').
sent(s_263_4_h, swe, 'Smith var närvarande efter det att Anderson var närvarande').

tree(s_264_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('UseV', [t(leave_V, [])])])])])).
sent(s_264_1_p, eng, 'Smith left').
sent(s_264_1_p, original, 'Smith left').
sent(s_264_1_p, swe, 'Smith gick').

tree(s_264_2_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('UseV', [t(leave_V, [])])])])])).
sent(s_264_2_p, eng, 'Jones left').
sent(s_264_2_p, original, 'Jones left').
sent(s_264_2_p, swe, 'Jones gick').

tree(s_264_3_p, s_261_1_p).
sent(s_264_3_p, eng, 'Smith left before Jones left').
sent(s_264_3_p, original, 'Smith left before Jones left').
sent(s_264_3_p, swe, 'Smith gick innan Jones gick').

tree(s_264_4_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('AdvVP', [t('UseV', [t(leave_V, [])]), t('SubjS', [t(after_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('UseV', [t(leave_V, [])])])])])])])])])])).
sent(s_264_4_q, eng, 'did Jones leave after Smith left').
sent(s_264_4_q, original, 'did Jones leave after Smith left').
sent(s_264_4_q, swe, 'gick Jones efter det att Smith gick').

tree(s_264_5_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('AdvVP', [t('UseV', [t(leave_V, [])]), t('SubjS', [t(after_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('UseV', [t(leave_V, [])])])])])])])])])).
sent(s_264_5_h, eng, 'Jones left after Smith left').
sent(s_264_5_h, original, 'Jones left after Smith left').
sent(s_264_5_h, swe, 'Jones gick efter det att Smith gick').

tree(s_265_1_p, s_264_1_p).
sent(s_265_1_p, eng, 'Smith left').
sent(s_265_1_p, original, 'Smith left').
sent(s_265_1_p, swe, 'Smith gick').

tree(s_265_2_p, s_264_2_p).
sent(s_265_2_p, eng, 'Jones left').
sent(s_265_2_p, original, 'Jones left').
sent(s_265_2_p, swe, 'Jones gick').

tree(s_265_3_p, s_262_1_p).
sent(s_265_3_p, eng, 'Smith left after Jones left').
sent(s_265_3_p, original, 'Smith left after Jones left').
sent(s_265_3_p, swe, 'Smith gick efter det att Jones gick').

tree(s_265_4_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('AdvVP', [t('UseV', [t(leave_V, [])]), t('SubjS', [t(before_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('UseV', [t(leave_V, [])])])])])])])])])])).
sent(s_265_4_q, eng, 'did Jones leave before Smith left').
sent(s_265_4_q, original, 'did Jones leave before Smith left').
sent(s_265_4_q, swe, 'gick Jones innan Smith gick').

tree(s_265_5_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('AdvVP', [t('UseV', [t(leave_V, [])]), t('SubjS', [t(before_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('UseV', [t(leave_V, [])])])])])])])])])).
sent(s_265_5_h, eng, 'Jones left before Smith left').
sent(s_265_5_h, original, 'Jones left before Smith left').
sent(s_265_5_h, swe, 'Jones gick innan Smith gick').

tree(s_266_1_p, s_264_1_p).
sent(s_266_1_p, eng, 'Smith left').
sent(s_266_1_p, original, 'Smith left').
sent(s_266_1_p, swe, 'Smith gick').

tree(s_266_2_p, s_264_2_p).
sent(s_266_2_p, eng, 'Jones left').
sent(s_266_2_p, original, 'Jones left').
sent(s_266_2_p, swe, 'Jones gick').

tree(s_266_3_p, s_265_5_h).
sent(s_266_3_p, eng, 'Jones left before Smith left').
sent(s_266_3_p, original, 'Jones left before Smith left').
sent(s_266_3_p, swe, 'Jones gick innan Smith gick').

tree(s_266_4_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('UseV', [t(leave_V, [])]), t('SubjS', [t(after_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('UseV', [t(leave_V, [])])])])])])])])])])).
sent(s_266_4_q, eng, 'did Smith leave after Jones left').
sent(s_266_4_q, original, 'did Smith leave after Jones left').
sent(s_266_4_q, swe, 'gick Smith efter det att Jones gick').

tree(s_266_5_h, s_262_1_p).
sent(s_266_5_h, eng, 'Smith left after Jones left').
sent(s_266_5_h, original, 'Smith left after Jones left').
sent(s_266_5_h, swe, 'Smith gick efter det att Jones gick').

tree(s_267_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(revise_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])])])])])).
sent(s_267_1_p, eng, 'Jones revised the contract').
sent(s_267_1_p, original, 'Jones revised the contract').
sent(s_267_1_p, swe, 'Jones granskade kontraktet').

tree(s_267_2_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(revise_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])])])])])).
sent(s_267_2_p, eng, 'Smith revised the contract').
sent(s_267_2_p, original, 'Smith revised the contract').
sent(s_267_2_p, swe, 'Smith granskade kontraktet').

tree(s_267_3_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(revise_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])]), t('SubjS', [t(before_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplVV', [t(do_VV, []), t(elliptic_VP, [])])])])])])])])])).
sent(s_267_3_p, eng, 'Jones revised the contract before Smith did [..]').
sent(s_267_3_p, original, 'Jones revised the contract before Smith did [..]').
sent(s_267_3_p, swe, 'Jones granskade kontraktet innan Smith gjorde [..]').

tree(s_267_4_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(revise_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])]), t('SubjS', [t(after_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('ComplVV', [t(do_VV, []), t(elliptic_VP, [])])])])])])])])])])).
sent(s_267_4_q, eng, 'did Smith revise the contract after Jones did [..]').
sent(s_267_4_q, original, 'did Smith revise the contract after Jones did [..]').
sent(s_267_4_q, swe, 'granskade Smith kontraktet efter det att Jones gjorde [..]').

tree(s_267_5_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(revise_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])]), t('SubjS', [t(after_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('ComplVV', [t(do_VV, []), t(elliptic_VP, [])])])])])])])])])).
sent(s_267_5_h, eng, 'Smith revised the contract after Jones did [..]').
sent(s_267_5_h, original, 'Smith revised the contract after Jones did [..]').
sent(s_267_5_h, swe, 'Smith granskade kontraktet efter det att Jones gjorde [..]').

tree(s_268_1_p, s_267_1_p).
sent(s_268_1_p, eng, 'Jones revised the contract').
sent(s_268_1_p, original, 'Jones revised the contract').
sent(s_268_1_p, swe, 'Jones granskade kontraktet').

tree(s_268_2_p, s_267_2_p).
sent(s_268_2_p, eng, 'Smith revised the contract').
sent(s_268_2_p, original, 'Smith revised the contract').
sent(s_268_2_p, swe, 'Smith granskade kontraktet').

tree(s_268_3_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(revise_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])]), t('SubjS', [t(after_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplVV', [t(do_VV, []), t(elliptic_VP, [])])])])])])])])])).
sent(s_268_3_p, eng, 'Jones revised the contract after Smith did [..]').
sent(s_268_3_p, original, 'Jones revised the contract after Smith did [..]').
sent(s_268_3_p, swe, 'Jones granskade kontraktet efter det att Smith gjorde [..]').

tree(s_268_4_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(revise_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])]), t('SubjS', [t(before_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('ComplVV', [t(do_VV, []), t(elliptic_VP, [])])])])])])])])])])).
sent(s_268_4_q, eng, 'did Smith revise the contract before Jones did [..]').
sent(s_268_4_q, original, 'did Smith revise the contract before Jones did [..]').
sent(s_268_4_q, swe, 'granskade Smith kontraktet innan Jones gjorde [..]').

tree(s_268_5_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(revise_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])]), t('SubjS', [t(before_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('ComplVV', [t(do_VV, []), t(elliptic_VP, [])])])])])])])])])).
sent(s_268_5_h, eng, 'Smith revised the contract before Jones did [..]').
sent(s_268_5_h, original, 'Smith revised the contract before Jones did [..]').
sent(s_268_5_h, swe, 'Smith granskade kontraktet innan Jones gjorde [..]').

tree(s_269_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('UseV', [t(swim_V, [])])])])])).
sent(s_269_1_p, eng, 'Smith swam').
sent(s_269_1_p, original, 'Smith swam').
sent(s_269_1_p, swe, 'Smith simmade').

tree(s_269_2_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('UseV', [t(swim_V, [])])])])])).
sent(s_269_2_p, eng, 'Jones swam').
sent(s_269_2_p, original, 'Jones swam').
sent(s_269_2_p, swe, 'Jones simmade').

tree(s_269_3_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('UseV', [t(swim_V, [])]), t('SubjS', [t(before_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('UseV', [t(swim_V, [])])])])])])])])])).
sent(s_269_3_p, eng, 'Smith swam before Jones swam').
sent(s_269_3_p, original, 'Smith swam before Jones swam').
sent(s_269_3_p, swe, 'Smith simmade innan Jones simmade').

tree(s_269_4_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('AdvVP', [t('UseV', [t(swim_V, [])]), t('SubjS', [t(after_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('UseV', [t(swim_V, [])])])])])])])])])])).
sent(s_269_4_q, eng, 'did Jones swim after Smith swam').
sent(s_269_4_q, original, 'did Jones swim after Smith swam').
sent(s_269_4_q, swe, 'simmade Jones efter det att Smith simmade').

tree(s_269_5_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('AdvVP', [t('UseV', [t(swim_V, [])]), t('SubjS', [t(after_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('UseV', [t(swim_V, [])])])])])])])])])).
sent(s_269_5_h, eng, 'Jones swam after Smith swam').
sent(s_269_5_h, original, 'Jones swam after Smith swam').
sent(s_269_5_h, swe, 'Jones simmade efter det att Smith simmade').

tree(s_270_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('UseV', [t(swim_V, [])]), t('PrepNP', [t(to_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(shore_N, [])])])])])])])])).
sent(s_270_1_p, eng, 'Smith swam to the shore').
sent(s_270_1_p, original, 'Smith swam to the shore').
sent(s_270_1_p, swe, 'Smith simmade till stranden').

tree(s_270_2_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('AdvVP', [t('UseV', [t(swim_V, [])]), t('PrepNP', [t(to_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(shore_N, [])])])])])])])])).
sent(s_270_2_p, eng, 'Jones swam to the shore').
sent(s_270_2_p, original, 'Jones swam to the shore').
sent(s_270_2_p, swe, 'Jones simmade till stranden').

tree(s_270_3_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('AdvVP', [t('UseV', [t(swim_V, [])]), t('PrepNP', [t(to_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(shore_N, [])])])])]), t('SubjS', [t(before_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('AdvVP', [t('UseV', [t(swim_V, [])]), t('PrepNP', [t(to_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(shore_N, [])])])])])])])])])])])])).
sent(s_270_3_p, eng, 'Smith swam to the shore before Jones swam to the shore').
sent(s_270_3_p, original, 'Smith swam to the shore before Jones swam to the shore').
sent(s_270_3_p, swe, 'Smith simmade till stranden innan Jones simmade till stranden').

tree(s_270_4_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('AdvVP', [t('AdvVP', [t('UseV', [t(swim_V, [])]), t('PrepNP', [t(to_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(shore_N, [])])])])]), t('SubjS', [t(after_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('UseV', [t(swim_V, [])]), t('PrepNP', [t(to_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(shore_N, [])])])])])])])])])])])])])).
sent(s_270_4_q, eng, 'did Jones swim to the shore after Smith swam to the shore').
sent(s_270_4_q, original, 'did Jones swim to the shore after Smith swam to the shore').
sent(s_270_4_q, swe, 'simmade Jones till stranden efter det att Smith simmade till stranden').

tree(s_270_5_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('AdvVP', [t('AdvVP', [t('UseV', [t(swim_V, [])]), t('PrepNP', [t(to_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(shore_N, [])])])])]), t('SubjS', [t(after_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('UseV', [t(swim_V, [])]), t('PrepNP', [t(to_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(shore_N, [])])])])])])])])])])])])).
sent(s_270_5_h, eng, 'Jones swam to the shore after Smith swam to the shore').
sent(s_270_5_h, original, 'Jones swam to the shore after Smith swam to the shore').
sent(s_270_5_h, swe, 'Jones simmade till stranden efter det att Smith simmade till stranden').

tree(s_271_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('UseComp', [t('CompAP', [t('PositA', [t(present8attending_A, [])])])])])])])).
sent(s_271_1_p, eng, 'Smith was present').
sent(s_271_1_p, original, 'Smith was present').
sent(s_271_1_p, swe, 'Smith var närvarande').

tree(s_271_2_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('UseComp', [t('CompAP', [t('PositA', [t(present8attending_A, [])])])])])])])).
sent(s_271_2_p, eng, 'Jones was present').
sent(s_271_2_p, original, 'Jones was present').
sent(s_271_2_p, swe, 'Jones var närvarande').

tree(s_271_3_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('UseComp', [t('CompAP', [t('PositA', [t(present8attending_A, [])])])]), t('SubjS', [t(after_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('UseComp', [t('CompAP', [t('PositA', [t(present8attending_A, [])])])])])])])])])])])).
sent(s_271_3_p, eng, 'Smith was present after Jones was present').
sent(s_271_3_p, original, 'Smith was present after Jones was present').
sent(s_271_3_p, swe, 'Smith var närvarande efter det att Jones var närvarande').

tree(s_271_4_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('AdvVP', [t('UseComp', [t('CompAP', [t('PositA', [t(present8attending_A, [])])])]), t('SubjS', [t(before_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('UseComp', [t('CompAP', [t('PositA', [t(present8attending_A, [])])])])])])])])])])])])).
sent(s_271_4_q, eng, 'was Jones present before Smith was present').
sent(s_271_4_q, original, 'was Jones present before Smith was present').
sent(s_271_4_q, swe, 'var Jones närvarande innan Smith var närvarande').

tree(s_271_5_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('AdvVP', [t('UseComp', [t('CompAP', [t('PositA', [t(present8attending_A, [])])])]), t('SubjS', [t(before_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('UseComp', [t('CompAP', [t('PositA', [t(present8attending_A, [])])])])])])])])])])])).
sent(s_271_5_h, eng, 'Jones was present before Smith was present').
sent(s_271_5_h, original, 'Jones was present before Smith was present').
sent(s_271_5_h, swe, 'Jones var närvarande innan Smith var närvarande').

tree(s_272_1_p, s_271_1_p).
sent(s_272_1_p, eng, 'Smith was present').
sent(s_272_1_p, original, 'Smith was present').
sent(s_272_1_p, swe, 'Smith var närvarande').

tree(s_272_2_p, s_271_2_p).
sent(s_272_2_p, eng, 'Jones was present').
sent(s_272_2_p, original, 'Jones was present').
sent(s_272_2_p, swe, 'Jones var närvarande').

tree(s_272_3_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('UseComp', [t('CompAP', [t('PositA', [t(present8attending_A, [])])])]), t('SubjS', [t(before_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('UseComp', [t('CompAP', [t('PositA', [t(present8attending_A, [])])])])])])])])])])])).
sent(s_272_3_p, eng, 'Smith was present before Jones was present').
sent(s_272_3_p, original, 'Smith was present before Jones was present').
sent(s_272_3_p, swe, 'Smith var närvarande innan Jones var närvarande').

tree(s_272_4_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('AdvVP', [t('UseComp', [t('CompAP', [t('PositA', [t(present8attending_A, [])])])]), t('SubjS', [t(after_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('UseComp', [t('CompAP', [t('PositA', [t(present8attending_A, [])])])])])])])])])])])])).
sent(s_272_4_q, eng, 'was Jones present after Smith was present').
sent(s_272_4_q, original, 'was Jones present after Smith was present').
sent(s_272_4_q, swe, 'var Jones närvarande efter det att Smith var närvarande').

tree(s_272_5_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('AdvVP', [t('UseComp', [t('CompAP', [t('PositA', [t(present8attending_A, [])])])]), t('SubjS', [t(after_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('UseComp', [t('CompAP', [t('PositA', [t(present8attending_A, [])])])])])])])])])])])).
sent(s_272_5_h, eng, 'Jones was present after Smith was present').
sent(s_272_5_h, original, 'Jones was present after Smith was present').
sent(s_272_5_h, swe, 'Jones var närvarande efter det att Smith var närvarande').

tree(s_273_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ProgrVPa', [t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])])])])])])).
sent(s_273_1_p, eng, 'Smith was writing a report').
sent(s_273_1_p, original, 'Smith was writing a report').
sent(s_273_1_p, swe, 'Smith skrev en rapport').

tree(s_273_2_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('ProgrVPa', [t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])])])])])])).
sent(s_273_2_p, eng, 'Jones was writing a report').
sent(s_273_2_p, original, 'Jones was writing a report').
sent(s_273_2_p, swe, 'Jones skrev en rapport').

tree(s_273_3_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ProgrVPa', [t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])])]), t('SubjS', [t(before_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('ProgrVPa', [t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])])])])])])])])])])).
sent(s_273_3_p, eng, 'Smith was writing a report before Jones was writing a report').
sent(s_273_3_p, original, 'Smith was writing a report before Jones was writing a report').
sent(s_273_3_p, swe, 'Smith skrev en rapport innan Jones skrev en rapport').

tree(s_273_4_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('AdvVP', [t('ProgrVPa', [t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])])]), t('SubjS', [t(after_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ProgrVPa', [t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])])])])])])])])])])])).
sent(s_273_4_q, eng, 'was Jones writing a report after Smith was writing a report').
sent(s_273_4_q, original, 'was Jones writing a report after Smith was writing a report').
sent(s_273_4_q, swe, 'skrev Jones en rapport efter det att Smith skrev en rapport').

tree(s_273_5_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('AdvVP', [t('ProgrVPa', [t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])])]), t('SubjS', [t(after_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ProgrVPa', [t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])])])])])])])])])])).
sent(s_273_5_h, eng, 'Jones was writing a report after Smith was writing a report').
sent(s_273_5_h, original, 'Jones was writing a report after Smith was writing a report').
sent(s_273_5_h, swe, 'Jones skrev en rapport efter det att Smith skrev en rapport').

tree(s_274_1_p, s_273_1_p).
sent(s_274_1_p, eng, 'Smith was writing a report').
sent(s_274_1_p, original, 'Smith was writing a report').
sent(s_274_1_p, swe, 'Smith skrev en rapport').

tree(s_274_2_p, s_273_2_p).
sent(s_274_2_p, eng, 'Jones was writing a report').
sent(s_274_2_p, original, 'Jones was writing a report').
sent(s_274_2_p, swe, 'Jones skrev en rapport').

tree(s_274_3_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ProgrVPa', [t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])])]), t('SubjS', [t(after_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('ProgrVPa', [t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])])])])])])])])])])).
sent(s_274_3_p, eng, 'Smith was writing a report after Jones was writing a report').
sent(s_274_3_p, original, 'Smith was writing a report after Jones was writing a report').
sent(s_274_3_p, swe, 'Smith skrev en rapport efter det att Jones skrev en rapport').

tree(s_274_4_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('AdvVP', [t('ProgrVPa', [t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])])]), t('SubjS', [t(before_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ProgrVPa', [t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])])])])])])])])])])])).
sent(s_274_4_q, eng, 'was Jones writing a report before Smith was writing a report').
sent(s_274_4_q, original, 'was Jones writing a report before Smith was writing a report').
sent(s_274_4_q, swe, 'skrev Jones en rapport innan Smith skrev en rapport').

tree(s_274_5_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('AdvVP', [t('ProgrVPa', [t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])])]), t('SubjS', [t(before_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ProgrVPa', [t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])])])])])])])])])])).
sent(s_274_5_h, eng, 'Jones was writing a report before Smith was writing a report').
sent(s_274_5_h, original, 'Jones was writing a report before Smith was writing a report').
sent(s_274_5_h, swe, 'Jones skrev en rapport innan Smith skrev en rapport').

tree(s_275_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(leave_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(meeting_N, [])])])]), t('SubjS', [t(before_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePron', [t(he_Pron, [])]), t('ComplSlash', [t('SlashV2a', [t(lose_V2, [])]), t('DetCN', [t('DetQuant', [t('PossPron', [t(heRefl_Pron, [])]), t('NumSg', [])]), t('UseN', [t(temper_N, [])])])])])])])])])])])).
sent(s_275_1_p, eng, 'Smith left the meeting before he lost his temper').
sent(s_275_1_p, original, 'Smith left the meeting before he lost his temper').
sent(s_275_1_p, swe, 'Smith lämnade mötet innan han förlorade sitt humör').

tree(s_275_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(lose_V2, [])]), t('DetCN', [t('DetQuant', [t('PossPron', [t(heRefl_Pron, [])]), t('NumSg', [])]), t('UseN', [t(temper_N, [])])])])])])])])).
sent(s_275_2_q, eng, 'did Smith lose his temper').
sent(s_275_2_q, original, 'did Smith lose his temper').
sent(s_275_2_q, swe, 'förlorade Smith sitt humör').

tree(s_275_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(lose_V2, [])]), t('DetCN', [t('DetQuant', [t('PossPron', [t(heRefl_Pron, [])]), t('NumSg', [])]), t('UseN', [t(temper_N, [])])])])])])])).
sent(s_275_3_h, eng, 'Smith lost his temper').
sent(s_275_3_h, original, 'Smith lost his temper').
sent(s_275_3_h, swe, 'Smith förlorade sitt humör').

tree(s_276_1_p, t('Sentence', [t('ExtAdvS', [t('SubjS', [t(when_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePron', [t(they_Pron, [])]), t('ComplSlash', [t('SlashV2a', [t(open_V2, [])]), t('UsePN', [t(the_m25_PN, [])])])])])]), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('MassNP', [t('UseN', [t(traffic_N, [])])]), t('UseV', [t(increase_V, [])])])])])])).
sent(s_276_1_p, eng, 'when they opened the M25 , traffic increased').
sent(s_276_1_p, original, 'when they opened the M25 , traffic increased').
sent(s_276_1_p, swe, 'när de öppnade M25:an , ökade trafik').

tree(s_277_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('AdvVP', [t('UseV', [t(live_V, [])]), t('PrepNP', [t(in_Prep, []), t('UsePN', [t(birmingham_PN, [])])])]), t(in_1991_Adv, [])])])])])).
sent(s_277_1_p, eng, 'Smith lived in Birmingham in 1991').
sent(s_277_1_p, original, 'Smith lived in Birmingham in 1991').
sent(s_277_1_p, swe, 'Smith bodde i Birmingham 1991').

tree(s_277_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('AdvVP', [t('UseV', [t(live_V, [])]), t('PrepNP', [t(in_Prep, []), t('UsePN', [t(birmingham_PN, [])])])]), t(in_1992_Adv, [])])])])])])).
sent(s_277_2_q, eng, 'did Smith live in Birmingham in 1992').
sent(s_277_2_q, original, 'did Smith live in Birmingham in 1992').
sent(s_277_2_q, swe, 'bodde Smith i Birmingham 1992').

tree(s_277_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('AdvVP', [t('UseV', [t(live_V, [])]), t('PrepNP', [t(in_Prep, []), t('UsePN', [t(birmingham_PN, [])])])]), t(in_1992_Adv, [])])])])])).
sent(s_277_3_h, eng, 'Smith lived in Birmingham in 1992').
sent(s_277_3_h, original, 'Smith lived in Birmingham in 1992').
sent(s_277_3_h, swe, 'Smith bodde i Birmingham 1992').

tree(s_278_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuantOrd', [t('PossPron', [t(heRefl_Pron, [])]), t('NumSg', []), t('OrdNumeral', [t('N_one', [])])]), t('UseN', [t(novel_N, [])])])]), t(in_1991_Adv, [])])])])])).
sent(s_278_1_p, eng, 'Smith wrote his first novel in 1991').
sent(s_278_1_p, original, 'Smith wrote his first novel in 1991').
sent(s_278_1_p, swe, 'Smith skrev sin första roman 1991').

tree(s_278_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuantOrd', [t('PossPron', [t(heRefl_Pron, [])]), t('NumSg', []), t('OrdNumeral', [t('N_one', [])])]), t('UseN', [t(novel_N, [])])])]), t(in_1992_Adv, [])])])])])])).
sent(s_278_2_q, eng, 'did Smith write his first novel in 1992').
sent(s_278_2_q, original, 'did Smith write his first novel in 1992').
sent(s_278_2_q, swe, 'skrev Smith sin första roman 1992').

tree(s_278_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuantOrd', [t('PossPron', [t(heRefl_Pron, [])]), t('NumSg', []), t('OrdNumeral', [t('N_one', [])])]), t('UseN', [t(novel_N, [])])])]), t(in_1992_Adv, [])])])])])).
sent(s_278_3_h, eng, 'Smith wrote his first novel in 1992').
sent(s_278_3_h, original, 'Smith wrote his first novel in 1992').
sent(s_278_3_h, swe, 'Smith skrev sin första roman 1992').

tree(s_279_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(novel_N, [])])])]), t(in_1991_Adv, [])])])])])).
sent(s_279_1_p, eng, 'Smith wrote a novel in 1991').
sent(s_279_1_p, original, 'Smith wrote a novel in 1991').
sent(s_279_1_p, swe, 'Smith skrev en roman 1991').

tree(s_279_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('UsePron', [t(it_Pron, [])])]), t(in_1992_Adv, [])])])])])])).
sent(s_279_2_q, eng, 'did Smith write it in 1992').
sent(s_279_2_q, original, 'did Smith write it in 1992').
sent(s_279_2_q, swe, 'skrev Smith det 1992').

tree(s_279_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('UsePron', [t(it_Pron, [])])]), t(in_1992_Adv, [])])])])])).
sent(s_279_3_h, eng, 'Smith wrote it in 1992').
sent(s_279_3_h, original, 'Smith wrote it in 1992').
sent(s_279_3_h, swe, 'Smith skrev det 1992').

tree(s_280_1_p, s_279_1_p).
sent(s_280_1_p, eng, 'Smith wrote a novel in 1991').
sent(s_280_1_p, original, 'Smith wrote a novel in 1991').
sent(s_280_1_p, swe, 'Smith skrev en roman 1991').

tree(s_280_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(novel_N, [])])])]), t(in_1992_Adv, [])])])])])])).
sent(s_280_2_q, eng, 'did Smith write a novel in 1992').
sent(s_280_2_q, original, 'did Smith write a novel in 1992').
sent(s_280_2_q, swe, 'skrev Smith en roman 1992').

tree(s_280_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(novel_N, [])])])]), t(in_1992_Adv, [])])])])])).
sent(s_280_3_h, eng, 'Smith wrote a novel in 1992').
sent(s_280_3_h, original, 'Smith wrote a novel in 1992').
sent(s_280_3_h, swe, 'Smith skrev en roman 1992').

tree(s_281_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ProgrVPa', [t('ComplSlash', [t('SlashV2a', [t(run_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(business_N, [])])])])]), t(in_1991_Adv, [])])])])])).
sent(s_281_1_p, eng, 'Smith was running a business in 1991').
sent(s_281_1_p, original, 'Smith was running a business in 1991').
sent(s_281_1_p, swe, 'Smith drev en affärsverksamhet 1991').

tree(s_281_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ProgrVPa', [t('ComplSlash', [t('SlashV2a', [t(run_V2, [])]), t('UsePron', [t(it_Pron, [])])])]), t(in_1992_Adv, [])])])])])])).
sent(s_281_2_q, eng, 'was Smith running it in 1992').
sent(s_281_2_q, original, 'was Smith running it in 1992').
sent(s_281_2_q, swe, 'drev Smith det 1992').

tree(s_281_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ProgrVPa', [t('ComplSlash', [t('SlashV2a', [t(run_V2, [])]), t('UsePron', [t(it_Pron, [])])])]), t(in_1992_Adv, [])])])])])).
sent(s_281_3_h, eng, 'Smith was running it in 1992').
sent(s_281_3_h, original, 'Smith was running it in 1992').
sent(s_281_3_h, swe, 'Smith drev det 1992').

tree(s_282_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(discover_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(new_A, [])]), t('UseN', [t(species_N, [])])])])]), t(in_1991_Adv, [])])])])])).
sent(s_282_1_p, eng, 'Smith discovered a new species in 1991').
sent(s_282_1_p, original, 'Smith discovered a new species in 1991').
sent(s_282_1_p, swe, 'Smith upptäckte en ny art 1991').

tree(s_282_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(discover_V2, [])]), t('UsePron', [t(it_Pron, [])])]), t(in_1992_Adv, [])])])])])])).
sent(s_282_2_q, eng, 'did Smith discover it in 1992').
sent(s_282_2_q, original, 'did Smith discover it in 1992').
sent(s_282_2_q, swe, 'upptäckte Smith det 1992').

tree(s_282_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(discover_V2, [])]), t('UsePron', [t(it_Pron, [])])]), t(in_1992_Adv, [])])])])])).
sent(s_282_3_h, eng, 'Smith discovered it in 1992').
sent(s_282_3_h, original, 'Smith discovered it in 1992').
sent(s_282_3_h, swe, 'Smith upptäckte det 1992').

tree(s_283_1_p, s_282_1_p).
sent(s_283_1_p, eng, 'Smith discovered a new species in 1991').
sent(s_283_1_p, original, 'Smith discovered a new species in 1991').
sent(s_283_1_p, swe, 'Smith upptäckte en ny art 1991').

tree(s_283_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(discover_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(new_A, [])]), t('UseN', [t(species_N, [])])])])]), t(in_1992_Adv, [])])])])])])).
sent(s_283_2_q, eng, 'did Smith discover a new species in 1992').
sent(s_283_2_q, original, 'did Smith discover a new species in 1992').
sent(s_283_2_q, swe, 'upptäckte Smith en ny art 1992').

tree(s_283_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(discover_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(new_A, [])]), t('UseN', [t(species_N, [])])])])]), t(in_1992_Adv, [])])])])])).
sent(s_283_3_h, eng, 'Smith discovered a new species in 1992').
sent(s_283_3_h, original, 'Smith discovered a new species in 1992').
sent(s_283_3_h, swe, 'Smith upptäckte en ny art 1992').

tree(s_284_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])]), t(in_two_hours_Adv, [])])])])])).
sent(s_284_1_p, eng, 'Smith wrote a report in two hours').
sent(s_284_1_p, original, 'Smith wrote a report in two hours').
sent(s_284_1_p, swe, 'Smith skrev en rapport på två timmar').

tree(s_284_2_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplVV', [t(start_VV, []), t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])])]), t(at_8_am_Adv, [])])])])])).
sent(s_284_2_p, eng, 'Smith started writing the report at 8 am').
sent(s_284_2_p, original, 'Smith started writing the report at 8 am').
sent(s_284_2_p, swe, 'Smith började skriva rapporten klockan 8').

tree(s_284_3_q, t('Question', [t('UseQCl', [t('PastPerfect', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplVV', [t(finish_VV, []), t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])])]), t(by_11_am_Adv, [])])])])])])).
sent(s_284_3_q, eng, 'had Smith finished writing the report by 11 am').
sent(s_284_3_q, original, 'had Smith finished writing the report by 11 am').
sent(s_284_3_q, swe, 'hade Smith slutat att skriva rapporten klockan 11').

tree(s_284_4_h, t('Sentence', [t('UseCl', [t('PastPerfect', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplVV', [t(finish_VV, []), t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])])]), t(by_11_am_Adv, [])])])])])).
sent(s_284_4_h, eng, 'Smith had finished writing the report by 11 am').
sent(s_284_4_h, original, 'Smith had finished writing the report by 11 am').
sent(s_284_4_h, swe, 'Smith hade slutat att skriva rapporten klockan 11').

tree(s_285_1_p, s_284_1_p).
sent(s_285_1_p, eng, 'Smith wrote a report in two hours').
sent(s_285_1_p, original, 'Smith wrote a report in two hours').
sent(s_285_1_p, swe, 'Smith skrev en rapport på två timmar').

tree(s_285_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(spend_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_two', [])])])]), t('AdjCN', [t('PartVP', [t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])])]), t('UseN', [t(hour_N, [])])])])])])])])])).
sent(s_285_2_q, eng, 'did Smith spend two hours writing the report').
sent(s_285_2_q, original, 'did Smith spend two hours writing the report').

tree(s_285_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(spend_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_two', [])])])]), t('AdjCN', [t('PartVP', [t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])])]), t('UseN', [t(hour_N, [])])])])])])])])).
sent(s_285_3_h, eng, 'Smith spent two hours writing the report').
sent(s_285_3_h, original, 'Smith spent two hours writing the report').

tree(s_286_1_p, s_284_1_p).
sent(s_286_1_p, eng, 'Smith wrote a report in two hours').
sent(s_286_1_p, original, 'Smith wrote a report in two hours').
sent(s_286_1_p, swe, 'Smith skrev en rapport på två timmar').

tree(s_286_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(spend_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('AdNum', [t(more_than_AdN, []), t('NumNumeral', [t('N_two', [])])])])]), t('AdjCN', [t('PartVP', [t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])])]), t('UseN', [t(hour_N, [])])])])])])])])])).
sent(s_286_2_q, eng, 'did Smith spend more than two hours writing the report').
sent(s_286_2_q, original, 'did Smith spend more than two hours writing the report').

tree(s_286_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(spend_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('AdNum', [t(more_than_AdN, []), t('NumNumeral', [t('N_two', [])])])])]), t('AdjCN', [t('PartVP', [t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])])]), t('UseN', [t(hour_N, [])])])])])])])])).
sent(s_286_3_h, eng, 'Smith spent more than two hours writing the report').
sent(s_286_3_h, original, 'Smith spent more than two hours writing the report').

tree(s_287_1_p, s_284_1_p).
sent(s_287_1_p, eng, 'Smith wrote a report in two hours').
sent(s_287_1_p, original, 'Smith wrote a report in two hours').
sent(s_287_1_p, swe, 'Smith skrev en rapport på två timmar').

tree(s_287_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])]), t(in_one_hour_Adv, [])])])])])])).
sent(s_287_2_q, eng, 'did Smith write a report in one hour').
sent(s_287_2_q, original, 'did Smith write a report in one hour').
sent(s_287_2_q, swe, 'skrev Smith en rapport på en timme').

tree(s_287_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])]), t(in_one_hour_Adv, [])])])])])).
sent(s_287_3_h, eng, 'Smith wrote a report in one hour').
sent(s_287_3_h, original, 'Smith wrote a report in one hour').
sent(s_287_3_h, swe, 'Smith skrev en rapport på en timme').

tree(s_288_1_p, s_284_1_p).
sent(s_288_1_p, eng, 'Smith wrote a report in two hours').
sent(s_288_1_p, original, 'Smith wrote a report in two hours').
sent(s_288_1_p, swe, 'Smith skrev en rapport på två timmar').

tree(s_288_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])])])])])])).
sent(s_288_2_q, eng, 'did Smith write a report').
sent(s_288_2_q, original, 'did Smith write a report').
sent(s_288_2_q, swe, 'skrev Smith en rapport').

tree(s_288_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])])])])])).
sent(s_288_3_h, eng, 'Smith wrote a report').
sent(s_288_3_h, original, 'Smith wrote a report').
sent(s_288_3_h, swe, 'Smith skrev en rapport').

tree(s_289_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(discover_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(new_A, [])]), t('UseN', [t(species_N, [])])])])]), t(in_two_hours_Adv, [])])])])])).
sent(s_289_1_p, eng, 'Smith discovered a new species in two hours').
sent(s_289_1_p, original, 'Smith discovered a new species in two hours').
sent(s_289_1_p, swe, 'Smith upptäckte en ny art på två timmar').

tree(s_289_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(spend_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_two', [])])])]), t('SentCN', [t('UseN', [t(hour_N, [])]), t('EmbedPresPart', [t('ComplSlash', [t('SlashV2a', [t(discover_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(new_A, [])]), t('UseN', [t(species_N, [])])])])])])])])])])])])])).
sent(s_289_2_q, eng, 'did Smith spend two hours discovering the new species').
sent(s_289_2_q, original, 'did Smith spend two hours discovering the new species').

tree(s_289_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(spend_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_two', [])])])]), t('SentCN', [t('UseN', [t(hour_N, [])]), t('EmbedPresPart', [t('ComplSlash', [t('SlashV2a', [t(discover_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(new_A, [])]), t('UseN', [t(species_N, [])])])])])])])])])])])])).
sent(s_289_3_h, eng, 'Smith spent two hours discovering the new species').
sent(s_289_3_h, original, 'Smith spent two hours discovering the new species').

tree(s_290_1_p, s_289_1_p).
sent(s_290_1_p, eng, 'Smith discovered a new species in two hours').
sent(s_290_1_p, original, 'Smith discovered a new species in two hours').
sent(s_290_1_p, swe, 'Smith upptäckte en ny art på två timmar').

tree(s_290_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(discover_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(new_A, [])]), t('UseN', [t(species_N, [])])])])])])])])])).
sent(s_290_2_q, eng, 'did Smith discover a new species').
sent(s_290_2_q, original, 'did Smith discover a new species').
sent(s_290_2_q, swe, 'upptäckte Smith en ny art').

tree(s_290_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(discover_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(new_A, [])]), t('UseN', [t(species_N, [])])])])])])])])).
sent(s_290_3_h, eng, 'Smith discovered a new species').
sent(s_290_3_h, original, 'Smith discovered a new species').
sent(s_290_3_h, swe, 'Smith upptäckte en ny art').

tree(s_291_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(discover_V2, [])]), t('DetCN', [t(many_Det, []), t('AdjCN', [t('PositA', [t(new_A, [])]), t('UseN', [t(species_N, [])])])])]), t(in_two_hours_Adv, [])])])])])).
sent(s_291_1_p, eng, 'Smith discovered many new species in two hours').
sent(s_291_1_p, original, 'Smith discovered many new species in two hours').
sent(s_291_1_p, swe, 'Smith upptäckte många nya arter på två timmar').

tree(s_291_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(spend_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_two', [])])])]), t('SentCN', [t('UseN', [t(hour_N, [])]), t('EmbedPresPart', [t('ComplSlash', [t('SlashV2a', [t(discover_V2, [])]), t('MassNP', [t('AdjCN', [t('PositA', [t(new_A, [])]), t('UseN', [t(species_N, [])])])])])])])])])])])])])).
sent(s_291_2_q, eng, 'did Smith spend two hours discovering new species').
sent(s_291_2_q, original, 'did Smith spend two hours discovering new species').

tree(s_291_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(spend_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_two', [])])])]), t('SentCN', [t('UseN', [t(hour_N, [])]), t('EmbedPresPart', [t('ComplSlash', [t('SlashV2a', [t(discover_V2, [])]), t('MassNP', [t('AdjCN', [t('PositA', [t(new_A, [])]), t('UseN', [t(species_N, [])])])])])])])])])])])])).
sent(s_291_3_h, eng, 'Smith spent two hours discovering new species').
sent(s_291_3_h, original, 'Smith spent two hours discovering new species').

tree(s_292_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ProgrVPa', [t('ComplSlash', [t('SlashV2a', [t(run_V2, [])]), t('DetCN', [t('DetQuant', [t('PossPron', [t(heRefl_Pron, [])]), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(own_A, [])]), t('UseN', [t(business_N, [])])])])])]), t('PrepNP', [t(in_Prep, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_two', [])])])]), t('UseN', [t(year_N, [])])])])])])])])).
sent(s_292_1_p, eng, 'Smith was running his own business in two years').
sent(s_292_1_p, original, 'Smith was running his own business in two years').
sent(s_292_1_p, swe, 'Smith drev sin egna affärsverksamhet i två år').

tree(s_292_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(spend_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_two', [])])])]), t('SentCN', [t('UseN', [t(year_N, [])]), t('EmbedPresPart', [t('ComplSlash', [t('SlashV2a', [t(run_V2, [])]), t('DetCN', [t('DetQuant', [t('PossPron', [t(heRefl_Pron, [])]), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(own_A, [])]), t('UseN', [t(business_N, [])])])])])])])])])])])])])).
sent(s_292_2_q, eng, 'did Smith spend two years running his own business').
sent(s_292_2_q, original, 'did Smith spend two years running his own business').

tree(s_292_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(spend_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_two', [])])])]), t('SentCN', [t('UseN', [t(year_N, [])]), t('EmbedPresPart', [t('ComplSlash', [t('SlashV2a', [t(run_V2, [])]), t('DetCN', [t('DetQuant', [t('PossPron', [t(heRefl_Pron, [])]), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(own_A, [])]), t('UseN', [t(business_N, [])])])])])])])])])])])])).
sent(s_292_3_h, eng, 'Smith spent two years running his own business').
sent(s_292_3_h, original, 'Smith spent two years running his own business').

tree(s_293_1_p, s_292_1_p).
sent(s_293_1_p, eng, 'Smith was running his own business in two years').
sent(s_293_1_p, original, 'Smith was running his own business in two years').
sent(s_293_1_p, swe, 'Smith drev sin egna affärsverksamhet i två år').

tree(s_293_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(spend_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('AdNum', [t(more_than_AdN, []), t('NumNumeral', [t('N_two', [])])])])]), t('SentCN', [t('UseN', [t(year_N, [])]), t('EmbedPresPart', [t('ComplSlash', [t('SlashV2a', [t(run_V2, [])]), t('DetCN', [t('DetQuant', [t('PossPron', [t(heRefl_Pron, [])]), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(own_A, [])]), t('UseN', [t(business_N, [])])])])])])])])])])])])])).
sent(s_293_2_q, eng, 'did Smith spend more than two years running his own business').
sent(s_293_2_q, original, 'did Smith spend more than two years running his own business').

tree(s_293_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(spend_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('AdNum', [t(more_than_AdN, []), t('NumNumeral', [t('N_two', [])])])])]), t('SentCN', [t('UseN', [t(year_N, [])]), t('EmbedPresPart', [t('ComplSlash', [t('SlashV2a', [t(run_V2, [])]), t('DetCN', [t('DetQuant', [t('PossPron', [t(heRefl_Pron, [])]), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(own_A, [])]), t('UseN', [t(business_N, [])])])])])])])])])])])])).
sent(s_293_3_h, eng, 'Smith spent more than two years running his own business').
sent(s_293_3_h, original, 'Smith spent more than two years running his own business').

tree(s_294_1_p, s_292_1_p).
sent(s_294_1_p, eng, 'Smith was running his own business in two years').
sent(s_294_1_p, original, 'Smith was running his own business in two years').
sent(s_294_1_p, swe, 'Smith drev sin egna affärsverksamhet i två år').

tree(s_294_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(run_V2, [])]), t('DetCN', [t('DetQuant', [t('PossPron', [t(heRefl_Pron, [])]), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(own_A, [])]), t('UseN', [t(business_N, [])])])])])])])])])).
sent(s_294_2_q, eng, 'did Smith run his own business').
sent(s_294_2_q, original, 'did Smith run his own business').
sent(s_294_2_q, swe, 'drev Smith sin egna affärsverksamhet').

tree(s_294_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(run_V2, [])]), t('DetCN', [t('DetQuant', [t('PossPron', [t(heRefl_Pron, [])]), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(own_A, [])]), t('UseN', [t(business_N, [])])])])])])])])).
sent(s_294_3_h, eng, 'Smith ran his own business').
sent(s_294_3_h, original, 'Smith ran his own business').
sent(s_294_3_h, swe, 'Smith drev sin egna affärsverksamhet').

tree(s_295_1_p, t('Sentence', [t('AdvS', [t('PrepNP', [t(in_Prep, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_two', [])])])]), t('UseN', [t(year_N, [])])])]), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(own_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdvCN', [t('UseN', [t(chain_N, [])]), t('PrepNP', [t(part_Prep, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('UseN', [t(business_N, [])])])])])])])])])])])).
sent(s_295_1_p, eng, 'in two years Smith owned a chain of businesses').
sent(s_295_1_p, original, 'in two years Smith owned a chain of businesses').
sent(s_295_1_p, swe, 'i två år ägde Smith en kedja av affärsverksamheter').

tree(s_295_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(own_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdvCN', [t('UseN', [t(chain_N, [])]), t('PrepNP', [t(part_Prep, []), t('MassNP', [t('UseN', [t(business_N, [])])])])])])]), t(for_two_years_Adv, [])])])])])])).
sent(s_295_2_q, eng, 'did Smith own a chain of business for two years').
sent(s_295_2_q, original, 'did Smith own a chain of business for two years').
sent(s_295_2_q, swe, 'ägde Smith en kedja av affärsverksamhet i två år').

tree(s_295_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(own_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdvCN', [t('UseN', [t(chain_N, [])]), t('PrepNP', [t(part_Prep, []), t('MassNP', [t('UseN', [t(business_N, [])])])])])])]), t(for_two_years_Adv, [])])])])])).
sent(s_295_3_h, eng, 'Smith owned a chain of business for two years').
sent(s_295_3_h, original, 'Smith owned a chain of business for two years').
sent(s_295_3_h, swe, 'Smith ägde en kedja av affärsverksamhet i två år').

tree(s_296_1_p, s_295_1_p).
sent(s_296_1_p, eng, 'in two years Smith owned a chain of businesses').
sent(s_296_1_p, original, 'in two years Smith owned a chain of businesses').
sent(s_296_1_p, swe, 'i två år ägde Smith en kedja av affärsverksamheter').

tree(s_296_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(own_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdvCN', [t('UseN', [t(chain_N, [])]), t('PrepNP', [t(part_Prep, []), t('MassNP', [t('UseN', [t(business_N, [])])])])])])]), t(for_more_than_two_years_Adv, [])])])])])])).
sent(s_296_2_q, eng, 'did Smith own a chain of business for more than two years').
sent(s_296_2_q, original, 'did Smith own a chain of business for more than two years').
sent(s_296_2_q, swe, 'ägde Smith en kedja av affärsverksamhet i mer än två år').

tree(s_296_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(own_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdvCN', [t('UseN', [t(chain_N, [])]), t('PrepNP', [t(part_Prep, []), t('MassNP', [t('UseN', [t(business_N, [])])])])])])]), t(for_more_than_two_years_Adv, [])])])])])).
sent(s_296_3_h, eng, 'Smith owned a chain of business for more than two years').
sent(s_296_3_h, original, 'Smith owned a chain of business for more than two years').
sent(s_296_3_h, swe, 'Smith ägde en kedja av affärsverksamhet i mer än två år').

tree(s_297_1_p, s_295_1_p).
sent(s_297_1_p, eng, 'in two years Smith owned a chain of businesses').
sent(s_297_1_p, original, 'in two years Smith owned a chain of businesses').
sent(s_297_1_p, swe, 'i två år ägde Smith en kedja av affärsverksamheter').

tree(s_297_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(own_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdvCN', [t('UseN', [t(chain_N, [])]), t('PrepNP', [t(part_Prep, []), t('MassNP', [t('UseN', [t(business_N, [])])])])])])])])])])])).
sent(s_297_2_q, eng, 'did Smith own a chain of business').
sent(s_297_2_q, original, 'did Smith own a chain of business').
sent(s_297_2_q, swe, 'ägde Smith en kedja av affärsverksamhet').

tree(s_297_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(own_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdvCN', [t('UseN', [t(chain_N, [])]), t('PrepNP', [t(part_Prep, []), t('MassNP', [t('UseN', [t(business_N, [])])])])])])])])])])).
sent(s_297_3_h, eng, 'Smith owned a chain of business').
sent(s_297_3_h, original, 'Smith owned a chain of business').
sent(s_297_3_h, swe, 'Smith ägde en kedja av affärsverksamhet').

tree(s_298_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('AdvVP', [t('UseV', [t(live_V, [])]), t('PrepNP', [t(in_Prep, []), t('UsePN', [t(birmingham_PN, [])])])]), t(for_two_years_Adv, [])])])])])).
sent(s_298_1_p, eng, 'Smith lived in Birmingham for two years').
sent(s_298_1_p, original, 'Smith lived in Birmingham for two years').
sent(s_298_1_p, swe, 'Smith bodde i Birmingham i två år').

tree(s_298_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('AdvVP', [t('UseV', [t(live_V, [])]), t('PrepNP', [t(in_Prep, []), t('UsePN', [t(birmingham_PN, [])])])]), t(for_a_year_Adv, [])])])])])])).
sent(s_298_2_q, eng, 'did Smith live in Birmingham for a year').
sent(s_298_2_q, original, 'did Smith live in Birmingham for a year').
sent(s_298_2_q, swe, 'bodde Smith i Birmingham i ett år').

tree(s_298_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('AdvVP', [t('UseV', [t(live_V, [])]), t('PrepNP', [t(in_Prep, []), t('UsePN', [t(birmingham_PN, [])])])]), t(for_a_year_Adv, [])])])])])).
sent(s_298_3_h, eng, 'Smith lived in Birmingham for a year').
sent(s_298_3_h, original, 'Smith lived in Birmingham for a year').
sent(s_298_3_h, swe, 'Smith bodde i Birmingham i ett år').

tree(s_299_1_p, s_298_1_p).
sent(s_299_1_p, eng, 'Smith lived in Birmingham for two years').
sent(s_299_1_p, original, 'Smith lived in Birmingham for two years').
sent(s_299_1_p, swe, 'Smith bodde i Birmingham i två år').

tree(s_299_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('AdvVP', [t('UseV', [t(live_V, [])]), t('PrepNP', [t(in_Prep, []), t('UsePN', [t(birmingham_PN, [])])])]), t(for_exactly_a_year_Adv, [])])])])])])).
sent(s_299_2_q, eng, 'did Smith live in Birmingham for exactly a year').
sent(s_299_2_q, original, 'did Smith live in Birmingham for exactly a year').
sent(s_299_2_q, swe, 'bodde Smith i Birmingham i exakt ett år').

tree(s_299_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('AdvVP', [t('UseV', [t(live_V, [])]), t('PrepNP', [t(in_Prep, []), t('UsePN', [t(birmingham_PN, [])])])]), t(for_exactly_a_year_Adv, [])])])])])).
sent(s_299_3_h, eng, 'Smith lived in Birmingham for exactly a year').
sent(s_299_3_h, original, 'Smith lived in Birmingham for exactly a year').
sent(s_299_3_h, swe, 'Smith bodde i Birmingham i exakt ett år').

tree(s_300_1_p, s_298_1_p).
sent(s_300_1_p, eng, 'Smith lived in Birmingham for two years').
sent(s_300_1_p, original, 'Smith lived in Birmingham for two years').
sent(s_300_1_p, swe, 'Smith bodde i Birmingham i två år').

tree(s_300_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('UseV', [t(live_V, [])]), t('PrepNP', [t(in_Prep, []), t('UsePN', [t(birmingham_PN, [])])])])])])])])).
sent(s_300_2_q, eng, 'did Smith live in Birmingham').
sent(s_300_2_q, original, 'did Smith live in Birmingham').
sent(s_300_2_q, swe, 'bodde Smith i Birmingham').

tree(s_300_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('UseV', [t(live_V, [])]), t('PrepNP', [t(in_Prep, []), t('UsePN', [t(birmingham_PN, [])])])])])])])).
sent(s_300_3_h, eng, 'Smith lived in Birmingham').
sent(s_300_3_h, original, 'Smith lived in Birmingham').
sent(s_300_3_h, swe, 'Smith bodde i Birmingham').

tree(s_301_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(run_V2, [])]), t('DetCN', [t('DetQuant', [t('PossPron', [t(heRefl_Pron, [])]), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(own_A, [])]), t('UseN', [t(business_N, [])])])])]), t(for_two_years_Adv, [])])])])])).
sent(s_301_1_p, eng, 'Smith ran his own business for two years').
sent(s_301_1_p, original, 'Smith ran his own business for two years').
sent(s_301_1_p, swe, 'Smith drev sin egna affärsverksamhet i två år').

tree(s_301_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(run_V2, [])]), t('DetCN', [t('DetQuant', [t('PossPron', [t(heRefl_Pron, [])]), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(own_A, [])]), t('UseN', [t(business_N, [])])])])]), t(for_a_year_Adv, [])])])])])])).
sent(s_301_2_q, eng, 'did Smith run his own business for a year').
sent(s_301_2_q, original, 'did Smith run his own business for a year').
sent(s_301_2_q, swe, 'drev Smith sin egna affärsverksamhet i ett år').

tree(s_301_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(run_V2, [])]), t('DetCN', [t('DetQuant', [t('PossPron', [t(heRefl_Pron, [])]), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(own_A, [])]), t('UseN', [t(business_N, [])])])])]), t(for_a_year_Adv, [])])])])])).
sent(s_301_3_h, eng, 'Smith ran his own business for a year').
sent(s_301_3_h, original, 'Smith ran his own business for a year').
sent(s_301_3_h, swe, 'Smith drev sin egna affärsverksamhet i ett år').

tree(s_302_1_p, s_301_1_p).
sent(s_302_1_p, eng, 'Smith ran his own business for two years').
sent(s_302_1_p, original, 'Smith ran his own business for two years').
sent(s_302_1_p, swe, 'Smith drev sin egna affärsverksamhet i två år').

tree(s_302_2_q, s_294_2_q).
sent(s_302_2_q, eng, 'did Smith run his own business').
sent(s_302_2_q, original, 'did Smith run his own business').
sent(s_302_2_q, swe, 'drev Smith sin egna affärsverksamhet').

tree(s_302_3_h, s_294_3_h).
sent(s_302_3_h, eng, 'Smith ran his own business').
sent(s_302_3_h, original, 'Smith ran his own business').
sent(s_302_3_h, swe, 'Smith drev sin egna affärsverksamhet').

tree(s_303_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])]), t(for_two_hours_Adv, [])])])])])).
sent(s_303_1_p, eng, 'Smith wrote a report for two hours').
sent(s_303_1_p, original, 'Smith wrote a report for two hours').
sent(s_303_1_p, swe, 'Smith skrev en rapport i två timmar').

tree(s_303_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])]), t(for_an_hour_Adv, [])])])])])])).
sent(s_303_2_q, eng, 'did Smith write a report for an hour').
sent(s_303_2_q, original, 'did Smith write a report for an hour').
sent(s_303_2_q, swe, 'skrev Smith en rapport i en timme').

tree(s_303_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])]), t(for_an_hour_Adv, [])])])])])).
sent(s_303_3_h, eng, 'Smith wrote a report for an hour').
sent(s_303_3_h, original, 'Smith wrote a report for an hour').
sent(s_303_3_h, swe, 'Smith skrev en rapport i en timme').

tree(s_304_1_p, s_303_1_p).
sent(s_304_1_p, eng, 'Smith wrote a report for two hours').
sent(s_304_1_p, original, 'Smith wrote a report for two hours').
sent(s_304_1_p, swe, 'Smith skrev en rapport i två timmar').

tree(s_304_2_q, s_288_2_q).
sent(s_304_2_q, eng, 'did Smith write a report').
sent(s_304_2_q, original, 'did Smith write a report').
sent(s_304_2_q, swe, 'skrev Smith en rapport').

tree(s_304_3_h, s_288_3_h).
sent(s_304_3_h, eng, 'Smith wrote a report').
sent(s_304_3_h, original, 'Smith wrote a report').
sent(s_304_3_h, swe, 'Smith skrev en rapport').

tree(s_305_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(discover_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(new_A, [])]), t('UseN', [t(species_N, [])])])])]), t(for_an_hour_Adv, [])])])])])).
sent(s_305_1_p, eng, 'Smith discovered a new species for an hour').
sent(s_305_1_p, original, 'Smith discovered a new species for an hour').
sent(s_305_1_p, swe, 'Smith upptäckte en ny art i en timme').

tree(s_306_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(discover_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('AdjCN', [t('PositA', [t(new_A, [])]), t('UseN', [t(species_N, [])])])])]), t(for_two_years_Adv, [])])])])])).
sent(s_306_1_p, eng, 'Smith discovered new species for two years').
sent(s_306_1_p, original, 'Smith discovered new species for two years').
sent(s_306_1_p, swe, 'Smith upptäckte nya arter i två år').

tree(s_306_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(discover_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('AdjCN', [t('PositA', [t(new_A, [])]), t('UseN', [t(species_N, [])])])])])])])])])).
sent(s_306_2_q, eng, 'did Smith discover new species').
sent(s_306_2_q, original, 'did Smith discover new species').
sent(s_306_2_q, swe, 'upptäckte Smith nya arter').

tree(s_306_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(discover_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('AdjCN', [t('PositA', [t(new_A, [])]), t('UseN', [t(species_N, [])])])])])])])])).
sent(s_306_3_h, eng, 'Smith discovered new species').
sent(s_306_3_h, original, 'Smith discovered new species').
sent(s_306_3_h, swe, 'Smith upptäckte nya arter').

tree(s_307_1_p, t('Sentence', [t('AdvS', [t(in_1994_Adv, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(send_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(progress_report_N, [])])])]), t(every_month_Adv, [])])])])])])).
sent(s_307_1_p, eng, 'in 1994 ITEL sent a progress report every month').
sent(s_307_1_p, original, 'in 1994 ITEL sent a progress report every month').
sent(s_307_1_p, swe, '1994 skickade ITEL en statusrapport varje månad').

tree(s_307_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(send_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(progress_report_N, [])])])]), t(in_july_1994_Adv, [])])])])])])).
sent(s_307_2_q, eng, 'did ITEL send a progress report in July 1994').
sent(s_307_2_q, original, 'did ITEL send a progress report in July 1994').
sent(s_307_2_q, swe, 'skickade ITEL en statusrapport i juli 1994').

tree(s_307_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(send_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(progress_report_N, [])])])]), t(in_july_1994_Adv, [])])])])])).
sent(s_307_3_h, eng, 'ITEL sent a progress report in July 1994').
sent(s_307_3_h, original, 'ITEL sent a progress report in July 1994').
sent(s_307_3_h, swe, 'ITEL skickade en statusrapport i juli 1994').

tree(s_308_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(write_to_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(representative_N, [])])])]), t(every_week_Adv, [])])])])])).
sent(s_308_1_p, eng, 'Smith wrote to a representative every week').
sent(s_308_1_p, original, 'Smith wrote to a representative every week').
sent(s_308_1_p, swe, 'Smith skrev till en representant varje vecka').

tree(s_308_2_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('ExistNP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdvCN', [t('RelCN', [t('UseN', [t(representative_N, [])]), t('UseRCl', [t('Past', []), t('PPos', []), t('StrandRelSlash', [t(that_RP, []), t('SlashVP', [t('UsePN', [t(smith_PN, [])]), t('SlashV2a', [t(write_to_V2, [])])])])])]), t(every_week_Adv, [])])])])])])])).
sent(s_308_2_q, eng, 'is there a representative that Smith wrote to every week').
sent(s_308_2_q, original, 'is there a representative that Smith wrote to every week').
sent(s_308_2_q, swe, 'finns det en representant som Smith skrev till varje vecka').

tree(s_308_3_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('ExistNP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdvCN', [t('RelCN', [t('UseN', [t(representative_N, [])]), t('UseRCl', [t('Past', []), t('PPos', []), t('StrandRelSlash', [t(that_RP, []), t('SlashVP', [t('UsePN', [t(smith_PN, [])]), t('SlashV2a', [t(write_to_V2, [])])])])])]), t(every_week_Adv, [])])])])])])).
sent(s_308_3_h, eng, 'there is a representative that Smith wrote to every week').
sent(s_308_3_h, original, 'there is a representative that Smith wrote to every week').
sent(s_308_3_h, swe, 'det finns en representant som Smith skrev till varje vecka').

tree(s_309_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(leave_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(house_N, [])])])]), t(at_a_quarter_past_five_Adv, [])])])])])).
sent(s_309_1_p, eng, 'Smith left the house at a quarter past five').
sent(s_309_1_p, original, 'Smith left the house at a quarter past five').
sent(s_309_1_p, swe, 'Smith lämnade huset kvart över fem').

tree(s_309_2_p, t('Sentence', [t('PredVPS', [t('UsePron', [t(she_Pron, [])]), t('ConjVPS2', [t(and_Conj, []), t('Past', []), t('PPos', []), t('ComplSlash', [t('SlashV2a', [t(take_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdvCN', [t('UseN', [t(taxi_N, [])]), t('PrepNP', [t(to_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(station_N, [])])])])])])]), t('Past', []), t('PPos', []), t('ComplSlash', [t('SlashV2a', [t(catch_V2, [])]), t('DetCN', [t('DetQuantOrd', [t('DefArt', []), t('NumSg', []), t('OrdNumeral', [t('N_one', [])])]), t('AdvCN', [t('UseN', [t(train_N, [])]), t('PrepNP', [t(to_Prep, []), t('UsePN', [t(luxembourg_PN, [])])])])])])])])])).
sent(s_309_2_p, eng, 'she took a taxi to the station and caught the first train to Luxembourg').
sent(s_309_2_p, original, 'she took a taxi to the station and caught the first train to Luxembourg').
sent(s_309_2_p, swe, 'hon tog en taxi till stationen och kom med det första tåget till Luxemburg').

tree(s_310_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(lose_V2, [])]), t('DetCN', [t(somePl_Det, []), t('UseN', [t(file_N, [])])])])])])])).
sent(s_310_1_p, eng, 'Smith lost some files').
sent(s_310_1_p, original, 'Smith lost some files').
sent(s_310_1_p, swe, 'Smith förlorade några filer').

tree(s_310_2_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePron', [t(they_Pron, [])]), t('AdvVP', [t('PassV2s', [t(destroy_V2, [])]), t('SubjS', [t(when_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('PossPron', [t(she_Pron, [])]), t('NumSg', [])]), t('UseN', [t(hard_disk_N, [])])]), t('UseV', [t(crash_V, [])])])])])])])])])).
sent(s_310_2_p, eng, 'they were destroyed when her hard disk crashed').
sent(s_310_2_p, original, 'they were destroyed when her hard disk crashed').
sent(s_310_2_p, swe, 'de förstördes när hennes hårddisk kraschade').

tree(s_311_1_p, t('Sentence', [t('UseCl', [t('PastPerfect', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(leave_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(house_N, [])])])]), t(at_a_quarter_past_five_Adv, [])])])])])).
sent(s_311_1_p, eng, 'Smith had left the house at a quarter past five').
sent(s_311_1_p, original, 'Smith had left the house at a quarter past five').
sent(s_311_1_p, swe, 'Smith hade lämnat huset kvart över fem').

tree(s_311_2_p, t('PSentence', [t(then_PConj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePron', [t(she_Pron, [])]), t('ComplSlash', [t('SlashV2a', [t(take_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('AdvCN', [t('UseN', [t(taxi_N, [])]), t('PrepNP', [t(to_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(station_N, [])])])])])])])])])])).
sent(s_311_2_p, eng, 'then she took a taxi to the station').
sent(s_311_2_p, original, 'then she took a taxi to the station').
sent(s_311_2_p, swe, 'sedan hon tog en taxi till stationen').

tree(s_311_3_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(leave_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(house_N, [])])])]), t('SubjS', [t(before_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePron', [t(she_Pron, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(take_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(taxi_N, [])])])]), t('PrepNP', [t(to_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(station_N, [])])])])])])])])])])])])])).
sent(s_311_3_q, eng, 'did Smith leave the house before she took a taxi to the station').
sent(s_311_3_q, original, 'did Smith leave the house before she took a taxi to the station').
sent(s_311_3_q, swe, 'lämnade Smith huset innan hon tog en taxi till stationen').

tree(s_311_4_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(leave_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(house_N, [])])])]), t('SubjS', [t(before_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePron', [t(she_Pron, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(take_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(taxi_N, [])])])]), t('PrepNP', [t(to_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(station_N, [])])])])])])])])])])])])).
sent(s_311_4_h, eng, 'Smith left the house before she took a taxi to the station').
sent(s_311_4_h, original, 'Smith left the house before she took a taxi to the station').
sent(s_311_4_h, swe, 'Smith lämnade huset innan hon tog en taxi till stationen').

tree(s_312_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('AdVVP', [t(always_AdV, []), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(deliver_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('UseN', [t(report_N, [])])])]), t(late_Adv, [])])])])])])).
sent(s_312_1_p, eng, 'ITEL always delivers reports late').
sent(s_312_1_p, original, 'ITEL always delivers reports late').
sent(s_312_1_p, swe, 'ITEL lämnar alltid rapporter sent').

tree(s_312_2_p, t('Sentence', [t('AdvS', [t(in_1993_Adv, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(deliver_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('UseN', [t(report_N, [])])])])])])])])).
sent(s_312_2_p, eng, 'in 1993 ITEL delivered reports').
sent(s_312_2_p, original, 'in 1993 ITEL delivered reports').
sent(s_312_2_p, swe, '1993 lämnade ITEL rapporter').

tree(s_312_3_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('AdvVP', [t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(deliver_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('UseN', [t(report_N, [])])])]), t(late_Adv, [])]), t(in_1993_Adv, [])])])])])])).
sent(s_312_3_q, eng, 'did ITEL deliver reports late in 1993').
sent(s_312_3_q, original, 'did ITEL deliver reports late in 1993').
sent(s_312_3_q, swe, 'lämnade ITEL rapporter sent 1993').

tree(s_312_4_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('AdvVP', [t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(deliver_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('UseN', [t(report_N, [])])])]), t(late_Adv, [])]), t(in_1993_Adv, [])])])])])).
sent(s_312_4_h, eng, 'ITEL delivered reports late in 1993').
sent(s_312_4_h, original, 'ITEL delivered reports late in 1993').
sent(s_312_4_h, swe, 'ITEL lämnade rapporter sent 1993').

tree(s_313_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('AdVVP', [t(never_AdV, []), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(deliver_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('UseN', [t(report_N, [])])])]), t(late_Adv, [])])])])])])).
sent(s_313_1_p, eng, 'ITEL never delivers reports late').
sent(s_313_1_p, original, 'ITEL never delivers reports late').
sent(s_313_1_p, swe, 'ITEL lämnar aldrig rapporter sent').

tree(s_313_2_p, s_312_2_p).
sent(s_313_2_p, eng, 'in 1993 ITEL delivered reports').
sent(s_313_2_p, original, 'in 1993 ITEL delivered reports').
sent(s_313_2_p, swe, '1993 lämnade ITEL rapporter').

tree(s_313_3_q, s_312_3_q).
sent(s_313_3_q, eng, 'did ITEL deliver reports late in 1993').
sent(s_313_3_q, original, 'did ITEL deliver reports late in 1993').
sent(s_313_3_q, swe, 'lämnade ITEL rapporter sent 1993').

tree(s_313_4_h, s_312_4_h).
sent(s_313_4_h, eng, 'ITEL delivered reports late in 1993').
sent(s_313_4_h, original, 'ITEL delivered reports late in 1993').
sent(s_313_4_h, swe, 'ITEL lämnade rapporter sent 1993').

tree(s_314_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(arrive_in_V2, [])]), t('UsePN', [t(paris_PN, [])])]), t(on_the_5th_of_may_1995_Adv, [])])])])])).
sent(s_314_1_p, eng, 'Smith arrived in Paris on the 5th of May , 1995').
sent(s_314_1_p, original, 'Smith arrived in Paris on the 5th of May , 1995').
sent(s_314_1_p, swe, 'Smith anlände till Paris den 5:e maj 1995').

tree(s_314_2_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('MassNP', [t('UseN', [t(today_N, [])])]), t('UseComp', [t('CompAdv', [t(the_15th_of_may_1995_Adv, [])])])])])])).
sent(s_314_2_p, eng, 'today is the 15th of May , 1995').
sent(s_314_2_p, original, 'today is the 15th of May , 1995').
sent(s_314_2_p, swe, 'idag är den 15 maj 1995').

tree(s_314_3_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePron', [t(she_Pron, [])]), t('AdVVP', [t(still_AdV, []), t('UseComp', [t('CompAdv', [t('PrepNP', [t(in_Prep, []), t('UsePN', [t(paris_PN, [])])])])])])])])])).
sent(s_314_3_p, eng, 'she is still in Paris').
sent(s_314_3_p, original, 'she is still in Paris').
sent(s_314_3_p, swe, 'hon är fortfarande i Paris').

tree(s_314_4_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('UseComp', [t('CompAdv', [t('PrepNP', [t(in_Prep, []), t('UsePN', [t(paris_PN, [])])])])]), t(on_the_7th_of_may_1995_Adv, [])])])])])])).
sent(s_314_4_q, eng, 'was Smith in Paris on the 7th of May , 1995').
sent(s_314_4_q, original, 'was Smith in Paris on the 7th of May , 1995').
sent(s_314_4_q, swe, 'var Smith i Paris den 7:e maj 1995').

tree(s_314_5_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('UseComp', [t('CompAdv', [t('PrepNP', [t(in_Prep, []), t('UsePN', [t(paris_PN, [])])])])]), t(on_the_7th_of_may_1995_Adv, [])])])])])).
sent(s_314_5_h, eng, 'Smith was in Paris on the 7th of May , 1995').
sent(s_314_5_h, original, 'Smith was in Paris on the 7th of May , 1995').
sent(s_314_5_h, swe, 'Smith var i Paris den 7:e maj 1995').

tree(s_315_1_p, t('Sentence', [t('AdvS', [t('SubjS', [t(when_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(arrive_in_V2, [])]), t('UsePN', [t(katmandu_PN, [])])])])])]), t('UseCl', [t('PastPerfect', []), t('PPos', []), t('PredVP', [t('UsePron', [t(she_Pron, [])]), t('AdvVP', [t('ProgrVPa', [t('UseV', [t(travel_V, [])])]), t(for_three_days_Adv, [])])])])])])).
sent(s_315_1_p, eng, 'when Smith arrived in Katmandu she had been travelling for three days').
sent(s_315_1_p, original, 'when Smith arrived in Katmandu she had been travelling for three days').
sent(s_315_1_p, swe, 'när Smith anlände till Katmandu hade hon rest i tre dagar').

sent(s_315_2_q, original, 'had Smith been travelling the day before she arrived in Katmandu').

sent(s_315_3_h, original, 'Smith had been travelling the day before she arrived in Katmandu').

tree(s_315_3_h_NEW, t('Sentence', [t('UseCl', [t('PastPerfect', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('ProgrVPa', [t('UseV', [t(travel_V, [])])]), t('PrepNP', [t(on_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('AdvCN', [t('UseN', [t(day_N, [])]), t('SubjS', [t(before_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePron', [t(she_Pron, [])]), t('ComplSlash', [t('SlashV2a', [t(arrive_in_V2, [])]), t('UsePN', [t(katmandu_PN, [])])])])])])])])])])])])])).
sent(s_315_3_h_NEW, eng, 'Smith had been travelling on the day before she arrived in Katmandu').
sent(s_315_3_h_NEW, original, 'Smith had been travelling on the day before she arrived in Katmandu').
sent(s_315_3_h_NEW, swe, 'Smith hade rest på dagen innan hon anlände till Katmandu').

tree(s_316_1_p, t('Sentence', [t('PredVPS', [t('UsePN', [t(jones_PN, [])]), t('ConjVPS2', [t(and_Conj, []), t('Past', []), t('PPos', []), t('AdvVP', [t('UseV', [t(graduate_V, [])]), t(in_march_Adv, [])]), t('PresentPerfect', []), t('PPos', []), t('AdvVP', [t('UseComp', [t('CompAP', [t('PositA', [t(employed_A, [])])])]), t(ever_since_Adv, [])])])])])).
sent(s_316_1_p, eng, 'Jones graduated in March and has been employed ever since').
sent(s_316_1_p, original, 'Jones graduated in March and has been employed ever since').
sent(s_316_1_p, swe, 'Jones utexaminerades i mars och har varit anställd ända sedan dess').

tree(s_316_2_p, t('Sentence', [t('UseCl', [t('PresentPerfect', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('AdvVP', [t('UseComp', [t('CompAP', [t('PositA', [t(unemployed_A, [])])])]), t(in_the_past_Adv, [])])])])])).
sent(s_316_2_p, eng, 'Jones has been unemployed in the past').
sent(s_316_2_p, original, 'Jones has been unemployed in the past').
sent(s_316_2_p, swe, 'Jones har varit arbetslös tidigare').

tree(s_316_3_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('AdvVP', [t('AdvVP', [t('UseComp', [t('CompAP', [t('PositA', [t(unemployed_A, [])])])]), t(at_some_time_Adv, [])]), t('SubjS', [t(before_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePron', [t(he_Pron, [])]), t('UseV', [t(graduate_V, [])])])])])])])])])])).
sent(s_316_3_q, eng, 'was Jones unemployed at some time before he graduated').
sent(s_316_3_q, original, 'was Jones unemployed at some time before he graduated').
sent(s_316_3_q, swe, 'var Jones arbetslös vid någon tidpunkt innan han utexaminerades').

tree(s_316_4_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('AdvVP', [t('AdvVP', [t('UseComp', [t('CompAP', [t('PositA', [t(unemployed_A, [])])])]), t(at_some_time_Adv, [])]), t('SubjS', [t(before_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePron', [t(he_Pron, [])]), t('UseV', [t(graduate_V, [])])])])])])])])])).
sent(s_316_4_h, eng, 'Jones was unemployed at some time before he graduated').
sent(s_316_4_h, original, 'Jones was unemployed at some time before he graduated').
sent(s_316_4_h, swe, 'Jones var arbetslös vid någon tidpunkt innan han utexaminerades').

tree(s_317_1_p, t('Sentence', [t('UseCl', [t('PresentPerfect', []), t('PPos', []), t('PredVP', [t('DetCN', [t(every_Det, []), t('UseN', [t(representative_N, [])])]), t('ComplSlash', [t('SlashV2a', [t(read_V2, [])]), t('DetCN', [t('DetQuant', [t(this_Quant, []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])])])])])).
sent(s_317_1_p, eng, 'every representative has read this report').
sent(s_317_1_p, original, 'every representative has read this report').
sent(s_317_1_p, swe, 'varje representant har läst den här rapporten').

tree(s_317_2_p, t('Sentence', [t('UseCl', [t('PresentPerfect', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t(no_Quant, []), t('NumCard', [t('NumNumeral', [t('N_two', [])])])]), t('UseN', [t(representative_N, [])])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(read_V2, [])]), t('UsePron', [t(it_Pron, [])])]), t(at_the_same_time_Adv, [])])])])])).
sent(s_317_2_p, eng, 'no two representatives have read it at the same time').
sent(s_317_2_p, original, 'no two representatives have read it at the same time').
sent(s_317_2_p, swe, 'inga två representanter har läst det samtidigt').

tree(s_317_3_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t(no_Quant, []), t('NumSg', [])]), t('UseN', [t(representative_N, [])])]), t('ComplSlash', [t('SlashV2V', [t(take_V2V, []), t('ComplSlash', [t('SlashV2a', [t(read_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('AdNum', [t(less_than_AdN, []), t(half_a_Card, [])])])]), t('UseN', [t(day_N, [])])])])])])])).
sent(s_317_3_p, eng, 'no representative took less than half a day to read the report').
sent(s_317_3_p, original, 'no representative took less than half a day to read the report').
sent(s_317_3_p, swe, 'ingen representant tog mindre än en halv dag att läsa rapporten').

tree(s_317_4_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('ExistNP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumCard', [t('NumNumeral', [t('N_sixteen', [])])])]), t('UseN', [t(representative_N, [])])])])])])).
sent(s_317_4_p, eng, 'there are sixteen representatives').
sent(s_317_4_p, original, 'there are sixteen representatives').
sent(s_317_4_p, swe, 'det finns sexton representanter').

tree(s_317_5_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('ImpersCl', [t('ComplSlash', [t('SlashV2V', [t(take_V2V, []), t('ComplSlash', [t('SlashV2a', [t(read_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumPl', [])]), t('AdjCN', [t('ComparA', [t(many_A, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(week_N, [])])])]), t('UseN', [t(representative_N, [])])])])])])])])])).
sent(s_317_5_q, eng, 'did it take the representatives more than a week to read the report').
sent(s_317_5_q, original, 'did it take the representatives more than a week to read the report').
sent(s_317_5_q, swe, 'tog det de representanterna mer än en vecka att läsa rapporten').

tree(s_317_6_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('ImpersCl', [t('ComplSlash', [t('SlashV2V', [t(take_V2V, []), t('ComplSlash', [t('SlashV2a', [t(read_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(report_N, [])])])])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumPl', [])]), t('AdjCN', [t('ComparA', [t(many_A, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(week_N, [])])])]), t('UseN', [t(representative_N, [])])])])])])])])).
sent(s_317_6_h, eng, 'it took the representatives more than a week to read the report').
sent(s_317_6_h, original, 'it took the representatives more than a week to read the report').
sent(s_317_6_h, swe, 'det tog de representanterna mer än en vecka att läsa rapporten').

tree(s_318_1_p, t('Sentence', [t('ExtAdvS', [t('SubjS', [t(while_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('ProgrVPa', [t('ComplSlash', [t('SlashV2a', [t(update_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(program_N, [])])])])])])])]), t('PredVPS', [t('UsePN', [t(mary_PN, [])]), t('ConjVPS2', [t(and_Conj, []), t('Past', []), t('PPos', []), t('UseV', [t(come_in_V, [])]), t('Past', []), t('PPos', []), t('ComplSlash', [t('Slash3V3', [t(tell_about_V3, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(board_meeting_N, [])])])]), t('UsePron', [t(he_Pron, [])])])])])])])).
sent(s_318_1_p, eng, 'while Jones was updating the program , Mary came in and told him about the board meeting').
sent(s_318_1_p, original, 'while Jones was updating the program , Mary came in and told him about the board meeting').
sent(s_318_1_p, swe, 'medan Jones uppdaterade programmet , kom in och berättade för honom om styrelsemötet Mary').

tree(s_318_2_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePron', [t(she_Pron, [])]), t('AdvVP', [t('ComplVV', [t(finish_VV, []), t(elliptic_VP, [])]), t('SubjS', [t(before_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePron', [t(he_Pron, [])]), t('ComplVV', [t(do_VV, []), t(elliptic_VP, [])])])])])])])])])).
sent(s_318_2_p, eng, 'she finished [..] before he did [..]').
sent(s_318_2_p, original, 'she finished [..] before he did [..]').
sent(s_318_2_p, swe, 'hon slutade att [..] innan han gjorde [..]').

sent(s_318_3_q, original, 'did Mary\'s story last as long as Jones\' updating the program').

sent(s_318_4_h, original, 'Mary\'s story lasted as long as Jones\' updating the program').

tree(s_319_1_p, t('Sentence', [t('ExtAdvS', [t('SubjS', [t(before_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(apcom_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(buy_V2, [])]), t('DetCN', [t('DetQuant', [t('PossPron', [t(itRefl_Pron, [])]), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(present8current_A, [])]), t('UseN', [t(office_building_N, [])])])])])])])]), t('UseCl', [t('PastPerfect', []), t('PPos', []), t('ImpersCl', [t('AdvVP', [t('AdvVP', [t('ProgrVPa', [t('ComplSlash', [t('SlashV2a', [t(pay_V2, [])]), t('MassNP', [t('UseN', [t(mortgage_interest_N, [])])])])]), t('PrepNP', [t(on_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(previous_A, [])]), t('UseN', [t(one_N, [])])])])])]), t(for_8_years_Adv, [])])])])])])).
sent(s_319_1_p, eng, 'before APCOM bought its present office building , it had been paying mortgage interest on the previous one for 8 years').
sent(s_319_1_p, original, 'before APCOM bought its present office building , it had been paying mortgage interest on the previous one for 8 years').
sent(s_319_1_p, swe, 'innan APCOM köpte sin nuvarande kontorsbyggnad , hade det betalat hypoteksränta på den förra nen i 8 år').

tree(s_319_2_p, t('Sentence', [t('AdvS', [t('SubjS', [t(since_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(apcom_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(buy_V2, [])]), t('DetCN', [t('DetQuant', [t('PossPron', [t(itRefl_Pron, [])]), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(present8current_A, [])]), t('UseN', [t(office_building_N, [])])])])])])])]), t('UseCl', [t('PresentPerfect', []), t('PPos', []), t('ImpersCl', [t('AdvVP', [t('AdvVP', [t('ProgrVPa', [t('ComplSlash', [t('SlashV2a', [t(pay_V2, [])]), t('MassNP', [t('UseN', [t(mortgage_interest_N, [])])])])]), t('PrepNP', [t(on_Prep, []), t('UsePron', [t(it_Pron, [])])])]), t(for_more_than_10_years_Adv, [])])])])])])).
sent(s_319_2_p, eng, 'since APCOM bought its present office building it has been paying mortgage interest on it for more than 10 years').
sent(s_319_2_p, original, 'since APCOM bought its present office building it has been paying mortgage interest on it for more than 10 years').
sent(s_319_2_p, swe, 'sedan APCOM köpte sin nuvarande kontorsbyggnad har det betalat hypoteksränta på det i mer än 10 år').

tree(s_319_3_q, t('Question', [t('UseQCl', [t('PresentPerfect', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(apcom_PN, [])]), t('AdvVP', [t('ProgrVPa', [t('ComplSlash', [t('SlashV2a', [t(pay_V2, [])]), t('MassNP', [t('UseN', [t(mortgage_interest_N, [])])])])]), t(for_a_total_of_15_years_or_more_Adv, [])])])])])])).
sent(s_319_3_q, eng, 'has APCOM been paying mortgage interest for a total of 15 years or more').
sent(s_319_3_q, original, 'has APCOM been paying mortgage interest for a total of 15 years or more').
sent(s_319_3_q, swe, 'har APCOM betalat hypoteksränta i totalt 15 år eller mer').

tree(s_319_4_h, t('Sentence', [t('UseCl', [t('PresentPerfect', []), t('PPos', []), t('PredVP', [t('UsePN', [t(apcom_PN, [])]), t('AdvVP', [t('ProgrVPa', [t('ComplSlash', [t('SlashV2a', [t(pay_V2, [])]), t('MassNP', [t('UseN', [t(mortgage_interest_N, [])])])])]), t(for_a_total_of_15_years_or_more_Adv, [])])])])])).
sent(s_319_4_h, eng, 'APCOM has been paying mortgage interest for a total of 15 years or more').
sent(s_319_4_h, original, 'APCOM has been paying mortgage interest for a total of 15 years or more').
sent(s_319_4_h, swe, 'APCOM har betalat hypoteksränta i totalt 15 år eller mer').

tree(s_320_1_p, t('Sentence', [t('ExtAdvS', [t('SubjS', [t(when_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(get_V2, [])]), t('DetCN', [t('DetQuant', [t('PossPron', [t(heRefl_Pron, [])]), t('NumSg', [])]), t('AdvCN', [t('UseN', [t(job_N, [])]), t('PrepNP', [t(at_Prep, []), t('UsePN', [t(the_cia_PN, [])])])])])])])])]), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePron', [t(he_Pron, [])]), t('ComplVS', [t(know_VS, []), t('UseCl', [t('Conditional', []), t('PPos', []), t('PredVP', [t('UsePron', [t(he_Pron, [])]), t('AdVVP', [t(never_AdV, []), t('PassVPSlash', [t('SlashV2V', [t(allow_V2V, []), t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('PossPron', [t(heRefl_Pron, [])]), t('NumPl', [])]), t('UseN', [t(memoir_N, [])])])])])])])])])])])])])])).
sent(s_320_1_p, eng, 'when Jones got his job at the CIA , he knew that he would never be allowed to write his memoirs').
sent(s_320_1_p, original, 'when Jones got his job at the CIA , he knew that he would never be allowed to write his memoirs').

sent(s_320_2_q, original, 'is it the case that Jones is not and will never be allowed to write his memoirs').

sent(s_320_3_h, original, 'it is the case that Jones is not and will never be allowed to write his memoirs').

tree(s_320_3_h_NEW, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('ImpersCl', [t('AdvVP', [t('UseComp', [t('CompNP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(case_N, [])])])])]), t('SubjS', [t(that_Subj, []), t('PredVPS', [t('UsePN', [t(jones_PN, [])]), t('ConjVPS2', [t(and_Conj, []), t('Present', []), t('UncNeg', []), t('PassVPSlash', [t(elliptic_VPSlash, [])]), t('Future', []), t('PPos', []), t('AdVVP', [t(never_AdV, []), t('PassVPSlash', [t('SlashV2V', [t(allow_V2V, []), t('ComplSlash', [t('SlashV2a', [t(write_V2, [])]), t('DetCN', [t('DetQuant', [t('PossPron', [t(heRefl_Pron, [])]), t('NumPl', [])]), t('UseN', [t(memoir_N, [])])])])])])])])])])])])])])).
sent(s_320_3_h_NEW, eng, 'it is the case that Jones is not [..] and never will be allowed to write his memoirs').
sent(s_320_3_h_NEW, original, 'it is the case that Jones is not [..] and never will be allowed to write his memoirs').

tree(s_321_1_p, t('Sentence', [t('UseCl', [t('PresentPerfect', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('AdvVP', [t('UseComp', [t('CompAdv', [t('PrepNP', [t(to_Prep, []), t('UsePN', [t(florence_PN, [])])])])]), t(twice_Adv, [])]), t(in_the_past_Adv, [])])])])])).
sent(s_321_1_p, eng, 'Smith has been to Florence twice in the past').
sent(s_321_1_p, original, 'Smith has been to Florence twice in the past').
sent(s_321_1_p, swe, 'Smith har varit till Florens två gånger tidigare').

tree(s_321_2_p, t('Sentence', [t('UseCl', [t('Future', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('AdvVP', [t('AdvVP', [t('UseV', [t(go8travel_V, [])]), t('PrepNP', [t(to_Prep, []), t('UsePN', [t(florence_PN, [])])])]), t(twice_Adv, [])]), t(in_the_coming_year_Adv, [])])])])])).
sent(s_321_2_p, eng, 'Smith will go to Florence twice in the coming year').
sent(s_321_2_p, original, 'Smith will go to Florence twice in the coming year').
sent(s_321_2_p, swe, 'Smith ska åka till Florens två gånger under det kommande året').

sent(s_321_3_q, original, 'two years from now will Smith have been to Florence at least four times').

tree(s_321_4_h, t('Sentence', [t('AdvS', [t(two_years_from_now_Adv, []), t('UseCl', [t('FuturePerfect', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('AdvVP', [t('UseComp', [t('CompAdv', [t('PrepNP', [t(to_Prep, []), t('UsePN', [t(florence_PN, [])])])])]), t(at_least_four_times, [])])])])])])).
sent(s_321_4_h, eng, 'two years from now Smith will have been to Florence at least four times').
sent(s_321_4_h, original, 'two years from now Smith will have been to Florence at least four times').
sent(s_321_4_h, swe, 'om två år ska Smith ha varit till Florens minst fyra gånger').

sent(s_322_1_p, original, 'last week I already knew that when , in a month\'s time , Smith would discover that she had been duped she would be furious').

tree(s_322_1_p_NEW, t('Sentence', [t('AdvS', [t(last_week_Adv, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePron', [t(i_Pron, [])]), t('AdVVP', [t(already_AdV, []), t('ComplVS', [t(know_VS, []), t('ExtAdvS', [t('SubjS', [t(when_Subj, []), t('ExtAdvS', [t(in_a_months_time_Adv, []), t('UseCl', [t('Conditional', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplVS', [t(discover_VS, []), t('UseCl', [t('PastPerfect', []), t('PPos', []), t('PredVP', [t('UsePron', [t(she_Pron, [])]), t('PassV2', [t(dupe_V2, [])])])])])])])])]), t('UseCl', [t('Conditional', []), t('PPos', []), t('PredVP', [t('UsePron', [t(she_Pron, [])]), t('UseComp', [t('CompAP', [t('PositA', [t(furious_A, [])])])])])])])])])])])])])).
sent(s_322_1_p_NEW, eng, 'last week I already knew that when in a month\'s time , Smith would discover that she had been duped , she would be furious').
sent(s_322_1_p_NEW, original, 'last week I already knew that when in a month\'s time , Smith would discover that she had been duped , she would be furious').
sent(s_322_1_p_NEW, swe, 'förra veckan visste jag redan att när om en månad , skulle Smith upptäcka att hon hade blivit lurad , skulle hon vara rasande').

sent(s_322_2_q, original, 'will it be the case that in a few weeks Smith will discover that she has been duped; and will she be furious').

tree(s_322_3_h, t('Sentence', [t('UseCl', [t('Future', []), t('PPos', []), t('ImpersCl', [t('AdvVP', [t('UseComp', [t('CompNP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(case_N, [])])])])]), t('SubjS', [t(that_Subj, []), t('ConjS2', [t(semicolon_and_Conj, []), t('AdvS', [t(in_a_few_weeks_Adv, []), t('UseCl', [t('Future', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplVS', [t(discover_VS, []), t('UseCl', [t('PresentPerfect', []), t('PPos', []), t('PredVP', [t('UsePron', [t(she_Pron, [])]), t('PassV2', [t(dupe_V2, [])])])])])])])]), t('UseCl', [t('Future', []), t('PPos', []), t('PredVP', [t('UsePron', [t(she_Pron, [])]), t('UseComp', [t('CompAP', [t('PositA', [t(furious_A, [])])])])])])])])])])])])).
sent(s_322_3_h, eng, 'it will be the case that in a few weeks Smith will discover that she has been duped ; and she will be furious').
sent(s_322_3_h, original, 'it will be the case that in a few weeks Smith will discover that she has been duped; and she will be furious').
sent(s_322_3_h, swe, 'det ska vara fallet att om några veckor ska Smith upptäcka att hon har blivit lurad ; och hon ska vara rasande').

sent(s_323_1_p, original, 'no one gambling seriously stops until he is broke').

tree(s_323_1_p_NEW, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('RelNPa', [t('UsePron', [t(no_one_Pron, [])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('AdvVP', [t('ProgrVPa', [t('UseV', [t(gamble_V, [])])]), t('PositAdvAdj', [t(serious_A, [])])])])])]), t('AdvVP', [t('UseV', [t(stop_V, [])]), t('SubjS', [t(until_Subj, []), t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePron', [t(he_Pron, [])]), t('UseComp', [t('CompAP', [t('PositA', [t(broke_A, [])])])])])])])])])])])).
sent(s_323_1_p_NEW, eng, 'no one who is gambling seriously stops until he is broke').
sent(s_323_1_p_NEW, original, 'no one who is gambling seriously stops until he is broke').
sent(s_323_1_p_NEW, swe, 'ingen som spelar seriöst slutar förrän han är pank').

tree(s_323_2_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePron', [t(no_one_Pron, [])]), t('ComplVV', [t(can_VV, []), t('AdvVP', [t('UseV', [t(gamble_V, [])]), t('SubjS', [t(when_Subj, []), t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePron', [t(he_Pron, [])]), t('UseComp', [t('CompAP', [t('PositA', [t(broke_A, [])])])])])])])])])])])])).
sent(s_323_2_p, eng, 'no one can gamble when he is broke').
sent(s_323_2_p, original, 'no one can gamble when he is broke').
sent(s_323_2_p, swe, 'ingen kan spela när han är pank').

sent(s_323_3_q, original, 'does everyone who starts gambling seriously stop the moment he is broke').

sent(s_323_4_h, original, 'everyone who starts gambling seriously stops the moment he is broke').

tree(s_323_4_h_NEW, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('RelNPa', [t('UsePron', [t(everyone_Pron, [])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('ComplVV', [t(start_VV, []), t('AdvVP', [t('UseV', [t(gamble_V, [])]), t('PositAdvAdj', [t(serious_A, [])])])])])])]), t('AdvVP', [t('UseV', [t(stop_V, [])]), t('PrepNP', [t(at_Prep, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('AdvCN', [t('UseN', [t(moment_N, [])]), t('SubjS', [t(when_Subj, []), t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePron', [t(he_Pron, [])]), t('UseComp', [t('CompAP', [t('PositA', [t(broke_A, [])])])])])])])])])])])])])])).
sent(s_323_4_h_NEW, eng, 'everyone who starts gambling seriously stops at the moment when he is broke').
sent(s_323_4_h_NEW, original, 'everyone who starts gambling seriously stops at the moment when he is broke').
sent(s_323_4_h_NEW, swe, 'alla som börjar spela seriöst slutar på ögonblicket när han är pank').

tree(s_324_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('RelNPa', [t('UsePron', [t(no_one_Pron, [])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('ComplVV', [t(start_VV, []), t('AdvVP', [t('UseV', [t(gamble_V, [])]), t('PositAdvAdj', [t(serious_A, [])])])])])])]), t('AdvVP', [t('UseV', [t(stop_V, [])]), t('SubjS', [t(until_Subj, []), t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePron', [t(he_Pron, [])]), t('UseComp', [t('CompAP', [t('PositA', [t(broke_A, [])])])])])])])])])])])).
sent(s_324_1_p, eng, 'no one who starts gambling seriously stops until he is broke').
sent(s_324_1_p, original, 'no one who starts gambling seriously stops until he is broke').
sent(s_324_1_p, swe, 'ingen som börjar spela seriöst slutar förrän han är pank').

sent(s_324_2_q, original, 'does everyone who starts gambling seriously continue until he is broke').

tree(s_324_3_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('RelNPa', [t('UsePron', [t(everyone_Pron, [])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('ComplVV', [t(start_VV, []), t('AdvVP', [t('UseV', [t(gamble_V, [])]), t('PositAdvAdj', [t(serious_A, [])])])])])])]), t('AdvVP', [t('UseV', [t(continue_V, [])]), t('SubjS', [t(until_Subj, []), t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePron', [t(he_Pron, [])]), t('UseComp', [t('CompAP', [t('PositA', [t(broke_A, [])])])])])])])])])])])).
sent(s_324_3_h, eng, 'everyone who starts gambling seriously continues until he is broke').
sent(s_324_3_h, original, 'everyone who starts gambling seriously continues until he is broke').
sent(s_324_3_h, swe, 'alla som börjar spela seriöst fortsätter förrän han är pank').

tree(s_325_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('RelNPa', [t('UsePron', [t(nobody_Pron, [])]), t('UseRCl', [t('Present', []), t('PPos', []), t('RelVP', [t('IdRP', []), t('UseComp', [t('CompAP', [t('PositA', [t(asleep_A, [])])])])])])]), t('AdVVP', [t(ever_AdV, []), t('ComplVS', [t(know_VS, []), t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePron', [t(he_Pron, [])]), t('UseComp', [t('CompAP', [t('PositA', [t(asleep_A, [])])])])])])])])])])])).
sent(s_325_1_p, eng, 'nobody who is asleep ever knows that he is asleep').
sent(s_325_1_p, original, 'nobody who is asleep ever knows that he is asleep').
sent(s_325_1_p, swe, 'ingen som är sovande vet någonsin att han är sovande').

tree(s_325_2_p, t('PSentence', [t(but_PConj, []), t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t(somePl_Det, []), t('UseN', [t(person_N, [])])]), t('AdvVP', [t('ComplVS', [t(know_VS, []), t('UseCl', [t('PresentPerfect', []), t('PPos', []), t('PredVP', [t('UsePron', [t(they_Pron, [])]), t('UseComp', [t('CompAP', [t('PositA', [t(asleep_A, [])])])])])])]), t('SubjS', [t(after_Subj, []), t('UseCl', [t('PresentPerfect', []), t('PPos', []), t('PredVP', [t('UsePron', [t(they_Pron, [])]), t('UseComp', [t('CompAP', [t('PositA', [t(asleep_A, [])])])])])])])])])])])).
sent(s_325_2_p, eng, 'but some people know that they have been asleep after they have been asleep').
sent(s_325_2_p, original, 'but some people know that they have been asleep after they have been asleep').
sent(s_325_2_p, swe, 'men några människor vet att de har varit sovande efter det att de har varit sovande').

tree(s_325_3_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('DetCN', [t(somePl_Det, []), t('UseN', [t(person_N, [])])]), t('ComplVS', [t(discover_VS, []), t('UseCl', [t('PresentPerfect', []), t('PPos', []), t('PredVP', [t('UsePron', [t(they_Pron, [])]), t('UseComp', [t('CompAP', [t('PositA', [t(asleep_A, [])])])])])])])])])])])).
sent(s_325_3_q, eng, 'do some people discover that they have been asleep').
sent(s_325_3_q, original, 'do some people discover that they have been asleep').
sent(s_325_3_q, swe, 'upptäcker några människor att de har varit sovande').

tree(s_325_4_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t(somePl_Det, []), t('UseN', [t(person_N, [])])]), t('ComplVS', [t(discover_VS, []), t('UseCl', [t('PresentPerfect', []), t('PPos', []), t('PredVP', [t('UsePron', [t(they_Pron, [])]), t('UseComp', [t('CompAP', [t('PositA', [t(asleep_A, [])])])])])])])])])])).
sent(s_325_4_h, eng, 'some people discover that they have been asleep').
sent(s_325_4_h, original, 'some people discover that they have been asleep').
sent(s_325_4_h, swe, 'några människor upptäcker att de har varit sovande').

tree(s_326_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(build_V2, [])]), t('UsePN', [t(mtalk_PN, [])])]), t(in_1993_Adv, [])])])])])).
sent(s_326_1_p, eng, 'ITEL built MTALK in 1993').
sent(s_326_1_p, original, 'ITEL built MTALK in 1993').
sent(s_326_1_p, swe, 'ITEL tillverkade MTALK 1993').

tree(s_326_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(finish_V2, [])]), t('UsePN', [t(mtalk_PN, [])])]), t(in_1993_Adv, [])])])])])])).
sent(s_326_2_q, eng, 'did ITEL finish MTALK in 1993').
sent(s_326_2_q, original, 'did ITEL finish MTALK in 1993').
sent(s_326_2_q, swe, 'slutförde ITEL MTALK 1993').

tree(s_326_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(finish_V2, [])]), t('UsePN', [t(mtalk_PN, [])])]), t(in_1993_Adv, [])])])])])).
sent(s_326_3_h, eng, 'ITEL finished MTALK in 1993').
sent(s_326_3_h, original, 'ITEL finished MTALK in 1993').
sent(s_326_3_h, swe, 'ITEL slutförde MTALK 1993').

tree(s_327_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('AdvVP', [t('ProgrVPa', [t('ComplSlash', [t('SlashV2a', [t(build_V2, [])]), t('UsePN', [t(mtalk_PN, [])])])]), t(in_1993_Adv, [])])])])])).
sent(s_327_1_p, eng, 'ITEL was building MTALK in 1993').
sent(s_327_1_p, original, 'ITEL was building MTALK in 1993').
sent(s_327_1_p, swe, 'ITEL tillverkade MTALK 1993').

tree(s_327_2_q, s_326_2_q).
sent(s_327_2_q, eng, 'did ITEL finish MTALK in 1993').
sent(s_327_2_q, original, 'did ITEL finish MTALK in 1993').
sent(s_327_2_q, swe, 'slutförde ITEL MTALK 1993').

tree(s_327_3_h, s_326_3_h).
sent(s_327_3_h, eng, 'ITEL finished MTALK in 1993').
sent(s_327_3_h, original, 'ITEL finished MTALK in 1993').
sent(s_327_3_h, swe, 'ITEL slutförde MTALK 1993').

tree(s_328_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('AdvVP', [t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(win_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])]), t('PrepNP', [t(from_Prep, []), t('UsePN', [t(apcom_PN, [])])])]), t(in_1993_Adv, [])])])])])).
sent(s_328_1_p, eng, 'ITEL won the contract from APCOM in 1993').
sent(s_328_1_p, original, 'ITEL won the contract from APCOM in 1993').
sent(s_328_1_p, swe, 'ITEL vann kontraktet från APCOM 1993').

tree(s_328_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(win_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])]), t(in_1993_Adv, [])])])])])])).
sent(s_328_2_q, eng, 'did ITEL win a contract in 1993').
sent(s_328_2_q, original, 'did ITEL win a contract in 1993').
sent(s_328_2_q, swe, 'vann ITEL ett kontrakt 1993').

tree(s_328_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(win_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])]), t(in_1993_Adv, [])])])])])).
sent(s_328_3_h, eng, 'ITEL won a contract in 1993').
sent(s_328_3_h, original, 'ITEL won a contract in 1993').
sent(s_328_3_h, swe, 'ITEL vann ett kontrakt 1993').

tree(s_329_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('AdvVP', [t('AdvVP', [t('ProgrVPa', [t('ComplSlash', [t('SlashV2a', [t(win_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])])]), t('PrepNP', [t(from_Prep, []), t('UsePN', [t(apcom_PN, [])])])]), t(in_1993_Adv, [])])])])])).
sent(s_329_1_p, eng, 'ITEL was winning the contract from APCOM in 1993').
sent(s_329_1_p, original, 'ITEL was winning the contract from APCOM in 1993').
sent(s_329_1_p, swe, 'ITEL vann kontraktet från APCOM 1993').

tree(s_329_2_q, s_328_2_q).
sent(s_329_2_q, eng, 'did ITEL win a contract in 1993').
sent(s_329_2_q, original, 'did ITEL win a contract in 1993').
sent(s_329_2_q, swe, 'vann ITEL ett kontrakt 1993').

tree(s_329_3_h, s_328_3_h).
sent(s_329_3_h, eng, 'ITEL won a contract in 1993').
sent(s_329_3_h, original, 'ITEL won a contract in 1993').
sent(s_329_3_h, swe, 'ITEL vann ett kontrakt 1993').

tree(s_330_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(own_V2, [])]), t('UsePN', [t(apcom_PN, [])])]), t(from_1988_to_1992_Adv, [])])])])])).
sent(s_330_1_p, eng, 'ITEL owned APCOM from 1988 to 1992').
sent(s_330_1_p, original, 'ITEL owned APCOM from 1988 to 1992').
sent(s_330_1_p, swe, 'ITEL ägde APCOM från 1988 till 1992').

tree(s_330_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(own_V2, [])]), t('UsePN', [t(apcom_PN, [])])]), t(in_1990_Adv, [])])])])])])).
sent(s_330_2_q, eng, 'did ITEL own APCOM in 1990').
sent(s_330_2_q, original, 'did ITEL own APCOM in 1990').
sent(s_330_2_q, swe, 'ägde ITEL APCOM 1990').

tree(s_330_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(own_V2, [])]), t('UsePN', [t(apcom_PN, [])])]), t(in_1990_Adv, [])])])])])).
sent(s_330_3_h, eng, 'ITEL owned APCOM in 1990').
sent(s_330_3_h, original, 'ITEL owned APCOM in 1990').
sent(s_330_3_h, swe, 'ITEL ägde APCOM 1990').

tree(s_331_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('ConjNP2', [t(and_Conj, []), t('UsePN', [t(smith_PN, [])]), t('UsePN', [t(jones_PN, [])])]), t('ComplSlash', [t('SlashV2a', [t(leave_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(meeting_N, [])])])])])])])).
sent(s_331_1_p, eng, 'Smith and Jones left the meeting').
sent(s_331_1_p, original, 'Smith and Jones left the meeting').
sent(s_331_1_p, swe, 'Smith och Jones lämnade mötet').

tree(s_331_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(leave_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(meeting_N, [])])])])])])])])).
sent(s_331_2_q, eng, 'did Smith leave the meeting').
sent(s_331_2_q, original, 'did Smith leave the meeting').
sent(s_331_2_q, swe, 'lämnade Smith mötet').

tree(s_331_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(leave_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(meeting_N, [])])])])])])])).
sent(s_331_3_h, eng, 'Smith left the meeting').
sent(s_331_3_h, original, 'Smith left the meeting').
sent(s_331_3_h, swe, 'Smith lämnade mötet').

tree(s_332_1_p, s_331_1_p).
sent(s_332_1_p, eng, 'Smith and Jones left the meeting').
sent(s_332_1_p, original, 'Smith and Jones left the meeting').
sent(s_332_1_p, swe, 'Smith och Jones lämnade mötet').

tree(s_332_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(leave_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(meeting_N, [])])])])])])])])).
sent(s_332_2_q, eng, 'did Jones leave the meeting').
sent(s_332_2_q, original, 'did Jones leave the meeting').
sent(s_332_2_q, swe, 'lämnade Jones mötet').

tree(s_332_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(leave_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(meeting_N, [])])])])])])])).
sent(s_332_3_h, eng, 'Jones left the meeting').
sent(s_332_3_h, original, 'Jones left the meeting').
sent(s_332_3_h, swe, 'Jones lämnade mötet').

tree(s_333_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('ConjNP3', [t(and_Conj, []), t('UsePN', [t(smith_PN, [])]), t('UsePN', [t(anderson_PN, [])]), t('UsePN', [t(jones_PN, [])])]), t('UseV', [t(meet_V, [])])])])])).
sent(s_333_1_p, eng, 'Smith , Anderson and Jones met').
sent(s_333_1_p, original, 'Smith , Anderson and Jones met').
sent(s_333_1_p, swe, 'Smith , Anderson och Jones träffades').

tree(s_333_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('ExistNP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('RelCN', [t('ComplN2', [t(group_N2, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('UseN', [t(person_N, [])])])]), t('UseRCl', [t('Past', []), t('PPos', []), t('RelVP', [t(that_RP, []), t('UseV', [t(meet_V, [])])])])])])])])])])).
sent(s_333_2_q, eng, 'was there a group of people that met').
sent(s_333_2_q, original, 'was there a group of people that met').
sent(s_333_2_q, swe, 'fanns det en grupp människor som träffades').

tree(s_333_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('ExistNP', [t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('RelCN', [t('ComplN2', [t(group_N2, []), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumPl', [])]), t('UseN', [t(person_N, [])])])]), t('UseRCl', [t('Past', []), t('PPos', []), t('RelVP', [t(that_RP, []), t('UseV', [t(meet_V, [])])])])])])])])])).
sent(s_333_3_h, eng, 'there was a group of people that met').
sent(s_333_3_h, original, 'there was a group of people that met').
sent(s_333_3_h, swe, 'det fanns en grupp människor som träffades').

tree(s_334_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplVS', [t(know_VS, []), t('UseCl', [t('PastPerfect', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(win_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])]), t(in_1992_Adv, [])])])])])])])])).
sent(s_334_1_p, eng, 'Smith knew that ITEL had won the contract in 1992').
sent(s_334_1_p, original, 'Smith knew that ITEL had won the contract in 1992').
sent(s_334_1_p, swe, 'Smith visste att ITEL hade vunnit kontraktet 1992').

tree(s_334_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(win_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])]), t(in_1992_Adv, [])])])])])])).
sent(s_334_2_q, eng, 'did ITEL win the contract in 1992').
sent(s_334_2_q, original, 'did ITEL win the contract in 1992').
sent(s_334_2_q, swe, 'vann ITEL kontraktet 1992').

tree(s_334_3_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(win_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])]), t(in_1992_Adv, [])])])])])).
sent(s_334_3_h, eng, 'ITEL won the contract in 1992').
sent(s_334_3_h, original, 'ITEL won the contract in 1992').
sent(s_334_3_h, swe, 'ITEL vann kontraktet 1992').

tree(s_335_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplVS', [t(believe_VS, []), t('UseCl', [t('PastPerfect', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(win_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])]), t(in_1992_Adv, [])])])])])])])])).
sent(s_335_1_p, eng, 'Smith believed that ITEL had won the contract in 1992').
sent(s_335_1_p, original, 'Smith believed that ITEL had won the contract in 1992').
sent(s_335_1_p, swe, 'Smith trodde att ITEL hade vunnit kontraktet 1992').

tree(s_335_2_q, s_334_2_q).
sent(s_335_2_q, eng, 'did ITEL win the contract in 1992').
sent(s_335_2_q, original, 'did ITEL win the contract in 1992').
sent(s_335_2_q, swe, 'vann ITEL kontraktet 1992').

tree(s_335_3_h, s_334_3_h).
sent(s_335_3_h, eng, 'ITEL won the contract in 1992').
sent(s_335_3_h, original, 'ITEL won the contract in 1992').
sent(s_335_3_h, swe, 'ITEL vann kontraktet 1992').

tree(s_336_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('AdvVP', [t('ComplVV', [t(manage_VV, []), t('ComplSlash', [t('SlashV2a', [t(win_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])])]), t(in_1992_Adv, [])])])])])).
sent(s_336_1_p, eng, 'ITEL managed to win the contract in 1992').
sent(s_336_1_p, original, 'ITEL managed to win the contract in 1992').
sent(s_336_1_p, swe, 'ITEL lyckades att vinna kontraktet 1992').

tree(s_336_2_q, s_334_2_q).
sent(s_336_2_q, eng, 'did ITEL win the contract in 1992').
sent(s_336_2_q, original, 'did ITEL win the contract in 1992').
sent(s_336_2_q, swe, 'vann ITEL kontraktet 1992').

tree(s_336_3_h, s_334_3_h).
sent(s_336_3_h, eng, 'ITEL won the contract in 1992').
sent(s_336_3_h, original, 'ITEL won the contract in 1992').
sent(s_336_3_h, swe, 'ITEL vann kontraktet 1992').

tree(s_337_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('AdvVP', [t('ComplVV', [t(try_VV, []), t('ComplSlash', [t('SlashV2a', [t(win_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])])]), t(in_1992_Adv, [])])])])])).
sent(s_337_1_p, eng, 'ITEL tried to win the contract in 1992').
sent(s_337_1_p, original, 'ITEL tried to win the contract in 1992').
sent(s_337_1_p, swe, 'ITEL försökte att vinna kontraktet 1992').

tree(s_337_2_q, s_334_2_q).
sent(s_337_2_q, eng, 'did ITEL win the contract in 1992').
sent(s_337_2_q, original, 'did ITEL win the contract in 1992').
sent(s_337_2_q, swe, 'vann ITEL kontraktet 1992').

tree(s_337_3_h, s_334_3_h).
sent(s_337_3_h, eng, 'ITEL won the contract in 1992').
sent(s_337_3_h, original, 'ITEL won the contract in 1992').
sent(s_337_3_h, swe, 'ITEL vann kontraktet 1992').

tree(s_338_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('ImpersCl', [t('UseComp', [t('CompAP', [t('SentAP', [t('PositA', [t(true_A, [])]), t('EmbedS', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(win_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])]), t(in_1992_Adv, [])])])])])])])])])])])).
sent(s_338_1_p, eng, 'it is true that ITEL won the contract in 1992').
sent(s_338_1_p, original, 'it is true that ITEL won the contract in 1992').
sent(s_338_1_p, swe, 'det är sant att ITEL vann kontraktet 1992').

tree(s_338_2_q, s_334_2_q).
sent(s_338_2_q, eng, 'did ITEL win the contract in 1992').
sent(s_338_2_q, original, 'did ITEL win the contract in 1992').
sent(s_338_2_q, swe, 'vann ITEL kontraktet 1992').

tree(s_338_3_h, s_334_3_h).
sent(s_338_3_h, eng, 'ITEL won the contract in 1992').
sent(s_338_3_h, original, 'ITEL won the contract in 1992').
sent(s_338_3_h, swe, 'ITEL vann kontraktet 1992').

tree(s_339_1_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('ImpersCl', [t('UseComp', [t('CompAP', [t('SentAP', [t('PositA', [t(false_A, [])]), t('EmbedS', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(itel_PN, [])]), t('AdvVP', [t('ComplSlash', [t('SlashV2a', [t(win_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])]), t(in_1992_Adv, [])])])])])])])])])])])).
sent(s_339_1_p, eng, 'it is false that ITEL won the contract in 1992').
sent(s_339_1_p, original, 'it is false that ITEL won the contract in 1992').
sent(s_339_1_p, swe, 'det är inte sant att ITEL vann kontraktet 1992').

tree(s_339_2_q, s_334_2_q).
sent(s_339_2_q, eng, 'did ITEL win the contract in 1992').
sent(s_339_2_q, original, 'did ITEL win the contract in 1992').
sent(s_339_2_q, swe, 'vann ITEL kontraktet 1992').

tree(s_339_3_h, s_334_3_h).
sent(s_339_3_h, eng, 'ITEL won the contract in 1992').
sent(s_339_3_h, original, 'ITEL won the contract in 1992').
sent(s_339_3_h, swe, 'ITEL vann kontraktet 1992').

tree(s_340_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2V', [t(see_V2V, []), t('ComplSlash', [t('SlashV2a', [t(sign_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])])]), t('UsePN', [t(jones_PN, [])])])])])])).
sent(s_340_1_p, eng, 'Smith saw Jones sign the contract').
sent(s_340_1_p, original, 'Smith saw Jones sign the contract').
sent(s_340_1_p, swe, 'Smith såg Jones underteckna kontraktet').

tree(s_340_2_p, t('Sentence', [t('ExtAdvS', [t('SubjS', [t(if_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(sign_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])])])])]), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('PossPron', [t(he_Pron, [])]), t('NumSg', [])]), t('UseN', [t(heart_N, [])])]), t('ProgrVPa', [t('UseV', [t(beat_V, [])])])])])])])).
sent(s_340_2_p, eng, 'if Jones signed the contract , his heart was beating').
sent(s_340_2_p, original, 'if Jones signed the contract , his heart was beating').
sent(s_340_2_p, swe, 'om Jones undertecknade kontraktet , slog hans hjärta').

tree(s_340_3_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2V', [t(see_V2V, []), t('UseV', [t(beat_V, [])])]), t('DetCN', [t('DetQuant', [t('GenNP', [t('UsePN', [t(jones_PN, [])])]), t('NumSg', [])]), t('UseN', [t(heart_N, [])])])])])])])])).
sent(s_340_3_q, eng, 'did Smith see Jones\' heart beat').
sent(s_340_3_q, original, 'did Smith see Jones\' heart beat').
sent(s_340_3_q, swe, 'såg Smith Jones hjärta slå').

tree(s_340_4_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2V', [t(see_V2V, []), t('UseV', [t(beat_V, [])])]), t('DetCN', [t('DetQuant', [t('GenNP', [t('UsePN', [t(jones_PN, [])])]), t('NumSg', [])]), t('UseN', [t(heart_N, [])])])])])])])).
sent(s_340_4_h, eng, 'Smith saw Jones\' heart beat').
sent(s_340_4_h, original, 'Smith saw Jones\' heart beat').
sent(s_340_4_h, swe, 'Smith såg Jones hjärta slå').

tree(s_341_1_p, s_340_1_p).
sent(s_341_1_p, eng, 'Smith saw Jones sign the contract').
sent(s_341_1_p, original, 'Smith saw Jones sign the contract').
sent(s_341_1_p, swe, 'Smith såg Jones underteckna kontraktet').

tree(s_341_2_p, t('Sentence', [t('ExtAdvS', [t('SubjS', [t(when_Subj, []), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('ComplSlash', [t('SlashV2a', [t(sign_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])])])])]), t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('PossPron', [t(he_Pron, [])]), t('NumSg', [])]), t('UseN', [t(heart_N, [])])]), t('ProgrVPa', [t('UseV', [t(beat_V, [])])])])])])])).
sent(s_341_2_p, eng, 'when Jones signed the contract , his heart was beating').
sent(s_341_2_p, original, 'when Jones signed the contract , his heart was beating').
sent(s_341_2_p, swe, 'när Jones undertecknade kontraktet , slog hans hjärta').

tree(s_341_3_q, s_340_3_q).
sent(s_341_3_q, eng, 'did Smith see Jones\' heart beat').
sent(s_341_3_q, original, 'did Smith see Jones\' heart beat').
sent(s_341_3_q, swe, 'såg Smith Jones hjärta slå').

tree(s_341_4_h, s_340_4_h).
sent(s_341_4_h, eng, 'Smith saw Jones\' heart beat').
sent(s_341_4_h, original, 'Smith saw Jones\' heart beat').
sent(s_341_4_h, swe, 'Smith såg Jones hjärta slå').

tree(s_342_1_p, s_341_1_p).
sent(s_342_1_p, eng, 'Smith saw Jones sign the contract').
sent(s_342_1_p, original, 'Smith saw Jones sign the contract').
sent(s_342_1_p, swe, 'Smith såg Jones underteckna kontraktet').

tree(s_342_2_q, s_081_2_q).
sent(s_342_2_q, eng, 'did Jones sign the contract').
sent(s_342_2_q, original, 'did Jones sign the contract').
sent(s_342_2_q, swe, 'undertecknade Jones kontraktet').

tree(s_342_3_h, s_081_3_h).
sent(s_342_3_h, eng, 'Jones signed the contract').
sent(s_342_3_h, original, 'Jones signed the contract').
sent(s_342_3_h, swe, 'Jones undertecknade kontraktet').

tree(s_343_1_p, s_341_1_p).
sent(s_343_1_p, eng, 'Smith saw Jones sign the contract').
sent(s_343_1_p, original, 'Smith saw Jones sign the contract').
sent(s_343_1_p, swe, 'Smith såg Jones underteckna kontraktet').

tree(s_343_2_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('UsePN', [t(jones_PN, [])]), t('UseComp', [t('CompNP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('ComplN2', [t(chairman_N2, []), t('UsePN', [t(itel_PN, [])])])])])])])])])).
sent(s_343_2_p, eng, 'Jones is the chairman of ITEL').
sent(s_343_2_p, original, 'Jones is the chairman of ITEL').
sent(s_343_2_p, swe, 'Jones är ordföranden för ITEL').

tree(s_343_3_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2V', [t(see_V2V, []), t('ComplSlash', [t('SlashV2a', [t(sign_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('ComplN2', [t(chairman_N2, []), t('UsePN', [t(itel_PN, [])])])])])])])])])).
sent(s_343_3_q, eng, 'did Smith see the chairman of ITEL sign the contract').
sent(s_343_3_q, original, 'did Smith see the chairman of ITEL sign the contract').
sent(s_343_3_q, swe, 'såg Smith ordföranden för ITEL underteckna kontraktet').

tree(s_343_4_h, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2V', [t(see_V2V, []), t('ComplSlash', [t('SlashV2a', [t(sign_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('ComplN2', [t(chairman_N2, []), t('UsePN', [t(itel_PN, [])])])])])])])])).
sent(s_343_4_h, eng, 'Smith saw the chairman of ITEL sign the contract').
sent(s_343_4_h, original, 'Smith saw the chairman of ITEL sign the contract').
sent(s_343_4_h, swe, 'Smith såg ordföranden för ITEL underteckna kontraktet').

tree(s_344_1_p, t('Sentence', [t('UseCl', [t('Past', []), t('PPos', []), t('PredVP', [t('UsePN', [t(helen_PN, [])]), t('ComplSlash', [t('SlashV2V', [t(see_V2V, []), t('ComplSlash', [t('SlashV2a', [t(answer_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(phone_N, [])])])])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('ComplN2', [t(chairman_N2, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(department_N, [])])])])])])])])])).
sent(s_344_1_p, eng, 'Helen saw the chairman of the department answer the phone').
sent(s_344_1_p, original, 'Helen saw the chairman of the department answer the phone').
sent(s_344_1_p, swe, 'Helen såg ordföranden för avdelningen svara i telefonen').

tree(s_344_2_p, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('PredVP', [t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('ComplN2', [t(chairman_N2, []), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(department_N, [])])])])]), t('UseComp', [t('CompCN', [t('UseN', [t(person_N, [])])])])])])])).
sent(s_344_2_p, eng, 'the chairman of the department is a person').
sent(s_344_2_p, original, 'the chairman of the department is a person').
sent(s_344_2_p, swe, 'ordföranden för avdelningen är en människa').

tree(s_344_3_q, t('Question', [t('UseQCl', [t('Present', []), t('PPos', []), t('QuestCl', [t('ExistNP', [t('RelNPa', [t('UsePron', [t(anyone_Pron, [])]), t('UseRCl', [t('Past', []), t('PPos', []), t('StrandRelSlash', [t('IdRP', []), t('SlashVP', [t('UsePN', [t(helen_PN, [])]), t('SlashV2V', [t(see_V2V, []), t('ComplSlash', [t('SlashV2a', [t(answer_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(phone_N, [])])])])])])])])])])])])])).
sent(s_344_3_q, eng, 'is there anyone whom Helen saw answer the phone').
sent(s_344_3_q, original, 'is there anyone whom Helen saw answer the phone').
sent(s_344_3_q, swe, 'finns det någon som Helen såg').

tree(s_344_4_h, t('Sentence', [t('UseCl', [t('Present', []), t('PPos', []), t('ExistNP', [t('RelNPa', [t('UsePron', [t(someone_Pron, [])]), t('UseRCl', [t('Past', []), t('PPos', []), t('StrandRelSlash', [t('IdRP', []), t('SlashVP', [t('UsePN', [t(helen_PN, [])]), t('SlashV2V', [t(see_V2V, []), t('ComplSlash', [t('SlashV2a', [t(answer_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(phone_N, [])])])])])])])])])])])])).
sent(s_344_4_h, eng, 'there is someone whom Helen saw answer the phone').
sent(s_344_4_h, original, 'there is someone whom Helen saw answer the phone').
sent(s_344_4_h, swe, 'det finns någon som Helen såg').

tree(s_345_1_p, t('Sentence', [t('PredVPS', [t('UsePN', [t(smith_PN, [])]), t('ConjVPS2', [t(and_Conj, []), t('Past', []), t('PPos', []), t('ComplSlash', [t('SlashV2V', [t(see_V2V, []), t('ComplSlash', [t('SlashV2a', [t(sign_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])])]), t('UsePN', [t(jones_PN, [])])]), t('Past', []), t('PPos', []), t('ComplSlash', [t('SlashV2V', [t(elliptic_V2V, []), t('ComplSlash', [t('SlashV2a', [t(make8do_V2, [])]), t('DetCN', [t('DetQuant', [t('IndefArt', []), t('NumSg', [])]), t('UseN', [t(copy_N, [])])])])]), t('DetCN', [t('DetQuant', [t('PossPron', [t(heRefl_Pron, [])]), t('NumSg', [])]), t('UseN', [t(secretary_N, [])])])])])])])).
sent(s_345_1_p, eng, 'Smith saw Jones sign the contract and [..] his secretary make a copy').
sent(s_345_1_p, original, 'Smith saw Jones sign the contract and [..] his secretary make a copy').
sent(s_345_1_p, swe, 'Smith såg Jones underteckna kontraktet och [..] sin sekreterare göra en kopia').

tree(s_345_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplSlash', [t('SlashV2V', [t(see_V2V, []), t('ComplSlash', [t('SlashV2a', [t(sign_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])])]), t('UsePN', [t(jones_PN, [])])])])])])])).
sent(s_345_2_q, eng, 'did Smith see Jones sign the contract').
sent(s_345_2_q, original, 'did Smith see Jones sign the contract').
sent(s_345_2_q, swe, 'såg Smith Jones underteckna kontraktet').

tree(s_345_3_h, s_340_1_p).
sent(s_345_3_h, eng, 'Smith saw Jones sign the contract').
sent(s_345_3_h, original, 'Smith saw Jones sign the contract').
sent(s_345_3_h, swe, 'Smith såg Jones underteckna kontraktet').

tree(s_346_1_p, t('Sentence', [t('PredVPS', [t('UsePN', [t(smith_PN, [])]), t('ConjVPS2', [t(or_Conj, []), t('Past', []), t('PPos', []), t('ComplSlash', [t('SlashV2V', [t(see_V2V, []), t('ComplSlash', [t('SlashV2a', [t(sign_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])])]), t('UsePN', [t(jones_PN, [])])]), t('Past', []), t('PPos', []), t('ComplSlash', [t('SlashV2V', [t(elliptic_V2V, []), t('ComplSlash', [t('SlashV2a', [t(cross_out_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(crucial_A, [])]), t('UseN', [t(clause_N, [])])])])])]), t(elliptic_NP_Sg, [])])])])])).
sent(s_346_1_p, eng, 'Smith saw Jones sign the contract or [..] [..] cross out the crucial clause').
sent(s_346_1_p, original, 'Smith saw Jones sign the contract or [..] [..] cross out the crucial clause').
sent(s_346_1_p, swe, 'Smith såg Jones underteckna kontraktet eller [..] [..] stryka över den kritiska paragrafen').

tree(s_346_2_q, t('Question', [t('UseQCl', [t('Past', []), t('PPos', []), t('QuestCl', [t('PredVP', [t('UsePN', [t(smith_PN, [])]), t('ComplVPIVV', [t(do_VV, []), t('ConjVPI2', [t(either7or_DConj, []), t('ComplSlash', [t('SlashV2V', [t(see_V2V, []), t('ComplSlash', [t('SlashV2a', [t(sign_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])])]), t('UsePN', [t(jones_PN, [])])]), t('ComplSlash', [t('SlashV2V', [t(see_V2V, []), t('ComplSlash', [t('SlashV2a', [t(cross_out_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(crucial_A, [])]), t('UseN', [t(clause_N, [])])])])])]), t('UsePN', [t(jones_PN, [])])])])])])])])])).
sent(s_346_2_q, eng, 'did Smith either see Jones sign the contract or see Jones cross out the crucial clause').
sent(s_346_2_q, original, 'did Smith either see Jones sign the contract or see Jones cross out the crucial clause').
sent(s_346_2_q, swe, 'gjorde Smith antingen se Jones underteckna kontraktet eller se Jones stryka över den kritiska paragrafen').

tree(s_346_3_h, t('Sentence', [t('PredVPS', [t('UsePN', [t(smith_PN, [])]), t('ConjVPS2', [t(either7or_DConj, []), t('Past', []), t('PPos', []), t('ComplSlash', [t('SlashV2V', [t(see_V2V, []), t('ComplSlash', [t('SlashV2a', [t(sign_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('UseN', [t(contract_N, [])])])])]), t('UsePN', [t(jones_PN, [])])]), t('Past', []), t('PPos', []), t('ComplSlash', [t('SlashV2V', [t(see_V2V, []), t('ComplSlash', [t('SlashV2a', [t(cross_out_V2, [])]), t('DetCN', [t('DetQuant', [t('DefArt', []), t('NumSg', [])]), t('AdjCN', [t('PositA', [t(crucial_A, [])]), t('UseN', [t(clause_N, [])])])])])]), t('UsePN', [t(jones_PN, [])])])])])])).
sent(s_346_3_h, eng, 'Smith either saw Jones sign the contract or saw Jones cross out the crucial clause').
sent(s_346_3_h, original, 'Smith either saw Jones sign the contract or saw Jones cross out the crucial clause').
sent(s_346_3_h, swe, 'Smith antingen såg Jones underteckna kontraktet eller såg Jones stryka över den kritiska paragrafen').

