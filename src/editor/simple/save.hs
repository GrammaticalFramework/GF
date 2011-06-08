import Monad(zipWithM)
import System(getArgs)

main = save =<< getArgs

save [dir] =
  do fs@[ns,_] <- readIO =<< getContents
     nes <- save_all fs
     putStrLn $ unwords nes
  where
    save_all [ns,cs] = zipWithM write1 ns cs
    write1 n c = 
       do writeFile (dir++"/"++ne) c
          return ne
      where
        ne=if '.' `elem` n then n else n++".gf"
 