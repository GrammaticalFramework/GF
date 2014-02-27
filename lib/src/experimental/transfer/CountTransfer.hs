module Main where

main = interact (unlines . map changeCounts . lines)

changeCounts = unlexer . concatMap counts . lexer

lexer s = case lex s of
  (t,s2@(_:_)):_ -> t:lexer s2
  _   -> []
  
unlexer = unwords

counts t = case t of
  "UttImpPl" -> ["PrImpPl"]
  "UttImpPol" -> ["PrImpPol"]
  "UttImpSg" -> ["PrImpSg"]
  "ImpVP" -> []
  "UttQS" -> ["UttPrS","UseQCl_none"]
  "UttS" -> ["UttPrS"]
  "UttVP" -> ["UttPrVPI","InfVP_none"]
  "UseRCl" -> []
  "TTAnt" -> []
  "RelCl" -> ["RelCl_none"]
  "RelVP" -> ["RelVP_none"]
  "RelSlash" -> ["RelSlash_none"]
  "PastPartRS" -> ["PastPartAP_none"]
  "PresPartRS" -> ["PresPartAP_none"]
  "ComparAdvAdjS" -> ["ComparAdvAdjS_none"] ----
  "SubjS" -> ["AdvSubjS"] ----
  "ConjS" -> ["UseClC_none"]
  "PredVPS" -> ["UseCl_none","PredVP_none","UseVPC_none"]
  "BaseVPS" -> ["StartVPC_none"]
  "ConsVPS" -> ["ContVPC_none"]
  "BaseS" -> ["StartClC_none"]
  "ConsS" -> ["ContClC_none"]
  "PredVP" -> ["PredVP_none"]
  "AdvVP" -> ["AdvCl_none","LiftAdv"]  ---- some for Cl, some for QCl
  "AdVVP" -> ["AdvQCl_none","LiftAdV"] ---- 
  "QuestVP" -> ["QuestVP_none"]
  "QuestSlash" -> ["QuestSlash_none"]
  "QuestCl" -> ["QuestCl_none"]
  "QuestIAdv" -> ["QuestIAdv_none"]
  "QuestIComp" -> ["QuestIComp_none"]
  "UseV" -> ["UseV_none"]
  "ComplVS" -> ["ComplVS_none","UseV_s","LiftVS"]
  "ComplVQ" -> ["ComplVQ_none","UseV_q","LiftVQ"]
  "ComplVA" -> ["ComplVA_none","UseV_a","LiftVA"]
  "ComplVV" -> ["ComplVV_none","UseV_v","LiftVV","InfVP_none"]
  "ComplSlash" -> ["ComplV2_none"]
  "UseComp" -> []
  "CompAP" -> ["UseAP_none","LiftAP"]
  "CompAdv" -> ["UseAdv_none","LiftAdv"]
  "CompCN" -> ["UseCN_none","LiftCN"]
  "CompNP" -> ["UseNP_none"]
  "CompVP" -> ["UseAP_none","InfAP_none"]
  "CompQS" -> ["UseQ_none"]
  "CompS" -> ["UseS_none"]
  "SlashV2a" -> ["UseV_np","LiftV2"]
  "ComplSlashPartLast" -> ["ComplV2_none"]
  "ComplVPIVV" -> ["ComplVV_none","UseV_v","LiftVV","InfVP_none"]
  "MkVPI" -> []
  "ConjVPI" -> ["UseVPC_none"]
  "PassVPSlash" -> ["PassUseV_none","LiftV2"] ---- can be other V's
  "PassAgentVPSlash" -> ["AgentPassUseV_none","LiftV2"] ---- can be other V's
  "SlashV2S" -> ["SlashV2S_none","UseV_np_s","LiftV2S"]
  "SlashV2Q" -> ["SlashV2Q_none","UseV_np_q","LiftV2Q"]
  "SlashV2A" -> ["SlashV2A_none","UseV_np_a","LiftV2A"]
  "SlashV2V" -> ["SlashV2V_none","UseV_np_v","LiftV2V","InfVP_none"]
  "SlashVV" -> ["ComplVV_np","UseV_v","LiftVV","InfVP_none"]
  "SlashVP" -> ["PredVP_np"]
  "SlashPrep" -> ["AdvCl_np","LiftPrep"]
  "SlashVS" -> [] ----
  "AdvSlash" -> [] ----
  "UseCl" -> []
  "UseQCl" -> []
  "UseSlash" -> []

  t -> [t]
