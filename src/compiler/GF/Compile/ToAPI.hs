module GF.Compile.ToAPI 
 (stringToAPI,exprToAPI)
  where

import PGF
import Data.Maybe
--import System.IO
--import Control.Monad
--import Data.Set as Set (fromList,toList)
import Data.List
--import Data.Map(Map)
import qualified Data.Map as Map


-- intermediate structure for representing the translated expression
data APIfunc = BasicFunc String | AppFunc String [APIfunc] | NoAPI  
  deriving (Show,Eq)




-- translates a GF expression/tree into an equivalent one which uses functions from the GF
-- API instead of the syntactic modules
exprToAPI :: Expr -> String
exprToAPI expr = 
    let ffs = exprToFunc expr 
       in printAPIfunc ffs




-- translates a GF expression/tree written as a string to its correspondent which uses API functions
-- the string is parsed into a GF expression/tree first
stringToAPI :: String -> String
stringToAPI expressionToRead = 
        case readExpr expressionToRead of
             Just ex -> exprToAPI ex                
             _       -> error "incorrect expression given as input "




-- function for translating an expression into APIFunc with type inference for  
-- the type of the expression
exprToFunc :: Expr -> APIfunc
exprToFunc expr = 
   case unApp expr of
      Just (cid,l) -> 
         case Map.lookup (showCId cid) syntaxFuncs of 
            Just sig -> mkAPI True (fst sig,expr)
            _        -> case l of 
                          [] -> BasicFunc (showCId cid) 
                          _  -> let es = map exprToFunc l 
                                   in  AppFunc (showCId cid) es
      _ -> BasicFunc (showExpr [] expr)

        
       
                             

-- main function for translating an expression along with its type into an APIFunc
-- the boolean controls the need to optimize the result
mkAPI :: Bool -> (String, Expr) -> APIfunc
mkAPI opt (ty,expr) = 
 if elem ty rephraseable then rephraseSentence ty expr 
  else if opt then if elem ty optimizable then optimize expr else computeAPI (ty,expr)
        else computeAPI (ty,expr) 
  where
     rephraseSentence ty expr = 
       case unApp expr of 
         Just (cid,es) -> if isPrefixOf "Use" (showCId cid) then 
                                                             let newCat = drop 3 (showCId cid)
                                                                 afClause = mkAPI True (newCat, es !! 2)
                                                                 afPol = mkAPI True ("Pol",es !! 1)                                         
                                                                 lTense = mkAPI True ("Temp", head es)                                        
                                                              in case lTense of 
                                                                  AppFunc _ [BasicFunc s1, BasicFunc s2] -> 
                                                                      let (r1,r2) = getTemporalParam s1 s2 in  
                                                                         AppFunc ("mk"++newCat) [r1,r2,afPol,afClause] 
                                                                  _ ->  error "erroneous tense"          
                           else (mkAPI False) (ty,expr)
         _             -> error $ "incorrect for for expression "++ showExpr [] expr
     
     getTemporalParam s1 s2 = 
                         let r1 = case s1 of 
                                     "TPres" -> NoAPI
                                     "TPast" -> BasicFunc "pastTense"
                                     "TFut"  -> BasicFunc "futureTense" 
                                     "TCond" -> BasicFunc "conditionalTense"
                             r2 = case s2 of
                                     "ASimul" -> NoAPI
                                     "AAnter" -> BasicFunc "anteriorAnt"
                              in (r1,r2) 



