----------------------------------------------------------------------
-- |
-- Module      : ShellState
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/03/02 14:22:53 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.37 $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module ShellState where

import Operations
import GFC
import AbsGFC
import Macros
import MMacros

import Look
import LookAbs
import ModDeps
import qualified Modules as M
import qualified Grammar as G
import qualified PrGrammar as P
import CF
import CFIdent
import CanonToCF
import Morphology
import Option
import Ident
import Arch (ModTime)

-- peb 25/5-04
-- import CFtoCFG
import qualified ConvertGrammar as Cnv

import List (nub,nubBy)

-- AR 11/11/2001 -- 17/6/2003 (for modules) ---- unfinished

-- | multilingual state with grammars and options
data ShellState = ShSt {
  abstract   :: Maybe Ident ,        -- ^ pointer to actual abstract, if not empty st
  concrete   :: Maybe Ident ,        -- ^ pointer to primary concrete
  concretes  :: [((Ident,Ident),Bool)], -- ^ list of all concretes, and whether active
  canModules :: CanonGrammar ,       -- ^ compiled abstracts and concretes
  srcModules :: G.SourceGrammar ,    -- ^ saved resource modules
  cfs        :: [(Ident,CF)] ,       -- ^ context-free grammars
  pInfos     :: [(Ident,Cnv.PInfo)], -- ^ parser information, peb 18\/6-04
  morphos    :: [(Ident,Morpho)],    -- ^ morphologies
  gloptions  :: Options,             -- ^ global options
  readFiles  :: [(FilePath,ModTime)],-- ^ files read
  absCats    :: [(G.Cat,(G.Context,
                  [(G.Fun,G.Type)],
                  [((G.Fun,Int),G.Type)]))],   -- ^ cats, (their contexts, 
                                               -- functions to them,
                                               -- functions on them)
  statistics :: [Statistics]         -- ^ statistics on grammars
  }                             

data Statistics = 
    StDepTypes Bool        -- ^ whether there are dependent types      
  | StBoundVars [G.Cat]    -- ^ which categories have bound variables
  ---                      -- etc
   deriving (Eq,Ord)

emptyShellState :: ShellState
emptyShellState = ShSt {
  abstract   = Nothing,
  concrete   = Nothing,
  concretes  = [],
  canModules = M.emptyMGrammar,
  srcModules = M.emptyMGrammar,
  cfs        = [],
  pInfos     = [], -- peb 18/6
  morphos    = [],
  gloptions  = noOptions,
  readFiles  = [],
  absCats    = [],
  statistics = []
  }

optInitShellState :: Options -> ShellState
optInitShellState os = addGlobalOptions os emptyShellState

type Language = Ident

language :: String -> Language
language = identC

prLanguage :: Language -> String
prLanguage = prIdent

-- | grammar for one language in a state, comprising its abs and cnc
data StateGrammar = StGr {
  absId   :: Ident,
  cncId   :: Ident,
  grammar :: CanonGrammar,
  cf      :: CF,
  pInfo   :: Cnv.PInfo, -- peb 8/6
  morpho  :: Morpho,
  loptions :: Options
  }

emptyStateGrammar :: StateGrammar
emptyStateGrammar = StGr {
  absId   = identC "#EMPTY", ---
  cncId   = identC "#EMPTY", ---
  grammar = M.emptyMGrammar,
  cf      = emptyCF,
  pInfo   = Cnv.emptyPInfo, -- peb 18/6
  morpho  = emptyMorpho,
  loptions = noOptions
  }

-- analysing shell grammar into parts

stateGrammarST    :: StateGrammar -> CanonGrammar
stateCF           :: StateGrammar -> CF
statePInfo        :: StateGrammar -> Cnv.PInfo
stateMorpho       :: StateGrammar -> Morpho
stateOptions      :: StateGrammar -> Options
stateGrammarWords :: StateGrammar -> [String]

stateGrammarST = grammar
stateCF        = cf
statePInfo     = pInfo
stateMorpho    = morpho
stateOptions   = loptions
stateGrammarWords = allMorphoWords . stateMorpho

cncModuleIdST :: StateGrammar -> CanonGrammar
cncModuleIdST = stateGrammarST

