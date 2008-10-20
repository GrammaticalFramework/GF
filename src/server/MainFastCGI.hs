{-# LANGUAGE DeriveDataTypeable #-}

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
import qualified Data.Map as Map
import Data.Maybe


main :: IO ()
main = do initFastCGI
          cache <- newCache PGF.readPGF
          runFastCGIConcurrent' forkIO 100 (handleErrors (handleCGIErrors (cgiMain cache)))

cgiMain :: Cache PGF -> CGI CGIResult
cgiMain cache =
    do path <- pathInfo
       case filter (not . null) $ splitBy (=='/') path of
         [file,command] -> do pgf  <- liftIO $ readCache cache file
                              json <- pgfMain pgf command
                              outputJSONP json
         _ -> throwCGIError 400 "Unknown resource" ["Unknown resource: " ++ show path,
                                                    "Use /grammar.pgf/command"]

pgfMain :: PGF -> String -> CGI JSValue
pgfMain pgf command = 
       case command of
         "parse"          -> return (doParse pgf) `ap` getText `ap` getCat `ap` getFrom
         "complete"       -> return (doComplete pgf) `ap` getText `ap` getCat `ap` getFrom `ap` getLimit
         "linearize"      -> return (doLinearize pgf) `ap` getTree `ap` getTo
         "translate"      -> return (doTranslate pgf) `ap` getText `ap` getCat `ap` getFrom `ap` getTo
         "grammar"        -> return (doGrammar pgf) `ap` requestAcceptLanguage
         _                -> throwCGIError 400 "Unknown command" ["Unknown command: " ++ show command]
  where
    getText :: CGI String
    getText = liftM (maybe "" (urlDecodeUnicode . UTF8.decodeString)) $ getInput "input"

    getTree :: CGI PGF.Tree
    getTree = do mt <- getInput "tree"
                 t <- maybe (throwCGIError 400 "No tree given" ["No tree given"]) return mt
                 maybe (throwCGIError 400 "Bad tree" ["Bad tree: " ++ t]) return (PGF.readTree t)

    getCat :: CGI (Maybe PGF.Category)
    getCat = 
       do mcat  <- getInput "cat"
          case mcat of
            Just "" -> return Nothing
            Just cat | cat `notElem` PGF.categories pgf ->
                         throwCGIError 400 "Unknown category" ["Unknown category: " ++ cat]
            _ -> return mcat

    getFrom :: CGI (Maybe PGF.Language)
    getFrom = getLang "from"

    getTo :: CGI (Maybe PGF.Language)
    getTo = getLang "to"

    getLimit :: CGI (Maybe Int)
    getLimit = readInput "limit"

    getLang :: String -> CGI (Maybe PGF.Language)
    getLang i = 
       do mlang <- getInput i
          case mlang of
            Just "" -> return Nothing
            Just lang | lang `notElem` PGF.languages pgf ->
                          throwCGIError 400 "Unknown language" ["Unknown language: " ++ lang]
            _ -> return mlang

doTranslate :: PGF -> String -> Maybe PGF.Category -> Maybe PGF.Language -> Maybe PGF.Language -> JSValue
doTranslate pgf input mcat mfrom mto = showJSON $ map toJSObject
     [[("from",from),("to",to),("text",output)]
           | (from,trees) <- parse' pgf input mcat mfrom,
             tree <- trees,
             (to,output) <- linearize' pgf mto tree]

doParse :: PGF -> String -> Maybe PGF.Category -> Maybe PGF.Language -> JSValue
doParse pgf input mcat mfrom = showJSON $ map toJSObject
     [[("from",from),("tree",PGF.showTree tree)]
         | (from,trees) <- parse' pgf input mcat mfrom,
           tree <- trees ]

doComplete :: PGF -> String -> Maybe PGF.Category -> Maybe PGF.Language -> Maybe Int -> JSValue
doComplete pgf input mcat mfrom mlimit = showJSON $ map toJSObject $ limit
     [[("from",from),("text",text)]
          | (from,compls) <- complete' pgf input mcat mfrom,
            text <- compls]
  where
    limit xs = maybe xs (\n -> take n xs) mlimit

doLinearize :: PGF -> PGF.Tree -> Maybe PGF.Language -> JSValue
doLinearize pgf tree mto = showJSON $ map toJSObject
     [[("to",to),("text",text)] | (to,text) <- linearize' pgf mto tree]

doGrammar :: PGF -> Maybe (Accept Language) -> JSValue
doGrammar pgf macc = showJSON $ toJSObject 
             [("name", showJSON (PGF.abstractName pgf)),
              ("userLanguage", showJSON (selectLanguage pgf macc)),
              ("categories", showJSON categories), 
              ("languages", showJSON languages)]
  where languages = map toJSObject
                    [[("name", showJSON l), 
                      ("languageCode", showJSON $ fromMaybe "" (PGF.languageCode pgf l)),
                      ("canParse",     showJSON $ PGF.canParse pgf l)]
                     | l <- PGF.languages pgf]
        categories = map toJSObject [[("cat", cat)] | cat <- PGF.categories pgf]

-- * PGF utilities

parse' :: PGF -> String -> Maybe PGF.Category -> Maybe PGF.Language -> [(PGF.Language,[PGF.Tree])]
parse' pgf input mcat mfrom = 
   [(from,ts) | from <- froms, PGF.canParse pgf from, let ts = PGF.parse pgf from cat input, not (null ts)]
  where froms = maybe (PGF.languages pgf) (:[]) mfrom
        cat = fromMaybe (PGF.startCat pgf) mcat

complete' :: PGF -> String -> Maybe PGF.Category -> Maybe PGF.Language -> [(PGF.Language,[String])]
complete' pgf input mcat mfrom = 
   [(from,ss) | from <- froms, PGF.canParse pgf from, let ss = PGF.complete pgf from cat input, not (null ss)]
  where froms = maybe (PGF.languages pgf) (:[]) mfrom
        cat = fromMaybe (PGF.startCat pgf) mcat

linearize' :: PGF -> Maybe PGF.Language -> PGF.Tree -> [(PGF.Language,String)]
linearize' pgf mto tree = 
    case mto of
      Nothing -> PGF.linearizeAllLang pgf tree
      Just to -> [(to,PGF.linearize pgf to tree)]

selectLanguage :: PGF -> Maybe (Accept Language) -> PGF.Language
selectLanguage pgf macc = case acceptable of
                            []  -> case PGF.languages pgf of
                                     []  -> "" -- FIXME: error?
                                     l:_ -> l
                            Language c:_ -> fromJust (langCodeLanguage pgf c)
  where langCodes = mapMaybe (PGF.languageCode pgf) (PGF.languages pgf)
        acceptable = negotiate (map Language langCodes) macc

langCodeLanguage :: PGF -> String -> Maybe PGF.Language
langCodeLanguage pgf code = listToMaybe [l | l <- PGF.languages pgf, PGF.languageCode pgf l == Just code]

-- * General CGI and JSON stuff

outputJSONP :: JSON a => a -> CGI CGIResult
outputJSONP x = 
    do mc <- getInput "jsonp"
       let str = case mc of
                   Nothing -> encode x
                   Just c  -> c ++ "(" ++ encode x ++ ")"
       setHeader "Content-Type" "text/json; charset=utf-8"
       outputStrict $ UTF8.encodeString str

outputStrict :: String -> CGI CGIResult
outputStrict x | x == x = output x
               | otherwise = fail "I am the pope."

-- * General utilities

splitBy :: (a -> Bool) -> [a] -> [[a]]
splitBy _ [] = [[]]
splitBy f list = case break f list of
                   (first,[]) -> [first]
                   (first,_:rest) -> first : splitBy f rest