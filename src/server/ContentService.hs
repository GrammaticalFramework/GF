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
         Just "save"   -> doSave c =<< getId
         Just "load"   -> doLoad c =<< getId
         Just "search" -> doSearch c =<< getQuery
         Just "delete" -> doDelete c =<< getIds
         Just "update_grammar"
                       -> do mb_pgf <- getFile
                             name   <- getFileName
                             descr  <- getDescription
                             doUpdateGrammar c mb_pgf name descr
         Just cmd      -> throwCGIError 400 "Unknown command" ["Unknown command: " ++ show cmd]
         Nothing       -> throwCGIError 400 "No command given" ["No command given"]
  where
    getId :: CGI (Maybe Int)
    getId = readInput "id"

    getIds :: CGI [Int]
    getIds = fmap (map read) (getMultiInput "id")

    getQuery :: CGI String
    getQuery = fmap (fromMaybe "") (getInput "query")
    
    getFile :: CGI (Maybe BS.ByteString)
    getFile = getInputFPS "file"

    getFileName :: CGI String
    getFileName = do
      mb_name <- getInput "name"
      mb_file <- getInputFilename "file"
      return (fromMaybe "" (mb_name `mplus` mb_file))

    getDescription :: CGI String
    getDescription = fmap (fromMaybe "") (getInput "description")

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

doUpdateGrammar c mb_pgf name descr = do
  r <- liftIO $ handleSql (return . Left) $ do
         s <- query c ("call updateGrammar(null,"++toSqlValue name++","++toSqlValue descr++")")
         [id] <- collectRows (\s -> getFieldValue s "id") s
         return (Right id)
  id <- case r of
          Right id -> return (id :: Int)
          Left  e  -> throwCGIError 400 "Saving failed" (lines (show e))
  path <- pathTranslated
  case mb_pgf of
    Just pgf -> liftIO (BS.writeFile (path </> ".." </> "grammars" </> addExtension (show id) "pgf") pgf)
    Nothing  -> return ()
  outputHTML "<H1>Done.</H1>"

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
