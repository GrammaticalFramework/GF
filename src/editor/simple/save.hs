import System(getArgs)
import CGI(getQuery,string)
import MUtils(apSnd)

main = save2 =<< getArgs

{-
save1 [dir] =
  do fs@[ns,_] <- readIO =<< getContents
     nes <- save_all fs
     putStrLn $ unwords nes
  where
    save_all [ns,cs] = mapM (write1 dir) (zip ns cs)
-}

write1 dir (n,c) = 
   do writeFile (dir++"/"++ne) c
      return ne
  where
    ne=if '.' `elem` n then n else n++".gf"
 
save2 [dir] =
  do nfs <- getQuery
     nes <- mapM (write1 dir . apSnd string) nfs
     putStrLn $ unwords nes
