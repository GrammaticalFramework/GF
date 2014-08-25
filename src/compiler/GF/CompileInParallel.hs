module GF.CompileInParallel where
import Prelude hiding (catch)
import Control.Monad(join,ap,when,unless)
import Control.Applicative
import Control.Concurrent
import System.FilePath
import System.IO.Unsafe(unsafeInterleaveIO)
import qualified GF.System.Directory as D
import GF.System.Catch(catch)
import Data.List(nub,isPrefixOf,intercalate,partition)
import qualified Data.Map as M
import GF.Compile.ReadFiles(getOptionsFromFile,findFile,gfImports,gfoImports)
import GF.CompileOne(reuseGFO,useTheSource)
import GF.Infra.Option
import GF.Infra.UseIO
import GF.Data.Operations
import GF.Grammar.Grammar(emptySourceGrammar,prependModule,modules)
import GF.Infra.Ident(identS)
import GF.Text.Pretty
import qualified Data.ByteString.Lazy as BS

batchCompile jobs opts rootfiles0 =
  do rootfiles <- mapM canonical rootfiles0
     lib_dir  <- canonical =<< getLibraryDirectory opts
     filepaths <- mapM (getPathFromFile lib_dir opts) rootfiles
     let groups = groupFiles lib_dir filepaths
         n = length groups
     when (n>1) $ ePutStrLn "Grammar mixes present and alltenses, dividing modules into two groups"
     (ts,sgrs) <- unzip <$> mapM (batchCompile1 lib_dir) groups
     return (maximum ts,sgrs)
  where
    groupFiles lib_dir filepaths =
        if length groups>1 then groups else [(opts,filepaths)]
      where
        groups = filter (not.null.snd) [(opts_p,present),(opts_a,alltenses)]
        (present,alltenses) = partition usesPresent filepaths
        gfoDir = flag optGFODir opts
        gfo = maybe "" id gfoDir
        opts_p = setGFO "present"
        opts_a = setGFO "alltenses"
        setGFO d = addOptions opts 
                              (modifyFlags $ \ f->f{optGFODir=Just (gfo</>d)})

        usesPresent (_,paths) = take 1 libs==["present"]
          where
            libs = [p|path<-paths,
                      let (d,p0) = splitAt n path
                          p = dropSlash p0,
                      d==lib_dir,p `elem` all_modes]
            n = length lib_dir  

        all_modes = ["alltenses","present"]

        dropSlash ('/':p) = p
        dropSlash p = p

batchCompile1 lib_dir (opts,filepaths) =
  do cwd <- D.getCurrentDirectory
     let rel = relativeTo lib_dir cwd
         prelude_dir = lib_dir</>"prelude"
         gfoDir = flag optGFODir opts
     maybe (return ()) (D.createDirectoryIfMissing True) gfoDir
     prelude_files <- maybe [] id <$> 
                      maybeIO (D.getDirectoryContents prelude_dir)
     let fromPrelude f = lib_dir `isPrefixOf` f &&
                         takeFileName f `elem` prelude_files
         ppPath ps = "-path="<>intercalate ":" (map rel ps)
     logchan <- liftIO newChan
     liftIO $ forkIO (mapM_ runIOE =<< getChanContents logchan)
     let logStrLn = writeChan logchan . ePutStrLn
         ok :: CollectOutput IOE a -> IO a
         ok (CO m) = err bad good =<< appIOE m
           where
              good (o,r) = do writeChan logchan o; return r
              bad e = do writeChan logchan (redPutStrLn e); fail "failed"
              redPutStrLn s = do ePutStr "\ESC[31m";ePutStr s;ePutStrLn "\ESC[m"
     sgr <- liftIO $ newMVar emptySourceGrammar
     let extendSgr sgr m =
           modifyMVar_ sgr $ \ gr ->
           do let gr' = prependModule gr m
