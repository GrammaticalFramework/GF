----------------------------------------------------------------------
-- |
-- Module      : ShellState
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/11/14 16:03:41 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.53 $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module GF.Compile.ShellState where

import GF.Data.Operations
import GF.Canon.GFC
import GF.Canon.AbsGFC
import GF.Grammar.Macros
import GF.Grammar.MMacros

import GF.Canon.Look
import GF.Canon.Subexpressions
import GF.Grammar.LookAbs
import GF.Compile.ModDeps
import qualified GF.Infra.Modules as M
import qualified GF.Grammar.Grammar as G
import qualified GF.Grammar.PrGrammar as P
import GF.CF.CF
import GF.CF.CFIdent
import GF.CF.CanonToCF
import GF.UseGrammar.Morphology
import GF.Probabilistic.Probabilistic
import GF.Compile.NoParse
import GF.Infra.Option
import GF.Infra.Ident
import GF.System.Arch (ModTime)

import qualified Transfer.InterpreterAPI as T

import qualified GF.OldParsing.ConvertGrammar as CnvOld -- OBSOLETE
import qualified GF.Conversion.GFC as Cnv
import qualified GF.Parsing.GFC as Prs

import Data.List (nub,nubBy)

-- AR 11/11/2001 -- 17/6/2003 (for modules) ---- unfinished

-- | multilingual state with grammars and options
data ShellState = ShSt {
  abstract   :: Maybe Ident ,        -- ^ pointer to actual abstract, if not empty st
  concrete   :: Maybe Ident ,        -- ^ pointer to primary concrete
  concretes  :: [((Ident,Ident),Bool)], -- ^ list of all concretes, and whether active
  canModules :: CanonGrammar ,       -- ^ compiled abstracts and concretes
  srcModules :: G.SourceGrammar ,    -- ^ saved resource modules
  cfs        :: [(Ident,CF)] ,       -- ^ context-free grammars (small, no parameters, very over-generating)
  abstracts  :: [(Ident,[Ident])],   -- ^ abstracts and their associated concretes
  mcfgs      :: [(Ident, Cnv.MGrammar)], -- ^ MCFG, converted according to Ljunglöf (2004, ch 3)
  cfgs       :: [(Ident, Cnv.CGrammar)], -- ^ CFG, converted from mcfg 
                                         -- (large, with parameters, no-so overgenerating)
  pInfos     :: [(Ident, Prs.PInfo)], -- ^ parsing information (compiled mcfg&cfg grammars)
  morphos    :: [(Ident,Morpho)],    -- ^ morphologies
  probss     :: [(Ident,Probs)],     -- ^ probability distributions
  gloptions  :: Options,             -- ^ global options
  readFiles  :: [(FilePath,ModTime)],-- ^ files read
  absCats    :: [(G.Cat,(G.Context,
                  [(G.Fun,G.Type)],
                  [((G.Fun,Int),G.Type)]))],   -- ^ cats, (their contexts, 
                                               -- functions to them,
                                               -- functions on them)
  statistics :: [Statistics],        -- ^ statistics on grammars
  transfers  :: [(Ident,T.Env)]      -- ^ transfer modules
  }                             

actualConcretes :: ShellState -> [((Ident,Ident),Bool)]
actualConcretes sh = nub [((c,c),b) | 
  Just a <- [abstract sh],
  c <- concretesOfAbstract sh a,
  let b = True -----
  ]

concretesOfAbstract :: ShellState -> Ident -> [Ident]
concretesOfAbstract sh a = [c | (b,cs) <- abstracts sh, b == a, c <- cs]

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
  abstracts  = [],
  mcfgs      = [],
  cfgs       = [],
  pInfos     = [],
  morphos    = [],
  probss     = [],
  gloptions  = noOptions,
  readFiles  = [],
  absCats    = [],
  statistics = [],
  transfers  = []
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
  absId    :: Ident,
  cncId    :: Ident,
  grammar  :: CanonGrammar,
  cf       :: CF,
  mcfg     :: Cnv.MGrammar,
  cfg      :: Cnv.CGrammar,
  pInfo    :: Prs.PInfo,
  morpho   :: Morpho,
  probs    :: Probs,
  loptions :: Options
  }

emptyStateGrammar :: StateGrammar
emptyStateGrammar = StGr {
  absId    = identC "#EMPTY", ---
  cncId    = identC "#EMPTY", ---
  grammar  = M.emptyMGrammar,
  cf       = emptyCF,
  mcfg     = [],
  cfg      = [],
  pInfo    = Prs.buildPInfo [] [],
  morpho   = emptyMorpho,
  probs    = emptyProbs,
  loptions = noOptions
  }

