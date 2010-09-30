{-# LANGUAGE DeriveDataTypeable, CPP #-}

import PGF (PGF)
import qualified PGF
import Cache
import FastCGIUtils
import URLEncoding
import RunHTTP
import ServeStaticFile

import Network.FastCGI
import Text.JSON
import Text.PrettyPrint (render, text, (<+>))
import qualified Codec.Binary.UTF8.String as UTF8 (encodeString, decodeString)
import qualified Data.ByteString.Lazy as BS

import Control.Concurrent
import Control.Exception
import Control.Monad
import Data.Char
import Data.Function (on)
import Data.List (sortBy,intersperse,mapAccumL)
import qualified Data.Map as Map
import Data.Maybe
import System.Directory
import System.Random
import System.FilePath
import System.Process
import System.Exit
import System.IO
import System.Environment(getArgs)

logFile :: FilePath
logFile = "pgf-error.log"


main :: IO ()
main = do stderrToFile logFile
          cache <- newCache PGF.readPGF
          args <- getArgs
          case args of
            [] -> fcgiMain cache
            ["http"] -> httpMain cache 41296
            ["http",port] -> httpMain cache =<< readIO port

httpMain cache port = runHTTP port (do log ; serve =<< getPath)
  where
    log = do method <- requestMethod
             uri    <- getVarWithDefault "REQUEST_URI" "-"
             logCGI $ method++" "++uri

    serve path =
        handleErrors . handleCGIErrors $
        if takeExtension path==".pgf"
        then cgiMain' cache path
        else if takeFileName path=="grammars.cgi"
             then grammarList (takeDirectory path)
             else serveStaticFile path

    grammarList dir =
        do paths <- liftIO $ getDirectoryContents dir
           let pgfs = [path|path<-paths, takeExtension path==".pgf"]
           outputJSONP pgfs

fcgiMain :: Cache PGF -> IO ()
fcgiMain cache =
#ifndef mingw32_HOST_OS
          runFastCGIConcurrent' forkIO 100 (cgiMain cache)
#else
          runFastCGI (cgiMain cache)
#endif

getPath = getVarWithDefault "SCRIPT_FILENAME" ""

cgiMain :: Cache PGF -> CGI CGIResult
cgiMain cache = handleErrors . handleCGIErrors $
                  cgiMain' cache =<< getPath

cgiMain' :: Cache PGF -> FilePath -> CGI CGIResult
cgiMain' cache path =
    do pgf <- liftIO $ readCache cache path
       command <- liftM (maybe "grammar" (urlDecodeUnicode . UTF8.decodeString)) (getInput "command")
       pgfMain pgf command

pgfMain :: PGF -> String -> CGI CGIResult
pgfMain pgf command = 
       case command of
         "parse"          -> outputJSONP =<< doParse pgf `fmap` getText `ap` getCat `ap` getFrom 
         "complete"       -> outputJSONP =<< doComplete pgf `fmap` getText `ap` getCat `ap` getFrom `ap` getLimit
         "linearize"      -> outputJSONP =<< doLinearize pgf `fmap` getTree `ap` getTo
         "random"         -> getCat >>= \c -> getLimit >>= liftIO . doRandom pgf c >>= outputJSONP
         "translate"      -> outputJSONP =<< doTranslate pgf `fmap` getText `ap` getCat `ap` getFrom `ap` getTo
         "translategroup" -> outputJSONP =<< doTranslateGroup pgf `fmap` getText `ap` getCat `ap` getFrom `ap` getTo
         "grammar"        -> outputJSONP =<< doGrammar pgf `fmap` requestAcceptLanguage
         "abstrtree"      -> outputPNG =<< liftIO . doGraphvizAbstrTree pgf =<< getTree
         "parsetree"      -> getTree >>= \t -> getFrom >>= \(Just l) -> liftIO (doGraphvizParseTree pgf l t) >>= outputPNG
         "alignment"      -> getTree >>= liftIO . doGraphvizAlignment pgf >>= outputPNG
         "browse"         -> outputHTML =<< doBrowse pgf `fmap` getId `ap` getCSSClass `ap` getHRef
         _                -> throwCGIError 400 "Unknown command" ["Unknown command: " ++ show command]
  where
    getText :: CGI String
    getText = liftM (maybe "" (urlDecodeUnicode . UTF8.decodeString)) $ getInput "input"

    getTree :: CGI PGF.Tree
    getTree = do ms <- getInput "tree"
                 s <- maybe (throwCGIError 400 "No tree given" ["No tree given"]) return ms
                 t <- maybe (throwCGIError 400 "Bad tree" ["tree: " ++ s]) return (PGF.readExpr s)
                 t <- either (\err -> throwCGIError 400 "Type incorrect tree" 
                                                        ["tree: " ++ PGF.showExpr [] t
                                                        ,render (text "error:" <+> PGF.ppTcError err)
                                                        ])
                             (return . fst)
                             (PGF.inferExpr pgf t)
                 return t

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
     [toJSObject (("from", showJSON from) :
                  ("brackets", showJSON bs) :
                  jsonParseOutput po)
           | (from,po,bs) <- parse' pgf input mcat mfrom]
  where
    jsonParseOutput (PGF.ParseOk trees)  = [("translations",showJSON 
                                               [toJSObject [("tree",          showJSON tree),
                                                            ("linearizations",showJSON 
                                                               [toJSObject [("to", showJSON to),
                                                                            ("text",showJSON output)]
                                                                  | (to,output) <- linearizeAndBind pgf mto tree]
                                                            )]
                                                   | tree <- trees])]
    jsonParseOutput (PGF.ParseIncomplete)= []
    jsonParseOutput (PGF.ParseFailed _)  = []
    jsonParseOutput (PGF.TypeError errs) = [("typeErrors",showJSON [toJSObject [("fid", showJSON fid)
                                                                               ,("msg", showJSON (show (PGF.ppTcError err)))
                                                                               ] | (fid,err) <- errs])]

-- used in phrasebook
doTranslateGroup :: PGF -> String -> Maybe PGF.Type -> Maybe PGF.Language -> Maybe PGF.Language -> JSValue
doTranslateGroup pgf input mcat mfrom mto =
  showJSON
     [toJSObject [("from",          showJSON (langOnly (PGF.showLanguage from))),
                  ("to",            showJSON (langOnly (PGF.showLanguage to))),
                  ("linearizations",showJSON 
                      [toJSObject (("text", doText (doBind alt)) : disamb lg from ts) | 
                                             (ts,alt) <- output, let lg = length output])
                 ]
        | 
          (from,po,bs) <- parse' pgf input mcat mfrom,
          (to,output)  <- groupResults [(t, linearize' pgf mto t) | t <- case po of {PGF.ParseOk ts -> ts; _ -> []}]
          ]
  where
   groupResults = Map.toList . foldr more Map.empty . start . collect
     where
       collect tls = [(t,(l,s)) | (t,ls) <- tls, (l,s) <- ls, notDisamb l]
       start ls = [(l,[([t],s)]) | (t,(l,s)) <- ls]
       more (l,s) = 
         Map.insertWith (\ [([t],x)] xs -> insertAlt t x xs) l s

   insertAlt t x xs = case xs of
     (ts,y):xs2 -> if x==y then (t:ts,y):xs2        -- if string is there add only tree
                   else (ts,y) : insertAlt t x xs2
     _ -> [([t],x)]

   doBind = unwords . bind . words
   doText s = case s of
     c:cs | elem (last s) ".?!" -> toUpper c : init (init cs) ++ [last s]
     _ -> s
   bind ws = case ws of
         w : "&+" : u : ws2 -> bind ((w ++ u) : ws2)
         "&+":ws2           -> bind ws2
         w : ws2            -> w : bind ws2
         _ -> ws
   langOnly = reverse . take 3 . reverse

   disamb lg from ts = 
     if lg < 2 
       then [] 
       else [("tree", "-- " ++ groupDisambs [doText (doBind (disambLang from t)) | t <- ts])]

   groupDisambs = unwords . intersperse "/"

   disambLang f t = 
     let 
       disfl lang = PGF.mkCId ("Disamb" ++ lang) 
       disf       = disfl (PGF.showLanguage f) 
       disfEng    = disfl (reverse (drop 3 (reverse (PGF.showLanguage f))) ++ "Eng") 
     in
       if elem disf (PGF.languages pgf)         -- if Disamb f exists use it
         then PGF.linearize pgf disf t          
       else if elem disfEng (PGF.languages pgf) -- else try DisambEng
         then PGF.linearize pgf disfEng t 
       else "AST " ++ PGF.showExpr [] t                   -- else show abstract tree

   notDisamb = (/="Disamb") . take 6 . PGF.showLanguage

doParse :: PGF -> String -> Maybe PGF.Type -> Maybe PGF.Language -> JSValue
doParse pgf input mcat mfrom = showJSON $ map toJSObject
     [("from", showJSON from) :
      ("brackets", showJSON bs) :
      jsonParseOutput po
         | (from,po,bs) <- parse' pgf input mcat mfrom]
  where
    jsonParseOutput (PGF.ParseOk trees)  = [("trees",showJSON trees)]
    jsonParseOutput (PGF.ParseFailed _)  = []
    jsonParseOutput (PGF.TypeError errs) = [("typeErrors",showJSON [toJSObject [("fid", showJSON fid)
                                                                               ,("msg", showJSON (show (PGF.ppTcError err)))
                                                                               ] | (fid,err) <- errs])]

doComplete :: PGF -> String -> Maybe PGF.Type -> Maybe PGF.Language -> Maybe Int -> JSValue
doComplete pgf input mcat mfrom mlimit = showJSON $ map toJSObject
  [[("from",        showJSON from),
    ("brackets",    showJSON bs),
    ("completions", showJSON cs),
    ("text",        showJSON s)]
          | from <- froms, let (bs,s,cs) = complete' pgf from cat mlimit input]
  where
    froms = maybe (PGF.languages pgf) (:[]) mfrom
    cat = fromMaybe (PGF.startCat pgf) mcat

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
                      ("languageCode", showJSON $ fromMaybe "" (PGF.languageCode pgf l))]
                     | l <- PGF.languages pgf]
        categories = [PGF.showCId cat | cat <- PGF.categories pgf]
        functions  = [PGF.showCId fun | fun <- PGF.functions pgf]

doGraphvizAbstrTree pgf tree = do
  pipeIt2graphviz $  PGF.graphvizAbstractTree pgf (True,True) tree

doGraphvizParseTree pgf lang tree = do
  pipeIt2graphviz $ PGF.graphvizParseTree pgf lang tree

doGraphvizAlignment pgf tree = do
  pipeIt2graphviz $ PGF.graphvizAlignment pgf (PGF.languages pgf) tree

pipeIt2graphviz :: String -> IO BS.ByteString
pipeIt2graphviz code = do
    (Just inh, Just outh, _, pid) <-
        createProcess (proc "dot" ["-T","png"])
                      { std_in  = CreatePipe,
                        std_out = CreatePipe,
                        std_err = Inherit }

    hSetEncoding outh latin1
    hSetEncoding inh  utf8

    -- fork off a thread to start consuming the output
    output  <- BS.hGetContents outh
    outMVar <- newEmptyMVar
    _ <- forkIO $ evaluate (BS.length output) >> putMVar outMVar ()

    -- now write and flush any input
    hPutStr inh code
    hFlush inh
    hClose inh -- done with stdin

    -- wait on the output
    takeMVar outMVar
    hClose outh

    -- wait on the process
    ex <- waitForProcess pid

    case ex of
     ExitSuccess   -> return output
     ExitFailure r -> fail ("pipeIt2graphviz: (exit " ++ show r ++ ")")

doBrowse pgf id cssClass href =
  case PGF.browse pgf id of
    Just (def,ps,cs) -> "<PRE>"++annotate def++"</PRE>\n"++
                        syntax++
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
    syntax = 
      case PGF.functionType pgf id of
        Just ty -> let (hypos,_,_) = PGF.unType ty
                       e          = PGF.mkApp id (snd $ mapAccumL mkArg (1,1) hypos)
                       rows = ["<TR class=\"my-SyntaxRow\">"++
                               "<TD class=\"my-SyntaxLang\">"++PGF.showCId lang++"</TD>"++
                               "<TD class=\"my-SyntaxLin\">"++PGF.linearize pgf lang e++"</TD>"++
                               "</TR>"
                                            | lang <- PGF.languages pgf]
                   in "<BR/>"++
                      "<H3>Syntax</H3>"++
                      "<TABLE class=\"my-SyntaxTable\">\n"++
                      "<TR class=\"my-SyntaxRow\">"++
                      "<TD class=\"my-SyntaxLang\">"++PGF.showCId (PGF.abstractName pgf)++"</TD>"++
                      "<TD class=\"my-SyntaxLin\">"++PGF.showExpr [] e++"</TD>"++
                      "</TR>\n"++
                      unlines rows++"\n</TABLE>"
        Nothing -> ""

    mkArg (i,j) (_,_,ty) = ((i+1,j+length hypos),e)
      where
        e = foldr (\(j,(bt,_,_)) -> PGF.mkAbs bt (PGF.mkCId ('X':show j))) (PGF.mkMeta i) (zip [j..] hypos)
        (hypos,_,_) = PGF.unType ty

    identifiers = PGF.functions pgf ++ PGF.categories pgf

    annotate []          = []
    annotate (c:cs)
      | isIdentInitial c = let (id,cs') = break (not . isIdentChar) (c:cs)
                           in (if PGF.mkCId id `elem` identifiers
                                 then mkLink id
                                 else if id == "fun" || id == "data" || id == "cat" || id == "def"
                                        then "<B>"++id++"</B>"
                                        else id) ++
                              annotate cs'
      | otherwise        = c : annotate cs

    annotateCIds ids = unwords (map (mkLink . PGF.showCId) ids)
    
    isIdentInitial c = isAlpha c || c == '_'
    isIdentChar    c = isAlphaNum c || c == '_' || c == '\''

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

instance JSON PGF.BracketedString where
    readJSON x = return (PGF.Leaf "")
    showJSON (PGF.Bracket cat fid index _ bs)
                          = showJSON $ toJSObject [("cat",      showJSON cat)
                                                  ,("fid",      showJSON fid)
                                                  ,("index",    showJSON index)
                                                  ,("children", showJSON bs)
                                                  ]
    showJSON (PGF.Leaf s) = showJSON $ toJSObject [("token", s)]

-- * PGF utilities

cat :: PGF -> Maybe PGF.Type -> PGF.Type
cat pgf mcat = fromMaybe (PGF.startCat pgf) mcat

parse' :: PGF -> String -> Maybe PGF.Type -> Maybe PGF.Language -> [(PGF.Language,PGF.ParseOutput,PGF.BracketedString)]
parse' pgf input mcat mfrom = 
   [(from,po,bs) | from <- froms, (po,bs) <- [PGF.parse_ pgf from cat input]]
  where froms = maybe (PGF.languages pgf) (:[]) mfrom
        cat = fromMaybe (PGF.startCat pgf) mcat

complete' :: PGF -> PGF.Language -> PGF.Type -> Maybe Int -> String
         -> (PGF.BracketedString, String, [String])
complete' pgf from typ mlimit input =
  let (ws,prefix) = tokensAndPrefix input
      ps0 = PGF.initState pgf from typ
      (ps,ws') = loop ps0 ws
      bs       = snd (PGF.getParseOutput ps typ)
  in if not (null ws')
       then (bs, unwords (if null prefix then ws' else ws'++[prefix]), [])
       else (bs, prefix, maybe id take mlimit $ order $ Map.keys (PGF.getCompletions ps prefix))
  where
    order = sortBy (compare `on` map toLower)

    tokensAndPrefix :: String -> ([String],String)
    tokensAndPrefix s | not (null s) && isSpace (last s) = (ws, "")
                      | null ws = ([],"")
                      | otherwise = (init ws, last ws)
        where ws = words s

    loop ps []     = (ps,[])
    loop ps (w:ws) = case PGF.nextState ps (PGF.simpleParseInput w) of
                       Left  es -> (ps,w:ws)
                       Right ps -> loop ps ws

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
random' pgf mcat = do
  g <- newStdGen
  return $ PGF.generateRandom (PGF.RandSel g) pgf (fromMaybe (PGF.startCat pgf) mcat)

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

--cleanFilePath :: FilePath -> FilePath
--cleanFilePath = takeFileName
