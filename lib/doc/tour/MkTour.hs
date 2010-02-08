module Main where

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
  system $ "gf -s Lang.pgf <" ++ gfs
  system $ "txt2tags -thtml " ++ txt


mkTour :: String -> String -> [String] -> FilePath -> FilePath -> IO ()
mkTour lan language src txt gfs = mapM_ mk src where

  mk line = case line of
    '>':command -> do                        -- gf command
      let comm = loc command
      apptxt ('>':comm) 
      appgfs (comm ++ " | " ++ appcomm)
      appgfs "\n"
    '*':_       -> return ()                 -- gf-generated text
    '#':_       -> return ()                 -- Swedish-specific line
    _           -> apptxt (loc line)

  appgfs line = appendFile gfs line >> appendFile gfs "\n"

  loc line = case line of
    'S':'w':'e':'d':'i':'s':'h':cs -> language ++ loc cs
    'S':'w':'e'                :cs -> lan ++ loc cs
    c                          :cs -> c   :  loc cs
    _ -> line

  apptxt line = appgfs $ appcomm ++ " " ++ show (line ++ "\n") ++ "\n"
 
  appcomm = "wf -append -file=" ++ txt


                                        
     