-- analysing shell grammar into parts

stateGrammarST    :: StateGrammar -> CanonGrammar
stateCF           :: StateGrammar -> CF
stateMCFG         :: StateGrammar -> Cnv.MGrammar
stateCFG          :: StateGrammar -> Cnv.CGrammar
statePInfo        :: StateGrammar -> Prs.PInfo
stateMorpho       :: StateGrammar -> Morpho
stateProbs        :: StateGrammar -> Probs
stateOptions      :: StateGrammar -> Options
stateGrammarWords :: StateGrammar -> [String]
stateGrammarLang  :: StateGrammar -> (CanonGrammar, Ident)

stateGrammarST = grammar
stateCF        = cf
stateMCFG      = mcfg
stateCFG       = cfg
statePInfo     = pInfo
stateMorpho    = morpho
stateProbs     = probs
stateOptions   = loptions
stateGrammarWords = allMorphoWords . stateMorpho
stateGrammarLang st = (grammar st, cncId st)

cncModuleIdST :: StateGrammar -> CanonGrammar
cncModuleIdST = stateGrammarST

-- | form a shell state from a canonical grammar
grammar2shellState :: Options -> (CanonGrammar, G.SourceGrammar) -> Err ShellState 
grammar2shellState opts (gr,sgr) = 
  updateShellState opts doParseAll Nothing emptyShellState ((0,sgr,gr),[]) --- is 0 safe?

-- | update a shell state from a canonical grammar
updateShellState :: Options -> NoParse -> Maybe Ident -> ShellState -> 
                    ((Int,G.SourceGrammar,CanonGrammar),[(FilePath,ModTime)]) ->
               ---- (CanonGrammar,(G.SourceGrammar,[(FilePath,ModTime)])) -> 
                    Err ShellState 
updateShellState opts ign mcnc sh ((_,sgr,gr),rts) = do 
  let cgr0 = M.updateMGrammar (canModules sh) gr

  -- a0 = abstract of old state
  -- a1 = abstract of compiled grammar

  let a0 = abstract sh
  a1 <- return $ case mcnc of
    Just cnc -> err (const Nothing) Just $ M.abstractOfConcrete cgr0 cnc
    _ -> M.greatestAbstract cgr0

  -- abstr0 = a1 if it exists

  let (abstr0,isNew) = case (a0,a1) of
        (Just a,  Just b) | a /= b -> (a1, True)
        (Nothing, Just _)          -> (a1, True)
        _                          -> (a0, False)

  let concrs0 = maybe [] (M.allConcretes cgr0) abstr0

  let abstrs = nubBy (\ (x,_) (y,_) -> x == y) $ 
               maybe id (\a -> ((a,concrs0):)) abstr0 $ abstracts sh

  let cgr = cgr0 ---- filterAbstracts (map fst abstrs) cgr0

  let concrs = nub $ concrs0 ++ map (snd . fst) (concretes sh)
      concr0 = ifNull Nothing (return . head) concrs
      notInrts f = notElem f $ map fst rts
      subcgr = unSubelimCanon cgr
  cf's <- if oElem noCF opts
            then return $ map snd $ cfs sh
            else mapM (canon2cf opts ign subcgr) concrs --- why need to update all...

  let morphos = map (mkMorpho subcgr) concrs
  let probss = [] -----


  let fromGFC       = snd . snd . Cnv.convertGFC opts
      (mcfgs, cfgs) = unzip $ map (curry fromGFC cgr) concrs 
      pInfos        = zipWith Prs.buildPInfo mcfgs cfgs

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
    cfs        = zip concrs cf's,
    abstracts  = abstrs,
    mcfgs      = zip concrs mcfgs,
    cfgs       = zip concrs cfgs,
    pInfos     = zip concrs pInfos,
    morphos    = zip concrs morphos,
    probss     = zip concrs probss,
    gloptions  = gloptions sh, --- opts, -- this would be command-line options
    readFiles  = [ft | ft@(f,_) <- readFiles sh, notInrts f] ++ rts,
    absCats    = csi,
    statistics = [StDepTypes deps,StBoundVars binds],
    transfers  = transfers sh
    }            

