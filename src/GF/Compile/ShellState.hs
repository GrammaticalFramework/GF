module ShellState where

import Operations
import GFC
import AbsGFC
import Macros
import MMacros

import Look
import LookAbs
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

-- AR 11/11/2001 -- 17/6/2003 (for modules) ---- unfinished

-- multilingual state with grammars and options
data ShellState = ShSt {
  abstract   :: Maybe Ident ,        -- pointer to actual abstract, if not empty st
  concrete   :: Maybe Ident ,        -- pointer to primary concrete
  concretes  :: [(Ident,Ident)],     -- list of all concretes
  canModules :: CanonGrammar ,       -- compiled abstracts and concretes
  srcModules :: G.SourceGrammar ,    -- saved resource modules
  cfs        :: [(Ident,CF)] ,       -- context-free grammars
  morphos    :: [(Ident,Morpho)],    -- morphologies
  gloptions  :: Options,             -- global options
  readFiles  :: [(FilePath,ModTime)],-- files read
  absCats    :: [(G.Cat,(G.Context,  -- cats, their contexts, 
                  [(G.Fun,G.Type)],          -- functions to them,
                  [((G.Fun,Int),G.Type)]))], -- functions on them
  statistics :: [Statistics]         -- statistics on grammars
  }                             

data Statistics = 
    StDepTypes Bool        -- whether there are dependent types      
  | StBoundVars [G.Cat]    -- which categories have bound variables
  ---                      -- etc
   deriving (Eq,Ord)

emptyShellState = ShSt {
  abstract   = Nothing,
  concrete   = Nothing,
  concretes  = [],
  canModules = M.emptyMGrammar,
  srcModules = M.emptyMGrammar,
  cfs        = [],
  morphos    = [],
  gloptions  = noOptions,
  readFiles  = [],
  absCats    = [],
  statistics = []
  }

type Language = Ident
language = identC
prLanguage = prIdent

-- grammar for one language in a state, comprising its abs and cnc

data StateGrammar = StGr {
  absId   :: Ident,
  cncId   :: Ident,
  grammar :: CanonGrammar,
  cf      :: CF,
----  parser :: StaticParserInfo,
  morpho  :: Morpho,
  loptions :: Options
  }

emptyStateGrammar = StGr {
  absId   = identC "#EMPTY", ---
  cncId   = identC "#EMPTY", ---
  grammar = M.emptyMGrammar,
  cf      = emptyCF,
  morpho  = emptyMorpho,
  loptions = noOptions
  }

-- analysing shell grammar into parts
stateGrammarST = grammar
stateCF        = cf
stateMorpho    = morpho
stateOptions   = loptions
stateGrammarWords = map fst . tree2list . stateMorpho

cncModuleIdST = stateGrammarST

-- form a shell state from a canonical grammar

grammar2shellState :: Options -> (CanonGrammar, G.SourceGrammar) -> Err ShellState 
grammar2shellState opts (gr,sgr) = 
  updateShellState opts emptyShellState (gr,(sgr,[]))

-- update a shell state from a canonical grammar

updateShellState :: Options -> ShellState -> 
                    (CanonGrammar,(G.SourceGrammar,[(FilePath,ModTime)])) -> 
                    Err ShellState 
updateShellState opts sh (gr,(sgr,rts)) = do 
  let cgr0 = M.updateMGrammar (canModules sh) gr
      a' = ifNull Nothing (return . last) $ allAbstracts cgr0
  abstr0 <- case abstract sh of
    Just a -> do
      --- test that abstract is compatible
      return $ Just a
    _ -> return a'
  let cgr = filterAbstracts abstr0 cgr0
  let concrs = maybe [] (allConcretes cgr) abstr0
      concr0 = ifNull Nothing (return . last) concrs
      notInrts f = notElem f $ map fst rts
  cfs <- mapM (canon2cf opts cgr) concrs --- would not need to update all...

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
    concretes  = zip concrs concrs,
    canModules = cgr,
    srcModules = src,
    cfs        = zip concrs cfs,
    morphos    = zip concrs (map (mkMorpho cgr) concrs),
    gloptions  = opts,
    readFiles  = [ft | ft@(f,_) <- readFiles sh, notInrts f] ++ rts,
    absCats    = csi,
    statistics = [StDepTypes deps,StBoundVars binds]
    }            