-- | form a shell state from a canonical grammar
grammar2shellState :: Options -> (CanonGrammar, G.SourceGrammar) -> Err ShellState 
grammar2shellState opts (gr,sgr) = 
  updateShellState opts Nothing emptyShellState ((0,sgr,gr),[]) --- is 0 safe?

-- | update a shell state from a canonical grammar
updateShellState :: Options -> Maybe Ident -> ShellState -> 
                    ((Int,G.SourceGrammar,CanonGrammar),[(FilePath,ModTime)]) ->
               ---- (CanonGrammar,(G.SourceGrammar,[(FilePath,ModTime)])) -> 
                    Err ShellState 
updateShellState opts mcnc sh ((_,sgr,gr),rts) = do 
  let cgr0 = M.updateMGrammar (canModules sh) gr
  a' <- return $ case mcnc of
    Just cnc -> err (const Nothing) Just $ M.abstractOfConcrete cgr0 cnc
    _ -> M.greatestAbstract cgr0
  abstr0 <- case abstract sh of
    Just a -> do
      -- test that abstract is compatible --- unsafe exception for old? 
      --- if True oElem showOld opts then return () else
      case a' of
        Nothing -> return ()
        Just b -> testErr (a==b) ("expected abstract" +++ P.prt a +++ "but found " +++ P.prt b) 
      return $ Just a
    _ -> return a'
  let cgr = filterAbstracts abstr0 cgr0
  let concrs = maybe [] (M.allConcretes cgr) abstr0
      concr0 = ifNull Nothing (return . head) concrs
      notInrts f = notElem f $ map fst rts
  cfs <- mapM (canon2cf opts cgr) concrs --- would not need to update all...

  let pinfos = map (Cnv.pInfo cgr) concrs  -- peb 18/6

  let funs = funRulesOf cgr
  let cats = allCatsOf cgr
  let csi  = [(c,(co,
                  [(fun,typ) | (fun,typ) <- funs, compatType tc typ], 
                  funsOnTypeFs compatType funs tc))
                                      | (c,co) <- cats, let tc = cat2val co c]
  let deps = True ---- not $ null $ allDepCats cgr
  let binds = [] ---- allCatsWithBind cgr 
  let src = M.updateMGrammar (srcModules sh) sgr

  return $ ShSt {
    abstract   = abstr0, 
    concrete   = concr0, 
    concretes  = zip (zip concrs concrs) (repeat True),
    canModules = cgr,
    srcModules = src,
    cfs        = zip concrs cfs,
    pInfos     = zip concrs pinfos, -- peb 8/6
    morphos    = zip concrs (map (mkMorpho cgr) concrs),
    gloptions  = gloptions sh, --- opts, -- this would be command-line options
    readFiles  = [ft | ft@(f,_) <- readFiles sh, notInrts f] ++ rts,
    absCats    = csi,
    statistics = [StDepTypes deps,StBoundVars binds]
    }            

prShellStateInfo :: ShellState -> String
prShellStateInfo sh = unlines [
  "main abstract :    " +++ abstractName sh,
  "main concrete :    " +++ maybe "(none)" P.prt (concrete sh),
  "all concretes :    " +++ unwords (map (P.prt . fst) (map fst (concretes sh))),
  "canonical modules :" +++ unwords (map (P.prt .fst) (M.modules (canModules sh))),
  "source modules :   " +++ unwords (map (P.prt .fst) (M.modules (srcModules sh))),
  "global options :   " +++ prOpts (gloptions sh)
  ]

{- ---- should be called from IOGrammar *before* compiling
testSameAbstract :: ShellState -> Maybe Ident -> Err (Maybe Ident)
testSameAbstract sh mcnc = do
  abstr0 <- case abstract sh of
    Just a -> do
      -- test that abstract is compatible --- unsafe exception for old? 
      --- if True oElem showOld opts then return () else
      case a' of
        Nothing -> return ()
        Just b -> testErr (a==b) ("expected abstract" +++ P.prt a +++ "but found " +++ P.prt b) 
      return $ Just a
    _ -> return a'
-}

