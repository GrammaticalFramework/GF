module API where

import qualified AbsGF as GF
import qualified AbsGFC as A
import qualified Rename as R
import GetTree
import GFC
--- import qualified Values as V
import Values

-----import GetGrammar
import Compile
import IOGrammar
import Linear
import Parsing
import Morphology
import PPrCF
import CFIdent
import PGrammar
import Randomized (mkRandomTree)

import MMacros
import qualified Macros as M
import TypeCheck
import CMacros
import Transfer
import qualified Generate as Gen

import Option
import Custom
import ShellState
import Linear
import GFC
import qualified Grammar as G
import PrGrammar
import qualified Compute as Co
import qualified Ident as I
import qualified GrammarToCanon as GC
import qualified CanonToGrammar as CG
import qualified MkGFC as MC

import Editing

----import GrammarToXML 

----import GrammarToMGrammar as M

import Arch (myStdGen)

import UTF8
import Operations
import UseIO
import Zipper

import List (nub)
import Monad (liftM)
import System (system)

-- Application Programmer's Interface to GF; also used by Shell. AR 10/11/2001

type GFGrammar = StateGrammar
type GFCat     = CFCat
type Ident     = I.Ident
--- type Tree      = V.Tree

-- these are enough for many simple applications

file2grammar :: FilePath -> IO GFGrammar
file2grammar file = do
  egr <- appIOE $ optFile2grammar (iOpts [beSilent]) file
  err (\s -> putStrLn s >> return emptyStateGrammar) return egr

linearize :: GFGrammar -> Tree -> String
linearize sgr = err id id . optLinearizeTree opts sgr where
  opts = addOption firstLin $ stateOptions sgr

linearizeToAll :: [GFGrammar] -> Tree -> [String]
linearizeToAll grs t = [linearize gr t | gr <- grs]

parse :: GFGrammar -> CFCat -> String -> [Tree]
parse sgr cat = errVal [] . parseString noOptions sgr cat

parseAny :: [GFGrammar] -> CFCat -> String -> [Tree]
parseAny grs cat s = concat [parse gr cat s | gr <- grs]

translate :: GFGrammar -> GFGrammar -> CFCat -> String -> [String]
translate ig og cat = map (linearize og) . parse ig cat

translateToAll :: GFGrammar -> [GFGrammar] -> CFCat -> String -> [String]
translateToAll ig ogs cat = concat . map (linearizeToAll ogs) . parse ig cat

translateFromAny :: [GFGrammar] -> GFGrammar -> CFCat -> String -> [String]
translateFromAny igs og cat s = concat [translate ig og cat s | ig <- igs]

translateBetweenAll :: [GFGrammar] -> CFCat -> String -> [String]
translateBetweenAll grs cat = concat . map (linearizeToAll grs) . parseAny grs cat

homonyms :: GFGrammar -> CFCat -> Tree -> [Tree]
homonyms gr cat = nub . parse gr cat . linearize gr

hasAmbiguousLin :: GFGrammar -> CFCat -> Tree -> Bool
hasAmbiguousLin gr cat t = case (homonyms gr cat t) of
  _:_:_ -> True
  _ -> False

{- ----
-- returns printname if one exists; othewrise linearizes with metas
printOrLin :: GFGrammar -> Fun -> String
printOrLin gr = printOrLinearize (stateGrammarST gr)

-- reads a syntax file and writes it in a format wanted
transformGrammarFile :: Options -> FilePath -> IO String
transformGrammarFile opts file = do
  sy <- useIOE GF.emptySyntax $ getSyntax opts file
  return $ optPrintSyntax opts sy
-}

prIdent :: Ident -> String
prIdent = prt

string2GFCat :: String -> String -> GFCat
string2GFCat = string2CFCat

-- then stg for customizable and internal use

optFile2grammar :: Options -> FilePath -> IOE GFGrammar
optFile2grammar os f = do
  ((_,_,gr),_) <- compileModule os emptyShellState f
  ioeErr $ grammar2stateGrammar os gr

optFile2grammarE :: Options -> FilePath -> IOE GFGrammar
optFile2grammarE = optFile2grammar


string2treeInState :: GFGrammar -> String -> State -> Err Tree
string2treeInState gr s st = do
  let metas = allMetas st
      xs    = map fst $ actBinds st
  t0 <- pTerm s
  let t = qualifTerm (absId gr) $ M.mkAbs xs $ refreshMetas metas $ t0
  annotateExpInState (grammar gr) t st 

