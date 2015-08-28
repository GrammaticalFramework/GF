module ExampleDemo (Environ,initial,getNext, provideExample, testThis,mkFuncWithArg,searchGoodTree,isMeta)
  where

import PGF
--import System.IO
import Data.List
--import Control.Monad
import qualified Data.Map as Map
--import qualified Data.IntMap as IntMap
import qualified Data.Set as Set
import Data.Maybe
--import System.Environment (getArgs)
import System.Random (RandomGen) --newStdGen


type MyType = CId                                -- name of the categories from the program
type ConcType = CId                              -- categories from the resource grammar, that we parse on
type MyFunc = CId                                -- functions that we need to implement
--type FuncWithArg = ((MyFunc, MyType), Expr)    -- function with arguments  
type InterInstr = [String]                       -- lincats that were generated but not written to the file



data FuncWithArg = FuncWithArg 
                      {getName :: MyFunc,        -- name of the function to generate
                       getType :: MyType,        -- return type of the function
                       getTypeArgs :: [MyType]  -- types of arguments 
                       }
       deriving (Show,Eq,Ord)

-- we assume that it's for English for the moment


type TypeMap = Map.Map MyType ConcType           -- mapping found from a file

type ConcMap = Map.Map MyFunc Expr               -- concrete expression after parsing

data Environ = Env {getTypeMap :: TypeMap,                  -- mapping between a category in the grammar and a concrete type from RGL
                    getConcMap :: ConcMap,                  -- concrete expression after parsing          
                    getSigs :: Map.Map MyType [FuncWithArg], -- functions for which we have the concrete syntax already with args 
                    getAll :: [FuncWithArg]           -- all the functions with arguments  
                    }


getNext :: Environ -> Environ -> ([MyFunc],[MyFunc])
getNext env example_env = 
  let sgs = getSigs env
      allfuncs  = getAll env
      names = Set.fromList $ map getName $ concat $ Map.elems sgs
      exampleable = filter (\x -> (isJust $ getNameExpr x env) 
                               &&
                               (not $ Set.member x names) -- maybe drop this if you want to also rewrite from examples...
                            ) $ map getName allfuncs
      testeable = filter (\x -> (isJust $ getNameExpr x env ) 
                              && 
                               (Set.member x names)
                          ) $ map getName allfuncs    

     in (exampleable,testeable)


provideExample :: RandomGen gen => gen -> Environ -> MyFunc -> PGF -> PGF -> Language -> Maybe (Expr,String)
provideExample gen env myfunc parsePGF pgfFile lang = 
      fmap giveExample $ getNameExpr myfunc env
 where 
   giveExample e_ = 
     let newexpr = head $ generateRandomFromDepth gen pgfFile e_ (Just 5) -- change here with the new random generator
         ty = getType $ head $ filter (\x -> getName x == myfunc) $ getAll env
         embeddedExpr = maybe "" (\x -> ", as in: " ++ q (linearize pgfFile lang x)) (embedInStart (getAll env) (Map.fromList [(ty,e_)]))
         lexpr = linearize pgfFile lang newexpr  
         q s = sq++s++sq
         sq = "\""
       in (newexpr,q lexpr ++ embeddedExpr)
-- question, you need the IO monad for the random generator, how to do otherwise ??
-- question can you make the expression bold/italic - somehow distinguishable from the rest ?



testThis :: Environ -> MyFunc -> PGF -> Language -> Maybe String  
testThis env myfunc parsePGF lang = 
    fmap (linearize parsePGF lang . mapToResource env . llin env) $
    getNameExpr myfunc env  


-- we assume that even the functions linearized by the user will still be in getSigs along with their linearization 


-- fill in the blancs of an expression that we want to linearize for testing purposes
---------------------------------------------------------------------------

llin :: Environ -> Expr -> Expr 
llin env expr = 
     let 
         (id,args) = fromJust $ unApp expr
       --cexpr = fromJust $ Map.lookup id (getConcMap env)
     in 
         if any isMeta args 
              then let 
                       sigs = concat $ Map.elems $ getSigs env
                       tys = findExprWhich sigs id
                    in  replaceConcArg 1 tys expr env 
           else mkApp id $ map (llin env) args


