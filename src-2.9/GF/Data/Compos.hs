{-# OPTIONS_GHC -fglasgow-exts #-}
module GF.Data.Compos (Compos(..),composOp,composM,composM_,composFold) where

import Control.Applicative (Applicative(..), Const(..), WrappedMonad(..))
import Data.Monoid (Monoid(..))

class Compos t where
  compos :: Applicative f => (forall a. t a -> f (t a)) -> t c -> f (t c)

composOp :: Compos t => (forall a. t a -> t a) -> t c -> t c
composOp f = runIdentity . compos (Identity . f)

composFold :: (Monoid o, Compos t) => (forall a. t a -> o) -> t c -> o
composFold f = getConst . compos (Const . f)

composM :: (Compos t, Monad m) => (forall a. t a -> m (t a)) -> t c -> m (t c)
composM f = unwrapMonad . compos (WrapMonad . f)

composM_ :: (Compos t, Monad m) => (forall a. t a -> m ()) -> t c -> m ()
composM_ f = unwrapMonad_ . composFold (WrapMonad_ . f)


newtype Identity a = Identity { runIdentity :: a }

instance Functor Identity where
  fmap f (Identity x) = Identity (f x)

instance Applicative Identity where
  pure                       = Identity
  Identity f <*> Identity x  = Identity (f x)


newtype WrappedMonad_ m = WrapMonad_ { unwrapMonad_ :: m () }

instance Monad m => Monoid (WrappedMonad_ m) where
  mempty  = WrapMonad_ (return ())
  WrapMonad_ x `mappend` WrapMonad_ y = WrapMonad_  (x >> y)