string2srcTerm :: G.SourceGrammar -> I.Ident -> String -> Err G.Term
string2srcTerm gr m s = do
  t <- pTerm s
  R.renameSourceTerm gr m t

randomTreesIO :: Options -> GFGrammar -> Int -> IO [Tree]
randomTreesIO opts gr n = do
  gen <- myStdGen mx
  t   <- err (\s -> putStrLnFlush s >> return []) (return . singleton) $ 
                                                       mkRandomTree gen mx g catfun
  ts  <- if n==1 then return [] else randomTreesIO opts gr (n-1)
  return $ t ++ ts
 where
   catfun = case getOptVal opts withFun of
     Just fun -> Right $ (absId gr, I.identC fun)
     _ -> Left $ firstAbsCat opts gr
   g   = grammar gr
   mx  = optIntOrN opts flagDepth 41

generateTrees :: Options -> GFGrammar -> Maybe Tree -> [Tree]
generateTrees opts gr mt =
  optIntOrAll opts flagNumber  
    [tr | t <- Gen.generateTrees gr' ifm cat dpt mn mt, Ok tr <- [mkTr t]]
  where
    mkTr = annotate gr' . qualifTerm (absId gr) 
    gr' = grammar gr
    cat = firstAbsCat opts gr
    dpt = maybe 3 id $ getOptInt opts flagDepth
    mn  = getOptInt opts flagAlts
    ifm = oElem withMetas opts

speechGenerate :: Options -> String -> IO ()
speechGenerate opts str = do
  let lan = maybe "" (" --language" +++) $ getOptVal opts speechLanguage
  system ("flite" +++ "\" " ++ str ++ "\"")
---  system ("echo" +++ "\"" ++ str ++ "\" | festival --tts" ++ lan)
  return ()

optLinearizeTreeVal :: Options -> GFGrammar -> Tree -> String
optLinearizeTreeVal opts gr = err id id . optLinearizeTree opts gr

optLinearizeTree :: Options -> GFGrammar -> Tree -> Err String
optLinearizeTree opts0 gr t = case getOptVal opts transferFun of
  Just m -> useByTransfer flin g (I.identC m) t
  _ -> flin t
 where
  opts = addOptions (stateOptions gr) opts0
  flin = case getOptVal opts markLin of
    Just mk
     | mk == markOptXML    -> lin markXML
     | mk == markOptJava   -> lin markXMLjgf
     | mk == markOptStruct -> lin markBracket
     | mk == markOptFocus  -> lin markFocus
     | otherwise           -> lin noMark
    _ -> lin noMark

  lin mk
    | oElem showRecord opts = liftM prt . linearizeNoMark g c
    | oElem tableLin opts   = liftM (unlines . map untok . prLinTable) . 
                                allLinTables g c
    | oElem showAll opts    = return . unlines . linTree2strings mk g c
    | otherwise             = return . unlines . optIntOrOne . linTree2strings mk g c
  g = grammar gr
  c = cncId gr
  untok = customOrDefault opts useUntokenizer customUntokenizer gr
  optIntOrOne = take $ optIntOrN opts flagNumber 1

{- ----
        untoksl . lin where
  gr = concreteOf (stateGrammarST sgr)
  lin -- options mutually exclusive, with priority: struct, rec, table, one
   | oElem showStruct opts = markedLinString True gr . tree2loc
   | oElem showRecord opts = err id prt                  . linTerm gr
   | oElem tableLin opts   = err id (concatMap prLinTable)  . allLinsAsStrs gr
   | oElem firstLin opts   = unlines . map sstr . take 1 . allLinStrings gr
   | otherwise = unlines . map sstr . optIntOrAll opts flagNumber . allLinStrings gr
  untoks = customOrDefault opts' useUntokenizer customUntokenizer sgr
  opts' = addOptions opts $ stateOptions sgr
  untoksl = unlines . map untoks . lines
-}

{-
optLinearizeArgForm :: Options -> StateGrammar -> [Term] -> Term -> String
optLinearizeArgForm opts sgr fs ts0 = untoksl $ lin ts where
  gr = concreteOf (stateGrammarST sgr) 
  ts = annotateTrm sgr ts0
  ms = map (renameTrm (lookupConcrete gr)) fs
  lin -- options mutually exclusive, with priority: struct, rec, table
   | oElem tableLin opts = err id (concatMap prLinTable) . allLinsForForms gr ms
   | otherwise = err id (unlines . map sstr . tkStrs . concat) . allLinsForForms gr ms
  tkStrs = concat . map snd . concat . map snd
  untoks = customOrDefault opts' useUntokenizer customUntokenizer sgr
  opts' = addOptions opts $ stateOptions sgr
  untoksl = unlines . map untoks . lines
-}

optParseArg :: Options -> GFGrammar -> String -> [Tree]
optParseArg opts gr =  err (const []) id . optParseArgErr opts gr

optParseArgAny :: Options -> [GFGrammar] -> String -> [Tree]
optParseArgAny opts grs s = concat [pars gr s | gr <- grs] where
  pars gr = optParseArg opts gr --- grammar options!

optParseArgErr :: Options -> GFGrammar -> String -> Err [Tree]
optParseArgErr opts gr = liftM fst . optParseArgErrMsg opts gr

optParseArgErrMsg :: Options -> GFGrammar -> String -> Err ([Tree],String)
optParseArgErrMsg opts gr s = do
  let cat = firstCatOpts opts gr
      g   = grammar gr
  (ts,m) <- parseStringMsg opts gr cat s
  ts' <- case getOptVal opts transferFun of
    Just m -> mkByTransfer (const $ return ts) g (I.identC m) s
    _ -> return ts
  return (ts',m)

-- analyses word by word
morphoAnalyse :: Options -> GFGrammar -> String -> String
morphoAnalyse opts gr 
  | oElem beShort opts = morphoTextShort mo 
  | otherwise = morphoText mo 
 where
  mo = morpho gr

{-
prExpXML :: StateGrammar -> Term -> [String]
prExpXML gr = prElementX . term2elemx (stateAbstract gr) 

prMultiGrammar :: Options -> ShellState -> String
prMultiGrammar opts = M.showMGrammar (oElem optimizeCanon opts)
-}
-- access to customizable commands

optPrintGrammar :: Options -> StateGrammar -> String
optPrintGrammar opts = customOrDefault opts grammarPrinter customGrammarPrinter

optPrintSyntax :: Options -> GF.Grammar -> String
optPrintSyntax opts = customOrDefault opts grammarPrinter customSyntaxPrinter

prCanonGrammar :: CanonGrammar -> String
prCanonGrammar = MC.prCanon


optPrintTree :: Options -> GFGrammar -> Tree -> String
optPrintTree opts = customOrDefault opts grammarPrinter customTermPrinter

-- look for string command (-filter=x)
optStringCommand :: Options -> GFGrammar -> String -> String
optStringCommand opts g = 
  optIntOrAll opts flagLength .  
  customOrDefault opts filterString customStringCommand g

optTermCommand :: Options -> GFGrammar -> Tree -> [Tree]
optTermCommand opts st = 
  optIntOrAll opts flagNumber .  
  customOrDefault opts termCommand customTermCommand st


{-
-- wraps term in a function and optionally computes the result

wrapByFun :: Options -> GFGrammar -> Ident -> Tree -> Tree
wrapByFun opts gr f t = 
  if oElem doCompute opts 
  then err (const t) id $ computeAbsTerm (stateAbstract g) (appCons f' [t])
  else appCons f' [t]
 where
   qualifTerm (absId gr) $ 


optTransfer :: Options -> StateGrammar -> Term -> Term
optTransfer opts g = case getOptVal opts transferFun of
  Just f -> wrapByFun (addOption doCompute opts) g (string2id f)
  _ -> id
-}
optTokenizer :: Options -> GFGrammar -> String -> String
optTokenizer opts gr = show . customOrDefault opts useTokenizer customTokenizer gr

-- performs UTF8 if the language does not have flag coding=utf8; replaces name*U

optEncodeUTF8 :: GFGrammar -> String -> String
optEncodeUTF8 gr = case getOptVal (stateOptions gr) uniCoding of
  Just "utf8" -> id
  _ -> encodeUTF8

optDecodeUTF8 :: GFGrammar -> String -> String
optDecodeUTF8 gr = case getOptVal (stateOptions gr) uniCoding of
  Just "utf8" -> decodeUTF8 
  _ -> id

