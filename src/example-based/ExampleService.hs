module ExampleService(cgiMain,cgiMain',newPGFCache) where
import System.Random(newStdGen)
import System.FilePath((</>),makeRelative)
import Data.Map(fromList)
import Data.Char(isDigit)
import Data.Maybe(fromJust)
import qualified Codec.Binary.UTF8.String as UTF8 (decodeString)
import PGF
import GF.Compile.ToAPI
import Network.CGI
import Text.JSON
import CGIUtils
import Cache
import qualified ExampleDemo as E

newPGFCache = newCache readPGF


cgiMain :: Cache PGF -> CGI CGIResult
cgiMain = handleErrors . handleCGIErrors . cgiMain' "." "."

cgiMain' root cwd cache =
  do command <- getInp "command"
     environ <- parseEnviron =<< getInp "state"
     case command of
       "possibilities"    -> doPossibilities environ
       "provide_example"  -> doProvideExample root cwd cache environ
       "abstract_example" -> doAbstractExample cwd cache environ
       "test_function"    -> doTestFunction cwd cache environ
       _ -> throwCGIError 400 ("Unknown command: "++command) []

doPossibilities environ =
  do example_environ <- parseEnviron =<< getInp "example_state"
     outputJSONP (E.getNext environ example_environ)

doProvideExample root cwd cache environ =
  do Just lang <- readInput "lang"
     fun <- getCId "fun"
     parsePGF <- readParsePGF cwd cache
     let adjpath path = root</>makeRelative "/" (makeRelative root cwd</>path)
     pgf <- liftIO . readCache cache . adjpath =<< getInp "grammar"
     gen <- liftIO newStdGen
     let Just (e,s) = E.provideExample gen environ fun parsePGF pgf lang
         res = (showExpr [] e,s)
     liftIO $ logError $ "proveExample ... = "++show res
     outputJSONP res

doAbstractExample cwd cache environ =
  do example <- getInp "input"
     Just params <- readInput "params"
     absstr <- getInp "abstract"
     Just abs <- return $ readExpr absstr
     liftIO $ logError $ "abstract = "++showExpr [] abs
     Just cat <- readInput "cat"
     let t = mkType [] cat []
     parsePGF <- readParsePGF cwd cache
     let lang:_ = languages parsePGF
     ae <- liftIO $ abstractExample parsePGF environ lang t abs example
     outputJSONP (fmap (\(e,_)->(exprToAPI (instExpMeta params e),e)) ae)

abstractExample parsePGF env lang cat abs example =
    E.searchGoodTree env abs (parse parsePGF lang cat example)

doTestFunction cwd cache environ =
  do fun <- getCId "fun"
     parsePGF <- readParsePGF cwd cache
     let lang:_ = languages parsePGF
     Just txt <- return (E.testThis environ fun parsePGF lang)
     outputJSONP txt

getCId :: String -> CGI CId
getCId name = maybe err return =<< fmap readCId (getInp name)
  where err = throwCGIError 400 ("Bad "++name) []
{-
getLimit :: CGI Int
getLimit = maybe err return =<< readInput "limit"
  where err = throwCGIError 400 "Missing/bad limit" []
-}

readParsePGF cwd cache =
    do parsepgf <- getInp "parser"
       liftIO $ readCache cache (cwd</>parsepgf)

parseEnviron s = do state <- liftIO $ readIO s
                    return $ environ state

getInp name = maybe err (return . UTF8.decodeString) =<< getInput name
  where err = throwCGIError 400 ("Missing parameter: "++name) []


instance JSON CId where
    showJSON = showJSON . show
    readJSON = (readResult =<<) . readJSON

instance JSON Expr where
   showJSON = showJSON . showExpr []
   readJSON = (m2r . readExpr =<<) . readJSON

m2r = maybe (Error "read failed") Ok

readResult s = case reads s of
                 (x,r):_ | lex r==[("","")] -> Ok x
                 _ -> Error "read failed"

--------------------------------------------------------------------------------
--            cat  lincat  fun  lin       fun  cat    cat
environ :: ([(CId, CId)],[(CId, Expr)],[((CId, CId), [CId])]) -> E.Environ
environ (lincats,lins0,funs) =
    E.initial (fromList lincats) concmap fs allfs
  where
    concmap = fromList lins
    allfs = map E.mkFuncWithArg funs
    fs = [E.mkFuncWithArg f | f@((fn,_),_)<-funs, fn `elem` cns]
    cns = map fst lins
    lins = filter (not . E.isMeta .snd) lins0


instExpMeta :: [CId] -> Expr -> Expr
instExpMeta ps = fromJust . readExpr . instMeta ps . showExpr []

instMeta :: [CId] -> String -> String
instMeta ps s =
  case break (=='?') s of
    (s1,'?':s2) ->
       case span isDigit s2 of
         (s21@(_:_),s22) -> s1++show (ps!!(read s21-1))++instMeta ps s22
         ("",s22) -> s1++'?':instMeta ps s22
    (_,_) -> s