computeAPI :: (String,Expr) ->  APIfunc
computeAPI (ty,expr) =
   case (unApp expr) of 
     Just (cid,[]) ->  getSimpCat (showCId cid) ty
     Just (cid,es) -> 
        let p = specFunction (showCId cid) es  
          in if isJust p then fromJust p
              else case Map.lookup (show cid) syntaxFuncs of
                    Nothing -> exprToFunc expr    
                    Just (nameCat,typesExps) -> 
                      if elem nameCat hiddenCats && length es == 1 then  (mkAPI True) (head typesExps,head es)
                       else if elem nameCat hiddenCats then error $ "incorrect coercion "++nameCat++" - "++show es   
                              else let afs = map (mkAPI True) (zip typesExps es)
                                      in AppFunc ("mk" ++ nameCat) afs 
     _         -> error "error"          
  where 
    getSimpCat "IdRP" _     = BasicFunc "which_RP"
    getSimpCat "DefArt" _   = BasicFunc "the_Art"
    getSimpCat "IndefArt" _ = BasicFunc "a_Art"
    getSimpCat "NumSg" _    = NoAPI
    getSimpCat "NumPl" _    = BasicFunc "plNum"
    getSimpCat "PPos" _     = NoAPI
    getSimpCat "PNeg" _     = BasicFunc "negativePol"
    getSimpCat cid ty       = if elem ty ["PConj","Voc"] && isInfixOf "No" cid
                                 then NoAPI 
                                  else BasicFunc cid

    specFunction "PassV2" es     = rephraseUnary "passiveVP" "V2" es
    specFunction "ReflA2" es     = rephraseUnary "reflAP" "A2" es
    specFunction "UseComparA" es = rephraseUnary "comparAP" "A" es
    specFunction "TFullStop" es  = rephraseText "fullStopPunct" es
    specFunction "TExclMark" es  = rephraseText "exclMarkPunct" es
    specFunction "TQuestMark" es = rephraseText "questMarkPunct" es
    specFunction _ _             = Nothing

    rephraseUnary ss ty es = 
     let afs = mkAPI True (ty,head es) 
        in Just (AppFunc ss [afs])

    rephraseText ss es = 
     let afs = map (mkAPI True) (zip ["Phr","Text"] es) in
        if afs !! 1 == BasicFunc "TEmpty" then  Just (AppFunc "mkText" [head afs,BasicFunc ss])
           else Just (AppFunc "mkText" [head afs, BasicFunc ss, last afs])



-- optimizations for the translation of some categories
optimize expr = optimizeNP expr

optimizeNP expr = 
   case unApp expr of
     Just (cid,es) -> 
         if showCId cid == "MassNP" then let afs = nounAsCN (head es)
                                           in AppFunc "mkNP" [afs]
           else if showCId cid == "DetCN" then let quants = quantAsDet (head es)
                                                   ns     = nounAsCN (head $ tail es)
                                                  in AppFunc "mkNP" (quants ++ [ns])
                 else mkAPI False ("NP",expr)
     _             -> error $ "incorrect expression " ++ (showExpr [] expr)
    where 
     nounAsCN expr = 
      case unApp expr of 
       Just (cid,es) -> if showCId cid == "UseN" then (mkAPI False) ("N",head es)
           else (mkAPI False) ("CN",expr)
       _ -> error $ "incorrect expression "++ (showExpr [] expr)

     quantAsDet expr =
       case unApp expr of
        Just (cid,es) -> if showCId cid == "DetQuant" then map (mkAPI False) [("Quant", head es),("Num",head $ tail es)]
                           else [mkAPI False ("Det",expr)]
                                  
        _             -> error $ "incorrect expression "++ (showExpr [] expr)
        

     
-- categories not present in the API - rephrasing needed
hiddenCats :: [String]
hiddenCats = ["N2","V2","Comp","SC"]



-- categories for which optimization of the translation is provided at the moment
optimizable :: [String]
optimizable = ["NP"]



-- categories for which the compositional translation needs to be rephrased
rephraseable :: [String]
rephraseable = ["S","QS","RS"]



-- converts the intermediate structure APIFunc to plain string
printAPIfunc :: APIfunc -> String 
printAPIfunc (BasicFunc f) = f 
printAPIfunc NoAPI = ""
printAPIfunc (AppFunc f es) = unwords (f : map (\x -> printAPIArgfunc x ) es) 
 where 
   printAPIArgfunc (BasicFunc f) = f
   printAPIArgfunc NoAPI = ""
   printAPIArgfunc f = "(" ++ printAPIfunc f ++ ")" 






