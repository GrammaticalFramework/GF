----------------------------------------------------------------------
-- |
-- Module      : Commands
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/08/17 14:43:50 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.40 $
--
-- temporary hacks for GF 2.0
--
-- Abstract command language for syntax editing. AR 22\/8\/2001.
-- Most arguments are strings, to make it easier to receive them from e.g. Java.
-- See "CommandsL" for a parser of a command language.
-----------------------------------------------------------------------------

module GF.Shell.Commands where

import GF.Data.Operations
import GF.Data.Zipper

import qualified GF.Grammar.Grammar as G ---- Cat, Fun, Q, QC
import GF.Canon.GFC
import GF.Canon.CMacros
import GF.Grammar.Macros (qq)----
import GF.Grammar.LookAbs
import GF.Canon.Look
import GF.Grammar.Values (loc2treeFocus,tree2exp)----

import GF.UseGrammar.GetTree
import GF.API
import GF.Compile.ShellState

import qualified GF.Shell as Shell
import qualified GF.Shell.PShell as PShell
import qualified GF.Grammar.Macros as M
import GF.Grammar.PrGrammar
import GF.Compile.PGrammar
import GF.API.IOGrammar
import GF.Infra.UseIO
import GF.Text.Unicode

import GF.CF.CF
import GF.CF.CFIdent (cat2CFCat, cfCat2Cat)
import GF.CF.PPrCF (prCFCat)
import GF.UseGrammar.Linear
import GF.UseGrammar.Randomized
import GF.UseGrammar.Editing
import GF.UseGrammar.Session
import GF.UseGrammar.Custom

import qualified GF.Infra.Ident as I
import GF.Infra.Option
import GF.Data.Str (sstr) ----
import GF.Text.UTF8 ----

import System.Random (StdGen, mkStdGen, newStdGen)
import Control.Monad (liftM2, foldM)
import Data.List (intersperse)

--- temporary hacks for GF 2.0

-- Abstract command language for syntax editing. AR 22/8/2001
-- Most arguments are strings, to make it easier to receive them from e.g. Java.
-- See CommandsL for a parser of a command language.

data Command =
   CNewCat String
 | CNewTree String
 | CAhead Int
 | CBack Int
 | CNextMeta
 | CPrevMeta
 | CTop
 | CLast
 | CMovePosition [Int]
 | CCopyPosition [Int]
 | CRefineWithTree String
 | CRefineWithClip Int
 | CRefineWithAtom String
 | CRefineParse String
 | CWrapWithFun (String,Int)
 | CChangeHead String
 | CPeelHead (String,Int)
 | CAlphaConvert String
 | CRefineRandom
 | CSelectCand Int
 | CTermCommand  String
 | CAddOption Option
 | CRemoveOption Option
 | CDelete
 | CAddClip
 | CRemoveClip Int
 | CUndo Int
 | CView
 | CMenu
 | CQuit
 | CHelp  (CEnv -> String) -- ^ help message depends on grammar and interface
 | CError -- ^ syntax error in command
 | CVoid  -- ^ empty command, e.g. just \<enter\>

 | CCEnvImport String         -- ^ |-- commands affecting 'CEnv'
 | CCEnvEmptyAndImport String -- ^ |
 | CCEnvOpenTerm String       -- ^ |
 | CCEnvOpenString String     -- ^ |
 | CCEnvEmpty                 -- ^ |

 | CCEnvOn  String            -- ^ |
 | CCEnvOff String            -- ^ |

 | CCEnvGFShell String        -- ^ |==========

 | CCEnvRefineWithTree String -- ^ |-- other commands using 'IO'
 | CCEnvRefineParse String    -- ^ |
 | CCEnvSave String FilePath  -- ^ |==========

isQuit :: Command -> Bool
isQuit CQuit = True
isQuit _ = False

-- | an abstract environment type
type CEnv    = ShellState

