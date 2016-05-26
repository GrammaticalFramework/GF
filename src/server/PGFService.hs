{-# LANGUAGE CPP #-}
module PGFService(cgiMain,cgiMain',getPath,
                  logFile,stderrToFile,
                  newPGFCache,flushPGFCache,listPGFCache) where

import PGF (PGF)
import qualified PGF
import PGF.Lexing
import Cache
import CGIUtils(outputJSONP,outputPlain,outputHTML,logError,outputBinary,
                outputBinary',handleCGIErrors,throwCGIError,stderrToFile)
import CGI(CGI,readInput,getInput,getVarWithDefault,
           CGIResult,requestAcceptLanguage,handleErrors,setHeader,
           Accept(..),Language(..),negotiate,liftIO)
import URLEncoding

#if C_RUNTIME
import qualified PGF2 as C
--import Data.Time.Clock(getCurrentTime,diffUTCTime)
#endif

import Data.Time.Clock(UTCTime)
import Data.Time.Format(formatTime)
#if MIN_VERSION_time(1,5,0)
import Data.Time.Format(defaultTimeLocale,rfc822DateFormat)
#else
import System.Locale(defaultTimeLocale,rfc822DateFormat)
#endif
import Text.JSON
import Text.PrettyPrint as PP(render, text, (<+>))
import qualified Codec.Binary.UTF8.String as UTF8 (decodeString)
import qualified Data.ByteString.Lazy as BS

import Control.Concurrent
import qualified Control.Exception as E
import Control.Monad
import Control.Monad.State(State,evalState,get,put)
import Control.Monad.Catch(bracket_)
import Data.Char
--import Data.Function (on)
import Data.List ({-sortBy,-}intersperse,mapAccumL,nub,isSuffixOf,nubBy)
import qualified Data.Map as Map
import Data.Maybe
import System.Random
import System.Process
import System.Exit
import System.IO
import System.IO.Error(isDoesNotExistError,tryIOError)
import System.Directory(removeFile)
import System.FilePath(dropExtension,(<.>))
import System.Mem(performGC)
import Fold(fold) -- transfer function for OpenMath LaTeX

catchIOE :: IO a -> (E.IOException -> IO a) -> IO a
catchIOE = E.catch

withQSem qsem = bracket_ (liftIO $ waitQSem qsem) (liftIO $ signalQSem qsem)

logFile :: FilePath
logFile = "pgf-error.log"

#ifdef C_RUNTIME
type Caches = (Cache PGF,(Cache (C.PGF,({-MVar ParseCache-})),QSem))
--type Caches = (Cache PGF,Cache (C.PGF,({-MVar ParseCache-})))
--type ParseCache = Map.Map (String,String) (ParseResult,UTCTime)
--type ParseResult = Either String [(C.Expr,Float)]

newPGFCache jobs = do pgfCache <- newCache' PGF.readPGF
                      let n = maybe 4 id jobs
                      qsem <- newQSem n
                      cCache <- newCache' $ \ path -> do pgf <- C.readPGF path
                                                       --pc <- newMVar Map.empty
                                                         return (pgf,({-pc-}))
                      return (pgfCache,(cCache,qsem))
flushPGFCache (c1,(c2,_)) = flushCache c1 >> flushCache c2
listPGFCache (c1,(c2,_)) = (,) # listCache c1 % listCache c2
#else
type Caches = (Cache PGF,())
newPGFCache _ = do pgfCache <- newCache' PGF.readPGF
                   return (pgfCache,())
flushPGFCache (c1,_) = flushCache c1
listPGFCache (c1,_) = (,) # listCache c1 % return []
#endif

newCache' rd = do c <- newCache rd
                  forkIO $ forever $ clean c
                  return c
  where
    clean c = do threadDelay 2000000000 -- 2000 seconds, i.e. ~33 minutes
                 expireCache (24*60*60) c -- 24 hours

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
         "download" -> outputBinary    =<< getFile BS.readFile path
         'c':'-':_  ->
#ifdef C_RUNTIME
                   cpgfMain (snd (snd cache)) command
                      =<< getFile (readCache' (fst (snd cache))) path
#else
                   serverError "Server configured without C run-time support" ""
#endif
         _     -> pgfMain path command =<< getFile (readCache' (fst cache)) path

getFile get path =
   either failed return =<< liftIO (E.try (get path))
  where
    failed e = if isDoesNotExistError e
               then notFound path
               else liftIO $ ioError e

--------------------------------------------------------------------------------
-- * C run-time functionality

#ifdef C_RUNTIME
--cpgfMain :: String -> (C.PGF,MVar ParseCache) -> CGI CGIResult
cpgfMain qsem command (t,(pgf,pc)) =
  case command of
    "c-parse"       -> withQSem qsem $
                       out t=<< join (parse # input % start % limit % treeopts)
    "c-linearize"   -> out t=<< lin # tree % to
    "c-linearizeAll"-> out t=<< linAll # tree % to
    "c-translate"   -> withQSem qsem $
                       out t=<<join(trans # input % to % start % limit%treeopts)
    "c-lookupmorpho"-> out t=<< morpho # from1 % textInput
    "c-flush"       -> out t=<< flush
    "c-grammar"     -> out t grammar
    "c-abstrtree"   -> outputGraphviz=<< C.graphvizAbstractTree pgf # tree
    "c-parsetree"   -> outputGraphviz=<< C.graphvizParseTree . snd # from1 %tree
    "c-wordforword" -> out t =<< wordforword # input % to
    _               -> badRequest "Unknown command" command
  where
    flush = liftIO $ do --modifyMVar_ pc $ const $ return Map.empty
                        performGC
                        return $ showJSON ()

    cat = C.startCat pgf
    langs = C.languages pgf

    grammar = showJSON $ makeObj
                 ["name".=C.abstractName pgf,
                  "lastmodified".=show t,
                  "startcat".=C.startCat pgf,
                  "languages".=languages]
      where
        languages = [makeObj ["name".= l] | (l,_)<-Map.toList langs]

    parse input@((from,_),_) start mlimit (trie,json) =
        do r <- parse' start mlimit input
           return $ showJSON [makeObj ("from".=from:jsonParseResult json r)]

    jsonParseResult json = either bad good
      where
        bad err = ["parseFailed".=err]
        good trees = "trees".=map tp trees :[]  -- :addTrie trie trees
        tp (tree,prob) = makeObj (addTree json tree++["prob".=prob])

    -- Without caching parse results:
    parse' start mlimit ((from,concr),input) =
        return $ maybe id take mlimit . drop start # cparse
      where
      --cparse = C.parse concr cat input
        cparse = C.parseWithHeuristics concr cat input (-1) callbacks
        callbacks = maybe [] cb $ lookup (C.abstractName pgf) C.literalCallbacks
        cb fs = [(cat,f pgf (from,concr) input)|(cat,f)<-fs]
{-
    -- Caching parse results:
    parse' start mlimit ((from,concr),input) = 
        liftIO $ do t <- getCurrentTime
                    fmap (maybe id take mlimit . drop start)
                      # modifyMVar pc (parse'' t)
      where
        key = (from,input)
        parse'' t pc = maybe new old $ Map.lookup key pc
          where
            new = return (update (res,t) pc,res)
              where res = C.parse concr cat input
            old (res,_) = return (update (res,t) pc,res)
            update r = Map.mapMaybe purge . Map.insert key r
            purge r@(_,t') = if diffUTCTime t t'<120 then Just r else Nothing
                             -- remove unused parse results after 2 minutes
-}
    linAll tree to = showJSON (linAll' tree to)
    linAll' tree (tos,unlex) =
        [makeObj ["to".=to,
                  "texts".=map unlex (C.linearizeAll c tree)]|(to,c)<-tos]

    lin tree to = showJSON (lin' tree to)
    lin' tree (tos,unlex) =
        [makeObj ["to".=to,"text".=unlex (C.linearize c tree)]|(to,c)<-tos]

    trans input@((from,_),_) to start mlimit (trie,jsontree) =
      do parses <- parse' start mlimit input
         return $
           showJSON [ makeObj ["from".=from,
                               "translations".= jsonParses parses]]
      where
        jsonParses = either bad good
          where
            bad err = [makeObj ["error".=err]]
            good parses = [makeObj (addTree jsontree tree++
                                    ["prob".=prob,
                                     "linearizations".=lin' tree to])
                                    | (tree,prob) <- parses]

    morpho (from,concr) input =
        showJSON [makeObj ["lemma".=l,"analysis".=a,"prob".=p]|(l,a,p)<-ms]
      where ms = C.lookupMorpho concr input


    wordforword input@((from,_),_) = jsonWFW from . wordforword' input

    jsonWFW from rs =
      showJSON
        [makeObj
          ["from".=from,
           "translations".=[makeObj ["linearizations".=
                                        [makeObj["to".=to,"text".=text]
                                         | (to,text)<-rs]]]]]

    wordforword' inp@((from,concr),input) (tos,unlex) =
        [(to,unlex . unwords $ map (lin_word' c) pws)
         |let pws=map parse_word' (words input),(to,c)<-tos]
      where
        lin_word' c = either id (lin1 c)

        lin1 c = dropq . C.linearize c
          where
            dropq (q:' ':s) | q `elem` "+*" = s
            dropq s = s

        parse_word' w = if all (\c->isSpace c||isPunctuation c) w
                        then Left w
                        else parse_word w


        parse_word w =
            maybe (Left ("["++w++"]")) Right $
            msum [parse1 w,parse1 ow,morph w,morph ow]
          where
            ow = if w==lw then capitInit w else lw
            lw = uncapitInit w
            parse1 = either (const Nothing) (fmap fst . listToMaybe) .
                     C.parse concr cat
            morph w = listToMaybe
                        [t | (f,a,p)<-C.lookupMorpho concr w,
                             t<-maybeToList (C.readExpr f)]

    ---

    input = lexit # from % textInput
      where
        lexit (from,lex) input = (from,lex input)

        from = maybe (missing "from") getlexer =<< from'
          where
            getlexer f@(_,concr) = (,) f # c_lexer concr

    from1 = maybe (missing "from") return =<< from'
    from' = getLang "from"

    to = (,) # getLangs "to" % unlexerC

    getLangs = getLangs' readLang
    getLang = getLang' readLang

    readLang :: String -> CGI (String,C.Concr)
    readLang lang =
      case Map.lookup lang langs of
        Nothing -> badRequest "Bad language" lang
        Just c -> return (lang,c)

    tree = do s <- maybe (missing "tree") return =<< getInput1 "tree"
              let t = C.readExpr s
              maybe (badRequest "bad tree" s) return t

    --c_lexer concr = lexer
    c_lexer concr = ilexer (not . null . C.lookupMorpho concr)

--------------------------------------------------------------------------------

{-
instance JSON C.CId where
    readJSON x = readJSON x >>= maybe (fail "Bad language.") return . C.readCId
    showJSON = showJSON . C.showCId
-}
instance JSON C.Expr where
    readJSON x = readJSON x >>= maybe (fail "Bad expression.") return . C.readExpr
    showJSON = showJSON . C.showExpr


-- | Convert a 'Tree' to an 'ATree'
cToATree :: C.Expr -> PGF.ATree C.Expr
cToATree e = maybe (PGF.Other e) app (C.unApp e)
  where
    app (f,es) = PGF.App (read f) (map cToATree es)

instance ToATree C.Expr where
  showTree = show
  toATree = cToATree

#endif

--------------------------------------------------------------------------------
-- * Lexing

-- | Lexers with a text lexer that tries to be a more clever with the first word
ilexer good = lexer' uncap
  where
    uncap s = case span isUpper s of
                ([c],r) | not (good s) -> toLower c:r
                _ -> s

-- | Standard lexers
lexer = lexer' uncapitInit

lexer' uncap = maybe (return id) lexerfun =<< getInput "lexer" 
  where
    lexerfun name =
       case name of
         "text"  -> return (unwords . lexText' uncap)
         "code"  -> return (unwords . lexCode)
         "mixed" -> return (unwords . lexMixed)
         _ -> badRequest "Unknown lexer" name


type Unlexer = String->String

-- | Unlexing for the C runtime system, &+ is already applied
unlexerC :: CGI Unlexer
unlexerC = maybe (return id) unlexerfun =<< getInput "unlexer"
  where
    unlexerfun name =
       case name of
         "text"  -> return (unlexText' . words)
         "code"  -> return (unlexCode . words)
         "mixed" -> return (unlexMixed . words)
         "none"  -> return id
         "id"    -> return id
         _ -> badRequest "Unknown lexer" name

-- | Unlex text, skipping the quality marker used by the App grammar
unlexText' ("+":ws) = "+ "++unlexText ws
unlexText' ("*":ws) = "* "++unlexText ws
unlexText' ws       = unlexText ws

-- | Unlexing for the Haskell run-time, applying the &+ operator first
unlexerH :: CGI Unlexer
unlexerH = maybe (return doBind) unlexerfun =<< getInput "unlexer"
  where
    unlexerfun name =
       case name of
         "text"  -> return (unlexText' . bind)
         "code"  -> return (unlexCode . bind)
         "mixed" -> return (unlexMixed . bind)
         "none"  -> return id
         "id"    -> return id
         "bind"  -> return doBind
         _ -> badRequest "Unknown lexer" name

    doBind = unwords . bind
    bind = bindTok . words

--------------------------------------------------------------------------------
-- * Haskell run-time functionality

--pgfMain :: FilePath -> String -> PGF -> CGI CGIResult
pgfMain path command (t,pgf) =
    case command of
      "parse"          -> o =<< doParse pgf # input % cat % limit % treeopts
      "complete"       -> o =<< doComplete pgf # input % cat % limit % full
      "linearize"      -> o =<< doLinearize pgf # tree % to
      "linearizeAll"   -> o =<< doLinearizes pgf # tree % to
      "linearizeTable" -> o =<< doLinearizeTabular pgf # tree % to
      "random"         -> o =<< join (doRandom pgf # cat % depth % limit % to)
      "generate"       -> o =<< doGenerate pgf # cat % depth % limit % to
      "translate"      -> o =<< doTranslate pgf # input % cat %to%limit%treeopts
      "translategroup" -> o =<< doTranslateGroup pgf # input % cat % to % limit
      "lookupmorpho"   -> o =<< doLookupMorpho pgf # from1 % textInput
      "grammar"        -> o =<< doGrammar t pgf # requestAcceptLanguage
      "abstrtree"      -> outputGraphviz =<< abstrTree pgf # graphvizOptions % tree
      "alignment"      -> outputGraphviz =<< alignment pgf # tree % to
      "parsetree"      -> outputGraphviz =<< parseTree pgf # from1 % graphvizOptions % tree
      "deptree"        -> join $ doDepTree path pgf # format "dot" % to1 % tree
      "abstrjson"      -> o . jsonExpr =<< tree
      "browse"         -> join $ doBrowse pgf # optId % cssClass % href % format "html" % getIncludePrintNames
      "external"       -> do cmd <- getInput "external"
                             doExternal cmd =<< textInput
      _                -> badRequest "Unknown command" command
  where
    o x = out t x

    input = do fr <- from
               lex <- mlexer fr
               inp <- textInput
               return (fr,lex inp)

    mlexer Nothing = lexer
    mlexer (Just lang) = ilexer (PGF.isInMorpho morpho)
      where morpho = PGF.buildMorpho pgf lang

    tree :: CGI PGF.Tree
    tree = do ms <- getInput "tree"
              s <- maybe (badRequest "No tree given" "") return ms
              t <- maybe (badRequest "Bad tree" s) return (PGF.readExpr s)
              t <- either (\err -> badRequest "Type incorrect tree"
                                              (unlines $
                                              [PGF.showExpr [] t
                                              ,render (PP.text "error:" <+> PGF.ppTcError err)
                                              ]))
                          (return . fst)
                          (PGF.inferExpr pgf t)
              return t

    cat :: CGI (Maybe PGF.Type)
    cat =
       do mcat  <- getInput1 "cat"
          case mcat of
            Nothing -> return Nothing
            Just cat -> case PGF.readType cat of
                          Nothing  -> badRequest "Bad category" cat
                          Just typ -> return $ Just typ  -- typecheck the category

    optId :: CGI (Maybe PGF.CId)
    optId = maybe (return Nothing) rd =<< getInput "id"
      where
        rd = maybe err (return . Just) . PGF.readCId
        err = badRequest "Bad identifier" []

    cssClass, href :: CGI (Maybe String)
    cssClass = getInput "css-class"
    href = getInput "href"
    
    getIncludePrintNames :: CGI Bool
    getIncludePrintNames = maybe False (const True) # getInput "printnames"

    graphvizOptions =
        PGF.GraphvizOptions # bool "noleaves"
                            % bool "nofun"
                            % bool "nocat"
                            % bool "nodep"
                            % string "nodefont"
                            % string "leaffont"
                            % string "nodecolor"
                            % string "leafcolor"
                            % string "nodeedgestyle"
                            % string "leafedgestyle"
      where
        string name = maybe "" id # getInput name
        bool name = maybe False toBool # getInput name

    from1 = maybe (missing "from") return =<< from
    from = getLang "from"

    to1 = maybe (missing "to") return =<< getLang "to"
    to = (,) # getLangs "to" % unlexerH

    getLangs = getLangs' readLang
    getLang = getLang' readLang

    readLang :: String -> CGI PGF.Language
    readLang l =
      case PGF.readLanguage l of
        Nothing -> badRequest "Bad language" l
        Just lang | lang `elem` PGF.languages pgf -> return lang
                  | otherwise -> badRequest "Unknown language" l

    full :: CGI Bool
    full = maybe False toBool # getInput "full"

-- * Request parameter access and related auxiliary functions

--out = outputJSONP
out t r = do let fmt = formatTime defaultTimeLocale rfc822DateFormat t
             setHeader "Last-Modified" fmt
             outputJSONP r

getInput1 x = nonEmpty # getInput x
nonEmpty (Just "") = Nothing
nonEmpty r = r

textInput :: CGI String
textInput = liftM (maybe "" (urlDecodeUnicode . UTF8.decodeString)) $ getInput "input"

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

treeopts :: CGI TreeOpts
treeopts = (,) # getBool "trie" % getBool "jsontree"

getBool x = maybe False toBool # getInput x
toBool s = s `elem` ["","yes","true","True"]

missing = badRequest "Missing parameter"
errorMissingId = badRequest "Missing identifier" ""

notFound = throw 404 "Not found"
badRequest = throw 400
serverError = throw 500

throw code msg extra =
    throwCGIError code msg [msg ++(if null extra then "" else ": "++extra)]

format def = maybe def id # getInput "format"

-- * Request implementations

-- Hook for simple extensions of the PGF service
doExternal Nothing input = badRequest "Unknown external command" ""
doExternal (Just cmd) input =
  do liftIO $ logError ("External command: "++cmd)
     cmds <- liftIO $ (fmap lines $ readFile "external_services")
                        `catchIOE` const (return [])
     liftIO $ logError ("External services: "++show cmds)
     if cmd `elem` cmds then ok else err
  where
    err = badRequest "Unknown external command" cmd
    ok =
      do let tmpfile1 = "external_input.txt"
             tmpfile2 = "external_output.txt"
         liftIO $ writeFile "external_input.txt" input
         liftIO $ system $ cmd ++ " " ++ tmpfile1 ++ " > " ++ tmpfile2
         liftIO $ removeFile tmpfile1
         r <- outputJSONP =<< liftIO (readFile tmpfile2)
         liftIO $ removeFile tmpfile2
         return r

doLookupMorpho :: PGF -> PGF.Language -> String -> JSValue
doLookupMorpho pgf from input =
    showJSON [makeObj ["lemma".=l,"analysis".=a]|(l,a)<-ms]
  where
    ms = PGF.lookupMorpho (PGF.buildMorpho pgf from) input


type From = (Maybe PGF.Language,String)
type To = ([PGF.Language],Unlexer)
type TreeOpts = (Bool,Bool) -- (trie,jsontree)

doTranslate :: PGF -> From -> Maybe PGF.Type -> To -> Maybe Int -> TreeOpts -> JSValue
doTranslate pgf (mfrom,input) mcat tos mlimit (trie,jsontree) =
  showJSON
     [makeObj ("from".=from : "brackets".=bs : jsonTranslateOutput po)
          | (from,po,bs) <- parse' pgf input mcat mfrom]
  where
    jsonTranslateOutput output =
      case output of
        PGF.ParseOk trees ->
            addTrie trie trees++
            ["translations".=
              [makeObj (addTree jsontree tree++
                       ["linearizations".=
                            [makeObj ["to".=to, "text".=text,
                                      "brackets".=bs]
                               | (to,text,bs)<- linearizeAndUnlex pgf tos tree]])
                | tree <- maybe id take mlimit trees]]
        PGF.ParseIncomplete -> ["incomplete".=True]
        PGF.ParseFailed n   -> ["parseFailed".=n]
        PGF.TypeError errs -> jsonTypeErrors errs

jsonTypeErrors errs = 
    ["typeErrors".= [makeObj ["fid".=fid, "msg".=show (PGF.ppTcError err)]
                       | (fid,err) <- errs]]

-- used in phrasebook
doTranslateGroup :: PGF -> From -> Maybe PGF.Type -> To -> Maybe Int -> JSValue
doTranslateGroup pgf (mfrom,input) mcat tos mlimit =
  showJSON
    [makeObj ["from".=langOnly (PGF.showLanguage from),
              "to".=langOnly (PGF.showLanguage to),
              "linearizations".=
                 [toJSObject (("text",alt) : disamb lg from ts)
                    | let lg = length output, (ts,alt) <- output]
              ]
       | 
         (from,po,bs) <- parse' pgf input mcat mfrom,
         (to,output)  <- groupResults [(t, linearizeAndUnlex pgf tos t) | t <- case po of {PGF.ParseOk ts -> maybe id take mlimit ts; _ -> []}]
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

   langOnly = reverse . take 3 . reverse

   disamb lg from ts = 
     if lg < 2 
       then [] 
       else [("tree", "-- " ++ groupDisambs [disambLang from t | t <- ts])]

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

doParse :: PGF -> From -> Maybe PGF.Type -> Maybe Int -> TreeOpts -> JSValue
doParse pgf (mfrom,input) mcat mlimit (trie,jsontree) = showJSON $ map makeObj
     ["from".=from : "brackets".=bs : jsonParseOutput po
        | (from,po,bs) <- parse' pgf input mcat mfrom]
  where
    jsonParseOutput output =
      case output of
        PGF.ParseOk trees   -> ["trees".=trees']
                               ++["jsontrees".=map jsonExpr trees'|jsontree]
                               ++addTrie trie trees
          where trees' = maybe id take mlimit trees
        PGF.TypeError errs  -> jsonTypeErrors errs
        PGF.ParseIncomplete -> ["incomplete".=True]
        PGF.ParseFailed n   -> ["parseFailed".=n]

addTrie trie trees =
    ["trie".=map head (PGF.toTrie (map PGF.toATree trees))|trie]

addTree json tree = "tree".=showTree tree:
                    ["jsontree".= jsonExpr tree | json]

doComplete :: PGF -> From -> Maybe PGF.Type -> Maybe Int -> Bool -> JSValue
doComplete pgf (mfrom,input) mcat mlimit full = showJSON
    [makeObj (
        ["from".=from, "brackets".=bs, "text".=s] ++
        if full
          then [ "completions" .= Map.elems (Map.mapWithKey (completionInfo pgf) cs) ]
          else [ "completions" .= Map.keys cs ]
        )
    | from <- froms, let (bs,s,cs) = complete' pgf from cat mlimit input]
  where
    froms = maybe (PGF.languages pgf) (:[]) mfrom
    cat = fromMaybe (PGF.startCat pgf) mcat

completionInfo :: PGF -> PGF.Token -> PGF.ParseState -> JSValue
completionInfo pgf token pstate =
  makeObj
  ["token".= token
  ,"funs" .= (map mkFun (nubBy ignoreFunIds funs))
  ]
  where
    contInfo = PGF.getContinuationInfo pstate
    funs = snd . head $ Map.toList contInfo -- always get [([],_)] ; funs :: [(fid,cid,seq)]
    ignoreFunIds (_,cid1,seq1) (_,cid2,seq2) = (cid1,seq1) == (cid2,seq2)
    mkFun (funid,cid,seq) = case PGF.functionType pgf cid of
      Just typ ->
        makeObj [ {-"fid".=funid,-} "fun".=cid, "hyps".=hyps', "cat".=cat, "seq".=seq ]
        where
          (hyps,cat,_es) = PGF.unType typ
          hyps' = [ PGF.showType [] typ | (_,_,typ) <- hyps ]
      Nothing -> makeObj [ "error".=("Function "++show cid++" not found") ] -- shouldn't happen

doLinearize :: PGF -> PGF.Tree -> To -> JSValue
doLinearize pgf tree tos = showJSON
    [makeObj ["to".=to, "text".=text,"brackets".=bs]
      | (to,text,bs) <- linearizeAndUnlex pgf tos tree]

doLinearizes :: PGF -> PGF.Tree -> To -> JSValue
doLinearizes pgf tree (tos,unlex) = showJSON
    [makeObj ["to".=to, "texts".=map unlex texts]
       | (to,texts) <- linearizes' pgf tos tree]
  where
    linearizes' pgf tos tree =
        [(to,lins to (transfer to tree)) | to <- langs]
      where
        langs = if null tos then PGF.languages pgf else tos
        lins to = nub . concatMap (map snd) . PGF.tabularLinearizes pgf to

doLinearizeTabular :: PGF -> PGF.Tree -> To -> JSValue
doLinearizeTabular pgf tree tos = showJSON
    [makeObj ["to".=to,
              "table".=[makeObj ["params".=ps,"texts".=ts]
                         | (ps,ts)<-texts]]
       | (to,texts) <- linearizeTabular pgf tos tree]

doRandom :: PGF -> Maybe PGF.Type -> Maybe Int -> Maybe Int -> To -> CGI JSValue
doRandom pgf mcat mdepth mlimit to =
  liftIO $
  do g <- newStdGen
     let trees = PGF.generateRandomDepth g pgf cat (Just depth)
     return $ showJSON
          [makeObj ["tree".=PGF.showExpr [] tree,
                    "linearizations".= doLinearizes pgf tree to]
             | tree <- limit trees]
  where cat = fromMaybe (PGF.startCat pgf) mcat
        limit = take (fromMaybe 1 mlimit)
        depth = fromMaybe 4 mdepth

doGenerate :: PGF -> Maybe PGF.Type -> Maybe Int -> Maybe Int -> To -> JSValue
doGenerate pgf mcat mdepth mlimit tos =
    showJSON [makeObj ["tree".=PGF.showExpr [] tree,
                       "linearizations".=
                          [makeObj ["to".=to, "text".=text]
                             | (to,text,bs) <- linearizeAndUnlex pgf tos tree]]
                | tree <- limit trees]
  where
    trees = PGF.generateAllDepth pgf cat (Just depth)
    cat = fromMaybe (PGF.startCat pgf) mcat
    limit = take (fromMaybe 1 mlimit)
    depth = fromMaybe 4 mdepth

doGrammar :: UTCTime -> PGF -> Maybe (Accept Language) -> JSValue
doGrammar t pgf macc = showJSON $ makeObj
             ["name".=PGF.abstractName pgf,
              "lastmodified".=show t,
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
    outputFPS' = outputBinary' . mimeType

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

doDepTree path pgf fmt lang tree =
  do lbls <- either (const Nothing) Just # liftIO (tryIOError readDepLabels)
     let vis = PGF.graphvizDependencyTree fmt False lbls Nothing pgf lang tree
     if fmt `elem` ["png","gif","svg","gv"]
       then outputGraphviz vis
       else outputPlain vis
  where
    labelsPath = dropExtension path <.> "labels"
    readDepLabels = PGF.getDepLabels . lines # readFile labelsPath

alignment pgf tree (tos,unlex) = PGF.graphvizAlignment pgf tos' tree
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

class ToATree a where 
  showTree :: a -> String
  toATree :: a -> PGF.ATree a

instance ToATree PGF.Expr where
  showTree = PGF.showExpr []
  toATree = PGF.toATree

-- | Render trees as JSON with numbered functions
jsonExpr e = evalState (expr (toATree e)) 0
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
{-
cat :: PGF -> Maybe PGF.Type -> PGF.Type
cat pgf mcat = fromMaybe (PGF.startCat pgf) mcat
-}
parse' :: PGF -> String -> Maybe PGF.Type -> Maybe PGF.Language -> [(PGF.Language,PGF.ParseOutput,PGF.BracketedString)]
parse' pgf input mcat mfrom = 
   [(from,po,bs) | from <- froms, (po,bs) <- [PGF.parse_ pgf from cat Nothing input]]
  where froms = maybe (PGF.languages pgf) (:[]) mfrom
        cat = fromMaybe (PGF.startCat pgf) mcat

complete' :: PGF -> PGF.Language -> PGF.Type -> Maybe Int -> String
         -> (PGF.BracketedString, String, Map.Map PGF.Token PGF.ParseState)
complete' pgf from typ mlimit input =
  let (ws,prefix) = tokensAndPrefix input
      ps0 = PGF.initState pgf from typ
      (ps,ws') = loop ps0 ws
      bs       = snd (PGF.getParseOutput ps typ Nothing)
  in if not (null ws')
       then (bs, unwords (if null prefix then ws' else ws'++[prefix]), Map.empty)
       else (bs, prefix, PGF.getCompletions ps prefix)
  where
  --order = sortBy (compare `on` map toLower)

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
  :: PGF -> To -> PGF.Tree -> [(PGF.Language,[(String,[String])])]
linearizeTabular pgf (tos,unlex) tree =
    [(to,lintab to (transfer to tree)) | to <- langs]
  where
    langs = if null tos then PGF.languages pgf else tos
    lintab to t = [(p,map unlex (nub [t|(p',t)<-vs,p'==p]))|p<-ps]
      where
        ps = nub (map fst vs)
        vs = concat (PGF.tabularLinearizes pgf to t)

linearizeAndUnlex pgf (mto,unlex) tree =
    [(to,s,bss) | to<-langs,
                 let bss = PGF.bracketedLinearize pgf to (transfer to tree)
                     s   = unlex . unwords $ concatMap PGF.flattenBracketedString bss]
  where
    langs = if null mto then PGF.languages pgf else mto

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

infixl 2 #,%

f .= v = (f,showJSON v)
f # x = fmap f x
f % x = ap f x

--cleanFilePath :: FilePath -> FilePath
--cleanFilePath = takeFileName