--------------------------------------------------------------------------------
{-
constFuncs :: Map.Map String (String,[String])
constFuncs = Map.fromList [("AAnter",("Ant",[])),("ASimul",("Ant",[])),("D_0",("Dig",[])),("D_1",("Dig",[])),("D_2",("Dig",[])),("D_3",("Dig",[])),("D_4",("Dig",[])),("D_5",("Dig",[])),("D_6",("Dig",[])),("D_7",("Dig",[])),("D_8",("Dig",[])),("D_9",("Dig",[])),("DefArt",("Quant",[])),("IdRP",("RP",[])),("IndefArt",("Quant",[])),("NoPConj",("PConj",[])),("NoVoc",("Voc",[])),("NumPl",("Num",[])),("NumSg",("Num",[])),("PNeg",("Pol",[])),("PPos",("Pol",[])),("TCond",("Tense",[])),("TEmpty",("Text",[])),("TFut",("Tense",[])),("TPast",("Tense",[])),("TPres",("Tense",[])),("UseCopula",("VP",[])),("above_Prep",("Prep",[])),("after_Prep",("Prep",[])),("alas_Interj",("Interj",[])),("all_Predet",("Predet",[])),("almost_AdA",("AdA",[])),("almost_AdN",("AdN",[])),("already_Adv",("Adv",[])),("although_Subj",("Subj",[])),("always_AdV",("AdV",[])),("and_Conj",("Conj",[])),("answer_V2S",("V2S",[])),("as_CAdv",("CAdv",[])),("ask_V2Q",("V2Q",[])),("at_least_AdN",("AdN",[])),("at_most_AdN",("AdN",[])),("because_Subj",("Subj",[])),("before_Prep",("Prep",[])),("beg_V2V",("V2V",[])),("behind_Prep",("Prep",[])),("between_Prep",("Prep",[])),("both7and_DConj",("Conj",[])),("but_PConj",("PConj",[])),("by8agent_Prep",("Prep",[])),("by8means_Prep",("Prep",[])),("during_Prep",("Prep",[])),("either7or_DConj",("Conj",[])),("every_Det",("Det",[])),("everybody_NP",("NP",[])),("everything_NP",("NP",[])),("everywhere_Adv",("Adv",[])),("except_Prep",("Prep",[])),("far_Adv",("Adv",[])),("few_Det",("Det",[])),("for_Prep",("Prep",[])),("from_Prep",("Prep",[])),("he_Pron",("Pron",[])),("here7from_Adv",("Adv",[])),("here7to_Adv",("Adv",[])),("here_Adv",("Adv",[])),("how8many_IDet",("IDet",[])),("how8much_IAdv",("IAdv",[])),("how_IAdv",("IAdv",[])),("i_Pron",("Pron",[])),("if_Subj",("Subj",[])),("if_then_Conj",("Conj",[])),("in8front_Prep",("Prep",[])),("in_Prep",("Prep",[])),("it_Pron",("Pron",[])),("language_title_Utt",("Utt",[])),("left_Ord",("Ord",[])),("less_CAdv",("CAdv",[])),("many_Det",("Det",[])),("more_CAdv",("CAdv",[])),("most_Predet",("Predet",[])),("much_Det",("Det",[])),("n2",("Digit",[])),("n3",("Digit",[])),("n4",("Digit",[])),("n5",("Digit",[])),("n6",("Digit",[])),("n7",("Digit",[])),("n8",("Digit",[])),("n9",("Digit",[])),("no_Quant",("Quant",[])),("no_Utt",("Utt",[])),("nobody_NP",("NP",[])),("not_Predet",("Predet",[])),("nothing_NP",("NP",[])),("now_Adv",("Adv",[])),("on_Prep",("Prep",[])),("only_Predet",("Predet",[])),("or_Conj",("Conj",[])),("otherwise_PConj",("PConj",[])),("paint_V2A",("V2A",[])),("part_Prep",("Prep",[])),("please_Voc",("Voc",[])),("possess_Prep",("Prep",[])),("pot01",("Sub10",[])),("pot110",("Sub100",[])),("pot111",("Sub100",[])),("quite_Adv",("AdA",[])),("right_Ord",("Ord",[])),("she_Pron",("Pron",[])),("so_AdA",("AdA",[])),("somePl_Det",("Det",[])),("someSg_Det",("Det",[])),("somebody_NP",("NP",[])),("something_NP",("NP",[])),("somewhere_Adv",("Adv",[])),("that_Quant",("Quant",[])),("that_Subj",("Subj",[])),("there7from_Adv",("Adv",[])),("there7to_Adv",("Adv",[])),("there_Adv",("Adv",[])),("therefore_PConj",("PConj",[])),("they_Pron",("Pron",[])),("this_Quant",("Quant",[])),("through_Prep",("Prep",[])),("to_Prep",("Prep",[])),("today_Adv",("Adv",[])),("too_AdA",("AdA",[])),("under_Prep",("Prep",[])),("very_AdA",("AdA",[])),("we_Pron",("Pron",[])),("whatPl_IP",("IP",[])),("whatSg_IP",("IP",[])),("when_IAdv",("IAdv",[])),("when_Subj",("Subj",[])),("where_IAdv",("IAdv",[])),("which_IQuant",("IQuant",[])),("whoPl_IP",("IP",[])),("whoSg_IP",("IP",[])),("why_IAdv",("IAdv",[])),("with_Prep",("Prep",[])),("without_Prep",("Prep",[])),("yes_Utt",("Utt",[])),("youPl_Pron",("Pron",[])),("youPol_Pron",("Pron",[])),("youSg_Pron",("Pron",[]))]
-}


