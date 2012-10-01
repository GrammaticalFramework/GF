module Structure where

data SentenceType = Q | Dir | Top 
  deriving (Show,Eq)

data NPType = Generic | Impers | Normal | Exist
  deriving (Show,Eq)

data VPForm  = Cop | Sup | VV | VA 
             | V | V2 | V2A | V2Pass 
             | Fut | FutKommer
             | VS         
                                            
  deriving (Eq,Show)

data VForm a
  = VInf | VPart | VSupin | VImp | VTense a
   deriving (Show,Eq)

instance Functor VForm where
  fmap f VInf       = VInf
  fmap f VPart      = VPart
  fmap f VSupin     = VSupin
  fmap f VImp       = VImp
  fmap f (VTense t) = VTense (f t)


