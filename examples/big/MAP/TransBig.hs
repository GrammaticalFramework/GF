module TransBig where

import AbsLisp
import PrintLisp

import Char

abstrgf = "BigLexEngAbs.gf"
concrgf = "BigLexEng.gf"

transTree :: Prog -> IO ()
transTree (Pro ts) = do
  writeFile abstrgf "abstract BigLexEngAbs = Cat **{\n"
  writeFile concrgf 
    "concrete BigLexEng of BigLexEngAbs = CatEng ** open ParadigmsEng, IrregEng in {\n"
  mapM_ transRule ts
  appendFile abstrgf "}\n"
  addOpers
  appendFile concrgf "}\n"

transRule :: Exp -> IO ()
transRule e = case e of
  App (At f : _ : cat : _) | not (discardCat cat) -> catRule (hyph f) cat
  _ -> notConsidered $ "--! " ++ printTree e
 where
  hyph (Id f) = Id (map unhyph f)
  unhyph '-' = '_'
  unhyph c = c

discardCat (App cs) = any (flip elem cs) discarded where
  discarded = [
    App [At (Id "AUX"),Plus],
    App [At (Id "PAST"),Plus],
    App [At (Id "QUA"),Plus],
    App [At (Id "VFORM"),At (Id "EN")],
    App [At (Id "AFORM"),At (Id "ER")],
    App [At (Id "AFORM"),At (Id "EST")]
    ]
discardCat _ = False


catRule :: Id -> Exp -> IO ()
catRule (Id f) e = case cleanCat e of
  App (App [At (Id "V"), Minus] : App [At (Id "N"), Plus] : more) -> case more of 
    [App [At (Id "SUBCAT"),sub]] -> 
      let prep = prepSub sub in
      putRule (f ++ "_N2" ++ prep) "N2" "prepN2" [show f, show prep]
    [App [At (Id "PLU"),Minus],App [At (Id "SUBCAT"),sub]] -> 
      let prep = prepSub sub in
      putRule (f ++ "_N2" ++ prep) "N2" "irregN2" [show f, show f, show prep]
    [App [At (Id "PLU"),Minus]] -> 
      putRule (f ++ "_N") "N" "irregN" [show f, show f] --- could find the forms
    [App [At (Id "PLU"),_]] -> 
      notConsidered $ "--! " ++ f ++ " " ++ printTree e
    (App [At (Id "PRO"),Plus]:_) -> 
      notConsidered $ "--! " ++ f ++ " " ++ printTree e
    [App [At (Id "COUNT"),Minus]] -> 
      putRule (f ++ "_N") "N" "massN" [show f]
    [App [At (Id "PN"),Plus]] -> 
      putRule (f ++ "_PN") "PN" "regPN" [show f]
    [] ->
      putRule (f ++ "_N") "N" "regN" [show f]
    _ -> putStrLn $ "---- " ++ f ++ " " ++ printTree e
  App (App [At (Id "V"), Plus] : App [At (Id "N"), Plus] : more) -> case more of 
    (App [At (Id "ADV"), Plus]:_) -> 
      putRule (f ++ "_Adv") "Adv" "mkAdv" [show f]
    [App [At (Id "SUBCAT"),sub]] -> 
      let prep = prepSub sub in
      putRule (f ++ "_A2" ++ prep) "A2" "regA2" [show f,show prep]
    [App [At (Id "AFORM"),At (Id "NONE")],App [At (Id "SUBCAT"),sub]] -> 
      let prep = prepSub sub in
      putRule (f ++ "_A2" ++ prep) "A2" "longA2" [show f,show prep]
    [App [At (Id "SUBCAT"),sub],App [At (Id "AFORM"),At (Id "NONE")]] -> 
      let prep = prepSub sub in
      putRule (f ++ "_A2" ++ prep) "A2" "longA2" [show f,show prep]
    (App [At (Id "AFORM"),At (Id "NONE")]:_) -> 
      putRule (f ++ "_A") "A" "longA" [show f]
    [] ->
      putRule (f ++ "_A") "A" "regA" [show f]
    _ -> putStrLn $ "---- " ++ f ++ " " ++ printTree e
  App (App [At (Id "V"), Plus] : App [At (Id "N"), Minus] : more) -> case more of 
    App [At (Id "SUBCAT"),At (Id "NP_NP")]:form -> 
      putRule (f ++ "_V3") "V3" "dirdirV3" [verbForm form f]
    App [At (Id "SUBCAT"),At (Id ('N':'P':'_':sub))]:form -> 
      let prep = map toLower (drop 2 sub) in
      putRule (f ++ "_V3" ++ prep) "V3" "dirprepV3" [verbForm form f, show prep]
    App [At (Id "SUBCAT"),At (Id "SFIN")]:form -> 
      putRule (f ++ "_VS") "VS" "mkVS" [verbForm form f]
    App [At (Id "SUBCAT"),At (Id "SE1")]:form -> 
      putRule (f ++ "_VV") "VV" "mkVV" [verbForm form f]
    App [At (Id "SUBCAT"),sub]:form -> 
      let prep = prepSub sub in
      putRule (f ++ "_V2" ++ prep) "V2" "prepV2" [verbForm form f, show prep]
    form | length form < 2 ->
      putRule (f ++ "_V") "V" "useV" [verbForm form f]
    _ -> putStrLn $ "---- " ++ f ++ " " ++ printTree e
  App (App [At (Id "V"), Minus] : App [At (Id "N"), Minus] : more) -> case more of 
    [App [At (Id "SUBCAT"), At (Id "BARE_S")]] -> 
      putRule (f ++ "_Subj") "Subj" "mkSubj" [show f]
    [App [At (Id "SUBCAT"), At (Id "NP")]] -> 
      putRule (f ++ "_Prep") "Prep" "mkPrep" [show f]
    App [At (Id "PRO"), Plus] : _ ->
      putRule (f ++ "_Adv") "Adv" "proAdv" [show f]
    _ -> putStrLn $ "---- " ++ f ++ " " ++ printTree e
  App (App [At (Id "PRO"), Plus] : 
    App [At (Id "V"), Minus] : App [At (Id "N"), Minus] :_) ->
      putRule (f ++ "_Adv") "Adv" "proAdv" [show f]
  _ -> notConsidered $ "--! " ++ f ++ " " ++ printTree e