prShellStateInfo :: ShellState -> String
prShellStateInfo sh = unlines [
  "main abstract :    " +++ abstractName sh,
  "main concrete :    " +++ maybe "(none)" P.prt (concrete sh),
  "actual concretes : " +++ unwords (map (P.prt . fst . fst) (actualConcretes sh)),
  "all abstracts :    " +++ unwords (map (P.prt . fst) (abstracts sh)),
  "all concretes :    " +++ unwords (map (P.prt . fst . fst) (concretes sh)),
  "canonical modules :" +++ unwords (map (P.prt .fst) (M.modules (canModules sh))),
  "source modules :   " +++ unwords (map (P.prt .fst) (M.modules (srcModules sh))),
  "global options :   " +++ prOpts (gloptions sh),
  "transfer modules : " +++ unwords (map (P.prt . fst) (transfers sh))
  ]

abstractName :: ShellState -> String
abstractName sh = maybe "(none)" P.prt (abstract sh)

-- | throw away those abstracts that are not needed --- could be more aggressive
filterAbstracts :: [Ident] -> CanonGrammar -> CanonGrammar
filterAbstracts absts cgr = M.MGrammar (nubBy (\x y -> fst x == fst y) [m | m <- ms, needed m]) where
  ms = M.modules cgr
  needed (i,_) = elem i needs
  needs   = [i | (i,M.ModMod m) <- ms, not (M.isModAbs m) || any (dep i) absts]
  dep i a = elem i (ext mse a)
  mse = [(i,me) | (i,M.ModMod m) <- ms, M.isModAbs m, me <- [M.extends m]]
  ext es a = case lookup a es of
    Just e -> a : concatMap (ext es) e  ---- FIX multiple exts
    _ -> []

purgeShellState :: ShellState -> ShellState
purgeShellState sh = ShSt {
  abstract   = abstr,
  concrete   = concrete sh,
  concretes  = concrs,
  canModules = M.MGrammar $ purge $ M.modules $ canModules sh,
  srcModules = M.emptyMGrammar,
  cfs        = cfs sh,
  abstracts  = maybe [] (\a -> [(a,map (snd . fst) concrs)]) abstr,
  mcfgs      = mcfgs sh,
  cfgs       = cfgs sh,
  pInfos     = pInfos sh,
  morphos    = morphos sh,
  probss     = probss sh,
  gloptions  = gloptions sh,
  readFiles  = [],
  absCats    = absCats sh,
  statistics = statistics sh,
  transfers  = transfers sh
  }
 where
   abstr = abstract sh
   concrs = [((a,i),b) | ((a,i),b) <- concretes sh, elem i needed]
   isSingle = length (abstracts sh) == 1
   needed = nub $ concatMap (requiredCanModules isSingle (canModules sh)) acncs
   purge = nubBy (\x y -> fst x == fst y) . filter (flip elem needed . fst)
   acncs = maybe [] singleton abstr ++ map (snd . fst) (actualConcretes sh)

changeMain :: Maybe Ident -> ShellState -> Err ShellState
changeMain Nothing (ShSt _ _ cs ms ss cfs old_pis mcfgs cfgs pinfos mos pbs os rs acs s trs) = 
  return (ShSt Nothing Nothing [] ms ss cfs old_pis mcfgs cfgs pinfos mos pbs os rs acs s trs)
changeMain 
  (Just c) st@(ShSt _ _ cs ms ss cfs old_pis mcfgs cfgs pinfos mos pbs os rs acs s trs) = 
   case lookup c (M.modules ms) of 
    Just _ -> do
      a   <- M.abstractOfConcrete ms c
      let cas = M.allConcretes ms a
      let cs' = [((c,c),True) | c <- cas]
      return (ShSt (Just a) (Just c) cs' ms ss cfs old_pis mcfgs cfgs
        pinfos mos pbs os rs acs s trs) 
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
stateGrammarOfLang = stateGrammarOfLangOpt True

stateGrammarOfLangOpt :: Bool -> ShellState -> Language -> StateGrammar
stateGrammarOfLangOpt purg st0 l = StGr {
  absId    = err (const (identC "Abs")) id  $ M.abstractOfConcrete allCan l, ---
  cncId    = l,
  grammar  = allCan,
  cf       = maybe emptyCF id (lookup l (cfs st)),
  mcfg     = maybe [] id $ lookup l $ mcfgs st,
  cfg      = maybe [] id $ lookup l $ cfgs st,
  pInfo    = maybe (Prs.buildPInfo [] []) id $ lookup l $ pInfos st,
  morpho   = maybe emptyMorpho id (lookup l (morphos st)),
  probs    = maybe emptyProbs id (lookup l (probss st)),
  loptions = errVal noOptions $ lookupOptionsCan allCan
  }
 where
   st = (if purg then purgeShellState else id) $ errVal st0 $ changeMain (Just l) st0
   allCan = canModules st