-- argument of the meta variable to replace, list of arguments left, expression to replace, environment, current replace expression 
replaceConcArg :: Int -> [MyType] -> Expr -> Environ -> Expr
replaceConcArg i [] expr env = expr
replaceConcArg i (t:ts) expr env =      -- TO DO : insert randomness here !!
   let ss = fromJust $ Map.lookup t $ getSigs env 
       args = filter (null . getTypeArgs) ss 
       finArg = if null args then let l = last ss in llin env (mkApp (getName l) [mkMeta j | j <- [1..(length $ getTypeArgs l)]]) 
                   else mkApp (getName $ last args) [] 
    in   
                     let newe = replaceOne i finArg expr
                               in replaceConcArg (i+1) ts newe env       
                   
-- replace a certain metavariable with a certain expression in another expression - return updated expression
replaceOne :: Int -> Expr -> Expr -> Expr                               
replaceOne i erep expr = 
      if isMeta expr && ((fromJust $ unMeta expr) == i) 
               then erep
        else if isMeta expr then expr
              else let (id,args) = fromJust $ unApp expr
                       in  
                        mkApp id $ map (replaceOne i erep) args


findExprWhich :: [FuncWithArg] -> MyFunc -> [MyType]
findExprWhich lst f = getTypeArgs $ head $ filter (\x -> getName x == f) lst 


mapToResource :: Environ -> Expr -> Expr 
mapToResource env expr = 
      let (id,args) =  maybe (error $ "tried to unwrap " ++ showExpr [] expr) (\x -> x) (unApp expr)
          cmap      = getConcMap env
          cexp      = maybe (error $ "didn't find " ++ showCId id ++ " in  "++ show cmap) (\x -> x)  (Map.lookup id cmap)
        in 
        if null args then cexp
             else let newargs = map (mapToResource env) args
                   in replaceAllArgs cexp 1 newargs
      where 
      replaceAllArgs expr i []     = expr 
      replaceAllArgs expr i (x:xs) = replaceAllArgs (replaceOne i x expr) (i+1) xs 
   
         

-----------------------------------------------

-- embed expression in another one from the start category

embedInStart :: [FuncWithArg] -> Map.Map MyType Expr -> Maybe Expr 
embedInStart fss cs =
  let currset = Map.toList cs 
      nextset = Map.fromList $ concat [ if elem myt (getTypeArgs farg) 
                     then connectWithArg (myt,exp) farg else [] 
                        | (myt,exp) <- currset, farg <- fss]
      nextmap = Map.union cs nextset
      maybeExpr = Map.lookup startCateg nextset
     in if isNothing maybeExpr then 
               if Map.size nextmap == Map.size cs then Nothing --error $ "could't build " ++ show startCateg ++ "with " ++ show fss 
                  else embedInStart fss nextmap
       else return $ fromJust maybeExpr
   where 
      connectWithArg (myt,exp) farg = 
             let ind = head $ elemIndices myt (getTypeArgs farg)
              in [(getType farg, mkApp (getName farg) $ [mkMeta i | i <- [1..ind]] ++ [exp] ++ [mkMeta i | i <- [(ind + 1)..((length $ getTypeArgs farg) - 1)]])]
               




-----------------------------------------------
{-
updateConcMap :: Environ -> MyFunc -> Expr -> Environ
updateConcMap env myf expr = 
     Env (getTypeMap env) (Map.insert myf expr (getConcMap env)) (getSigs env) (getAll env)

 
updateInterInstr :: Environ -> MyType -> FuncWithArg -> Environ
updateInterInstr env myt myf  = 
  let  ii = getSigs env
       newInterInstr = 
         maybe (Map.insert myt [myf] ii) (\x -> Map.insert myt (myf:x) ii) $ Map.lookup myt ii
      in Env (getTypeMap env) (getConcMap env) newInterInstr (getAll env)


putSignatures :: Environ -> [FuncWithArg] -> Environ
putSignatures env fss = 
     Env (getTypeMap env) (getConcMap env) (mkSigs fss) (getAll env)
      
      
updateEnv :: Environ -> FuncWithArg -> MyType -> Expr -> Environ 
updateEnv env myf myt expr =  
  let  ii = getSigs env
       nn = getName myf
       newInterInstr = 
         maybe (Map.insert myt [myf] ii) (\x -> Map.insert myt (myf:x) ii) $ Map.lookup myt ii
      in Env (getTypeMap env) (Map.insert nn expr (getConcMap env)) newInterInstr (getAll env)
-}

