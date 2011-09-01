{-# LANGUAGE CPP #-}
module GF.Compile.Compute.Concrete(module M) where
#ifdef CC_LAZY
import GF.Compile.Compute.ConcreteLazy as M -- New, experimental
#else
import GF.Compile.Compute.ConcreteStrict as M -- Old, trusted
#endif