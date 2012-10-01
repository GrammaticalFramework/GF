{-# LANGUAGE FlexibleInstances, 
             MultiParamTypeClasses, 
             ScopedTypeVariables, 
             FlexibleContexts, 
             UndecidableInstances #-}
module MonadSP  ( Rule(..), Grammar, grammar
             , P, parse
             , cat, word, word2, lemma, inside, insideSuff, transform
             , many, many1, opt
             , optEat, consume, wordlookup,write
             ) where
import Data.Tree
import Data.Char
import Data.List
import qualified Data.Map as Map
import Control.Monad
import Control.Monad.State
import Control.Monad.Writer
import PGF hiding (Tree,parse)


infix 1 :->


data Rule    m t e = t :-> P t e m e
type Grammar m t e = t -> PGF -> Morpho -> [Tree t] -> m e

instance Show t => Show (Rule m t e) where
  show (t :-> x) = show t


grammar :: (MonadWriter [String] m,MonadState s m,Ord t,Show t,Show e) 
        => ([e] -> e) -> [Rule m t e] -> Grammar m t e
grammar def rules = gr 
  where
    gr = \tag -> do
      
      let retry = \pgf m ts -> case ts of 
            [Node w []] -> return (def [])
            trs         -> def `liftM` sequence [ gr tag pgf m trs' 
                                                | Node tag trs' <- trs]
 
      case Map.lookup tag pmap of
        Just f -> \pgf m ts -> do 
           stored <- get 
           r <- unP f gr pgf m ts 
           case r of
              Just (e,[]) -> return e
              Just (e,xs) -> tell ["Rest parse"] >> retry pgf m ts -- use xs here?
              Nothing     -> put stored          >> retry pgf m ts
        Nothing -> retry 

    -- If many rules match, try all of them (mplus)
    pmap = Map.fromListWith mplus (map (\(t :-> r) -> (t,r)) rules)

newtype P t e m a = P {unP :: Grammar m t e -> PGF -> Morpho -> [Tree t] -> m (Maybe (a,[Tree t]))} 

instance Monad m => Monad (P t e m) where
  return x = P $ \gr pgf m ts -> return (Just (x,ts))
  f >>= g  = P $ \gr pgf m ts -> unP f gr pgf m ts >>= \r -> case r of
                                  Just (x,ts') -> unP (g x) gr pgf m ts'
                                  Nothing      -> return Nothing

instance MonadState s m => MonadPlus (P t e m) where
  mzero     = P $ \gr pgf m ts -> return Nothing
  mplus f g = P $ \gr pgf m ts -> do 
    store <- get
    res <- unP f gr pgf m ts
    case res of
      Just x  -> return (Just x)
      Nothing -> put store >> unP g gr pgf m ts
      
instance MonadState s m => MonadState s (P t e m) where
  put s = P $ \gr pgf m ts -> put s >> return (Just ((),ts))
  get   = P $ \gr pgf m ts -> get >>= \s -> return (Just (s,ts))
  
instance MonadWriter w m => MonadWriter w (P t e m) where
  tell w = P $ \gr pgf m ts -> tell w >> return (Just ((),ts))
  listen = error "listen not implemented for P"
  pass   = error "pass not implemented for P"
                                     
-- write x = tell [x]
write :: MonadWriter [w] m => w -> P t e m ()
write = tell . return

instance MonadTrans (P t e) where
  lift m = P $ \gr p morpho ts -> m >>= \r -> return (Just (r,ts))

parse :: Monad m => Grammar m t e -> PGF -> Morpho -> Tree t -> m e
parse gr pgf morpho (Node tag ts) = gr tag pgf morpho ts

silent m     = (m,[])
speak  s (m,w) = (m,s:w)
speaks s (m,w) = (m,s++w)
addS   s m = (m,s)
add    s m = (m,[s])


cat :: (Monad m,Eq t,Show t) => [t] -> P [t] e m e
cat tag = P $ \gr pgf morpho ts ->
  case ts of
    Node tag1 ts1 : ts | tag `isPrefixOf` tag1
                                       -> gr tag1 pgf morpho ts1 >>= \r -> return (Just (r,ts))
    _                                  -> return Nothing

word :: (Monad m,Show t,Eq t) => [t] -> P [t] e m [t]
word tag = P $ \gr pgf morpho ts -> return $
  case ts of
    (Node tag1 [Node w []] : ts) | tag `isPrefixOf` tag1 
                                               -> Just (w,ts)
    _                                          -> Nothing


word2 :: (Monad m,Eq t) => t -> P t e m t
word2 tag = P $ \gr pgf morpho ts -> return $
  case ts of
    (Node tag1 [Node tag2 [Node w []]] : ts) | tag == tag1 -> Just (w,ts)
    _                                                      -> Nothing


inside, insideSuff :: (MonadWriter [String] m,Eq t,Show t)=> [t] -> P [t] e m a -> P [t] e m a          
insideSuff = inside' isSuffixOf
inside     = inside' isPrefixOf

inside' :: (MonadWriter [String] m,Eq t,Show t)=>
              ([t] -> [t] -> Bool) -> [t] -> P [t] e m a -> P [t] e m a          
inside' isEq tag f = P $ \gr pgf morpho ts ->
  case ts of
    Node tag1 ts1 : ts | tag `isEq` tag1 -> do
                            tell [show tag++" "++show tag1]
                            unP f gr pgf morpho ts1 >>= \r -> case r of
                                            Just (x,[]) -> return (Just (x,ts))
                                            Just (x,xs) -> tell ["inside fail "++show xs] >> return Nothing
                                            Nothing     -> return Nothing
    _                       -> return Nothing


magicLookup :: String -> String -> String -> Morpho -> PGF -> [Lemma]
magicLookup w cat0 an0 morpho pgf = [ lem 
                                | (lem, an1) <- lookupMorpho morpho (map toLower w)
                                , let cat1 = maybe "" (showType []) (functionType pgf lem)
                                , cat0 == cat1 && an0 == an1
                                ] 

wordlookup :: MonadWriter [String] m => String -> String -> String -> P String e m CId
wordlookup w cat0 an0 = P $ \gr pgf morpho ts -> do
  tell ["wordlookup: " ++ w ++ show ts ++ show cat0]
  let wds = magicLookup w cat0 an0 morpho pgf
  tell [show wds]
  case wds of
    (wd:_) -> return $ Just (wd,ts)
    []     -> return Nothing
  
  
lemma :: MonadWriter [String] m => String -> String -> P String e m CId
lemma cat = liftM head . lemmas cat

lemmas :: MonadWriter [String] m => String -> String -> P String e m [CId]
lemmas cat0 an0 = P $ \gr pgf morpho ts -> do
   tell ["lemma: "++show ts++show cat0]
   case ts of
     Node w [] : ts -> case magicLookup w cat0 an0 morpho pgf of
                          (id:ids) -> tell ["lemma ok"] >> return (Just (id:ids,ts))
                          _        -> tell ["no word "++w++cat0++an0]  >> return Nothing
     _              -> tell ["tried to lemma a tag"]    >> return Nothing


transform :: Monad m => ([Tree t] -> [Tree t]) -> P t e m ()
transform f = P $ \gr pgf morpho ts -> return (Just ((),f ts))

many :: MonadState s m => P t e m a -> P t e m [a]
many f = many1 f
         `mplus`
         return []

many1 :: MonadState s m => P t e m a -> P t e m [a]
many1 f = do x  <- f
             xs <- many f
             return (x:xs)

opt :: MonadState s m => P t e m a -> a -> P t e m a
opt f x = mplus f (return x)  

optEat :: MonadState s m => P t e m a -> a -> P t e m a
optEat f x = mplus f (consume >> return x)  


consume :: Monad m => P t e m ()
consume = P $ \gr pgf morpho ts ->
  case ts of
   Node x w:ws -> return (Just ((),ws))
   []          -> return (Just ((),[])) 

