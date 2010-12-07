module GF.Compile.ToAPI 
 (stringToAPI,exprToAPI)
  where

import PGF.Expr
import PGF.CId
import Data.Maybe
import System.IO
import Control.Monad
import Data.Set as Set (fromList,toList)
import Data.List
import Data.Map(Map)
import qualified Data.Map as Map
import PGF.Signature


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