prShellStateInfo :: ShellState -> String
prShellStateInfo sh = unlines [
  "main abstract :    " +++ abstractName sh,
  "main concrete :    " +++ maybe "(none)" P.prt (concrete sh),
  "all concretes :    " +++ unwords (map (P.prt . fst) (concretes sh)),
  "canonical modules :" +++ unwords (map (P.prt .fst) (M.modules (canModules sh))),
  "source modules :   " +++ unwords (map (P.prt .fst) (M.modules (srcModules sh))),
  "global options :   " +++ prOpts (gloptions sh)
  ]

abstractName sh = maybe "(none)" P.prt (abstract sh)

-- throw away those abstracts that are not needed --- could be more aggressive

filterAbstracts :: Maybe Ident -> CanonGrammar -> CanonGrammar
filterAbstracts abstr cgr = M.MGrammar [m | m <- ms, needed m] where
  ms = M.modules cgr
  needed (i,_) = case abstr of
    Just a -> elem i $ needs a
    _ -> True
  needs a = [i | (i,M.ModMod m) <- ms, not (M.isModAbs m) || dep i a]
  dep i a = elem i (ext a mse)
  mse = [(i,me) | (i,M.ModMod m) <- ms, M.isModAbs m, me <- [M.extends m]]
  ext a es = case lookup a es of
    Just (Just e) -> a : ext e es
    Just _ -> a : []
    _ -> []

-- form just one state grammar, if unique, from a canonical grammar

grammar2stateGrammar :: Options -> CanonGrammar -> Err StateGrammar 
grammar2stateGrammar opts gr = do 
  st    <- grammar2shellState opts (gr,M.emptyMGrammar)
  concr <- maybeErr "no concrete syntax" $ concrete st 
  return $ stateGrammarOfLang st concr

-- all abstract modules
allAbstracts :: CanonGrammar -> [Ident]
allAbstracts gr = [i | (i,M.ModMod m) <- M.modules gr, M.mtype m == M.MTAbstract]

-- the last abstract in dependency order
greatestAbstract :: CanonGrammar -> Maybe Ident
greatestAbstract gr = case allAbstracts gr of
  [] -> Nothing
  a -> return $ last a

qualifTop :: StateGrammar -> G.QIdent -> G.QIdent
qualifTop gr (_,c) = (absId gr,c)

-- all concretes for a given abstract
allConcretes :: CanonGrammar -> Ident -> [Ident]
allConcretes gr a = [i | (i,M.ModMod m) <- M.modules gr, M.mtype m== M.MTConcrete a]

stateGrammarOfLang :: ShellState -> Language -> StateGrammar
stateGrammarOfLang st l = StGr {
  absId    = maybe (identC "Abs") id (abstract st), ---
  cncId    = l,
  grammar  = can,
  cf       = maybe emptyCF id (lookup l (cfs st)),
  morpho   = maybe emptyMorpho id (lookup l (morphos st)),
  loptions = errVal noOptions $ lookupOptionsCan can
  }
 where
   allCan = canModules st
   can = M.partOfGrammar allCan 
           (l, maybe M.emptyModInfo id (lookup l (M.modules allCan)))

grammarOfLang st = stateGrammarST . stateGrammarOfLang st
cfOfLang st      = stateCF        . stateGrammarOfLang st
morphoOfLang st  = stateMorpho    . stateGrammarOfLang st
optionsOfLang st = stateOptions   . stateGrammarOfLang st

-- the last introduced grammar, stored in options, is the default for operations

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
  morpho  = emptyMorpho,
  loptions = gloptions st ----
  }