abstractName :: ShellState -> String
abstractName sh = maybe "(none)" P.prt (abstract sh)

-- | throw away those abstracts that are not needed --- could be more aggressive
filterAbstracts :: Maybe Ident -> CanonGrammar -> CanonGrammar
filterAbstracts abstr cgr = M.MGrammar (nubBy (\x y -> fst x == fst y) [m | m <- ms, needed m]) where
  ms = M.modules cgr
  needed (i,_) = case abstr of
    Just a -> elem i $ needs a
    _ -> True
  needs a = [i | (i,M.ModMod m) <- ms, not (M.isModAbs m) || dep i a]
  dep i a = elem i (ext mse a)
  mse = [(i,me) | (i,M.ModMod m) <- ms, M.isModAbs m, me <- [M.extends m]]
  ext es a = case lookup a es of
    Just e -> a : concatMap (ext es) e  ---- FIX multiple exts
    _ -> []


purgeShellState :: ShellState -> ShellState
purgeShellState sh = ShSt {
  abstract   = abstract sh,
  concrete   = concrete sh,
  concretes  = [((a,i),b) | ((a,i),b) <- concretes sh, elem i needed],
  canModules = M.MGrammar $ purge $ M.modules $ canModules sh,
  srcModules = M.emptyMGrammar,
  cfs        = cfs sh,
  pInfos     = pInfos sh,
  morphos    = morphos sh,
  gloptions  = gloptions sh,
  readFiles  = [],
  absCats    = absCats sh,
  statistics = statistics sh
  }
 where
   needed = nub $ concatMap (requiredCanModules (canModules sh)) acncs
   purge = nubBy (\x y -> fst x == fst y) . filter (flip elem needed . fst)
   acncs = maybe [] singleton (abstract sh) ++ map (snd . fst) (concretes sh)

changeMain :: Maybe Ident -> ShellState -> Err ShellState
changeMain Nothing (ShSt _ _ cs ms ss cfs pis mos os rs acs s) = 
  return (ShSt Nothing Nothing [] ms ss cfs pis mos os rs acs s)
