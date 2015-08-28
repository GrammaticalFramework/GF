module PGF.SortTop
    ( forExample
     ) where

import PGF.CId
import PGF.Data
import qualified Data.Map as Map
import qualified Data.Set as Set
import Data.Maybe


arguments :: Type -> [CId]
arguments (DTyp [] _ _) = []
arguments (DTyp hypos _ _) = [ t |  (_,_, DTyp _ t _) <- hypos]

-- topological order of functions
-- in the order that they should be tested and generated in an example-based system

showInOrder :: Abstr -> Set.Set CId -> Set.Set CId -> Set.Set CId  -> IO [[((CId,CId),[CId])]]
showInOrder abs fset remset avset = 
    let mtypes = typesInterm abs fset
        nextsetWithArgs = Set.map (\(x,y) -> ((x, returnCat abs x), fromJust y)) $ Set.filter (isJust.snd) $ Set.map (\x -> (x, isArg abs mtypes avset x)) remset
        nextset = Set.map (fst.fst) nextsetWithArgs
        nextcat = Set.map (returnCat abs) nextset
        diffset = Set.difference remset nextset
              in 
            if Set.null diffset then do 
                                        return [Set.toList nextsetWithArgs]
               else if Set.null nextset then do 
                                                putStrLn $ "not comparable : "  ++ show diffset
                                                return []
                      else do 
                               
                              rest <- showInOrder abs (Set.union fset nextset) (Set.difference remset nextset) (Set.union avset nextcat)
                              return $ (Set.toList nextsetWithArgs) : rest 

  
isArg :: Abstr -> Map.Map CId CId -> Set.Set CId -> CId -> Maybe [CId]
isArg abs mtypes scid cid = 
   let p = Map.lookup cid $ funs abs
       (ty,_,_,_) = fromJust p 
       args  = arguments ty  
       setargs = Set.fromList args
       cond = Set.null $ Set.difference setargs scid
      in     
        if isNothing p then error $ "not found " ++ show cid ++ "here !!"
             else if cond then return args
                   else Nothing 

typesInterm :: Abstr -> Set.Set CId -> Map.Map CId CId
typesInterm abs fset = 
          let fs = funs abs
              fsetTypes = Set.map (\x -> 
                                    let (DTyp _ c _,_,_,_)=fromJust $ Map.lookup x fs
                                     in (x,c)) fset
              in Map.fromList $ Set.toList fsetTypes             

{-
takeArgs :: Map.Map CId CId -> Map.Map CId Expr -> CId -> Expr
takeArgs mtypes mexpr ty = 
     let xarg = head $ Map.keys $ Map.filter (==ty) mtypes
          in fromJust $ Map.lookup xarg mexpr               

doesReturnCat :: Type -> CId -> Bool
doesReturnCat (DTyp _ c _) cat = c == cat                                  
-}                         
returnCat :: Abstr -> CId -> CId 
returnCat abs cid = 
      let p = Map.lookup cid $ funs abs           
          (DTyp _ c _,_,_,_) = fromJust p  
        in if isNothing p then error $ "not found "++ show cid ++ " in abstract "
                   else c

-- topological order of the categories
forExample :: PGF -> IO [[((CId,CId),[CId])]]
forExample pgf = let abs = abstract pgf 
       in showInOrder abs Set.empty (Set.fromList $ Map.keys $ funs abs) Set.empty 
