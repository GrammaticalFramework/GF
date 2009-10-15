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

logFile :: FilePath
logFile = "pgf-error.log"

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
       jsonp <- pgfMain pgf command
       outputJSONP jsonp

pgfMain :: PGF -> String -> CGI JSValue
pgfMain pgf command = 
       case command of
         "parse"          -> return (doParse pgf) `ap` getText `ap` getCat `ap` getFrom
         "complete"       -> return (doComplete pgf) `ap` getText `ap` getCat `ap` getFrom `ap` getLimit
         "linearize"      -> return (doLinearize pgf) `ap` getTree `ap` getTo
         "random"         -> getCat >>= \c -> getLimit >>= liftIO . doRandom pgf c
         "translate"      -> return (doTranslate pgf) `ap` getText `ap` getCat `ap` getFrom `ap` getTo
         "grammar"        -> return (doGrammar pgf) `ap` requestAcceptLanguage
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
                          Nothing -> throwCGIError 400 "Bad category" ["Bad category: " ++ cat]
                          Just typ | typ `elem` PGF.categories pgf -> return $ Just typ
                                   | otherwise -> throwCGIError 400 "Unknown category" ["Unknown category: " ++ show typ]

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
            Nothing -> return Nothing
            Just "" -> return Nothing
            Just l  -> case PGF.readLanguage l of
                         Nothing -> throwCGIError 400 "Bad language" ["Bad language: " ++ l]
                         Just lang | lang `elem` PGF.languages pgf -> return $ Just lang
                                   | otherwise -> throwCGIError 400 "Unknown language" ["Unknown language: " ++ l]

doListGrammars :: IO JSValue
doListGrammars = 
    do cwd <- getCurrentDirectory
       ps <- getDirectoryContents cwd
       let fs = filter ((== ".pgf") . map toLower . takeExtension) $ map takeFileName ps
       return $ showJSON $ map toJSObject [[("name", f)] | f <- fs]

doTranslate :: PGF -> String -> Maybe PGF.Type -> Maybe PGF.Language -> Maybe PGF.Language -> JSValue
doTranslate pgf input mcat mfrom mto = showJSON $ map toJSObject
     [[("from", PGF.showLanguage from),("to", PGF.showLanguage to),("text",output)]
           | (from,trees) <- parse' pgf input mcat mfrom,
             tree <- trees,
             (to,output) <- linearize' pgf mto tree]

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
              ("languages", showJSON languages)]
  where languages = map toJSObject
                    [[("name", showJSON l), 
                      ("languageCode", showJSON $ fromMaybe "" (PGF.languageCode pgf l)),
                      ("canParse",     showJSON $ PGF.canParse pgf l)]
                     | l <- PGF.languages pgf]
        categories = map toJSObject [[("cat", PGF.showType [] cat)] | cat <- PGF.categories pgf]

instance JSON PGF.CId where
    readJSON x = readJSON x >>= maybe (fail "Bad language.") return . PGF.readLanguage
    showJSON = showJSON . PGF.showLanguage

-- * PGF utilities

cat :: PGF -> Maybe PGF.Type -> PGF.Type
cat pgf mcat = fromMaybe (PGF.startCat pgf) mcat

parse' :: PGF -> String -> Maybe PGF.Type -> Maybe PGF.Language -> [(PGF.Language,[PGF.Tree])]
parse' pgf input mcat mfrom = 
   [(from,ts) | from <- froms, PGF.canParse pgf from, let ts = PGF.parse pgf from cat input, not (null ts)]
  where froms = maybe (PGF.languages pgf) (:[]) mfrom
        cat = fromMaybe (PGF.startCat pgf) mcat

complete' :: PGF -> String -> Maybe PGF.Type -> Maybe PGF.Language -> [(PGF.Language,[String])]
complete' pgf input mcat mfrom = 
   [(from,order ss) | from <- froms, PGF.canParse pgf from, let ss = PGF.complete pgf from cat input, not (null ss)]
  where froms = maybe (PGF.languages pgf) (:[]) mfrom
        cat = fromMaybe (PGF.startCat pgf) mcat
        order = sortBy (compare `on` map toLower)

linearize' :: PGF -> Maybe PGF.Language -> PGF.Tree -> [(PGF.Language,String)]
linearize' pgf mto tree = 
    case mto of
      Nothing -> PGF.linearizeAllLang pgf tree
      Just to -> [(to,PGF.linearize pgf to tree)]

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