grammarOfLang :: ShellState -> Language -> CanonGrammar
cfOfLang      :: ShellState -> Language -> CF
morphoOfLang  :: ShellState -> Language -> Morpho
probsOfLang   :: ShellState -> Language -> Probs
optionsOfLang :: ShellState -> Language -> Options

grammarOfLang st = stateGrammarST . stateGrammarOfLang st
cfOfLang st      = stateCF        . stateGrammarOfLang st
morphoOfLang st  = stateMorpho    . stateGrammarOfLang st
probsOfLang st   = stateProbs     . stateGrammarOfLang st
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
  absId    = maybe (identC "Abs") id (abstract st), ---
  cncId    = identC "#Cnc", ---
  grammar  = canModules st, ---- only abstarct ones
  cf       = emptyCF,
  mcfg     = [],
  cfg      = [],
  pInfo    = Prs.buildPInfo [] [],
  morpho   = emptyMorpho,
  probs    = emptyProbs,
  loptions = gloptions st ----
  }


-- analysing shell state into parts

globalOptions                   :: ShellState -> Options
allLanguages                    :: ShellState -> [Language]
allTransfers                    :: ShellState -> [Ident]
allCategories                   :: ShellState -> [G.Cat]
allStateGrammars                :: ShellState -> [StateGrammar]
allStateGrammarsWithNames       :: ShellState -> [(Language, StateGrammar)]
allGrammarFileNames             :: ShellState -> [String]
allActiveStateGrammarsWithNames :: ShellState -> [(Language, StateGrammar)]
allActiveGrammars               :: ShellState -> [StateGrammar]

globalOptions = gloptions
--allLanguages  = map (fst . fst) . concretes
allLanguages  = map (snd . fst) . actualConcretes
allTransfers  = map fst . transfers
allCategories = map fst . allCatsOf . canModules

allStateGrammars = map snd . allStateGrammarsWithNames

allStateGrammarsWithNames st = 
  [(c, mkStateGrammar st c) | ((c,_),_) <- actualConcretes st]

allGrammarFileNames st = [prLanguage c ++ ".gf" | ((c,_),_) <- actualConcretes st]

allActiveStateGrammarsWithNames st =   
  [(c, mkStateGrammar st c) | ((c,_),True) <- concretes st] --- actual

allActiveGrammars = map snd . allActiveStateGrammarsWithNames

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

stateIsWord :: StateGrammar -> String -> Bool
stateIsWord sg = isKnownWord (stateMorpho sg)

addProbs :: (Ident,Probs) -> ShellState -> Err ShellState
addProbs ip@(lang,probs) sh = do
  let gr = grammarOfLang sh lang
  probs' <- checkGrammarProbs gr probs
  let pbs' = (lang,probs') : filter ((/= lang) . fst) (probss sh)
  return $ sh{probss = pbs'}

addTransfer :: (Ident,T.Env) -> ShellState -> ShellState
addTransfer it@(i,_) sh = 
  sh {transfers = it : filter ((/= i) . fst) (transfers sh)}

-- modify state

type ShellStateOper = ShellState -> ShellState
type ShellStateOperErr = ShellState -> Err ShellState

reinitShellState :: ShellStateOper
reinitShellState = const emptyShellState

languageOn, languageOff :: Language -> ShellStateOper
languageOn  = languageOnOff True
languageOff = languageOnOff False

languageOnOff :: Bool -> Language -> ShellStateOper
---                                         __________ this is OBSOLETE
languageOnOff b lang sh = sh {concretes = cs'} where
  cs' = [if lang==l then (lc,b) else i | i@(lc@(l,c),_) <- concretes sh]

changeOptions :: (Options -> Options) -> ShellStateOper
---                                      __________ this is OBSOLETE
changeOptions f sh = sh {gloptions = f (gloptions sh)}

changeModTimes :: [(FilePath,ModTime)] -> ShellStateOper
---                                         __________ this is OBSOLETE
changeModTimes mfs
 (ShSt a c cs can src cfs old_pinfos mcfgs cfgs pinfos ms pbs os ff ts ss trs) = 
  ShSt a c cs can src cfs old_pinfos mcfgs cfgs pinfos ms pbs os ff' ts ss trs
 where
   ff' = mfs ++ [mf | mf@(f,_) <- ff, notElem f (map fst mfs)]

addGlobalOptions :: Options -> ShellStateOper
addGlobalOptions = changeOptions . addOptions

removeGlobalOptions :: Options -> ShellStateOper
removeGlobalOptions = changeOptions . removeOptions

