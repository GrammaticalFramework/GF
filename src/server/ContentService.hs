{-# LANGUAGE DeriveDataTypeable, CPP #-}

import PGF (PGF)
import qualified PGF
import Cache
import FastCGIUtils
import URLEncoding

import Data.Maybe
import Network.FastCGI
import Text.JSON
import qualified Data.ByteString.Lazy as BS
import qualified Codec.Binary.UTF8.String as UTF8 (encodeString, decodeString)

import Control.Monad
import Control.Exception
import Control.Concurrent(forkIO)
import System.Environment(getArgs)
import System.Time
import System.Locale
import System.FilePath
import Database.HSQL.MySQL
import Database.HSQL.Types(toSqlValue)

logFile :: FilePath
logFile = "content-error.log"


main :: IO ()
main = do
  args <- getArgs
  case args of
    []      -> do stderrToFile logFile
                  cache <- newCache dbConnect

#ifndef mingw32_HOST_OS
                  runFastCGIConcurrent' forkIO 100 (cgiMain cache)
#else
                  runFastCGI (cgiMain cache)
#endif
    [fpath] -> do c <- dbConnect fpath
                  dbInit c

getPath = getVarWithDefault "SCRIPT_FILENAME" ""

cgiMain :: Cache Connection -> CGI CGIResult
cgiMain cache = handleErrors . handleCGIErrors $
                  cgiMain' cache =<< getPath

cgiMain' :: Cache Connection -> FilePath -> CGI CGIResult
cgiMain' cache path =
    do c <- liftIO $ readCache cache path
       mb_command <- liftM (liftM (urlDecodeUnicode . UTF8.decodeString)) (getInput "command")
       case mb_command of
         Just "update_grammar"
                       -> do mb_pgf <- getFile
                             id     <- getGrammarId
                             name   <- getFileName
                             descr  <- getDescription
                             userId <- getUserId
                             doUpdateGrammar c mb_pgf id name descr userId
         Just "delete_grammar"
                       -> do id <- getGrammarId
                             userId <- getUserId
                             doDeleteGrammar c id userId
         Just "grammars"
                       -> do userId <- getUserId
                             doGrammars c userId
         Just "save"   -> doSave c =<< getId
         Just "load"   -> doLoad c =<< getId
         Just "search" -> doSearch c =<< getQuery
         Just "delete" -> doDelete c =<< getIds
         Just cmd      -> throwCGIError 400 "Unknown command" ["Unknown command: " ++ show cmd]
         Nothing       -> do mb_uri <- getIdentity
                             mb_email <- getEMail
                             doLogin c mb_uri mb_email
  where
    getUserId :: CGI (Maybe String)
    getUserId = getInput "userId"

    getId :: CGI (Maybe Int)
    getId = readInput "id"

    getIds :: CGI [Int]
    getIds = fmap (map read) (getMultiInput "id")

    getQuery :: CGI String
    getQuery = fmap (fromMaybe "") (getInput "query")

    getGrammarId :: CGI String
    getGrammarId = do 
      mb_url <- getInput "url"
      return (maybe "null" (reverse . takeWhile (/='/') . drop 4 . reverse) mb_url)

    getFile :: CGI (Maybe BS.ByteString)
    getFile = do
      getInputFPS "file"

    getFileName :: CGI String
    getFileName = do
      mb_name0 <- getInput "name"
      let mb_name | mb_name0 == Just "" = Nothing
                  | otherwise           = mb_name0
      mb_file <- getInputFilename "file"
      return (fromMaybe "" (mb_name `mplus` mb_file))

    getDescription :: CGI String
    getDescription = fmap (fromMaybe "") (getInput "description")

    getIdentity :: CGI (Maybe String)
    getIdentity = getInput "openid.identity"

    getEMail :: CGI (Maybe String)
    getEMail = getInput "openid.ext1.value.email"


doLogin c mb_uri mb_email = do
  path <- scriptName
  r <- liftIO $ handleSql (return . Left) $ do
         s <- query c ("call getUserId("++toSqlValue mb_uri++","++toSqlValue mb_email++")")
         [id] <- collectRows getUserId s
         return (Right id)
  case r of
    Right mb_id -> outputHTML (startupHTML mb_id mb_uri mb_email (Just path))
    Left  e     -> throwCGIError 400 "Login failed" (lines (show e))
  where
    getUserId s = do
      id <- getFieldValueMB s "userId"
      return (id :: Maybe Int)

doGrammars c mb_userId = do
  path <- scriptName
  r <- liftIO $ handleSql (return . Left) $ do
         s <- query c ("call getGrammars("++toSqlValue mb_userId++")")
         rows <- collectRows (getGrammar path) s
         return (Right rows)
  case r of
    Right rows -> outputJSONP rows
    Left  e    -> throwCGIError 400 "Loading failed" (lines (show e))
  where
    getGrammar path s = do
      id <- getFieldValue s "id"
      name <- getFieldValue s "name"
      description <- getFieldValue s "description"
      return $ toJSObject [ ("url",  showJSON (dropExtension path ++ '/':addExtension (show (id :: Int)) "pgf"))
                          , ("name", showJSON (name :: String))
                          , ("description", showJSON (description :: String))
                          ]

doUpdateGrammar c mb_pgf id name descr mb_userId = do
  r <- liftIO $ handleSql (return . Left) $ do
         s <- query c ("call updateGrammar("++id++","++toSqlValue name++","++toSqlValue descr++","++toSqlValue mb_userId++")")
         [id] <- collectRows (\s -> getFieldValue s "id") s
         return (Right id)
  nid <- case r of
           Right id -> return (id :: Int)
           Left  e  -> throwCGIError 400 "Saving failed" (lines (show e))
  path <- pathTranslated
  case mb_pgf of
    Just pgf -> if pgf /= BS.empty
                  then liftIO (BS.writeFile (dropExtension  path </> addExtension (show nid) "pgf") pgf)
                  else if id == "null"
                         then throwCGIError 400 "Grammar update failed" []
                         else return ()
    Nothing  -> return ()
  outputHTML ""

doDeleteGrammar c id mb_userId = do
  r <- liftIO $ handleSql (return . Left) $ do
         execute c ("call deleteGrammar("++id++","++toSqlValue mb_userId++")")
         return (Right "")
  case r of
    Right x -> outputJSONP ([] :: [(String,String)])
    Left  e -> throwCGIError 400 "Saving failed" (lines (show e))

doSave c mb_id = do
  body <- getBody
  r <- liftIO $ handleSql (return . Left) $ do
         s <- query c ("call saveDocument("++toSqlValue mb_id++","++toSqlValue body++")")
         [id] <- collectRows (\s -> getFieldValue s "id") s
         return (Right id)
  case r of
    Right id -> outputJSONP (toJSObject [("id", id :: Int)])
    Left  e  -> throwCGIError 400 "Saving failed" (lines (show e))

doLoad c Nothing   = throwCGIError 400 "Loading failed" ["Missing ID"]
doLoad c (Just id) = do
  r <- liftIO $ handleSql (return . Left) $ do
         s <- query c ("SELECT id,title,created,modified,content\n"++
                       "FROM Documents\n"++
                       "WHERE id="++toSqlValue id)
         rows <- collectRows getDocument s
         return (Right rows)
  case r of
    Right [row] -> outputJSONP row
    Right _     -> throwCGIError 400 "Missing document" ["ID="++show id]
    Left  e     -> throwCGIError 400 "Loading failed" (lines (show e))
  where
    getDocument s = do
      id <- getFieldValue s "id"
      title <- getFieldValue s "title"
      created <- getFieldValue s "created" >>= pt
      modified <- getFieldValue s "modified" >>= pt
      content <- getFieldValue s "content"
      return $ toJSObject [ ("id",      showJSON (id :: Int))
                          , ("title",   showJSON (title :: String))
                          , ("created", showJSON (created :: String))
                          , ("modified", showJSON (modified :: String))
                          , ("content", showJSON (content :: String))
                          ]

doSearch c q = do
  r <- liftIO $ handleSql (return . Left) $ do
         s <- query c ("SELECT id,title,created,modified\n"++
                       "FROM Documents"++
                       if null q
                         then ""
                         else "\nWHERE MATCH(content) AGAINST ("++toSqlValue q++" IN BOOLEAN MODE)")
         rows <- collectRows getDocument s
         return (Right rows)
  case r of
    Right rows -> outputJSONP rows
    Left  e    -> throwCGIError 400 "Saving failed" (lines (show e))
  where
    getDocument s = do
      id <- getFieldValue s "id"
      title <- getFieldValue s "title"
      created <- getFieldValue s "created" >>= pt
      modified <- getFieldValue s "modified" >>= pt
      return $ toJSObject [ ("id",      showJSON (id :: Int))
                          , ("title",   showJSON (title :: String))
                          , ("created", showJSON (created :: String))
                          , ("modified", showJSON (modified :: String))
                          ]
                          
pt ct = liftM (formatCalendarTime defaultTimeLocale "%d %b %Y") (toCalendarTime ct)

doDelete c ids = do
  liftIO $
    inTransaction c $ \c ->
      mapM_ (\id -> execute c ("DELETE FROM Documents WHERE id = "++toSqlValue id)) ids
  outputJSONP (toJSObject ([] :: [(String,String)]))

dbConnect fpath = do
  [host,db,user,pwd] <- fmap words $ readFile fpath
  connect host db user pwd

startupHTML mb_id mb_uri mb_email mb_path = unlines [
  "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">",
  "<html>",
  "   <head>",
  "      <meta http-equiv=\"content-type\" content=\"text/html; charset=UTF-8\">",
  "      <title>Editor</title>",
  "      <script type=\"text/javascript\" language=\"javascript\" src=\"org.grammaticalframework.ui.gwt.EditorApp/org.grammaticalframework.ui.gwt.EditorApp.nocache.js\"></script>",
  "   </head>",
  "   <body onload=\"window.__gfInit = new Object(); "++
                    maybe "" (\id    -> "window.__gfInit.userId = "++show id++"; ") mb_id++
                    maybe "" (\uri   -> "window.__gfInit.userURI = '"++uri++"'; ") mb_uri++
                    maybe "" (\email -> "window.__gfInit.userEMail = '"++email++"'; ") mb_email++
                    maybe "" (\path  -> "window.__gfInit.contentURL = '"++path++"'; ") mb_path++
                    "\">",
  "      <iframe src=\"javascript:''\" id=\"__gwt_historyFrame\" tabIndex='-1' style=\"position:absolute;width:0;height:0;border:0\"></iframe>",
  "   </body>",
  "</html>"]

dbInit c = 
  handleSql (fail . show) $ do
    inTransaction c $ \c -> do
      execute c "DROP TABLE IF EXISTS GrammarUsers"
      execute c "DROP TABLE IF EXISTS Users"
      execute c "DROP TABLE IF EXISTS Grammars"
      execute c "DROP TABLE IF EXISTS Documents"
      execute c ("CREATE TABLE Users"++
                 "                (id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,\n"++
                 "                 identity VARCHAR(256) NOT NULL,\n"++
                 "                 email VARCHAR(128) NOT NULL,\n"++
                 "                 UNIQUE INDEX (identity))")
      execute c ("CREATE TABLE Grammars"++
                 "                (id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,"++
                 "                 name VARCHAR(64) NOT NULL,\n"++
                 "                 description VARCHAR(512) NOT NULL,\n"++
                 "                 created TIMESTAMP NOT NULL DEFAULT 0,\n"++
                 "                 modified TIMESTAMP NOT NULL DEFAULT 0)")
      execute c ("CREATE TABLE Documents"++
                 "                (id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,"++
                 "                 title VARCHAR(256) NOT NULL,\n"++
                 "                 created TIMESTAMP NOT NULL DEFAULT 0,\n"++
                 "                 modified TIMESTAMP NOT NULL DEFAULT 0,\n"++
                 "                 content TEXT NOT NULL,\n"++
                 "                 FULLTEXT INDEX (content)) TYPE=MyISAM")
      execute c ("CREATE TABLE GrammarUsers"++
                 "                (userId INTEGER NOT NULL,\n"++
                 "                 grammarId INTEGER NOT NULL,\n"++
                 "                 flags INTEGER NOT NULL,\n"++
                 "                 PRIMARY KEY (userId, grammarId),\n"++
                 "                 FOREIGN KEY (userId) REFERENCES Users(id) ON DELETE CASCADE,\n"++
                 "                 FOREIGN KEY (grammarId) REFERENCES Grammars(id) ON DELETE RESTRICT)")
      execute c "DROP PROCEDURE IF EXISTS saveDocument"
      execute c ("CREATE PROCEDURE saveDocument(IN id INTEGER, content TEXT)\n"++
                 "BEGIN\n"++
                 "   IF id IS NULL THEN\n"++
                 "     INSERT INTO Documents(title,content,created,modified) VALUES (content,content,NOW(),NOW());\n"++
                 "     SELECT LAST_INSERT_ID() as id;\n"++
                 "   ELSE\n"++
                 "     UPDATE Documents d SET content = content, modified=NOW() WHERE d.id = id;\n"++
                 "     select id;\n"++
                 "   END IF;\n"++
                 "END")
      execute c "DROP PROCEDURE IF EXISTS updateGrammar"
      execute c ("CREATE PROCEDURE updateGrammar(IN id INTEGER, name VARCHAR(64), description VARCHAR(512), userId INTEGER)\n"++
                 "BEGIN\n"++
                 "   IF id IS NULL THEN\n"++
                 "     INSERT INTO Grammars(name,description,created,modified) VALUES (name,description,NOW(),NOW());\n"++
                 "     SET id = LAST_INSERT_ID();\n"++
                 "     INSERT INTO GrammarUsers(grammarId,userId,flags) VALUES (id,userId,0);\n"++
                 "   ELSE\n"++
                 "     UPDATE Grammars gr SET name = name, description=description, modified=NOW() WHERE gr.id = id;\n"++
                 "   END IF;\n"++
                 "   SELECT id;\n"++
                 "END")
      execute c "DROP PROCEDURE IF EXISTS deleteGrammar"
      execute c ("CREATE PROCEDURE deleteGrammar(IN aGrammarId INTEGER, aUserId INTEGER)\n"++
                 "BEGIN\n"++
                 "   DECLARE deleted INTEGER;\n"++
                 "   DELETE FROM GrammarUsers\n"++
                 "   WHERE grammarId = aGrammarId AND userId = aUserId;\n"++
                 "   IF NOT EXISTS(SELECT * FROM GrammarUsers gu WHERE gu.grammarId = aGrammarId) THEN\n"++
                 "     DELETE FROM Grammars WHERE id = aGrammarId;\n"++
                 "     SET deleted = 1;\n"++
                 "   ELSE\n"++
                 "     SET deleted = 0;\n"++
                 "   END IF;\n"++
                 "   SELECT deleted;\n"++
                 "END")
      execute c "DROP PROCEDURE IF EXISTS getGrammars"
      execute c ("CREATE PROCEDURE getGrammars(IN userId INTEGER)\n"++
                 "BEGIN\n"++
                 "  SELECT g.id,g.name,g.description\n"++
                 "  FROM Grammars g JOIN GrammarUsers gu ON g.id = gu.grammarId\n"++
                 "  WHERE gu.userId = userId\n"++
                 "  ORDER BY g.name;\n"++
                 "END")
      execute c "DROP PROCEDURE IF EXISTS getUserId"
      execute c ("CREATE PROCEDURE getUserId(identity VARCHAR(256), email VARCHAR(128))\n"++
                 "BEGIN\n"++
                 "  DECLARE userId INTEGER;\n"++
                 "  IF identity IS NULL OR email IS NULL THEN\n"++
                 "    SET userId = NULL;\n"++
                 "  ELSE\n"++
                 "    SELECT id INTO userId FROM Users u WHERE u.identity = identity;\n"++
                 "    IF userId IS NULL THEN\n"++
                 "      INSERT INTO Users(identity, email) VALUES (identity, email);\n"++
                 "      SET userId = LAST_INSERT_ID();\n"++
                 "    END IF;\n"++
                 "  END IF;\n"++
                 "  SELECT userId;\n"++
                 "END")
