module Commands where

import Operations
import Zipper

import qualified Grammar as G ---- Cat, Fun, Q, QC
import GFC
import CMacros
import Macros (qq)----
import LookAbs
import Look
import Values (loc2treeFocus,tree2exp)----

import GetTree
import API
import ShellState

import qualified Shell
import qualified PShell
import qualified Macros as M
import PrGrammar
import PGrammar
import IOGrammar
import UseIO
import Unicode

import CF
import CFIdent (cat2CFCat, cfCat2Cat)
import Linear
import Randomized
import Editing
import Session
import Custom

import qualified Ident as I
import Option
import Str (sstr) ----

import Random (mkStdGen, newStdGen)
import Monad (liftM2)
import List (intersperse)

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
 | CRefineWithTree String
 | CRefineWithClip Int
 | CRefineWithAtom String
 | CRefineParse String
 | CWrapWithFun (G.Fun,Int)
 | CChangeHead G.Fun
 | CPeelHead
 | CAlphaConvert String
 | CRefineRandom
 | CSelectCand Int
 | CTermCommand  String
 | CAddOption Option
 | CRemoveOption Option
 | CDelete
 | CAddClip
 | CUndo
 | CView
 | CMenu
 | CQuit
 | CHelp  (CEnv -> String) -- help message depends on grammar and interface
 | CError -- syntax error in command
 | CVoid  -- empty command, e.g. just <enter>

-- commands affecting CEnv
 | CCEnvImport String
 | CCEnvEmptyAndImport String
 | CCEnvOpenTerm String
 | CCEnvOpenString String
 | CCEnvEmpty

 | CCEnvOn  String
 | CCEnvOff String

 | CCEnvGFShell String

-- other commands using IO
 | CCEnvRefineWithTree String
 | CCEnvRefineParse String

isQuit CQuit = True
isQuit _ = False

-- an abstract environment type

type CEnv    = ShellState

grammarCEnv  = firstStateGrammar
canCEnv  = canModules
concreteCEnv = cncId
abstractCEnv = absId

stdGenCEnv env s = mkStdGen (length (displayJustStateIn env s) * 31 +11) ---

initSStateEnv env = case getOptVal (stateOptions sgr) gStartCat of
  Just cat -> action2commandNext (newCat gr (abs, I.identC cat)) initSState
  _ -> initSState
 where 
   sgr = firstStateGrammar env
   abs = absId sgr
   gr  = stateGrammarST sgr

-- the main function

execCommand :: CEnv -> Command -> SState -> IO (CEnv,SState)
execCommand env c s = case c of

-- these commands do need IO
  CCEnvImport file -> useIOE (env,s) $ do
    st <- shellStateFromFiles opts env file
    return (st,s)

