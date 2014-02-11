{-# LANGUAGE CPP #-}
module PGFService(cgiMain,cgiMain',getPath,
                  logFile,stderrToFile,
                  newPGFCache) where

import PGF (PGF)
import qualified PGF
import Cache
import FastCGIUtils
import URLEncoding

#if C_RUNTIME
import qualified PGF2 as C
import Data.Time.Clock(UTCTime,getCurrentTime,diffUTCTime)
#endif

import Network.CGI
import Text.JSON
import Text.PrettyPrint as PP(render, text, (<+>))
import qualified Codec.Binary.UTF8.String as UTF8 (decodeString)
import qualified Data.ByteString.Lazy as BS

import Control.Concurrent
import qualified Control.Exception as E
import Control.Monad
import Control.Monad.State(State,evalState,get,put)
import Data.Char
import Data.Function (on)
import Data.List (sortBy,intersperse,mapAccumL,nub,isSuffixOf)
import qualified Data.Map as Map
import Data.Maybe
import System.Random
import System.Process
import System.Exit
import System.IO
import System.Directory(removeFile)
import System.Mem(performGC)
import Fold(fold) -- transfer function for OpenMath LaTeX

catchIOE :: IO a -> (E.IOException -> IO a) -> IO a
catchIOE = E.catch

logFile :: FilePath
logFile = "pgf-error.log"

#ifdef C_RUNTIME
type Caches = (Cache PGF,Cache (C.PGF,MVar ParseCache))
type ParseCache = Map.Map (String,String) ([(C.Expr,Float)],UTCTime)
newPGFCache = do pgfCache <- newCache PGF.readPGF
                 cCache <- newCache $ \ path -> do pgf <- C.readPGF path
                                                   pc <- newMVar Map.empty
                                                   return (pgf,pc)
                 return (pgfCache,cCache)
#else
type Caches = (Cache PGF,())
newPGFCache = do pgfCache <- newCache PGF.readPGF
                 return (pgfCache,())
#endif

getPath =
    do path <- getVarWithDefault "PATH_TRANSLATED" "" -- apache mod_fastcgi
       if null path
          then getVarWithDefault "SCRIPT_FILENAME" "" -- lighttpd
          else return path

cgiMain :: Caches -> CGI CGIResult
cgiMain cache = handleErrors . handleCGIErrors $
                  cgiMain' cache =<< getPath

cgiMain' :: Caches -> FilePath -> CGI CGIResult
cgiMain' cache path =
    do command <- liftM (maybe "grammar" (urlDecodeUnicode . UTF8.decodeString))
                        (getInput "command")
       case command of
         "download" -> outputBinary    =<< liftIO (BS.readFile path)
#ifdef C_RUNTIME
         'c':'-':_  -> cpgfMain command =<< liftIO (readCache (snd cache) path)
#endif
         _          -> pgfMain command =<< liftIO (readCache (fst cache) path)

--------------------------------------------------------------------------------
-- * C run-time functionality

#ifdef C_RUNTIME
cpgfMain :: String -> (C.PGF,MVar ParseCache) -> CGI CGIResult
cpgfMain command (pgf,pc) =
  case command of
    "c-parse"     -> out =<< join (parse # input % from % start % limit % trie)
    "c-linearize" -> out =<< lin # tree % to
    "c-translate" -> out =<< join (trans # input % from % to % start % limit % trie)
    "c-flush"     -> out =<< flush
    "c-grammar"   -> out grammar
    _             -> badRequest "Unknown command" command
  where
    flush = liftIO $ do modifyMVar_ pc $ const $ return Map.empty
                        performGC
                        return $ showJSON ()

    grammar = showJSON $ makeObj
                 ["name".=C.abstractName pgf,
                  "startcat".=C.startCat pgf,
                  "languages".=languages]
      where
        languages = [makeObj ["name".= l] | (l,_)<-Map.toList (C.languages pgf)]

    parse input (from,concr) start mlimit trie =
        do trees <- parse' input (from,concr) start mlimit
           return $ showJSON [makeObj ("from".=from:"trees".=map tp trees :[])]
                                                        -- :addTrie trie trees

    tp (tree,prob) = makeObj ["tree".=tree,"prob".=prob]

    parse' input (from,concr) start mlimit = 
        liftIO $ do t <- getCurrentTime
                    (maybe id take mlimit . drop start)
                      # modifyMVar pc (parse'' t)
      where
        key = (from,input)
        parse'' t pc = maybe new old $ Map.lookup key pc
          where
            new = return (update (res,t) pc,res)
              where res = C.parse concr (C.startCat pgf) input
            old (res,_) = return (update (res,t) pc,res)
            update r = Map.mapMaybe purge . Map.insert key r
            purge r@(_,t') = if diffUTCTime t t'<120 then Just r else Nothing
                             -- remove unused parse results after 2 minutes

    lin tree tos = showJSON (lin' tree tos)
    lin' tree tos = [makeObj ["to".=to,"text".=C.linearize c tree]|(to,c)<-tos]

    trans input (from,concr) tos start mlimit trie =
      do parses <- parse' input (from,concr) start mlimit
         return $
           showJSON [ makeObj ["from".=from,
                               "translations".=
                                 [makeObj ["tree".=tree,
                                           "prob".=prob,
                                           "linearizations".=lin' tree tos]
                                  | (tree,prob) <- parses]]]

    from = maybe (missing "from") return =<< getLang "from"
    
    to = getLangs "to"

    getLangs = getLangs' readLang
    getLang = getLang' readLang

    readLang :: String -> CGI (String,C.Concr)
    readLang lang =
      case Map.lookup lang (C.languages pgf) of
        Nothing -> badRequest "Bad language" lang
        Just c -> return (lang,c)

    tree = do s <- maybe (missing "tree") return =<< getInput1 "tree"
              let t = C.readExpr s
              maybe (badRequest "bad tree" s) return t
{-
instance JSON C.CId where
    readJSON x = readJSON x >>= maybe (fail "Bad language.") return . C.readCId
    showJSON = showJSON . C.showCId
-}
instance JSON C.Expr where
    readJSON x = readJSON x >>= maybe (fail "Bad expression.") return . C.readExpr
    showJSON = showJSON . C.showExpr

#endif

--------------------------------------------------------------------------------
-- * Haskell run-time functionality

pgfMain :: String -> PGF -> CGI CGIResult
pgfMain command pgf =
    case command of
      "parse"          -> out =<< doParse pgf # input % cat % from % limit % trie
      "complete"       -> out =<< doComplete pgf # input % cat % from % limit
      "linearize"      -> out =<< doLinearize pgf # tree % to
      "linearizeAll"   -> out =<< doLinearizes pgf # tree % to
      "linearizeTable" -> out =<< doLinearizeTabular pgf # tree % to
      "random"         -> cat >>= \c -> depth >>= \dp -> limit >>= \l -> to >>= \to -> liftIO (doRandom pgf c dp l to) >>= out
      "generate"       -> out =<< doGenerate pgf # cat % depth % limit % to
      "translate"      -> out =<< doTranslate pgf # input % cat % from % to % limit % trie
      "translategroup" -> out =<< doTranslateGroup pgf # input % cat % from % to % limit
      "grammar"        -> out =<< doGrammar pgf # requestAcceptLanguage
      "abstrtree"      -> outputGraphviz =<< abstrTree pgf # graphvizOptions % tree
      "alignment"      -> outputGraphviz =<< alignment pgf # tree % to
      "parsetree"      -> do t <- tree
                             Just l <- from
                             opts <- graphvizOptions
                             outputGraphviz (parseTree pgf l opts t)
      "abstrjson"      -> out . jsonExpr =<< tree
      "browse"         -> join $ doBrowse pgf # optId % cssClass % href % format "html" % getIncludePrintNames
      "external"       -> do cmd <- getInput "external"
                             doExternal cmd =<< input
      _                -> throwCGIError 400 "Unknown command" ["Unknown command: " ++ show command]
  where
    tree :: CGI PGF.Tree
    tree = do ms <- getInput "tree"
              s <- maybe (throwCGIError 400 "No tree given" ["No tree given"]) return ms
              t <- maybe (throwCGIError 400 "Bad tree" ["tree: " ++ s]) return (PGF.readExpr s)
              t <- either (\err -> throwCGIError 400 "Type incorrect tree"
                                                     ["tree: " ++ PGF.showExpr [] t
                                                     ,render (PP.text "error:" <+> PGF.ppTcError err)
                                                     ])
                          (return . fst)
                          (PGF.inferExpr pgf t)
              return t

    cat :: CGI (Maybe PGF.Type)
    cat =
       do mcat  <- getInput1 "cat"
          case mcat of
            Nothing -> return Nothing
            Just cat -> case PGF.readType cat of
                          Nothing  -> throwCGIError 400 "Bad category" ["Bad category: " ++ cat]
                          Just typ -> return $ Just typ  -- typecheck the category

    optId :: CGI (Maybe PGF.CId)
    optId = maybe (return Nothing) rd =<< getInput "id"
      where
        rd = maybe err (return . Just) . PGF.readCId
        err = throwCGIError 400 "Bad identifier" []

    cssClass, href :: CGI (Maybe String)
    cssClass = getInput "css-class"
    href = getInput "href"
    
    getIncludePrintNames :: CGI Bool
    getIncludePrintNames = maybe False (const True) # getInput "printnames"

    graphvizOptions =
        PGF.GraphvizOptions # bool "noleaves"
                            % bool "nofun"
                            % bool "nocat"
                            % string "nodefont"
                            % string "leaffont"
                            % string "nodecolor"
                            % string "leafcolor"
                            % string "nodeedgestyle"
                            % string "leafedgestyle"
      where
        string name = maybe "" id # getInput name
        bool name = maybe False toBool # getInput name

    from = getLang "from"
    to = getLangs "to"

    getLangs = getLangs' readLang
    getLang = getLang' readLang

    readLang :: String -> CGI PGF.Language
    readLang l =
      case PGF.readLanguage l of
        Nothing -> throwCGIError 400 "Bad language" ["Bad language: " ++ l]
        Just lang | lang `elem` PGF.languages pgf -> return lang
                  | otherwise -> throwCGIError 400 "Unknown language" ["Unknown language: " ++ l]

-- * Request parameter access and related auxiliary functions

out = outputJSONP

getInput1 x = nonEmpty # getInput x
nonEmpty (Just "") = Nothing
nonEmpty r = r


input :: CGI String
input = liftM (maybe "" (urlDecodeUnicode . UTF8.decodeString)) $ getInput "input"

getLangs' readLang i = mapM readLang . maybe [] words =<< getInput i

getLang' readLang i =
   do mlang <- getInput i
      case mlang of
        Just l@(_:_) -> Just # readLang l
        _            -> return Nothing


limit, depth :: CGI (Maybe Int)
limit = readInput "limit"
depth = readInput "depth"

start :: CGI Int
start = maybe 0 id # readInput "start"

trie :: CGI Bool
trie = maybe False toBool # getInput "trie"

toBool s = s `elem` ["","yes","true","True"]

missing = badRequest "Missing parameter"
errorMissingId = badRequest "Missing identifier" ""

badRequest msg extra =
    throwCGIError 400 msg [msg ++(if null extra then "" else ": "++extra)]

format def = maybe def id # getInput "format"

-- * Request implementations

-- Hook for simple extensions of the PGF service
doExternal Nothing input = throwCGIError 400 "Unknown external command" ["Unknown external command"]
doExternal (Just cmd) input =
  do liftIO $ logError ("External command: "++cmd)
     cmds <- liftIO $ (fmap lines $ readFile "external_services")
                        `catchIOE` const (return [])
     liftIO $ logError ("External services: "++show cmds)
     if cmd `elem` cmds then ok else err
  where
    err = throwCGIError 400 "Unknown external command" ["Unknown external command: "++cmd]
    ok =
      do let tmpfile1 = "external_input.txt"
             tmpfile2 = "external_output.txt"
         liftIO $ writeFile "external_input.txt" input
         liftIO $ system $ cmd ++ " " ++ tmpfile1 ++ " > " ++ tmpfile2
         liftIO $ removeFile tmpfile1
         r <- outputJSONP =<< liftIO (readFile tmpfile2)
         liftIO $ removeFile tmpfile2
         return r

doTranslate :: PGF -> String -> Maybe PGF.Type -> Maybe PGF.Language -> [PGF.Language] -> Maybe Int -> Bool -> JSValue
doTranslate pgf input mcat mfrom tos mlimit trie =
  showJSON
     [makeObj ("from".=from : "brackets".=bs : jsonTranslateOutput po)
          | (from,po,bs) <- parse' pgf input mcat mfrom]
  where
    jsonTranslateOutput output =
      case output of
        PGF.ParseOk trees ->
            addTrie trie trees++
            ["translations".=
              [makeObj ["tree".=tree,
                        "linearizations".=
                            [makeObj ["to".=to, "text".=text, "brackets".=bs]
                               | (to,text,bs)<- linearizeAndBind pgf tos tree]]
                | tree <- maybe id take mlimit trees]]
        PGF.ParseIncomplete -> ["incomplete".=True]
        PGF.ParseFailed n   -> ["parseFailed".=n]
        PGF.TypeError errs -> jsonTypeErrors errs

jsonTypeErrors errs = 
    ["typeErrors".= [makeObj ["fid".=fid, "msg".=show (PGF.ppTcError err)]
                       | (fid,err) <- errs]]

-- used in phrasebook
doTranslateGroup :: PGF -> String -> Maybe PGF.Type -> Maybe PGF.Language -> [PGF.Language] -> Maybe Int -> JSValue
doTranslateGroup pgf input mcat mfrom tos mlimit =
  showJSON
    [makeObj ["from".=langOnly (PGF.showLanguage from),
              "to".=langOnly (PGF.showLanguage to),
              "linearizations".=
                 [toJSObject (("text", doText alt) : disamb lg from ts)
                    | (ts,alt) <- output, let lg = length output]
              ]
       | 
         (from,po,bs) <- parse' pgf input mcat mfrom,
         (to,output)  <- groupResults [(t, linearizeAndBind pgf tos t) | t <- case po of {PGF.ParseOk ts -> maybe id take mlimit ts; _ -> []}]
          ]
  where
   groupResults = Map.toList . foldr more Map.empty . start . collect
     where
       collect tls = [(t,(l,s)) | (t,ls) <- tls, (l,s,_) <- ls, notDisamb l]
       start ls = [(l,[([t],s)]) | (t,(l,s)) <- ls]
       more (l,s) = Map.insertWith (\ [([t],x)] xs -> insertAlt t x xs) l s

   insertAlt t x xs = case xs of
     (ts,y):xs2 -> if x==y then (t:ts,y):xs2 -- if string is there add only tree
                   else (ts,y) : insertAlt t x xs2
     _ -> [([t],x)]

   doText s = case s of
     c:cs | elem (last s) ".?!" -> toUpper c : init (init cs) ++ [last s]
     _ -> s

   langOnly = reverse . take 3 . reverse

   disamb lg from ts = 
     if lg < 2 
       then [] 
       else [("tree", "-- " ++ groupDisambs [doText (disambLang from t) | t <- ts])]

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

doParse :: PGF -> String -> Maybe PGF.Type -> Maybe PGF.Language -> Maybe Int -> Bool -> JSValue
doParse pgf input mcat mfrom mlimit trie = showJSON $ map makeObj
     ["from".=from : "brackets".=bs : jsonParseOutput po
        | (from,po,bs) <- parse' pgf input mcat mfrom]
  where
    jsonParseOutput output =
      case output of
        PGF.ParseOk trees   -> ["trees".=maybe id take mlimit trees]
                               ++addTrie trie trees
        PGF.TypeError errs  -> jsonTypeErrors errs
        PGF.ParseIncomplete -> ["incomlete".=True]
        PGF.ParseFailed n   -> ["parseFailed".=n]

addTrie trie trees =
    ["trie".=map head (PGF.toTrie (map PGF.toATree trees))|trie]

doComplete :: PGF -> String -> Maybe PGF.Type -> Maybe PGF.Language -> Maybe Int -> JSValue
doComplete pgf input mcat mfrom mlimit = showJSON
    [makeObj ["from".=from, "brackets".=bs, "completions".=cs, "text".=s]
       | from <- froms, let (bs,s,cs) = complete' pgf from cat mlimit input]
  where
    froms = maybe (PGF.languages pgf) (:[]) mfrom
    cat = fromMaybe (PGF.startCat pgf) mcat

doLinearize :: PGF -> PGF.Tree -> [PGF.Language] -> JSValue
doLinearize pgf tree tos = showJSON
    [makeObj ["to".=to, "text".=text,"brackets".=bs]
      | (to,text,bs) <- linearizeAndBind pgf tos tree]

doLinearizes :: PGF -> PGF.Tree -> [PGF.Language] -> JSValue
doLinearizes pgf tree tos = showJSON
    [makeObj ["to".=to, "texts".=map doBind texts]
       | (to,texts) <- linearizes' pgf tos tree]
  where
    linearizes' pgf tos tree =
        [(to,lins to (transfer to tree)) | to <- langs]
      where
        langs = if null tos then PGF.languages pgf else tos
        lins to = nub . concatMap (map snd) . PGF.tabularLinearizes pgf to

doLinearizeTabular :: PGF -> PGF.Tree -> [PGF.Language] -> JSValue
doLinearizeTabular pgf tree tos = showJSON
    [makeObj ["to".=to,
              "table".=[makeObj ["params".=ps,"texts".=ts] | (ps,ts)<-texts]]
       | (to,texts) <- linearizeTabular pgf tos tree]

doRandom :: PGF -> Maybe PGF.Type -> Maybe Int -> Maybe Int -> [PGF.Language] -> IO JSValue
doRandom pgf mcat mdepth mlimit tos =
  do g <- newStdGen
     let trees = PGF.generateRandomDepth g pgf cat (Just depth)
     return $ showJSON
          [makeObj ["tree".=PGF.showExpr [] tree,
                    "linearizations".= doLinearizes pgf tree tos]
             | tree <- limit trees]
  where cat = fromMaybe (PGF.startCat pgf) mcat
        limit = take (fromMaybe 1 mlimit)
        depth = fromMaybe 4 mdepth

doGenerate :: PGF -> Maybe PGF.Type -> Maybe Int -> Maybe Int -> [PGF.Language] -> JSValue
doGenerate pgf mcat mdepth mlimit tos =
    showJSON [makeObj ["tree".=PGF.showExpr [] tree,
                       "linearizations".=
                          [makeObj ["to".=to, "text".=text]
                             | (to,text,bs) <- linearizeAndBind pgf tos tree]]
                | tree <- limit trees]
  where
    trees = PGF.generateAllDepth pgf cat (Just depth)
    cat = fromMaybe (PGF.startCat pgf) mcat
    limit = take (fromMaybe 1 mlimit)
    depth = fromMaybe 4 mdepth

doGrammar :: PGF -> Maybe (Accept Language) -> JSValue
doGrammar pgf macc = showJSON $ makeObj
             ["name".=PGF.abstractName pgf,
              "userLanguage".=selectLanguage pgf macc,
              "startcat".=PGF.showType [] (PGF.startCat pgf),
              "categories".=categories,
              "functions".=functions,
              "languages".=languages]
  where
    languages =
       [makeObj ["name".= l, 
                  "languageCode".= fromMaybe "" (PGF.languageCode pgf l)]
          | l <- PGF.languages pgf]
    categories = [PGF.showCId cat | cat <- PGF.categories pgf]
    functions  = [PGF.showCId fun | fun <- PGF.functions pgf]

outputGraphviz code =
  do fmt <- format "png"
     case fmt of
       "gv" -> outputPlain code
       _ -> outputFPS' fmt =<< liftIO (pipeIt2graphviz fmt code)
  where
    outputFPS' fmt bs =
      do setHeader "Content-Type" (mimeType fmt)
         outputFPS bs

    mimeType fmt =
      case fmt of
        "png" -> "image/png"
        "gif" -> "image/gif"
        "svg" -> "image/svg+xml"
    -- ...
        _     -> "application/binary"

abstrTree pgf      opts tree = PGF.graphvizAbstractTree pgf opts' tree
  where opts' = (not (PGF.noFun opts),not (PGF.noCat opts))

parseTree pgf lang opts tree = PGF.graphvizParseTree pgf lang opts tree

alignment pgf tree tos       = PGF.graphvizAlignment pgf tos' tree
  where tos' = if null tos then PGF.languages pgf else tos

pipeIt2graphviz :: String -> String -> IO BS.ByteString
pipeIt2graphviz fmt code = do
    (Just inh, Just outh, _, pid) <-
        createProcess (proc "dot" ["-T",fmt])
                      { std_in  = CreatePipe,
                        std_out = CreatePipe,
                        std_err = Inherit }

    hSetBinaryMode outh True
    hSetEncoding inh  utf8

    -- fork off a thread to start consuming the output
    output  <- BS.hGetContents outh
    outMVar <- newEmptyMVar
    _ <- forkIO $ E.evaluate (BS.length output) >> putMVar outMVar ()

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

browse1json pgf id pn = makeObj . maybe [] obj $ PGF.browse pgf id
  where
    obj (def,ps,cs) = if pn then (baseobj ++ pnames) else baseobj
      where
        baseobj = ["def".=def, "producers".=ps, "consumers".=cs]
        pnames = ["printnames".=makeObj [(show lang).=PGF.showPrintName pgf lang id | lang <- PGF.languages pgf]]


doBrowse pgf (Just id) _ _ "json" pn = outputJSONP $ browse1json pgf id pn
doBrowse pgf Nothing   _ _ "json" pn =
    outputJSONP $ makeObj ["cats".=all (PGF.categories pgf),
                           "funs".=all (PGF.functions pgf)]
  where
    all = makeObj . map one
    one id = PGF.showCId id.=browse1json pgf id pn

doBrowse pgf Nothing cssClass href _ pn = errorMissingId
doBrowse pgf (Just id) cssClass href _ pn = -- default to "html" format
  outputHTML $
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
                           else "")++
                        (if pn
                           then "<BR/>"++
                                "<H3>Print Names</H3>"++
                                "<P>"++annotatePrintNames++"</P>\n"
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
    
    annotatePrintNames = "<DL>"++(unwords pns)++"</DL>"
      where pns = ["<DT>"++(show lang)++"</DT><DD>"++(PGF.showPrintName pgf lang id)++"</DD>" | lang <- PGF.languages pgf ]

-- | Render trees as JSON with numbered functions
jsonExpr e = evalState (expr (PGF.toATree e)) 0
  where
    expr e =
      case e of
        PGF.Other e -> return (makeObj ["other".=e])
        PGF.App f es ->
                do js <- mapM expr es
                   let children=["children".=js | not (null js)]
                   i<-inc
                   return $ makeObj (["fun".=f,"fid".=i]++children)

    inc :: State Int Int
    inc = do i <- get; put (i+1); return i

instance JSON PGF.Trie where
    showJSON (PGF.Oth e) = makeObj ["other".=e]
    showJSON (PGF.Ap f [[]]) = makeObj ["fun".=f] -- leaf
--  showJSON (PGF.Ap f [es]) = makeObj ["fun".=f,"children".=es] -- one alternative
    showJSON (PGF.Ap f alts) = makeObj ["fun".=f,"alts".=alts]

instance JSON PGF.CId where
    readJSON x = readJSON x >>= maybe (fail "Bad language.") return . PGF.readLanguage
    showJSON = showJSON . PGF.showLanguage

instance JSON PGF.Expr where
    readJSON x = readJSON x >>= maybe (fail "Bad expression.") return . PGF.readExpr
    showJSON = showJSON . PGF.showExpr []

instance JSON PGF.BracketedString where
    readJSON x = return (PGF.Leaf "")
    showJSON (PGF.Bracket cat fid index fun _ bs) =
        makeObj ["cat".=cat, "fid".=fid, "index".=index, "fun".=fun, "children".=bs]
    showJSON (PGF.Leaf s) = makeObj ["token".=s]

-- * PGF utilities

cat :: PGF -> Maybe PGF.Type -> PGF.Type
cat pgf mcat = fromMaybe (PGF.startCat pgf) mcat

parse' :: PGF -> String -> Maybe PGF.Type -> Maybe PGF.Language -> [(PGF.Language,PGF.ParseOutput,PGF.BracketedString)]
parse' pgf input mcat mfrom = 
   [(from,po,bs) | from <- froms, (po,bs) <- [PGF.parse_ pgf from cat Nothing input]]
  where froms = maybe (PGF.languages pgf) (:[]) mfrom
        cat = fromMaybe (PGF.startCat pgf) mcat

complete' :: PGF -> PGF.Language -> PGF.Type -> Maybe Int -> String
         -> (PGF.BracketedString, String, [String])
complete' pgf from typ mlimit input =
  let (ws,prefix) = tokensAndPrefix input
      ps0 = PGF.initState pgf from typ
      (ps,ws') = loop ps0 ws
      bs       = snd (PGF.getParseOutput ps typ Nothing)
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

transfer lang = if "LaTeX" `isSuffixOf` show lang
                then fold -- OpenMath LaTeX transfer
                else id

-- | tabulate all variants and their forms
linearizeTabular
  :: PGF -> [PGF.Language] -> PGF.Tree -> [(PGF.Language,[(String,[String])])]
linearizeTabular pgf tos tree =
    [(to,lintab to (transfer to tree)) | to <- langs]
  where
    langs = if null tos then PGF.languages pgf else tos
    lintab to t = [(p,map doBind (nub [t|(p',t)<-vs,p'==p]))|p<-ps]
      where
        ps = nub (map fst vs)
        vs = concat (PGF.tabularLinearizes pgf to t)

linearizeAndBind pgf mto tree =
    [(to,s,bss) | to<-langs,
                 let bss = PGF.bracketedLinearize pgf to (transfer to tree)
                     s   = unwords . bind $ concatMap PGF.flattenBracketedString bss]
  where
    langs = if null mto then PGF.languages pgf else mto

doBind = unwords . bind . words
bind ws = case ws of
      w : "&+" : u : ws2 -> bind ((w ++ u) : ws2)
      "&+":ws2           -> bind ws2
      w : ws2            -> w : bind ws2
      _ -> ws

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

f .= v = (f,showJSON v)
f # x = fmap f x
f % x = ap f x

--cleanFilePath :: FilePath -> FilePath
--cleanFilePath = takeFileName
