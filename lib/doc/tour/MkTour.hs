module Main where

import Char
import System

original = "tour.txt"

main = do
  xx <- getArgs
  let (lan:language:_) = xx
  src <- readFile original >>= return . lines
  let txt = "tour" ++ lan ++ ".txt"
  let gfs = "tour" ++ lan ++ ".gfs"
  writeFile gfs []
  writeFile txt []
  script <- mkTour lan language src txt gfs
  system $ "gf -s Demo.pgf <" ++ gfs
  system $ "txt2tags --toc -thtml " ++ txt


mkTour :: String -> String -> [String] -> FilePath -> FilePath -> IO ()
mkTour lan language src txt gfs = mapM_ mk src where

  mk ll = do
    let (lans,line) = lansline ll
    if (not (null lans) && not (elem lan lans))  -- language-specific, not for lan
      then return ()
      else case line of
        '>':command -> do                        -- gf command
          let comm = loc command
          apptxt ('>':comm) 
          appgfs (comm ++ " | " ++ appcomm)
          appgfs "\n"
        '*':_  -> return ()                 -- gf-generated text
        _      -> apptxt (loc line)

  appgfs line = appendFile gfs line >> appendFile gfs "\n"

  loc line = case line of
    'L':'A':'N':'G':'U':'A':'G':'E':cs -> language ++ loc cs
    'L':'N':'G'                :cs -> lan ++ loc cs
    c                          :cs -> c   :  loc cs
    _ -> line

  apptxt line = appgfs $ appcomm ++ " " ++ show (line ++ "\n") ++ "\n"
 
  appcomm = "wf -append -file=" ++ txt

  lansline ll = case ll of
    '#':cs -> let (la,li) = break isSpace cs in (langs la, drop 1 li)
    _ -> ([],ll)

  langs = words . (map (\c -> if c==',' then ' ' else c))