mkSigs :: [FuncWithArg] -> Map.Map MyType [FuncWithArg]
mkSigs fss = Map.fromListWith (++) $ zip (map getType fss) (map (\x -> [x]) fss)



{------------------------------------
lang :: String 
lang = "Eng"


parseLang :: Language
parseLang = fromJust $ readLanguage "ParseEng"


parsePGFfile :: String
parsePGFfile = "ParseEngAbs.pgf"
------------------------------------}




                 
searchGoodTree :: Environ -> Expr -> [Expr] -> IO (Maybe (Expr,Expr))
searchGoodTree env expr [] = return Nothing
searchGoodTree env expr (e:es) = 
     do val <- debugReplaceArgs expr e env
        maybe (searchGoodTree env expr es) (\x -> return $ Just (x,e)) val 



getNameExpr :: MyFunc -> Environ -> Maybe Expr
getNameExpr myfunc env = 
    let allfunc = filter (\x -> getName x == myfunc) $ getAll env
            in 
        if null allfunc then Nothing
            else getExpr (head allfunc) env

-- find an expression to generate where we have all the other elements available
getExpr :: FuncWithArg -> Environ -> Maybe Expr 
getExpr farg env =  
  let tys = getTypeArgs farg
      ctx = getSigs env 
      lst = getConcTypes ctx tys 1
    in if (all isJust lst) then  Just $ mkApp (getName farg) (map fromJust lst)
            else  Nothing    
     where getConcTypes context [] i = []
           getConcTypes context (ty:types) i =  
                let pos = Map.lookup ty context
                   in 
                    if isNothing pos  || (null $ fromJust pos) then [Nothing]                                                
                          else  
                             let mm = last $ fromJust pos
                                 mmargs = getTypeArgs mm
                                 newi = i + length mmargs - 1  
                                 lst = getConcTypes (Map.insert ty (init $ (fromJust pos)) context) types (newi+1)
                                  in                      
                                  if (all isJust lst) then                     -- i..newi
                                         (Just $ mkApp (getName mm) [mkMeta j | j <- [1..(length mmargs)]]) : lst 
                                       else  [Nothing]
      




-- only covers simple expressions with meta variables, not the rest...
isGeneralizationOf :: Expr -> Expr -> Bool
isGeneralizationOf genExpr testExpr = 
  if isMeta genExpr then True
   else if isMeta testExpr then False
    else let genUnwrap = unApp genExpr 
             testUnwrap = unApp testExpr
       in if isNothing genUnwrap || isNothing testUnwrap then False -- see if you can generalize here
           else let (gencid, genargs) = fromJust genUnwrap 
                    (testcid, testargs) = fromJust testUnwrap
                in 
                   (gencid == testcid) && (length genargs == length testargs)       
                       && (and [isGeneralizationOf g t | (g,t) <- (zip genargs testargs)])

{-do lst <- getConcTypes context types (i+1)
     return $ mkMeta i : lst -} 

debugReplaceArgs :: Expr -> Expr -> Environ -> IO (Maybe Expr)
debugReplaceArgs aexpr cexpr env = 
  if isNothing $ unApp aexpr then return Nothing
       else if any isNothing $ map unApp $ snd $ fromJust $ unApp aexpr then return Nothing
     else
       let args = map (fst.fromJust.unApp) $ snd $ fromJust $ unApp aexpr
           concExprs = map (\x -> fromJust $ Map.lookup x $ getConcMap env) args
         in startReplace 1 cexpr concExprs
        where 
          startReplace i cex []        = return $ Just cex
          startReplace i cex (a:as)    = do val <- debugReplaceConc cex i a
                                            maybe ( --do putStrLn $ "didn't find "++ showExpr [] a ++ " in " ++showExpr [] cexpr
                                                       return Nothing) 
                                                  (\x -> --do putStrLn $ "found it, the current expression is "++ showExpr [] x
                                                            startReplace (i+1) x as) 
                                                     val 
                      
