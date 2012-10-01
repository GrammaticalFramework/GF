{-# LANGUAGE TypeSynonymInstances, FlexibleInstances #-}
module Format where
import Prelude hiding (words,id)
import Text.XML.HXT.Core 
import Data.Ord
import Data.List hiding (words)
import Data.Maybe
import qualified Data.Map as M
import System.Environment
import Debug.Trace as Debug
import Data.Char
import qualified Data.Tree as T
import Control.Monad.State
 
-- Functions for parsing XML to a format read by the other Haskell files

data Word     = W  {id :: Id, word :: String, pos :: Tag}
data PhrTag   = Ph {idPh :: Id, cat :: Tag, tags :: [(Tag,Id)]}
data Sentence = Sent {rootS :: Id, words :: [Word], info :: [PhrTag], ws :: Int}
type Tag      = String
type Id       = String


instance XmlPickler [Word] where
  xpickle = xpWords

instance XmlPickler Sentence where
  xpickle = xpSentence

xpSentences :: PU [Sentence] 
xpSentences = xpElem "corpus" 
              $ xpWrap (snd, \a -> ((),a))
              $ xpPair (xpElem "head" $ xpUnit) (xpElem "body" $ xpList $ xpSentence)
xpTags :: PU [PhrTag]
xpTags = xpList $ xpElem "nt"
         $ xpWrap (uncurry3 Ph,\p -> (idPh p,cat p,tags p))
         $ xpTriple (xpAttr "id" xpText) (xpAttr "cat" xpText)
                     (xpList $ xpTagMap)

xpTagMap :: PU (Tag,String)
xpTagMap = xpElem "edge"
           $ xpPair (xpAttr "label" xpText)
                    (xpAttr "idref" xpText)

xpSentence :: PU Sentence  
xpSentence = xpElem "s"
             $ xpWrap (makeSentence,\s -> (rootS s,words s, info s))
             $ xpElem "graph"  
             $  xpTriple (xpAttr "root" xpText)
                         ( xpElem "terminals" xpWords)
                         ( xpElem "nonterminals" xpTags)
  where makeSentence (r,ws,tgs) = Sent r ws tgs (length ws)


xpWords :: PU [Word]
xpWords = xpList $ xpElem "t"  
          $ xpWrap (uncurry3 W,\t -> (id t, word t,pos t)) 
          $ xpTriple (xpAttr "id" xpText)
                     (xpAttr "word" xpText)
                     (xpAttr "pos" xpText)
                     
mainF src =   
  runX (xunpickleDocument xpSentences [withInputEncoding utf8
                                     , withRemoveWS yes] src
        >>> arrIO (putStrLn . unlines . map (show . toTree))) 

runPickle f src = 
  runX (xunpickleDocument xpSentences [withInputEncoding utf8
                                     , withRemoveWS yes] src
        >>> arrIO (return . map f)) 

parse = runPickle toStringTree
parseIdTree = runPickle toTree

toStringTree :: Sentence -> (String,T.Tree String)
toStringTree = second (fmap snd) . toTree

toTree :: Sentence -> (String,T.Tree (Id,String))
toTree s@(Sent root ws inf _) = (root,toTree' root s)

toTree' :: String -> Sentence -> T.Tree (Id,String)
toTree' nr s@(Sent root ws inf _) = 
     case (lookup' nr ws,lookup'' nr inf) of
       (Just w,_) -> putWord w
       (_,Just p) -> putPhrase p
       _          -> error $ "Error in toTree' "++show nr++" could not be found"
  where putWord (W i w p)    = T.Node (i,p) [T.Node (i,w) []]
        putPhrase (Ph i c t) = T.Node (i,c) 
                                $ map (\(tag,next) -> T.Node (next,tag)  [toTree' next s]) t

        lookup' y (w@(W x _ _):xs) | y ==x     = Just w
                                   | otherwise = lookup' y xs
        lookup' y [] = Nothing

        lookup'' y (w@(Ph x _ _):xs) | y ==x     = Just w
                                     | otherwise = lookup'' y xs
        lookup'' y [] = Nothing
 

treeToSentence :: [T.Tree String] -> String
treeToSentence ts = unwords $ map extractS ts
  where extractS (T.Node ws []) = ws
        extractS (T.Node c  ts) = unwords $ map extractS ts

showa :: T.Tree String -> String
showa (T.Node root ts) = "("++root++" "++concatMap showa ts++" )"
