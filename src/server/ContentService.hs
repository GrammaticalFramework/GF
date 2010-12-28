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
import System.Environment(getArgs)
import System.Time
import System.Locale
import System.FilePath
import Database.HSQL.MySQL

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
                             id  <- getGrammarId
                             name   <- getFileName
                             descr  <- getDescription
                             doUpdateGrammar c mb_pgf id name descr
         Just "delete_grammar"
                       -> do id <- getGrammarId
                             doDeleteGrammar c id
         Just "grammars"
                       -> doGrammars c
         Just "save"   -> doSave c =<< getId
         Just "load"   -> doLoad c =<< getId
         Just "search" -> doSearch c =<< getQuery
         Just "delete" -> doDelete c =<< getIds
         Just cmd      -> throwCGIError 400 "Unknown command" ["Unknown command: " ++ show cmd]
         Nothing       -> throwCGIError 400 "No command given" ["No command given"]
  where
    getId :: CGI (Maybe Int)
    getId = readInput "id"

    getIds :: CGI [Int]
    getIds = fmap (map read) (getMultiInput "id")

    getQuery :: CGI String
    getQuery = fmap (fromMaybe "") (getInput "query")

    getGrammarId :: CGI String
    getGrammarId = do 
      mb_url <- getInput "url"
      return (maybe "null" (reverse . drop 4 . reverse) mb_url)

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

doGrammars c = do
  r <- liftIO $ handleSql (return . Left) $ do
         s <- query c "call getGrammars()"
         rows <- collectRows getGrammar s
         return (Right rows)
  case r of
    Right rows -> outputJSONP rows
    Left  e    -> throwCGIError 400 "Loading failed" (lines (show e))
  where
    getGrammar s = do
      id <- getFieldValue s "id"
      name <- getFieldValue s "name"
      description <- getFieldValue s "description"
      return $ toJSObject [ ("url",  showJSON (addExtension (show (id :: Int)) "pgf"))
                          , ("name", showJSON (name :: String))
                          , ("description", showJSON (description :: String))
                          ]

doUpdateGrammar c mb_pgf id name descr = do
  r <- liftIO $ handleSql (return . Left) $ do
         s <- query c ("call updateGrammar("++id++","++toSqlValue name++","++toSqlValue descr++")")
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

doDeleteGrammar c id = do
  r <- liftIO $ handleSql (return . Left) $ do
         execute c ("call deleteGrammar("++id++")")
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

dbInit c = 
  handleSql (fail . show) $ do
    inTransaction c $ \c -> do
      execute c "DROP TABLE IF EXISTS Documents"
      execute c ("CREATE TABLE Documents(id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,"++
                 "                       title VARCHAR(256) NOT NULL,\n"++
                 "                       created TIMESTAMP NOT NULL DEFAULT 0,\n"++
                 "                       modified TIMESTAMP NOT NULL DEFAULT 0,\n"++
                 "                       content TEXT NOT NULL,\n"++
                 "                       FULLTEXT INDEX (content)) TYPE=MyISAM")
      execute c "DROP TABLE IF EXISTS Grammars"
      execute c ("CREATE TABLE Grammars(id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,"++
                 "                      name VARCHAR(64) NOT NULL,\n"++
                 "                      description VARCHAR(512) NOT NULL,\n"++
                 "                      created TIMESTAMP NOT NULL DEFAULT 0,\n"++
                 "                      modified TIMESTAMP NOT NULL DEFAULT 0)")
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
      execute c ("CREATE PROCEDURE updateGrammar(IN id INTEGER, name VARCHAR(64), description VARCHAR(512))\n"++
                 "BEGIN\n"++
                 "   IF id IS NULL THEN\n"++
                 "     INSERT INTO Grammars(name,description,created,modified) VALUES (name,description,NOW(),NOW());\n"++
                 "     SELECT LAST_INSERT_ID() as id;\n"++
                 "   ELSE\n"++
                 "     UPDATE Grammars gr SET name = name, description=description, modified=NOW() WHERE gr.id = id;\n"++
                 "     select id;\n"++
                 "   END IF;\n"++
                 "END")
      execute c "DROP PROCEDURE IF EXISTS deleteGrammar"
      execute c ("CREATE PROCEDURE deleteGrammar(IN grammarId INTEGER)\n"++
                 "BEGIN\n"++
                 "   DELETE FROM Grammars WHERE id = grammarId;\n"++
                 "END")
      execute c "DROP PROCEDURE IF EXISTS getGrammars"
      execute c ("CREATE PROCEDURE getGrammars()\n"++
                 "BEGIN\n"++
                 "  SELECT id,name,description FROM Grammars ORDER BY name;\n"++
                 "END")
