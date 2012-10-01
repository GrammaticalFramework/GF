{-# LANGUAGE TemplateHaskell #-}
module State where
import Structure
import PGF
import Data.Label 

data State = State {
             _isExist      :: Bool
           , _iquant       :: Bool
           , _passive      :: Bool
           , _sentenceType :: SentenceType
           , _vform        :: [VPForm]
           , _complement   :: (VPForm,[Maybe Expr],[Bool])
           , _object       :: Maybe Expr  -- for objects not within the VP 'vilka äpplen äter han'
           , _tmp          :: Maybe (VForm CId)
           , _anter        :: Bool
           , _pol          :: Maybe Bool
           , _subj         :: Maybe Expr
           , _nptype       :: NPType
           }

$(mkLabels [''State])

startState :: State
startState = State { 
                _isExist = False
               ,_passive = False
               ,_iquant = False
               ,_vform  = []
               ,_complement = (V,[],[])
               ,_sentenceType = Dir 
               ,_object = Nothing
               ,_tmp = Nothing
               ,_anter = False
               ,_pol = Nothing
               ,_subj = Nothing
               ,_nptype = Normal}