debugReplaceConc :: Expr -> Int -> Expr -> IO (Maybe Expr)
debugReplaceConc expr i e = 
       let (newe,isThere) = searchArg expr 
          in if isThere then return $ Just newe else return $ Nothing 
     where   
      searchArg e_  =  
            if isGeneralizationOf e e_ then (mkMeta i, True)
              else maybe (e_,False) (\(cid,args) -> let repargs = map searchArg args
                                         in (mkApp cid (map  fst repargs), or $ map snd repargs)) $ unApp e_  
 

{-
-- replaceArgs : Original expression to parse (from abstract syntax) -> Concrete expression (parsed) 
replaceArgs :: Expr -> Expr -> Environ -> Maybe Expr
replaceArgs aexpr cexpr env =
  if isNothing $ unApp aexpr then error $ "could't unwrap this "++ show aexpr 
      else if any isNothing $ map unApp $ snd $ fromJust $ unApp aexpr then error $ "couldn't unwrap more this : "++ show aexpr
  else 
   let  args = map (fst.fromJust.unApp) $ snd $ fromJust $ unApp aexpr
        concExprs = map (\x -> fromJust $ Map.lookup x $ getConcMap env) args
          in startReplace 1 cexpr concExprs
    where 
      startReplace i cex []       = return cex 
      startReplace i cex (a:as)   = maybe Nothing (\x -> startReplace (i+1) x as) $ replaceConc cex i a



replaceConc :: Expr -> Int -> Expr -> Maybe Expr
replaceConc expr i e = 
       let (newe,isThere) = searchArg expr 
          in if isThere then return newe else Nothing 
     where   
      searchArg e_  =  
            if isGeneralizationOf e e_ then (mkMeta i, True)
              else maybe (e_,False) (\(cid,args) -> let repargs = map searchArg args
                                         in (mkApp cid (map  fst repargs), or $ map snd repargs)) $ unApp e_  



writeResults :: Environ -> String -> IO ()
writeResults env fileName = 
   let cmap = getConcMap env
       lincats = unlines $ map (\(x,y) -> "lincat " ++ showCId x ++ " = " ++ showCId y ++ " ; " ) $ Map.toList $ getTypeMap env 
       sigs = unlines $ map 
                  (\x -> let n = getName x 
                             no = length $ getTypeArgs x
                             oargs = unwords $ ("lin " ++ showCId n) : ["o"++show i | i <- [1..no]]     
                         in (oargs ++ " = " ++ (simpleReplace $ showExpr [] $ fromJust $ Map.lookup n cmap) ++ " ; ")) $ concat $ Map.elems $ getSigs env
    in 
          writeFile fileName ("\n" ++ lincats ++ "\n\n" ++  sigs)  
         

simpleReplace :: String -> String 
simpleReplace [] = []
simpleReplace ('?':xs) = 'o' : simpleReplace xs
simpleReplace (x:xs) = x : simpleReplace xs
-}

isMeta :: Expr -> Bool
isMeta = isJust.unMeta 

-- works with utf-8 characters also, as it seems


mkFuncWithArg ::  ((CId,CId),[CId]) -> FuncWithArg
mkFuncWithArg ((c1,c2),cids) = FuncWithArg c1 c2 cids


---------------------------------------------------------------------------------

initial :: TypeMap -> ConcMap -> [FuncWithArg] -> [FuncWithArg] -> Environ
initial tm cm fss allfs = Env tm cm (mkSigs fss) allfs
{-
testInit :: [FuncWithArg] -> Environ
testInit allfs = initial lTypes Map.empty [] allfs

lTypes = Map.fromList [(mkCId "Comment", mkCId "S"),(mkCId "Item", mkCId "NP"), (mkCId "Kind", mkCId "CN"), (mkCId "Quality", mkCId "AP")]
-}
startCateg = mkCId "Comment"
-- question about either to give the startcat or not ...





