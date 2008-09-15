{-# LANGUAGE DeriveDataTypeable #-}

import PGF (PGF)
import qualified PGF
import FastCGIUtils
import URLEncoding

import Network.CGI
import Text.JSON
import qualified Codec.Binary.UTF8.String as UTF8 (encodeString, decodeString)

import Control.Monad
import Data.Char
import qualified Data.Map as Map
import Data.Maybe


grammarFile :: FilePath
grammarFile = "grammar.pgf"



main :: IO ()
main = do initFastCGI
          r <- newDataRef
          loopFastCGI (handleErrors (handleCGIErrors (fcgiMain r)))

fcgiMain :: DataRef PGF -> CGI CGIResult
fcgiMain ref = getData (liftIO . PGF.readPGF) ref grammarFile >>= cgiMain

cgiMain :: PGF -> CGI CGIResult
cgiMain pgf =
    do path <- pathInfo
       json <- case path of
         "/parse"          -> return (doParse pgf) `ap` getText `ap` getCat `ap` getFrom
         "/complete"       -> return (doComplete pgf) `ap` getText `ap` getCat `ap` getFrom `ap` getLimit
         "/linearize"      -> return (doLinearize pgf) `ap` getTree `ap` getTo
         "/translate"      -> return (doTranslate pgf) `ap` getText `ap` getCat `ap` getFrom `ap` getTo
         "/categories"     -> return $ doCategories pgf
         "/languages"      -> return $ doLanguages pgf
         _                 -> throwCGIError 404 "Not Found" ["Resource not found: " ++ path]
       outputJSON json
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

doLanguages :: PGF -> JSValue
doLanguages pgf = showJSON $ map toJSObject
     [[("name", showJSON l), 
       ("languageCode", showJSON $ fromMaybe "" (PGF.languageCode pgf l)),
       ("canParse",     showJSON $ PGF.canParse pgf l)]
          | l <- PGF.languages pgf]

doCategories :: PGF -> JSValue
doCategories pgf = showJSON $ map toJSObject
      [[("cat",cat)] | cat <- PGF.categories pgf]


-- * PGF utilities

parse' :: PGF -> String -> Maybe PGF.Category -> Maybe PGF.Language -> [(PGF.Language,[PGF.Tree])]
parse' pgf input mcat mfrom = 
   [(from,ts) | from <- froms, PGF.canParse pgf from, let ts = PGF.parse pgf from cat input, not (null ts)]
  where froms = maybe (PGF.languages pgf) (:[]) mfrom
        cat = fromMaybe (PGF.startCat pgf) mcat

complete' :: PGF -> String -> Maybe PGF.Category -> Maybe PGF.Language -> [(PGF.Language,[String])]
complete' pgf input mcat mfrom = 
   [(from,ss) | from <- froms, PGF.canParse pgf from, let ss = complete pgf from cat input, not (null ss)]
  where froms = maybe (PGF.languages pgf) (:[]) mfrom
        cat = fromMaybe (PGF.startCat pgf) mcat

complete :: PGF -> PGF.Language -> PGF.Category -> String -> [String]
complete pgf from cat input = 
         let (ws,prefix) = tokensAndPrefix input
             state0 = PGF.initState pgf from cat
             state = foldl PGF.nextState state0 ws
             compls = PGF.getCompletions state prefix
          in [unwords (ws++[c]) ++ " " | c <- Map.keys compls]

tokensAndPrefix :: String -> ([String],String)
tokensAndPrefix s | not (null s) && isSpace (last s) = (words s, "")
                  | null ws = ([],"")
                  | otherwise = (init ws, last ws)
  where ws = words s

linearize' :: PGF -> Maybe PGF.Language -> PGF.Tree -> [(PGF.Language,String)]
linearize' pgf mto tree = 
    case mto of
      Nothing -> PGF.linearizeAllLang pgf tree
      Just to -> [(to,PGF.linearize pgf to tree)]

-- * General CGI and JSON stuff

outputJSON :: JSON a => a -> CGI CGIResult
outputJSON x = do setHeader "Content-Type" "text/json; charset=utf-8"
                  outputStrict $ UTF8.encodeString $ encode x

outputStrict :: String -> CGI CGIResult
outputStrict x | x == x = output x
               | otherwise = fail "I am the pope."