changeMain (Just c) st@(ShSt _ _ cs ms ss cfs pis mos os rs acs s) = 
  case lookup c (M.modules ms) of 
    Just _ -> do
      a   <- M.abstractOfConcrete ms c
      let cas = M.allConcretes ms a
      let cs' = [((c,c),True) | c <- cas]
      return (ShSt (Just a) (Just c) cs' ms ss cfs pis mos os rs acs s) 
    _ -> P.prtBad "The state has no concrete syntax named" c

-- | form just one state grammar, if unique, from a canonical grammar
grammar2stateGrammar :: Options -> CanonGrammar -> Err StateGrammar 
grammar2stateGrammar opts gr = do 
  st    <- grammar2shellState opts (gr,M.emptyMGrammar)
  concr <- maybeErr "no concrete syntax" $ concrete st 
  return $ stateGrammarOfLang st concr

resourceOfShellState :: ShellState -> Maybe Ident
resourceOfShellState = M.greatestResource . srcModules

qualifTop :: StateGrammar -> G.QIdent -> G.QIdent
qualifTop gr (_,c) = (absId gr,c)

stateGrammarOfLang :: ShellState -> Language -> StateGrammar
stateGrammarOfLang st l = StGr {
  absId    = maybe (identC "Abs") id (abstract st), ---
  cncId    = l,
  grammar  = can,
  cf       = maybe emptyCF id (lookup l (cfs st)),
  pInfo    = maybe Cnv.emptyPInfo id (lookup l (pInfos st)), -- peb 18/6
  morpho   = maybe emptyMorpho id (lookup l (morphos st)),
  loptions = errVal noOptions $ lookupOptionsCan can
  }
 where
   allCan = canModules st
   can = M.partOfGrammar allCan 
           (l, maybe M.emptyModInfo id (lookup l (M.modules allCan)))

grammarOfLang :: ShellState -> Language -> CanonGrammar
cfOfLang      :: ShellState -> Language -> CF
morphoOfLang  :: ShellState -> Language -> Morpho
optionsOfLang :: ShellState -> Language -> Options

grammarOfLang st = stateGrammarST . stateGrammarOfLang st
cfOfLang st      = stateCF        . stateGrammarOfLang st
morphoOfLang st  = stateMorpho    . stateGrammarOfLang st
optionsOfLang st = stateOptions   . stateGrammarOfLang st

-- | the last introduced grammar, stored in options, is the default for operations
firstStateGrammar :: ShellState -> StateGrammar
firstStateGrammar st = errVal (stateAbstractGrammar st) $ do
  concr <- maybeErr "no concrete syntax" $ concrete st 
  return $ stateGrammarOfLang st concr

mkStateGrammar :: ShellState -> Language -> StateGrammar
mkStateGrammar = stateGrammarOfLang

stateAbstractGrammar :: ShellState -> StateGrammar
stateAbstractGrammar st = StGr {
  absId   = maybe (identC "Abs") id (abstract st), ---
  cncId   = identC "#Cnc", ---
  grammar = canModules st, ---- only abstarct ones
  cf      = emptyCF,
  pInfo   = Cnv.emptyPInfo, -- peb 18/6
  morpho  = emptyMorpho,
  loptions = gloptions st ----
  }


-- analysing shell state into parts

globalOptions                   :: ShellState -> Options
allLanguages                    :: ShellState -> [Language]
allCategories                   :: ShellState -> [G.Cat]
allStateGrammars                :: ShellState -> [StateGrammar]
allStateGrammarsWithNames       :: ShellState -> [(Language, StateGrammar)]
allGrammarFileNames             :: ShellState -> [String]
allActiveStateGrammarsWithNames :: ShellState -> [(Language, StateGrammar)]
allActiveGrammars               :: ShellState -> [StateGrammar]

globalOptions = gloptions
allLanguages  = map (fst . fst) . concretes
allCategories = map fst . allCatsOf . canModules

allStateGrammars = map snd . allStateGrammarsWithNames

allStateGrammarsWithNames st = 
  [(c, mkStateGrammar st c) | ((c,_),_) <- concretes st]

allGrammarFileNames st = [prLanguage c ++ ".gf" | ((c,_),_) <- concretes st] ---

allActiveStateGrammarsWithNames st =   
  [(c, mkStateGrammar st c) | ((c,_),True) <- concretes st]

allActiveGrammars = map snd . allActiveStateGrammarsWithNames

{-
allGrammarSTs = map stateGrammarST . allStateGrammars
allCFs        = map stateCF        . allStateGrammars

firstGrammarST  = stateGrammarST . firstStateGrammar
firstAbstractST = abstractOf . firstGrammarST
firstConcreteST = concreteOf . firstGrammarST
-}
-- command-line option -lang=foo overrides the actual grammar in state
grammarOfOptState :: Options -> ShellState -> StateGrammar
grammarOfOptState opts st = 
  maybe (firstStateGrammar st) (stateGrammarOfLang st . language) $ 
                                               getOptVal opts useLanguage

languageOfOptState :: Options -> ShellState -> Maybe Language
languageOfOptState opts st = 
  maybe (concrete st) (return . language) $ getOptVal opts useLanguage

-- | command-line option -cat=foo overrides the possible start cat of a grammar
firstCatOpts :: Options -> StateGrammar -> CFCat
firstCatOpts opts sgr = 
  maybe (stateFirstCat sgr) (string2CFCat (P.prt (absId sgr))) $ 
    getOptVal opts firstCat

-- | the first cat for random generation
firstAbsCat :: Options -> StateGrammar -> G.QIdent
firstAbsCat opts = cfCat2Cat . firstCatOpts opts

-- | a grammar can have start category as option startcat=foo ; default is S 
stateFirstCat :: StateGrammar -> CFCat
stateFirstCat sgr =
  maybe (string2CFCat a "S") (string2CFCat a) $ 
  getOptVal (stateOptions sgr) gStartCat
 where 
   a = P.prt (absId sgr)

{-
-- command-line option -cat=foo overrides the possible start cat of a grammar
stateTransferFun :: StateGrammar -> Maybe Fun
stateTransferFun sgr = getOptVal (stateOptions sgr) transferFun >>= return . zIdent

stateConcrete = concreteOf . stateGrammarST
stateAbstract = abstractOf . stateGrammarST

maybeStateAbstract (ShSt (ma,_,_)) = ma
hasStateAbstract = maybe False (const True) . maybeStateAbstract
abstractOfState = maybe emptyAbstractST id . maybeStateAbstract
-}

stateIsWord :: StateGrammar -> String -> Bool
stateIsWord sg = isKnownWord (stateMorpho sg)



{-

-- getting info on a language
existLang :: ShellState -> Language -> Bool
existLang st lang = elem lang (allLanguages st)

stateConcreteOfLang :: ShellState -> Language -> StateConcrete
stateConcreteOfLang (ShSt (_,gs,_)) lang = 
  maybe emptyStateConcrete snd $ lookup lang gs

fileOfLang :: ShellState -> Language -> FilePath
fileOfLang (ShSt (_,gs,_)) lang = 
  maybe nonExistingLangFile (fst .fst) $ lookup lang gs

nonExistingLangFile = "NON-EXISTING LANGUAGE" ---


allLangOptions st lang = unionOptions (optionsOfLang st lang) (globalOptions st)

-- construct state

stateGrammar st cf mo opts = StGr ((st,cf,mo),opts)

initShellState ab fs gs opts = 
  ShSt (Just ab, [(getLangName f, ((f,True),g)) | (f,g) <- zip fs gs], opts)
emptyInitShellState opts     = ShSt (Nothing, [], opts)

-- the second-last part of a file name is the default language name
getLangName :: String -> Language
getLangName file = language (if notElem '.' file then file else langname) where
 elif     = reverse file
 xiferp   = tail (dropWhile (/='.') elif)
 langname = reverse (takeWhile (flip notElem "./") xiferp)

-- option -language=foo overrides the default language name
getLangNameOpt :: Options -> String -> Language
getLangNameOpt opts file = 
  maybe (getLangName file) language $ getOptVal opts useLanguage
-}
-- modify state

type ShellStateOper = ShellState -> ShellState
type ShellStateOperErr = ShellState -> Err ShellState

reinitShellState :: ShellStateOper
reinitShellState = const emptyShellState

languageOn, languageOff :: Language -> ShellStateOper
languageOn  = languageOnOff True
languageOff = languageOnOff False

languageOnOff :: Bool -> Language -> ShellStateOper
languageOnOff b lang (ShSt a c cs cg sg cfs pinfos ms os fs cats sts) =
  ShSt a c cs' cg sg cfs pinfos ms os fs cats sts where
  cs' = [if lang==l then ((l,c),b) else i | i@((l,c),_) <- cs]

{-
updateLanguage :: FilePath -> (Language, StateConcrete) -> ShellStateOper
updateLanguage file (lang,gr) (ShSt (ab,gs,os)) = 
  ShSt (ab, updateAssoc (lang,((file,True),gr)) gs, os') where
    os' = changeOptVal os useLanguage (prLanguage lang) -- actualizes the new lang

initWithAbstract :: AbstractST -> ShellStateOper
initWithAbstract ab st@(ShSt (ma,cs,os)) = 
  maybe (ShSt (Just ab,cs,os)) (const st) ma

removeLanguage :: Language -> ShellStateOper
removeLanguage lang (ShSt (ab,gs,os)) = ShSt (ab,removeAssoc lang gs, os)
-}
changeOptions :: (Options -> Options) -> ShellStateOper
changeOptions f (ShSt a c cs can src cfs pinfos ms os ff ts ss) = 
  ShSt a c cs can src cfs pinfos ms (f os) ff ts ss

changeModTimes :: [(FilePath,ModTime)] -> ShellStateOper
changeModTimes mfs (ShSt a c cs can src cfs pinfos ms os ff ts ss) = 
  ShSt a c cs can src cfs pinfos ms os ff' ts ss
 where
   ff' = mfs ++ [mf | mf@(f,_) <- ff, notElem f (map fst mfs)]

addGlobalOptions :: Options -> ShellStateOper
addGlobalOptions = changeOptions . addOptions

removeGlobalOptions :: Options -> ShellStateOper
removeGlobalOptions = changeOptions . removeOptions

