module ReadFiles where

import Arch (selectLater, modifiedFiles, ModTime)

import Operations
import UseIO
import System
import Char
import Monad

-- make analysis for GF grammar modules. AR 11/6/2003

-- to find all files that have to be read, put them in dependency order, and
-- decide which files need recompilation. Name file.gf is returned for them,
-- and file.gfc or file.gfr otherwise.

type ModName = String
type FileName = String
type InitPath = String
type FullPath = String

getAllFiles :: [InitPath] -> [(FullPath,ModTime)] -> FileName -> 
               IOE [FullPath]
getAllFiles ps env file = do
  ds  <- getImports ps file
  -- print ds  ---- debug
  ds1 <- ioeErr $ either 
           return 
           (\ms -> Bad $ "circular modules" +++ unwords (map show (head ms))) $ 
              topoTest $ map fst ds
  let paths = [(f,p) | ((f,_),p) <- ds]
  let pds1 = [(p,f) | f <- ds1, Just p <- [lookup f paths]]
  ds2 <- ioeIO $ mapM selectFormat pds1
  -- print ds2 ---- debug
  let ds3 = needCompile ds ds2
  ds4 <- ioeIO $ modifiedFiles env ds3
  return ds4

getImports :: [InitPath] -> FileName -> IOE [((ModName,[ModName]),InitPath)]
getImports ps = get [] where
  get ds file = do
    let name = fileBody file
    (p,s) <- readFileIfPath ps $ file
    let imps  = importsOfFile s
    case imps of
      _ | elem name (map (fst . fst) ds) -> return ds  --- file already read
      [] -> return $ ((name,[]),p):ds
      _  -> do
        let files = map gfFile imps
        foldM get (((name,imps),p):ds) files

-- to decide whether to read gf or gfc; returns full file path

selectFormat :: (InitPath,ModName) -> IO (ModName,(FullPath,Bool))
selectFormat (p,f) = do
  let pf = prefixPathName p f
  f0 <- selectLater (gfFile pf) (gfcFile pf)
  f1 <- selectLater (gfrFile pf) f0
  return $ (f, (f1, f1 == gfFile pf)) -- True if needs compile

needCompile :: [((ModName,[ModName]),InitPath)] -> [(ModName,(FullPath,Bool))] ->
               [FullPath]
needCompile deps sfiles = filt $ mark $ iter changed where

  -- start with the changed files themselves; returns [ModName]
  changed = [f | (f,(_,True)) <- sfiles] 

  -- add other files that depend on some changed file; returns [ModName]
  iter np = let new = [f | ((f,fs),_) <- deps, 
                           not (elem f np), any (flip elem np) fs]
            in  if null new then np else (iter (new ++ np))

  -- for each module in the full list, choose source file if change is needed
  -- returns [FullPath]
  mark cs = [f' | (f,(file,_)) <- sfiles, 
                  let f' = if (elem f cs) then gfFile (fileBody file) else file]

  -- if the top file is gfc, only gfc files need be read (could be even better)---
  filt ds = if isGFC (last ds) 
    then [gfcFile name | f <- ds, 
               let (name,suff) = nameAndSuffix f, elem suff ["gfc","gfr"]] 
    else ds

isGFC = (== "gfc") . fileSuffix

gfcFile = suffixFile "gfc"
gfrFile = suffixFile "gfr"
gfFile  = suffixFile "gf"

-- to get imports without parsing the file

importsOfFile :: String -> [FilePath]
importsOfFile = 
  drop 1 .                   -- ignore module name itself
  filter (not . spec) .      -- ignore keywords and special symbols
  unqual .                   -- take away qualifiers
  takeWhile (not . term) .   -- read until curly or semic
  lexs .                     -- analyse into lexical tokens
  unComm                     -- ignore comments before the headed line
 where
    term = flip elem ["{",";"]
    spec = flip elem ["of", "open","in", ":", "->", "reuse", "=", "(", ")",",","**","with",
                      "abstract","concrete","resource","transfer","interface","incomplete",
                      "instance"]
    unqual ws = case ws of
      "(":q:ws' -> unqual ws'
      w:ws' -> w:unqual ws'
      _ -> ws

unComm s = case s of
      '-':'-':cs -> unComm $ dropWhile (/='\n') cs
      '{':'-':cs -> dpComm cs
      c:cs -> c : unComm cs
      _ -> s
    
dpComm s = case s of
      '-':'}':cs -> unComm cs
      c:cs -> dpComm cs
      _ -> s
    
lexs s = x:xs where 
      (x,y) = head $ lex s
      xs = if null y then [] else lexs y

-- old GF tolerated newlines in quotes. No more supported!
fixNewlines s = case s of
     '"':cs -> '"':mk cs
     c  :cs -> c:fixNewlines cs
     _ -> s
 where
   mk s = case s of
     '\\':'"':cs -> '\\':'"': mk cs
     '"'     :cs -> '"' :fixNewlines cs
     '\n'    :cs -> '\\':'n': mk cs
     c       :cs -> c : mk cs
     _ -> s 

