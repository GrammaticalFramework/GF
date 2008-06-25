module GSyntax where

import GF.Infra.Ident
import GF.Grammar.Grammar
import GF.Grammar.PrGrammar
import GF.Grammar.Macros
import GF.Data.Operations
----------------------------------------------------
-- automatic translation from GF to Haskell
----------------------------------------------------

class Gf a where gf :: a -> Trm
class Fg a where fg :: Trm -> a

newtype GString = GString String  deriving Show

instance Gf GString where
  gf (GString s) = K s

instance Fg GString where
  fg t =
    case termForm t of
      Ok ([], K s ,[]) -> GString s
      _ -> error ("no GString " ++ prt t)

newtype GInt = GInt Integer  deriving Show

instance Gf GInt where
  gf (GInt s) = EInt s

instance Fg GInt where
  fg t =
    case termForm t of
      Ok ([], EInt s ,[]) -> GInt s
      _ -> error ("no GInt " ++ prt t)

newtype GFloat = GFloat Double  deriving Show

instance Gf GFloat where
  gf (GFloat s) = EFloat s

instance Fg GFloat where
  fg t =
    case termForm t of
      Ok ([], EFloat s ,[]) -> GFloat s
      _ -> error ("no GFloat " ++ prt t)

----------------------------------------------------
-- below this line machine-generated
----------------------------------------------------

data GAnswer =
   GYes 
 | GNo 
  deriving Show

data GObject = GNumber GInt 
  deriving Show

data GQuestion =
   GPrime GObject 
 | GOdd GObject 
 | GEven GObject 
  deriving Show


instance Gf GAnswer where
 gf GYes = appqc "Math" "Yes" []
 gf GNo = appqc "Math" "No" []

instance Gf GObject where gf (GNumber x1) = appqc "Math" "Number" [gf x1]

instance Gf GQuestion where
 gf (GPrime x1) = appqc "Math" "Prime" [gf x1]
 gf (GOdd x1) = appqc "Math" "Odd" [gf x1]
 gf (GEven x1) = appqc "Math" "Even" [gf x1]


instance Fg GAnswer where
 fg t =
  case termForm t of
    Ok ([], Q (IC "Math") (IC "Yes"),[]) -> GYes 
    Ok ([], Q (IC "Math") (IC "No"),[]) -> GNo 
    _ -> error ("no Answer " ++ prt t)

instance Fg GObject where
 fg t =
  case termForm t of
    Ok ([], Q (IC "Math") (IC "Number"),[x1]) -> GNumber (fg x1)
    _ -> error ("no Object " ++ prt t)

instance Fg GQuestion where
 fg t =
  case termForm t of
    Ok ([], Q (IC "Math") (IC "Prime"),[x1]) -> GPrime (fg x1)
    Ok ([], Q (IC "Math") (IC "Odd"),[x1]) -> GOdd (fg x1)
    Ok ([], Q (IC "Math") (IC "Even"),[x1]) -> GEven (fg x1)
    _ -> error ("no Question " ++ prt t)