-- analysing shell state into parts
globalOptions = gloptions
allLanguages  = map fst . concretes

allStateGrammars = map snd . allStateGrammarsWithNames

allStateGrammarsWithNames st = [(c, mkStateGrammar st c) | (c,_) <- concretes st]

allGrammarFileNames st = [prLanguage c ++ ".gf" | (c,_) <- concretes st] ---

{-
allActiveStateGrammarsWithNames (ShSt (ma,gs,_)) = 
  [(l, mkStateGrammar a c) | (l,((_,True),c)) <- gs, Just a <- [ma]]



allActiveGrammars = map snd . allActiveStateGrammarsWithNames

allGrammarSTs = map stateGrammarST . allStateGrammars
allCFs        = map stateCF        . allStateGrammars

firstGrammarST  = stateGrammarST . firstStateGrammar
firstAbstractST = abstractOf . firstGrammarST
firstConcreteST = concreteOf . firstGrammarST
-}
-- command-line option -language=foo overrides the actual grammar in state
grammarOfOptState :: Options -> ShellState -> StateGrammar
grammarOfOptState opts st = 
  maybe (firstStateGrammar st) (stateGrammarOfLang st . language) $ 
                                               getOptVal opts useLanguage

-- command-line option -cat=foo overrides the possible start cat of a grammar
firstCatOpts :: Options -> StateGrammar -> CFCat
firstCatOpts opts sgr = 
  maybe (stateFirstCat sgr) (string2CFCat (P.prt (absId sgr))) $ 
    getOptVal opts firstCat

-- a grammar can have start category as option startcat=foo ; default is S 
stateFirstCat sgr =
  maybe (string2CFCat a "S") (string2CFCat a) $ 
  getOptVal (stateOptions sgr) gStartCat
 where 
   a = P.prt (absId sgr)

-- the first cat for random generation
firstAbsCat :: Options -> StateGrammar -> G.QIdent
firstAbsCat opts sgr = 
  maybe (absId sgr, identC "S") (\c -> (absId sgr, identC c)) $ ----
    getOptVal opts firstCat

{-
-- command-line option -cat=foo overrides the possible start cat of a grammar
stateTransferFun :: StateGrammar -> Maybe Fun
stateTransferFun sgr = getOptVal (stateOptions sgr) transferFun >>= return . zIdent

stateConcrete = concreteOf . stateGrammarST
stateAbstract = abstractOf . stateGrammarST

maybeStateAbstract (ShSt (ma,_,_)) = ma
hasStateAbstract = maybe False (const True) . maybeStateAbstract
abstractOfState = maybe emptyAbstractST id . maybeStateAbstract

stateIsWord sg = isKnownWord (stateMorpho sg)


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

reinitShellState :: ShellStateOper
reinitShellState = const emptyShellState

{-
languageOn  = languageOnOff True
languageOff = languageOnOff False

languageOnOff :: Bool -> Language -> ShellStateOper
languageOnOff b lang (ShSt (ab,gs,os)) = ShSt (ab, gs', os) where
  gs' = [if lang==l then (l,((f,b),g)) else i | i@(l,((f,_),g)) <- gs]

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
changeOptions f (ShSt a c cs can src cfs ms os ff ts ss) = 
  ShSt a c cs can src cfs ms (f os) ff ts ss

changeModTimes :: [(FilePath,ModTime)] -> ShellStateOper
changeModTimes mfs (ShSt a c cs can src cfs ms os ff ts ss) = 
  ShSt a c cs can src cfs ms os ff' ts ss
 where
   ff' = mfs ++ [mf | mf@(f,_) <- ff, notElem f (map fst mfs)]

addGlobalOptions :: Options -> ShellStateOper
addGlobalOptions = changeOptions . addOptions

removeGlobalOptions :: Options -> ShellStateOper
removeGlobalOptions = changeOptions . removeOptions