----------------------------------------------------------------------------------------------------------
{-
main = 
 do args <- getArgs
    case args of 
      [pgfFile] -> 
         do pgf <- readPGF pgfFile
            parsePGF <- readPGF parsePGFfile
            fsWithArg <- forExample pgf
            let funcsWithArg = map (map mkFuncWithArg) fsWithArg
            let morpho = buildMorpho parsePGF parseLang
            let fss = concat funcsWithArg
            let fileName = takeWhile (/='.') pgfFile ++ lang ++ ".gf"
            env <- start parsePGF pgf morpho (testInit fss) fss
            putStrLn $ "Should I write the results to a file ? yes/no"
            ans <-getLine 
            if ans == "yes" then do writeResults env fileName
                                    putStrLn $ "Wrote file " ++ fileName
             else return ()  
      _ ->  fail "usage : Testing <path-to-pgf> "


  
start :: PGF -> PGF -> Morpho -> Environ -> [FuncWithArg] -> IO Environ
start parsePGF pgfFile morpho env lst = 
  do putStrLn "Do you want examples from another language ? (no/concrete syntax name otherwise)"
     ans1 <- getLine
     putStrLn "Do you want testing mode ? (yes/no)"
     ans2 <- getLine
     case (ans1,ans2) of
       ("no","no")    -> do putStrLn "no extra language, just the abstract syntax tree"
                            interact env lst False Nothing 
       (_,"no")       -> interact env lst False (readLanguage ans1)
       ("no","yes")   -> do putStrLn "no extra language, just the abstract syntax tree"
                            interact env lst True Nothing
       (_,"yes")    -> interact env lst True (readLanguage ans1)
       ("no",_)       -> do putStrLn "no extra language, just the abstract syntax tree"
                            putStrLn $ "I assume you don't want the testing mode ... " 
                            interact env lst False Nothing
       (_,_)          -> do putStrLn $ "I assume you don't want the testing mode ... " 
                            interact env lst False (readLanguage ans1)             
  where 

   interact environ [] func _ = return environ
   interact environ (farg:fargs) boo otherLang = 
             do 
                maybeEnv <- basicInter farg otherLang environ boo
                if isNothing maybeEnv then return environ
                 else interact (fromJust maybeEnv) fargs boo otherLang                

   basicInter farg js environ False = 
       let e_ = getExpr farg environ in 
        if isNothing e_ then return $ Just environ
             else parseAndBuild farg js environ (getType farg) e_ Nothing 
   basicInter farg js environ True = 
        let (e_,e_test) = get2Expr farg environ in 
         if isNothing e_ then return $ Just environ 
          else if isNothing e_test then do putStrLn $ "not enough arguments "++ (showCId $ getName farg)
                                           parseAndBuild farg js environ (getType farg) e_ Nothing  
                    else parseAndBuild farg js environ (getType farg) e_ e_test

-- . head . generateRandomFrom gen2 pgfFile
   parseAndBuild farg js environ ty e_ e_test =
           do let expr = fromJust e_
              gen1 <- newStdGen
              gen2 <- newStdGen
              let newexpr = head $ generateRandomFrom gen1 pgfFile expr
              let embeddedExpr = maybe "***" (showExpr [] ) (embedInStart (getAll environ) (Map.fromList [(ty,expr)])) 
              let lexpr = if isNothing js then "" else "\n-- " ++ linearize pgfFile (fromJust js) newexpr ++ " --" 
              putStrLn $ "Give an example for " ++ (showExpr [] expr)    
                               ++ lexpr ++ "and now"
                               ++ "\n\nas in " ++ embeddedExpr ++ "\n\n"
              --
              ex <- getLine 
              if (ex == ":q") then return Nothing  
                    else 
                      let ctype = fromJust $ Map.lookup (getType farg) (getTypeMap environ) in
                         do env' <- decypher farg ex expr environ (fromJust $ readType $ showCId ctype) e_test
                            return (Just env')
       
   decypher farg ex expr environ ty e_test =  
     --do putStrLn $ "We need to parse " ++ ex ++ " as " ++ show ctype
        let pTrees = parse parsePGF (fromJust $ readLanguage "ParseEng") ty ex  in 
             pickTree farg expr environ ex e_test pTrees 
             
 --  putStrLn $ "And now for testing, \n is this also correct yes/no \n ## " ++  (linearize parsePGF parseLang $ mapToResource newenv $ llin newenv e_test) ++ " ##"
                                               
   -- select the right tree among the options given by the parser 
   pickTree farg expr environ ex e_test [] =  
                let miswords = morphoMissing morpho (words ex) 
                   in 
                if null miswords then do putStrLn $ "all words known, but some syntactic construction is not covered by the grammar..."
                                         return environ
                    else do putStrLn $ "the following words are unknown, please add them to the lexicon: " ++ show miswords
                            return environ
   pickTree farg expr environ ex e_test [tree] = 
                do val <- searchGoodTree environ expr [tree]  -- maybe order here after the probabilities for better precision
                   maybe (do putStrLn $ "none of the trees is consistent with the rest of the grammar, please check arguments "
                             return environ) 
                         (\(x,newtree) -> let newenv = updateEnv environ farg (getType farg) x in
                                              do putStrLn $ "the result is "++showExpr [] x
                                                 newtestenv <- testTest newenv e_test -- question ? should it belong there - there is just one possibility of a tree... 
                                                 return newenv) val
   pickTree farg expr environ ex e_test parseTrees = 
                do putStrLn $ "There is more than one possibility, do you want to choose the right tree yourself ? yes/no "
                   putStr "  >"
                   ans <- getLine
                   if ans == "yes" then do pTree <- chooseRightTree parseTrees
                                           processTree farg environ expr pTree e_test
                     else processTree farg environ expr parseTrees e_test

   -- introduce testing function, if it doesn't work, then reparse, take that tree
   testTree envv e_test = return envv -- TO DO - add testing here
   
   testTest envv Nothing = return envv
   testTest envv (Just exxpr) = testTree envv exxpr   
 

   -- allows the user to pick his own tree
   chooseRightTree trees = return trees -- TO DO - add something clever here     
   
   -- selects the tree from where one can abstract over the original arguments 
   processTree farg environ expr lsTrees e_test =
     let trmes = if length lsTrees == 1 then "the tree is not consistent " else "none of the trees is consistent " in
     do val <- searchGoodTree environ expr lsTrees
        maybe (do putStrLn $ trmes ++ "with the rest of the grammar, please check arguments! "
                  return environ) 
                         (\(x,newtree) -> let newenv = updateEnv environ farg (getType farg) x in
                                              do putStrLn $ "the result is "++showExpr [] x
                                                 newtestenv <- testTest newenv e_test 
                                                 return newenv) val



-------------------------------

get2Expr :: FuncWithArg -> Environ -> (Maybe Expr, Maybe Expr)
get2Expr farg env =
  let tys = getTypeArgs farg
      ctx = getSigs env
      (lst1,lst2) = getConcTypes2 ctx tys 1
      arg1 = if (all isJust lst1) then Just $ mkApp (getName farg) (map fromJust lst1) else Nothing
      arg2 = if (all isJust lst2) then Just $ mkApp (getName farg) (map fromJust lst2) else Nothing
   in if arg1 == arg2 then (arg1, Nothing)
         else (arg1,arg2)
  where 
           getConcTypes2 context [] i = ([],[])
           getConcTypes2 context (ty:types) i =  
                let pos = Map.lookup ty context
                   in 
                    if isNothing pos  || (null $ fromJust pos) then ([Nothing],[Nothing])                                                
                          else  
                             let (mm,tt) = (last $ fromJust pos, head $ fromJust pos)
                                 mmargs = getTypeArgs mm
                                 newi = i + length mmargs - 1  
                                 (lst1,lst2) = getConcTypes2 (Map.insert ty (init (fromJust pos)) context) types (newi+1)
                                 ttargs = getTypeArgs tt
                                 newtti = i + length ttargs - 1
                                 fstArg = if (all isJust lst1) then               -- i..newi  
                                             (Just $ mkApp (getName mm) [mkMeta j | j <- [1..(length mmargs)]]) : lst1 
                                            else [Nothing]
                                 sndArg = if (all isJust lst2) then 
                                             (Just $ mkApp (getName tt) [mkMeta j | j <- [1..(length ttargs)]]) : lst2
                                            else [Nothing]
                              in 
                                (fstArg,sndArg)   


-}
 