grammarCEnv :: CEnv -> StateGrammar
grammarCEnv  = firstStateGrammar

canCEnv :: CEnv -> CanonGrammar
canCEnv  = canModules

concreteCEnv, abstractCEnv :: StateGrammar -> I.Ident
concreteCEnv = cncId
abstractCEnv = absId

stdGenCEnv :: CEnv -> SState -> StdGen
stdGenCEnv env s = mkStdGen (length (displayJustStateIn env s) * 31 +11) ---

initSStateEnv :: CEnv -> SState
initSStateEnv env = case getOptVal (stateOptions sgr) gStartCat of
  Just cat -> action2commandNext (newCat gr (abs, I.identC cat)) initSState
  _ -> initSState
 where 
   sgr = firstStateGrammar env
   abs = absId sgr
   gr  = stateGrammarST sgr

-- | the main function
execCommand :: CEnv -> Command -> SState -> IO (CEnv,SState)
execCommand env c s = case c of

-- these commands do need IO
  CCEnvImport file -> useIOE (env,s) $ do
    st <- shellStateFromFiles optss env file
    return (st,s)

  CCEnvEmptyAndImport file -> useIOE (emptyShellState, initSState) $ do
    st <- shellStateFromFiles optss emptyShellState file
    return (startEditEnv st,initSState)

  CCEnvEmpty -> do
    return (startEditEnv emptyShellState, initSState)

  CCEnvGFShell command -> do
    let cs = PShell.pCommandLines command
    (msg,(env',_)) <- Shell.execLines False cs (Shell.initHState env)
    return (env', changeMsg msg s) ----

  CCEnvOpenTerm file -> do
    c <- readFileIf file
    let (fs,t) = envAndTerm file c
----    (env',_) <- execCommand env (CCEnvGFShell fs) s  --TODO; next deprec
----    env' <- useIOE env $ foldM (shellStateFromFiles noOptions) env fs 
    let env' = env ----
    return (env', execECommand env' (CNewTree t) s)

  CCEnvOpenString file -> do
    c <- readFileIf file
    let (fs,t) = envAndTerm file c
----    (env',_) <- execCommand env (CCEnvGFShell fs) s  --TODO; next deprec
---- env' <- useIOE env $ foldM (shellStateFromFiles noOptions) env fs
    let env' = env ----
    return (env', execECommand env' (CRefineParse t) s)

  CCEnvOn  name -> return (languageOn  (language name) env,s)
  CCEnvOff name -> return (languageOff (language name) env,s)

  CCEnvSave lang file -> do
    let str = optLinearizeTreeVal opts (stateGrammarOfLang env (language lang)) $ treeSState s
    writeFile file str
    let msg = ["wrote file" +++ file]
    return (env,changeMsg msg s)

-- this command is improved by the use of IO
  CRefineRandom -> do
    g <- newStdGen
    return (env, action2commandNext (refineRandom g 41 cgr) s)

-- these commands use IO
  CCEnvRefineWithTree file -> do
    str <- readFileIf file 
    execCommand env (CRefineWithTree str) s 
  CCEnvRefineParse file -> do
    str <- readFileIf file 
    execCommand env (CRefineParse str) s 

-- other commands don't need IO; they are available in the fudget
  c -> return (env, execECommand env c s)

 where
   gr = grammarCEnv env
   cgr = canCEnv env
   opts = globalOptions env
   optss = addOption beSilent opts

   -- format for documents: 
   -- GF commands of form "-- command", then term or text  
   envAndTerm f s = 
     (unwords (intersperse ";;" fs), unlines ss) where
       (fs,ss) = span isImport (lines s)
       isImport l = take 2 l == "--"


execECommand :: CEnv -> Command -> ECommand
execECommand env c = case c of
  CNewCat cat        -> action2commandNext $ \x -> do
                          cat' <- string2cat sgr cat
                          s' <- newCat cgr cat' x
                          uniqueRefinements cgr s'
  CNewTree s         -> action2commandNext $ \x -> do 
                          t  <- string2treeErr gr s 
                          s' <- newTree t x
                          uniqueRefinements cgr s'
  CAhead n           -> action2command (goAheadN n)
  CBack n            -> action2command (goBackN n)
  CTop               -> action2command $ return . goRoot
  CLast              -> action2command $ goLast
  CMovePosition p    -> action2command $ goPosition p
  CNextMeta          -> action2command goNextNewMeta
  CPrevMeta          -> action2command goPrevNewMeta
  CRefineWithAtom s  -> action2commandNext $ \x -> do 
                          t  <- string2ref gr s
                          s' <- refineWithAtom der cgr t x
                          uniqueRefinements cgr s'
  CWrapWithFun (f,i) -> action2commandKeep $ wrapWithFun cgr (qualif f, i)
  CChangeHead f      -> action2commandKeep $ changeFunHead cgr (qualif f)
  CPeelHead (f,i)    -> action2commandKeep $ peelFunHead cgr (qualif f,i)

  CAlphaConvert s    -> action2commandKeep $ \x ->
                          string2varPair s >>= \xy -> alphaConvert cgr xy x

  CRefineWithTree s  -> action2commandNext $ \x -> 
                          (string2treeInState gr s x >>= 
                            \t -> refineWithTree der cgr t x)
  CRefineWithClip i  -> \s -> 
                          let et = getNumberedClip i s
                          in (case et of 
                                Ok t -> refineByTrees der cgr [t] s
                                Bad m -> changeMsg [m] s)
  CCopyPosition p  -> action2command $ \s -> do
                        s1    <- goPosition p s
                        let t  = actTree s1
                        let compat = actVal s1 == actVal s
                        if compat 
                          then refineWithTree der cgr t s 
                          else return s 

  CRefineParse str   -> \s -> 
                     let cat = cat2CFCat (qualifTop sgr (actCat (stateSState s)))
                         ts = parseAny agrs cat str
                     in (if null ts ---- debug
                           then withMsg ["parse failed in cat" +++ prCFCat cat]
                           else id) 
                            (refineByTrees der cgr ts) s

  CRefineRandom      -> \s -> action2commandNext
                                (refineRandom (stdGenCEnv env s) 41 cgr) s 

  CSelectCand i      -> selectCand cgr i

  CTermCommand c     -> case c of
                         "reindex" -> \s ->
                           replaceByTermCommand der gr c (actTree (stateSState s)) s
                         "paraphrase" -> \s ->
                           replaceByTermCommand der gr c (actTree (stateSState s)) s
----                          "transfer" -> action2commandNext $
----                                       transferSubTree (stateTransferFun sgr) gr
                         "generate" -> \s ->
                           replaceByTermCommand der gr c (actTree (stateSState s)) s
                         _ -> replaceByEditCommand gr c

  CAddOption o       -> changeStOptions (addOption o)
  CRemoveOption o    -> changeStOptions (removeOption o)
  CDelete            -> action2commandKeep $ deleteSubTree cgr
  CAddClip           -> \s -> (addtoClip (actTree (stateSState s))) s
  CRemoveClip n      -> \s -> (removeClip n) s
  CUndo n            -> undoCommand n
  CMenu              -> \s -> changeMsg (menuState env s) s
  CView              -> changeView
  CHelp h            -> changeMsg [h env]
  CVoid              -> id
  _                  -> changeMsg ["command not yet implemented"]
 where
   sgr  = firstStateGrammar env 
   agrs = allActiveGrammars env
   cgr  = canCEnv env
   gr   = grammarCEnv env
   der  = maybe True not $ caseYesNo (globalOptions env) noDepTypes
          -- if there are dep types, then derived refs;  deptypes is the default
   abs = absId sgr
   qualif = string2Fun gr

--


string2varPair :: String -> Err (I.Ident,I.Ident)
string2varPair s = case words s of
  x : y : [] -> liftM2 (,) (string2ident x) (string2ident y)
  _          -> Bad "expected format 'x y'"


startEditEnv :: CEnv -> CEnv
startEditEnv env = addGlobalOptions (options [sizeDisplay "short"]) env

-- | seen on display
cMenuDisplay :: String -> Command
cMenuDisplay s = CAddOption (menuDisplay s)

newCatMenu :: CEnv -> [(Command, String)]
newCatMenu env = [(CNewCat (prQIdent c), printname env initSState c) | 
                                  (c,[]) <- allCatsOf (canCEnv env)]

mkRefineMenu :: CEnv -> SState -> [(Command,String)]
mkRefineMenu env sstate = [(c,s) | (c,(s,_)) <- mkRefineMenuAll env sstate]

mkRefineMenuAll :: CEnv -> SState -> [(Command,(String,String))]
mkRefineMenuAll env sstate = 
  case (refinementsState cgr state, candsSState sstate, wrappingsState cgr state) of
    ([],[],wraps) -> 
       [(CWrapWithFun (prQIdent_ f, i), prWrap "w" "Wrap" fit)     
         | fit@((f,i),_) <- wraps] ++
       [(CChangeHead (prQIdent_ f),  prChangeHead f) 
         | f <- headChangesState cgr state] ++
       [(CPeelHead (prQIdent_ f, i), prPeel "ph" "PeelHead" fi)     
         | fi@(f,i) <- peelingsState cgr state] ++
       [(CDelete,      (ifShort "d"  "Delete",   "d"))] ++
       [(CAddClip,     (ifShort "ac" "AddClip",  "ac"))]
    (refs,[],_)   -> 
       [(CRefineWithAtom (prRefinement f), prRef t) | t@(f,_) <- refs] ++
       [(CRefineWithClip i, prClip i t) | (i,t) <- possClipsSState gr sstate] 
    (_,cands,_)   -> 
       [(CSelectCand i,   prCand (t,i))    | (t,i) <- zip cands [0..]]

 where
  prRef (f,(t,_)) = 
    (ifShort "r" "Refine" +++ prOrLinRef f +++ ifTyped (":" +++ prt_ t),
     "r" +++ prRefinement f)
  prClip i t =
    (ifShort "rc" "Paste" +++ prOrLinTree t,
     "rc" +++ show i)
  prChangeHead f = 
    (ifShort "ch" "ChangeHead" +++ prOrLinFun f,
     "ch" +++ prQIdent_ f)
  prWrap sh lg ((f,i),t) = 
    (ifShort sh lg   +++ prOrLinFun f +++ ifTyped (":" +++ prt t) +++
     ifShort (show i) (prBracket (show i)),
     sh +++ prQIdent_ f +++ show i)
  prPeel sh lg (f,i) = 
    (ifShort sh lg   +++ prOrLinFun f +++
     ifShort (show i) (prBracket (show i)),
     sh +++ prQIdent_ f +++ show i)
  prCand (t,i) = 
    (ifShort ("s" +++ prOrLinExp t) ("Select" +++ prOrLinExp t),"s" +++ show i)

  gr = grammarCEnv env
  cgr = canCEnv env
  state = stateSState sstate
  opts = addOptions (optsSState sstate) (globalOptions env)
  ifOpt f v a b = case getOptVal opts f of 
    Just s | s == v -> a 
    _ -> b
  ifShort = ifOpt sizeDisplay "short"
  ifTyped t = ifOpt typeDisplay "typed" t ""
  prOrLinExp t = err (const $ prt_ t) prOrLinTree $ annotateInState cgr t state
  prOrLinRef t = case t of
    G.Q m f  ->  printname env sstate (m,f) 
    G.QC m f ->  printname env sstate (m,f) 
    _ -> prt_ t
  prOrLinFun = printname env sstate
  prOrLinTree t = case getOptVal opts menuDisplay of
    Just "Abs" -> prt_ $ tree2exp t ---- prTermOpt opts $ tree2exp t
    Just lang  -> prQuotedString $ lin lang t
    _ -> prTermOpt opts $ tree2exp t
  lin lang t = optLinearizeTreeVal opts (stateGrammarOfLang env (language lang)) t

-- there are three orthogonal parameters: Abs/[conc], short/long, typed/untyped
-- the default is Abs, long, untyped; the Menus menu changes the parameter

emptyMenuItem :: (Command, (String, String))
emptyMenuItem = (CVoid,("",""))



---- allStringCommands = snd $ customInfo customStringCommand
termCommandMenu :: [(Command,String)]
termCommandMenu = [(CTermCommand s, s) | s <- allTermCommands]

allTermCommands :: [String]
allTermCommands = snd $ customInfo customEditCommand

stringCommandMenu :: [(Command,String)]
stringCommandMenu = []

displayCommandMenu :: CEnv -> [(Command,String)]
displayCommandMenu env =
  [(CAddOption (menuDisplay s), s) | s <- "Abs" : langs] ++
  [(CAddOption (sizeDisplay s), s) | s <- ["short", "long"]] ++
  [(fo nostripQualif, s) | (fo,s) <- [(CAddOption,"qualified"),
                                      (CRemoveOption,"unqualified")]] ++
  [(CAddOption (typeDisplay s), s) | s <- ["typed", "untyped"]]
 where
   langs = map prLanguage $ allLanguages env

{- ----

stringCommandMenu = 
   (CAddOption showStruct,      "structured") :
   (CRemoveOption showStruct,   "unstructured") :
  [(CAddOption (filterString s), s) | s <- allStringCommands]
-}

changeMenuLanguage, changeMenuSize, changeMenuTyped :: String -> Command
changeMenuLanguage s = CAddOption (menuDisplay s)
changeMenuSize s     = CAddOption (sizeDisplay s)
changeMenuTyped s    = CAddOption (typeDisplay s)

menuState :: CEnv -> SState -> [String]
menuState env = map snd . mkRefineMenu env

prState :: State -> [String]
prState s = prMarkedTree (loc2treeMarked s)

displayJustStateIn :: CEnv -> SState -> String
displayJustStateIn env state = case displaySStateIn env state of 
   (t,msg,_) -> unlines (t ++ ["",""] ++ msg) --- ad hoc for CommandF

displaySStateIn :: CEnv -> SState -> ([String],[String],[(String,String)])
displaySStateIn env state = (tree',msg,menu) where
  (tree,msg,menu) = displaySState env state
  grs    = allStateGrammars env
  lang   = (viewSState state) `mod` (length grs + 3)
  tree'  = (tree : exp : linAll ++ separ (linAll ++ [tree])) !! lang
  opts   = addOptions (optsSState state)   -- state opts override
             (addOption (markLin markOptFocus) (globalOptions env))
  lin g  = linearizeState fudWrap opts g zipper
  exp    = return $ tree2string $ loc2tree zipper
  zipper = stateSState state
  linAll = map lin grs
  separ  = singleton . map unlines . intersperse [replicate 72 '*']

-- | the Boolean is a temporary hack to have two parallel GUIs
displaySStateJavaX :: Bool -> CEnv -> SState -> String -> String
displaySStateJavaX isNew env state m = encodeUTF8 $ mkUnicode $
                                       unlines $ tagXML "gfedit" $ concat [
  if null m then [] else tagXML "hmsg" [m],
  tagXML "linearizations" (concat 
    [tagAttrXML "lin" ("lang", prLanguage lang) ss | (lang,ss) <- lins]),
  tagXML "tree"           tree,
  tagXML "message"        msg,
  tagXML "menu"           (tagsXML "item" menu')
  ]
 where
  (tree,msg,menu) = displaySState env state
  menu'  = [tagXML "show" [unicode s] ++ tagXML "send" [c] | (s,c) <- menu] 
  (ls,grs) = unzip $ lgrs
  lgrs   = allActiveStateGrammarsWithNames env
  lins   = (langAbstract, exp) : linAll
  opts   = addOptions (optsSState state)   -- state opts override 
              (addOption (markLin mark) (globalOptions env))
  lin (n,gr) = (n, map uni $ linearizeState noWrap opts gr zipper) where
                  uni = optDecodeUTF8 gr
  exp    = prprTree $ loc2tree zipper
  zipper = stateSState state
  linAll = map lin lgrs
  gr     = firstStateGrammar env
  mark   = markOptXML -- markOptJava   

  unicode = case getOptVal opts menuDisplay of
    Just lang -> optDecodeUTF8 (stateGrammarOfLang env (language lang)) 
    _ -> id

-- | the env is UTF8 if the display language is 
--
-- should be independent
isCEnvUTF8 :: CEnv -> SState -> Bool
isCEnvUTF8 env st = maybe False id $ do
   lang <- getOptVal opts menuDisplay
   co   <- getOptVal (stateOptions (stateGrammarOfLang env (language lang))) uniCoding
   return $ co == "utf8"
  where
    opts = addOptions (optsSState st) (globalOptions env)

langAbstract, langXML :: I.Ident
langAbstract = language "Abstract"
langXML      = language "XML"

linearizeState :: (String -> [String]) -> Options -> GFGrammar -> State -> [String]
linearizeState wrap opts gr = 
 wrap . strop . unt . optLinearizeTreeVal opts gr . loc2treeFocus

  where
   unt   = customOrDefault (stateOptions gr) useUntokenizer customUntokenizer gr
   strop = maybe id ($ gr) $ customAsOptVal opts filterString customStringCommand
   br    = oElem showStruct opts

noWrap, fudWrap :: String -> [String]
noWrap = lines
fudWrap = lines . wrapLines 0 ---

displaySState :: CEnv -> SState -> ([String],[String],[(String,String)])
displaySState env state = 
  (prState (stateSState state), msgSState state, menuSState env state)

menuSState :: CEnv -> SState -> [(String,String)]
menuSState env state = if null cs then [("[NO ALTERNATIVE]","")] else cs 
  where
    cs = [(s,c) | (_,(s,c)) <- mkRefineMenuAll env state]

printname :: CEnv -> SState -> G.Fun -> String
printname env state f = case getOptVal opts menuDisplay of
  Just "Abs" -> prQIdent_ f
  Just lang  -> printn lang f
  _ -> prQIdent_ f ---- prTermOpt opts (qq f)
 where
  opts = addOptions (optsSState state) (globalOptions env)
  printn lang f = err id (ifNull (prQIdent_ f) (sstr . head)) $ do
    t  <- lookupPrintname gr mf 
    strsFromTerm t
   where
     sgr = stateGrammarOfLang env (language lang)
     gr  = grammar sgr
     mf  = ciq (cncId sgr) (snd f)

-- * XML printing; does not belong here!

tagsXML :: String -> [[String]] -> [String]
tagsXML t = concatMap (tagXML t)

tagAttrXML :: String -> (String, String) -> [String] -> [String]
tagAttrXML t av ss = mkTagAttrXML t av : map (indent 2) ss ++ [mkEndTagXML t]

tagXML :: String -> [String] -> [String]
tagXML t ss = mkTagXML t : map (indent 2) ss ++ [mkEndTagXML t]

mkTagXML :: String -> String
mkTagXML t = '<':t ++ ">"

mkEndTagXML :: String -> String
mkEndTagXML t = mkTagXML ('/':t)

mkTagAttrsXML :: String -> [(String, String)] -> String
mkTagAttrsXML t avs = '<':t +++ unwords [a++"="++v | (a,v) <- avs] ++">"

mkTagAttrXML :: String -> (String, String) -> String
mkTagAttrXML t av  = mkTagAttrsXML t [av]

