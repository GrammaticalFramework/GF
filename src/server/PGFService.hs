{-# LANGUAGE DeriveDataTypeable, CPP #-}

import PGF (PGF)
import qualified PGF
import Cache
import FastCGIUtils
import URLEncoding

import Network.FastCGI
import Text.JSON
import qualified Codec.Binary.UTF8.String as UTF8 (encodeString, decodeString)

import Control.Concurrent
import Control.Monad
import Data.Char
import Data.Function (on)
import Data.List (sortBy)
import qualified Data.Map as Map
import Data.Maybe
import System.Directory
import System.FilePath
import System.Process

logFile :: FilePath
logFile = "pgf-error.log"

--canParse = PGF.canParse -- old
canParse _ _ = True -- parser is not optional in new PGF format

main :: IO ()
main = do stderrToFile logFile
          cache <- newCache PGF.readPGF
#ifndef mingw32_HOST_OS
          runFastCGIConcurrent' forkIO 100 (handleErrors (handleCGIErrors (cgiMain cache)))
#else
          runFastCGI (handleErrors (handleCGIErrors (cgiMain cache)))
#endif

cgiMain :: Cache PGF -> CGI CGIResult
cgiMain cache =
    do path <- getVarWithDefault "SCRIPT_FILENAME" ""
       pgf <- liftIO $ readCache cache path
       command <- liftM (maybe "grammar" (urlDecodeUnicode . UTF8.decodeString)) (getInput "command")
       pgfMain pgf command

pgfMain :: PGF -> String -> CGI CGIResult
pgfMain pgf command = 
       case command of
         "parse"          -> return (doParse pgf) `ap` getText `ap` getCat `ap` getFrom >>= outputJSONP
         "complete"       -> return (doComplete pgf) `ap` getText `ap` getCat `ap` getFrom `ap` getLimit >>= outputJSONP
         "linearize"      -> return (doLinearize pgf) `ap` getTree `ap` getTo >>= outputJSONP
         "random"         -> getCat >>= \c -> getLimit >>= liftIO . doRandom pgf c >>= outputJSONP
         "translate"      -> return (doTranslate pgf) `ap` getText `ap` getCat `ap` getFrom `ap` getTo >>= outputJSONP
         "translategroup" -> return (doTranslateGroup pgf) `ap` getText `ap` getCat `ap` getFrom `ap` getTo >>= outputJSONP
         "grammar"        -> return (doGrammar pgf) `ap` requestAcceptLanguage >>= outputJSONP
         "abstrtree"      -> getTree >>= liftIO . doGraphvizAbstrTree pgf >>= outputPNG
         "parsetree"      -> getTree >>= \t -> getFrom >>= \(Just l) -> liftIO (doGraphvizParseTree pgf l t) >>= outputPNG
         "alignment"      -> getTree >>= liftIO . doGraphvizAlignment pgf >>= outputPNG
         "browse"         -> return (doBrowse pgf) `ap` getId `ap` getCSSClass `ap` getHRef  >>= outputHTML
         _                -> throwCGIError 400 "Unknown command" ["Unknown command: " ++ show command]
  where
    getText :: CGI String
    getText = liftM (maybe "" (urlDecodeUnicode . UTF8.decodeString)) $ getInput "input"

    getTree :: CGI PGF.Tree
    getTree = do mt <- getInput "tree"
                 t <- maybe (throwCGIError 400 "No tree given" ["No tree given"]) return mt
                 maybe (throwCGIError 400 "Bad tree" ["Bad tree: " ++ t]) return (PGF.readExpr t)

    getCat :: CGI (Maybe PGF.Type)
    getCat = 
       do mcat  <- getInput "cat"
          case mcat of
            Nothing -> return Nothing
            Just "" -> return Nothing
            Just cat -> case PGF.readType cat of
                          Nothing  -> throwCGIError 400 "Bad category" ["Bad category: " ++ cat]
                          Just typ -> return $ Just typ  -- typecheck the category

    getFrom :: CGI (Maybe PGF.Language)
    getFrom = getLang "from"

    getTo :: CGI (Maybe PGF.Language)
    getTo = getLang "to"

    getId :: CGI PGF.CId
    getId = do mb_id <- fmap (>>= PGF.readCId) (getInput "id")
               case mb_id of
                 Just id -> return id
                 Nothing -> throwCGIError 400 "Bad identifier" []

    getCSSClass :: CGI (Maybe String)
    getCSSClass = getInput "css-class"

    getHRef :: CGI (Maybe String)
    getHRef = getInput "href"

    getLimit :: CGI (Maybe Int)
    getLimit = readInput "limit"

    getLang :: String -> CGI (Maybe PGF.Language)
    getLang i = 
       do mlang <- getInput i
          case mlang of
            Nothing -> return Nothing
            Just "" -> return Nothing
            Just l  -> case PGF.readLanguage l of
                         Nothing -> throwCGIError 400 "Bad language" ["Bad language: " ++ l]
                         Just lang | lang `elem` PGF.languages pgf -> return $ Just lang
                                   | otherwise -> throwCGIError 400 "Unknown language" ["Unknown language: " ++ l]

doTranslate :: PGF -> String -> Maybe PGF.Type -> Maybe PGF.Language -> Maybe PGF.Language -> JSValue
doTranslate pgf input mcat mfrom mto =
  showJSON
     [toJSObject [("from",          showJSON (PGF.showLanguage from)),
                  ("tree",          showJSON tree),
                  ("linearizations",showJSON 
                     [toJSObject [("to", PGF.showLanguage to),("text",output)]
                       | (to,output) <- linearizeAndBind pgf mto tree]
                  )
                 ]
           | (from,trees) <- parse' pgf input mcat mfrom,
             tree <- trees]

-- used in phrasebook
doTranslateGroup :: PGF -> String -> Maybe PGF.Type -> Maybe PGF.Language -> Maybe PGF.Language -> JSValue
doTranslateGroup pgf input mcat mfrom mto =
  showJSON
     [toJSObject [("from",          showJSON (langOnly (PGF.showLanguage from))),
                  ("to",            showJSON (langOnly (PGF.showLanguage to))),
                  ("linearizations",showJSON 
                      [toJSObject [("text", doText (doBind alt))] | alt <- output])
                 ]
        | 
          (from,trees) <- parse' pgf input mcat mfrom,
          (to,output)  <- groupResults (map (linearize' pgf mto) trees) 
          ]
  where
   groupResults = Map.toList . foldr more Map.empty . start . concat
     where
       start ls = [(l,[s]) | (l,s) <- ls]
       more (l,s) = 
         Map.insertWith (\ [x] xs -> if elem x xs then xs else (x : xs)) l s
   doBind = unwords . bind . words
   doText s = case s of
     c:cs | elem (last s) ".?!" -> toUpper c : init (init cs) ++ [last s]
     _ -> s
   bind ws = case ws of
         w : "&+" : u : ws2 -> bind ((w ++ u) : ws2)
         w : ws2            -> w : bind ws2
         _ -> ws
   langOnly = reverse . take 3 . reverse


doParse :: PGF -> String -> Maybe PGF.Type -> Maybe PGF.Language -> JSValue
doParse pgf input mcat mfrom = showJSON $ map toJSObject
     [[("from", PGF.showLanguage from),("tree",PGF.showExpr [] tree)]
         | (from,trees) <- parse' pgf input mcat mfrom,
           tree <- trees ]

doComplete :: PGF -> String -> Maybe PGF.Type -> Maybe PGF.Language -> Maybe Int -> JSValue
doComplete pgf input mcat mfrom mlimit = showJSON $ map toJSObject $ limit
     [[("from", PGF.showLanguage from),("text",text)]
          | (from,compls) <- complete' pgf input mcat mfrom,
            text <- compls]
  where
    limit xs = maybe xs (\n -> take n xs) mlimit

doLinearize :: PGF -> PGF.Tree -> Maybe PGF.Language -> JSValue
doLinearize pgf tree mto = showJSON $ map toJSObject
     [[("to", PGF.showLanguage to),("text",text)] | (to,text) <- linearize' pgf mto tree]

doRandom :: PGF -> Maybe PGF.Type -> Maybe Int -> IO JSValue
doRandom pgf mcat mlimit = 
    do trees <- random' pgf mcat
       return $ showJSON $ map toJSObject [[("tree", PGF.showExpr [] tree)] | tree <- limit trees]
  where limit = take (fromMaybe 1 mlimit)

doGrammar :: PGF -> Maybe (Accept Language) -> JSValue
doGrammar pgf macc = showJSON $ toJSObject 
             [("name", showJSON (PGF.abstractName pgf)),
              ("userLanguage", showJSON (selectLanguage pgf macc)),
              ("categories", showJSON categories),
              ("functions", showJSON functions),
              ("languages", showJSON languages)]
  where languages = map toJSObject
                    [[("name", showJSON l), 
                      ("languageCode", showJSON $ fromMaybe "" (PGF.languageCode pgf l)),
                      ("canParse",     showJSON $ canParse pgf l)]
                     | l <- PGF.languages pgf]
        categories = [PGF.showCId cat | cat <- PGF.categories pgf]
        functions  = [PGF.showCId fun | fun <- PGF.functions pgf]

doGraphvizAbstrTree pgf tree = do
  let dot = PGF.graphvizAbstractTree pgf (True,True) tree
  readProcess "dot" ["-T","png"] dot

doGraphvizParseTree pgf lang tree = do
  let dot = PGF.graphvizParseTree pgf lang tree
  readProcess "dot" ["-T","png"] (UTF8.encodeString dot)

doGraphvizAlignment pgf tree = do
  let dot = PGF.graphvizAlignment pgf tree
  readProcess "dot" ["-T","png"] (UTF8.encodeString dot)

doBrowse pgf id cssClass href =
  case PGF.browse pgf id of
    Just (def,ps,cs) -> "<PRE>"++annotate def++"</PRE>\n"++
                        (if not (null ps)
                           then "<BR/>"++
                                "<H3>Producers</H3>"++
                                "<P>"++annotateCIds ps++"</P>\n"
                           else "")++
                        (if not (null cs)
                           then "<BR/>"++
                                "<H3>Consumers</H3>"++
                                "<P>"++annotateCIds cs++"</P>\n"
                           else "")
    Nothing          -> ""
  where
    identifiers = PGF.functions pgf ++ PGF.categories pgf

    annotate []   = []
    annotate (c:cs)
      | isSpace c = c : annotate cs
      | otherwise = let (id,cs') = break isSpace (c:cs)
                    in (if PGF.mkCId id `elem` identifiers
                          then mkLink id
                          else if id == "fun" || id == "data" || id == "cat" || id == "def"
                                 then "<B>"++id++"</B>"
                                 else id) ++
                       annotate cs'
    annotateCIds ids = unwords (map (mkLink . PGF.showCId) ids)

    hrefAttr id =
      case href of
        Nothing -> ""
        Just s  -> "href=\""++substId id s++"\""

    substId id [] = []
    substId id ('$':'I':'D':cs) = id ++ cs
    substId id (c:cs) = c : substId id cs

    classAttr =
      case cssClass of
        Nothing -> ""
        Just s  -> "class=\""++s++"\""

    mkLink s = "<A "++hrefAttr s++" "++classAttr++">"++s++"</A>"

instance JSON PGF.CId where
    readJSON x = readJSON x >>= maybe (fail "Bad language.") return . PGF.readLanguage
    showJSON = showJSON . PGF.showLanguage

instance JSON PGF.Expr where
    readJSON x = readJSON x >>= maybe (fail "Bad expression.") return . PGF.readExpr
    showJSON = showJSON . PGF.showExpr []

-- * PGF utilities

cat :: PGF -> Maybe PGF.Type -> PGF.Type
cat pgf mcat = fromMaybe (PGF.startCat pgf) mcat

parse' :: PGF -> String -> Maybe PGF.Type -> Maybe PGF.Language -> [(PGF.Language,[PGF.Tree])]
parse' pgf input mcat mfrom = 
   [(from,ts) | from <- froms, canParse pgf from, let ts = PGF.parse pgf from cat input, not (null ts)]
  where froms = maybe (PGF.languages pgf) (:[]) mfrom
        cat = fromMaybe (PGF.startCat pgf) mcat

complete' :: PGF -> String -> Maybe PGF.Type -> Maybe PGF.Language -> [(PGF.Language,[String])]
complete' pgf input mcat mfrom = 
   [(from,order ss) | from <- froms, canParse pgf from, let ss = PGF.complete pgf from cat input, not (null ss)]
  where froms = maybe (PGF.languages pgf) (:[]) mfrom
        cat = fromMaybe (PGF.startCat pgf) mcat
        order = sortBy (compare `on` map toLower)

linearize' :: PGF -> Maybe PGF.Language -> PGF.Tree -> [(PGF.Language,String)]
linearize' pgf mto tree = 
    case mto of
      Nothing -> PGF.linearizeAllLang pgf tree
      Just to -> [(to,PGF.linearize pgf to tree)]

linearizeAndBind pgf mto t = [(la, binds s) | (la,s) <- linearize' pgf mto t]
  where
    binds = unwords . bs . words
    bs ws = case ws of
      u:"&+":v:ws2 -> bs ((u ++ v):ws2)
      u:ws2        -> u : bs ws2
      _            -> []

random' :: PGF -> Maybe PGF.Type -> IO [PGF.Tree]
random' pgf mcat = PGF.generateRandom pgf (fromMaybe (PGF.startCat pgf) mcat)

selectLanguage :: PGF -> Maybe (Accept Language) -> PGF.Language
selectLanguage pgf macc = case acceptable of
                            []  -> case PGF.languages pgf of
                                     []  -> error "No concrete syntaxes in PGF grammar."
                                     l:_ -> l
                            Language c:_ -> fromJust (langCodeLanguage pgf c)
  where langCodes = mapMaybe (PGF.languageCode pgf) (PGF.languages pgf)
        acceptable = negotiate (map Language langCodes) macc

langCodeLanguage :: PGF -> String -> Maybe PGF.Language
langCodeLanguage pgf code = listToMaybe [l | l <- PGF.languages pgf, PGF.languageCode pgf l == Just code]

-- * General utilities

cleanFilePath :: FilePath -> FilePath
cleanFilePath = takeFileName
