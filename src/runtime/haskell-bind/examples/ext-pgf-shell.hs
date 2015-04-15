-- | pgf-shell: A simple shell to illustrate the use of the Haskell binding
--   to the C implementation of the PGF run-time system.
--
--   lib/src$ 
--   make -j TranslateEng.pgf TranslateFre.pgf
--    make TranslateEngFre
--
--  src/runtime/haskell-bind/examples
--    ghc --make ext-pgf-shell.hs 
--    ./ext-pgf-shell ~/GF/lib/src/TranslateEngFre.pgf 

--   The shell has 3 commands:
--
--     * parse: p <lang> <text>
--     * linearize: l <lang> <tree>
--     * translate: t <lang> <lang> <text> 
-- AR 15/4/2015: extended functionality:
-- call the program with 
--   ./ext-pgf-shell <pgf-file> <from-concrete-name> <to-concrete-name>
-- then you can translate text files line by line, and see the top-20 trees with their translations and probabilities.
-- 20 = maxNumTrees, which can be changed

import Control.Monad(forever)
import Control.Monad.State(evalStateT,put,get,gets,liftIO)
import Control.Exception.Lifted as L(catch)
import Data.Char(isSpace)
import qualified Data.Map as M
import System.IO(hFlush,stdout)
import System.Environment
import PGF2
import System.Mem(performGC)
import qualified Data.Map as Map

maxNumTrees :: Int
maxNumTrees = 20

main = getPGF =<< getArgs

getPGF [path,from,to] = pgfShell from to =<< readPGF path
getPGF [path] = pgfShell english french =<< readPGF path
getPGF _ = putStrLn "Usage: pgf-shell <path to pgf>"

pgfShell from to pgf =
  do putStrLn . unwords . M.keys $ languages pgf
     putStrLn $ unwords ["default translation direction:",from,to]
     flip evalStateT (pgf,[]) $ forever $ do liftIO performGC
                                             puts "> "; liftIO $ hFlush stdout
                                             execute from to =<< liftIO readLn

execute from to cmd =
  case cmd of
    L lang tree -> do pgf <- gets fst
                      c <- getConcr' pgf lang
                      put (pgf,[])
                      putln $ linearize c tree
    P lang s    -> do pgf <- gets fst
                      c <- getConcr' pgf lang
                      case parse c (startCat pgf) s of
                        Left tok -> do put (pgf,[])
                                       putln ("Parse error: "++tok)
                        Right ts -> do put (pgf,map show ts)
                                       pop
    T from to s -> do pgf <- gets fst
                      cfrom <- getConcr' pgf from
                      cto   <- getConcr' pgf to
                      case parse cfrom (startCat pgf) s of
                        Left tok -> do put (pgf,[])
                                       putln ("Parse error: "++tok)
                        Right ts -> do put (pgf,map (linearize cto.fst) ts)
                                       pop
    A ss        -> do pgf <- gets fst -- AR
                      cfrom <- getConcr' pgf from
                      cto   <- getConcr' pgf to
                      translatesWithPron pgf cfrom cto (startCat pgf) [] ss
    E s         -> do pgf <- gets fst -- AR
                      cfrom <- getConcr' pgf from
                      cto   <- getConcr' pgf to
                      translates pgf cfrom cto (startCat pgf) [] s
    I path -> do pgf <- liftIO (readPGF path)
                 putln . unwords . M.keys $ languages pgf
                 put (pgf,[])
    Empty -> pop
    Unknown s -> putln ("Unknown command: "++s)       
  `L.catch` (liftIO . print . (id::IOError->IOError))

pop = do (pgf,ls) <- get
         let (ls1,ls2) = splitAt 1 ls
         putl ls1
         put (pgf,ls2)

getConcr' pgf lang =
    maybe (fail $ "Concrete syntax not found: "++show lang) return $
    Map.lookup lang (languages pgf)

printl xs = liftIO $ putl $ map show xs
putl ls = liftIO . putStr $ unlines ls
putln s = liftIO $ putStrLn s
puts s = liftIO $ putStr s

-- | Abstracy syntax of shell commands
data Command = P String String | L String Expr | T String String String
             | I FilePath | Empty | Unknown String
             | A [String] -- AR
             | E String -- AR
             deriving Show

-- | Shell command parser
instance Read Command where
  readsPrec _ s =
      take 1 $
          [(P l r2,"") | ("p",r1)<-lex s, (l,r2) <- lex r1]
       ++ [(L l t,"") | ("l",r1)<-lex s, (l,r2)<- lex r1, Just t<-[readExpr r2]]
       ++ [(T l1 l2 r3,"") | ("t",r1)<-lex s, (l1,r2)<-lex r1, (l2,r3)<-lex r2]
       ++ [(I (dropWhile isSpace r),"") | ("i",r)<-lex s]
       ++ [(Empty,"") | ("","") <- lex s]
       ++ [(E s,"")]        -- translation with treebank output
       ++ [(A (chop s),"")] -- Liza's application
       ++ [(Unknown s,"")]


-- extensions AR 9/4/2015

-- the main function
changeTree :: [Expr] -> (Expr,a) -> (Expr,a)
changeTree context (t,a) = (change t,a) where
  change t = maybe t trans $ unApp t 
  trans (fun,args) = case (fun,args) of
    ("it_Pron",[]) -> case givenNouns context of 
       n:_ -> mkApp "AnnotPron" [n]
       _ -> mkApp "she_Pron" []
    _ -> mkApp fun (map change args)

givenNouns :: [Expr] -> [Expr]
givenNouns = concatMap getNouns where
  getNouns t = case unApp t of
    Just ("UseN",[n]) -> [n]
    Just (_,ts) -> concatMap getNouns ts
    _ -> []

english = "TranslateEng"
french = "TranslateFre"

linearizeAndShow gr (t,p) = [show t, linearize gr t, show p]
--                                       put (pgf,map show ts')
--                                       put (pgf,map (linearize cto.fst) ts')


selectTrees :: [(Expr,a)] -> [(Expr,a)]
selectTrees ts = case filter notChunk (take 10 ts) of
  [] -> ts
  ncts -> ncts
 where
  notChunk (t,_) = case unApp t of
    Just ("ChunkPhr",_) -> False
    _ -> True

chop :: String -> [String]
chop s = case break (==';') s of
  (s1,_:s2) -> s1 : chop s2
  _ -> [s]

translates pgf cfrom cto cat context s = do
  putln s
  case cparse pgf cfrom cat s of
    Left tok -> do 
--      put (pgf,[])
      putln ("Parse error: "++tok)
    Right ts -> do 
      let ls = map (unlines . linearizeAndShow cto) ts
  --    put (pgf,ls)
      putln (unlines $ take maxNumTrees ls)
  put (pgf,[])

translatesWithPron pgf cfrom cto cat context ss = case ss of
  []  -> put (pgf,[])
  s:rest -> case cparse pgf cfrom cat s of
    Left tok -> do 
      put (pgf,[])
      putln ("Parse error: "++tok)
    Right ts -> do 
      let ts' = map (changeTree context) (selectTrees ts)
      put (pgf,map (unlines . init . linearizeAndShow cto) ts')
      pop
      translatesWithPron pgf cfrom cto cat (fst (head ts') : context) rest

cparse pgf concr cat input = parseWithHeuristics concr cat input (-1) callbacks where
  callbacks = maybe [] cb $ lookup "App" literalCallbacks
  cb fs = [(cat,f pgf ("TranslateEng",concr))|(cat,f)<-fs]


-- to do
-- actual selection in changeTree
