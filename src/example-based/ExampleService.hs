module ExampleService(cgiMain,newPGFCache) where
import Data.Map(fromList)
import PGF
import GF.Compile.ToAPI
import Network.CGI
import Text.JSON
import FastCGIUtils
import Cache
import qualified ExampleDemo as E

newPGFCache = newCache readPGF


cgiMain :: Cache PGF -> CGI CGIResult
cgiMain cache =
    handleErrors . handleCGIErrors $
    do command <- getInp "command"
       environ <- parseEnviron =<< getInp "state"
       cgiMain' cache command environ

cgiMain' cache command environ =
  case command of
    "possibilities" -> outputJSONP (E.getNext environ)
    "provide_example" ->  doProvideExample cache environ
    "abstract_example" -> doAbstractExample cache environ
    "test_function" -> doTestFunction cache environ
    _ -> throwCGIError 400 ("Unknown command: "++command) []

doProvideExample cache environ =
  do Just lang <- readInput "lang"
     fun <- getCId "fun"
     parsePGF <- readParsePGF cache
     pgf <- liftIO . readCache cache =<< getInp "grammar"
     let Just s = E.provideExample environ fun parsePGF pgf lang
     outputJSONP s

doAbstractExample cache environ =
  do example <- getInp "input"
     Just abs <- readInput "abstract"
     Just cat <- readInput "cat"
     let t = mkType [] cat []
     parsePGF <- readParsePGF cache
     let lang:_ = languages parsePGF
     Just (e,_) <- liftIO $ abstractExample parsePGF environ lang t abs example
     outputJSONP e --(showExpr [] (exprToAPI e))

abstractExample parsePGF env lang cat abs example =
    E.searchGoodTree env abs (parse parsePGF lang cat example)

doTestFunction cache environ =
  do fun <- getCId "fun"
     parsePGF <- readParsePGF cache
     let lang:_ = languages parsePGF
     Just txt <- return (E.testThis environ fun parsePGF lang)
     outputJSONP txt

getCId :: String -> CGI CId
getCId name = maybe err return =<< fmap readCId (getInp name)
  where err = throwCGIError 400 ("Bad "++name) []

getLimit :: CGI Int
getLimit = maybe err return =<< readInput "limit"
  where err = throwCGIError 400 "Missing/bad limit" []


readParsePGF cache = liftIO $ readCache cache "ParseEngAbs.pgf"

parseEnviron s = do state <- liftIO $ readIO s
                    return $ environ state

getInp name = maybe err return =<< getInput name
  where err = throwCGIError 400 ("Missing parameter: "++name) []


instance JSON CId where
    showJSON = showJSON . show
    readJSON = (readResult =<<) . readJSON

instance JSON Expr where
   showJSON = showJSON . show
   readJSON = (readResult =<<) . readJSON

readResult s = case reads s of
                 (x,r):_ | lex r==[("","")] -> Ok x
                 _ -> Error "read failed"


--            cat  lincat  fun  lin       fun  cat    cat
environ :: ([(CId, CId)],[(CId, Expr)],[((CId, CId), [CId])]) -> E.Environ
environ (lincats,lins,funs) =
    E.initial (fromList lincats) concmap fs allfs
  where
    concmap = fromList lins
    allfs = map E.mkFuncWithArg funs
    fs = [E.mkFuncWithArg f | f@((fn,_),_)<-funs, fn `elem` cns]
    cns = map fst lins