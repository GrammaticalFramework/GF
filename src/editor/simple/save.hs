import Monad(zipWithM_)
import System(getArgs)

main = save =<< getArgs

save [dir] =
  do fs@[ns,_] <- readIO =<< getContents
     save_all fs
     putStrLn $ unwords [n++".gf"|n<-ns]
  where
    save_all [ns,cs] = zipWithM_ write1 ns cs
    write1 n = writeFile (dir++"/"++n++".gf")