syntaxFuncs :: Map.Map String (String,[String])
syntaxFuncs = Map.fromList [("AdAP",("AP",["AdA","AP"])),("AdAdv",("Adv",["AdA","Adv"])),("AdNum",("Card",["AdN","Card"])),("AdVVP",("VP",["AdV","VP"])),("AddAdvQVP",("QVP",["QVP","IAdv"])),("AdjCN",("CN",["AP","CN"])),("AdjOrd",("AP",["Ord"])),("AdnCAdv",("AdN",["CAdv"])),("AdvAP",("AP",["AP","Adv"])),("AdvCN",("CN",["CN","Adv"])),("AdvIAdv",("IAdv",["IAdv","Adv"])),("AdvIP",("IP",["IP","Adv"])),("AdvNP",("NP",["NP","Adv"])),("AdvQVP",("QVP",["VP","IAdv"])),("AdvS",("S",["Adv","S"])),("AdvSlash",("ClSlash",["ClSlash","Adv"])),("AdvVP",("VP",["VP","Adv"])),("ApposCN",("CN",["CN","NP"])),("BaseAP",("ListAP",["AP","AP"])),("BaseAdv",("ListAdv",["Adv","Adv"])),("BaseCN",("ListCN",["CN","CN"])),("BaseIAdv",("ListIAdv",["IAdv","IAdv"])),("BaseNP",("ListNP",["NP","NP"])),("BaseRS",("ListRS",["RS","RS"])),("BaseS",("ListS",["S","S"])),("CAdvAP",("AP",["CAdv","AP","NP"])),("CleftAdv",("Cl",["Adv","S"])),("CleftNP",("Cl",["NP","RS"])),("CompAP",("Comp",["AP"])),("CompAdv",("Comp",["Adv"])),("CompCN",("Comp",["CN"])),("CompIAdv",("IComp",["IAdv"])),("CompIP",("IComp",["IP"])),("CompNP",("Comp",["NP"])),("ComparA",("AP",["A","NP"])),("ComparAdvAdj",("Adv",["CAdv","A","NP"])),("ComparAdvAdjS",("Adv",["CAdv","A","S"])),("ComplA2",("AP",["A2","NP"])),("ComplN2",("CN",["N2","NP"])),("ComplN3",("N2",["N3","NP"])),("ComplSlash",("VP",["VPSlash","NP"])),("ComplSlashIP",("QVP",["VPSlash","IP"])),("ComplVA",("VP",["VA","AP"])),("ComplVQ",("VP",["VQ","QS"])),("ComplVS",("VP",["VS","S"])),("ComplVV",("VP",["VV","VP"])),("ConjAP",("AP",["Conj","ListAP"])),("ConjAdv",("Adv",["Conj","ListAdv"])),("ConjCN",("CN",["Conj","ListCN"])),("ConjIAdv",("IAdv",["Conj","ListIAdv"])),("ConjNP",("NP",["Conj","ListNP"])),("ConjRS",("RS",["Conj","ListRS"])),("ConjS",("S",["Conj","ListS"])),("ConsAP",("ListAP",["AP","ListAP"])),("ConsAdv",("ListAdv",["Adv","ListAdv"])),("ConsCN",("ListCN",["CN","ListCN"])),("ConsIAdv",("ListIAdv",["IAdv","ListIAdv"])),("ConsNP",("ListNP",["NP","ListNP"])),("ConsRS",("ListRS",["RS","ListRS"])),("ConsS",("ListS",["S","ListS"])),("DetCN",("NP",["Det","CN"])),("DetNP",("NP",["Det"])),("DetQuant",("Det",["Quant","Num"])),("DetQuantOrd",("Det",["Quant","Num","Ord"])),("EmbedQS",("SC",["QS"])),("EmbedS",("SC",["S"])),("EmbedVP",("SC",["VP"])),("ExistIP",("QCl",["IP"])),("ExistNP",("Cl",["NP"])),("FunRP",("RP",["Prep","NP","RP"])),("GenericCl",("Cl",["VP"])),("IDig",("Digits",["Dig"])),("IIDig",("Digits",["Dig","Digits"])),("IdetCN",("IP",["IDet","CN"])),("IdetIP",("IP",["IDet"])),("IdetQuant",("IDet",["IQuant","Num"])),("ImpP3",("Utt",["NP","VP"])),("ImpPl1",("Utt",["VP"])),("ImpVP",("Imp",["VP"])),("ImpersCl",("Cl",["VP"])),("MassNP",("NP",["CN"])),("NumCard",("Num",["Card"])),("NumDigits",("Card",["Digits"])),("NumNumeral",("Card",["Numeral"])),("OrdDigits",("Ord",["Digits"])),("OrdNumeral",("Ord",["Numeral"])),("OrdSuperl",("Ord",["A"])),("PConjConj",("PConj",["Conj"])),("PPartNP",("NP",["NP","V2"])),("PassV2",("VP",["V2"])),("PhrUtt",("Phr",["PConj","Utt","Voc"])),("PositA",("AP",["A"])),("PositAdAAdj",("AdA",["A"])),("PositAdvAdj",("Adv",["A"])),("PossPron",("Quant",["Pron"])),("PredSCVP",("Cl",["SC","VP"])),("PredVP",("Cl",["NP","VP"])),("PredetNP",("NP",["Predet","NP"])),("PrepIP",("IAdv",["Prep","IP"])),("PrepNP",("Adv",["Prep","NP"])),("ProgrVP",("VP",["VP"])),("QuestCl",("QCl",["Cl"])),("QuestIAdv",("QCl",["IAdv","Cl"])),("QuestIComp",("QCl",["IComp","NP"])),("QuestQVP",("QCl",["IP","QVP"])),("QuestSlash",("QCl",["IP","ClSlash"])),("QuestVP",("QCl",["IP","VP"])),("ReflA2",("AP",["A2"])),("ReflVP",("VP",["VPSlash"])),("RelCN",("CN",["CN","RS"])),("RelCl",("RCl",["Cl"])),("RelNP",("NP",["NP","RS"])),("RelS",("S",["S","RS"])),("RelSlash",("RCl",["RP","ClSlash"])),("RelVP",("RCl",["RP","VP"])),("SSubjS",("S",["S","Subj","S"])),("SentAP",("AP",["AP","SC"])),("SentCN",("CN",["CN","SC"])),("Slash2V3",("VPSlash",["V3","NP"])),("Slash3V3",("VPSlash",["V3","NP"])),("SlashPrep",("ClSlash",["Cl","Prep"])),("SlashV2A",("VPSlash",["V2A","AP"])),("SlashV2Q",("VPSlash",["V2Q","QS"])),("SlashV2S",("VPSlash",["V2S","S"])),("SlashV2V",("VPSlash",["V2V","VP"])),("SlashV2VNP",("VPSlash",["V2V","NP","VPSlash"])),("SlashV2a",("VPSlash",["V2"])),("SlashVP",("ClSlash",["NP","VPSlash"])),("SlashVS",("ClSlash",["NP","VS","SSlash"])),("SlashVV",("VPSlash",["VV","VPSlash"])),("SubjS",("Adv",["Subj","S"])),("TExclMark",("Text",["Phr","Text"])),("TFullStop",("Text",["Phr","Text"])),("TQuestMark",("Text",["Phr","Text"])),("TTAnt",("Temp",["Tense","Ant"])),("Use2N3",("N2",["N3"])),("Use3N3",("N2",["N3"])),("UseA2",("AP",["A2"])),("UseCl",("S",["Temp","Pol","Cl"])),("UseComp",("VP",["Comp"])),("UseComparA",("AP",["A"])),("UseN",("CN",["N"])),("UseN2",("CN",["N2"])),("UsePN",("NP",["PN"])),("UsePron",("NP",["Pron"])),("UseQCl",("QS",["Temp","Pol","QCl"])),("UseRCl",("RS",["Temp","Pol","RCl"])),("UseSlash",("SSlash",["Temp","Pol","ClSlash"])),("UseV",("VP",["V"])),("UttAP",("Utt",["AP"])),("UttAdv",("Utt",["Adv"])),("UttCN",("Utt",["CN"])),("UttCard",("Utt",["Card"])),("UttIAdv",("Utt",["IAdv"])),("UttIP",("Utt",["IP"])),("UttImpPl",("Utt",["Pol","Imp"])),("UttImpPol",("Utt",["Pol","Imp"])),("UttImpSg",("Utt",["Pol","Imp"])),("UttInterj",("Utt",["Interj"])),("UttNP",("Utt",["NP"])),("UttQS",("Utt",["QS"])),("UttS",("Utt",["S"])),("UttVP",("Utt",["VP"])),("VocNP",("Voc",["NP"])),("dconcat",("Digits",["Digits","Digits"])),("digits2num",("Numeral",["Digits"])),("dn",("Digit",["Dig"])),("dn10",("Sub10",["Dig"])),("dn100",("Sub100",["Dig","Dig"])),("dn1000",("Sub1000",["Dig","Dig","Dig"])),("dn1000000a",("Sub1000000",["Dig","Dig","Dig","Dig"])),("dn1000000b",("Sub1000000",["Dig","Dig","Dig","Dig","Dig"])),("dn1000000c",("Sub1000000",["Dig","Dig","Dig","Dig","Dig","Dig"])),("nd",("Dig",["Digit"])),("nd10",("Digits",["Sub10"])),("nd100",("Digits",["Sub100"])),("nd1000",("Digits",["Sub1000"])),("nd1000000",("Digits",["Sub1000000"])),("num",("Numeral",["Sub1000000"])),("num2digits",("Digits",["Numeral"])),("pot0",("Sub10",["Digit"])),("pot0as1",("Sub100",["Sub10"])),("pot1",("Sub100",["Digit"])),("pot1as2",("Sub1000",["Sub100"])),("pot1plus",("Sub100",["Digit","Sub10"])),("pot1to19",("Sub100",["Digit"])),("pot2",("Sub1000",["Sub10"])),("pot2as3",("Sub1000000",["Sub1000"])),("pot2plus",("Sub1000",["Sub10","Sub100"])),("pot3",("Sub1000000",["Sub1000"])),("pot3plus",("Sub1000000",["Sub1000","Sub1000"]))]