--            logStrLn $ "Finished "++show (length (modules gr'))++" modules."
              return gr'
     fcache <- liftIO $ newIOCache $ \ _ (imp,Hide (f,ps)) ->
                 do (file,_,_) <- runIOE $ findFile gfoDir ps imp
                    return (file,(f,ps))
     let find f ps imp =
           do (file',(f',ps')) <- liftIO $ readIOCache fcache (imp,Hide (f,ps))
              when (ps'/=ps) $
                 do (file,_,_) <- findFile gfoDir ps imp
                    unless (file==file' || any fromPrelude [file,file']) $
                      do eq <- liftIO $ (==) <$> BS.readFile file <*> BS.readFile file'
                         unless eq $
                           fail $ render $ 
                             hang ("Ambiguous import of"<+>imp<>":") 4
                              (hang (rel file<+>"from"<+>rel f) 4 (ppPath ps)
                              $$
                              hang (rel file'<+>"from"<+>rel f') 4 (ppPath ps'))
              return file'
         compile cache (file,paths) = readIOCache cache (file,Hide paths)
         compile' cache (f,Hide ps) =
           do let compileImport f = compile cache (f,ps)
                  findImports (f,ps) = mapM (find f ps) . nub . snd
                                         =<< getImports opts f
              tis <- parMapM compileImport =<< ok (findImports (f,ps))
              let reuse gfo = do t <- D.getModificationTime gfo
                                 gr <- readMVar sgr
                                 r <- lazyIO $ ok (reuseGFO opts gr gfo)
                                 return (t,snd r)
                  compileSrc f =
                    do gr <- readMVar sgr
                       (Just gfo,mo) <- ok (useTheSource opts gr f)
                       t <- D.getModificationTime gfo
                       return (t,mo)
              (t,mo) <- if isGFO f
                        then reuse f
                        else do ts <- D.getModificationTime f
                                let gfo = gf2gfo' gfoDir f
                                to <- maybeIO (D.getModificationTime gfo)
                                if to>=Just (maximum (ts:tis))
                                  then reuse gfo
                                  else compileSrc f
              extendSgr sgr mo
              return (maximum (t:tis))
     cache <- liftIO $ newIOCache compile'
     ts <- liftIO $ parMapM (compile cache) filepaths
     gr <- liftIO $ readMVar sgr
     let cnc = identS (justModuleName (fst (last filepaths)))
     return (maximum ts,(cnc,gr))

parMapM f xs = 
  do vs <- mapM (const newEmptyMVar) xs
     sequence_ [ forkIO (putMVar v =<< f x) | (v,x) <- zip vs xs]
     mapM takeMVar vs

lazyIO = unsafeInterleaveIO

canonical path = liftIO $ D.canonicalizePath path `catch` const (return path)

getPathFromFile lib_dir cmdline_opts file =
  do --file <- getRealFile file
     file_opts <- getOptionsFromFile file
     let file_dir = dropFileName file
         opts = addOptions (fixRelativeLibPaths file_dir lib_dir file_opts)
                           cmdline_opts
     paths <- mapM canonical . nub . (file_dir :) =<< extendPathEnv opts
     return (file,nub paths)

getImports opts file =
    if isGFO file then gfoImports' file else gfImports opts file
  where
    gfoImports' file = maybe bad return =<< gfoImports file
      where bad = raise $ file++": bad .gfo file"

relativeTo lib_dir cwd path =
    if length librel<length cwdrel then librel else cwdrel
  where
    librel = "%"</>makeRelative lib_dir path
    cwdrel = makeRelative cwd path

--------------------------------------------------------------------------------

data IOCache arg res
    = IOCache { op::arg->IO res,
                cache::MVar (M.Map arg (MVar res)) }

newIOCache op =
   do v <- newMVar M.empty
      let cache = IOCache (op cache) v
      return cache

readIOCache (IOCache op cacheVar) arg =
  join $ modifyMVar cacheVar $ \ cache ->
    case M.lookup arg cache of
       Nothing -> do v <- newEmptyMVar
                     let doit = do res <- op arg
                                   putMVar v res
                                   return res
                     return (M.insert arg v cache,doit)
       Just v  -> do return (cache,readMVar v)


newtype Hide a = Hide {reveal::a}
instance Eq (Hide a) where _ == _ = True
instance Ord (Hide a) where compare _ _ = EQ

--------------------------------------------------------------------------------

newtype CollectOutput m a = CO {unCO::m (m (),a)}
{-
runCO (CO m) = do (o,x) <- m
                  o
                  return x
-}
instance Functor m => Functor (CollectOutput m) where
   fmap f (CO m) = CO (fmap (fmap f) m)

instance (Functor m,Monad m) => Applicative (CollectOutput m) where 
  pure = return
  (<*>) = ap

instance Monad m => Monad (CollectOutput m) where
  return x = CO (return (return (),x))
  CO m >>= f = CO $ do (o1,x) <- m
                       let CO m2 = f x
                       (o2,y) <- m2
                       return (o1>>o2,y)
instance MonadIO m => MonadIO (CollectOutput m) where
  liftIO io = CO $ do x <- liftIO io
                      return (return (),x)

instance Output m => Output (CollectOutput m) where
  ePutStr   s = CO (return (ePutStr s,()))
  ePutStrLn s = CO (return (ePutStrLn s,()))
  putStrLnE s = CO (return (putStrLnE s,()))
  putStrE   s = CO (return (putStrE s,()))

instance ErrorMonad m => ErrorMonad (CollectOutput m) where
  raise e = CO (raise e)
  handle (CO m) h = CO $ handle m (unCO . h)