cleanCat (App es) = App $ filter (not . irrelevant) es where
  irrelevant c = elem c [
    App [At (Id "SUBCAT"), At (Id "NULL")],
    App [At (Id "AT"), Minus], --- ?
    App [At (Id "LAT"), Minus],
    App [At (Id "LAT"), Plus]
    ]
cleanCat c = c

notConsidered r = return () --- putStrLn

putRule :: String -> String -> String -> [String] -> IO ()
putRule fun cat oper args = do
  appendFile abstrgf $ unwords ["fun",fun,":",cat,";\n"]
  appendFile concrgf $ unwords $ ["lin",fun,"=",oper] ++ args ++ [";\n"]

prepSub :: Exp -> String
prepSub s = case s of
  At (Id ('P':'P':cs)) -> map toLower cs
  _ -> ""

verbForm form f
   | elem (App [At (Id "REG"),Minus]) form = "IrregEng." ++ f ++ "_V"
   | otherwise = "(regV " ++ show f ++ ")"

addOpers = mapM_ (appendFile concrgf) [
  "oper proAdv : Str -> Adv = \\s -> mkAdv s ;\n",
  "oper useV : V -> V = \\v -> v ;\n",
  "oper massN : Str -> N = \\s -> regN s ;\n",
  "longA : Str -> A = \\s -> compoundADeg (regA s) ;\n",
  "mkSubj : Str -> Subj = \\s -> {s = s ; lock_Subj = <>} ;\n",
  "irregN : Str -> Str -> N = \x,y -> mk2N x y ;\",
  "irregN2 : Str -> Str -> Str -> N2 = \x,y,p -> mkN2 (irregN x y) (mkPrep p) ;\n",
  "longA2 : Str -> Str -> A2 = \s,p -> mkA2 (compoundADeg (regA s)) (mkPrep p) ;\n",
  "regA2 : Str -> Str -> A2 = \s,p -> mkA2 (regA s) (mkPrep p) ;\n",
  "prepV2 : V -> Str -> V2 = \s,p -> mkV2 s (mkPrep p) ;\n",
  "prepN2 : Str -> Str -> N2 = \s,p -> mkN2 (regN s) (mkPrep p) ;\n",
  "dirprepV3 : V -> Str -> V3 = \s,p -> dirV3 s (mkPrep p) ;\n"
  ]