{- ----
  CCEnvEmptyAndImport file -> do
    gr <- optFile2grammar noOptions Nothing file
    let lan = getLangNameOpt noOptions file
    return (updateLanguage file (lan, getStateConcrete gr) 
                 (initWithAbstract (stateAbstract gr) emptyShellState), initSState)
-}

  CCEnvEmpty -> do
    return (emptyShellState, initSState)

  CCEnvGFShell command -> do
    let cs = PShell.pCommandLines command
    (msg,(env',_)) <- Shell.execLines False cs (Shell.initHState env)
    return (env', changeMsg msg s) ----

{- ----
  CCEnvOpenTerm file -> do
    c <- readFileIf file
    let (fs,t) = envAndTerm file c

    env' <- shellStateFromFiles noOptions fs
    return (env', (action2commandNext $ \x -> 
                      (string2treeErr (grammarCEnv env') t x >>= 
                                                      \t -> newTree t x)) s)

  CCEnvOpenString file -> do
    c <- readFileIf file
    let (fs,t) = envAndTerm file c
    env' <- shellStateFromFiles noOptions fs
    let gr   = grammarCEnv env'
        sgr  = firstStateGrammar env'
        agrs = allActiveGrammars env'
        cat  = firstCatOpts (stateOptions sgr) sgr
    state0 <- err (const $ return (stateSState s)) return $
                   newCat gr (cfCat2Cat cat) $ stateSState s
    state1 <- return $ 
                   refineByExps True gr (parseAny agrs cat t) $ changeState state0 s
    return (env', state1)
-}

----  CCEnvOn  name -> return (languageOn  (language name) env,s)
----  CCEnvOff name -> return (languageOff (language name) env,s)

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

   -- format for documents: import lines of form "-- file", then term 
   envAndTerm f s = 
     (map ((initFilePath f ++) . filter (/=' ') . drop 2) fs, unlines ss) where
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
  CWrapWithFun fi    -> action2commandNext $ wrapWithFun cgr fi
  CChangeHead f      -> action2commandNext $ changeFunHead cgr f
  CPeelHead          -> action2commandNext $ peelFunHead cgr

  CAlphaConvert s    -> action2commandNext $ \x ->
                          string2varPair s >>= \xy -> alphaConvert cgr xy x

  CRefineWithTree s  -> action2commandNext $ \x -> 
                          (string2treeInState gr s x >>= 
                            \t -> refineWithTree der cgr t x)
  CRefineWithClip i  -> \s -> 
                          let et = getNumberedClip i s
                          in (case et of 
                                Ok t -> refineByTrees der cgr [t] s
                                Bad m -> changeMsg [m] s)

  CRefineParse str   -> \s -> 
                     let cat = cat2CFCat (qualifTop sgr (actCat (stateSState s)))
                         ts = parseAny agrs cat str
                     in (if null ts ---- debug
                           then withMsg [str, "parse failed in cat" +++ show cat]
                           else id) 
                            (refineByTrees der cgr ts) s

  CRefineRandom      -> \s -> action2commandNext
                                (refineRandom (stdGenCEnv env s) 41 cgr) s 

  CSelectCand i      -> selectCand cgr i

  CTermCommand c     -> case c of
                         "paraphrase" -> \s ->
                           replaceByTermCommand der gr c (actTree (stateSState s)) s
----                          "transfer" -> action2commandNext $
----                                       transferSubTree (stateTransferFun sgr) gr
                         _ -> replaceByEditCommand gr c

  CAddOption o       -> changeStOptions (addOption o)
  CRemoveOption o    -> changeStOptions (removeOption o)
  CDelete            -> action2commandNext $ deleteSubTree cgr
  CAddClip           -> \s -> (addtoClip (actTree (stateSState s))) s
  CUndo              -> undoCommand
  CMenu              -> \s -> changeMsg (menuState env s) s
  CView              -> changeView
  CHelp h            -> changeMsg [h env]
  CVoid              -> id
  _                  -> changeMsg ["command not yet implemented"]
 where
   sgr  = firstStateGrammar env 
   agrs = allStateGrammars env ---- allActiveGrammars env
   cgr  = canCEnv env
   gr   = grammarCEnv env
   der  = maybe True not $ caseYesNo (globalOptions env) noDepTypes
          -- if there are dep types, then derived refs;  deptypes is the default
   abs = absId sgr

--


string2varPair :: String -> Err (I.Ident,I.Ident)
string2varPair s = case words s of
  x : y : [] -> liftM2 (,) (string2ident x) (string2ident y)
  _          -> Bad "expected format 'x y'"

-- seen on display

cMenuDisplay :: String -> Command
cMenuDisplay s = CAddOption (menuDisplay s)

newCatMenu env = [(CNewCat (prQIdent c), printname env initSState c) | 
                                  (c,[]) <- allCatsOf (canCEnv env)]

mkRefineMenu :: CEnv -> SState -> [(Command,String)]
mkRefineMenu env sstate = [(c,s) | (c,(s,_)) <- mkRefineMenuAll env sstate]

mkRefineMenuAll :: CEnv -> SState -> [(Command,(String,String))]
mkRefineMenuAll env sstate = 
  case (refinementsState cgr state, candsSState sstate, wrappingsState cgr state) of
    ([],[],wraps) -> 
       [(CWrapWithFun fi, prWrap fit)     | fit@(fi,_) <- wraps] ++
       [(CChangeHead f,   prChangeHead f) | f <- headChangesState cgr state] ++
       [(CPeelHead,    (ifShort "ph" "PeelHead", "ph")) | canPeelState cgr state] ++
       [(CDelete,      (ifShort "d"  "Delete",   "d"))] ++
       [(CAddClip,     (ifShort "ac" "AddClip",  "ac"))]
    (refs,[],_)   -> 
       [(CRefineWithAtom (prRefinement f), prRef t) | t@(f,_) <- refs] ++
       [(CRefineWithClip i, prClip i t) | (i,t) <- possClipsSState gr sstate] 
    (_,cands,_)   -> 
       [(CSelectCand i,   prCand (t,i))    | (t,i) <- zip cands [0..]]

 where
  prRef (f,t) = 
    (ifShort "r" "Refine" +++ prOrLinRef f +++ ifTyped (":" +++ prt t),
     "r" +++ prRefinement f)
  prClip i t =
    (ifShort "rc" "Paste" +++ prOrLinTree t,
     "rc" +++ show i)
  prChangeHead f = 
    (ifShort "ch" "ChangeHead" +++ prOrLinFun f,
     "ch" +++ prQIdent f)
  prWrap ((f,i),t) = 
    (ifShort "w" "Wrap"   +++ prOrLinFun f +++ ifTyped (":" +++ prt t) +++
     ifShort (show i) (prBracket (show i)),
     "w" +++ prQIdent f +++ show i)
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
  prOrLinExp t = prt t ---- 
  prOrLinRef t = case t of
    G.Q m f  ->  printname env sstate (m,f) 
    G.QC m f ->  printname env sstate (m,f) 
    _ -> prt t
  prOrLinFun = printname env sstate
  prOrLinTree t = case getOptVal opts menuDisplay of
    Just "Abs" -> prTermOpt opts $ tree2exp t
    Just lang  -> prQuotedString $ lin lang t
    _ -> prTermOpt opts $ tree2exp t
  lin lang t = optLinearizeTreeVal opts (stateGrammarOfLang env (language lang)) t

-- there are three orthogonal parameters: Abs/[conc], short/long, typed/untyped
-- the default is Abs, long, untyped; the Menus menu changes the parameter

emptyMenuItem = (CVoid,("",""))



---- allStringCommands = snd $ customInfo customStringCommand
termCommandMenu, stringCommandMenu :: [(Command,String)]
termCommandMenu = [(CTermCommand s, s) | s <- allTermCommands]

allTermCommands = snd $ customInfo customEditCommand

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

---- the Boolean is a temporary hack to have two parallel GUIs
displaySStateJavaX :: Bool -> CEnv -> SState -> String
displaySStateJavaX isNew env state = unlines $ tagXML "gfedit" $ concat [
  tagXML "linearizations" (concat 
    [tagAttrXML "lin" ("lang", prLanguage lang) ss | (lang,ss) <- lins]),
  tagXML "tree"           tree,
  tagXML "message"        msg,
  tagXML "menu"           (tagsXML "item" menu')
  ]
 where
  (tree,msg,menu) = displaySState env state
  menu'  = [tagXML "show" [s] ++ tagXML "send" [c] | (s,c) <- menu] 
  (ls,grs) = unzip $ lgrs
  lgrs   = allStateGrammarsWithNames env ---- allActiveStateGrammarsWithNames env
  lins   = (langAbstract, exp) : linAll
  opts   = addOptions (optsSState state)   -- state opts override 
              (addOption (markLin mark) (globalOptions env))
  lin (n,gr) = (n, map uni $ linearizeState noWrap opts gr zipper) where
                  uni = optEncodeUTF8 gr . mkUnicode
  exp    = prprTree $ loc2tree zipper
  zipper = stateSState state
  linAll = map lin lgrs
  gr     = firstStateGrammar env
  mark   = markOptXML -- markOptJava   

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
menuSState env state = [(s,c) | (_,(s,c)) <- mkRefineMenuAll env state]

printname :: CEnv -> SState -> G.Fun -> String
printname env state f = case getOptVal opts menuDisplay of
  Just "Abs" -> prQIdent f
  Just lang  -> printn lang f
  _ -> prTermOpt opts (qq f)
 where
  opts = addOptions (optsSState state) (globalOptions env)
  printn lang f = err id (ifNull (prQIdent f) (sstr . head)) $ do
    t  <- lookupPrintname gr mf 
    strsFromTerm t
   where
     sgr = stateGrammarOfLang env (language lang)
     gr  = grammar sgr
     mf  = ciq (cncId sgr) (snd f)

--- XML printing; does not belong here!

tagsXML t = concatMap (tagXML t)
tagAttrXML t av ss = mkTagAttrXML t av : map (indent 2) ss ++ [mkEndTagXML t]
tagXML t ss = mkTagXML t : map (indent 2) ss ++ [mkEndTagXML t]
mkTagXML t = '<':t ++ ">"
mkEndTagXML t = mkTagXML ('/':t)
mkTagAttrsXML t avs = '<':t +++ unwords [a++"="++v | (a,v) <- avs] ++">"
mkTagAttrXML  t av  = mkTagAttrsXML t [av]

